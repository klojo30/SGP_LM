--
-- PostgreSQL database dump
--

\restrict a0eWEAgO8OnOnybjfXvcoSaqigjgvIrDevDEs3ABKgw9rHyl2QjWeQVTvySRH75

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-18 20:58:43

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16492)
-- Name: BIGLIETTI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BIGLIETTI" (
    id_biglietto integer NOT NULL,
    codice_biglietto character varying(20) NOT NULL,
    id_prenotazione integer NOT NULL,
    id_tariffa integer NOT NULL,
    timestamp_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    timestamp_validita_inizio timestamp with time zone NOT NULL,
    timestamp_validita_fine timestamp with time zone NOT NULL,
    stato character varying(30) DEFAULT 'ATTIVO'::character varying NOT NULL,
    timestamp_validazione timestamp with time zone,
    prezzo numeric(8,2) NOT NULL,
    id_orario integer NOT NULL,
    CONSTRAINT check_prezzo_greater CHECK ((prezzo >= (0)::numeric))
);


ALTER TABLE public."BIGLIETTI" OWNER TO postgres;

--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."BIGLIETTI" IS 'Tabella contenente tutti i titoli di viaggio acquistati legati ad una prentoazione';


--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN "BIGLIETTI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."BIGLIETTI".id_orario IS 'FK per collegare alla tabella ORARI';


--
-- TOC entry 225 (class 1259 OID 16491)
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."BIGLIETTI_id_biglietto_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."BIGLIETTI_id_biglietto_seq" OWNER TO postgres;

--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 225
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."BIGLIETTI_id_biglietto_seq" OWNED BY public."BIGLIETTI".id_biglietto;


--
-- TOC entry 241 (class 1259 OID 16703)
-- Name: OPERATORI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OPERATORI" (
    id_operatore integer NOT NULL,
    matricola_operatore character varying(20) NOT NULL,
    ruolo character varying(30) DEFAULT ' CONTROLLORE'::character varying NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    stato_attivo boolean DEFAULT true,
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."OPERATORI" OWNER TO postgres;

--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE "OPERATORI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."OPERATORI" IS 'Tabella contenente tutti gli operatori abilitati alla validazione dei BIGLIETTI. Potrà contenere anche altre tipologie di operatori.';


--
-- TOC entry 240 (class 1259 OID 16702)
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OPERATORI_id_operatore_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OPERATORI_id_operatore_seq" OWNER TO postgres;

--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 240
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OPERATORI_id_operatore_seq" OWNED BY public."OPERATORI".id_operatore;


--
-- TOC entry 233 (class 1259 OID 16596)
-- Name: ORARI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ORARI" (
    id_orario integer NOT NULL,
    codice_orario character varying(50) NOT NULL,
    timestamp_partenza timestamp with time zone NOT NULL,
    timestamp_arrivo timestamp with time zone NOT NULL,
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_tariffa integer NOT NULL,
    id_tratta integer NOT NULL,
    id_veicolo integer NOT NULL,
    validita_da date NOT NULL,
    validita_a date,
    stato character varying(30) DEFAULT 'ATTIVO'::character varying,
    note text,
    CONSTRAINT check_partenza CHECK ((timestamp_partenza < timestamp_arrivo)),
    CONSTRAINT check_validita CHECK ((validita_da <= COALESCE(validita_a, '9999-12-31'::date)))
);


ALTER TABLE public."ORARI" OWNER TO postgres;

--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."ORARI" IS 'Tabella contenente tutti gli orari di partenza, utilizzata in fase di prenotazione dal cliente/passeggero. Identificabile come entità "corsa" del treno.';


--
-- TOC entry 232 (class 1259 OID 16595)
-- Name: ORARI_id_orario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ORARI_id_orario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ORARI_id_orario_seq" OWNER TO postgres;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 232
-- Name: ORARI_id_orario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ORARI_id_orario_seq" OWNED BY public."ORARI".id_orario;


--
-- TOC entry 237 (class 1259 OID 16659)
-- Name: PAGAMENTI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PAGAMENTI" (
    id_pagamento integer NOT NULL,
    id_prenotazione integer NOT NULL,
    codice_transazione character varying NOT NULL,
    importo numeric(8,2) NOT NULL,
    commissioni numeric(6,2) DEFAULT 0.00,
    metodo_pagamento character varying(30) NOT NULL,
    data_pagamento timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    stato_pagamento character varying(30) DEFAULT 'PENDING'::character varying,
    note_pagamento text,
    CONSTRAINT check_commissioni CHECK ((commissioni >= (0)::numeric)),
    CONSTRAINT check_importo CHECK ((importo >= (0)::numeric))
);


