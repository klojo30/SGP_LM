--
-- PostgreSQL database dump
--

\restrict DtiodNELevj6Ejkd1i7tSbjkeOMcfZot7EZQZ2DikuZpEjWoRntG2L6qBXChA3j

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-17 20:49:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5132 (class 0 OID 16425)
-- Dependencies: 220
-- Data for Name: STAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (1, 'ROMA_T', 'Roma Termini', 'Roma', 'RM', 41.90100000, 12.50100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (2, 'MILANO_C', 'Milano Centrale', 'Milano', 'MI', 45.48500000, 9.20400000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (3, 'NAPOLI_C', 'Napoli Centrale', 'Napoli', 'NA', 40.85200000, 14.27100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (4, 'TORINO_PN', 'Torino Porta Nuova', 'Torino', 'TO', 45.06200000, 7.67700000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (5, 'FIRENZE_SMN', 'Firenze Santa Maria Novella', 'Firenze', 'FI', 43.77900000, 11.24600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (6, 'VENEZIA_SM', 'Venezia Santa Lucia', 'Venezia', 'VE', 45.44100000, 12.32100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (7, 'BOLOGNA_C', 'Bologna Centrale', 'Bologna', 'BO', 44.50500000, 11.34300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (8, 'GENOVA_PP', 'Genova Piazza Principe', 'Genova', 'GE', 44.42000000, 8.91500000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (9, 'VERONA_PN', 'Verona Porta Nuova', 'Verona', 'VR', 45.42900000, 10.97800000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (10, 'PALERMO_C', 'Palermo Centrale', 'Palermo', 'PA', 38.11500000, 13.36700000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (11, 'BARI_C', 'Bari Centrale', 'Bari', 'BA', 41.12200000, 16.86600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (12, 'SALERNO_C', 'Salerno', 'Salerno', 'SA', 40.68000000, 14.77300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (13, 'FIRENZE_CM', 'Firenze Campo di Marte', 'Firenze', 'FI', 43.78100000, 11.28300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (14, 'CATANIA_C', 'Catania Centrale', 'Catania', 'CT', 37.49900000, 15.08200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (15, 'PADOVA_C', 'Padova', 'Padova', 'PD', 45.41800000, 11.88200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (16, 'TRIESTE_C', 'Trieste Centrale', 'Trieste', 'TS', 45.65500000, 13.77100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (17, 'FIRENZE_RF', 'Firenze Rifredi', 'Firenze', 'FI', 43.80700000, 11.23700000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (18, 'REGGIO_C', 'Reggio Calabria Centrale', 'Reggio Calabria', 'RC', 38.11400000, 15.64600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (19, 'PISA_C', 'Pisa Centrale', 'Pisa', 'PI', 43.70300000, 10.40300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (20, 'RIMINI_C', 'Rimini', 'Rimini', 'RN', 44.06100000, 12.57000000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (21, 'BRESCIA_C', 'Brescia', 'Brescia', 'BS', 45.54100000, 10.21400000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (22, 'ANCONA_C', 'Ancona', 'Ancona', 'AN', 43.59900000, 13.49200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (23, 'SIRACUSA_C', 'Siracusa', 'Siracusa', 'SR', 37.06800000, 15.29300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (24, 'LUCCA_C', 'Lucca', 'Lucca', 'LU', 43.84300000, 10.50600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (25, 'AREZZO_C', 'Arezzo', 'Arezzo', 'AR', 43.46500000, 11.87700000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (26, 'LECCE_C', 'Lecce', 'Lecce', 'LE', 40.35300000, 18.17300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (27, 'CASERTA_C', 'Caserta', 'Caserta', 'CE', 41.07200000, 14.33100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (28, 'PIACENZA_C', 'Piacenza', 'Piacenza', 'PC', 45.05000000, 9.69300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (29, 'PESCARA_C', 'Pescara Centrale', 'Pescara', 'PE', 42.46700000, 14.20500000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (30, 'MESSINA_C', 'Messina Centrale', 'Messina', 'ME', 38.19300000, 15.55200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (31, 'MODENA_C', 'Modena', 'Modena', 'MO', 44.64800000, 10.93600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (32, 'MESTRE_C', 'Venezia Mestre', 'Venezia', 'VE', 45.49300000, 12.24100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (33, 'TRENTO_C', 'Trento', 'Trento', 'TN', 46.06200000, 11.12000000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (34, 'BOLZANO_C', 'Bolzano', 'Bolzano', 'BZ', 46.49500000, 11.35400000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (35, 'FORLI_C', 'Forlì', 'Forlì', 'FC', 44.22200000, 12.04000000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (36, 'ASTI_C', 'Asti', 'Asti', 'AT', 44.90000000, 8.20000000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (37, 'ALESSANDRIA_C', 'Alessandria', 'Alessandria', 'AL', 44.91300000, 8.61800000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (38, 'PARMA_C', 'Parma', 'Parma', 'PR', 44.80600000, 10.32400000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (39, 'CUNEO_C', 'Cuneo', 'Cuneo', 'CN', 44.38500000, 7.54600000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (40, 'PERUGIA_C', 'Perugia', 'Perugia', 'PG', 43.10200000, 12.38900000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (41, 'NOVARA_C', 'Novara', 'Novara', 'NO', 45.45800000, 8.62100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (42, 'VARESE_C', 'Varese', 'Varese', 'VA', 45.82000000, 8.83300000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (43, 'CREMONA_C', 'Cremona', 'Cremona', 'CR', 45.13200000, 10.03200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (44, 'FERRARA_C', 'Ferrara', 'Ferrara', 'FE', 44.84200000, 11.60700000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (45, 'SAVONA_C', 'Savona', 'Savona', 'SV', 44.30900000, 8.48100000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (46, 'LA_SPEZIA_C', 'La Spezia Centrale', 'La Spezia', 'SP', 44.10800000, 9.80800000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (47, 'RAVENNA_C', 'Ravenna', 'Ravenna', 'RA', 44.42000000, 12.19800000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (48, 'IMOLA_C', 'Imola', 'Imola', 'BO', 44.35800000, 11.70900000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (49, 'LUINO_C', 'Luino', 'Luino', 'VA', 46.00200000, 8.73200000, '2025-11-07 18:56:03.619248+01');
INSERT INTO public."STAZIONI" (id_stazione, codice_stazione, nome_stazione, citta, provincia, latitudine, longitudine, data_creazione) VALUES (50, 'DOMODOSSOLA', 'Domodossola', 'Domodossola', 'VB', 46.11300000, 8.29400000, '2025-11-07 18:56:03.619248+01');


--
-- TOC entry 5140 (class 0 OID 16526)
-- Dependencies: 228
-- Data for Name: TARIFFE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (1, 'FR_BASE', 'Frecciarossa Base', 'Tariffa base Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (2, 'FR_ECO', 'Frecciarossa Economy', 'Tariffa economy Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (3, 'FR_SUP', 'Frecciarossa Super Economy', 'Tariffa super economy Frecciarossa', false, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (4, 'FA_BASE', 'Frecciargento Base', 'Tariffa base Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (5, 'FA_ECO', 'Frecciargento Economy', 'Tariffa economy Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (6, 'IC_BASE', 'Intercity Base', 'Tariffa base Intercity', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (7, 'IC_ECO', 'Intercity Economy', 'Tariffa economy Intercity', true, true, '2025-11-08 19:36:02.100249+01', 7.50);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (8, 'IC_SUP', 'Intercity Super Economy', 'Tariffa super economy Intercity', false, true, '2025-11-08 19:36:02.100249+01', 12.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (9, 'REG_BASE', 'Regionale Ordinaria', 'Tariffa ordinaria Regionale', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (10, 'REG_WEEK', 'Regionale Weekend', 'Tariffa week-end Regionale', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (11, 'REG_RID', 'Regionale Ridotto', 'Tariffa ridotta Regionale', true, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (12, 'REG_FAM', 'Regionale Famiglia', 'Tariffa famiglia Regionale', true, true, '2025-11-08 19:36:02.100249+01', 18.99);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (13, 'FR_YOUTH', 'Frecciarossa Young', 'Tariffa giovani Frecciarossa', false, true, '2025-11-08 19:36:02.100249+01', 12.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (14, 'FR_SENIOR', 'Frecciarossa Senior', 'Tariffa over 65 Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (15, 'FA_SUP', 'Frecciargento Super Economy', 'Tariffa super economy Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 9.99);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (16, 'IC_YOUTH', 'Intercity Young', 'Tariffa giovani Intercity', false, true, '2025-11-08 19:36:02.100249+01', 14.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (17, 'IC_SENIOR', 'Intercity Senior', 'Tariffa senior Intercity', true, true, '2025-11-08 19:36:02.100249+01', 16.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (18, 'REG_GRUPPO', 'Regionale Gruppo', 'Tariffa gruppi Regionale', false, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (19, 'FR_FAM', 'Frecciarossa Famiglia', 'Tariffa di gruppo/famiglia Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (20, 'FA_FAM', 'Frecciargento Famiglia', 'Tariffa di famiglia Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 13.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (21, 'IC_PRIV', 'Intercity Privilege', 'Tariffa Privilege Intercity', false, true, '2025-11-08 19:36:02.100249+01', 22.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (22, 'FR_PROMO', 'Frecciarossa Promo', 'Tariffa promozionale Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 25.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (23, 'FA_PROMO', 'Frecciargento Promo', 'Tariffa promozionale Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (24, 'REG_PROMO', 'Regionale Promo', 'Tariffa promo Regionale', true, true, '2025-11-08 19:36:02.100249+01', 19.50);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (25, 'IC_PROMO', 'Intercity Promo', 'Tariffa promo Intercity', false, true, '2025-11-08 19:36:02.100249+01', 24.50);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (26, 'FR_NOTTE', 'Frecciarossa Notturna', 'Tariffa notturna Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (27, 'FA_NOTTE', 'Frecciargento Notturna', 'Tariffa notturna Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 11.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (28, 'IC_NOTTE', 'Intercity Notturna', 'Tariffa notturna Intercity', true, true, '2025-11-08 19:36:02.100249+01', 16.80);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (29, 'REG_NOTTE', 'Regionale Notturna', 'Tariffa notturna Regionale', true, true, '2025-11-08 19:36:02.100249+01', 8.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (30, 'FR_LAST', 'Frecciarossa Last Minute', 'Tariffa last minute Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (31, 'FA_LAST', 'Frecciargento Last Minute', 'Tariffa last minute Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (32, 'IC_LAST', 'Intercity Last Minute', 'Tariffa last minute Intercity', true, true, '2025-11-08 19:36:02.100249+01', 17.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (33, 'REG_LAST', 'Regionale Last Minute', 'Tariffa last minute Regionale', false, true, '2025-11-08 19:36:02.100249+01', 12.30);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (34, 'FR_BUS', 'Frecciarossa Business', 'Tariffa business Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 28.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (35, 'FA_BUS', 'Frecciargento Business', 'Tariffa business Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 22.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (36, 'IC_BUS', 'Intercity Business', 'Tariffa business Intercity', false, true, '2025-11-08 19:36:02.100249+01', 29.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (37, 'REG_BUS', 'Regionale Business', 'Tariffa business Regionale', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (38, 'FR_PREM', 'Frecciarossa Premium', 'Tariffa premium Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 30.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (39, 'FA_PREM', 'Frecciargento Premium', 'Tariffa premium Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 23.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (40, 'IC_PREM', 'Intercity Premium', 'Tariffa premium Intercity', false, true, '2025-11-08 19:36:02.100249+01', 25.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (41, 'REG_PREM', 'Regionale Premium', 'Tariffa premium Regionale', true, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (42, 'FR_STU', 'Frecciarossa Studente', 'Tariffa studenti Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (43, 'FA_STU', 'Frecciargento Studente', 'Tariffa studenti Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (44, 'IC_STU', 'Intercity Studente', 'Tariffa studenti Intercity', false, true, '2025-11-08 19:36:02.100249+01', 14.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (45, 'REG_STU', 'Regionale Studente', 'Tariffa studenti Regionale', true, true, '2025-11-08 19:36:02.100249+01', 13.70);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (46, 'FR_ANN', 'Frecciarossa Annuale', 'Tariffa annuale Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 35.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (47, 'FA_ANN', 'Frecciargento Annuale', 'Tariffa annuale Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 26.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (48, 'IC_ANN', 'Intercity Annuale', 'Tariffa annuale Intercity', true, true, '2025-11-08 19:36:02.100249+01', 30.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (49, 'REG_ANN', 'Regionale Annuale', 'Tariffa annuale Regionale', true, true, '2025-11-08 19:36:02.100249+01', 17.00);
INSERT INTO public."TARIFFE" (id_tariffa, codice_tariffa, tipo_tariffa, descrizione, cambio_consentito, attivo, data_creazione, sconto_percentuale) VALUES (50, 'FR_GRAT', 'Frecciarossa Gratuita', 'Tariffa gratuita Frecciarossa', true, false, '2025-11-08 19:36:02.100249+01', 100.01);


--
-- TOC entry 5142 (class 0 OID 16546)
-- Dependencies: 230
-- Data for Name: TRATTE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (1, 1, 2, 570.00, '03:10:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (2, 2, 4, 145.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (3, 1, 5, 300.00, '01:40:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (4, 5, 6, 260.00, '02:05:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (5, 2, 7, 215.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (6, 7, 9, 144.00, '00:50:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (7, 9, 15, 82.00, '00:54:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (8, 5, 13, 2.00, '00:05:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (9, 1, 3, 220.00, '01:15:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (10, 7, 11, 670.00, '05:45:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (11, 3, 12, 55.00, '00:37:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (12, 6, 32, 9.00, '00:12:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (13, 19, 24, 18.00, '00:20:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (14, 38, 31, 90.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (15, 14, 30, 104.00, '02:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (16, 33, 34, 60.00, '00:50:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (17, 28, 38, 108.00, '01:30:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (18, 16, 6, 158.00, '02:15:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (19, 8, 45, 45.00, '00:42:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" (id_tratta, stazione_partenza_id, stazione_arrivo_id, km_distanza, durata, data_creazione, stato_tratta, validita_da, validita_a) VALUES (20, 12, 27, 52.00, '00:47:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);


--
-- TOC entry 5151 (class 0 OID 16685)
-- Dependencies: 239
-- Data for Name: VEICOLI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (1, 'FR9500', 'Frecciarossa 1000', 600, 100, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (2, 'IT9902', 'Italo EVO', 450, 65, 385, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (3, 'IC783', 'Intercity MD', 350, 40, 310, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (4, 'REG225', 'Jazz Stadler', 260, 24, 220, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (5, 'FA8400', 'Frecciargento ETR600', 520, 80, 440, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (6, 'REG220', 'Pop Alstom', 350, 30, 310, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (7, 'FR9600', 'Frecciarossa 500', 542, 80, 450, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (8, 'REG300', 'Swing Pesa', 180, 18, 150, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (9, 'IC9140', 'Intercity MD', 320, 36, 270, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (10, 'FA8300', 'Frecciargento ETR485', 480, 69, 400, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (11, 'FR9100', 'Frecciarossa 1000', 610, 110, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (12, 'REG9824', 'Minuetto', 151, 0, 140, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (13, 'REG330', 'Pop Alstom', 350, 35, 300, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (14, 'REG210', 'Minuetto', 150, 12, 120, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (15, 'FR9750', 'Frecciarossa 500', 540, 90, 445, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (16, 'REG150', 'Swing Pesa', 185, 8, 160, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (17, 'FA9604', 'Frecciargento ETR600', 523, 80, 435, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (18, 'IC9111', 'Intercity MD', 325, 35, 270, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (19, 'REG155', 'Jazz Stadler', 250, 20, 220, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" (id_veicolo, codice_veicolo, modello, totale_posti, posti_prima_classe, posti_seconda_classe, stato_veicolo, timestamp_creazione) VALUES (20, 'FR9002', 'Frecciarossa 1000', 620, 120, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');


--
-- TOC entry 5145 (class 0 OID 16596)
-- Dependencies: 233
-- Data for Name: ORARI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (1, 'OR202511081', '2025-11-09 07:30:00+01', '2025-11-09 10:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-09', '2025-12-31', 'ATTIVO', 'Frecciarossa 9500 Milano-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (2, 'OR202511082', '2025-11-09 09:00:00+01', '2025-11-09 11:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 2, 2, '2025-11-09', NULL, 'ATTIVO', 'Italo 9902 Napoli-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (3, 'OR202511083', '2025-11-09 08:45:00+01', '2025-11-09 12:45:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 3, '2025-11-09', NULL, 'ATTIVO', 'Intercity 783 Venezia-Bologna');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (4, 'OR202511084', '2025-11-09 18:00:00+01', '2025-11-09 20:45:00+01', '2025-11-08 19:42:24.044553+01', 1, 4, 4, '2025-11-09', '2025-11-30', 'ATTIVO', 'Regionale 225 Firenze-Pisa');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (5, 'OR202511085', '2025-11-10 05:30:00+01', '2025-11-10 08:05:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 5, '2025-11-10', NULL, 'ATTIVO', 'Frecciargento 8400 Torino-Venezia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (6, 'OR202511086', '2025-11-10 13:00:00+01', '2025-11-10 15:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 6, 2, '2025-11-10', '2025-12-01', 'ATTIVO', 'Regionale 220 Roma-Ancona');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (7, 'OR202511087', '2025-11-11 07:00:00+01', '2025-11-11 09:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-11', NULL, 'ATTIVO', 'Frecciarossa 9600 Milano-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (8, 'OR202511088', '2025-11-11 11:10:00+01', '2025-11-11 13:35:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 4, '2025-11-11', NULL, 'ATTIVO', 'Regionale 300 Ravenna-Bologna');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (9, 'OR202511089', '2025-11-11 17:40:00+01', '2025-11-11 21:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 3, '2025-11-11', NULL, 'ATTIVO', 'Intercity 9140 Palermo-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (10, 'OR2025110810', '2025-11-12 06:05:00+01', '2025-11-12 09:25:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 2, '2025-11-12', '2025-12-31', 'ATTIVO', 'Frecciargento 8300 Venezia-Perugia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (11, 'OR2025110811', '2025-11-12 14:00:00+01', '2025-11-12 17:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 9, 4, '2025-11-12', NULL, 'ATTIVO', 'Frecciarossa 9100 Bologna-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (12, 'OR2025110812', '2025-11-13 08:00:00+01', '2025-11-13 10:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 2, 5, '2025-11-13', NULL, 'ATTIVO', 'Italo 9824 Milano-Firenze');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (13, 'OR2025110813', '2025-11-13 12:10:00+01', '2025-11-13 14:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 10, 3, '2025-11-13', '2025-11-30', 'ATTIVO', 'Regionale 330 Genoa-La Spezia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (14, 'OR2025110814', '2025-11-14 16:00:00+01', '2025-11-14 19:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 6, 2, '2025-11-14', NULL, 'ATTIVO', 'Regionale 210 Bari-Foggia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (15, 'OR2025110815', '2025-11-14 17:25:00+01', '2025-11-14 19:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 1, '2025-11-14', NULL, 'ATTIVO', 'Frecciargento 8500 Torino-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (16, 'OR2025110816', '2025-11-15 09:10:00+01', '2025-11-15 11:50:00+01', '2025-11-08 19:42:24.044553+01', 1, 8, 5, '2025-11-15', NULL, 'ATTIVO', 'Frecciarossa 9750 Verona-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (17, 'OR2025110817', '2025-11-15 15:30:00+01', '2025-11-15 16:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 1, '2025-11-15', NULL, 'ATTIVO', 'Regionale 150 Napoli-Salerno');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (18, 'OR2025110818', '2025-11-16 06:30:00+01', '2025-11-16 09:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 2, '2025-11-16', NULL, 'ATTIVO', 'Frecciarossa 9604 Milano-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (19, 'OR2025110819', '2025-11-16 11:50:00+01', '2025-11-16 14:15:00+01', '2025-11-08 19:42:24.044553+01', 2, 9, 4, '2025-11-16', NULL, 'ATTIVO', 'Frecciarossa 9111 Bologna-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (20, 'OR2025110820', '2025-11-17 07:20:00+01', '2025-11-17 08:54:00+01', '2025-11-08 19:42:24.044553+01', 3, 4, 3, '2025-11-17', NULL, 'ATTIVO', 'Regionale 155 Pisa-Siena');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (21, 'OR2025110821', '2025-11-17 14:15:00+01', '2025-11-17 16:47:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 5, '2025-11-17', '2025-11-30', 'ATTIVO', 'Intercity 7904 Roma-Milano');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (22, 'OR2025110822', '2025-11-18 06:50:00+01', '2025-11-18 08:51:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 1, '2025-11-18', NULL, 'ATTIVO', 'Italo 9920 Napoli-Firenze');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (23, 'OR2025110823', '2025-11-18 10:20:00+01', '2025-11-18 13:00:00+01', '2025-11-08 19:42:24.044553+01', 2, 3, 4, '2025-11-18', NULL, 'ATTIVO', 'Intercity 874 Milano-Venezia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (24, 'OR2025110824', '2025-11-19 09:35:00+01', '2025-11-19 11:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 10, 2, '2025-11-19', NULL, 'ATTIVO', 'Regionale 340 La Spezia-Pisa');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (25, 'OR2025110825', '2025-11-19 11:50:00+01', '2025-11-19 14:35:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 3, '2025-11-19', NULL, 'ATTIVO', 'Frecciargento 8120 Perugia-Bari');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (26, 'OR2025110826', '2025-11-19 15:05:00+01', '2025-11-19 18:05:00+01', '2025-11-08 19:42:24.044553+01', 1, 6, 4, '2025-11-19', NULL, 'ATTIVO', 'Frecciarossa 9800 Ancona-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (27, 'OR2025110827', '2025-11-20 07:45:00+01', '2025-11-20 09:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 7, 5, '2025-11-20', NULL, 'ATTIVO', 'Regionale 130 Caserta-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (28, 'OR2025110828', '2025-11-20 13:30:00+01', '2025-11-20 14:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 4, 4, '2025-11-20', NULL, 'ATTIVO', 'Regionale 160 Pisa-Livorno');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (29, 'OR2025110829', '2025-11-21 06:40:00+01', '2025-11-21 09:15:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 2, '2025-11-21', '2025-12-15', 'ATTIVO', 'Frecciarossa 9506 Milano-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (30, 'OR2025110830', '2025-11-21 17:30:00+01', '2025-11-21 20:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 1, '2025-11-21', NULL, 'ATTIVO', 'Frecciargento 8502 Torino-Firenze');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (31, 'OR2025110831', '2025-11-22 08:15:00+01', '2025-11-22 09:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 2, 3, '2025-11-22', NULL, 'ATTIVO', 'Italo 9930 Napoli-Milano');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (32, 'OR2025110832', '2025-11-22 11:00:00+01', '2025-11-22 13:35:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 4, '2025-11-22', NULL, 'ATTIVO', 'Regionale 345 Perugia-Assisi');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (33, 'OR2025110833', '2025-11-23 07:30:00+01', '2025-11-23 09:20:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 2, '2025-11-23', NULL, 'ATTIVO', 'Frecciargento 8200 La Spezia-Milano');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (34, 'OR2025110834', '2025-11-23 16:40:00+01', '2025-11-23 18:45:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 1, '2025-11-23', NULL, 'ATTIVO', 'Intercity 850 Venezia-Trieste');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (35, 'OR2025110835', '2025-11-24 08:20:00+01', '2025-11-24 09:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 3, '2025-11-24', NULL, 'ATTIVO', 'Regionale 175 Torino-Asti');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (36, 'OR2025110836', '2025-11-24 11:25:00+01', '2025-11-24 14:15:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 5, '2025-11-24', NULL, 'ATTIVO', 'Frecciarossa 9200 Milano-Firenze');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (37, 'OR2025110837', '2025-11-25 15:00:00+01', '2025-11-25 17:00:00+01', '2025-11-08 19:42:24.044553+01', 3, 4, 2, '2025-11-25', NULL, 'ATTIVO', 'Regionale 200 Pisa-Firenze');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (38, 'OR2025110838', '2025-11-25 19:30:00+01', '2025-11-25 21:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 4, '2025-11-25', NULL, 'ATTIVO', 'Regionale 355 Assisi-Perugia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (39, 'OR2025110839', '2025-11-26 09:30:00+01', '2025-11-26 12:10:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-26', NULL, 'ATTIVO', 'Frecciarossa 9400 Milano-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (40, 'OR2025110840', '2025-11-26 13:45:00+01', '2025-11-26 16:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 2, '2025-11-26', NULL, 'ATTIVO', 'Intercity 9200 Napoli-Palermo');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (41, 'OR2025110841', '2025-11-27 05:30:00+01', '2025-11-27 08:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 4, '2025-11-27', NULL, 'ATTIVO', 'Frecciargento 8340 Torino-Bari');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (42, 'OR2025110842', '2025-11-27 08:00:00+01', '2025-11-27 10:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 3, '2025-11-27', NULL, 'ATTIVO', 'Regionale 202 Milano-La Spezia');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (43, 'OR2025110843', '2025-11-28 09:35:00+01', '2025-11-28 10:55:00+01', '2025-11-08 19:42:24.044553+01', 2, 6, 5, '2025-11-28', NULL, 'ATTIVO', 'Regionale 218 Ancona-Fermo');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (44, 'OR2025110844', '2025-11-28 14:50:00+01', '2025-11-28 18:10:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 1, '2025-11-28', NULL, 'ATTIVO', 'Intercity 9310 Palermo-Roma');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (45, 'OR2025110845', '2025-11-29 17:20:00+01', '2025-11-29 20:35:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 2, '2025-11-29', NULL, 'ATTIVO', 'Regionale 228 Torino-Aosta');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (46, 'OR2025110846', '2025-11-29 19:50:00+01', '2025-11-29 23:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 4, '2025-11-29', NULL, 'ATTIVO', 'Frecciarossa 9000 Milano-Napoli');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (47, 'OR2025110847', '2025-11-30 09:00:00+01', '2025-11-30 11:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 4, 5, '2025-11-30', '2025-12-30', 'ATTIVO', 'Regionale 169 Pisa-Livorno');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (48, 'OR2025110848', '2025-11-30 13:30:00+01', '2025-11-30 15:50:00+01', '2025-11-08 19:42:24.044553+01', 3, 10, 3, '2025-11-30', NULL, 'ATTIVO', 'Regionale 310 La Spezia-Genova');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (49, 'OR2025110849', '2025-12-01 06:45:00+01', '2025-12-01 09:20:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 2, '2025-12-01', NULL, 'ATTIVO', 'Frecciargento 8122 Milano-Bari');
INSERT INTO public."ORARI" (id_orario, codice_orario, timestamp_partenza, timestamp_arrivo, data_creazione, id_tariffa, id_tratta, id_veicolo, validita_da, validita_a, stato, note) VALUES (50, 'OR2025110850', '2025-12-01 19:00:00+01', '2025-12-01 22:00:00+01', '2025-11-08 19:42:24.044553+01', 2, 1, 4, '2025-12-01', '2026-01-31', 'ATTIVO', 'Frecciarossa 9002 Roma-Milano');


--
-- TOC entry 5134 (class 0 OID 16441)
-- Dependencies: 222
-- Data for Name: PASSEGGERI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (1, 'RSSMRA80A01H501U', 'Mario', 'Rossi', '1980-01-01', 'mario.rossi@email.com', '3331234567', 'Via Roma 12', 'Roma', 'RM', '00100', 'CARD12345', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (2, 'BNCLCU85B10D325C', 'Luca', 'Bianchi', '1985-02-10', 'luca.bianchi@email.com', '3499876543', 'Piazza Garibaldi 5', 'Milano', 'MI', '20100', 'CARD34567', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (3, 'FRGMRA90C15Z404U', 'Giulia', 'Ferrari', '1990-03-15', 'giulia.ferrari@email.com', '3205467890', 'C.so Vittorio 23', 'Torino', 'TO', '10121', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (4, 'VRDLRA95D20H501F', 'Laura', 'Verdi', '1995-04-20', 'laura.verdi@email.com', '3662345678', 'Via Verdi 100', 'Firenze', 'FI', '50121', 'CARD67890', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (5, 'BGNSNV91E25C351I', 'Simone', 'Bergamaschi', '1991-05-25', 'simone.bergamaschi@email.com', '3771230987', 'Via Dante 33', 'Bergamo', 'BG', '24100', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (6, 'DLCGPT88F30H224R', 'Giuseppe', 'Delconte', '1988-06-30', 'giuseppe.delconte@email.com', '3897651230', 'Via Ospedale 17', 'Palermo', 'PA', '90133', 'CARD90123', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (7, 'NGRMNL99G15B157S', 'Manuela', 'Negri', '1999-07-15', 'manuela.negri@email.com', '3912345670', 'Via Napoli 200', 'Napoli', 'NA', '80100', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (8, 'PRSVFR77H10H501W', 'Francesco', 'Parisi', '1977-08-10', 'francesco.parisi@email.com', '3106547892', 'Via Garibaldi 22', 'Roma', 'RM', '00185', 'CARD56789', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (9, 'CMLGLA93I05F205Z', 'Angela', 'Camilli', '1993-09-05', 'angela.camilli@email.com', '3689081720', 'Via Manzoni 55', 'Bologna', 'BO', '40121', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" (id_passeggero, codice_fiscale, nome, cognome, data_nascita, email, telefono, indirizzo, citta, provincia, cap, codice_carta_fedelta, data_registrazione) VALUES (10, 'BLTTMT65J01Z404F', 'Tommaso', 'Bellotti', '1965-10-01', 'tommaso.bellotti@email.com', '3925678130', 'Via Venezia 99', 'Venezia', 'VE', '30100', 'CARD24680', '2025-11-07 19:36:09.74706+01');


--
-- TOC entry 5136 (class 0 OID 16463)
-- Dependencies: 224
-- Data for Name: PRENOTAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (2, 'PR002', '2025-11-08 19:58:15.654472+01', 2, 99.90, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (3, 'PR003', '2025-11-08 19:58:15.654472+01', 1, 38.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (5, 'PR005', '2025-11-08 19:58:15.654472+01', 3, 132.00, 'CONFERMATA', 'TELEFONO', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (6, 'PR006', '2025-11-08 19:58:15.654472+01', 1, 26.50, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (8, 'PR008', '2025-11-08 19:58:15.654472+01', 1, 60.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (9, 'PR009', '2025-11-08 19:58:15.654472+01', 1, 24.99, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (10, 'PR010', '2025-11-08 19:58:15.654472+01', 1, 52.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (1, 'PR001', '2025-11-08 19:58:15.654472+01', 1, 45.00, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (4, 'PR004', '2025-11-08 19:58:15.654472+01', 1, 50.00, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (7, 'PR007', '2025-11-08 19:58:15.654472+01', 2, 97.98, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (11, 'PR101', '2025-11-16 18:00:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (12, 'PR102', '2025-11-16 18:10:00+01', 2, 78.00, 'CONFERMATA', 'APP', 2, 2);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (13, 'PR103', '2025-11-16 18:20:00+01', 1, 52.00, 'CONFERMATA', 'WEB', 3, 3);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (14, 'PR104', '2025-11-16 18:30:00+01', 1, 87.00, 'CONFERMATA', 'APP', 4, 4);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (15, 'PR105', '2025-11-16 18:40:00+01', 1, 32.50, 'CONFERMATA', 'AGENZIA', 5, 5);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (16, 'PR106', '2025-11-16 18:50:00+01', 1, 44.00, 'CONFERMATA', 'WEB', 6, 6);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (17, 'PR107', '2025-11-16 19:00:00+01', 1, 56.00, 'CONFERMATA', 'APP', 7, 7);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (18, 'PR108', '2025-11-16 19:10:00+01', 1, 28.00, 'CONFERMATA', 'AGENZIA', 8, 8);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (19, 'PR109', '2025-11-16 19:20:00+01', 1, 67.00, 'CONFERMATA', 'WEB', 9, 9);
INSERT INTO public."PRENOTAZIONI" (id_prenotazione, codice_prenotazione, data_prenotazione, numero_posti, importo_totale, stato_prenotazione, canale, id_orario, id_passeggero) VALUES (20, 'PR110', '2025-11-16 19:30:00+01', 1, 22.50, 'CONFERMATA', 'APP', 10, 10);


--
-- TOC entry 5138 (class 0 OID 16492)
-- Dependencies: 226
-- Data for Name: BIGLIETTI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (1, 'BG101', 11, 1, '2025-11-16 18:01:00+01', '2025-11-17 08:00:00+01', '2025-11-17 22:00:00+01', 'ATTIVO', '2025-11-17 08:05:00+01', 42.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (2, 'BG102', 12, 2, '2025-11-16 18:11:00+01', '2025-11-18 09:00:00+01', '2025-11-18 23:00:00+01', 'ATTIVO', '2025-11-18 09:10:00+01', 39.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (3, 'BG103', 12, 2, '2025-11-16 18:12:00+01', '2025-11-18 09:00:00+01', '2025-11-18 23:00:00+01', 'ATTIVO', '2025-11-18 09:10:00+01', 39.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (4, 'BG104', 13, 3, '2025-11-16 18:21:00+01', '2025-11-19 14:00:00+01', '2025-11-19 22:00:00+01', 'ATTIVO', '2025-11-19 14:05:00+01', 52.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (5, 'BG105', 14, 4, '2025-11-16 18:31:00+01', '2025-11-20 18:30:00+01', '2025-11-21 23:00:00+01', 'ATTIVO', NULL, 87.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (6, 'BG106', 15, 5, '2025-11-16 18:41:00+01', '2025-11-22 05:30:00+01', '2025-11-22 23:00:00+01', 'ATTIVO', NULL, 32.50);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (7, 'BG107', 16, 6, '2025-11-16 18:51:00+01', '2025-11-23 13:00:00+01', '2025-11-23 23:00:00+01', 'ATTIVO', NULL, 44.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (8, 'BG108', 17, 7, '2025-11-16 19:01:00+01', '2025-11-24 07:00:00+01', '2025-11-24 23:00:00+01', 'ATTIVO', NULL, 56.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (9, 'BG109', 18, 8, '2025-11-16 19:11:00+01', '2025-11-25 11:00:00+01', '2025-11-25 23:00:00+01', 'ATTIVO', NULL, 28.00);
INSERT INTO public."BIGLIETTI" (id_biglietto, codice_biglietto, id_prenotazione, id_tariffa, timestamp_creazione, timestamp_validita_inizio, timestamp_validita_fine, stato, timestamp_validazione, prezzo) VALUES (10, 'BG110', 19, 9, '2025-11-16 19:21:00+01', '2025-11-26 17:40:00+01', '2025-11-26 23:00:00+01', 'ATTIVO', NULL, 67.00);


--
-- TOC entry 5153 (class 0 OID 16703)
-- Dependencies: 241
-- Data for Name: OPERATORI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (1, 'OPE001', 'CONTROLLORE', 'Giuseppe', 'Sanna', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (2, 'OPE002', 'CAPOTRENO', 'Elena', 'Mannucci', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (3, 'OPE003', 'CONTROLLORE', 'Marco', 'Vitale', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (4, 'OPE004', 'CONTROLLORE', 'Chiara', 'Brunetti', false, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (5, 'OPE005', 'CAPOTRENO', 'Alessandro', 'Ferri', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" (id_operatore, matricola_operatore, ruolo, nome, cognome, stato_attivo, data_creazione) VALUES (6, 'OPE006', 'CONTROLLORE', 'Serena', 'Redaelli', true, '2025-11-08 20:08:02.730912+01');


--
-- TOC entry 5149 (class 0 OID 16659)
-- Dependencies: 237
-- Data for Name: PAGAMENTI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (1, 11, 'TX101', 42.00, 1.00, 'Carta di credito', '2025-11-16 18:05:00+01', 'COMPLETATO', 'Pagamento online');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (2, 12, 'TX102', 78.00, 2.50, 'PayPal', '2025-11-16 18:12:00+01', 'COMPLETATO', 'Pagamento confermato via PayPal');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (3, 13, 'TX103', 52.00, 0.80, 'Carta di credito', '2025-11-16 18:22:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (4, 14, 'TX104', 87.00, 1.90, 'Bonifico', '2025-11-16 18:32:00+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (5, 15, 'TX105', 32.50, 0.60, 'Carta di credito', '2025-11-16 18:42:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (6, 16, 'TX106', 44.00, 1.10, 'Bancomat', '2025-11-16 18:52:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (7, 17, 'TX107', 56.00, 1.50, 'Contanti', '2025-11-16 19:02:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (8, 18, 'TX108', 28.00, 0.30, 'Carta di credito', '2025-11-16 19:12:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (9, 19, 'TX109', 67.00, 2.00, 'PayPal', '2025-11-16 19:22:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" (id_pagamento, id_prenotazione, codice_transazione, importo, commissioni, metodo_pagamento, data_pagamento, stato_pagamento, note_pagamento) VALUES (10, 20, 'TX110', 22.50, 0.15, 'PayPal', '2025-11-16 19:32:00+01', 'COMPLETATO', '');


--
-- TOC entry 5147 (class 0 OID 16630)
-- Dependencies: 235
-- Data for Name: PREZZI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (1, 1, 1, 'STANDARD', '2025-11-16 12:00:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 42.00, 45.00, 47.00, 1);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (2, 2, 2, 'STANDARD', '2025-11-16 12:01:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 39.00, 41.00, 44.00, 2);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (3, 3, 3, 'PREMIUM', '2025-11-16 12:02:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 52.00, 54.00, 56.00, 3);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (4, 4, 4, 'BUSINESS', '2025-11-16 12:03:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-15', 87.00, 89.00, 91.00, 4);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (5, 5, 5, 'STANDARD', '2025-11-16 12:04:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 32.50, 35.50, 38.00, 5);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (6, 6, 6, 'PREMIUM', '2025-11-16 12:05:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 44.00, 46.00, 49.00, 6);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (7, 7, 7, 'BUSINESS', '2025-11-16 12:06:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 56.00, 58.00, 61.00, 7);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (8, 8, 8, 'STANDARD', '2025-11-16 12:07:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 28.00, 31.00, 32.00, 8);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (9, 9, 9, 'PREMIUM', '2025-11-16 12:08:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-31', 67.00, 69.00, 71.00, 9);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (10, 10, 10, 'BUSINESS', '2025-11-16 12:09:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 22.50, 24.00, 26.50, 10);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (11, 11, 1, 'STANDARD', '2025-11-16 12:10:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 59.00, 62.00, 65.00, 11);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (12, 12, 2, 'PREMIUM', '2025-11-16 12:11:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 46.00, 48.00, 51.00, 12);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (13, 13, 3, 'BUSINESS', '2025-11-16 12:12:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-01', 71.00, 73.00, 76.00, 13);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (14, 14, 4, 'STANDARD', '2025-11-16 12:13:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 34.30, 36.40, 38.45, 14);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (15, 15, 5, 'PREMIUM', '2025-11-16 12:14:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 41.50, 44.30, 47.00, 15);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (16, 16, 6, 'BUSINESS', '2025-11-16 12:15:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 49.00, 51.30, 52.80, 16);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (17, 17, 7, 'STANDARD', '2025-11-16 12:16:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-11-30', 56.80, 57.40, 59.20, 17);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (18, 18, 8, 'PREMIUM', '2025-11-16 12:17:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 28.00, 29.10, 30.20, 18);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (19, 19, 9, 'BUSINESS', '2025-11-16 12:18:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 37.30, 39.90, 41.10, 19);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (20, 20, 10, 'STANDARD', '2025-11-16 12:19:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 62.00, 63.60, 67.10, 20);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (21, 21, 1, 'PREMIUM', '2025-11-16 12:20:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 72.30, 75.00, 76.90, 21);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (22, 22, 2, 'BUSINESS', '2025-11-16 12:21:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 21.90, 22.50, 23.20, 22);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (23, 23, 3, 'STANDARD', '2025-11-16 12:22:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 24.00, 25.90, 28.10, 23);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (24, 24, 4, 'PREMIUM', '2025-11-16 12:23:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 36.20, 37.55, 39.99, 24);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (25, 25, 5, 'BUSINESS', '2025-11-16 12:24:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 79.40, 80.50, 82.00, 25);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (26, 26, 6, 'STANDARD', '2025-11-16 12:25:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 63.00, 65.00, 67.50, 26);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (27, 27, 7, 'PREMIUM', '2025-11-16 12:26:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 72.10, 74.00, 77.50, 27);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (28, 28, 8, 'BUSINESS', '2025-11-16 12:27:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 21.40, 22.00, 22.90, 28);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (29, 29, 9, 'STANDARD', '2025-11-16 12:28:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 29.00, 31.00, 32.50, 29);
INSERT INTO public."PREZZI" (id_prezzo, id_tariffa, id_tratta, classe, timestamp_creazione, timestamp_modifica, stato, validita_da, validita_a, prezzo_base, prezzo_weekend, prezzo_festivo, id_orario) VALUES (30, 30, 10, 'PREMIUM', '2025-11-16 12:29:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 59.00, 61.00, 63.50, 30);


--
-- TOC entry 5143 (class 0 OID 16573)
-- Dependencies: 231
-- Data for Name: TRATTE_INTERMEDIE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (1, 1, '2025-11-08 19:44:02.391054+01', 5, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (1, 7, '2025-11-08 19:44:02.391054+01', 4, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (1, 2, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (2, 2, '2025-11-08 19:44:02.391054+01', 3, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (2, 21, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (2, 4, '2025-11-08 19:44:02.391054+01', 4, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (3, 1, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (3, 25, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (3, 5, '2025-11-08 19:44:02.391054+01', 3, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (4, 5, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (4, 15, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (4, 6, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (5, 2, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (5, 31, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (5, 7, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (6, 7, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (6, 19, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (6, 9, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (7, 9, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (7, 15, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (8, 5, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (8, 13, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (9, 1, '2025-11-08 19:44:02.391054+01', 3, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (9, 27, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (9, 3, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (10, 7, '2025-11-08 19:44:02.391054+01', 4, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (10, 22, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (10, 11, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (11, 3, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (11, 12, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (12, 6, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (12, 32, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (13, 19, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (13, 24, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (14, 38, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (14, 31, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (15, 14, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (15, 30, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (16, 33, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (16, 34, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (17, 28, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (17, 38, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (18, 16, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (18, 6, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (19, 8, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (19, 45, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (20, 12, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" (id_tratta, id_stazione, data_creazione, tempo_sosta_minuti, ordine_fermata) VALUES (20, 27, '2025-11-08 19:44:02.391054+01', 2, 2);


--
-- TOC entry 5155 (class 0 OID 16719)
-- Dependencies: 243
-- Data for Name: VALIDAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (1, 1, 1, 1, '2025-11-17 08:10:00+01', 'VALIDATO', 'Biglietto in regola.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (2, 2, 2, 2, '2025-11-18 09:15:00+01', 'VALIDATO', 'Controllo su treno.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (3, 3, 2, 2, '2025-11-18 09:18:00+01', 'VALIDATO', 'Controllo su treno.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (4, 4, 3, 3, '2025-11-19 14:10:00+01', 'VALIDATO', 'Passeggero premium.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (5, 5, 4, 4, '2025-11-20 18:40:00+01', 'NON VALIDO', 'Segnalato smarrito.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (6, 6, 5, 5, '2025-11-22 05:40:00+01', 'VALIDATO', 'Controllo casuale.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (7, 7, 5, 6, '2025-11-23 13:05:00+01', 'VALIDATO', 'Upgrade classe.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (8, 8, 1, 7, '2025-11-24 07:05:00+01', 'VALIDATO', 'Viaggiatore frequente.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (9, 9, 2, 8, '2025-11-25 12:00:00+01', 'VALIDATO', 'Cliente app.');
INSERT INTO public."VALIDAZIONI" (id_validazione, id_biglietto, id_operatore, id_orario, timestamp_validazione, esito, note) VALUES (10, 10, 3, 9, '2025-11-26 18:10:00+01', 'NON VALIDO', 'Problema pagamento.');


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 225
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."BIGLIETTI_id_biglietto_seq"', 1, false);


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 240
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OPERATORI_id_operatore_seq"', 1, false);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 232
-- Name: ORARI_id_orario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ORARI_id_orario_seq"', 1, false);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 236
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PAGAMENTI_id_pagamento_seq"', 1, false);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 221
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PASSEGGERO_id_passeggero_seq"', 1, false);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 223
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PRENOTAZIONI_id_prenotazione_seq"', 1, false);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 234
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PREZZI_id_prezzo_seq"', 1, false);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 219
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."STATIONS_id_stazione_seq"', 1, false);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 227
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TARIFFE_id_tariffa_seq"', 1, false);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 229
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TRATTE_id_tratta_seq"', 1, false);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 242
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VALIDAZIONI_id_validazione_seq"', 1, false);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 238
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VEICOLI_id_veicolo_seq"', 1, false);


-- Completed on 2025-11-17 20:49:34

--
-- PostgreSQL database dump complete
--

\unrestrict DtiodNELevj6Ejkd1i7tSbjkeOMcfZot7EZQZ2DikuZpEjWoRntG2L6qBXChA3j

