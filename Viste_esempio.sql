------ #1 Vendite Totali -------------

CREATE VIEW v_dashboard_incassi_giornalieri AS
SELECT --- ricavo informazioni inerenti al pagamento come data e num transazioni, ricavando anche il num tot di prenotazioni e clienti esistenti
    DATE(p.data_pagamento) AS data,
    COUNT(DISTINCT p.id_pagamento) AS numero_transazioni,
    COUNT(DISTINCT pr.id_prenotazione) AS numero_prenotazioni,
    COUNT(DISTINCT ps.id_passeggero) AS numero_clienti_unici,
    
    -- ricavo i valori economici totali, utili per grafici di bsn
    SUM(p.importo) AS ricavi_lordi,
    SUM(p.commissioni) AS commissioni_totali,
    (SUM(p.importo) - SUM(p.commissioni)) AS ricavi_netti,
    ROUND(AVG(p.importo), 2) AS ticket_medio,
    
    -- identifico la percentuali di casi di successo (possibile KPI di bsn)
    ROUND((SUM(CASE WHEN p.stato_pagamento = 'COMPLETATO' THEN 1 ELSE 0 END)::numeric / 
           COUNT(p.id_pagamento) * 100), 2) AS percentuale_successo,
    -- indico l'ultimo pagamento considerato
    MAX(p.data_pagamento) AS ultimo_aggiornamento
    
FROM public."PAGAMENTI" p
    JOIN public."PRENOTAZIONI" pr ON p.id_prenotazione = pr.id_prenotazione
    JOIN public."PASSEGGERI" ps ON pr.id_passeggero = ps.id_passeggero

WHERE p.stato_pagamento = 'COMPLETATO'
	AND p.data_pagamento >= CURRENT_DATE - INTERVAL '30 days' --- considero gli ultimi 30gg per non appesantire troppo la query 
GROUP BY DATE(p.data_pagamento)

ORDER BY data DESC;



------- #2 Occupazione tratte ----------------
CREATE VIEW v_occupazione_tratte AS
SELECT -- info tratta, concateno anche le stazioni partenza e arrivo, può tornare utile come label di qualche grafico 
    t.id_tratta,
    CONCAT(s1.nome_stazione, ' - ', s2.nome_stazione) AS tratta,
    s1.citta AS citta_partenza,
    s2.citta AS citta_arrivo,
-- Ricavo i numeri totali di corse, giorni partenza, posti totali 
    COUNT(DISTINCT o.id_orario) AS numero_corse,
    COUNT(DISTINCT DATE(o.timestamp_partenza)) AS numero_giorni,
    SUM(v.totale_posti) AS capacita_totale,
-- biglietti venduti
    COUNT(DISTINCT b.id_biglietto) AS biglietti_venduti,
-- occupazione media percentuale
    ROUND((COUNT(DISTINCT b.id_biglietto)::numeric / 
           (COUNT(DISTINCT o.id_orario) * AVG(v.totale_posti)) * 100), 2) AS percentuale_occupazione_media,
-- ricavi totali e prezzo medio tramite AVG 
    SUM(b.prezzo) AS ricavi_totali,
    ROUND(AVG(b.prezzo), 2) AS prezzo_medio

FROM public."TRATTE" t
    JOIN public."STAZIONI" s1 ON t.stazione_partenza_id = s1.id_stazione
    JOIN public."STAZIONI" s2 ON t.stazione_arrivo_id = s2.id_stazione
    LEFT JOIN public."ORARI" o ON t.id_tratta = o.id_tratta 
        AND o.timestamp_partenza > CURRENT_TIMESTAMP - INTERVAL '90 days' ---> sto considerando gli ultimi 90 gg ma sarà un valore parametrico. In alteernativa, l'applicativo passerà come parametro il valore datetime da usare nella condizione
    LEFT JOIN public."VEICOLI" v ON o.id_veicolo = v.id_veicolo
    LEFT JOIN public."BIGLIETTI" b ON o.id_orario = b.id_orario

WHERE t.stato_tratta = 'ATTIVA'

GROUP BY t.id_tratta, s1.nome_stazione, s2.nome_stazione, s1.citta, s2.citta
--mi assicuro di evitare valori null 
HAVING 
    COUNT(DISTINCT o.id_orario) > 0      
    AND COUNT(DISTINCT b.id_biglietto) > 0  
    AND SUM(v.totale_posti) IS NOT NULL 

ORDER BY percentuale_occupazione_media DESC;


---------------- #3 Performance del controllore ----------
CREATE VIEW v_performance_controllori AS
SELECT --- raccolgo una serie di info utili inerenti all'operatore, concatenando nome cognome magari per label dei grafici 
    op.id_operatore,
    op.matricola_operatore,
    CONCAT(op.nome, ' ', op.cognome) AS operatore,
    op.ruolo,
    op.stato_attivo,
-- ricavo numeri di validazioni, e quanti giorni sono stati effettivamente dedicati alle validazioni con percentuale 
    COUNT(DISTINCT v.id_validazione) AS numero_validazioni,
    COUNT(DISTINCT DATE(v.timestamp_validazione)) AS giorni_attivi,
    ROUND((COUNT(DISTINCT v.id_validazione)::numeric / 
           NULLIF(COUNT(DISTINCT DATE(v.timestamp_validazione)), 0)), 2) AS media_validazioni_giorno,
-- numero di validazioni con esiti 
    SUM(CASE WHEN v.esito = 'VALIDATO' THEN 1 ELSE 0 END) AS validazioni_valide,
    SUM(CASE WHEN v.esito = 'NON VALIDO' THEN 1 ELSE 0 END) AS validazioni_non_valide,
-- numero di tratte e corse soggette a controllo 
    COUNT(DISTINCT o.id_tratta) AS numero_tratte_controllate,
    COUNT(DISTINCT v.id_orario) AS numero_corse_controllate,
-- timeline delle validazioni dalla prima all'ultima, stampando anche il timestamp della richiesta query
    MIN(DATE(v.timestamp_validazione)) AS primo_turno,
    MAX(DATE(v.timestamp_validazione)) AS ultimo_turno,
    CURRENT_TIMESTAMP AS data_aggiornamento

FROM public."OPERATORI" op
    LEFT JOIN public."VALIDAZIONI" v ON op.id_operatore = v.id_operatore
    LEFT JOIN public."ORARI" o ON v.id_orario = o.id_orario

GROUP BY op.id_operatore, op.matricola_operatore, op.nome, op.cognome, op.ruolo, op.stato_attivo

ORDER BY numero_validazioni DESC;