ALTER TABLE public."PAGAMENTI" OWNER TO postgres;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PAGAMENTI" IS 'Tabella contenente tutte le transazione avvenute (sia quelle a buon fine che fallite), inerenti alle prenotazioni.';


--
-- TOC entry 236 (class 1259 OID 16658)
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PAGAMENTI_id_pagamento_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PAGAMENTI_id_pagamento_seq" OWNER TO postgres;

--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 236
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PAGAMENTI_id_pagamento_seq" OWNED BY public."PAGAMENTI".id_pagamento;


--
-- TOC entry 222 (class 1259 OID 16441)
-- Name: PASSEGGERI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PASSEGGERI" (
    id_passeggero integer CONSTRAINT "PASSEGGERO_id_passeggero_not_null" NOT NULL,
    codice_fiscale character varying(16) CONSTRAINT "PASSEGGERO_codice_fiscale_not_null" NOT NULL,
    nome character varying(50) CONSTRAINT "PASSEGGERO_nome_not_null" NOT NULL,
    cognome character varying(50) CONSTRAINT "PASSEGGERO_cognome_not_null" NOT NULL,
    data_nascita date CONSTRAINT "PASSEGGERO_data_nascita_not_null" NOT NULL,
    email character varying(50),
    telefono character varying(20),
    indirizzo text,
    citta character varying(50),
    provincia character varying(2),
    cap character varying(10),
    codice_carta_fedelta character varying(50),
    data_registrazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_data_nascita_not_future CHECK ((data_nascita < CURRENT_DATE))
);


ALTER TABLE public."PASSEGGERI" OWNER TO postgres;

--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PASSEGGERI" IS 'Tabella contenente tutte le informazioni inerenti al passeggero/cliente che effettua la prenotazione';


--
-- TOC entry 221 (class 1259 OID 16440)
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PASSEGGERO_id_passeggero_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PASSEGGERO_id_passeggero_seq" OWNER TO postgres;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 221
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PASSEGGERO_id_passeggero_seq" OWNED BY public."PASSEGGERI".id_passeggero;


--
-- TOC entry 224 (class 1259 OID 16463)
-- Name: PRENOTAZIONI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PRENOTAZIONI" (
    id_prenotazione integer NOT NULL,
    codice_prenotazione character varying(20) NOT NULL,
    data_prenotazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    numero_posti smallint DEFAULT 1 NOT NULL,
    importo_totale numeric(8,2) NOT NULL,
    stato_prenotazione character varying(30),
    canale character varying(30) NOT NULL,
    id_orario integer NOT NULL,
    id_passeggero integer NOT NULL
);


ALTER TABLE public."PRENOTAZIONI" OWNER TO postgres;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PRENOTAZIONI" IS 'Tabella che conterrà tutte le prenotazioni effettuate dal passeggero/cliente';


--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN "PRENOTAZIONI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PRENOTAZIONI".id_orario IS 'FK per relazionare alla tabella ORARI';


--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN "PRENOTAZIONI".id_passeggero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PRENOTAZIONI".id_passeggero IS 'FK per collegare alla tabella PASSEGGERI';


--
-- TOC entry 223 (class 1259 OID 16462)
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PRENOTAZIONI_id_prenotazione_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PRENOTAZIONI_id_prenotazione_seq" OWNER TO postgres;

--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 223
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PRENOTAZIONI_id_prenotazione_seq" OWNED BY public."PRENOTAZIONI".id_prenotazione;


--
-- TOC entry 235 (class 1259 OID 16630)
-- Name: PREZZI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PREZZI" (
    id_prezzo integer NOT NULL,
    id_tariffa integer NOT NULL,
    id_tratta integer NOT NULL,
    classe character varying(30) DEFAULT 'STANDARD'::character varying,
    timestamp_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    timestamp_modifica timestamp with time zone,
    stato character varying(30) DEFAULT 'ATTIVO'::character varying,
    validita_da date NOT NULL,
    validita_a date,
    prezzo_base numeric(8,2) NOT NULL,
    prezzo_weekend numeric(8,2),
    prezzo_festivo numeric(8,2),
    id_orario integer NOT NULL,
    CONSTRAINT check_prezzo CHECK ((prezzo_base >= (0)::numeric)),
    CONSTRAINT check_validita CHECK ((validita_da <= COALESCE(validita_a, '9999-12-31'::date)))
);


