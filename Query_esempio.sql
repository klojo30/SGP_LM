------ #1 Ricerca per km dalla posizione cliente (sfruttando estensione POSTGIS) ---------------
---Nel nostro caso consideriamo una posizione nei pressi di Napoli C.le (14.256793161461957 40.855037225506514). In Prod verranno passati come parametri dall'applicativo

SELECT 
    s.id_stazione,
    s.nome_stazione,
    s.citta,
    s.provincia,   
-- distanza in km (divisione per 1000) da punto di partenza (es. posizione attuale del cliente)
    ROUND(ST_Distance(
        s.geo_stazione,
        ST_GeomFromText('POINT(14.256793161461957 40.855037225506514)', 4326)::geography 
    ) / 1000.0)::numeric AS distanza_km,
-- numero di corse disponibili per la stazione vicina 
    (SELECT COUNT(DISTINCT id_orario) 
     FROM public."ORARI" o
     JOIN public."TRATTE" t ON o.id_tratta = t.id_tratta
     WHERE t.stazione_partenza_id = s.id_stazione
     AND o.stato = 'ATTIVO') AS numero_corse,
-- potrebbe tornare utile restituire le coordinate all'applicativo tramite le funzioni ST_Y e ST_X
    ST_Y(s.geo_stazione::geometry) AS Coordinata_Y,
    ST_X(s.geo_stazione::geometry) AS Coordinata_X

FROM public."STAZIONI" s

WHERE 
-- uso ST_DWithin per calcolare la distanza max  (10km in questo caso, espresso come parametro alla funzione ST_GeomFromText = 10000m)
    ST_DWithin(s.geo_stazione,ST_GeomFromText('POINT(12.4964 41.9028)', 4326)::geography, -- coordinate passate come point che corrisponde alla posizione del cliente 
        10000  -- = 10 km
		)
    AND s.geo_stazione IS NOT NULL

ORDER BY distanza_km ASC


--------------- #2 QUERY STORICO PRENOTAZIONI CLIENTE ---------------

SELECT -- estraggo tutte le info della prenotazione 
    p.id_passeggero,
	p.id_prenotazione,
    p.codice_prenotazione,
    p.data_prenotazione,
    p.numero_posti,
    p.importo_totale,
    p.stato_prenotazione,
    p.canale,
-- grazie alle join e fk mi estraggo anche i dettagli di Orario e Tratta
    o.codice_orario,
    t.stazione_partenza_id,
    t.stazione_arrivo_id,
    s_part.nome_stazione AS da_stazione,
    s_arr.nome_stazione AS a_stazione,
    o.timestamp_partenza,
    o.timestamp_arrivo,
-- conteggio biglietti inerenti alla prenotazione trovata 
    COUNT(b.id_biglietto) AS numero_biglietti_emessi,
-- tramite MAX mi prendo gli ultimi dati di pagamento tracciati 
    MAX(pg.stato_pagamento) AS stato_pagamento_ultimo,
    MAX(pg.data_pagamento) AS data_pagamento,
    MAX(pg.importo) AS importo_pagato,
-- e conto le eventuali validazioni effettuate sui biglietti 
    COUNT(DISTINCT v.id_validazione) AS numero_validazioni
    
FROM public."PRENOTAZIONI" p ---- Join con tutte le tabelle del sistema che includono informazioni utili alla prenotazione, come descritto nel diagramma ER 
    JOIN public."PASSEGGERI" ps ON p.id_passeggero = ps.id_passeggero
    JOIN public."ORARI" o ON p.id_orario = o.id_orario
    JOIN public."TRATTE" t ON o.id_tratta = t.id_tratta
    JOIN public."STAZIONI" s_part ON t.stazione_partenza_id = s_part.id_stazione
    JOIN public."STAZIONI" s_arr ON t.stazione_arrivo_id = s_arr.id_stazione
    LEFT JOIN public."BIGLIETTI" b ON p.id_prenotazione = b.id_prenotazione
    LEFT JOIN public."PAGAMENTI" pg ON p.id_prenotazione = pg.id_prenotazione
    LEFT JOIN public."VALIDAZIONI" v ON b.id_biglietto = v.id_biglietto

WHERE 
    ps.id_passeggero = 1 -- Sto considerando il cliente con id_passeggero = 1 ma sarà un parametro passato dall'applicativo
