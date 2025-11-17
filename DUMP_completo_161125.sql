--
-- PostgreSQL database dump
--

\restrict XdBEusYjbNBy4S09BX4ZUDQELmA8lcY6xVtfvC5v2ACz9hmObH96IZCPZwJnZ23

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-16 18:43:36

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
-- TOC entry 5218 (class 0 OID 0)
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
    CONSTRAINT check_prezzo_greater CHECK ((prezzo >= (0)::numeric))
);


ALTER TABLE public."BIGLIETTI" OWNER TO postgres;

--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."BIGLIETTI" IS 'Tabella contenente tutti i titoli di viaggio acquistati legati ad una prentoazione';


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
-- TOC entry 5220 (class 0 OID 0)
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
-- TOC entry 5221 (class 0 OID 0)
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
-- TOC entry 5222 (class 0 OID 0)
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
-- TOC entry 5223 (class 0 OID 0)
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
-- TOC entry 5224 (class 0 OID 0)
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
-- TOC entry 5225 (class 0 OID 0)
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
-- TOC entry 5226 (class 0 OID 0)
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
-- TOC entry 5227 (class 0 OID 0)
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
-- TOC entry 5228 (class 0 OID 0)
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
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PRENOTAZIONI" IS 'Tabella che conterrà tutte le prenotazioni effettuate dal passeggero/cliente';


--
-- TOC entry 5230 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN "PRENOTAZIONI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PRENOTAZIONI".id_orario IS 'FK per relazionare alla tabella ORARI';


--
-- TOC entry 5231 (class 0 OID 0)
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
-- TOC entry 5232 (class 0 OID 0)
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
-- TOC entry 5233 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PREZZI" IS 'Tabella contenente i prezzi da applicare in fase di prenotazione';


--
-- TOC entry 5234 (class 0 OID 0)
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
-- TOC entry 5235 (class 0 OID 0)
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
-- TOC entry 5236 (class 0 OID 0)
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
-- TOC entry 5237 (class 0 OID 0)
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
-- TOC entry 5238 (class 0 OID 0)
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
-- TOC entry 5239 (class 0 OID 0)
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
-- TOC entry 5240 (class 0 OID 0)
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
-- TOC entry 5241 (class 0 OID 0)
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
-- TOC entry 5242 (class 0 OID 0)
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
-- TOC entry 5243 (class 0 OID 0)
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
-- TOC entry 5244 (class 0 OID 0)
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
-- TOC entry 5245 (class 0 OID 0)
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
-- TOC entry 5246 (class 0 OID 0)
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
-- TOC entry 5195 (class 0 OID 16492)
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
-- TOC entry 5210 (class 0 OID 16703)
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
-- TOC entry 5202 (class 0 OID 16596)
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
-- TOC entry 5206 (class 0 OID 16659)
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
-- TOC entry 5191 (class 0 OID 16441)
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
-- TOC entry 5193 (class 0 OID 16463)
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
-- TOC entry 5204 (class 0 OID 16630)
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
-- TOC entry 5189 (class 0 OID 16425)
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
-- TOC entry 5197 (class 0 OID 16526)
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
-- TOC entry 5199 (class 0 OID 16546)
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
-- TOC entry 5200 (class 0 OID 16573)
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
-- TOC entry 5212 (class 0 OID 16719)
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
-- TOC entry 5208 (class 0 OID 16685)
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
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 225
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."BIGLIETTI_id_biglietto_seq"', 1, false);


--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 240
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OPERATORI_id_operatore_seq"', 1, false);


--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 232
-- Name: ORARI_id_orario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ORARI_id_orario_seq"', 1, false);


--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 236
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PAGAMENTI_id_pagamento_seq"', 1, false);


--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 221
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PASSEGGERO_id_passeggero_seq"', 1, false);


--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 223
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PRENOTAZIONI_id_prenotazione_seq"', 1, false);


--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 234
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PREZZI_id_prezzo_seq"', 1, false);


--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 219
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."STATIONS_id_stazione_seq"', 1, false);


--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 227
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TARIFFE_id_tariffa_seq"', 1, false);


--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 229
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TRATTE_id_tratta_seq"', 1, false);


--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 242
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VALIDAZIONI_id_validazione_seq"', 1, false);


--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 238
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VEICOLI_id_veicolo_seq"', 1, false);


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
-- TOC entry 5259 (class 0 OID 0)
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
-- TOC entry 5260 (class 0 OID 0)
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
-- TOC entry 5261 (class 0 OID 0)
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
-- TOC entry 5262 (class 0 OID 0)
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
-- TOC entry 5263 (class 0 OID 0)
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
-- TOC entry 5264 (class 0 OID 0)
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
-- TOC entry 5265 (class 0 OID 0)
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
-- TOC entry 5266 (class 0 OID 0)
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
-- TOC entry 5267 (class 0 OID 0)
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
-- TOC entry 5268 (class 0 OID 0)
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
-- TOC entry 5269 (class 0 OID 0)
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
-- TOC entry 5270 (class 0 OID 0)
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
-- TOC entry 5038 (class 2606 OID 16792)
-- Name: VALIDAZIONI FK_id_biglietto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_biglietto" FOREIGN KEY (id_biglietto) REFERENCES public."BIGLIETTI"(id_biglietto) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 5038
-- Name: CONSTRAINT "FK_id_biglietto" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_biglietto" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata al biglietto controllato della tabella BIGLIETTI. Non posso cancellare una riga della tabella BIGLIETTI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5039 (class 2606 OID 16738)
-- Name: VALIDAZIONI FK_id_operatore; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_operatore" FOREIGN KEY (id_operatore) REFERENCES public."OPERATORI"(id_operatore) ON DELETE RESTRICT;