ALTER TABLE public."PREZZI" OWNER TO postgres;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PREZZI" IS 'Tabella contenente i prezzi da applicare in fase di prenotazione';


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN "PREZZI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PREZZI".id_orario IS 'FK per legare alla tabella ORARI';


--
-- TOC entry 234 (class 1259 OID 16629)
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PREZZI_id_prezzo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PREZZI_id_prezzo_seq" OWNER TO postgres;

--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 234
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PREZZI_id_prezzo_seq" OWNED BY public."PREZZI".id_prezzo;


--
-- TOC entry 220 (class 1259 OID 16425)
-- Name: STAZIONI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."STAZIONI" (
    id_stazione integer CONSTRAINT "STATIONS_id_stazione_not_null" NOT NULL,
    codice_stazione character varying(20) CONSTRAINT "STATIONS_codice_stazione_not_null" NOT NULL,
    nome_stazione character varying(128) CONSTRAINT "STATIONS_nome_stazione_not_null" NOT NULL,
    citta character varying(50) CONSTRAINT "STATIONS_citta_not_null" NOT NULL,
    provincia character varying(2),
    latitudine numeric(11,8),
    longitudine numeric(11,8),
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."STAZIONI" OWNER TO postgres;

--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."STAZIONI" IS 'Tabella che include tutte le stazioni e fermate, selezionabili dal cliente/passeggero in fase di prenotazione. Aggiungo una constraint che mi assicura che abbia longitude o latitude popolati singolarmente, ma solo in coppia.';


--
-- TOC entry 219 (class 1259 OID 16424)
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."STATIONS_id_stazione_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."STATIONS_id_stazione_seq" OWNER TO postgres;

--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 219
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."STATIONS_id_stazione_seq" OWNED BY public."STAZIONI".id_stazione;


--
-- TOC entry 228 (class 1259 OID 16526)
-- Name: TARIFFE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TARIFFE" (
    id_tariffa integer NOT NULL,
    codice_tariffa character varying(20) NOT NULL,
    tipo_tariffa character varying(128) NOT NULL,
    descrizione text,
    cambio_consentito boolean DEFAULT true NOT NULL,
    attivo boolean DEFAULT true,
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sconto_percentuale numeric(5,2)
);


ALTER TABLE public."TARIFFE" OWNER TO postgres;

--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE "TARIFFE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TARIFFE" IS 'Contiene le tariffe che caratterizzano un titolo di viaggio prenotato.';


--
-- TOC entry 227 (class 1259 OID 16525)
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TARIFFE_id_tariffa_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TARIFFE_id_tariffa_seq" OWNER TO postgres;

--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 227
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TARIFFE_id_tariffa_seq" OWNED BY public."TARIFFE".id_tariffa;


--
-- TOC entry 230 (class 1259 OID 16546)
-- Name: TRATTE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TRATTE" (
    id_tratta integer NOT NULL,
    stazione_partenza_id integer NOT NULL,
    stazione_arrivo_id integer NOT NULL,
    km_distanza numeric(8,2) NOT NULL,
    durata interval,
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    stato_tratta character varying(30) DEFAULT 'ATTIVA'::character varying,
    validita_da date NOT NULL,
    validita_a date,
    CONSTRAINT check_km_distanza CHECK ((km_distanza > (0)::numeric)),
    CONSTRAINT check_stazioni CHECK ((stazione_arrivo_id <> stazione_partenza_id)),
    CONSTRAINT check_validita CHECK ((validita_da <= COALESCE(validita_a, '9999-12-31'::date)))
);


ALTER TABLE public."TRATTE" OWNER TO postgres;

--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TRATTE" IS 'Contiene tutte le tratte gestite dal servizio ferroviario';


--
-- TOC entry 231 (class 1259 OID 16573)
-- Name: TRATTE_INTERMEDIE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TRATTE_INTERMEDIE" (
    id_tratta integer NOT NULL,
    id_stazione integer NOT NULL,
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    tempo_sosta_minuti smallint DEFAULT 2,
    ordine_fermata smallint NOT NULL,
    CONSTRAINT check_ordine_fermata CHECK ((ordine_fermata > 0))
);