AND 
	p.data_prenotazione >= CURRENT_DATE - INTERVAL '1 year'  -- qui considero come range temporale l'ultimo anno, ma anche in questo caso si può pensare di approcciare con un prametro che mi definisca il range (mensile, giornaliero), oppure far calcolare dall'applicativo il valore date da usare, evitando il calcolo con CURRENT_DATE

GROUP BY --> raggruppo i valori uguali per avere singole righe
    p.id_prenotazione, p.codice_prenotazione, p.data_prenotazione, p.numero_posti,
    p.importo_totale, p.stato_prenotazione, p.canale, o.id_orario, o.codice_orario,
    t.stazione_partenza_id, t.stazione_arrivo_id, s_part.nome_stazione, s_arr.nome_stazione,
    o.timestamp_partenza, o.timestamp_arrivo

ORDER BY p.data_prenotazione DESC;


--------------- #3 Ricerca biglietti ---------

SELECT --- tiro fuori tutte le info utili alla scelta di un biglietto (orario, stazioni, posti) tramite join su FK
    o.id_orario,
    o.codice_orario,
    t.id_tratta,
    s_part.nome_stazione AS stazione_partenza,
    s_arr.nome_stazione AS stazione_arrivo,
    o.timestamp_partenza,
    o.timestamp_arrivo,
    v.totale_posti,
    v.posti_prima_classe,
    v.posti_seconda_classe,
-- ricavo i posti disponibili 
	(v.totale_posti - COALESCE(COUNT(b.id_biglietto), 0)) AS posti_disponibili,
-- con la join delle tabelle PREZZI, mi ricavo i prezzi definiti per le varie tipologie 
    MIN(CASE WHEN pr.classe = 'STANDARD' THEN pr.prezzo_base ELSE NULL END) AS prezzo_standard,
    MIN(CASE WHEN pr.classe = 'PREMIUM' THEN pr.prezzo_base ELSE NULL END) AS prezzo_premium,
    MIN(CASE WHEN pr.classe = 'BUSINESS' THEN pr.prezzo_base ELSE NULL END) AS prezzo_business

FROM public."ORARI" o
    JOIN public."TRATTE" t ON o.id_tratta = t.id_tratta
    JOIN public."STAZIONI" s_part ON t.stazione_partenza_id = s_part.id_stazione
    JOIN public."STAZIONI" s_arr ON t.stazione_arrivo_id = s_arr.id_stazione
    JOIN public."VEICOLI" v ON o.id_veicolo = v.id_veicolo
--- Utilizzo Left join in quanto sono info aggiuntive e mi serve quindi mantenere le righe della tabella sinistra 
    LEFT JOIN public."BIGLIETTI" b ON o.id_orario = b.id_orario 
        AND b.stato = 'ATTIVO' 
        AND DATE(b.timestamp_validita_inizio) = DATE(o.timestamp_partenza)
    LEFT JOIN public."PREZZI" pr ON o.id_orario = pr.id_orario 
        AND pr.stato = 'ATTIVO'
        AND CURRENT_DATE BETWEEN pr.validita_da AND COALESCE(pr.validita_a, '9999-12-31')

WHERE 
     s_part.nome_stazione = 'Roma Termini' --> andrà parametrizzato e passato dall'applicativo 
 AND s_arr.nome_stazione = 'Milano Centrale' --> andrà parametrizzato e passato dall'applicativo 
 AND DATE(o.timestamp_partenza) >= '2025-11-11' --> andrà parametrizzato e passato dall'applicativo 
-- Considero solo le righe attive
 AND o.stato = 'ATTIVO'
 AND t.stato_tratta = 'ATTIVA'
 AND v.stato_veicolo = 'ATTIVO'
    
GROUP BY o.id_orario, o.codice_orario, t.id_tratta, s_part.nome_stazione, s_arr.nome_stazione,
         o.timestamp_partenza, o.timestamp_arrivo, v.id_veicolo, v.totale_posti,
         v.posti_prima_classe, v.posti_seconda_classe, o.stato
-- Uso HAVING quando faccio logiche su colonne raggruppate 
HAVING (v.totale_posti - COALESCE(COUNT(b.id_biglietto), 0)) > 0

ORDER BY o.timestamp_partenza ASC;


----------- #4 Validazione Biglietto --------------------
SELECT --- ricavo le info biglietto
    b.id_biglietto,
    b.codice_biglietto,
    b.stato, 
	tar.tipo_tariffa,
    b.prezzo,
    b.timestamp_validita_inizio,
    b.timestamp_validita_fine,
-- dati passeggero
    ps.nome,
    ps.cognome,
    ps.codice_fiscale,