--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 5039
-- Name: CONSTRAINT "FK_id_operatore" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_operatore" ON public."VALIDAZIONI" IS 'Collega alla tabella OPERATORI, per identificare l''operatore che ha effettuato la validazione.
Non posso cancellare una riga della tabella OPERATORI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5040 (class 2606 OID 16743)
-- Name: VALIDAZIONI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario);


--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 5040
-- Name: CONSTRAINT "FK_id_orario" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata alla schedulazione, relazionandosi alla tabella ORARI. Non posso cancellare una riga della tabella ORARI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 5034 (class 2606 OID 16757)
-- Name: PREZZI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 5034
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
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 5024
-- Name: CONSTRAINT "FK_id_orario" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."PRENOTAZIONI" IS 'FK per relazionare la tabella ORARI';


--
-- TOC entry 5025 (class 2606 OID 16786)
-- Name: PRENOTAZIONI FK_id_passeggero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "FK_id_passeggero" FOREIGN KEY (id_passeggero) REFERENCES public."PASSEGGERI"(id_passeggero) NOT VALID;


--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 5025
-- Name: CONSTRAINT "FK_id_passeggero" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_passeggero" ON public."PRENOTAZIONI" IS 'FK per collegare prenotazioni con passeggero';


--
-- TOC entry 5037 (class 2606 OID 16679)
-- Name: PAGAMENTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT;


--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 5037
-- Name: CONSTRAINT "FK_id_prenotazione" ON "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."PAGAMENTI" IS 'Per relazionare l''entità alla tabella PRENOTAZIONI. Non è possibile cancellare una riga di PRENOTAZIONI se esiste una all''interno di PAGAMENTI';


--
-- TOC entry 5026 (class 2606 OID 16798)
-- Name: BIGLIETTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 5026
-- Name: CONSTRAINT "FK_id_prenotazione" ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."BIGLIETTI" IS 'FK che collega la tabella a quella delle PRENOTAZIONI';


--
-- TOC entry 5029 (class 2606 OID 16590)
-- Name: TRATTE_INTERMEDIE FK_id_stazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_stazione" FOREIGN KEY (id_stazione) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5279 (class 0 OID 0)
-- Dependencies: 5029
-- Name: CONSTRAINT "FK_id_stazione" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_stazione" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle STAZIONI';


--
-- TOC entry 5031 (class 2606 OID 16619)
-- Name: ORARI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa);


--
-- TOC entry 5280 (class 0 OID 0)
-- Dependencies: 5031
-- Name: CONSTRAINT "FK_id_tariffa" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."ORARI" IS 'FK per legare alla tabella TARIFFE';


--
-- TOC entry 5035 (class 2606 OID 16653)
-- Name: PREZZI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa) ON DELETE CASCADE;


--
-- TOC entry 5281 (class 0 OID 0)
-- Dependencies: 5035
-- Name: CONSTRAINT "FK_id_tariffa" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."PREZZI" IS 'per collegare alla tabella TARIFFE. Inoltre, se un elemento collegato di TARIFFE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI.';


--
-- TOC entry 5030 (class 2606 OID 16585)
-- Name: TRATTE_INTERMEDIE FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 5030
-- Name: CONSTRAINT "FK_id_tratta" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle tratte "principali"';


--
-- TOC entry 5032 (class 2606 OID 16624)
-- Name: ORARI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 5032
-- Name: CONSTRAINT "FK_id_tratta" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."ORARI" IS 'FK per legare alla tabella TRATTE';


--
-- TOC entry 5036 (class 2606 OID 16648)
-- Name: PREZZI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta) ON DELETE CASCADE;


--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 5036
-- Name: CONSTRAINT "FK_id_tratta" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."PREZZI" IS 'Collega alla tabella TRATTE. Inoltre, se un elemento collegato di TRATTE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI. ';


--
-- TOC entry 5033 (class 2606 OID 16749)
-- Name: ORARI FK_id_veicolo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_veicolo" FOREIGN KEY (id_veicolo) REFERENCES public."VEICOLI"(id_veicolo) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 5285 (class 0 OID 0)
-- Dependencies: 5033
-- Name: CONSTRAINT "FK_id_veicolo" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_veicolo" ON public."ORARI" IS 'FK che collega alla tabella VEICOLI. Se esiste una corrispondenza nella tabella ORARI, non posso cancellare la riga corrispondente in VEICOLI';


--
-- TOC entry 5027 (class 2606 OID 16568)
-- Name: TRATTE FK_stazione_arrivo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_arrivo_id" FOREIGN KEY (stazione_arrivo_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 5027
-- Name: CONSTRAINT "FK_stazione_arrivo_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_arrivo_id" ON public."TRATTE" IS 'FK che collega stazione di arrivo alla tabella STAZIONI';


--
-- TOC entry 5028 (class 2606 OID 16563)
-- Name: TRATTE FK_stazione_partenza_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_partenza_id" FOREIGN KEY (stazione_partenza_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 5028
-- Name: CONSTRAINT "FK_stazione_partenza_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_partenza_id" ON public."TRATTE" IS 'FK che collega stazione di partenza alla tabella STAZIONI';


-- Completed on 2025-11-16 18:43:36

--
-- PostgreSQL database dump complete
--

\unrestrict XdBEusYjbNBy4S09BX4ZUDQELmA8lcY6xVtfvC5v2ACz9hmObH96IZCPZwJnZ23