ALTER TABLE public."TRATTE_INTERMEDIE" OWNER TO postgres;

--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TRATTE_INTERMEDIE" IS 'Contiene le fermate intermedie di una tratta ';


--
-- TOC entry 229 (class 1259 OID 16545)
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TRATTE_id_tratta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TRATTE_id_tratta_seq" OWNER TO postgres;

--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 229
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TRATTE_id_tratta_seq" OWNED BY public."TRATTE".id_tratta;


--
-- TOC entry 243 (class 1259 OID 16719)
-- Name: VALIDAZIONI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VALIDAZIONI" (
    id_validazione integer NOT NULL,
    id_biglietto integer NOT NULL,
    id_operatore integer NOT NULL,
    id_orario integer NOT NULL,
    timestamp_validazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    esito character varying(30) NOT NULL,
    note text
);


ALTER TABLE public."VALIDAZIONI" OWNER TO postgres;

--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."VALIDAZIONI" IS 'Contiene tutte le validazioni effettuate da un operatore, sui ticket controllati.';


--
-- TOC entry 242 (class 1259 OID 16718)
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."VALIDAZIONI_id_validazione_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."VALIDAZIONI_id_validazione_seq" OWNER TO postgres;

--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 242
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VALIDAZIONI_id_validazione_seq" OWNED BY public."VALIDAZIONI".id_validazione;


--
-- TOC entry 239 (class 1259 OID 16685)
-- Name: VEICOLI; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VEICOLI" (
    id_veicolo integer NOT NULL,
    codice_veicolo character varying(50) NOT NULL,
    modello character varying(50),
    totale_posti integer NOT NULL,
    posti_prima_classe integer DEFAULT 0,
    posti_seconda_classe integer DEFAULT 0,
    stato_veicolo character varying(30) DEFAULT 'ATTIVO'::character varying,
    timestamp_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Check_posti_totali" CHECK (((posti_prima_classe + posti_seconda_classe) <= totale_posti)),
    CONSTRAINT "Check_totale_posti" CHECK ((totale_posti > 0))
);


ALTER TABLE public."VEICOLI" OWNER TO postgres;

--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE "VEICOLI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."VEICOLI" IS 'Tabella contenente tutti i veicoli della flotta aziendale ';


--
-- TOC entry 238 (class 1259 OID 16684)
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."VEICOLI_id_veicolo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."VEICOLI_id_veicolo_seq" OWNER TO postgres;

--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 238
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VEICOLI_id_veicolo_seq" OWNED BY public."VEICOLI".id_veicolo;


--
-- TOC entry 4922 (class 2604 OID 16495)
-- Name: BIGLIETTI id_biglietto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI" ALTER COLUMN id_biglietto SET DEFAULT nextval('public."BIGLIETTI_id_biglietto_seq"'::regclass);


--
-- TOC entry 4950 (class 2604 OID 16706)
-- Name: OPERATORI id_operatore; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OPERATORI" ALTER COLUMN id_operatore SET DEFAULT nextval('public."OPERATORI_id_operatore_seq"'::regclass);


--
-- TOC entry 4934 (class 2604 OID 16599)
-- Name: ORARI id_orario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI" ALTER COLUMN id_orario SET DEFAULT nextval('public."ORARI_id_orario_seq"'::regclass);


--
-- TOC entry 4941 (class 2604 OID 16662)
-- Name: PAGAMENTI id_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI" ALTER COLUMN id_pagamento SET DEFAULT nextval('public."PAGAMENTI_id_pagamento_seq"'::regclass);


--
-- TOC entry 4917 (class 2604 OID 16444)
-- Name: PASSEGGERI id_passeggero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI" ALTER COLUMN id_passeggero SET DEFAULT nextval('public."PASSEGGERO_id_passeggero_seq"'::regclass);


--
-- TOC entry 4919 (class 2604 OID 16466)
-- Name: PRENOTAZIONI id_prenotazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI" ALTER COLUMN id_prenotazione SET DEFAULT nextval('public."PRENOTAZIONI_id_prenotazione_seq"'::regclass);


--
-- TOC entry 4937 (class 2604 OID 16633)
-- Name: PREZZI id_prezzo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI" ALTER COLUMN id_prezzo SET DEFAULT nextval('public."PREZZI_id_prezzo_seq"'::regclass);


