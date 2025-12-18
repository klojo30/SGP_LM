# LM_Schema_Prenotazioni
Progetto 24/25: Persistenza di un servizio di prenotazione viaggi
# Requisito
  Andare a descrivere e sviluppare uno schema di persistenza dei dati a supporto di un sistema di prenotazione di un'azienda del settore dei trasporti.
  In questo caso di studio, si è preso come riferimento un'azienda di trasporti ferroviari. E' stato sviluppato un DB a supporto del processo di Prenotazione nuovi biglietti, Cambio Biglietto e Validazione Biglietto.
# DBMS 
  è stato scelto, ed usato, PostgreSQL
# CONTENUTI
presenti nel branch sql
  - DUMP_completo_181225.sql ---> contenente schema e tutte le insert per popolare le tabelle con dati di test
    
Eventualmente, il dump è stato diviso in:
  - DUMP_solo_schema_181225.sql --> contenente solo DDL delle tabelle create, FKs, Constraints
  - DUMP_solo_dati_181225.sql ---> contenente solo le insert per popolare le tabelle con i dati di test

Inoltre, sono presenti i seguenti file:
  - Query_esempio.sql --> contenente 5 query di esempio
  - Viste_esempio.sql --> contenente 3 viste di esempio
  - Tableu_esempi_grafici.twb --> file Tableau contenente i grafici draft popolati dalle viste

# COMMENTI
  Per poter usufruire di tutte le funzionalità di ricerca geografica e definizione di colonne di tipo geography, si rende necessario installare l'estensione PostGIS: https://postgis.net/