-- dati della prenotazione
    pr.codice_prenotazione,
    pr.data_prenotazione,
-- dati di viaggio
    t.stazione_partenza_id,
    t.stazione_arrivo_id,
    s_part.nome_stazione AS Stazione_Partenza,
    s_arr.nome_stazione AS Stazione_Arrivo,
    o.timestamp_partenza,
    o.timestamp_arrivo,
    v.codice_veicolo,
-- eventuali ulteriori validazioni
    COUNT(val.id_validazione) AS numero_validazioni_precedenti,
    MAX(val.timestamp_validazione) AS ultima_validazione

FROM public."BIGLIETTI" b
    JOIN public."PRENOTAZIONI" pr ON b.id_prenotazione = pr.id_prenotazione
    JOIN public."PASSEGGERI" ps ON pr.id_passeggero = ps.id_passeggero
    JOIN public."ORARI" o ON b.id_orario = o.id_orario
    JOIN public."TRATTE" t ON o.id_tratta = t.id_tratta
    JOIN public."STAZIONI" s_part ON t.stazione_partenza_id = s_part.id_stazione
    JOIN public."STAZIONI" s_arr ON t.stazione_arrivo_id = s_arr.id_stazione
    JOIN public."VEICOLI" v ON o.id_veicolo = v.id_veicolo
    JOIN public."TARIFFE" tar ON b.id_tariffa = tar.id_tariffa
    LEFT JOIN public."VALIDAZIONI" val ON b.id_biglietto = val.id_biglietto

WHERE b.codice_biglietto = 'BG110' -- Ho inserito un biglietto di test con validazione ma questo sarà popolato da un parametro passato dall'applicativo 

GROUP BY 
    b.id_biglietto, b.codice_biglietto, b.stato, ps.nome, ps.cognome, ps.codice_fiscale,
    pr.codice_prenotazione, pr.data_prenotazione, t.stazione_partenza_id, t.stazione_arrivo_id,
    s_part.nome_stazione, s_arr.nome_stazione, o.timestamp_partenza, o.timestamp_arrivo,
    v.codice_veicolo, tar.tipo_tariffa, b.prezzo, b.timestamp_validita_inizio, b.timestamp_validita_fine;



---------------- #5 Controllo Tariffe disponibili per tratta ----------------
SELECT ---- ricavo le info sulla tratta 
    pr.id_prezzo,
    t.id_tratta,
	s_part.nome_stazione AS Stazione_Partenza,
	s_arr.nome_stazione AS Stazione_Arrivo,
    tar.tipo_tariffa,
    tar.sconto_percentuale,
    pr.classe,
    pr.prezzo_base,
    pr.prezzo_weekend,
    pr.prezzo_festivo,
    pr.validita_da,
    pr.validita_a,
    pr.stato,
-- sfrutto Case when per calcolare il prezzo applicabile, tramite conversione in CHAR della data 
    CASE 
        WHEN TO_CHAR(CURRENT_DATE, 'D') IN ('6', '7') AND pr.prezzo_weekend IS NOT NULL 
        THEN pr.prezzo_weekend
        WHEN pr.prezzo_festivo IS NOT NULL  
        THEN pr.prezzo_festivo
        ELSE pr.prezzo_base
    END AS prezzo_applicabile,
-- prezzo con sconto sconto applicabile calcolato, arrotondo per la 2 cifra decimale 
    ROUND(pr.prezzo_base * (100 - tar.sconto_percentuale) / 100, 2) AS prezzo_con_sconto

FROM public."PREZZI" pr
    JOIN public."TRATTE" t ON pr.id_tratta = t.id_tratta
    JOIN public."STAZIONI" s_part ON t.stazione_partenza_id = s_part.id_stazione
    JOIN public."STAZIONI" s_arr ON t.stazione_arrivo_id = s_arr.id_stazione
    JOIN public."ORARI" o ON pr.id_orario = o.id_orario
    JOIN public."TARIFFE" tar ON pr.id_tariffa = tar.id_tariffa

WHERE 
    t.stazione_partenza_id = 9 AND t.stazione_arrivo_id = 15  -- ho preso le stazioni Verona - Padova come esempio 
    AND pr.stato = 'ATTIVO'
    AND tar.attivo = TRUE
    AND DATE(pr.validita_da) <= CURRENT_DATE 
    AND (pr.validita_a IS NULL OR DATE(pr.validita_a) >= CURRENT_DATE)

ORDER BY pr.prezzo_base ASC;