--
-- TOC entry 4915 (class 2604 OID 16428)
-- Name: STAZIONI id_stazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI" ALTER COLUMN id_stazione SET DEFAULT nextval('public."STATIONS_id_stazione_seq"'::regclass);


--
-- TOC entry 4925 (class 2604 OID 16529)
-- Name: TARIFFE id_tariffa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE" ALTER COLUMN id_tariffa SET DEFAULT nextval('public."TARIFFE_id_tariffa_seq"'::regclass);


--
-- TOC entry 4929 (class 2604 OID 16549)
-- Name: TRATTE id_tratta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE" ALTER COLUMN id_tratta SET DEFAULT nextval('public."TRATTE_id_tratta_seq"'::regclass);


--
-- TOC entry 4954 (class 2604 OID 16722)
-- Name: VALIDAZIONI id_validazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI" ALTER COLUMN id_validazione SET DEFAULT nextval('public."VALIDAZIONI_id_validazione_seq"'::regclass);


--
-- TOC entry 4945 (class 2604 OID 16688)
-- Name: VEICOLI id_veicolo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI" ALTER COLUMN id_veicolo SET DEFAULT nextval('public."VEICOLI_id_veicolo_seq"'::regclass);


--
-- TOC entry 4990 (class 2606 OID 16509)
-- Name: BIGLIETTI BIGLIETTI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "BIGLIETTI_pkey" PRIMARY KEY (id_biglietto);


--
-- TOC entry 5020 (class 2606 OID 16716)
-- Name: OPERATORI OPERATORI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OPERATORI"
    ADD CONSTRAINT "OPERATORI_pkey" PRIMARY KEY (id_operatore);


--
-- TOC entry 5003 (class 2606 OID 16616)
-- Name: ORARI ORARI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "ORARI_pkey" PRIMARY KEY (id_orario);


--
-- TOC entry 5012 (class 2606 OID 16676)
-- Name: PAGAMENTI PAGAMENTI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT "PAGAMENTI_pkey" PRIMARY KEY (id_pagamento);


--
-- TOC entry 4977 (class 2606 OID 16455)
-- Name: PASSEGGERI PASSEGGERO_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT "PASSEGGERO_pkey" PRIMARY KEY (id_passeggero);


--
-- TOC entry 4985 (class 2606 OID 16477)
-- Name: PRENOTAZIONI PRENOTAZIONI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "PRENOTAZIONI_pkey" PRIMARY KEY (id_prenotazione);


--
-- TOC entry 5007 (class 2606 OID 16645)
-- Name: PREZZI PREZZI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "PREZZI_pkey" PRIMARY KEY (id_prezzo);


--
-- TOC entry 4973 (class 2606 OID 16436)
-- Name: STAZIONI STATIONS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI"
    ADD CONSTRAINT "STATIONS_pkey" PRIMARY KEY (id_stazione);


--
-- TOC entry 4995 (class 2606 OID 16542)
-- Name: TARIFFE TARIFFE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE"
    ADD CONSTRAINT "TARIFFE_pkey" PRIMARY KEY (id_tariffa);


--
-- TOC entry 5001 (class 2606 OID 16584)
-- Name: TRATTE_INTERMEDIE TRATTE_INTERMEDIE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "TRATTE_INTERMEDIE_pkey" PRIMARY KEY (id_tratta, id_stazione);


--
-- TOC entry 4999 (class 2606 OID 16562)
-- Name: TRATTE TRATTE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "TRATTE_pkey" PRIMARY KEY (id_tratta);


--
-- TOC entry 5022 (class 2606 OID 16732)
-- Name: VALIDAZIONI VALIDAZIONI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "VALIDAZIONI_pkey" PRIMARY KEY (id_validazione);


--
-- TOC entry 5016 (class 2606 OID 16699)
-- Name: VEICOLI VEICOLI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI"
    ADD CONSTRAINT "VEICOLI_pkey" PRIMARY KEY (id_veicolo);


--
-- TOC entry 4956 (class 2606 OID 16439)
-- Name: STAZIONI check_coordinate; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."STAZIONI"
    ADD CONSTRAINT check_coordinate CHECK ((((latitudine IS NULL) AND (longitudine IS NULL)) OR ((latitudine IS NOT NULL) AND (longitudine IS NOT NULL)))) NOT VALID;


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 4956
-- Name: CONSTRAINT check_coordinate ON "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT check_coordinate ON public."STAZIONI" IS 'per assicurarmi che o entrambe le colonne latitudine e longitudine sono popolate, o nessuna';


--
-- TOC entry 4959 (class 2606 OID 16748)
-- Name: TARIFFE check_sconto; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."TARIFFE"
    ADD CONSTRAINT check_sconto CHECK (((sconto_percentuale < (100)::numeric) OR (sconto_percentuale > (0)::numeric))) NOT VALID;


--
-- TOC entry 5009 (class 2606 OID 16764)
-- Name: PREZZI check_unique_price; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT check_unique_price UNIQUE (id_tariffa, classe, id_orario, validita_da);


--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 5009
-- Name: CONSTRAINT check_unique_price ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT check_unique_price ON public."PREZZI" IS 'Per esser certi che non esistano prezzi con le seguenti colonne uguali: validita_da, classe, id_orario, id_tariffa.';


--
-- TOC entry 4992 (class 2606 OID 16511)
-- Name: BIGLIETTI codice_biglietto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT codice_biglietto UNIQUE (codice_biglietto);


--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 4992
-- Name: CONSTRAINT codice_biglietto ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_biglietto ON public."BIGLIETTI" IS 'codice_biglietto deve essere unico';


--
-- TOC entry 4979 (class 2606 OID 16461)
-- Name: PASSEGGERI codice_carta_fedelta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT codice_carta_fedelta UNIQUE (codice_carta_fedelta);


--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 4979
-- Name: CONSTRAINT codice_carta_fedelta ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_carta_fedelta ON public."PASSEGGERI" IS 'per esser certi che non venga riutilizzata la stessa carta fedeltà per più clienti';


--
-- TOC entry 4981 (class 2606 OID 16457)
-- Name: PASSEGGERI codice_fiscale; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT codice_fiscale UNIQUE (codice_fiscale);


--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 4981
-- Name: CONSTRAINT codice_fiscale ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_fiscale ON public."PASSEGGERI" IS 'per esser certi di avere sempre codici fiscali univoci';


--
-- TOC entry 5005 (class 2606 OID 16618)
-- Name: ORARI codice_orario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT codice_orario UNIQUE (codice_orario);


--
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 5005
-- Name: CONSTRAINT codice_orario ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_orario ON public."ORARI" IS 'Non posso avere codice_orario uguali ';


--
-- TOC entry 4987 (class 2606 OID 16479)
-- Name: PRENOTAZIONI codice_prenotazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT codice_prenotazione UNIQUE (codice_prenotazione);


--
-- TOC entry 5230 (class 0 OID 0)
-- Dependencies: 4987
-- Name: CONSTRAINT codice_prenotazione ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_prenotazione ON public."PRENOTAZIONI" IS 'non possono esserci record con stesso codice_prenotazione';


--
-- TOC entry 4975 (class 2606 OID 16438)
-- Name: STAZIONI codice_stazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI"
    ADD CONSTRAINT codice_stazione UNIQUE (codice_stazione);


--
-- TOC entry 5231 (class 0 OID 0)
-- Dependencies: 4975
-- Name: CONSTRAINT codice_stazione ON "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_stazione ON public."STAZIONI" IS 'per assicurarmi che non abbia stazioni con lo stesso codice';


--
-- TOC entry 4997 (class 2606 OID 16544)
-- Name: TARIFFE codice_tariffa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE"
    ADD CONSTRAINT codice_tariffa UNIQUE (codice_tariffa);


--
-- TOC entry 5232 (class 0 OID 0)
-- Dependencies: 4997
-- Name: CONSTRAINT codice_tariffa ON "TARIFFE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_tariffa ON public."TARIFFE" IS 'codice_tariffa deve essere univoco';


--
-- TOC entry 4983 (class 2606 OID 16459)
-- Name: PASSEGGERI email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT email UNIQUE (email);


--
-- TOC entry 5233 (class 0 OID 0)
-- Dependencies: 4983
-- Name: CONSTRAINT email ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT email ON public."PASSEGGERI" IS 'per esser certi che non venga riutilizzata da altri clienti';


--
-- TOC entry 5014 (class 2606 OID 16678)
-- Name: PAGAMENTI unique_codice_transazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT unique_codice_transazione UNIQUE (codice_transazione);


--
-- TOC entry 5234 (class 0 OID 0)
-- Dependencies: 5014
-- Name: CONSTRAINT unique_codice_transazione ON "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT unique_codice_transazione ON public."PAGAMENTI" IS 'non posso avere codici transazioni uguali';


--
-- TOC entry 5018 (class 2606 OID 16701)
-- Name: VEICOLI unique_codice_veicolo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI"
    ADD CONSTRAINT unique_codice_veicolo UNIQUE (codice_veicolo);


--
-- TOC entry 5235 (class 0 OID 0)
-- Dependencies: 5018
-- Name: CONSTRAINT unique_codice_veicolo ON "VEICOLI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT unique_codice_veicolo ON public."VEICOLI" IS 'non posso avere più veicoli con lo stesso codice_veicolo';


--
-- TOC entry 5023 (class 1259 OID 16797)
-- Name: fki_FK_id_biglietto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_biglietto" ON public."VALIDAZIONI" USING btree (id_biglietto);


--
-- TOC entry 5010 (class 1259 OID 16762)
-- Name: fki_FK_id_orario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_orario" ON public."PREZZI" USING btree (id_orario);


--
-- TOC entry 4988 (class 1259 OID 16791)
-- Name: fki_FK_id_passeggero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_passeggero" ON public."PRENOTAZIONI" USING btree (id_passeggero);


--
-- TOC entry 4993 (class 1259 OID 16803)
-- Name: fki_FK_id_prenotazione; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_prenotazione" ON public."BIGLIETTI" USING btree (id_prenotazione);


--
-- TOC entry 5039 (class 2606 OID 16792)
-- Name: VALIDAZIONI FK_id_biglietto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_biglietto" FOREIGN KEY (id_biglietto) REFERENCES public."BIGLIETTI"(id_biglietto) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5236 (class 0 OID 0)
-- Dependencies: 5039
-- Name: CONSTRAINT "FK_id_biglietto" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_biglietto" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata al biglietto controllato della tabella BIGLIETTI. Non posso cancellare una riga della tabella BIGLIETTI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5040 (class 2606 OID 16738)
-- Name: VALIDAZIONI FK_id_operatore; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_operatore" FOREIGN KEY (id_operatore) REFERENCES public."OPERATORI"(id_operatore) ON DELETE RESTRICT;


--
-- TOC entry 5237 (class 0 OID 0)
-- Dependencies: 5040
-- Name: CONSTRAINT "FK_id_operatore" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_operatore" ON public."VALIDAZIONI" IS 'Collega alla tabella OPERATORI, per identificare l''operatore che ha effettuato la validazione.
Non posso cancellare una riga della tabella OPERATORI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5041 (class 2606 OID 16743)
-- Name: VALIDAZIONI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario);


--
-- TOC entry 5238 (class 0 OID 0)
-- Dependencies: 5041
-- Name: CONSTRAINT "FK_id_orario" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata alla schedulazione, relazionandosi alla tabella ORARI. Non posso cancellare una riga della tabella ORARI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5035 (class 2606 OID 16757)
-- Name: PREZZI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 5239 (class 0 OID 0)
-- Dependencies: 5035
-- Name: CONSTRAINT "FK_id_orario" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."PREZZI" IS 'FK per relazionarla alla tabella ORARI';


--
-- TOC entry 5024 (class 2606 OID 16767)
-- Name: PRENOTAZIONI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5240 (class 0 OID 0)
-- Dependencies: 5024
-- Name: CONSTRAINT "FK_id_orario" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."PRENOTAZIONI" IS 'FK per relazionare la tabella ORARI';


--
-- TOC entry 5026 (class 2606 OID 16811)
-- Name: BIGLIETTI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) NOT VALID;


--
-- TOC entry 5241 (class 0 OID 0)
-- Dependencies: 5026
-- Name: CONSTRAINT "FK_id_orario" ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."BIGLIETTI" IS 'FK per collegare alla tabella ORARI';


--
-- TOC entry 5025 (class 2606 OID 16786)
-- Name: PRENOTAZIONI FK_id_passeggero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "FK_id_passeggero" FOREIGN KEY (id_passeggero) REFERENCES public."PASSEGGERI"(id_passeggero) NOT VALID;


--
-- TOC entry 5242 (class 0 OID 0)
-- Dependencies: 5025
-- Name: CONSTRAINT "FK_id_passeggero" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_passeggero" ON public."PRENOTAZIONI" IS 'FK per collegare prenotazioni con passeggero';


--
-- TOC entry 5038 (class 2606 OID 16679)
-- Name: PAGAMENTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT;


--
-- TOC entry 5243 (class 0 OID 0)
-- Dependencies: 5038
-- Name: CONSTRAINT "FK_id_prenotazione" ON "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."PAGAMENTI" IS 'Per relazionare l''entità alla tabella PRENOTAZIONI. Non è possibile cancellare una riga di PRENOTAZIONI se esiste una all''interno di PAGAMENTI';


--
-- TOC entry 5027 (class 2606 OID 16798)
-- Name: BIGLIETTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5244 (class 0 OID 0)
-- Dependencies: 5027
-- Name: CONSTRAINT "FK_id_prenotazione" ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."BIGLIETTI" IS 'FK che collega la tabella a quella delle PRENOTAZIONI';


--
-- TOC entry 5030 (class 2606 OID 16590)
-- Name: TRATTE_INTERMEDIE FK_id_stazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_stazione" FOREIGN KEY (id_stazione) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5245 (class 0 OID 0)
-- Dependencies: 5030
-- Name: CONSTRAINT "FK_id_stazione" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_stazione" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle STAZIONI';


--
-- TOC entry 5032 (class 2606 OID 16619)
-- Name: ORARI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa);


--
-- TOC entry 5246 (class 0 OID 0)
-- Dependencies: 5032
-- Name: CONSTRAINT "FK_id_tariffa" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."ORARI" IS 'FK per legare alla tabella TARIFFE';


--
-- TOC entry 5036 (class 2606 OID 16653)
-- Name: PREZZI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa) ON DELETE CASCADE;


--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 5036
-- Name: CONSTRAINT "FK_id_tariffa" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."PREZZI" IS 'per collegare alla tabella TARIFFE. Inoltre, se un elemento collegato di TARIFFE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI.';


--
-- TOC entry 5031 (class 2606 OID 16585)
-- Name: TRATTE_INTERMEDIE FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 5031
-- Name: CONSTRAINT "FK_id_tratta" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle tratte "principali"';


--
-- TOC entry 5033 (class 2606 OID 16624)
-- Name: ORARI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 5033
-- Name: CONSTRAINT "FK_id_tratta" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."ORARI" IS 'FK per legare alla tabella TRATTE';


--
-- TOC entry 5037 (class 2606 OID 16648)
-- Name: PREZZI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta) ON DELETE CASCADE;


--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 5037
-- Name: CONSTRAINT "FK_id_tratta" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."PREZZI" IS 'Collega alla tabella TRATTE. Inoltre, se un elemento collegato di TRATTE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI. ';


--
-- TOC entry 5034 (class 2606 OID 16749)
-- Name: ORARI FK_id_veicolo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_veicolo" FOREIGN KEY (id_veicolo) REFERENCES public."VEICOLI"(id_veicolo) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 5034
-- Name: CONSTRAINT "FK_id_veicolo" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_veicolo" ON public."ORARI" IS 'FK che collega alla tabella VEICOLI. Se esiste una corrispondenza nella tabella ORARI, non posso cancellare la riga corrispondente in VEICOLI';


--
-- TOC entry 5028 (class 2606 OID 16568)
-- Name: TRATTE FK_stazione_arrivo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_arrivo_id" FOREIGN KEY (stazione_arrivo_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 5028
-- Name: CONSTRAINT "FK_stazione_arrivo_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_arrivo_id" ON public."TRATTE" IS 'FK che collega stazione di arrivo alla tabella STAZIONI';


--
-- TOC entry 5029 (class 2606 OID 16563)
-- Name: TRATTE FK_stazione_partenza_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_partenza_id" FOREIGN KEY (stazione_partenza_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 5029
-- Name: CONSTRAINT "FK_stazione_partenza_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_partenza_id" ON public."TRATTE" IS 'FK che collega stazione di partenza alla tabella STAZIONI';


-- Completed on 2025-11-18 20:58:43

--
-- PostgreSQL database dump complete
--

\unrestrict a0eWEAgO8OnOnybjfXvcoSaqigjgvIrDevDEs3ABKgw9rHyl2QjWeQVTvySRH75

