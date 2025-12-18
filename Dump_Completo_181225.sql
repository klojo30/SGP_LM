--
-- PostgreSQL database dump
--

\restrict TJvut1bQq2gZxKRNbuPy7U9mjReWs6tFmEHavSVdpq0C1JdDbJzdUtaclflRysE

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-18 20:05:02

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
-- TOC entry 8 (class 2615 OID 17907)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- TOC entry 6326 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 2 (class 3079 OID 16825)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 6327 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 3 (class 3079 OID 17908)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 6328 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- TOC entry 567 (class 1255 OID 18106)
-- Name: stazioni_set_geo_stazione(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stazioni_set_geo_stazione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Se il campo geo_stazione è già valorizzato allora esco
  IF NEW.geo_stazione IS NOT NULL THEN
    RETURN NEW;
  END IF;

  -- mi assicuro che latitudine e longitudine siano popolati, altrimenti esco
  IF NEW."latitudine" IS NULL OR NEW."longitudine" IS NULL THEN
    RETURN NEW;
  END IF;

  -- calcolo il valore del nuovo campo geo_stazione tramite la funz ST_GeogFromText
  NEW.geo_stazione :=
    ST_GeogFromText(
      'SRID=4326;POINT(' ||
      NEW."longitudine" || ' ' || NEW."latitudine" || ')'
    );

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.stazioni_set_geo_stazione() OWNER TO postgres;

--
-- TOC entry 6329 (class 0 OID 0)
-- Dependencies: 567
-- Name: FUNCTION stazioni_set_geo_stazione(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.stazioni_set_geo_stazione() IS 'utilizzata dal trigger per popolare il campo geo_stazione della tabella STAZIONI';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 16492)
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
-- TOC entry 6330 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."BIGLIETTI" IS 'Tabella contenente tutti i titoli di viaggio acquistati legati ad una prentoazione';


--
-- TOC entry 6331 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN "BIGLIETTI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."BIGLIETTI".id_orario IS 'FK per collegare alla tabella ORARI';


--
-- TOC entry 228 (class 1259 OID 16491)
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
-- TOC entry 6332 (class 0 OID 0)
-- Dependencies: 228
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."BIGLIETTI_id_biglietto_seq" OWNED BY public."BIGLIETTI".id_biglietto;


--
-- TOC entry 244 (class 1259 OID 16703)
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
-- TOC entry 6333 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE "OPERATORI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."OPERATORI" IS 'Tabella contenente tutti gli operatori abilitati alla validazione dei BIGLIETTI. Potrà contenere anche altre tipologie di operatori.';


--
-- TOC entry 243 (class 1259 OID 16702)
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
-- TOC entry 6334 (class 0 OID 0)
-- Dependencies: 243
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OPERATORI_id_operatore_seq" OWNED BY public."OPERATORI".id_operatore;


--
-- TOC entry 236 (class 1259 OID 16596)
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
-- TOC entry 6335 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."ORARI" IS 'Tabella contenente tutti gli orari di partenza, utilizzata in fase di prenotazione dal cliente/passeggero. Identificabile come entità "corsa" del treno.';


--
-- TOC entry 235 (class 1259 OID 16595)
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
-- TOC entry 6336 (class 0 OID 0)
-- Dependencies: 235
-- Name: ORARI_id_orario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ORARI_id_orario_seq" OWNED BY public."ORARI".id_orario;


--
-- TOC entry 240 (class 1259 OID 16659)
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
-- TOC entry 6337 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PAGAMENTI" IS 'Tabella contenente tutte le transazione avvenute (sia quelle a buon fine che fallite), inerenti alle prenotazioni.';


--
-- TOC entry 239 (class 1259 OID 16658)
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
-- TOC entry 6338 (class 0 OID 0)
-- Dependencies: 239
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PAGAMENTI_id_pagamento_seq" OWNED BY public."PAGAMENTI".id_pagamento;


--
-- TOC entry 225 (class 1259 OID 16441)
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
-- TOC entry 6339 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PASSEGGERI" IS 'Tabella contenente tutte le informazioni inerenti al passeggero/cliente che effettua la prenotazione';


--
-- TOC entry 224 (class 1259 OID 16440)
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
-- TOC entry 6340 (class 0 OID 0)
-- Dependencies: 224
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PASSEGGERO_id_passeggero_seq" OWNED BY public."PASSEGGERI".id_passeggero;


--
-- TOC entry 227 (class 1259 OID 16463)
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
-- TOC entry 6341 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PRENOTAZIONI" IS 'Tabella che conterrà tutte le prenotazioni effettuate dal passeggero/cliente';


--
-- TOC entry 6342 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN "PRENOTAZIONI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PRENOTAZIONI".id_orario IS 'FK per relazionare alla tabella ORARI';


--
-- TOC entry 6343 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN "PRENOTAZIONI".id_passeggero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PRENOTAZIONI".id_passeggero IS 'FK per collegare alla tabella PASSEGGERI';


--
-- TOC entry 226 (class 1259 OID 16462)
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
-- TOC entry 6344 (class 0 OID 0)
-- Dependencies: 226
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PRENOTAZIONI_id_prenotazione_seq" OWNED BY public."PRENOTAZIONI".id_prenotazione;


--
-- TOC entry 238 (class 1259 OID 16630)
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
-- TOC entry 6345 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."PREZZI" IS 'Tabella contenente i prezzi da applicare in fase di prenotazione';


--
-- TOC entry 6346 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN "PREZZI".id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."PREZZI".id_orario IS 'FK per legare alla tabella ORARI';


--
-- TOC entry 237 (class 1259 OID 16629)
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
-- TOC entry 6347 (class 0 OID 0)
-- Dependencies: 237
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PREZZI_id_prezzo_seq" OWNED BY public."PREZZI".id_prezzo;


--
-- TOC entry 223 (class 1259 OID 16425)
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
    data_creazione timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    geo_stazione public.geography(Point,4326)
);


ALTER TABLE public."STAZIONI" OWNER TO postgres;

--
-- TOC entry 6348 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."STAZIONI" IS 'Tabella che include tutte le stazioni e fermate, selezionabili dal cliente/passeggero in fase di prenotazione. Aggiungo una constraint che mi assicura che abbia longitude o latitude popolati singolarmente, ma solo in coppia.';


--
-- TOC entry 222 (class 1259 OID 16424)
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
-- TOC entry 6349 (class 0 OID 0)
-- Dependencies: 222
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."STATIONS_id_stazione_seq" OWNED BY public."STAZIONI".id_stazione;


--
-- TOC entry 231 (class 1259 OID 16526)
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
-- TOC entry 6350 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE "TARIFFE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TARIFFE" IS 'Contiene le tariffe che caratterizzano un titolo di viaggio prenotato.';


--
-- TOC entry 230 (class 1259 OID 16525)
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
-- TOC entry 6351 (class 0 OID 0)
-- Dependencies: 230
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TARIFFE_id_tariffa_seq" OWNED BY public."TARIFFE".id_tariffa;


--
-- TOC entry 233 (class 1259 OID 16546)
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
-- TOC entry 6352 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TRATTE" IS 'Contiene tutte le tratte gestite dal servizio ferroviario';


--
-- TOC entry 234 (class 1259 OID 16573)
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
-- TOC entry 6353 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."TRATTE_INTERMEDIE" IS 'Contiene le fermate intermedie di una tratta ';


--
-- TOC entry 232 (class 1259 OID 16545)
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
-- TOC entry 6354 (class 0 OID 0)
-- Dependencies: 232
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TRATTE_id_tratta_seq" OWNED BY public."TRATTE".id_tratta;


--
-- TOC entry 246 (class 1259 OID 16719)
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
-- TOC entry 6355 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."VALIDAZIONI" IS 'Contiene tutte le validazioni effettuate da un operatore, sui ticket controllati.';


--
-- TOC entry 245 (class 1259 OID 16718)
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
-- TOC entry 6356 (class 0 OID 0)
-- Dependencies: 245
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VALIDAZIONI_id_validazione_seq" OWNED BY public."VALIDAZIONI".id_validazione;


--
-- TOC entry 242 (class 1259 OID 16685)
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
-- TOC entry 6357 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE "VEICOLI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."VEICOLI" IS 'Tabella contenente tutti i veicoli della flotta aziendale ';


--
-- TOC entry 241 (class 1259 OID 16684)
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
-- TOC entry 6358 (class 0 OID 0)
-- Dependencies: 241
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."VEICOLI_id_veicolo_seq" OWNED BY public."VEICOLI".id_veicolo;


--
-- TOC entry 260 (class 1259 OID 18143)
-- Name: v_dashboard_incassi_giornalieri; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_dashboard_incassi_giornalieri AS
 SELECT date(p.data_pagamento) AS data,
    count(DISTINCT p.id_pagamento) AS numero_transazioni,
    count(DISTINCT pr.id_prenotazione) AS numero_prenotazioni,
    count(DISTINCT ps.id_passeggero) AS numero_clienti_unici,
    sum(p.importo) AS ricavi_lordi,
    sum(p.commissioni) AS commissioni_totali,
    (sum(p.importo) - sum(p.commissioni)) AS ricavi_netti,
    round(avg(p.importo), 2) AS ticket_medio,
    round((((sum(
        CASE
            WHEN ((p.stato_pagamento)::text = 'COMPLETATO'::text) THEN 1
            ELSE 0
        END))::numeric / (count(p.id_pagamento))::numeric) * (100)::numeric), 2) AS percentuale_successo,
    max(p.data_pagamento) AS ultimo_aggiornamento
   FROM ((public."PAGAMENTI" p
     JOIN public."PRENOTAZIONI" pr ON ((p.id_prenotazione = pr.id_prenotazione)))
     JOIN public."PASSEGGERI" ps ON ((pr.id_passeggero = ps.id_passeggero)))
  WHERE (((p.stato_pagamento)::text = 'COMPLETATO'::text) AND (p.data_pagamento >= (CURRENT_DATE - '30 days'::interval)))
  GROUP BY (date(p.data_pagamento))
  ORDER BY (date(p.data_pagamento)) DESC;


ALTER VIEW public.v_dashboard_incassi_giornalieri OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 18138)
-- Name: v_occupazione_tratte; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_occupazione_tratte AS
 SELECT t.id_tratta,
    concat(s1.nome_stazione, ' - ', s2.nome_stazione) AS tratta,
    s1.citta AS citta_partenza,
    s2.citta AS citta_arrivo,
    count(DISTINCT o.id_orario) AS numero_corse,
    count(DISTINCT date(o.timestamp_partenza)) AS numero_giorni,
    sum(v.totale_posti) AS capacita_totale,
    count(DISTINCT b.id_biglietto) AS biglietti_venduti,
    round((((count(DISTINCT b.id_biglietto))::numeric / ((count(DISTINCT o.id_orario))::numeric * avg(v.totale_posti))) * (100)::numeric), 2) AS percentuale_occupazione_media,
    sum(b.prezzo) AS ricavi_totali,
    round(avg(b.prezzo), 2) AS prezzo_medio
   FROM (((((public."TRATTE" t
     JOIN public."STAZIONI" s1 ON ((t.stazione_partenza_id = s1.id_stazione)))
     JOIN public."STAZIONI" s2 ON ((t.stazione_arrivo_id = s2.id_stazione)))
     LEFT JOIN public."ORARI" o ON (((t.id_tratta = o.id_tratta) AND (o.timestamp_partenza > (CURRENT_TIMESTAMP - '90 days'::interval)))))
     LEFT JOIN public."VEICOLI" v ON ((o.id_veicolo = v.id_veicolo)))
     LEFT JOIN public."BIGLIETTI" b ON ((o.id_orario = b.id_orario)))
  WHERE ((t.stato_tratta)::text = 'ATTIVA'::text)
  GROUP BY t.id_tratta, s1.nome_stazione, s2.nome_stazione, s1.citta, s2.citta
 HAVING ((count(DISTINCT o.id_orario) > 0) AND (count(DISTINCT b.id_biglietto) > 0) AND (sum(v.totale_posti) IS NOT NULL))
  ORDER BY (round((((count(DISTINCT b.id_biglietto))::numeric / ((count(DISTINCT o.id_orario))::numeric * avg(v.totale_posti))) * (100)::numeric), 2)) DESC;


ALTER VIEW public.v_occupazione_tratte OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18133)
-- Name: v_performance_controllori; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_performance_controllori AS
 SELECT op.id_operatore,
    op.matricola_operatore,
    concat(op.nome, ' ', op.cognome) AS operatore,
    op.ruolo,
    op.stato_attivo,
    count(DISTINCT v.id_validazione) AS numero_validazioni,
    count(DISTINCT date(v.timestamp_validazione)) AS giorni_attivi,
    round(((count(DISTINCT v.id_validazione))::numeric / (NULLIF(count(DISTINCT date(v.timestamp_validazione)), 0))::numeric), 2) AS media_validazioni_giorno,
    sum(
        CASE
            WHEN ((v.esito)::text = 'VALIDATO'::text) THEN 1
            ELSE 0
        END) AS validazioni_valide,
    sum(
        CASE
            WHEN ((v.esito)::text = 'NON VALIDO'::text) THEN 1
            ELSE 0
        END) AS validazioni_non_valide,
    count(DISTINCT o.id_tratta) AS numero_tratte_controllate,
    count(DISTINCT v.id_orario) AS numero_corse_controllate,
    min(date(v.timestamp_validazione)) AS primo_turno,
    max(date(v.timestamp_validazione)) AS ultimo_turno,
    CURRENT_TIMESTAMP AS data_aggiornamento
   FROM ((public."OPERATORI" op
     LEFT JOIN public."VALIDAZIONI" v ON ((op.id_operatore = v.id_operatore)))
     LEFT JOIN public."ORARI" o ON ((v.id_orario = o.id_orario)))
  GROUP BY op.id_operatore, op.matricola_operatore, op.nome, op.cognome, op.ruolo, op.stato_attivo
  ORDER BY (count(DISTINCT v.id_validazione)) DESC;


ALTER VIEW public.v_performance_controllori OWNER TO postgres;

--
-- TOC entry 5988 (class 2604 OID 16495)
-- Name: BIGLIETTI id_biglietto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI" ALTER COLUMN id_biglietto SET DEFAULT nextval('public."BIGLIETTI_id_biglietto_seq"'::regclass);


--
-- TOC entry 6016 (class 2604 OID 16706)
-- Name: OPERATORI id_operatore; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OPERATORI" ALTER COLUMN id_operatore SET DEFAULT nextval('public."OPERATORI_id_operatore_seq"'::regclass);


--
-- TOC entry 6000 (class 2604 OID 16599)
-- Name: ORARI id_orario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI" ALTER COLUMN id_orario SET DEFAULT nextval('public."ORARI_id_orario_seq"'::regclass);


--
-- TOC entry 6007 (class 2604 OID 16662)
-- Name: PAGAMENTI id_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI" ALTER COLUMN id_pagamento SET DEFAULT nextval('public."PAGAMENTI_id_pagamento_seq"'::regclass);


--
-- TOC entry 5983 (class 2604 OID 16444)
-- Name: PASSEGGERI id_passeggero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI" ALTER COLUMN id_passeggero SET DEFAULT nextval('public."PASSEGGERO_id_passeggero_seq"'::regclass);


--
-- TOC entry 5985 (class 2604 OID 16466)
-- Name: PRENOTAZIONI id_prenotazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI" ALTER COLUMN id_prenotazione SET DEFAULT nextval('public."PRENOTAZIONI_id_prenotazione_seq"'::regclass);


--
-- TOC entry 6003 (class 2604 OID 16633)
-- Name: PREZZI id_prezzo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI" ALTER COLUMN id_prezzo SET DEFAULT nextval('public."PREZZI_id_prezzo_seq"'::regclass);


--
-- TOC entry 5981 (class 2604 OID 16428)
-- Name: STAZIONI id_stazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI" ALTER COLUMN id_stazione SET DEFAULT nextval('public."STATIONS_id_stazione_seq"'::regclass);


--
-- TOC entry 5991 (class 2604 OID 16529)
-- Name: TARIFFE id_tariffa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE" ALTER COLUMN id_tariffa SET DEFAULT nextval('public."TARIFFE_id_tariffa_seq"'::regclass);


--
-- TOC entry 5995 (class 2604 OID 16549)
-- Name: TRATTE id_tratta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE" ALTER COLUMN id_tratta SET DEFAULT nextval('public."TRATTE_id_tratta_seq"'::regclass);


--
-- TOC entry 6020 (class 2604 OID 16722)
-- Name: VALIDAZIONI id_validazione; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI" ALTER COLUMN id_validazione SET DEFAULT nextval('public."VALIDAZIONI_id_validazione_seq"'::regclass);


--
-- TOC entry 6011 (class 2604 OID 16688)
-- Name: VEICOLI id_veicolo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI" ALTER COLUMN id_veicolo SET DEFAULT nextval('public."VEICOLI_id_veicolo_seq"'::regclass);


--
-- TOC entry 6303 (class 0 OID 16492)
-- Dependencies: 229
-- Data for Name: BIGLIETTI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."BIGLIETTI" VALUES (1, 'BG101', 11, 1, '2025-11-16 18:01:00+01', '2025-11-17 08:00:00+01', '2025-11-17 22:00:00+01', 'ATTIVO', '2025-11-17 08:05:00+01', 42.00, 1);
INSERT INTO public."BIGLIETTI" VALUES (2, 'BG102', 12, 2, '2025-11-16 18:11:00+01', '2025-11-18 09:00:00+01', '2025-11-18 23:00:00+01', 'ATTIVO', '2025-11-18 09:10:00+01', 39.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (3, 'BG103', 12, 2, '2025-11-16 18:12:00+01', '2025-11-18 09:00:00+01', '2025-11-18 23:00:00+01', 'ATTIVO', '2025-11-18 09:10:00+01', 39.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (4, 'BG104', 13, 3, '2025-11-16 18:21:00+01', '2025-11-19 14:00:00+01', '2025-11-19 22:00:00+01', 'ATTIVO', '2025-11-19 14:05:00+01', 52.00, 3);
INSERT INTO public."BIGLIETTI" VALUES (5, 'BG105', 14, 4, '2025-11-16 18:31:00+01', '2025-11-20 18:30:00+01', '2025-11-21 23:00:00+01', 'ATTIVO', NULL, 87.00, 4);
INSERT INTO public."BIGLIETTI" VALUES (6, 'BG106', 15, 5, '2025-11-16 18:41:00+01', '2025-11-22 05:30:00+01', '2025-11-22 23:00:00+01', 'ATTIVO', NULL, 32.50, 5);
INSERT INTO public."BIGLIETTI" VALUES (7, 'BG107', 16, 6, '2025-11-16 18:51:00+01', '2025-11-23 13:00:00+01', '2025-11-23 23:00:00+01', 'ATTIVO', NULL, 44.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (8, 'BG108', 17, 7, '2025-11-16 19:01:00+01', '2025-11-24 07:00:00+01', '2025-11-24 23:00:00+01', 'ATTIVO', NULL, 56.00, 7);
INSERT INTO public."BIGLIETTI" VALUES (9, 'BG109', 18, 8, '2025-11-16 19:11:00+01', '2025-11-25 11:00:00+01', '2025-11-25 23:00:00+01', 'ATTIVO', NULL, 28.00, 8);
INSERT INTO public."BIGLIETTI" VALUES (10, 'BG110', 19, 9, '2025-11-16 19:21:00+01', '2025-11-26 17:40:00+01', '2025-11-26 23:00:00+01', 'ATTIVO', NULL, 67.00, 9);
INSERT INTO public."BIGLIETTI" VALUES (11, 'BG301', 21, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 1);
INSERT INTO public."BIGLIETTI" VALUES (12, 'BG302', 22, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (13, 'BG303', 22, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (14, 'BG304', 23, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 39.00, 3);
INSERT INTO public."BIGLIETTI" VALUES (15, 'BG305', 24, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 18:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 4);
INSERT INTO public."BIGLIETTI" VALUES (16, 'BG306', 24, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 18:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 4);
INSERT INTO public."BIGLIETTI" VALUES (17, 'BG307', 24, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 18:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 4);
INSERT INTO public."BIGLIETTI" VALUES (18, 'BG308', 25, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 05:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 5);
INSERT INTO public."BIGLIETTI" VALUES (19, 'BG309', 26, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 44.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (20, 'BG310', 26, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 44.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (21, 'BG311', 27, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.00, 7);
INSERT INTO public."BIGLIETTI" VALUES (22, 'BG312', 28, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 8);
INSERT INTO public."BIGLIETTI" VALUES (23, 'BG313', 28, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 8);
INSERT INTO public."BIGLIETTI" VALUES (24, 'BG314', 29, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 67.00, 9);
INSERT INTO public."BIGLIETTI" VALUES (25, 'BG315', 30, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 10);
INSERT INTO public."BIGLIETTI" VALUES (26, 'BG316', 30, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 10);
INSERT INTO public."BIGLIETTI" VALUES (27, 'BG317', 30, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 10);
INSERT INTO public."BIGLIETTI" VALUES (28, 'BG318', 30, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 10);
INSERT INTO public."BIGLIETTI" VALUES (29, 'BG319', 31, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 11);
INSERT INTO public."BIGLIETTI" VALUES (30, 'BG320', 32, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (31, 'BG321', 32, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (32, 'BG322', 33, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 12:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 71.00, 13);
INSERT INTO public."BIGLIETTI" VALUES (33, 'BG323', 34, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (34, 'BG324', 34, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (35, 'BG325', 34, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (36, 'BG326', 35, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 41.50, 15);
INSERT INTO public."BIGLIETTI" VALUES (37, 'BG327', 36, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 16);
INSERT INTO public."BIGLIETTI" VALUES (38, 'BG328', 36, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 16);
INSERT INTO public."BIGLIETTI" VALUES (39, 'BG329', 37, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.80, 17);
INSERT INTO public."BIGLIETTI" VALUES (40, 'BG330', 38, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (41, 'BG331', 38, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (42, 'BG332', 39, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 37.30, 19);
INSERT INTO public."BIGLIETTI" VALUES (43, 'BG333', 40, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (44, 'BG334', 40, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (45, 'BG335', 40, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (46, 'BG336', 41, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.30, 21);
INSERT INTO public."BIGLIETTI" VALUES (47, 'BG337', 42, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (48, 'BG338', 42, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (49, 'BG339', 43, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 10:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 24.00, 23);
INSERT INTO public."BIGLIETTI" VALUES (50, 'BG340', 44, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (51, 'BG341', 44, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (52, 'BG342', 45, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 79.40, 25);
INSERT INTO public."BIGLIETTI" VALUES (53, 'BG343', 46, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (54, 'BG344', 46, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (55, 'BG345', 46, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (56, 'BG346', 47, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.10, 27);
INSERT INTO public."BIGLIETTI" VALUES (57, 'BG347', 48, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (58, 'BG348', 48, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (59, 'BG349', 49, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 29.00, 29);
INSERT INTO public."BIGLIETTI" VALUES (60, 'BG350', 50, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (61, 'BG351', 50, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (62, 'BG352', 50, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (63, 'BG353', 50, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (64, 'BG354', 51, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.30, 31);
INSERT INTO public."BIGLIETTI" VALUES (65, 'BG355', 52, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 32);
INSERT INTO public."BIGLIETTI" VALUES (66, 'BG356', 52, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 32);
INSERT INTO public."BIGLIETTI" VALUES (67, 'BG357', 53, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 24.00, 33);
INSERT INTO public."BIGLIETTI" VALUES (68, 'BG358', 54, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 34);
INSERT INTO public."BIGLIETTI" VALUES (69, 'BG359', 54, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 34);
INSERT INTO public."BIGLIETTI" VALUES (70, 'BG360', 55, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 79.40, 35);
INSERT INTO public."BIGLIETTI" VALUES (71, 'BG361', 56, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 36);
INSERT INTO public."BIGLIETTI" VALUES (72, 'BG362', 56, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 36);
INSERT INTO public."BIGLIETTI" VALUES (73, 'BG363', 56, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 36);
INSERT INTO public."BIGLIETTI" VALUES (74, 'BG364', 57, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.80, 37);
INSERT INTO public."BIGLIETTI" VALUES (75, 'BG365', 58, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 19:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 38);
INSERT INTO public."BIGLIETTI" VALUES (76, 'BG366', 58, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 19:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 38);
INSERT INTO public."BIGLIETTI" VALUES (77, 'BG367', 59, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 37.30, 39);
INSERT INTO public."BIGLIETTI" VALUES (78, 'BG368', 60, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 40);
INSERT INTO public."BIGLIETTI" VALUES (79, 'BG369', 60, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 40);
INSERT INTO public."BIGLIETTI" VALUES (80, 'BG370', 60, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 40);
INSERT INTO public."BIGLIETTI" VALUES (81, 'BG371', 60, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 40);
INSERT INTO public."BIGLIETTI" VALUES (82, 'BG372', 61, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 05:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 41);
INSERT INTO public."BIGLIETTI" VALUES (83, 'BG373', 62, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 42);
INSERT INTO public."BIGLIETTI" VALUES (84, 'BG374', 62, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 42);
INSERT INTO public."BIGLIETTI" VALUES (85, 'BG375', 63, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 71.00, 43);
INSERT INTO public."BIGLIETTI" VALUES (86, 'BG376', 64, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 44);
INSERT INTO public."BIGLIETTI" VALUES (87, 'BG377', 64, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 44);
INSERT INTO public."BIGLIETTI" VALUES (88, 'BG378', 64, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 34.30, 44);
INSERT INTO public."BIGLIETTI" VALUES (89, 'BG379', 65, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 41.50, 45);
INSERT INTO public."BIGLIETTI" VALUES (90, 'BG380', 66, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 46);
INSERT INTO public."BIGLIETTI" VALUES (91, 'BG381', 66, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 46);
INSERT INTO public."BIGLIETTI" VALUES (92, 'BG382', 67, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 47);
INSERT INTO public."BIGLIETTI" VALUES (93, 'BG383', 68, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 48);
INSERT INTO public."BIGLIETTI" VALUES (94, 'BG384', 68, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 48);
INSERT INTO public."BIGLIETTI" VALUES (95, 'BG385', 69, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 37.30, 49);
INSERT INTO public."BIGLIETTI" VALUES (96, 'BG386', 70, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 50);
INSERT INTO public."BIGLIETTI" VALUES (97, 'BG387', 70, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 50);
INSERT INTO public."BIGLIETTI" VALUES (98, 'BG388', 70, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 50);
INSERT INTO public."BIGLIETTI" VALUES (99, 'BG389', 70, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 62.00, 50);
INSERT INTO public."BIGLIETTI" VALUES (100, 'BG390', 71, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.30, 1);
INSERT INTO public."BIGLIETTI" VALUES (101, 'BG391', 72, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 2);
INSERT INTO public."BIGLIETTI" VALUES (102, 'BG392', 72, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 2);
INSERT INTO public."BIGLIETTI" VALUES (103, 'BG393', 73, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 24.00, 3);
INSERT INTO public."BIGLIETTI" VALUES (104, 'BG394', 74, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 4);
INSERT INTO public."BIGLIETTI" VALUES (105, 'BG395', 74, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 16:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 4);
INSERT INTO public."BIGLIETTI" VALUES (106, 'BG396', 75, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 79.40, 5);
INSERT INTO public."BIGLIETTI" VALUES (107, 'BG397', 76, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (108, 'BG398', 76, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (109, 'BG399', 76, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:25:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 83.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (110, 'BG400', 77, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.80, 7);
INSERT INTO public."BIGLIETTI" VALUES (111, 'BG401', 78, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 19:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 8);
INSERT INTO public."BIGLIETTI" VALUES (112, 'BG402', 78, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 19:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 28.00, 8);
INSERT INTO public."BIGLIETTI" VALUES (113, 'BG403', 79, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 37.30, 9);
INSERT INTO public."BIGLIETTI" VALUES (114, 'BG404', 80, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 10);
INSERT INTO public."BIGLIETTI" VALUES (115, 'BG405', 80, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 10);
INSERT INTO public."BIGLIETTI" VALUES (116, 'BG406', 80, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 10);
INSERT INTO public."BIGLIETTI" VALUES (117, 'BG407', 80, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 10);
INSERT INTO public."BIGLIETTI" VALUES (118, 'BG408', 81, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 41.50, 11);
INSERT INTO public."BIGLIETTI" VALUES (119, 'BG409', 82, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (120, 'BG410', 82, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (121, 'BG411', 83, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 71.00, 13);
INSERT INTO public."BIGLIETTI" VALUES (122, 'BG412', 84, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 14);
INSERT INTO public."BIGLIETTI" VALUES (123, 'BG413', 84, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 14);
INSERT INTO public."BIGLIETTI" VALUES (124, 'BG414', 84, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 14);
INSERT INTO public."BIGLIETTI" VALUES (125, 'BG415', 85, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 41.50, 15);
INSERT INTO public."BIGLIETTI" VALUES (126, 'BG416', 86, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 16);
INSERT INTO public."BIGLIETTI" VALUES (127, 'BG417', 86, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:10:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 49.00, 16);
INSERT INTO public."BIGLIETTI" VALUES (128, 'BG418', 87, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.00, 17);
INSERT INTO public."BIGLIETTI" VALUES (129, 'BG419', 88, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (130, 'BG420', 88, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 56.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (131, 'BG421', 89, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 67.00, 19);
INSERT INTO public."BIGLIETTI" VALUES (132, 'BG422', 90, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 20);
INSERT INTO public."BIGLIETTI" VALUES (133, 'BG423', 90, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 20);
INSERT INTO public."BIGLIETTI" VALUES (134, 'BG424', 90, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 20);
INSERT INTO public."BIGLIETTI" VALUES (135, 'BG425', 90, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 22.50, 20);
INSERT INTO public."BIGLIETTI" VALUES (136, 'BG426', 91, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.30, 21);
INSERT INTO public."BIGLIETTI" VALUES (137, 'BG427', 92, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (138, 'BG428', 92, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (139, 'BG429', 93, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 10:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 24.00, 23);
INSERT INTO public."BIGLIETTI" VALUES (140, 'BG430', 94, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (141, 'BG431', 94, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (142, 'BG432', 95, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 79.40, 25);
INSERT INTO public."BIGLIETTI" VALUES (143, 'BG433', 96, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (144, 'BG434', 96, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (145, 'BG435', 96, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 15:05:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (146, 'BG436', 97, 3, '2025-12-14 13:53:00.169346+01', '2025-12-08 07:45:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 72.10, 27);
INSERT INTO public."BIGLIETTI" VALUES (147, 'BG437', 98, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (148, 'BG438', 98, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 13:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (149, 'BG439', 99, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 06:40:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 29.00, 29);
INSERT INTO public."BIGLIETTI" VALUES (150, 'BG440', 100, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (151, 'BG441', 100, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (152, 'BG442', 100, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (153, 'BG443', 100, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:30:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (154, 'BG444', 101, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 08:15:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 11);
INSERT INTO public."BIGLIETTI" VALUES (155, 'BG445', 102, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (156, 'BG446', 102, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 11:00:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 42.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (157, 'BG447', 103, 2, '2025-12-14 13:53:00.169346+01', '2025-12-08 09:35:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 39.00, 13);
INSERT INTO public."BIGLIETTI" VALUES (158, 'BG448', 104, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 14);
INSERT INTO public."BIGLIETTI" VALUES (159, 'BG449', 104, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 14:50:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 14);
INSERT INTO public."BIGLIETTI" VALUES (160, 'BG450', 105, 1, '2025-12-14 13:53:00.169346+01', '2025-12-08 17:20:00+01', '2025-12-08 23:59:00+01', 'ATTIVO', NULL, 52.00, 15);
INSERT INTO public."BIGLIETTI" VALUES (161, 'BGG121001', 121, 1, '2025-11-09 09:30:00+01', '2025-11-09 07:00:00+01', '2025-11-10 00:59:00+01', 'ATTIVO', NULL, 42.00, 1);
INSERT INTO public."BIGLIETTI" VALUES (162, 'BGG122001', 122, 2, '2025-11-10 10:30:00+01', '2025-11-10 07:00:00+01', '2025-11-11 00:59:00+01', 'ATTIVO', NULL, 39.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (163, 'BGG122002', 122, 2, '2025-11-10 10:30:00+01', '2025-11-10 07:00:00+01', '2025-11-11 00:59:00+01', 'ATTIVO', NULL, 39.00, 2);
INSERT INTO public."BIGLIETTI" VALUES (164, 'BGG123001', 123, 3, '2025-11-11 11:30:00+01', '2025-11-11 07:00:00+01', '2025-11-12 00:59:00+01', 'ATTIVO', NULL, 52.00, 3);
INSERT INTO public."BIGLIETTI" VALUES (165, 'BGG124001', 124, 4, '2025-11-12 10:00:00+01', '2025-11-12 07:00:00+01', '2025-11-13 00:59:00+01', 'ATTIVO', NULL, 43.50, 4);
INSERT INTO public."BIGLIETTI" VALUES (166, 'BGG124002', 124, 4, '2025-11-12 10:00:00+01', '2025-11-12 07:00:00+01', '2025-11-13 00:59:00+01', 'ATTIVO', NULL, 43.50, 4);
INSERT INTO public."BIGLIETTI" VALUES (167, 'BGG125001', 125, 5, '2025-11-13 11:00:00+01', '2025-11-13 07:00:00+01', '2025-11-14 00:59:00+01', 'ATTIVO', NULL, 32.50, 5);
INSERT INTO public."BIGLIETTI" VALUES (168, 'BGG126001', 126, 6, '2025-11-14 12:00:00+01', '2025-11-14 07:00:00+01', '2025-11-15 00:59:00+01', 'ATTIVO', NULL, 22.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (169, 'BGG126002', 126, 6, '2025-11-14 12:00:00+01', '2025-11-14 07:00:00+01', '2025-11-15 00:59:00+01', 'ATTIVO', NULL, 22.00, 6);
INSERT INTO public."BIGLIETTI" VALUES (170, 'BGG127001', 127, 7, '2025-11-15 09:30:00+01', '2025-11-15 07:00:00+01', '2025-11-16 00:59:00+01', 'ATTIVO', NULL, 56.00, 7);
INSERT INTO public."BIGLIETTI" VALUES (171, 'BGG128001', 128, 8, '2025-11-16 10:30:00+01', '2025-11-16 07:00:00+01', '2025-11-17 00:59:00+01', 'ATTIVO', NULL, 18.67, 8);
INSERT INTO public."BIGLIETTI" VALUES (172, 'BGG128002', 128, 8, '2025-11-16 10:30:00+01', '2025-11-16 07:00:00+01', '2025-11-17 00:59:00+01', 'ATTIVO', NULL, 18.67, 8);
INSERT INTO public."BIGLIETTI" VALUES (173, 'BGG128003', 128, 8, '2025-11-16 10:30:00+01', '2025-11-16 07:00:00+01', '2025-11-17 00:59:00+01', 'ATTIVO', NULL, 18.66, 8);
INSERT INTO public."BIGLIETTI" VALUES (174, 'BGG129001', 129, 9, '2025-11-17 11:30:00+01', '2025-11-17 07:00:00+01', '2025-11-18 00:59:00+01', 'ATTIVO', NULL, 67.00, 9);
INSERT INTO public."BIGLIETTI" VALUES (175, 'BGG130001', 130, 1, '2025-11-18 10:00:00+01', '2025-11-18 07:00:00+01', '2025-11-19 00:59:00+01', 'ATTIVO', NULL, 11.25, 10);
INSERT INTO public."BIGLIETTI" VALUES (176, 'BGG130002', 130, 1, '2025-11-18 10:00:00+01', '2025-11-18 07:00:00+01', '2025-11-19 00:59:00+01', 'ATTIVO', NULL, 11.25, 10);
INSERT INTO public."BIGLIETTI" VALUES (177, 'BGG131001', 131, 2, '2025-11-19 11:00:00+01', '2025-11-19 07:00:00+01', '2025-11-20 00:59:00+01', 'ATTIVO', NULL, 59.00, 11);
INSERT INTO public."BIGLIETTI" VALUES (178, 'BGG132001', 132, 3, '2025-11-20 12:00:00+01', '2025-11-20 07:00:00+01', '2025-11-21 00:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (179, 'BGG132002', 132, 3, '2025-11-20 12:00:00+01', '2025-11-20 07:00:00+01', '2025-11-21 00:59:00+01', 'ATTIVO', NULL, 46.00, 12);
INSERT INTO public."BIGLIETTI" VALUES (180, 'BGG133001', 133, 4, '2025-11-21 09:30:00+01', '2025-11-21 07:00:00+01', '2025-11-22 00:59:00+01', 'ATTIVO', NULL, 71.00, 13);
INSERT INTO public."BIGLIETTI" VALUES (181, 'BGG134001', 134, 5, '2025-11-22 10:30:00+01', '2025-11-22 07:00:00+01', '2025-11-23 00:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (182, 'BGG134002', 134, 5, '2025-11-22 10:30:00+01', '2025-11-22 07:00:00+01', '2025-11-23 00:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (183, 'BGG134003', 134, 5, '2025-11-22 10:30:00+01', '2025-11-22 07:00:00+01', '2025-11-23 00:59:00+01', 'ATTIVO', NULL, 34.30, 14);
INSERT INTO public."BIGLIETTI" VALUES (184, 'BGG135001', 135, 6, '2025-11-23 11:30:00+01', '2025-11-23 07:00:00+01', '2025-11-24 00:59:00+01', 'ATTIVO', NULL, 34.30, 15);
INSERT INTO public."BIGLIETTI" VALUES (185, 'BGG136001', 136, 7, '2025-11-24 10:00:00+01', '2025-11-24 07:00:00+01', '2025-11-25 00:59:00+01', 'ATTIVO', NULL, 41.50, 16);
INSERT INTO public."BIGLIETTI" VALUES (186, 'BGG136002', 136, 7, '2025-11-24 10:00:00+01', '2025-11-24 07:00:00+01', '2025-11-25 00:59:00+01', 'ATTIVO', NULL, 41.50, 16);
INSERT INTO public."BIGLIETTI" VALUES (187, 'BGG137001', 137, 8, '2025-11-25 11:00:00+01', '2025-11-25 07:00:00+01', '2025-11-26 00:59:00+01', 'ATTIVO', NULL, 56.80, 17);
INSERT INTO public."BIGLIETTI" VALUES (188, 'BGG138001', 138, 9, '2025-11-26 12:00:00+01', '2025-11-26 07:00:00+01', '2025-11-27 00:59:00+01', 'ATTIVO', NULL, 28.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (189, 'BGG138002', 138, 9, '2025-11-26 12:00:00+01', '2025-11-26 07:00:00+01', '2025-11-27 00:59:00+01', 'ATTIVO', NULL, 28.00, 18);
INSERT INTO public."BIGLIETTI" VALUES (190, 'BGG139001', 139, 1, '2025-11-27 09:30:00+01', '2025-11-27 07:00:00+01', '2025-11-28 00:59:00+01', 'ATTIVO', NULL, 37.30, 19);
INSERT INTO public."BIGLIETTI" VALUES (191, 'BGG140001', 140, 2, '2025-11-28 10:30:00+01', '2025-11-28 07:00:00+01', '2025-11-29 00:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (192, 'BGG140002', 140, 2, '2025-11-28 10:30:00+01', '2025-11-28 07:00:00+01', '2025-11-29 00:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (193, 'BGG140003', 140, 2, '2025-11-28 10:30:00+01', '2025-11-28 07:00:00+01', '2025-11-29 00:59:00+01', 'ATTIVO', NULL, 62.00, 20);
INSERT INTO public."BIGLIETTI" VALUES (194, 'BGG141001', 141, 3, '2025-11-29 11:30:00+01', '2025-11-29 07:00:00+01', '2025-11-30 00:59:00+01', 'ATTIVO', NULL, 72.30, 21);
INSERT INTO public."BIGLIETTI" VALUES (195, 'BGG142001', 142, 4, '2025-11-30 10:00:00+01', '2025-11-30 07:00:00+01', '2025-12-01 00:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (196, 'BGG142002', 142, 4, '2025-11-30 10:00:00+01', '2025-11-30 07:00:00+01', '2025-12-01 00:59:00+01', 'ATTIVO', NULL, 21.90, 22);
INSERT INTO public."BIGLIETTI" VALUES (197, 'BGG143001', 143, 5, '2025-12-01 11:00:00+01', '2025-12-01 07:00:00+01', '2025-12-02 00:59:00+01', 'ATTIVO', NULL, 24.00, 23);
INSERT INTO public."BIGLIETTI" VALUES (198, 'BGG144001', 144, 6, '2025-12-02 12:00:00+01', '2025-12-02 07:00:00+01', '2025-12-03 00:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (199, 'BGG144002', 144, 6, '2025-12-02 12:00:00+01', '2025-12-02 07:00:00+01', '2025-12-03 00:59:00+01', 'ATTIVO', NULL, 36.20, 24);
INSERT INTO public."BIGLIETTI" VALUES (200, 'BGG145001', 145, 7, '2025-12-03 09:30:00+01', '2025-12-03 07:00:00+01', '2025-12-04 00:59:00+01', 'ATTIVO', NULL, 79.40, 25);
INSERT INTO public."BIGLIETTI" VALUES (201, 'BGG146001', 146, 8, '2025-12-04 10:30:00+01', '2025-12-04 07:00:00+01', '2025-12-05 00:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (202, 'BGG146002', 146, 8, '2025-12-04 10:30:00+01', '2025-12-04 07:00:00+01', '2025-12-05 00:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (203, 'BGG146003', 146, 8, '2025-12-04 10:30:00+01', '2025-12-04 07:00:00+01', '2025-12-05 00:59:00+01', 'ATTIVO', NULL, 63.00, 26);
INSERT INTO public."BIGLIETTI" VALUES (204, 'BGG147001', 147, 9, '2025-12-05 11:30:00+01', '2025-12-05 07:00:00+01', '2025-12-06 00:59:00+01', 'ATTIVO', NULL, 72.10, 27);
INSERT INTO public."BIGLIETTI" VALUES (205, 'BGG148001', 148, 1, '2025-12-06 10:00:00+01', '2025-12-06 07:00:00+01', '2025-12-07 00:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (206, 'BGG148002', 148, 1, '2025-12-06 10:00:00+01', '2025-12-06 07:00:00+01', '2025-12-07 00:59:00+01', 'ATTIVO', NULL, 21.40, 28);
INSERT INTO public."BIGLIETTI" VALUES (207, 'BGG149001', 149, 2, '2025-12-07 11:00:00+01', '2025-12-07 07:00:00+01', '2025-12-08 00:59:00+01', 'ATTIVO', NULL, 29.00, 29);
INSERT INTO public."BIGLIETTI" VALUES (208, 'BGG150001', 150, 3, '2025-12-08 12:00:00+01', '2025-12-08 07:00:00+01', '2025-12-09 00:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (209, 'BGG150002', 150, 3, '2025-12-08 12:00:00+01', '2025-12-08 07:00:00+01', '2025-12-09 00:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (210, 'BGG150003', 150, 3, '2025-12-08 12:00:00+01', '2025-12-08 07:00:00+01', '2025-12-09 00:59:00+01', 'ATTIVO', NULL, 59.00, 30);
INSERT INTO public."BIGLIETTI" VALUES (211, 'BGG150004', 150, 3, '2025-12-08 12:00:00+01', '2025-12-08 07:00:00+01', '2025-12-09 00:59:00+01', 'ATTIVO', NULL, 59.00, 30);


--
-- TOC entry 6318 (class 0 OID 16703)
-- Dependencies: 244
-- Data for Name: OPERATORI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."OPERATORI" VALUES (1, 'OPE001', 'CONTROLLORE', 'Giuseppe', 'Sanna', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" VALUES (2, 'OPE002', 'CAPOTRENO', 'Elena', 'Mannucci', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" VALUES (3, 'OPE003', 'CONTROLLORE', 'Marco', 'Vitale', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" VALUES (4, 'OPE004', 'CONTROLLORE', 'Chiara', 'Brunetti', false, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" VALUES (5, 'OPE005', 'CAPOTRENO', 'Alessandro', 'Ferri', true, '2025-11-08 20:08:02.730912+01');
INSERT INTO public."OPERATORI" VALUES (6, 'OPE006', 'CONTROLLORE', 'Serena', 'Redaelli', true, '2025-11-08 20:08:02.730912+01');


--
-- TOC entry 6310 (class 0 OID 16596)
-- Dependencies: 236
-- Data for Name: ORARI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ORARI" VALUES (1, 'OR202511081', '2025-11-09 07:30:00+01', '2025-11-09 10:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-09', '2025-12-31', 'ATTIVO', 'Frecciarossa 9500 Milano-Roma');
INSERT INTO public."ORARI" VALUES (2, 'OR202511082', '2025-11-09 09:00:00+01', '2025-11-09 11:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 2, 2, '2025-11-09', NULL, 'ATTIVO', 'Italo 9902 Napoli-Roma');
INSERT INTO public."ORARI" VALUES (3, 'OR202511083', '2025-11-09 08:45:00+01', '2025-11-09 12:45:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 3, '2025-11-09', NULL, 'ATTIVO', 'Intercity 783 Venezia-Bologna');
INSERT INTO public."ORARI" VALUES (4, 'OR202511084', '2025-11-09 18:00:00+01', '2025-11-09 20:45:00+01', '2025-11-08 19:42:24.044553+01', 1, 4, 4, '2025-11-09', '2025-11-30', 'ATTIVO', 'Regionale 225 Firenze-Pisa');
INSERT INTO public."ORARI" VALUES (5, 'OR202511085', '2025-11-10 05:30:00+01', '2025-11-10 08:05:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 5, '2025-11-10', NULL, 'ATTIVO', 'Frecciargento 8400 Torino-Venezia');
INSERT INTO public."ORARI" VALUES (6, 'OR202511086', '2025-11-10 13:00:00+01', '2025-11-10 15:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 6, 2, '2025-11-10', '2025-12-01', 'ATTIVO', 'Regionale 220 Roma-Ancona');
INSERT INTO public."ORARI" VALUES (7, 'OR202511087', '2025-11-11 07:00:00+01', '2025-11-11 09:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-11', NULL, 'ATTIVO', 'Frecciarossa 9600 Milano-Roma');
INSERT INTO public."ORARI" VALUES (8, 'OR202511088', '2025-11-11 11:10:00+01', '2025-11-11 13:35:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 4, '2025-11-11', NULL, 'ATTIVO', 'Regionale 300 Ravenna-Bologna');
INSERT INTO public."ORARI" VALUES (9, 'OR202511089', '2025-11-11 17:40:00+01', '2025-11-11 21:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 3, '2025-11-11', NULL, 'ATTIVO', 'Intercity 9140 Palermo-Napoli');
INSERT INTO public."ORARI" VALUES (10, 'OR2025110810', '2025-11-12 06:05:00+01', '2025-11-12 09:25:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 2, '2025-11-12', '2025-12-31', 'ATTIVO', 'Frecciargento 8300 Venezia-Perugia');
INSERT INTO public."ORARI" VALUES (11, 'OR2025110811', '2025-11-12 14:00:00+01', '2025-11-12 17:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 9, 4, '2025-11-12', NULL, 'ATTIVO', 'Frecciarossa 9100 Bologna-Napoli');
INSERT INTO public."ORARI" VALUES (12, 'OR2025110812', '2025-11-13 08:00:00+01', '2025-11-13 10:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 2, 5, '2025-11-13', NULL, 'ATTIVO', 'Italo 9824 Milano-Firenze');
INSERT INTO public."ORARI" VALUES (13, 'OR2025110813', '2025-11-13 12:10:00+01', '2025-11-13 14:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 10, 3, '2025-11-13', '2025-11-30', 'ATTIVO', 'Regionale 330 Genoa-La Spezia');
INSERT INTO public."ORARI" VALUES (14, 'OR2025110814', '2025-11-14 16:00:00+01', '2025-11-14 19:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 6, 2, '2025-11-14', NULL, 'ATTIVO', 'Regionale 210 Bari-Foggia');
INSERT INTO public."ORARI" VALUES (15, 'OR2025110815', '2025-11-14 17:25:00+01', '2025-11-14 19:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 1, '2025-11-14', NULL, 'ATTIVO', 'Frecciargento 8500 Torino-Napoli');
INSERT INTO public."ORARI" VALUES (16, 'OR2025110816', '2025-11-15 09:10:00+01', '2025-11-15 11:50:00+01', '2025-11-08 19:42:24.044553+01', 1, 8, 5, '2025-11-15', NULL, 'ATTIVO', 'Frecciarossa 9750 Verona-Roma');
INSERT INTO public."ORARI" VALUES (17, 'OR2025110817', '2025-11-15 15:30:00+01', '2025-11-15 16:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 1, '2025-11-15', NULL, 'ATTIVO', 'Regionale 150 Napoli-Salerno');
INSERT INTO public."ORARI" VALUES (18, 'OR2025110818', '2025-11-16 06:30:00+01', '2025-11-16 09:00:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 2, '2025-11-16', NULL, 'ATTIVO', 'Frecciarossa 9604 Milano-Roma');
INSERT INTO public."ORARI" VALUES (19, 'OR2025110819', '2025-11-16 11:50:00+01', '2025-11-16 14:15:00+01', '2025-11-08 19:42:24.044553+01', 2, 9, 4, '2025-11-16', NULL, 'ATTIVO', 'Frecciarossa 9111 Bologna-Napoli');
INSERT INTO public."ORARI" VALUES (20, 'OR2025110820', '2025-11-17 07:20:00+01', '2025-11-17 08:54:00+01', '2025-11-08 19:42:24.044553+01', 3, 4, 3, '2025-11-17', NULL, 'ATTIVO', 'Regionale 155 Pisa-Siena');
INSERT INTO public."ORARI" VALUES (21, 'OR2025110821', '2025-11-17 14:15:00+01', '2025-11-17 16:47:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 5, '2025-11-17', '2025-11-30', 'ATTIVO', 'Intercity 7904 Roma-Milano');
INSERT INTO public."ORARI" VALUES (22, 'OR2025110822', '2025-11-18 06:50:00+01', '2025-11-18 08:51:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 1, '2025-11-18', NULL, 'ATTIVO', 'Italo 9920 Napoli-Firenze');
INSERT INTO public."ORARI" VALUES (23, 'OR2025110823', '2025-11-18 10:20:00+01', '2025-11-18 13:00:00+01', '2025-11-08 19:42:24.044553+01', 2, 3, 4, '2025-11-18', NULL, 'ATTIVO', 'Intercity 874 Milano-Venezia');
INSERT INTO public."ORARI" VALUES (24, 'OR2025110824', '2025-11-19 09:35:00+01', '2025-11-19 11:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 10, 2, '2025-11-19', NULL, 'ATTIVO', 'Regionale 340 La Spezia-Pisa');
INSERT INTO public."ORARI" VALUES (25, 'OR2025110825', '2025-11-19 11:50:00+01', '2025-11-19 14:35:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 3, '2025-11-19', NULL, 'ATTIVO', 'Frecciargento 8120 Perugia-Bari');
INSERT INTO public."ORARI" VALUES (26, 'OR2025110826', '2025-11-19 15:05:00+01', '2025-11-19 18:05:00+01', '2025-11-08 19:42:24.044553+01', 1, 6, 4, '2025-11-19', NULL, 'ATTIVO', 'Frecciarossa 9800 Ancona-Roma');
INSERT INTO public."ORARI" VALUES (27, 'OR2025110827', '2025-11-20 07:45:00+01', '2025-11-20 09:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 7, 5, '2025-11-20', NULL, 'ATTIVO', 'Regionale 130 Caserta-Napoli');
INSERT INTO public."ORARI" VALUES (28, 'OR2025110828', '2025-11-20 13:30:00+01', '2025-11-20 14:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 4, 4, '2025-11-20', NULL, 'ATTIVO', 'Regionale 160 Pisa-Livorno');
INSERT INTO public."ORARI" VALUES (29, 'OR2025110829', '2025-11-21 06:40:00+01', '2025-11-21 09:15:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 2, '2025-11-21', '2025-12-15', 'ATTIVO', 'Frecciarossa 9506 Milano-Roma');
INSERT INTO public."ORARI" VALUES (30, 'OR2025110830', '2025-11-21 17:30:00+01', '2025-11-21 20:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 1, '2025-11-21', NULL, 'ATTIVO', 'Frecciargento 8502 Torino-Firenze');
INSERT INTO public."ORARI" VALUES (31, 'OR2025110831', '2025-11-22 08:15:00+01', '2025-11-22 09:55:00+01', '2025-11-08 19:42:24.044553+01', 3, 2, 3, '2025-11-22', NULL, 'ATTIVO', 'Italo 9930 Napoli-Milano');
INSERT INTO public."ORARI" VALUES (32, 'OR2025110832', '2025-11-22 11:00:00+01', '2025-11-22 13:35:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 4, '2025-11-22', NULL, 'ATTIVO', 'Regionale 345 Perugia-Assisi');
INSERT INTO public."ORARI" VALUES (33, 'OR2025110833', '2025-11-23 07:30:00+01', '2025-11-23 09:20:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 2, '2025-11-23', NULL, 'ATTIVO', 'Frecciargento 8200 La Spezia-Milano');
INSERT INTO public."ORARI" VALUES (34, 'OR2025110834', '2025-11-23 16:40:00+01', '2025-11-23 18:45:00+01', '2025-11-08 19:42:24.044553+01', 3, 3, 1, '2025-11-23', NULL, 'ATTIVO', 'Intercity 850 Venezia-Trieste');
INSERT INTO public."ORARI" VALUES (35, 'OR2025110835', '2025-11-24 08:20:00+01', '2025-11-24 09:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 5, 3, '2025-11-24', NULL, 'ATTIVO', 'Regionale 175 Torino-Asti');
INSERT INTO public."ORARI" VALUES (36, 'OR2025110836', '2025-11-24 11:25:00+01', '2025-11-24 14:15:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 5, '2025-11-24', NULL, 'ATTIVO', 'Frecciarossa 9200 Milano-Firenze');
INSERT INTO public."ORARI" VALUES (37, 'OR2025110837', '2025-11-25 15:00:00+01', '2025-11-25 17:00:00+01', '2025-11-08 19:42:24.044553+01', 3, 4, 2, '2025-11-25', NULL, 'ATTIVO', 'Regionale 200 Pisa-Firenze');
INSERT INTO public."ORARI" VALUES (38, 'OR2025110838', '2025-11-25 19:30:00+01', '2025-11-25 21:45:00+01', '2025-11-08 19:42:24.044553+01', 2, 8, 4, '2025-11-25', NULL, 'ATTIVO', 'Regionale 355 Assisi-Perugia');
INSERT INTO public."ORARI" VALUES (39, 'OR2025110839', '2025-11-26 09:30:00+01', '2025-11-26 12:10:00+01', '2025-11-08 19:42:24.044553+01', 1, 1, 1, '2025-11-26', NULL, 'ATTIVO', 'Frecciarossa 9400 Milano-Roma');
INSERT INTO public."ORARI" VALUES (40, 'OR2025110840', '2025-11-26 13:45:00+01', '2025-11-26 16:50:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 2, '2025-11-26', NULL, 'ATTIVO', 'Intercity 9200 Napoli-Palermo');
INSERT INTO public."ORARI" VALUES (41, 'OR2025110841', '2025-11-27 05:30:00+01', '2025-11-27 08:10:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 4, '2025-11-27', NULL, 'ATTIVO', 'Frecciargento 8340 Torino-Bari');
INSERT INTO public."ORARI" VALUES (42, 'OR2025110842', '2025-11-27 08:00:00+01', '2025-11-27 10:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 3, '2025-11-27', NULL, 'ATTIVO', 'Regionale 202 Milano-La Spezia');
INSERT INTO public."ORARI" VALUES (43, 'OR2025110843', '2025-11-28 09:35:00+01', '2025-11-28 10:55:00+01', '2025-11-08 19:42:24.044553+01', 2, 6, 5, '2025-11-28', NULL, 'ATTIVO', 'Regionale 218 Ancona-Fermo');
INSERT INTO public."ORARI" VALUES (44, 'OR2025110844', '2025-11-28 14:50:00+01', '2025-11-28 18:10:00+01', '2025-11-08 19:42:24.044553+01', 2, 7, 1, '2025-11-28', NULL, 'ATTIVO', 'Intercity 9310 Palermo-Roma');
INSERT INTO public."ORARI" VALUES (45, 'OR2025110845', '2025-11-29 17:20:00+01', '2025-11-29 20:35:00+01', '2025-11-08 19:42:24.044553+01', 3, 5, 2, '2025-11-29', NULL, 'ATTIVO', 'Regionale 228 Torino-Aosta');
INSERT INTO public."ORARI" VALUES (46, 'OR2025110846', '2025-11-29 19:50:00+01', '2025-11-29 23:30:00+01', '2025-11-08 19:42:24.044553+01', 1, 2, 4, '2025-11-29', NULL, 'ATTIVO', 'Frecciarossa 9000 Milano-Napoli');
INSERT INTO public."ORARI" VALUES (47, 'OR2025110847', '2025-11-30 09:00:00+01', '2025-11-30 11:30:00+01', '2025-11-08 19:42:24.044553+01', 2, 4, 5, '2025-11-30', '2025-12-30', 'ATTIVO', 'Regionale 169 Pisa-Livorno');
INSERT INTO public."ORARI" VALUES (48, 'OR2025110848', '2025-11-30 13:30:00+01', '2025-11-30 15:50:00+01', '2025-11-08 19:42:24.044553+01', 3, 10, 3, '2025-11-30', NULL, 'ATTIVO', 'Regionale 310 La Spezia-Genova');
INSERT INTO public."ORARI" VALUES (49, 'OR2025110849', '2025-12-01 06:45:00+01', '2025-12-01 09:20:00+01', '2025-11-08 19:42:24.044553+01', 1, 10, 2, '2025-12-01', NULL, 'ATTIVO', 'Frecciargento 8122 Milano-Bari');
INSERT INTO public."ORARI" VALUES (50, 'OR2025110850', '2025-12-01 19:00:00+01', '2025-12-01 22:00:00+01', '2025-11-08 19:42:24.044553+01', 2, 1, 4, '2025-12-01', '2026-01-31', 'ATTIVO', 'Frecciarossa 9002 Roma-Milano');


--
-- TOC entry 6314 (class 0 OID 16659)
-- Dependencies: 240
-- Data for Name: PAGAMENTI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PAGAMENTI" VALUES (1, 11, 'TX101', 42.00, 1.00, 'Carta di credito', '2025-11-16 18:05:00+01', 'COMPLETATO', 'Pagamento online');
INSERT INTO public."PAGAMENTI" VALUES (2, 12, 'TX102', 78.00, 2.50, 'PayPal', '2025-11-16 18:12:00+01', 'COMPLETATO', 'Pagamento confermato via PayPal');
INSERT INTO public."PAGAMENTI" VALUES (3, 13, 'TX103', 52.00, 0.80, 'Carta di credito', '2025-11-16 18:22:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (4, 14, 'TX104', 87.00, 1.90, 'Bonifico', '2025-11-16 18:32:00+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (5, 15, 'TX105', 32.50, 0.60, 'Carta di credito', '2025-11-16 18:42:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (6, 16, 'TX106', 44.00, 1.10, 'Bancomat', '2025-11-16 18:52:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (7, 17, 'TX107', 56.00, 1.50, 'Contanti', '2025-11-16 19:02:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (8, 18, 'TX108', 28.00, 0.30, 'Carta di credito', '2025-11-16 19:12:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (9, 19, 'TX109', 67.00, 2.00, 'PayPal', '2025-11-16 19:22:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (10, 20, 'TX110', 22.50, 0.15, 'PayPal', '2025-11-16 19:32:00+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (11, 21, 'TX301', 42.00, 1.26, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento online');
INSERT INTO public."PAGAMENTI" VALUES (12, 22, 'TX302', 84.00, 2.52, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento confermato');
INSERT INTO public."PAGAMENTI" VALUES (13, 23, 'TX303', 39.00, 1.17, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (14, 24, 'TX304', 156.00, 4.68, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (15, 25, 'TX305', 52.00, 1.56, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (16, 26, 'TX306', 88.00, 2.64, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (17, 27, 'TX307', 56.00, 1.68, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (18, 28, 'TX308', 56.00, 1.68, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (19, 29, 'TX309', 67.00, 2.01, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (20, 30, 'TX310', 90.00, 2.70, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (21, 31, 'TX311', 59.00, 1.77, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (22, 32, 'TX312', 92.00, 2.76, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (23, 33, 'TX313', 71.00, 2.13, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (24, 34, 'TX314', 102.90, 3.09, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (25, 35, 'TX315', 34.30, 1.03, 'Contanti', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento in agenzia');
INSERT INTO public."PAGAMENTI" VALUES (26, 36, 'TX316', 83.00, 2.49, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (27, 37, 'TX317', 56.80, 1.70, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (28, 38, 'TX318', 56.00, 1.68, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (29, 39, 'TX319', 37.30, 1.12, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (30, 40, 'TX320', 186.00, 5.58, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (31, 41, 'TX321', 72.30, 2.17, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (32, 42, 'TX322', 43.80, 1.31, 'Carte credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (33, 43, 'TX323', 24.00, 0.72, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (34, 44, 'TX324', 72.40, 2.17, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (35, 45, 'TX325', 79.40, 2.38, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (36, 46, 'TX326', 189.00, 5.67, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (37, 47, 'TX327', 72.10, 2.16, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (38, 48, 'TX328', 42.80, 1.28, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (39, 49, 'TX329', 29.00, 0.87, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (40, 50, 'TX330', 236.00, 7.08, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (41, 51, 'TX331', 72.30, 2.17, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (42, 52, 'TX332', 43.80, 1.31, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (43, 53, 'TX333', 24.00, 0.72, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (44, 54, 'TX334', 72.40, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (45, 55, 'TX335', 79.40, 2.38, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (46, 56, 'TX336', 189.00, 5.67, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (47, 57, 'TX337', 72.10, 2.16, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (48, 58, 'TX338', 42.80, 1.28, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (49, 59, 'TX339', 29.00, 0.87, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (50, 60, 'TX340', 236.00, 7.08, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (51, 61, 'TX341', 72.30, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (52, 62, 'TX342', 43.80, 1.31, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (53, 63, 'TX343', 24.00, 0.72, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (54, 64, 'TX344', 72.40, 2.17, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (55, 65, 'TX345', 79.40, 2.38, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (56, 66, 'TX346', 189.00, 5.67, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (57, 67, 'TX347', 72.10, 2.16, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (58, 68, 'TX348', 42.80, 1.28, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (59, 69, 'TX349', 29.00, 0.87, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (60, 70, 'TX350', 236.00, 7.08, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (61, 71, 'TX351', 72.30, 2.17, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (62, 72, 'TX352', 43.80, 1.31, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (63, 73, 'TX353', 24.00, 0.72, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (64, 74, 'TX354', 72.40, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (65, 75, 'TX355', 79.40, 2.38, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (66, 76, 'TX356', 189.00, 5.67, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (67, 77, 'TX357', 72.10, 2.16, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (68, 78, 'TX358', 42.80, 1.28, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (69, 79, 'TX359', 29.00, 0.87, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (70, 80, 'TX360', 236.00, 7.08, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (71, 81, 'TX361', 72.30, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (72, 82, 'TX362', 43.80, 1.31, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (73, 83, 'TX363', 24.00, 0.72, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (74, 84, 'TX364', 72.40, 2.17, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (75, 85, 'TX365', 79.40, 2.38, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (76, 86, 'TX366', 189.00, 5.67, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (77, 87, 'TX367', 72.10, 2.16, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (78, 88, 'TX368', 42.80, 1.28, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (79, 89, 'TX369', 29.00, 0.87, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (80, 90, 'TX370', 236.00, 7.08, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (81, 91, 'TX371', 72.30, 2.17, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (82, 92, 'TX372', 43.80, 1.31, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (83, 93, 'TX373', 24.00, 0.72, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (84, 94, 'TX374', 72.40, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (85, 95, 'TX375', 79.40, 2.38, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (86, 96, 'TX376', 189.00, 5.67, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (87, 97, 'TX377', 72.10, 2.16, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (88, 98, 'TX378', 42.80, 1.28, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (89, 99, 'TX379', 29.00, 0.87, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (90, 100, 'TX380', 236.00, 7.08, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (91, 101, 'TX381', 72.30, 2.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (92, 102, 'TX382', 43.80, 1.31, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (93, 103, 'TX383', 24.00, 0.72, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (94, 104, 'TX384', 72.40, 2.17, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (95, 105, 'TX385', 79.40, 2.38, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (96, 106, 'TX386', 189.00, 5.67, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (97, 107, 'TX387', 72.10, 2.16, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (98, 108, 'TX388', 42.80, 1.28, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (99, 109, 'TX389', 29.00, 0.87, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (100, 110, 'TX390', 236.00, 7.08, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (101, 111, 'TX391', 42.00, 1.26, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (102, 112, 'TX392', 84.00, 2.52, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (103, 113, 'TX393', 39.00, 1.17, 'Google Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (104, 114, 'TX394', 156.00, 4.68, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (105, 115, 'TX395', 52.00, 1.56, 'Carta di debito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (106, 116, 'TX396', 88.00, 2.64, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (107, 117, 'TX397', 56.00, 1.68, 'Bonifico', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (108, 118, 'TX398', 56.00, 1.68, 'Apple Pay', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (109, 119, 'TX399', 67.00, 2.01, 'Carta di credito', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (110, 120, 'TX400', 90.00, 2.70, 'PayPal', '2025-12-14 13:54:19.651078+01', 'COMPLETATO', '');
INSERT INTO public."PAGAMENTI" VALUES (141, 121, 'TXGRAPH2025110901', 42.00, 1.26, 'Carta di credito', '2025-11-09 11:30:00+01', 'COMPLETATO', 'Pagamento online');
INSERT INTO public."PAGAMENTI" VALUES (142, 122, 'TXGRAPH2025111001', 78.00, 2.34, 'PayPal', '2025-11-10 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (143, 123, 'TXGRAPH2025111101', 52.00, 1.56, 'Carta di debito', '2025-11-11 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (144, 124, 'TXGRAPH2025111201', 87.00, 2.61, 'Bancomat', '2025-11-12 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (145, 125, 'TXGRAPH2025111301', 32.50, 0.98, 'Apple Pay', '2025-11-13 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (146, 126, 'TXGRAPH2025111401', 44.00, 1.32, 'Carta di credito', '2025-11-14 11:30:00+01', 'COMPLETATO', 'Pagamento confermato');
INSERT INTO public."PAGAMENTI" VALUES (147, 127, 'TXGRAPH2025111501', 56.00, 1.68, 'Google Pay', '2025-11-15 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (148, 128, 'TXGRAPH2025111601', 56.00, 1.68, 'Carta di credito', '2025-11-16 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (149, 129, 'TXGRAPH2025111701', 67.00, 2.01, 'PayPal', '2025-11-17 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (150, 130, 'TXGRAPH2025111801', 22.50, 0.68, 'Bonifico', '2025-11-18 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (151, 131, 'TXGRAPH2025111901', 59.00, 1.77, 'Carta di debito', '2025-11-19 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (152, 132, 'TXGRAPH2025112001', 92.00, 2.76, 'Apple Pay', '2025-11-20 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (153, 133, 'TXGRAPH2025112101', 71.00, 2.13, 'Carta di credito', '2025-11-21 11:30:00+01', 'COMPLETATO', 'Pagamento standard');
INSERT INTO public."PAGAMENTI" VALUES (154, 134, 'TXGRAPH2025112201', 102.90, 3.09, 'PayPal', '2025-11-22 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (155, 135, 'TXGRAPH2025112301', 34.30, 1.03, 'Google Pay', '2025-11-23 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (156, 136, 'TXGRAPH2025112401', 83.00, 2.49, 'Carta di debito', '2025-11-24 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (157, 137, 'TXGRAPH2025112501', 56.80, 1.70, 'Bancomat', '2025-11-25 11:30:00+01', 'COMPLETATO', 'Pagamento confermato');
INSERT INTO public."PAGAMENTI" VALUES (158, 138, 'TXGRAPH2025112601', 56.00, 1.68, 'Carta di credito', '2025-11-26 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (159, 139, 'TXGRAPH2025112701', 37.30, 1.12, 'Apple Pay', '2025-11-27 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (160, 140, 'TXGRAPH2025112801', 186.00, 5.58, 'PayPal', '2025-11-28 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (161, 141, 'TXGRAPH2025112901', 72.30, 2.17, 'Google Pay', '2025-11-29 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (162, 142, 'TXGRAPH2025113001', 43.80, 1.31, 'Carta di credito', '2025-11-30 11:30:00+01', 'COMPLETATO', 'Pagamento online');
INSERT INTO public."PAGAMENTI" VALUES (163, 143, 'TXGRAPH2025120101', 24.00, 0.72, 'Bancomat', '2025-12-01 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (164, 144, 'TXGRAPH2025120201', 72.40, 2.17, 'Carta di debito', '2025-12-02 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (165, 145, 'TXGRAPH2025120301', 79.40, 2.38, 'Apple Pay', '2025-12-03 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (166, 146, 'TXGRAPH2025120401', 189.00, 5.67, 'PayPal', '2025-12-04 11:30:00+01', 'COMPLETATO', 'Pagamento grosso');
INSERT INTO public."PAGAMENTI" VALUES (167, 147, 'TXGRAPH2025120501', 72.10, 2.16, 'Google Pay', '2025-12-05 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (168, 148, 'TXGRAPH2025120601', 42.80, 1.28, 'Carta di credito', '2025-12-06 11:30:00+01', 'COMPLETATO', NULL);
INSERT INTO public."PAGAMENTI" VALUES (169, 149, 'TXGRAPH2025120701', 29.00, 0.87, 'Bonifico', '2025-12-07 11:30:00+01', 'COMPLETATO', 'Pagamento tramite bonifico');
INSERT INTO public."PAGAMENTI" VALUES (170, 150, 'TXGRAPH2025120801', 236.00, 7.08, 'Carta di debito', '2025-12-08 11:30:00+01', 'COMPLETATO', NULL);


--
-- TOC entry 6299 (class 0 OID 16441)
-- Dependencies: 225
-- Data for Name: PASSEGGERI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PASSEGGERI" VALUES (1, 'RSSMRA80A01H501U', 'Mario', 'Rossi', '1980-01-01', 'mario.rossi@email.com', '3331234567', 'Via Roma 12', 'Roma', 'RM', '00100', 'CARD12345', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (2, 'BNCLCU85B10D325C', 'Luca', 'Bianchi', '1985-02-10', 'luca.bianchi@email.com', '3499876543', 'Piazza Garibaldi 5', 'Milano', 'MI', '20100', 'CARD34567', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (3, 'FRGMRA90C15Z404U', 'Giulia', 'Ferrari', '1990-03-15', 'giulia.ferrari@email.com', '3205467890', 'C.so Vittorio 23', 'Torino', 'TO', '10121', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (4, 'VRDLRA95D20H501F', 'Laura', 'Verdi', '1995-04-20', 'laura.verdi@email.com', '3662345678', 'Via Verdi 100', 'Firenze', 'FI', '50121', 'CARD67890', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (5, 'BGNSNV91E25C351I', 'Simone', 'Bergamaschi', '1991-05-25', 'simone.bergamaschi@email.com', '3771230987', 'Via Dante 33', 'Bergamo', 'BG', '24100', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (6, 'DLCGPT88F30H224R', 'Giuseppe', 'Delconte', '1988-06-30', 'giuseppe.delconte@email.com', '3897651230', 'Via Ospedale 17', 'Palermo', 'PA', '90133', 'CARD90123', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (7, 'NGRMNL99G15B157S', 'Manuela', 'Negri', '1999-07-15', 'manuela.negri@email.com', '3912345670', 'Via Napoli 200', 'Napoli', 'NA', '80100', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (8, 'PRSVFR77H10H501W', 'Francesco', 'Parisi', '1977-08-10', 'francesco.parisi@email.com', '3106547892', 'Via Garibaldi 22', 'Roma', 'RM', '00185', 'CARD56789', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (9, 'CMLGLA93I05F205Z', 'Angela', 'Camilli', '1993-09-05', 'angela.camilli@email.com', '3689081720', 'Via Manzoni 55', 'Bologna', 'BO', '40121', NULL, '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (10, 'BLTTMT65J01Z404F', 'Tommaso', 'Bellotti', '1965-10-01', 'tommaso.bellotti@email.com', '3925678130', 'Via Venezia 99', 'Venezia', 'VE', '30100', 'CARD24680', '2025-11-07 19:36:09.74706+01');
INSERT INTO public."PASSEGGERI" VALUES (11, 'RSSNCL90D10R001A', 'Nicola', 'Rossi', '1990-04-10', 'nicola.rossi@email.com', '3331111111', 'Via Roma 1', 'Roma', 'RM', '00100', 'CARD11111', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (12, 'BNCGNN85C20M001B', 'Gianna', 'Bianchi', '1985-03-20', 'gianna.bianchi@email.com', '3332222222', 'Via Milano 2', 'Milano', 'MI', '20100', 'CARD22222', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (13, 'FRRLRA92E30T001C', 'Lorenza', 'Ferrari', '1992-05-30', 'lorenza.ferrari@email.com', '3333333333', 'Via Torino 3', 'Torino', 'TO', '10121', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (14, 'VRDMRC88F10F001D', 'Marco', 'Verdi', '1988-06-10', 'marco.verdi@email.com', '3334444444', 'Via Firenze 4', 'Firenze', 'FI', '50121', 'CARD33333', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (15, 'BGNNGL95G25B001E', 'Gabriele', 'Bergamaschi', '1995-07-25', 'gabriele.bergamaschi@email.com', '3335555555', 'Via Bergamo 5', 'Bergamo', 'BG', '24100', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (16, 'DLCSMN89H15P001F', 'Simone', 'Delconte', '1989-08-15', 'simone.delconte@email.com', '3336666666', 'Via Palermo 6', 'Palermo', 'PA', '90133', 'CARD44444', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (17, 'NGRFRN97I20N001G', 'Francesca', 'Negri', '1997-09-20', 'francesca.negri@email.com', '3337777777', 'Via Napoli 7', 'Napoli', 'NA', '80100', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (18, 'PRSVNZ81J30R001H', 'Vinenzo', 'Parisi', '1981-10-30', 'vinenzo.parisi@email.com', '3338888888', 'Via Venezia 8', 'Venezia', 'VE', '30100', 'CARD55555', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (19, 'CMLGTD93K05B001I', 'Giada', 'Camilli', '1993-11-05', 'giada.camilli@email.com', '3339999999', 'Via Bologna 9', 'Bologna', 'BO', '40121', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (20, 'BLTTBT67L10G001J', 'Barbara', 'Bellotti', '1967-12-10', 'barbara.bellotti@email.com', '3330000000', 'Via Genova 10', 'Genova', 'GE', '16121', 'CARD66666', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (21, 'RSSMDS78A01H001K', 'Matteo', 'Rossi', '1978-01-15', 'matteo.rossi@email.com', '3341111111', 'Via Napoli 11', 'Napoli', 'NA', '80122', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (22, 'BNCRTR86B05M001L', 'Riccardo', 'Bianchi', '1986-02-20', 'riccardo.bianchi@email.com', '3342222222', 'Via Roma 12', 'Roma', 'RM', '00185', 'CARD77777', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (23, 'FRRCRL89C10F001M', 'Carla', 'Ferrari', '1989-03-25', 'carla.ferrari@email.com', '3343333333', 'Via Milano 13', 'Milano', 'MI', '20122', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (24, 'VRDNND91D15T001N', 'Nando', 'Verdi', '1991-04-10', 'nando.verdi@email.com', '3344444444', 'Via Torino 14', 'Torino', 'TO', '10122', 'CARD88888', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (25, 'BGNCNT94E20B001O', 'Concetta', 'Bergamaschi', '1994-05-05', 'concetta.bergamaschi@email.com', '3345555555', 'Via Bergamo 15', 'Bergamo', 'BG', '24122', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (26, 'DLCMRIA87F25P001', 'Maria', 'Delconte', '1987-06-12', 'maria.delconte@email.com', '3346666666', 'Via Palermo 16', 'Palermo', 'PA', '90134', 'CARD99999', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (27, 'NGRSFN96G10N001Q', 'Stefano', 'Negri', '1996-07-18', 'stefano.negri2@email.com', '3347777777', 'Via Napoli 17', 'Napoli', 'NA', '80123', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (28, 'PRSDVD82H20R001R', 'Davide', 'Parisi', '1982-08-22', 'davide.parisi@email.com', '3348888888', 'Via Venezia 18', 'Venezia', 'VE', '30122', 'CARD10000', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (29, 'CMLSNZ98I15B001S', 'Senza', 'Camilli', '1998-09-11', 'senza.camilli@email.com', '3349999999', 'Via Bologna 19', 'Bologna', 'BO', '40122', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (30, 'BLTVNT70J25G001T', 'Vincenzo', 'Bellotti', '1970-10-30', 'vincenzo.bellotti@email.com', '3350000000', 'Via Genova 20', 'Genova', 'GE', '16122', 'CARD11001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (31, 'RSSPQL75K10H001U', 'Paolo', 'Rossi', '1975-11-14', 'paolo.rossi@email.com', '3351111111', 'Via Roma 21', 'Roma', 'RM', '00186', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (32, 'BNCGPT88L05M001V', 'Giuseppe', 'Bianchi', '1988-12-20', 'giuseppe.bianchi@email.com', '3352222222', 'Via Milano 22', 'Milano', 'MI', '20123', 'CARD12001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (33, 'FRRGVN91M15F001W', 'Giovanni', 'Ferrari', '1991-01-25', 'giovanni.ferrari@email.com', '3353333333', 'Via Torino 23', 'Torino', 'TO', '10123', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (34, 'VRDCRN93N20T001X', 'Cristiano', 'Verdi', '1993-02-10', 'cristiano.verdi@email.com', '3354444444', 'Via Firenze 24', 'Firenze', 'FI', '50122', 'CARD13001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (35, 'BGNGST96O25B001Y', 'Giacomo', 'Bergamaschi', '1996-03-15', 'giacomo.bergamaschi@email.com', '3355555555', 'Via Bergamo 25', 'Bergamo', 'BG', '24123', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (36, 'DLCFRC84P10P001Z', 'Francesco', 'Delconte', '1984-04-22', 'francesco.delconte@email.com', '3356666666', 'Via Palermo 26', 'Palermo', 'PA', '90135', 'CARD14001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (37, 'NGRSFR99Q05N001A', 'Sandro', 'Negri', '1999-05-18', 'sandro.negri@email.com', '3357777777', 'Via Napoli 27', 'Napoli', 'NA', '80124', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (38, 'PRSLRS80R30R001B', 'Luca', 'Parisi', '1980-06-12', 'luca.parisi@email.com', '3358888888', 'Via Venezia 27', 'Venezia', 'VE', '30123', 'CARD15001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (39, 'CMLSTS97S15B001C', 'Stefania', 'Camilli', '1997-07-09', 'stefania.camilli@email.com', '3359999999', 'Via Bologna 28', 'Bologna', 'BO', '40123', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (40, 'BLTRBN72T20G001D', 'Ruben', 'Bellotti', '1972-08-16', 'ruben.bellotti@email.com', '3360000000', 'Via Genova 29', 'Genova', 'GE', '16123', 'CARD16001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (41, 'RSSRNZ77U05H001E', 'Enrico', 'Rossi', '1977-09-21', 'enrico.rossi@email.com', '3361111111', 'Via Roma 30', 'Roma', 'RM', '00187', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (42, 'BNCBRT89V10M001F', 'Bertrand', 'Bianchi', '1989-10-14', 'bertrand.bianchi@email.com', '3362222222', 'Via Milano 31', 'Milano', 'MI', '20124', 'CARD17001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (43, 'FRRMRC92W20F001G', 'Mirco', 'Ferrari', '1992-11-30', 'mirco.ferrari@email.com', '3363333333', 'Via Torino 32', 'Torino', 'TO', '10124', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (44, 'VRDSGR94X15T001H', 'Sergio', 'Verdi', '1994-12-11', 'sergio.verdi@email.com', '3364444444', 'Via Firenze 33', 'Firenze', 'FI', '50123', 'CARD18001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (45, 'BGNDNI97Y25B001I', 'Dario', 'Bergamaschi', '1997-01-08', 'dario.bergamaschi@email.com', '3365555555', 'Via Bergamo 34', 'Bergamo', 'BG', '24124', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (46, 'DLCVLE85Z30P001J', 'Valerio', 'Delconte', '1985-02-19', 'valerio.delconte@email.com', '3366666666', 'Via Palermo 35', 'Palermo', 'PA', '90136', 'CARD19001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (47, 'NGRRFE98A10N001K', 'Raffaele', 'Negri', '1998-03-27', 'raffaele.negri@email.com', '3367777777', 'Via Napoli 36', 'Napoli', 'NA', '80125', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (48, 'PRSNDP81B20R001L', 'Andrea', 'Parisi', '1981-04-23', 'andrea.parisi@email.com', '3368888888', 'Via Venezia 37', 'Venezia', 'VE', '30124', 'CARD20001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (49, 'CMLGVN96C05B001M', 'Giovanni', 'Camilli', '1996-05-14', 'giovanni.camilli@email.com', '3369999999', 'Via Bologna 38', 'Bologna', 'BO', '40124', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (50, 'BLTNCD73D10G001N', 'Niccolò', 'Bellotti', '1973-06-25', 'niccolo.bellotti@email.com', '3370000000', 'Via Genova 39', 'Genova', 'GE', '16124', 'CARD21001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (51, 'RSSLGI76E15H001O', 'Luigi', 'Rossi', '1976-07-30', 'luigi.rossi@email.com', '3371111111', 'Via Roma 40', 'Roma', 'RM', '00188', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (52, 'BNCSFN87F20M001P', 'Stefano', 'Bianchi', '1987-08-18', 'stefano.bianchi@email.com', '3372222222', 'Via Milano 41', 'Milano', 'MI', '20125', 'CARD22001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (53, 'FRRVCN90G25F001Q', 'Vincenzo', 'Ferrari', '1990-09-09', 'vincenzo.ferrari@email.com', '3373333333', 'Via Torino 42', 'Torino', 'TO', '10125', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (54, 'VRDMTZ92H10T001R', 'Matteo', 'Verdi', '1992-10-20', 'matteo.verdi@email.com', '3374444444', 'Via Firenze 43', 'Firenze', 'FI', '50124', 'CARD23001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (55, 'BGNCRL95I05B001S', 'Carlo', 'Bergamaschi', '1995-11-12', 'carlo.bergamaschi@email.com', '3375555555', 'Via Bergamo 44', 'Bergamo', 'BG', '24125', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (56, 'DLCPWL83J15P001T', 'Paolo', 'Delconte', '1983-12-22', 'paolo.delconte@email.com', '3376666666', 'Via Palermo 45', 'Palermo', 'PA', '90137', 'CARD24001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (57, 'NGRMRC97K20N001U', 'Marcello', 'Negri', '1997-01-31', 'marcello.negri@email.com', '3377777777', 'Via Napoli 46', 'Napoli', 'NA', '80126', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (58, 'PRSTSM82L25R001V', 'Tommaso', 'Parisi', '1982-02-14', 'tommaso.parisi@email.com', '3378888888', 'Via Venezia 47', 'Venezia', 'VE', '30125', 'CARD25001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (59, 'CMLPTR99M10B001W', 'Pietro', 'Camilli', '1999-03-24', 'pietro.camilli@email.com', '3379999999', 'Via Bologna 48', 'Bologna', 'BO', '40125', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (60, 'BLTGRT74N30G001X', 'Giancarlo', 'Bellotti', '1974-04-08', 'giancarlo.bellotti@email.com', '3380000000', 'Via Genova 49', 'Genova', 'GE', '16125', 'CARD26001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (61, 'RSSDRN79O10H001Y', 'Dorian', 'Rossi', '1979-05-16', 'dorian.rossi@email.com', '3381111111', 'Via Roma 50', 'Roma', 'RM', '00189', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (62, 'BNCFNC88P05M001Z', 'Francesca', 'Bianchi', '1988-06-23', 'francesca.bianchi@email.com', '3382222222', 'Via Milano 51', 'Milano', 'MI', '20126', 'CARD27001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (63, 'FRRMMT91Q15F001A', 'Mattia', 'Ferrari', '1991-07-11', 'mattia.ferrari@email.com', '3383333333', 'Via Torino 52', 'Torino', 'TO', '10126', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (64, 'VRDLZN93R20T001B', 'Lazzaro', 'Verdi', '1993-08-19', 'lazzaro.verdi@email.com', '3384444444', 'Via Firenze 53', 'Firenze', 'FI', '50125', 'CARD28001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (65, 'BGNNDR96S25B001C', 'Andrea', 'Bergamaschi', '1996-09-27', 'andrea.bergamaschi@email.com', '3385555555', 'Via Bergamo 54', 'Bergamo', 'BG', '24126', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (66, 'DLCSBM84T10P001D', 'Sebastiano', 'Delconte', '1984-10-05', 'sebastiano.delconte@email.com', '3386666666', 'Via Palermo 55', 'Palermo', 'PA', '90138', 'CARD29001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (67, 'NGRMNN98U20N001E', 'Manuele', 'Negri', '1998-11-13', 'manuele.negri@email.com', '3387777777', 'Via Napoli 56', 'Napoli', 'NA', '80127', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (68, 'PRSCRZ81V30R001F', 'Corrado', 'Parisi', '1981-12-28', 'corrado.parisi@email.com', '3388888888', 'Via Venezia 57', 'Venezia', 'VE', '30126', 'CARD30001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (69, 'CMLSFN97W05B001G', 'Stefano', 'Camilli', '1997-01-06', 'stefano.camilli@email.com', '3389999999', 'Via Bologna 58', 'Bologna', 'BO', '40126', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (70, 'BLTMRN75X10G001H', 'Maurizio', 'Bellotti', '1975-02-14', 'maurizio.bellotti@email.com', '3390000000', 'Via Genova 59', 'Genova', 'GE', '16126', 'CARD31001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (71, 'RSSCRL78Y15H001I', 'Carlo', 'Rossi', '1978-03-22', 'carlo.rossi@email.com', '3391111111', 'Via Roma 60', 'Roma', 'RM', '00190', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (72, 'BNCRGN89Z20M001J', 'Reggino', 'Bianchi', '1989-04-30', 'reggino.bianchi@email.com', '3392222222', 'Via Milano 61', 'Milano', 'MI', '20127', 'CARD32001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (73, 'FRRSLY92A25F001K', 'Silvio', 'Ferrari', '1992-05-08', 'silvio.ferrari@email.com', '3393333333', 'Via Torino 62', 'Torino', 'TO', '10127', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (74, 'VRDGLM94B10T001L', 'Guglielmo', 'Verdi', '1994-06-16', 'guglielmo.verdi@email.com', '3394444444', 'Via Firenze 64', 'Firenze', 'FI', '50126', 'CARD33001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (75, 'BGNTMS97C20B001M', 'Tommaso', 'Bergamaschi', '1997-07-24', 'tommaso.bergamaschi@email.com', '3395555555', 'Via Bergamo 65', 'Bergamo', 'BG', '24127', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (76, 'DLCDVD85D05P001N', 'Davide', 'Delconte', '1985-08-01', 'davide.delconte@email.com', '3396666666', 'Via Palermo 66', 'Palermo', 'PA', '90139', 'CARD34001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (77, 'NGRSTN99E15N001O', 'Stefano', 'Negri', '1999-09-09', 'stefano.negri@email.com', '3397777777', 'Via Napoli 67', 'Napoli', 'NA', '80128', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (78, 'PRSSFN82F20R001P', 'Stefano', 'Parisi', '1982-10-17', 'stefano.parisi@email.com', '3398888888', 'Via Venezia 68', 'Venezia', 'VE', '30127', 'CARD35001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (79, 'CMLRCR98G25B001Q', 'Riccardo', 'Camilli', '1998-11-25', 'riccardo.camilli@email.com', '3399999999', 'Via Bologna 69', 'Bologna', 'BO', '40127', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (80, 'BLTRRT76H10G001R', 'Roberto', 'Bellotti', '1976-12-03', 'roberto.bellotti@email.com', '3400000000', 'Via Genova 70', 'Genova', 'GE', '16127', 'CARD36001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (81, 'RSSTNJ79I20H001S', 'Tony', 'Rossi', '1979-01-11', 'tony.rossi@email.com', '3401111111', 'Via Roma 71', 'Roma', 'RM', '00191', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (82, 'BNCFNN90J05M001T', 'Fausto', 'Bianchi', '1990-02-19', 'fausto.bianchi@email.com', '3402222222', 'Via Milano 72', 'Milano', 'MI', '20128', 'CARD37001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (83, 'FRRVNN93K10F001U', 'Viviano', 'Ferrari', '1993-03-27', 'viviano.ferrari@email.com', '3403333333', 'Via Torino 73', 'Torino', 'TO', '10128', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (84, 'VRDTRZ95L15T001V', 'Terenzi', 'Verdi', '1995-04-05', 'terenzi.verdi@email.com', '3404444444', 'Via Firenze 74', 'Firenze', 'FI', '50127', 'CARD38001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (85, 'BGNNRY98M20B001W', 'Nurdy', 'Bergamaschi', '1998-05-13', 'nurdy.bergamaschi@email.com', '3405555555', 'Via Bergamo 75', 'Bergamo', 'BG', '24128', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (86, 'DLCRND86N25P001X', 'Rolando', 'Delconte', '1986-06-21', 'rolando.delconte@email.com', '3406666666', 'Via Palermo 76', 'Palermo', 'PA', '90140', 'CARD39001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (87, 'NGRSML00O30N001Y', 'Samuel', 'Negri', '2000-07-29', 'samuel.negri@email.com', '3407777777', 'Via Napoli 77', 'Napoli', 'NA', '80129', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (88, 'PRSVLY83P05R001Z', 'Valery', 'Parisi', '1983-08-06', 'valery.parisi@email.com', '3408888888', 'Via Venezia 78', 'Venezia', 'VE', '30128', 'CARD40001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (89, 'CMLGVS99Q10B001A', 'Gavino', 'Camilli', '1999-09-14', 'gavino.camilli@email.com', '3409999999', 'Via Bologna 79', 'Bologna', 'BO', '40128', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (90, 'BLTRCN77R20G001B', 'Rocco', 'Bellotti', '1977-10-22', 'rocco.bellotti@email.com', '3410000000', 'Via Genova 80', 'Genova', 'GE', '16128', 'CARD41001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (91, 'RSSMRL80S10H001C', 'Morel', 'Rossi', '1980-11-30', 'morel.rossi@email.com', '3411111111', 'Via Roma 81', 'Roma', 'RM', '00192', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (92, 'BNCSBL91T05M001D', 'Sibilla', 'Bianchi', '1991-12-08', 'sibilla.bianchi@email.com', '3412222222', 'Via Milano 82', 'Milano', 'MI', '20129', 'CARD42001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (93, 'FRRDLL94U15F001E', 'Dalila', 'Ferrari', '1994-01-16', 'dalila.ferrari@email.com', '3413333333', 'Via Torino 83', 'Torino', 'TO', '10129', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (94, 'VRDRBL96V20T001F', 'Raoul', 'Verdi', '1996-02-24', 'raoul.verdi@email.com', '3414444444', 'Via Firenze 84', 'Firenze', 'FI', '50128', 'CARD43001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (95, 'BGNJNN99W25B001G', 'Janina', 'Bergamaschi', '1999-03-03', 'janina.bergamaschi@email.com', '3415555555', 'Via Bergamo 85', 'Bergamo', 'BG', '24129', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (96, 'DLCNLL87X30P001H', 'Nello', 'Delconte', '1987-04-11', 'nello.delconte@email.com', '3416666666', 'Via Palermo 86', 'Palermo', 'PA', '90141', 'CARD44001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (97, 'NGRSRL00Y15N001I', 'Serena', 'Negri', '2000-05-19', 'serena.negri@email.com', '3417777777', 'Via Napoli 87', 'Napoli', 'NA', '80130', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (98, 'PRSNRL84Z20R001J', 'Neri', 'Parisi', '1984-06-27', 'neri.parisi@email.com', '3418888888', 'Via Venezia 88', 'Venezia', 'VE', '30129', 'CARD45001', '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (99, 'CMLNLF00A05B001K', 'Emanuele', 'Camilli', '2000-07-05', 'emanuele.camilli@email.com', '3419999999', 'Via Bologna 89', 'Bologna', 'BO', '40129', NULL, '2025-12-14 13:49:58.518167+01');
INSERT INTO public."PASSEGGERI" VALUES (100, 'BLTNRD78B10G001L', 'Nardo', 'Bellotti', '1978-08-13', 'nardo.bellotti@email.com', '3420000000', 'Via Genova 90', 'Genova', 'GE', '16129', 'CARD46001', '2025-12-14 13:49:58.518167+01');


--
-- TOC entry 6301 (class 0 OID 16463)
-- Dependencies: 227
-- Data for Name: PRENOTAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PRENOTAZIONI" VALUES (2, 'PR002', '2025-11-08 19:58:15.654472+01', 2, 99.90, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (3, 'PR003', '2025-11-08 19:58:15.654472+01', 1, 38.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (5, 'PR005', '2025-11-08 19:58:15.654472+01', 3, 132.00, 'CONFERMATA', 'TELEFONO', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (6, 'PR006', '2025-11-08 19:58:15.654472+01', 1, 26.50, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (8, 'PR008', '2025-11-08 19:58:15.654472+01', 1, 60.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (9, 'PR009', '2025-11-08 19:58:15.654472+01', 1, 24.99, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (10, 'PR010', '2025-11-08 19:58:15.654472+01', 1, 52.00, 'CONFERMATA', 'APP', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (1, 'PR001', '2025-11-08 19:58:15.654472+01', 1, 45.00, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (4, 'PR004', '2025-11-08 19:58:15.654472+01', 1, 50.00, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (7, 'PR007', '2025-11-08 19:58:15.654472+01', 2, 97.98, 'CONFERMATA', 'AGENZIA', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (11, 'PR101', '2025-11-16 18:00:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (12, 'PR102', '2025-11-16 18:10:00+01', 2, 78.00, 'CONFERMATA', 'APP', 2, 2);
INSERT INTO public."PRENOTAZIONI" VALUES (13, 'PR103', '2025-11-16 18:20:00+01', 1, 52.00, 'CONFERMATA', 'WEB', 3, 3);
INSERT INTO public."PRENOTAZIONI" VALUES (14, 'PR104', '2025-11-16 18:30:00+01', 1, 87.00, 'CONFERMATA', 'APP', 4, 4);
INSERT INTO public."PRENOTAZIONI" VALUES (15, 'PR105', '2025-11-16 18:40:00+01', 1, 32.50, 'CONFERMATA', 'AGENZIA', 5, 5);
INSERT INTO public."PRENOTAZIONI" VALUES (16, 'PR106', '2025-11-16 18:50:00+01', 1, 44.00, 'CONFERMATA', 'WEB', 6, 6);
INSERT INTO public."PRENOTAZIONI" VALUES (17, 'PR107', '2025-11-16 19:00:00+01', 1, 56.00, 'CONFERMATA', 'APP', 7, 7);
INSERT INTO public."PRENOTAZIONI" VALUES (18, 'PR108', '2025-11-16 19:10:00+01', 1, 28.00, 'CONFERMATA', 'AGENZIA', 8, 8);
INSERT INTO public."PRENOTAZIONI" VALUES (19, 'PR109', '2025-11-16 19:20:00+01', 1, 67.00, 'CONFERMATA', 'WEB', 9, 9);
INSERT INTO public."PRENOTAZIONI" VALUES (20, 'PR110', '2025-11-16 19:30:00+01', 1, 22.50, 'CONFERMATA', 'APP', 10, 10);
INSERT INTO public."PRENOTAZIONI" VALUES (21, 'PR201', '2025-12-08 10:00:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 1, 11);
INSERT INTO public."PRENOTAZIONI" VALUES (22, 'PR202', '2025-12-08 10:15:00+01', 2, 84.00, 'CONFERMATA', 'APP', 2, 12);
INSERT INTO public."PRENOTAZIONI" VALUES (23, 'PR203', '2025-12-08 10:30:00+01', 1, 39.00, 'CONFERMATA', 'AGENZIA', 3, 13);
INSERT INTO public."PRENOTAZIONI" VALUES (24, 'PR204', '2025-12-08 10:45:00+01', 3, 156.00, 'CONFERMATA', 'WEB', 4, 14);
INSERT INTO public."PRENOTAZIONI" VALUES (25, 'PR205', '2025-12-08 11:00:00+01', 1, 52.00, 'CONFERMATA', 'APP', 5, 15);
INSERT INTO public."PRENOTAZIONI" VALUES (26, 'PR206', '2025-12-08 11:15:00+01', 2, 88.00, 'CONFERMATA', 'TELEFONO', 6, 16);
INSERT INTO public."PRENOTAZIONI" VALUES (27, 'PR207', '2025-12-08 11:30:00+01', 1, 56.00, 'CONFERMATA', 'WEB', 7, 17);
INSERT INTO public."PRENOTAZIONI" VALUES (28, 'PR208', '2025-12-08 11:45:00+01', 2, 56.00, 'CONFERMATA', 'APP', 8, 18);
INSERT INTO public."PRENOTAZIONI" VALUES (29, 'PR209', '2025-12-08 12:00:00+01', 1, 67.00, 'CONFERMATA', 'AGENZIA', 9, 19);
INSERT INTO public."PRENOTAZIONI" VALUES (30, 'PR210', '2025-12-08 12:15:00+01', 4, 90.00, 'CONFERMATA', 'WEB', 10, 20);
INSERT INTO public."PRENOTAZIONI" VALUES (31, 'PR211', '2025-12-08 12:30:00+01', 1, 59.00, 'CONFERMATA', 'APP', 11, 21);
INSERT INTO public."PRENOTAZIONI" VALUES (32, 'PR212', '2025-12-08 12:45:00+01', 2, 92.00, 'CONFERMATA', 'TELEFONO', 12, 22);
INSERT INTO public."PRENOTAZIONI" VALUES (33, 'PR213', '2025-12-08 13:00:00+01', 1, 71.00, 'CONFERMATA', 'WEB', 13, 23);
INSERT INTO public."PRENOTAZIONI" VALUES (34, 'PR214', '2025-12-08 13:15:00+01', 3, 102.90, 'CONFERMATA', 'APP', 14, 24);
INSERT INTO public."PRENOTAZIONI" VALUES (35, 'PR215', '2025-12-08 13:30:00+01', 1, 34.30, 'CONFERMATA', 'AGENZIA', 15, 25);
INSERT INTO public."PRENOTAZIONI" VALUES (36, 'PR216', '2025-12-08 13:45:00+01', 2, 83.00, 'CONFERMATA', 'WEB', 16, 26);
INSERT INTO public."PRENOTAZIONI" VALUES (37, 'PR217', '2025-12-08 14:00:00+01', 1, 56.80, 'CONFERMATA', 'APP', 17, 27);
INSERT INTO public."PRENOTAZIONI" VALUES (38, 'PR218', '2025-12-08 14:15:00+01', 2, 56.00, 'CONFERMATA', 'TELEFONO', 18, 28);
INSERT INTO public."PRENOTAZIONI" VALUES (39, 'PR219', '2025-12-08 14:30:00+01', 1, 37.30, 'CONFERMATA', 'WEB', 19, 29);
INSERT INTO public."PRENOTAZIONI" VALUES (40, 'PR220', '2025-12-08 14:45:00+01', 3, 186.00, 'CONFERMATA', 'APP', 20, 30);
INSERT INTO public."PRENOTAZIONI" VALUES (41, 'PR221', '2025-12-08 15:00:00+01', 1, 72.30, 'CONFERMATA', 'AGENZIA', 21, 31);
INSERT INTO public."PRENOTAZIONI" VALUES (42, 'PR222', '2025-12-08 15:15:00+01', 2, 43.80, 'CONFERMATA', 'WEB', 22, 32);
INSERT INTO public."PRENOTAZIONI" VALUES (43, 'PR223', '2025-12-08 15:30:00+01', 1, 24.00, 'CONFERMATA', 'APP', 23, 33);
INSERT INTO public."PRENOTAZIONI" VALUES (44, 'PR224', '2025-12-08 15:45:00+01', 2, 72.40, 'CONFERMATA', 'TELEFONO', 24, 34);
INSERT INTO public."PRENOTAZIONI" VALUES (45, 'PR225', '2025-12-08 16:00:00+01', 1, 79.40, 'CONFERMATA', 'WEB', 25, 35);
INSERT INTO public."PRENOTAZIONI" VALUES (46, 'PR226', '2025-12-08 16:15:00+01', 3, 189.00, 'CONFERMATA', 'APP', 26, 36);
INSERT INTO public."PRENOTAZIONI" VALUES (47, 'PR227', '2025-12-08 16:30:00+01', 1, 72.10, 'CONFERMATA', 'AGENZIA', 27, 37);
INSERT INTO public."PRENOTAZIONI" VALUES (48, 'PR228', '2025-12-08 16:45:00+01', 2, 42.80, 'CONFERMATA', 'WEB', 28, 38);
INSERT INTO public."PRENOTAZIONI" VALUES (49, 'PR229', '2025-12-08 17:00:00+01', 1, 29.00, 'CONFERMATA', 'APP', 29, 39);
INSERT INTO public."PRENOTAZIONI" VALUES (50, 'PR230', '2025-12-08 17:15:00+01', 4, 236.00, 'CONFERMATA', 'TELEFONO', 30, 40);
INSERT INTO public."PRENOTAZIONI" VALUES (51, 'PR231', '2025-12-08 17:30:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 1, 41);
INSERT INTO public."PRENOTAZIONI" VALUES (52, 'PR232', '2025-12-08 17:45:00+01', 2, 84.00, 'CONFERMATA', 'APP', 2, 42);
INSERT INTO public."PRENOTAZIONI" VALUES (53, 'PR233', '2025-12-08 18:00:00+01', 1, 39.00, 'CONFERMATA', 'AGENZIA', 3, 43);
INSERT INTO public."PRENOTAZIONI" VALUES (54, 'PR234', '2025-12-08 18:15:00+01', 3, 156.00, 'CONFERMATA', 'WEB', 4, 44);
INSERT INTO public."PRENOTAZIONI" VALUES (55, 'PR235', '2025-12-08 18:30:00+01', 1, 52.00, 'CONFERMATA', 'APP', 5, 45);
INSERT INTO public."PRENOTAZIONI" VALUES (56, 'PR236', '2025-12-08 18:45:00+01', 2, 88.00, 'CONFERMATA', 'TELEFONO', 6, 46);
INSERT INTO public."PRENOTAZIONI" VALUES (57, 'PR237', '2025-12-08 19:00:00+01', 1, 56.00, 'CONFERMATA', 'WEB', 7, 47);
INSERT INTO public."PRENOTAZIONI" VALUES (58, 'PR238', '2025-12-08 19:15:00+01', 2, 56.00, 'CONFERMATA', 'APP', 8, 48);
INSERT INTO public."PRENOTAZIONI" VALUES (59, 'PR239', '2025-12-08 19:30:00+01', 1, 67.00, 'CONFERMATA', 'AGENZIA', 9, 49);
INSERT INTO public."PRENOTAZIONI" VALUES (60, 'PR240', '2025-12-08 19:45:00+01', 4, 90.00, 'CONFERMATA', 'WEB', 10, 50);
INSERT INTO public."PRENOTAZIONI" VALUES (61, 'PR241', '2025-12-08 20:00:00+01', 1, 59.00, 'CONFERMATA', 'APP', 11, 51);
INSERT INTO public."PRENOTAZIONI" VALUES (62, 'PR242', '2025-12-08 20:15:00+01', 2, 92.00, 'CONFERMATA', 'TELEFONO', 12, 52);
INSERT INTO public."PRENOTAZIONI" VALUES (63, 'PR243', '2025-12-08 20:30:00+01', 1, 71.00, 'CONFERMATA', 'WEB', 13, 53);
INSERT INTO public."PRENOTAZIONI" VALUES (64, 'PR244', '2025-12-08 20:45:00+01', 3, 102.90, 'CONFERMATA', 'APP', 14, 54);
INSERT INTO public."PRENOTAZIONI" VALUES (65, 'PR245', '2025-12-08 21:00:00+01', 1, 34.30, 'CONFERMATA', 'AGENZIA', 15, 55);
INSERT INTO public."PRENOTAZIONI" VALUES (66, 'PR246', '2025-12-08 21:15:00+01', 2, 83.00, 'CONFERMATA', 'WEB', 16, 56);
INSERT INTO public."PRENOTAZIONI" VALUES (67, 'PR247', '2025-12-08 21:30:00+01', 1, 56.80, 'CONFERMATA', 'APP', 17, 57);
INSERT INTO public."PRENOTAZIONI" VALUES (68, 'PR248', '2025-12-08 21:45:00+01', 2, 56.00, 'CONFERMATA', 'TELEFONO', 18, 58);
INSERT INTO public."PRENOTAZIONI" VALUES (69, 'PR249', '2025-12-08 22:00:00+01', 1, 37.30, 'CONFERMATA', 'WEB', 19, 59);
INSERT INTO public."PRENOTAZIONI" VALUES (70, 'PR250', '2025-12-08 22:15:00+01', 3, 186.00, 'CONFERMATA', 'APP', 20, 60);
INSERT INTO public."PRENOTAZIONI" VALUES (71, 'PR251', '2025-12-09 08:00:00+01', 1, 72.30, 'CONFERMATA', 'AGENZIA', 21, 61);
INSERT INTO public."PRENOTAZIONI" VALUES (72, 'PR252', '2025-12-09 08:15:00+01', 2, 43.80, 'CONFERMATA', 'WEB', 22, 62);
INSERT INTO public."PRENOTAZIONI" VALUES (73, 'PR253', '2025-12-09 08:30:00+01', 1, 24.00, 'CONFERMATA', 'APP', 23, 63);
INSERT INTO public."PRENOTAZIONI" VALUES (74, 'PR254', '2025-12-09 08:45:00+01', 2, 72.40, 'CONFERMATA', 'TELEFONO', 24, 64);
INSERT INTO public."PRENOTAZIONI" VALUES (75, 'PR255', '2025-12-09 09:00:00+01', 1, 79.40, 'CONFERMATA', 'WEB', 25, 65);
INSERT INTO public."PRENOTAZIONI" VALUES (76, 'PR256', '2025-12-09 09:15:00+01', 3, 189.00, 'CONFERMATA', 'APP', 26, 66);
INSERT INTO public."PRENOTAZIONI" VALUES (77, 'PR257', '2025-12-09 09:30:00+01', 1, 72.10, 'CONFERMATA', 'AGENZIA', 27, 67);
INSERT INTO public."PRENOTAZIONI" VALUES (78, 'PR258', '2025-12-09 09:45:00+01', 2, 42.80, 'CONFERMATA', 'WEB', 28, 68);
INSERT INTO public."PRENOTAZIONI" VALUES (79, 'PR259', '2025-12-09 10:00:00+01', 1, 29.00, 'CONFERMATA', 'APP', 29, 69);
INSERT INTO public."PRENOTAZIONI" VALUES (80, 'PR260', '2025-12-09 10:15:00+01', 4, 236.00, 'CONFERMATA', 'TELEFONO', 30, 70);
INSERT INTO public."PRENOTAZIONI" VALUES (81, 'PR261', '2025-12-09 10:30:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 31, 71);
INSERT INTO public."PRENOTAZIONI" VALUES (82, 'PR262', '2025-12-09 10:45:00+01', 2, 84.00, 'CONFERMATA', 'APP', 32, 72);
INSERT INTO public."PRENOTAZIONI" VALUES (83, 'PR263', '2025-12-09 11:00:00+01', 1, 39.00, 'CONFERMATA', 'AGENZIA', 33, 73);
INSERT INTO public."PRENOTAZIONI" VALUES (84, 'PR264', '2025-12-09 11:15:00+01', 3, 156.00, 'CONFERMATA', 'WEB', 34, 74);
INSERT INTO public."PRENOTAZIONI" VALUES (85, 'PR265', '2025-12-09 11:30:00+01', 1, 52.00, 'CONFERMATA', 'APP', 35, 75);
INSERT INTO public."PRENOTAZIONI" VALUES (86, 'PR266', '2025-12-09 11:45:00+01', 2, 88.00, 'CONFERMATA', 'TELEFONO', 36, 76);
INSERT INTO public."PRENOTAZIONI" VALUES (87, 'PR267', '2025-12-09 12:00:00+01', 1, 56.00, 'CONFERMATA', 'WEB', 37, 77);
INSERT INTO public."PRENOTAZIONI" VALUES (88, 'PR268', '2025-12-09 12:15:00+01', 2, 56.00, 'CONFERMATA', 'APP', 38, 78);
INSERT INTO public."PRENOTAZIONI" VALUES (89, 'PR269', '2025-12-09 12:30:00+01', 1, 67.00, 'CONFERMATA', 'AGENZIA', 39, 79);
INSERT INTO public."PRENOTAZIONI" VALUES (90, 'PR270', '2025-12-09 12:45:00+01', 4, 90.00, 'CONFERMATA', 'WEB', 40, 80);
INSERT INTO public."PRENOTAZIONI" VALUES (91, 'PR271', '2025-12-09 13:00:00+01', 1, 59.00, 'CONFERMATA', 'APP', 41, 81);
INSERT INTO public."PRENOTAZIONI" VALUES (92, 'PR272', '2025-12-09 13:15:00+01', 2, 92.00, 'CONFERMATA', 'TELEFONO', 42, 82);
INSERT INTO public."PRENOTAZIONI" VALUES (93, 'PR273', '2025-12-09 13:30:00+01', 1, 71.00, 'CONFERMATA', 'WEB', 43, 83);
INSERT INTO public."PRENOTAZIONI" VALUES (94, 'PR274', '2025-12-09 13:45:00+01', 3, 102.90, 'CONFERMATA', 'APP', 44, 84);
INSERT INTO public."PRENOTAZIONI" VALUES (95, 'PR275', '2025-12-09 14:00:00+01', 1, 34.30, 'CONFERMATA', 'AGENZIA', 45, 85);
INSERT INTO public."PRENOTAZIONI" VALUES (96, 'PR276', '2025-12-09 14:15:00+01', 2, 83.00, 'CONFERMATA', 'WEB', 46, 86);
INSERT INTO public."PRENOTAZIONI" VALUES (97, 'PR277', '2025-12-09 14:30:00+01', 1, 56.80, 'CONFERMATA', 'APP', 47, 87);
INSERT INTO public."PRENOTAZIONI" VALUES (98, 'PR278', '2025-12-09 14:45:00+01', 2, 56.00, 'CONFERMATA', 'TELEFONO', 48, 88);
INSERT INTO public."PRENOTAZIONI" VALUES (99, 'PR279', '2025-12-09 15:00:00+01', 1, 37.30, 'CONFERMATA', 'WEB', 49, 89);
INSERT INTO public."PRENOTAZIONI" VALUES (100, 'PR280', '2025-12-09 15:15:00+01', 3, 186.00, 'CONFERMATA', 'APP', 50, 90);
INSERT INTO public."PRENOTAZIONI" VALUES (101, 'PR281', '2025-12-09 15:30:00+01', 1, 72.30, 'CONFERMATA', 'AGENZIA', 1, 91);
INSERT INTO public."PRENOTAZIONI" VALUES (102, 'PR282', '2025-12-09 15:45:00+01', 2, 43.80, 'CONFERMATA', 'WEB', 2, 92);
INSERT INTO public."PRENOTAZIONI" VALUES (103, 'PR283', '2025-12-09 16:00:00+01', 1, 24.00, 'CONFERMATA', 'APP', 3, 93);
INSERT INTO public."PRENOTAZIONI" VALUES (104, 'PR284', '2025-12-09 16:15:00+01', 2, 72.40, 'CONFERMATA', 'TELEFONO', 4, 94);
INSERT INTO public."PRENOTAZIONI" VALUES (105, 'PR285', '2025-12-09 16:30:00+01', 1, 79.40, 'CONFERMATA', 'WEB', 5, 95);
INSERT INTO public."PRENOTAZIONI" VALUES (106, 'PR286', '2025-12-09 16:45:00+01', 3, 189.00, 'CONFERMATA', 'APP', 6, 96);
INSERT INTO public."PRENOTAZIONI" VALUES (107, 'PR287', '2025-12-09 17:00:00+01', 1, 72.10, 'CONFERMATA', 'AGENZIA', 7, 97);
INSERT INTO public."PRENOTAZIONI" VALUES (108, 'PR288', '2025-12-09 17:15:00+01', 2, 42.80, 'CONFERMATA', 'WEB', 8, 98);
INSERT INTO public."PRENOTAZIONI" VALUES (109, 'PR289', '2025-12-09 17:30:00+01', 1, 29.00, 'CONFERMATA', 'APP', 9, 99);
INSERT INTO public."PRENOTAZIONI" VALUES (110, 'PR290', '2025-12-09 17:45:00+01', 4, 236.00, 'CONFERMATA', 'TELEFONO', 10, 100);
INSERT INTO public."PRENOTAZIONI" VALUES (111, 'PR291', '2025-12-09 18:00:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 11, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (112, 'PR292', '2025-12-09 18:15:00+01', 2, 84.00, 'CONFERMATA', 'APP', 12, 2);
INSERT INTO public."PRENOTAZIONI" VALUES (113, 'PR293', '2025-12-09 18:30:00+01', 1, 39.00, 'CONFERMATA', 'AGENZIA', 13, 3);
INSERT INTO public."PRENOTAZIONI" VALUES (114, 'PR294', '2025-12-09 18:45:00+01', 3, 156.00, 'CONFERMATA', 'WEB', 14, 4);
INSERT INTO public."PRENOTAZIONI" VALUES (115, 'PR295', '2025-12-09 19:00:00+01', 1, 52.00, 'CONFERMATA', 'APP', 15, 5);
INSERT INTO public."PRENOTAZIONI" VALUES (116, 'PR296', '2025-12-09 19:15:00+01', 2, 88.00, 'CONFERMATA', 'TELEFONO', 16, 6);
INSERT INTO public."PRENOTAZIONI" VALUES (117, 'PR297', '2025-12-09 19:30:00+01', 1, 56.00, 'CONFERMATA', 'WEB', 17, 7);
INSERT INTO public."PRENOTAZIONI" VALUES (118, 'PR298', '2025-12-09 19:45:00+01', 2, 56.00, 'CONFERMATA', 'APP', 18, 8);
INSERT INTO public."PRENOTAZIONI" VALUES (119, 'PR299', '2025-12-09 20:00:00+01', 1, 67.00, 'CONFERMATA', 'AGENZIA', 19, 9);
INSERT INTO public."PRENOTAZIONI" VALUES (120, 'PR300', '2025-12-09 20:15:00+01', 4, 90.00, 'CONFERMATA', 'WEB', 20, 10);
INSERT INTO public."PRENOTAZIONI" VALUES (121, 'PRGRAPH001', '2025-11-09 09:00:00+01', 1, 42.00, 'CONFERMATA', 'WEB', 1, 1);
INSERT INTO public."PRENOTAZIONI" VALUES (122, 'PRGRAPH002', '2025-11-10 10:00:00+01', 2, 78.00, 'CONFERMATA', 'APP', 2, 2);
INSERT INTO public."PRENOTAZIONI" VALUES (123, 'PRGRAPH003', '2025-11-11 11:00:00+01', 1, 52.00, 'CONFERMATA', 'WEB', 3, 3);
INSERT INTO public."PRENOTAZIONI" VALUES (124, 'PRGRAPH004', '2025-11-12 09:30:00+01', 2, 87.00, 'CONFERMATA', 'TELEFONO', 4, 4);
INSERT INTO public."PRENOTAZIONI" VALUES (125, 'PRGRAPH005', '2025-11-13 10:30:00+01', 1, 32.50, 'CONFERMATA', 'APP', 5, 5);
INSERT INTO public."PRENOTAZIONI" VALUES (126, 'PRGRAPH006', '2025-11-14 11:30:00+01', 2, 44.00, 'CONFERMATA', 'WEB', 6, 6);
INSERT INTO public."PRENOTAZIONI" VALUES (127, 'PRGRAPH007', '2025-11-15 09:00:00+01', 1, 56.00, 'CONFERMATA', 'AGENZIA', 7, 7);
INSERT INTO public."PRENOTAZIONI" VALUES (128, 'PRGRAPH008', '2025-11-16 10:00:00+01', 3, 56.00, 'CONFERMATA', 'APP', 8, 8);
INSERT INTO public."PRENOTAZIONI" VALUES (129, 'PRGRAPH009', '2025-11-17 11:00:00+01', 1, 67.00, 'CONFERMATA', 'WEB', 9, 9);
INSERT INTO public."PRENOTAZIONI" VALUES (130, 'PRGRAPH010', '2025-11-18 09:30:00+01', 2, 22.50, 'CONFERMATA', 'TELEFONO', 10, 10);
INSERT INTO public."PRENOTAZIONI" VALUES (131, 'PRGRAPH011', '2025-11-19 10:30:00+01', 1, 59.00, 'CONFERMATA', 'APP', 11, 11);
INSERT INTO public."PRENOTAZIONI" VALUES (132, 'PRGRAPH012', '2025-11-20 11:30:00+01', 2, 92.00, 'CONFERMATA', 'WEB', 12, 12);
INSERT INTO public."PRENOTAZIONI" VALUES (133, 'PRGRAPH013', '2025-11-21 09:00:00+01', 1, 71.00, 'CONFERMATA', 'AGENZIA', 13, 13);
INSERT INTO public."PRENOTAZIONI" VALUES (134, 'PRGRAPH014', '2025-11-22 10:00:00+01', 3, 102.90, 'CONFERMATA', 'APP', 14, 14);
INSERT INTO public."PRENOTAZIONI" VALUES (135, 'PRGRAPH015', '2025-11-23 11:00:00+01', 1, 34.30, 'CONFERMATA', 'WEB', 15, 15);
INSERT INTO public."PRENOTAZIONI" VALUES (136, 'PRGRAPH016', '2025-11-24 09:30:00+01', 2, 83.00, 'CONFERMATA', 'TELEFONO', 16, 16);
INSERT INTO public."PRENOTAZIONI" VALUES (137, 'PRGRAPH017', '2025-11-25 10:30:00+01', 1, 56.80, 'CONFERMATA', 'APP', 17, 17);
INSERT INTO public."PRENOTAZIONI" VALUES (138, 'PRGRAPH018', '2025-11-26 11:30:00+01', 2, 56.00, 'CONFERMATA', 'WEB', 18, 18);
INSERT INTO public."PRENOTAZIONI" VALUES (139, 'PRGRAPH019', '2025-11-27 09:00:00+01', 1, 37.30, 'CONFERMATA', 'AGENZIA', 19, 19);
INSERT INTO public."PRENOTAZIONI" VALUES (140, 'PRGRAPH020', '2025-11-28 10:00:00+01', 3, 186.00, 'CONFERMATA', 'APP', 20, 20);
INSERT INTO public."PRENOTAZIONI" VALUES (141, 'PRGRAPH021', '2025-11-29 11:00:00+01', 1, 72.30, 'CONFERMATA', 'WEB', 21, 21);
INSERT INTO public."PRENOTAZIONI" VALUES (142, 'PRGRAPH022', '2025-11-30 09:30:00+01', 2, 43.80, 'CONFERMATA', 'TELEFONO', 22, 22);
INSERT INTO public."PRENOTAZIONI" VALUES (143, 'PRGRAPH023', '2025-12-01 10:30:00+01', 1, 24.00, 'CONFERMATA', 'APP', 23, 23);
INSERT INTO public."PRENOTAZIONI" VALUES (144, 'PRGRAPH024', '2025-12-02 11:30:00+01', 2, 72.40, 'CONFERMATA', 'WEB', 24, 24);
INSERT INTO public."PRENOTAZIONI" VALUES (145, 'PRGRAPH025', '2025-12-03 09:00:00+01', 1, 79.40, 'CONFERMATA', 'AGENZIA', 25, 25);
INSERT INTO public."PRENOTAZIONI" VALUES (146, 'PRGRAPH026', '2025-12-04 10:00:00+01', 3, 189.00, 'CONFERMATA', 'APP', 26, 26);
INSERT INTO public."PRENOTAZIONI" VALUES (147, 'PRGRAPH027', '2025-12-05 11:00:00+01', 1, 72.10, 'CONFERMATA', 'WEB', 27, 27);
INSERT INTO public."PRENOTAZIONI" VALUES (148, 'PRGRAPH028', '2025-12-06 09:30:00+01', 2, 42.80, 'CONFERMATA', 'TELEFONO', 28, 28);
INSERT INTO public."PRENOTAZIONI" VALUES (149, 'PRGRAPH029', '2025-12-07 10:30:00+01', 1, 29.00, 'CONFERMATA', 'APP', 29, 29);
INSERT INTO public."PRENOTAZIONI" VALUES (150, 'PRGRAPH030', '2025-12-08 11:30:00+01', 4, 236.00, 'CONFERMATA', 'WEB', 30, 30);


--
-- TOC entry 6312 (class 0 OID 16630)
-- Dependencies: 238
-- Data for Name: PREZZI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PREZZI" VALUES (1, 1, 1, 'STANDARD', '2025-11-16 12:00:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 42.00, 45.00, 47.00, 1);
INSERT INTO public."PREZZI" VALUES (2, 2, 2, 'STANDARD', '2025-11-16 12:01:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 39.00, 41.00, 44.00, 2);
INSERT INTO public."PREZZI" VALUES (3, 3, 3, 'PREMIUM', '2025-11-16 12:02:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 52.00, 54.00, 56.00, 3);
INSERT INTO public."PREZZI" VALUES (4, 4, 4, 'BUSINESS', '2025-11-16 12:03:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-15', 87.00, 89.00, 91.00, 4);
INSERT INTO public."PREZZI" VALUES (5, 5, 5, 'STANDARD', '2025-11-16 12:04:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 32.50, 35.50, 38.00, 5);
INSERT INTO public."PREZZI" VALUES (6, 6, 6, 'PREMIUM', '2025-11-16 12:05:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 44.00, 46.00, 49.00, 6);
INSERT INTO public."PREZZI" VALUES (7, 7, 7, 'BUSINESS', '2025-11-16 12:06:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 56.00, 58.00, 61.00, 7);
INSERT INTO public."PREZZI" VALUES (8, 8, 8, 'STANDARD', '2025-11-16 12:07:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 28.00, 31.00, 32.00, 8);
INSERT INTO public."PREZZI" VALUES (9, 9, 9, 'PREMIUM', '2025-11-16 12:08:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-31', 67.00, 69.00, 71.00, 9);
INSERT INTO public."PREZZI" VALUES (10, 10, 10, 'BUSINESS', '2025-11-16 12:09:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 22.50, 24.00, 26.50, 10);
INSERT INTO public."PREZZI" VALUES (11, 11, 1, 'STANDARD', '2025-11-16 12:10:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 59.00, 62.00, 65.00, 11);
INSERT INTO public."PREZZI" VALUES (12, 12, 2, 'PREMIUM', '2025-11-16 12:11:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 46.00, 48.00, 51.00, 12);
INSERT INTO public."PREZZI" VALUES (13, 13, 3, 'BUSINESS', '2025-11-16 12:12:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-12-01', 71.00, 73.00, 76.00, 13);
INSERT INTO public."PREZZI" VALUES (14, 14, 4, 'STANDARD', '2025-11-16 12:13:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 34.30, 36.40, 38.45, 14);
INSERT INTO public."PREZZI" VALUES (15, 15, 5, 'PREMIUM', '2025-11-16 12:14:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 41.50, 44.30, 47.00, 15);
INSERT INTO public."PREZZI" VALUES (16, 16, 6, 'BUSINESS', '2025-11-16 12:15:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 49.00, 51.30, 52.80, 16);
INSERT INTO public."PREZZI" VALUES (17, 17, 7, 'STANDARD', '2025-11-16 12:16:00+01', NULL, 'ATTIVO', '2025-11-01', '2025-11-30', 56.80, 57.40, 59.20, 17);
INSERT INTO public."PREZZI" VALUES (18, 18, 8, 'PREMIUM', '2025-11-16 12:17:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 28.00, 29.10, 30.20, 18);
INSERT INTO public."PREZZI" VALUES (19, 19, 9, 'BUSINESS', '2025-11-16 12:18:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 37.30, 39.90, 41.10, 19);
INSERT INTO public."PREZZI" VALUES (20, 20, 10, 'STANDARD', '2025-11-16 12:19:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 62.00, 63.60, 67.10, 20);
INSERT INTO public."PREZZI" VALUES (21, 21, 1, 'PREMIUM', '2025-11-16 12:20:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 72.30, 75.00, 76.90, 21);
INSERT INTO public."PREZZI" VALUES (22, 22, 2, 'BUSINESS', '2025-11-16 12:21:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 21.90, 22.50, 23.20, 22);
INSERT INTO public."PREZZI" VALUES (23, 23, 3, 'STANDARD', '2025-11-16 12:22:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 24.00, 25.90, 28.10, 23);
INSERT INTO public."PREZZI" VALUES (24, 24, 4, 'PREMIUM', '2025-11-16 12:23:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 36.20, 37.55, 39.99, 24);
INSERT INTO public."PREZZI" VALUES (25, 25, 5, 'BUSINESS', '2025-11-16 12:24:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 79.40, 80.50, 82.00, 25);
INSERT INTO public."PREZZI" VALUES (26, 26, 6, 'STANDARD', '2025-11-16 12:25:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 63.00, 65.00, 67.50, 26);
INSERT INTO public."PREZZI" VALUES (27, 27, 7, 'PREMIUM', '2025-11-16 12:26:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 72.10, 74.00, 77.50, 27);
INSERT INTO public."PREZZI" VALUES (28, 28, 8, 'BUSINESS', '2025-11-16 12:27:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 21.40, 22.00, 22.90, 28);
INSERT INTO public."PREZZI" VALUES (29, 29, 9, 'STANDARD', '2025-11-16 12:28:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 29.00, 31.00, 32.50, 29);
INSERT INTO public."PREZZI" VALUES (30, 30, 10, 'PREMIUM', '2025-11-16 12:29:00+01', NULL, 'ATTIVO', '2025-11-01', NULL, 59.00, 61.00, 63.50, 30);
INSERT INTO public."PREZZI" VALUES (31, 1, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 45.00, 48.50, 52.00, 1);
INSERT INTO public."PREZZI" VALUES (32, 1, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 51.75, 55.80, 59.80, 1);
INSERT INTO public."PREZZI" VALUES (33, 1, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 58.50, 63.10, 67.60, 1);
INSERT INTO public."PREZZI" VALUES (34, 2, 2, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 38.00, 41.00, 44.50, 2);
INSERT INTO public."PREZZI" VALUES (35, 2, 2, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 43.70, 47.15, 51.20, 2);
INSERT INTO public."PREZZI" VALUES (36, 2, 2, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 49.40, 53.30, 57.85, 2);
INSERT INTO public."PREZZI" VALUES (37, 3, 3, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 52.00, 56.00, 60.00, 3);
INSERT INTO public."PREZZI" VALUES (38, 3, 3, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 59.80, 64.40, 69.00, 3);
INSERT INTO public."PREZZI" VALUES (39, 3, 3, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 67.60, 72.80, 78.00, 3);
INSERT INTO public."PREZZI" VALUES (40, 4, 4, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 28.00, 30.00, 32.50, 4);
INSERT INTO public."PREZZI" VALUES (41, 4, 4, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 32.20, 34.50, 37.40, 4);
INSERT INTO public."PREZZI" VALUES (42, 4, 4, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 36.40, 39.00, 42.25, 4);
INSERT INTO public."PREZZI" VALUES (43, 5, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 62.00, 67.00, 72.00, 5);
INSERT INTO public."PREZZI" VALUES (44, 5, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 71.30, 77.05, 82.80, 5);
INSERT INTO public."PREZZI" VALUES (45, 5, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 80.60, 87.10, 93.60, 5);
INSERT INTO public."PREZZI" VALUES (46, 6, 6, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 48.00, 51.75, 55.50, 6);
INSERT INTO public."PREZZI" VALUES (47, 6, 6, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 55.20, 59.50, 63.83, 6);
INSERT INTO public."PREZZI" VALUES (48, 6, 6, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 62.40, 67.25, 72.15, 6);
INSERT INTO public."PREZZI" VALUES (49, 1, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 46.00, 49.50, 53.00, 7);
INSERT INTO public."PREZZI" VALUES (50, 1, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 52.90, 56.94, 60.95, 7);
INSERT INTO public."PREZZI" VALUES (51, 1, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 59.80, 64.38, 68.90, 7);
INSERT INTO public."PREZZI" VALUES (52, 3, 3, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 35.00, 37.75, 41.00, 8);
INSERT INTO public."PREZZI" VALUES (53, 3, 3, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 40.25, 43.41, 47.15, 8);
INSERT INTO public."PREZZI" VALUES (54, 3, 3, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 45.50, 49.07, 53.30, 8);
INSERT INTO public."PREZZI" VALUES (55, 7, 7, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 75.00, 81.00, 87.00, 9);
INSERT INTO public."PREZZI" VALUES (56, 7, 7, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 86.25, 93.15, 100.05, 9);
INSERT INTO public."PREZZI" VALUES (57, 7, 7, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 97.50, 105.30, 113.10, 9);
INSERT INTO public."PREZZI" VALUES (58, 2, 8, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 55.00, 59.25, 64.00, 10);
INSERT INTO public."PREZZI" VALUES (59, 2, 8, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 63.25, 68.14, 73.60, 10);
INSERT INTO public."PREZZI" VALUES (60, 2, 8, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 71.50, 77.02, 83.20, 10);
INSERT INTO public."PREZZI" VALUES (61, 1, 9, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 64.00, 69.00, 74.50, 11);
INSERT INTO public."PREZZI" VALUES (62, 1, 9, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 73.60, 79.35, 85.68, 11);
INSERT INTO public."PREZZI" VALUES (63, 1, 9, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 83.20, 89.70, 96.82, 11);
INSERT INTO public."PREZZI" VALUES (64, 3, 2, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 42.00, 45.30, 49.00, 12);
INSERT INTO public."PREZZI" VALUES (65, 3, 2, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 48.30, 52.10, 56.35, 12);
INSERT INTO public."PREZZI" VALUES (66, 3, 2, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 54.60, 58.90, 63.70, 12);
INSERT INTO public."PREZZI" VALUES (67, 2, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 32.00, 34.50, 37.50, 13);
INSERT INTO public."PREZZI" VALUES (68, 2, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 36.80, 39.68, 43.13, 13);
INSERT INTO public."PREZZI" VALUES (69, 2, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 41.60, 44.85, 48.75, 13);
INSERT INTO public."PREZZI" VALUES (70, 1, 6, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 39.00, 42.00, 45.50, 14);
INSERT INTO public."PREZZI" VALUES (71, 1, 6, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 44.85, 48.30, 52.33, 14);
INSERT INTO public."PREZZI" VALUES (72, 1, 6, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 50.70, 54.60, 59.15, 14);
INSERT INTO public."PREZZI" VALUES (73, 3, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 85.00, 91.75, 99.00, 15);
INSERT INTO public."PREZZI" VALUES (74, 3, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 97.75, 105.51, 113.85, 15);
INSERT INTO public."PREZZI" VALUES (75, 3, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 110.50, 119.28, 128.70, 15);
INSERT INTO public."PREZZI" VALUES (76, 1, 8, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 54.00, 58.30, 63.00, 16);
INSERT INTO public."PREZZI" VALUES (77, 1, 8, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 62.10, 67.05, 72.45, 16);
INSERT INTO public."PREZZI" VALUES (78, 1, 8, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 70.20, 75.80, 81.90, 16);
INSERT INTO public."PREZZI" VALUES (79, 2, 7, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 18.00, 19.40, 21.00, 17);
INSERT INTO public."PREZZI" VALUES (80, 2, 7, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 20.70, 22.31, 24.15, 17);
INSERT INTO public."PREZZI" VALUES (81, 2, 7, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 23.40, 25.23, 27.30, 17);
INSERT INTO public."PREZZI" VALUES (82, 1, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 45.50, 49.00, 53.00, 18);
INSERT INTO public."PREZZI" VALUES (83, 1, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 52.33, 56.35, 60.95, 18);
INSERT INTO public."PREZZI" VALUES (84, 1, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 59.15, 63.70, 68.90, 18);
INSERT INTO public."PREZZI" VALUES (85, 2, 9, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 63.50, 68.50, 74.00, 19);
INSERT INTO public."PREZZI" VALUES (86, 2, 9, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 73.03, 78.78, 85.10, 19);
INSERT INTO public."PREZZI" VALUES (87, 2, 9, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 82.55, 89.05, 96.20, 19);
INSERT INTO public."PREZZI" VALUES (88, 3, 4, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 30.00, 32.40, 35.00, 20);
INSERT INTO public."PREZZI" VALUES (89, 3, 4, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 34.50, 37.26, 40.25, 20);
INSERT INTO public."PREZZI" VALUES (90, 3, 4, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 39.00, 42.12, 45.50, 20);
INSERT INTO public."PREZZI" VALUES (91, 2, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 72.00, 77.70, 84.00, 21);
INSERT INTO public."PREZZI" VALUES (92, 2, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 82.80, 89.36, 96.60, 21);
INSERT INTO public."PREZZI" VALUES (93, 2, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 93.60, 101.01, 109.20, 21);
INSERT INTO public."PREZZI" VALUES (94, 1, 2, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 50.00, 54.00, 58.50, 22);
INSERT INTO public."PREZZI" VALUES (95, 1, 2, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 57.50, 62.10, 67.28, 22);
INSERT INTO public."PREZZI" VALUES (96, 1, 2, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 65.00, 70.20, 76.05, 22);
INSERT INTO public."PREZZI" VALUES (97, 2, 3, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 44.00, 47.40, 51.20, 23);
INSERT INTO public."PREZZI" VALUES (98, 2, 3, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 50.60, 54.51, 58.88, 23);
INSERT INTO public."PREZZI" VALUES (99, 2, 3, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 57.20, 61.62, 66.56, 23);
INSERT INTO public."PREZZI" VALUES (100, 3, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 26.00, 28.00, 30.50, 24);
INSERT INTO public."PREZZI" VALUES (101, 3, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 29.90, 32.20, 35.08, 24);
INSERT INTO public."PREZZI" VALUES (102, 3, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 33.80, 36.40, 39.65, 24);
INSERT INTO public."PREZZI" VALUES (103, 2, 8, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 68.00, 73.30, 79.20, 25);
INSERT INTO public."PREZZI" VALUES (104, 2, 8, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 78.20, 84.30, 91.08, 25);
INSERT INTO public."PREZZI" VALUES (105, 2, 8, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 88.40, 95.30, 102.96, 25);
INSERT INTO public."PREZZI" VALUES (106, 1, 6, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 56.00, 60.40, 65.00, 26);
INSERT INTO public."PREZZI" VALUES (107, 1, 6, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 64.40, 69.46, 74.75, 26);
INSERT INTO public."PREZZI" VALUES (108, 1, 6, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 72.80, 78.52, 84.50, 26);
INSERT INTO public."PREZZI" VALUES (109, 3, 7, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 22.00, 23.70, 25.50, 27);
INSERT INTO public."PREZZI" VALUES (110, 3, 7, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 25.30, 27.26, 29.33, 27);
INSERT INTO public."PREZZI" VALUES (111, 3, 7, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 28.60, 30.82, 33.15, 27);
INSERT INTO public."PREZZI" VALUES (112, 2, 4, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 20.00, 21.60, 23.50, 28);
INSERT INTO public."PREZZI" VALUES (113, 2, 4, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 23.00, 24.84, 27.03, 28);
INSERT INTO public."PREZZI" VALUES (114, 2, 4, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 26.00, 28.08, 30.55, 28);
INSERT INTO public."PREZZI" VALUES (115, 1, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 45.00, 48.50, 52.00, 29);
INSERT INTO public."PREZZI" VALUES (116, 1, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 51.75, 55.78, 59.80, 29);
INSERT INTO public."PREZZI" VALUES (117, 1, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 58.50, 63.10, 67.60, 29);
INSERT INTO public."PREZZI" VALUES (118, 2, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 70.00, 75.50, 81.50, 30);
INSERT INTO public."PREZZI" VALUES (119, 2, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 80.50, 86.83, 93.73, 30);
INSERT INTO public."PREZZI" VALUES (120, 2, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 91.00, 98.15, 105.00, 30);
INSERT INTO public."PREZZI" VALUES (121, 3, 2, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 58.00, 62.60, 67.50, 31);
INSERT INTO public."PREZZI" VALUES (122, 3, 2, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 66.70, 71.99, 77.63, 31);
INSERT INTO public."PREZZI" VALUES (123, 3, 2, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 75.40, 81.38, 87.75, 31);
INSERT INTO public."PREZZI" VALUES (124, 2, 8, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 25.00, 27.00, 29.50, 32);
INSERT INTO public."PREZZI" VALUES (125, 2, 8, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 28.75, 31.05, 33.93, 32);
INSERT INTO public."PREZZI" VALUES (126, 2, 8, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 32.50, 35.10, 38.35, 32);
INSERT INTO public."PREZZI" VALUES (127, 1, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 60.00, 64.80, 70.00, 33);
INSERT INTO public."PREZZI" VALUES (128, 1, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 69.00, 74.52, 80.50, 33);
INSERT INTO public."PREZZI" VALUES (129, 1, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 78.00, 84.24, 91.00, 33);
INSERT INTO public."PREZZI" VALUES (130, 3, 3, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 40.00, 43.20, 47.00, 34);
INSERT INTO public."PREZZI" VALUES (131, 3, 3, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 46.00, 49.68, 54.05, 34);
INSERT INTO public."PREZZI" VALUES (132, 3, 3, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 52.00, 56.16, 61.10, 34);
INSERT INTO public."PREZZI" VALUES (133, 2, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 24.00, 25.90, 28.00, 35);
INSERT INTO public."PREZZI" VALUES (134, 2, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 27.60, 29.79, 32.20, 35);
INSERT INTO public."PREZZI" VALUES (135, 2, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 31.20, 33.66, 36.40, 35);
INSERT INTO public."PREZZI" VALUES (136, 1, 2, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 47.00, 50.70, 54.50, 36);
INSERT INTO public."PREZZI" VALUES (137, 1, 2, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 54.05, 58.30, 62.68, 36);
INSERT INTO public."PREZZI" VALUES (138, 1, 2, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 61.10, 65.90, 70.85, 36);
INSERT INTO public."PREZZI" VALUES (139, 3, 4, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 29.00, 31.30, 33.80, 37);
INSERT INTO public."PREZZI" VALUES (140, 3, 4, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 33.35, 36.00, 38.87, 37);
INSERT INTO public."PREZZI" VALUES (141, 3, 4, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 37.70, 40.69, 43.94, 37);
INSERT INTO public."PREZZI" VALUES (142, 2, 8, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 35.00, 37.75, 41.00, 38);
INSERT INTO public."PREZZI" VALUES (143, 2, 8, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 40.25, 43.41, 47.15, 38);
INSERT INTO public."PREZZI" VALUES (144, 2, 8, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 45.50, 49.07, 53.30, 38);
INSERT INTO public."PREZZI" VALUES (145, 1, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 44.50, 48.00, 52.00, 39);
INSERT INTO public."PREZZI" VALUES (146, 1, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 51.18, 55.20, 59.80, 39);
INSERT INTO public."PREZZI" VALUES (147, 1, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 57.85, 62.40, 67.60, 39);
INSERT INTO public."PREZZI" VALUES (148, 2, 7, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 82.00, 88.50, 96.00, 40);
INSERT INTO public."PREZZI" VALUES (149, 2, 7, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 94.30, 101.78, 110.40, 40);
INSERT INTO public."PREZZI" VALUES (150, 2, 7, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 106.60, 115.05, 124.80, 40);
INSERT INTO public."PREZZI" VALUES (151, 3, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 88.00, 94.90, 102.50, 41);
INSERT INTO public."PREZZI" VALUES (152, 3, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 101.20, 109.14, 117.88, 41);
INSERT INTO public."PREZZI" VALUES (153, 3, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 114.40, 123.38, 133.25, 41);
INSERT INTO public."PREZZI" VALUES (154, 1, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 42.00, 45.30, 49.00, 42);
INSERT INTO public."PREZZI" VALUES (155, 1, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 48.30, 52.10, 56.35, 42);
INSERT INTO public."PREZZI" VALUES (156, 1, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 54.60, 58.90, 63.70, 42);
INSERT INTO public."PREZZI" VALUES (157, 2, 6, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 34.00, 36.70, 39.50, 43);
INSERT INTO public."PREZZI" VALUES (158, 2, 6, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 39.10, 42.21, 45.43, 43);
INSERT INTO public."PREZZI" VALUES (159, 2, 6, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 44.20, 47.72, 51.35, 43);
INSERT INTO public."PREZZI" VALUES (160, 2, 7, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 95.00, 102.50, 111.00, 44);
INSERT INTO public."PREZZI" VALUES (161, 2, 7, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 109.25, 117.88, 127.65, 44);
INSERT INTO public."PREZZI" VALUES (162, 2, 7, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 123.50, 133.25, 144.30, 44);
INSERT INTO public."PREZZI" VALUES (163, 3, 5, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 18.00, 19.40, 21.00, 45);
INSERT INTO public."PREZZI" VALUES (164, 3, 5, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 20.70, 22.31, 24.15, 45);
INSERT INTO public."PREZZI" VALUES (165, 3, 5, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 23.40, 25.23, 27.30, 45);
INSERT INTO public."PREZZI" VALUES (166, 1, 9, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 78.00, 84.15, 91.00, 46);
INSERT INTO public."PREZZI" VALUES (167, 1, 9, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 89.70, 96.77, 104.65, 46);
INSERT INTO public."PREZZI" VALUES (168, 1, 9, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 101.40, 109.38, 118.30, 46);
INSERT INTO public."PREZZI" VALUES (169, 2, 4, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 21.00, 22.70, 24.20, 47);
INSERT INTO public."PREZZI" VALUES (170, 2, 4, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 24.15, 26.10, 27.83, 47);
INSERT INTO public."PREZZI" VALUES (171, 2, 4, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 27.30, 29.50, 31.46, 47);
INSERT INTO public."PREZZI" VALUES (172, 3, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 36.00, 38.90, 41.50, 48);
INSERT INTO public."PREZZI" VALUES (173, 3, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 41.40, 44.74, 47.73, 48);
INSERT INTO public."PREZZI" VALUES (174, 3, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 46.80, 50.58, 53.95, 48);
INSERT INTO public."PREZZI" VALUES (175, 1, 10, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 91.00, 98.20, 106.50, 49);
INSERT INTO public."PREZZI" VALUES (176, 1, 10, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 104.65, 112.93, 122.48, 49);
INSERT INTO public."PREZZI" VALUES (177, 1, 10, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 118.30, 127.66, 138.45, 49);
INSERT INTO public."PREZZI" VALUES (178, 2, 1, 'STANDARD', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 46.00, 49.65, 53.50, 50);
INSERT INTO public."PREZZI" VALUES (179, 2, 1, 'PREMIUM', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 52.90, 57.10, 61.53, 50);
INSERT INTO public."PREZZI" VALUES (180, 2, 1, 'BUSINESS', '2025-12-14 18:54:10.937893+01', NULL, 'ATTIVO', '2025-12-01', '2026-12-31', 59.80, 64.55, 69.55, 50);


--
-- TOC entry 6297 (class 0 OID 16425)
-- Dependencies: 223
-- Data for Name: STAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."STAZIONI" VALUES (1, 'ROMA_T', 'Roma Termini', 'Roma', 'RM', 41.90100000, 12.50100000, '2025-11-07 18:56:03.619248+01', '0101000020E61000008D976E128300294017D9CEF753F34440');
INSERT INTO public."STAZIONI" VALUES (2, 'MILANO_C', 'Milano Centrale', 'Milano', 'MI', 45.48500000, 9.20400000, '2025-11-07 18:56:03.619248+01', '0101000020E61000009CC420B072682240AE47E17A14BE4640');
INSERT INTO public."STAZIONI" VALUES (3, 'NAPOLI_C', 'Napoli Centrale', 'Napoli', 'NA', 40.85200000, 14.27100000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000986E1283C08A2C40931804560E6D4440');
INSERT INTO public."STAZIONI" VALUES (4, 'TORINO_PN', 'Torino Porta Nuova', 'Torino', 'TO', 45.06200000, 7.67700000, '2025-11-07 18:56:03.619248+01', '0101000020E61000006891ED7C3FB51E400E2DB29DEF874640');
INSERT INTO public."STAZIONI" VALUES (5, 'FIRENZE_SMN', 'Firenze Santa Maria Novella', 'Firenze', 'FI', 43.77900000, 11.24600000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000CBA145B6F37D2640C1CAA145B6E34540');
INSERT INTO public."STAZIONI" VALUES (6, 'VENEZIA_SM', 'Venezia Santa Lucia', 'Venezia', 'VE', 45.44100000, 12.32100000, '2025-11-07 18:56:03.619248+01', '0101000020E61000003108AC1C5AA428409CC420B072B84640');
INSERT INTO public."STAZIONI" VALUES (7, 'BOLOGNA_C', 'Bologna Centrale', 'Bologna', 'BO', 44.50500000, 11.34300000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000560E2DB29DAF2640713D0AD7A3404640');
INSERT INTO public."STAZIONI" VALUES (8, 'GENOVA_PP', 'Genova Piazza Principe', 'Genova', 'GE', 44.42000000, 8.91500000, '2025-11-07 18:56:03.619248+01', '0101000020E610000014AE47E17AD42140F6285C8FC2354640');
INSERT INTO public."STAZIONI" VALUES (9, 'VERONA_PN', 'Verona Porta Nuova', 'Verona', 'VR', 45.42900000, 10.97800000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000DBF97E6ABCF42540F4FDD478E9B64640');
INSERT INTO public."STAZIONI" VALUES (10, 'PALERMO_C', 'Palermo Centrale', 'Palermo', 'PA', 38.11500000, 13.36700000, '2025-11-07 18:56:03.619248+01', '0101000020E610000096438B6CE7BB2A401F85EB51B80E4340');
INSERT INTO public."STAZIONI" VALUES (11, 'BARI_C', 'Bari Centrale', 'Bari', 'BA', 41.12200000, 16.86600000, '2025-11-07 18:56:03.619248+01', '0101000020E610000004560E2DB2DD3040560E2DB29D8F4440');
INSERT INTO public."STAZIONI" VALUES (12, 'SALERNO_C', 'Salerno', 'Salerno', 'SA', 40.68000000, 14.77300000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000B29DEFA7C68B2D40D7A3703D0A574440');
INSERT INTO public."STAZIONI" VALUES (13, 'FIRENZE_CM', 'Firenze Campo di Marte', 'Firenze', 'FI', 43.78100000, 11.28300000, '2025-11-07 18:56:03.619248+01', '0101000020E610000037894160E59026408716D9CEF7E34540');
INSERT INTO public."STAZIONI" VALUES (14, 'CATANIA_C', 'Catania Centrale', 'Catania', 'CT', 37.49900000, 15.08200000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000448B6CE7FB292E401D5A643BDFBF4240');
INSERT INTO public."STAZIONI" VALUES (15, 'PADOVA_C', 'Padova', 'Padova', 'PD', 45.41800000, 11.88200000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000DD24068195C327402FDD240681B54640');
INSERT INTO public."STAZIONI" VALUES (16, 'TRIESTE_C', 'Trieste Centrale', 'Trieste', 'TS', 45.65500000, 13.77100000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000986E1283C08A2B40A4703D0AD7D34640');
INSERT INTO public."STAZIONI" VALUES (17, 'FIRENZE_RF', 'Firenze Rifredi', 'Firenze', 'FI', 43.80700000, 11.23700000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000D34D6210587926409EEFA7C64BE74540');
INSERT INTO public."STAZIONI" VALUES (18, 'REGGIO_C', 'Reggio Calabria Centrale', 'Reggio Calabria', 'RC', 38.11400000, 15.64600000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000986E1283C04A2F403BDF4F8D970E4340');
INSERT INTO public."STAZIONI" VALUES (19, 'PISA_C', 'Pisa Centrale', 'Pisa', 'PI', 43.70300000, 10.40300000, '2025-11-07 18:56:03.619248+01', '0101000020E61000007593180456CE2440448B6CE7FBD94540');
INSERT INTO public."STAZIONI" VALUES (20, 'RIMINI_C', 'Rimini', 'Rimini', 'RN', 44.06100000, 12.57000000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000A4703D0AD72329402B8716D9CE074640');
INSERT INTO public."STAZIONI" VALUES (21, 'BRESCIA_C', 'Brescia', 'Brescia', 'BS', 45.54100000, 10.21400000, '2025-11-07 18:56:03.619248+01', '0101000020E610000021B07268916D24406891ED7C3FC54640');
INSERT INTO public."STAZIONI" VALUES (22, 'ANCONA_C', 'Ancona', 'Ancona', 'AN', 43.59900000, 13.49200000, '2025-11-07 18:56:03.619248+01', '0101000020E610000096438B6CE7FB2A40E9263108ACCC4540');
INSERT INTO public."STAZIONI" VALUES (23, 'SIRACUSA_C', 'Siracusa', 'Siracusa', 'SR', 37.06800000, 15.29300000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000BC74931804962E4062105839B4884240');
INSERT INTO public."STAZIONI" VALUES (24, 'LUCCA_C', 'Lucca', 'Lucca', 'LU', 43.84300000, 10.50600000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000508D976E1203254096438B6CE7EB4540');
INSERT INTO public."STAZIONI" VALUES (25, 'AREZZO_C', 'Arezzo', 'Arezzo', 'AR', 43.46500000, 11.87700000, '2025-11-07 18:56:03.619248+01', '0101000020E61000001B2FDD2406C12740EC51B81E85BB4540');
INSERT INTO public."STAZIONI" VALUES (26, 'LECCE_C', 'Lecce', 'Lecce', 'LE', 40.35300000, 18.17300000, '2025-11-07 18:56:03.619248+01', '0101000020E61000003F355EBA492C324077BE9F1A2F2D4440');
INSERT INTO public."STAZIONI" VALUES (27, 'CASERTA_C', 'Caserta', 'Caserta', 'CE', 41.07200000, 14.33100000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000B6F3FDD478A92C40F0A7C64B37894440');
INSERT INTO public."STAZIONI" VALUES (28, 'PIACENZA_C', 'Piacenza', 'Piacenza', 'PC', 45.05000000, 9.69300000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000894160E5D06223406666666666864640');
INSERT INTO public."STAZIONI" VALUES (29, 'PESCARA_C', 'Pescara Centrale', 'Pescara', 'PE', 42.46700000, 14.20500000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000295C8FC2F5682C40B29DEFA7C63B4540');
INSERT INTO public."STAZIONI" VALUES (30, 'MESSINA_C', 'Messina Centrale', 'Messina', 'ME', 38.19300000, 15.55200000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000B4C876BE9F1A2F4062105839B4184340');
INSERT INTO public."STAZIONI" VALUES (31, 'MODENA_C', 'Modena', 'Modena', 'MO', 44.64800000, 10.93600000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000AC1C5A643BDF25406DE7FBA9F1524640');
INSERT INTO public."STAZIONI" VALUES (32, 'MESTRE_C', 'Venezia Mestre', 'Venezia', 'VE', 45.49300000, 12.24100000, '2025-11-07 18:56:03.619248+01', '0101000020E610000008AC1C5A647B2840C976BE9F1ABF4640');
INSERT INTO public."STAZIONI" VALUES (33, 'TRENTO_C', 'Trento', 'Trento', 'TN', 46.06200000, 11.12000000, '2025-11-07 18:56:03.619248+01', '0101000020E61000003D0AD7A3703D26400E2DB29DEF074740');
INSERT INTO public."STAZIONI" VALUES (34, 'BOLZANO_C', 'Bolzano', 'Bolzano', 'BZ', 46.49500000, 11.35400000, '2025-11-07 18:56:03.619248+01', '0101000020E61000006891ED7C3FB526408FC2F5285C3F4740');
INSERT INTO public."STAZIONI" VALUES (35, 'FORLI_C', 'Forlì', 'Forlì', 'FC', 44.22200000, 12.04000000, '2025-11-07 18:56:03.619248+01', '0101000020E610000014AE47E17A14284023DBF97E6A1C4640');
INSERT INTO public."STAZIONI" VALUES (36, 'ASTI_C', 'Asti', 'Asti', 'AT', 44.90000000, 8.20000000, '2025-11-07 18:56:03.619248+01', '0101000020E610000066666666666620403333333333734640');
INSERT INTO public."STAZIONI" VALUES (37, 'ALESSANDRIA_C', 'Alessandria', 'Alessandria', 'AL', 44.91300000, 8.61800000, '2025-11-07 18:56:03.619248+01', '0101000020E610000023DBF97E6A3C2140BE9F1A2FDD744640');
INSERT INTO public."STAZIONI" VALUES (38, 'PARMA_C', 'Parma', 'Parma', 'PR', 44.80600000, 10.32400000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000D9CEF753E3A52440BA490C022B674640');
INSERT INTO public."STAZIONI" VALUES (39, 'CUNEO_C', 'Cuneo', 'Cuneo', 'CN', 44.38500000, 7.54600000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000C976BE9F1A2F1E40E17A14AE47314640');
INSERT INTO public."STAZIONI" VALUES (40, 'PERUGIA_C', 'Perugia', 'Perugia', 'PG', 43.10200000, 12.38900000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000BA490C022BC72840931804560E8D4540');
INSERT INTO public."STAZIONI" VALUES (41, 'NOVARA_C', 'Novara', 'Novara', 'NO', 45.45800000, 8.62100000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000CBA145B6F33D2140B4C876BE9FBA4640');
INSERT INTO public."STAZIONI" VALUES (42, 'VARESE_C', 'Varese', 'Varese', 'VA', 45.82000000, 8.83300000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000D122DBF97EAA2140295C8FC2F5E84640');
INSERT INTO public."STAZIONI" VALUES (43, 'CREMONA_C', 'Cremona', 'Cremona', 'CR', 45.13200000, 10.03200000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000AAF1D24D6210244037894160E5904640');
INSERT INTO public."STAZIONI" VALUES (44, 'FERRARA_C', 'Ferrara', 'Ferrara', 'FE', 44.84200000, 11.60700000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000105839B4C8362740B29DEFA7C66B4640');
INSERT INTO public."STAZIONI" VALUES (45, 'SAVONA_C', 'Savona', 'Savona', 'SV', 44.30900000, 8.48100000, '2025-11-07 18:56:03.619248+01', '0101000020E610000083C0CAA145F62040643BDF4F8D274640');
INSERT INTO public."STAZIONI" VALUES (46, 'LA_SPEZIA_C', 'La Spezia Centrale', 'La Spezia', 'SP', 44.10800000, 9.80800000, '2025-11-07 18:56:03.619248+01', '0101000020E610000004560E2DB29D2340E7FBA9F1D20D4640');
INSERT INTO public."STAZIONI" VALUES (47, 'RAVENNA_C', 'Ravenna', 'Ravenna', 'RA', 44.42000000, 12.19800000, '2025-11-07 18:56:03.619248+01', '0101000020E61000004C37894160652840F6285C8FC2354640');
INSERT INTO public."STAZIONI" VALUES (48, 'IMOLA_C', 'Imola', 'Imola', 'BO', 44.35800000, 11.70900000, '2025-11-07 18:56:03.619248+01', '0101000020E61000005EBA490C026B2740E7FBA9F1D22D4640');
INSERT INTO public."STAZIONI" VALUES (49, 'LUINO_C', 'Luino', 'Luino', 'VA', 46.00200000, 8.73200000, '2025-11-07 18:56:03.619248+01', '0101000020E6100000105839B4C8762140C74B378941004740');
INSERT INTO public."STAZIONI" VALUES (50, 'DOMODOSSOLA', 'Domodossola', 'Domodossola', 'VB', 46.11300000, 8.29400000, '2025-11-07 18:56:03.619248+01', '0101000020E61000004A0C022B879620405839B4C8760E4740');


--
-- TOC entry 6305 (class 0 OID 16526)
-- Dependencies: 231
-- Data for Name: TARIFFE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TARIFFE" VALUES (1, 'FR_BASE', 'Frecciarossa Base', 'Tariffa base Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" VALUES (2, 'FR_ECO', 'Frecciarossa Economy', 'Tariffa economy Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" VALUES (3, 'FR_SUP', 'Frecciarossa Super Economy', 'Tariffa super economy Frecciarossa', false, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" VALUES (4, 'FA_BASE', 'Frecciargento Base', 'Tariffa base Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" VALUES (5, 'FA_ECO', 'Frecciargento Economy', 'Tariffa economy Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" VALUES (6, 'IC_BASE', 'Intercity Base', 'Tariffa base Intercity', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" VALUES (7, 'IC_ECO', 'Intercity Economy', 'Tariffa economy Intercity', true, true, '2025-11-08 19:36:02.100249+01', 7.50);
INSERT INTO public."TARIFFE" VALUES (8, 'IC_SUP', 'Intercity Super Economy', 'Tariffa super economy Intercity', false, true, '2025-11-08 19:36:02.100249+01', 12.00);
INSERT INTO public."TARIFFE" VALUES (9, 'REG_BASE', 'Regionale Ordinaria', 'Tariffa ordinaria Regionale', true, true, '2025-11-08 19:36:02.100249+01', 0.00);
INSERT INTO public."TARIFFE" VALUES (10, 'REG_WEEK', 'Regionale Weekend', 'Tariffa week-end Regionale', true, true, '2025-11-08 19:36:02.100249+01', 5.00);
INSERT INTO public."TARIFFE" VALUES (11, 'REG_RID', 'Regionale Ridotto', 'Tariffa ridotta Regionale', true, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" VALUES (12, 'REG_FAM', 'Regionale Famiglia', 'Tariffa famiglia Regionale', true, true, '2025-11-08 19:36:02.100249+01', 18.99);
INSERT INTO public."TARIFFE" VALUES (13, 'FR_YOUTH', 'Frecciarossa Young', 'Tariffa giovani Frecciarossa', false, true, '2025-11-08 19:36:02.100249+01', 12.00);
INSERT INTO public."TARIFFE" VALUES (14, 'FR_SENIOR', 'Frecciarossa Senior', 'Tariffa over 65 Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" VALUES (15, 'FA_SUP', 'Frecciargento Super Economy', 'Tariffa super economy Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 9.99);
INSERT INTO public."TARIFFE" VALUES (16, 'IC_YOUTH', 'Intercity Young', 'Tariffa giovani Intercity', false, true, '2025-11-08 19:36:02.100249+01', 14.00);
INSERT INTO public."TARIFFE" VALUES (17, 'IC_SENIOR', 'Intercity Senior', 'Tariffa senior Intercity', true, true, '2025-11-08 19:36:02.100249+01', 16.00);
INSERT INTO public."TARIFFE" VALUES (18, 'REG_GRUPPO', 'Regionale Gruppo', 'Tariffa gruppi Regionale', false, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" VALUES (19, 'FR_FAM', 'Frecciarossa Famiglia', 'Tariffa di gruppo/famiglia Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" VALUES (20, 'FA_FAM', 'Frecciargento Famiglia', 'Tariffa di famiglia Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 13.00);
INSERT INTO public."TARIFFE" VALUES (21, 'IC_PRIV', 'Intercity Privilege', 'Tariffa Privilege Intercity', false, true, '2025-11-08 19:36:02.100249+01', 22.00);
INSERT INTO public."TARIFFE" VALUES (22, 'FR_PROMO', 'Frecciarossa Promo', 'Tariffa promozionale Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 25.00);
INSERT INTO public."TARIFFE" VALUES (23, 'FA_PROMO', 'Frecciargento Promo', 'Tariffa promozionale Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" VALUES (24, 'REG_PROMO', 'Regionale Promo', 'Tariffa promo Regionale', true, true, '2025-11-08 19:36:02.100249+01', 19.50);
INSERT INTO public."TARIFFE" VALUES (25, 'IC_PROMO', 'Intercity Promo', 'Tariffa promo Intercity', false, true, '2025-11-08 19:36:02.100249+01', 24.50);
INSERT INTO public."TARIFFE" VALUES (26, 'FR_NOTTE', 'Frecciarossa Notturna', 'Tariffa notturna Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" VALUES (27, 'FA_NOTTE', 'Frecciargento Notturna', 'Tariffa notturna Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 11.00);
INSERT INTO public."TARIFFE" VALUES (28, 'IC_NOTTE', 'Intercity Notturna', 'Tariffa notturna Intercity', true, true, '2025-11-08 19:36:02.100249+01', 16.80);
INSERT INTO public."TARIFFE" VALUES (29, 'REG_NOTTE', 'Regionale Notturna', 'Tariffa notturna Regionale', true, true, '2025-11-08 19:36:02.100249+01', 8.00);
INSERT INTO public."TARIFFE" VALUES (30, 'FR_LAST', 'Frecciarossa Last Minute', 'Tariffa last minute Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" VALUES (31, 'FA_LAST', 'Frecciargento Last Minute', 'Tariffa last minute Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" VALUES (32, 'IC_LAST', 'Intercity Last Minute', 'Tariffa last minute Intercity', true, true, '2025-11-08 19:36:02.100249+01', 17.00);
INSERT INTO public."TARIFFE" VALUES (33, 'REG_LAST', 'Regionale Last Minute', 'Tariffa last minute Regionale', false, true, '2025-11-08 19:36:02.100249+01', 12.30);
INSERT INTO public."TARIFFE" VALUES (34, 'FR_BUS', 'Frecciarossa Business', 'Tariffa business Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 28.00);
INSERT INTO public."TARIFFE" VALUES (35, 'FA_BUS', 'Frecciargento Business', 'Tariffa business Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 22.00);
INSERT INTO public."TARIFFE" VALUES (36, 'IC_BUS', 'Intercity Business', 'Tariffa business Intercity', false, true, '2025-11-08 19:36:02.100249+01', 29.00);
INSERT INTO public."TARIFFE" VALUES (37, 'REG_BUS', 'Regionale Business', 'Tariffa business Regionale', true, true, '2025-11-08 19:36:02.100249+01', 10.00);
INSERT INTO public."TARIFFE" VALUES (38, 'FR_PREM', 'Frecciarossa Premium', 'Tariffa premium Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 30.00);
INSERT INTO public."TARIFFE" VALUES (39, 'FA_PREM', 'Frecciargento Premium', 'Tariffa premium Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 23.00);
INSERT INTO public."TARIFFE" VALUES (40, 'IC_PREM', 'Intercity Premium', 'Tariffa premium Intercity', false, true, '2025-11-08 19:36:02.100249+01', 25.00);
INSERT INTO public."TARIFFE" VALUES (41, 'REG_PREM', 'Regionale Premium', 'Tariffa premium Regionale', true, true, '2025-11-08 19:36:02.100249+01', 15.00);
INSERT INTO public."TARIFFE" VALUES (42, 'FR_STU', 'Frecciarossa Studente', 'Tariffa studenti Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 20.00);
INSERT INTO public."TARIFFE" VALUES (43, 'FA_STU', 'Frecciargento Studente', 'Tariffa studenti Frecciargento', true, true, '2025-11-08 19:36:02.100249+01', 18.00);
INSERT INTO public."TARIFFE" VALUES (44, 'IC_STU', 'Intercity Studente', 'Tariffa studenti Intercity', false, true, '2025-11-08 19:36:02.100249+01', 14.00);
INSERT INTO public."TARIFFE" VALUES (45, 'REG_STU', 'Regionale Studente', 'Tariffa studenti Regionale', true, true, '2025-11-08 19:36:02.100249+01', 13.70);
INSERT INTO public."TARIFFE" VALUES (46, 'FR_ANN', 'Frecciarossa Annuale', 'Tariffa annuale Frecciarossa', true, true, '2025-11-08 19:36:02.100249+01', 35.00);
INSERT INTO public."TARIFFE" VALUES (47, 'FA_ANN', 'Frecciargento Annuale', 'Tariffa annuale Frecciargento', false, true, '2025-11-08 19:36:02.100249+01', 26.00);
INSERT INTO public."TARIFFE" VALUES (48, 'IC_ANN', 'Intercity Annuale', 'Tariffa annuale Intercity', true, true, '2025-11-08 19:36:02.100249+01', 30.00);
INSERT INTO public."TARIFFE" VALUES (49, 'REG_ANN', 'Regionale Annuale', 'Tariffa annuale Regionale', true, true, '2025-11-08 19:36:02.100249+01', 17.00);
INSERT INTO public."TARIFFE" VALUES (50, 'FR_GRAT', 'Frecciarossa Gratuita', 'Tariffa gratuita Frecciarossa', true, false, '2025-11-08 19:36:02.100249+01', 100.01);


--
-- TOC entry 6307 (class 0 OID 16546)
-- Dependencies: 233
-- Data for Name: TRATTE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TRATTE" VALUES (1, 1, 2, 570.00, '03:10:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (2, 2, 4, 145.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (3, 1, 5, 300.00, '01:40:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (4, 5, 6, 260.00, '02:05:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (5, 2, 7, 215.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (6, 7, 9, 144.00, '00:50:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (7, 9, 15, 82.00, '00:54:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (8, 5, 13, 2.00, '00:05:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (9, 1, 3, 220.00, '01:15:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (10, 7, 11, 670.00, '05:45:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (11, 3, 12, 55.00, '00:37:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (12, 6, 32, 9.00, '00:12:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (13, 19, 24, 18.00, '00:20:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (14, 38, 31, 90.00, '01:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (15, 14, 30, 104.00, '02:00:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (16, 33, 34, 60.00, '00:50:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (17, 28, 38, 108.00, '01:30:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (18, 16, 6, 158.00, '02:15:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (19, 8, 45, 45.00, '00:42:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);
INSERT INTO public."TRATTE" VALUES (20, 12, 27, 52.00, '00:47:00', '2025-11-08 19:41:59.527026+01', 'ATTIVA', '2025-11-01', NULL);


--
-- TOC entry 6308 (class 0 OID 16573)
-- Dependencies: 234
-- Data for Name: TRATTE_INTERMEDIE; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TRATTE_INTERMEDIE" VALUES (1, 1, '2025-11-08 19:44:02.391054+01', 5, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (1, 7, '2025-11-08 19:44:02.391054+01', 4, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (1, 2, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (2, 2, '2025-11-08 19:44:02.391054+01', 3, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (2, 21, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (2, 4, '2025-11-08 19:44:02.391054+01', 4, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (3, 1, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (3, 25, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (3, 5, '2025-11-08 19:44:02.391054+01', 3, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (4, 5, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (4, 15, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (4, 6, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (5, 2, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (5, 31, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (5, 7, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (6, 7, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (6, 19, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (6, 9, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (7, 9, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (7, 15, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (8, 5, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (8, 13, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (9, 1, '2025-11-08 19:44:02.391054+01', 3, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (9, 27, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (9, 3, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (10, 7, '2025-11-08 19:44:02.391054+01', 4, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (10, 22, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (10, 11, '2025-11-08 19:44:02.391054+01', 2, 3);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (11, 3, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (11, 12, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (12, 6, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (12, 32, '2025-11-08 19:44:02.391054+01', 3, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (13, 19, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (13, 24, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (14, 38, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (14, 31, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (15, 14, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (15, 30, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (16, 33, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (16, 34, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (17, 28, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (17, 38, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (18, 16, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (18, 6, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (19, 8, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (19, 45, '2025-11-08 19:44:02.391054+01', 2, 2);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (20, 12, '2025-11-08 19:44:02.391054+01', 2, 1);
INSERT INTO public."TRATTE_INTERMEDIE" VALUES (20, 27, '2025-11-08 19:44:02.391054+01', 2, 2);


--
-- TOC entry 6320 (class 0 OID 16719)
-- Dependencies: 246
-- Data for Name: VALIDAZIONI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."VALIDAZIONI" VALUES (1, 1, 1, 1, '2025-11-17 08:10:00+01', 'VALIDATO', 'Biglietto in regola.');
INSERT INTO public."VALIDAZIONI" VALUES (2, 2, 2, 2, '2025-11-18 09:15:00+01', 'VALIDATO', 'Controllo su treno.');
INSERT INTO public."VALIDAZIONI" VALUES (3, 3, 2, 2, '2025-11-18 09:18:00+01', 'VALIDATO', 'Controllo su treno.');
INSERT INTO public."VALIDAZIONI" VALUES (4, 4, 3, 3, '2025-11-19 14:10:00+01', 'VALIDATO', 'Passeggero premium.');
INSERT INTO public."VALIDAZIONI" VALUES (5, 5, 4, 4, '2025-11-20 18:40:00+01', 'NON VALIDO', 'Segnalato smarrito.');
INSERT INTO public."VALIDAZIONI" VALUES (6, 6, 5, 5, '2025-11-22 05:40:00+01', 'VALIDATO', 'Controllo casuale.');
INSERT INTO public."VALIDAZIONI" VALUES (7, 7, 5, 6, '2025-11-23 13:05:00+01', 'VALIDATO', 'Upgrade classe.');
INSERT INTO public."VALIDAZIONI" VALUES (8, 8, 1, 7, '2025-11-24 07:05:00+01', 'VALIDATO', 'Viaggiatore frequente.');
INSERT INTO public."VALIDAZIONI" VALUES (9, 9, 2, 8, '2025-11-25 12:00:00+01', 'VALIDATO', 'Cliente app.');
INSERT INTO public."VALIDAZIONI" VALUES (10, 10, 3, 9, '2025-11-26 18:10:00+01', 'NON VALIDO', 'Problema pagamento.');


--
-- TOC entry 6316 (class 0 OID 16685)
-- Dependencies: 242
-- Data for Name: VEICOLI; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."VEICOLI" VALUES (1, 'FR9500', 'Frecciarossa 1000', 600, 100, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (2, 'IT9902', 'Italo EVO', 450, 65, 385, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (3, 'IC783', 'Intercity MD', 350, 40, 310, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (4, 'REG225', 'Jazz Stadler', 260, 24, 220, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (5, 'FA8400', 'Frecciargento ETR600', 520, 80, 440, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (6, 'REG220', 'Pop Alstom', 350, 30, 310, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (7, 'FR9600', 'Frecciarossa 500', 542, 80, 450, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (8, 'REG300', 'Swing Pesa', 180, 18, 150, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (9, 'IC9140', 'Intercity MD', 320, 36, 270, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (10, 'FA8300', 'Frecciargento ETR485', 480, 69, 400, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (11, 'FR9100', 'Frecciarossa 1000', 610, 110, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (12, 'REG9824', 'Minuetto', 151, 0, 140, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (13, 'REG330', 'Pop Alstom', 350, 35, 300, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (14, 'REG210', 'Minuetto', 150, 12, 120, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (15, 'FR9750', 'Frecciarossa 500', 540, 90, 445, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (16, 'REG150', 'Swing Pesa', 185, 8, 160, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (17, 'FA9604', 'Frecciargento ETR600', 523, 80, 435, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (18, 'IC9111', 'Intercity MD', 325, 35, 270, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (19, 'REG155', 'Jazz Stadler', 250, 20, 220, 'ATTIVO', '2025-11-08 19:46:08.150987+01');
INSERT INTO public."VEICOLI" VALUES (20, 'FR9002', 'Frecciarossa 1000', 620, 120, 500, 'ATTIVO', '2025-11-08 19:46:08.150987+01');


--
-- TOC entry 5977 (class 0 OID 17144)
-- Dependencies: 248
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5979 (class 0 OID 17910)
-- Dependencies: 253
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--



--
-- TOC entry 5980 (class 0 OID 17929)
-- Dependencies: 254
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--



--
-- TOC entry 6359 (class 0 OID 0)
-- Dependencies: 228
-- Name: BIGLIETTI_id_biglietto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."BIGLIETTI_id_biglietto_seq"', 1, false);


--
-- TOC entry 6360 (class 0 OID 0)
-- Dependencies: 243
-- Name: OPERATORI_id_operatore_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OPERATORI_id_operatore_seq"', 1, false);


--
-- TOC entry 6361 (class 0 OID 0)
-- Dependencies: 235
-- Name: ORARI_id_orario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ORARI_id_orario_seq"', 1, false);


--
-- TOC entry 6362 (class 0 OID 0)
-- Dependencies: 239
-- Name: PAGAMENTI_id_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PAGAMENTI_id_pagamento_seq"', 1, false);


--
-- TOC entry 6363 (class 0 OID 0)
-- Dependencies: 224
-- Name: PASSEGGERO_id_passeggero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PASSEGGERO_id_passeggero_seq"', 1, false);


--
-- TOC entry 6364 (class 0 OID 0)
-- Dependencies: 226
-- Name: PRENOTAZIONI_id_prenotazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PRENOTAZIONI_id_prenotazione_seq"', 1, false);


--
-- TOC entry 6365 (class 0 OID 0)
-- Dependencies: 237
-- Name: PREZZI_id_prezzo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PREZZI_id_prezzo_seq"', 1, true);


--
-- TOC entry 6366 (class 0 OID 0)
-- Dependencies: 222
-- Name: STATIONS_id_stazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."STATIONS_id_stazione_seq"', 1, false);


--
-- TOC entry 6367 (class 0 OID 0)
-- Dependencies: 230
-- Name: TARIFFE_id_tariffa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TARIFFE_id_tariffa_seq"', 1, false);


--
-- TOC entry 6368 (class 0 OID 0)
-- Dependencies: 232
-- Name: TRATTE_id_tratta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TRATTE_id_tratta_seq"', 1, false);


--
-- TOC entry 6369 (class 0 OID 0)
-- Dependencies: 245
-- Name: VALIDAZIONI_id_validazione_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VALIDAZIONI_id_validazione_seq"', 1, false);


--
-- TOC entry 6370 (class 0 OID 0)
-- Dependencies: 241
-- Name: VEICOLI_id_veicolo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."VEICOLI_id_veicolo_seq"', 1, false);


--
-- TOC entry 6371 (class 0 OID 0)
-- Dependencies: 252
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: postgres
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- TOC entry 6067 (class 2606 OID 16509)
-- Name: BIGLIETTI BIGLIETTI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "BIGLIETTI_pkey" PRIMARY KEY (id_biglietto);


--
-- TOC entry 6105 (class 2606 OID 16716)
-- Name: OPERATORI OPERATORI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OPERATORI"
    ADD CONSTRAINT "OPERATORI_pkey" PRIMARY KEY (id_operatore);


--
-- TOC entry 6083 (class 2606 OID 16616)
-- Name: ORARI ORARI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "ORARI_pkey" PRIMARY KEY (id_orario);


--
-- TOC entry 6095 (class 2606 OID 16676)
-- Name: PAGAMENTI PAGAMENTI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT "PAGAMENTI_pkey" PRIMARY KEY (id_pagamento);


--
-- TOC entry 6049 (class 2606 OID 16455)
-- Name: PASSEGGERI PASSEGGERO_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT "PASSEGGERO_pkey" PRIMARY KEY (id_passeggero);


--
-- TOC entry 6059 (class 2606 OID 16477)
-- Name: PRENOTAZIONI PRENOTAZIONI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "PRENOTAZIONI_pkey" PRIMARY KEY (id_prenotazione);


--
-- TOC entry 6089 (class 2606 OID 16645)
-- Name: PREZZI PREZZI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "PREZZI_pkey" PRIMARY KEY (id_prezzo);


--
-- TOC entry 6044 (class 2606 OID 16436)
-- Name: STAZIONI STATIONS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI"
    ADD CONSTRAINT "STATIONS_pkey" PRIMARY KEY (id_stazione);


--
-- TOC entry 6074 (class 2606 OID 16542)
-- Name: TARIFFE TARIFFE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE"
    ADD CONSTRAINT "TARIFFE_pkey" PRIMARY KEY (id_tariffa);


--
-- TOC entry 6081 (class 2606 OID 16584)
-- Name: TRATTE_INTERMEDIE TRATTE_INTERMEDIE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "TRATTE_INTERMEDIE_pkey" PRIMARY KEY (id_tratta, id_stazione);


--
-- TOC entry 6078 (class 2606 OID 16562)
-- Name: TRATTE TRATTE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "TRATTE_pkey" PRIMARY KEY (id_tratta);


--
-- TOC entry 6107 (class 2606 OID 16732)
-- Name: VALIDAZIONI VALIDAZIONI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "VALIDAZIONI_pkey" PRIMARY KEY (id_validazione);


--
-- TOC entry 6101 (class 2606 OID 16699)
-- Name: VEICOLI VEICOLI_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI"
    ADD CONSTRAINT "VEICOLI_pkey" PRIMARY KEY (id_veicolo);


--
-- TOC entry 6026 (class 2606 OID 16439)
-- Name: STAZIONI check_coordinate; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."STAZIONI"
    ADD CONSTRAINT check_coordinate CHECK ((((latitudine IS NULL) AND (longitudine IS NULL)) OR ((latitudine IS NOT NULL) AND (longitudine IS NOT NULL)))) NOT VALID;


--
-- TOC entry 6372 (class 0 OID 0)
-- Dependencies: 6026
-- Name: CONSTRAINT check_coordinate ON "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT check_coordinate ON public."STAZIONI" IS 'per assicurarmi che o entrambe le colonne latitudine e longitudine sono popolate, o nessuna';


--
-- TOC entry 6029 (class 2606 OID 16816)
-- Name: TARIFFE check_sconto; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public."TARIFFE"
    ADD CONSTRAINT check_sconto CHECK (((sconto_percentuale < (100)::numeric) AND (sconto_percentuale > (0)::numeric))) NOT VALID;


--
-- TOC entry 6373 (class 0 OID 0)
-- Dependencies: 6029
-- Name: CONSTRAINT check_sconto ON "TARIFFE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT check_sconto ON public."TARIFFE" IS 'Per esser certi che lo sconto non sia inferiore di 0 ne maggiore di 100';


--
-- TOC entry 6091 (class 2606 OID 16764)
-- Name: PREZZI check_unique_price; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT check_unique_price UNIQUE (id_tariffa, classe, id_orario, validita_da);


--
-- TOC entry 6374 (class 0 OID 0)
-- Dependencies: 6091
-- Name: CONSTRAINT check_unique_price ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT check_unique_price ON public."PREZZI" IS 'Per esser certi che non esistano prezzi con le seguenti colonne uguali: validita_da, classe, id_orario, id_tariffa.';


--
-- TOC entry 6069 (class 2606 OID 16511)
-- Name: BIGLIETTI codice_biglietto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT codice_biglietto UNIQUE (codice_biglietto);


--
-- TOC entry 6375 (class 0 OID 0)
-- Dependencies: 6069
-- Name: CONSTRAINT codice_biglietto ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_biglietto ON public."BIGLIETTI" IS 'codice_biglietto deve essere unico';


--
-- TOC entry 6051 (class 2606 OID 16461)
-- Name: PASSEGGERI codice_carta_fedelta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT codice_carta_fedelta UNIQUE (codice_carta_fedelta);


--
-- TOC entry 6376 (class 0 OID 0)
-- Dependencies: 6051
-- Name: CONSTRAINT codice_carta_fedelta ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_carta_fedelta ON public."PASSEGGERI" IS 'per esser certi che non venga riutilizzata la stessa carta fedeltà per più clienti';


--
-- TOC entry 6053 (class 2606 OID 16457)
-- Name: PASSEGGERI codice_fiscale; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT codice_fiscale UNIQUE (codice_fiscale);


--
-- TOC entry 6377 (class 0 OID 0)
-- Dependencies: 6053
-- Name: CONSTRAINT codice_fiscale ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_fiscale ON public."PASSEGGERI" IS 'per esser certi di avere sempre codici fiscali univoci';


--
-- TOC entry 6085 (class 2606 OID 16618)
-- Name: ORARI codice_orario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT codice_orario UNIQUE (codice_orario);


--
-- TOC entry 6378 (class 0 OID 0)
-- Dependencies: 6085
-- Name: CONSTRAINT codice_orario ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_orario ON public."ORARI" IS 'Non posso avere codice_orario uguali ';


--
-- TOC entry 6061 (class 2606 OID 16479)
-- Name: PRENOTAZIONI codice_prenotazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT codice_prenotazione UNIQUE (codice_prenotazione);


--
-- TOC entry 6379 (class 0 OID 0)
-- Dependencies: 6061
-- Name: CONSTRAINT codice_prenotazione ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_prenotazione ON public."PRENOTAZIONI" IS 'non possono esserci record con stesso codice_prenotazione';


--
-- TOC entry 6046 (class 2606 OID 16438)
-- Name: STAZIONI codice_stazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STAZIONI"
    ADD CONSTRAINT codice_stazione UNIQUE (codice_stazione);


--
-- TOC entry 6380 (class 0 OID 0)
-- Dependencies: 6046
-- Name: CONSTRAINT codice_stazione ON "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_stazione ON public."STAZIONI" IS 'per assicurarmi che non abbia stazioni con lo stesso codice';


--
-- TOC entry 6076 (class 2606 OID 16544)
-- Name: TARIFFE codice_tariffa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TARIFFE"
    ADD CONSTRAINT codice_tariffa UNIQUE (codice_tariffa);


--
-- TOC entry 6381 (class 0 OID 0)
-- Dependencies: 6076
-- Name: CONSTRAINT codice_tariffa ON "TARIFFE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT codice_tariffa ON public."TARIFFE" IS 'codice_tariffa deve essere univoco';


--
-- TOC entry 6055 (class 2606 OID 16459)
-- Name: PASSEGGERI email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PASSEGGERI"
    ADD CONSTRAINT email UNIQUE (email);


--
-- TOC entry 6382 (class 0 OID 0)
-- Dependencies: 6055
-- Name: CONSTRAINT email ON "PASSEGGERI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT email ON public."PASSEGGERI" IS 'per esser certi che non venga riutilizzata da altri clienti';


--
-- TOC entry 6099 (class 2606 OID 16678)
-- Name: PAGAMENTI unique_codice_transazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT unique_codice_transazione UNIQUE (codice_transazione);


--
-- TOC entry 6383 (class 0 OID 0)
-- Dependencies: 6099
-- Name: CONSTRAINT unique_codice_transazione ON "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT unique_codice_transazione ON public."PAGAMENTI" IS 'non posso avere codici transazioni uguali';


--
-- TOC entry 6103 (class 2606 OID 16701)
-- Name: VEICOLI unique_codice_veicolo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VEICOLI"
    ADD CONSTRAINT unique_codice_veicolo UNIQUE (codice_veicolo);


--
-- TOC entry 6384 (class 0 OID 0)
-- Dependencies: 6103
-- Name: CONSTRAINT unique_codice_veicolo ON "VEICOLI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT unique_codice_veicolo ON public."VEICOLI" IS 'non posso avere più veicoli con lo stesso codice_veicolo';


--
-- TOC entry 6108 (class 1259 OID 16797)
-- Name: fki_FK_id_biglietto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_biglietto" ON public."VALIDAZIONI" USING btree (id_biglietto);


--
-- TOC entry 6092 (class 1259 OID 16762)
-- Name: fki_FK_id_orario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_orario" ON public."PREZZI" USING btree (id_orario);


--
-- TOC entry 6062 (class 1259 OID 16791)
-- Name: fki_FK_id_passeggero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_passeggero" ON public."PRENOTAZIONI" USING btree (id_passeggero);


--
-- TOC entry 6070 (class 1259 OID 16803)
-- Name: fki_FK_id_prenotazione; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_id_prenotazione" ON public."BIGLIETTI" USING btree (id_prenotazione);


--
-- TOC entry 6071 (class 1259 OID 18150)
-- Name: idx_biglietti_id_orario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietti_id_orario ON public."BIGLIETTI" USING btree (id_orario);


--
-- TOC entry 6385 (class 0 OID 0)
-- Dependencies: 6071
-- Name: INDEX idx_biglietti_id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_biglietti_id_orario IS 'Indice utile per la vista sulle tratte più affollate';


--
-- TOC entry 6072 (class 1259 OID 18126)
-- Name: idx_biglietti_orario_stato_validita; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietti_orario_stato_validita ON public."BIGLIETTI" USING btree (id_orario, stato, timestamp_validita_fine DESC) INCLUDE (codice_biglietto, prezzo, id_prenotazione);


--
-- TOC entry 6386 (class 0 OID 0)
-- Dependencies: 6072
-- Name: INDEX idx_biglietti_orario_stato_validita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_biglietti_orario_stato_validita IS 'Indice utile nel caso in cui vengano reperiti i biglietti entrando per id_orario, stato ed ordinando per timestamp_validita_fine';


--
-- TOC entry 6086 (class 1259 OID 16821)
-- Name: idx_orari_id_orario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_orari_id_orario ON public."ORARI" USING btree (id_orario) NULLS NOT DISTINCT WITH (deduplicate_items='true');


--
-- TOC entry 6087 (class 1259 OID 16822)
-- Name: idx_orari_timestamp_partenza; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orari_timestamp_partenza ON public."ORARI" USING btree (timestamp_partenza) WITH (deduplicate_items='true');


--
-- TOC entry 6387 (class 0 OID 0)
-- Dependencies: 6087
-- Name: INDEX idx_orari_timestamp_partenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_orari_timestamp_partenza IS 'Index su timestamp_partenza utile in fase di ricerca Ticket';


--
-- TOC entry 6096 (class 1259 OID 18149)
-- Name: idx_pagamenti_id_prenotazione; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagamenti_id_prenotazione ON public."PAGAMENTI" USING btree (id_prenotazione);


--
-- TOC entry 6388 (class 0 OID 0)
-- Dependencies: 6096
-- Name: INDEX idx_pagamenti_id_prenotazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_pagamenti_id_prenotazione IS 'Indice su id_prenotazione per velocizzare le viste inerenti ai pagamenti ';


--
-- TOC entry 6097 (class 1259 OID 18148)
-- Name: idx_pagamenti_stato_data; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagamenti_stato_data ON public."PAGAMENTI" USING btree (stato_pagamento, data_pagamento);


--
-- TOC entry 6389 (class 0 OID 0)
-- Dependencies: 6097
-- Name: INDEX idx_pagamenti_stato_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_pagamenti_stato_data IS 'indice su stato pagamento e data pagamento. Utile per le viste inerenti ai pagamenti';


--
-- TOC entry 6056 (class 1259 OID 18127)
-- Name: idx_passeggeri_codice_fiscale; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_passeggeri_codice_fiscale ON public."PASSEGGERI" USING btree (codice_fiscale);


--
-- TOC entry 6390 (class 0 OID 0)
-- Dependencies: 6056
-- Name: INDEX idx_passeggeri_codice_fiscale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_passeggeri_codice_fiscale IS 'In caso di ricerca cliente per codice_fiscale';


--
-- TOC entry 6057 (class 1259 OID 16817)
-- Name: idx_passeggero_id_passeggero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_passeggero_id_passeggero ON public."PASSEGGERI" USING btree (id_passeggero) WITH (deduplicate_items='true');


--
-- TOC entry 6391 (class 0 OID 0)
-- Dependencies: 6057
-- Name: INDEX idx_passeggero_id_passeggero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_passeggero_id_passeggero IS 'Index su campo id_passeggero';


--
-- TOC entry 6063 (class 1259 OID 16823)
-- Name: idx_prenotazioni_confermate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prenotazioni_confermate ON public."PRENOTAZIONI" USING btree (id_passeggero, data_prenotazione DESC) WHERE ((stato_prenotazione)::text = 'CONFERMATA'::text);


--
-- TOC entry 6392 (class 0 OID 0)
-- Dependencies: 6063
-- Name: INDEX idx_prenotazioni_confermate; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_prenotazioni_confermate IS 'Utile quando vengono richieste le sole PRENOTAZIONI "Confermate"';


--
-- TOC entry 6064 (class 1259 OID 18122)
-- Name: idx_prenotazioni_data_desc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prenotazioni_data_desc ON public."PRENOTAZIONI" USING btree (data_prenotazione DESC);


--
-- TOC entry 6065 (class 1259 OID 18155)
-- Name: idx_prenotazioni_passeggero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prenotazioni_passeggero ON public."PRENOTAZIONI" USING btree (id_passeggero) WITH (fillfactor='100', deduplicate_items='true');


--
-- TOC entry 6393 (class 0 OID 0)
-- Dependencies: 6065
-- Name: INDEX idx_prenotazioni_passeggero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_prenotazioni_passeggero IS 'Utile in fase di reperimento storico prenotazioni entrando per id_passeggero';


--
-- TOC entry 6093 (class 1259 OID 18125)
-- Name: idx_prezzi_attivi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prezzi_attivi ON public."PREZZI" USING btree (id_orario, id_tariffa, validita_da) WHERE ((stato)::text = 'ATTIVO'::text);


--
-- TOC entry 6394 (class 0 OID 0)
-- Dependencies: 6093
-- Name: INDEX idx_prezzi_attivi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_prezzi_attivi IS 'Utile in quanto la maggior parte delle query cercheranno solo prezzi "Attivi"';


--
-- TOC entry 6047 (class 1259 OID 18108)
-- Name: idx_stazioni_geo_stazioni ; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_stazioni_geo_stazioni " ON public."STAZIONI" USING gist (geo_stazione) WITH (buffering=auto);


--
-- TOC entry 6395 (class 0 OID 0)
-- Dependencies: 6047
-- Name: INDEX "idx_stazioni_geo_stazioni "; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public."idx_stazioni_geo_stazioni " IS 'Indice di tipo GIST per sfruttare il campo geo_stazione di tipo geography ed ottimizzare le ricerche di prossimità';


--
-- TOC entry 6079 (class 1259 OID 16824)
-- Name: idx_tratte_attive; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tratte_attive ON public."TRATTE" USING btree (stazione_partenza_id, stazione_arrivo_id) WHERE ((stato_tratta)::text = 'ATTIVA'::text);


--
-- TOC entry 6396 (class 0 OID 0)
-- Dependencies: 6079
-- Name: INDEX idx_tratte_attive; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_tratte_attive IS 'Indice utile per la ricerca delle sole TRATTE  "Attive", basandosi sulle colonne stazione_arrivo_id ed stazione_partenza_id ';


--
-- TOC entry 6109 (class 1259 OID 18152)
-- Name: idx_validazioni_id_operatore; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validazioni_id_operatore ON public."VALIDAZIONI" USING btree (id_operatore);


--
-- TOC entry 6110 (class 1259 OID 18151)
-- Name: idx_validazioni_id_orario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validazioni_id_orario ON public."VALIDAZIONI" USING btree (id_orario);


--
-- TOC entry 6397 (class 0 OID 0)
-- Dependencies: 6110
-- Name: INDEX idx_validazioni_id_orario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_validazioni_id_orario IS 'Indice utile per la vista su validazioni operatori, utile in join con ORARI';


--
-- TOC entry 6111 (class 1259 OID 18123)
-- Name: idx_validazioni_timestamp_desc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validazioni_timestamp_desc ON public."VALIDAZIONI" USING btree (timestamp_validazione DESC);


--
-- TOC entry 6140 (class 2620 OID 18107)
-- Name: STAZIONI trg_stazioni_set_geo_stazione; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_stazioni_set_geo_stazione BEFORE INSERT OR UPDATE ON public."STAZIONI" FOR EACH ROW EXECUTE FUNCTION public.stazioni_set_geo_stazione();


--
-- TOC entry 6398 (class 0 OID 0)
-- Dependencies: 6140
-- Name: TRIGGER trg_stazioni_set_geo_stazione ON "STAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TRIGGER trg_stazioni_set_geo_stazione ON public."STAZIONI" IS 'Trigger che richiamerà la funzione set_geostazione ad ogni INSERT o UPDATE';


--
-- TOC entry 6137 (class 2606 OID 16792)
-- Name: VALIDAZIONI FK_id_biglietto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_biglietto" FOREIGN KEY (id_biglietto) REFERENCES public."BIGLIETTI"(id_biglietto) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 6399 (class 0 OID 0)
-- Dependencies: 6137
-- Name: CONSTRAINT "FK_id_biglietto" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_biglietto" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata al biglietto controllato della tabella BIGLIETTI. Non posso cancellare una riga della tabella BIGLIETTI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 6138 (class 2606 OID 16738)
-- Name: VALIDAZIONI FK_id_operatore; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_operatore" FOREIGN KEY (id_operatore) REFERENCES public."OPERATORI"(id_operatore) ON DELETE RESTRICT;


--
-- TOC entry 6400 (class 0 OID 0)
-- Dependencies: 6138
-- Name: CONSTRAINT "FK_id_operatore" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_operatore" ON public."VALIDAZIONI" IS 'Collega alla tabella OPERATORI, per identificare l''operatore che ha effettuato la validazione.
Non posso cancellare una riga della tabella OPERATORI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 6139 (class 2606 OID 16743)
-- Name: VALIDAZIONI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VALIDAZIONI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario);


--
-- TOC entry 6401 (class 0 OID 0)
-- Dependencies: 6139
-- Name: CONSTRAINT "FK_id_orario" ON "VALIDAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."VALIDAZIONI" IS 'Collega la validazione effettuata alla schedulazione, relazionandosi alla tabella ORARI. Non posso cancellare una riga della tabella ORARI, se è presente una corrispondenza sulla tabella VALIDAZIONI.';


--
-- TOC entry 6133 (class 2606 OID 16757)
-- Name: PREZZI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 6402 (class 0 OID 0)
-- Dependencies: 6133
-- Name: CONSTRAINT "FK_id_orario" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."PREZZI" IS 'FK per relazionarla alla tabella ORARI';


--
-- TOC entry 6122 (class 2606 OID 16767)
-- Name: PRENOTAZIONI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 6403 (class 0 OID 0)
-- Dependencies: 6122
-- Name: CONSTRAINT "FK_id_orario" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."PRENOTAZIONI" IS 'FK per relazionare la tabella ORARI';


--
-- TOC entry 6124 (class 2606 OID 16811)
-- Name: BIGLIETTI FK_id_orario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "FK_id_orario" FOREIGN KEY (id_orario) REFERENCES public."ORARI"(id_orario) NOT VALID;


--
-- TOC entry 6404 (class 0 OID 0)
-- Dependencies: 6124
-- Name: CONSTRAINT "FK_id_orario" ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_orario" ON public."BIGLIETTI" IS 'FK per collegare alla tabella ORARI';


--
-- TOC entry 6123 (class 2606 OID 16786)
-- Name: PRENOTAZIONI FK_id_passeggero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRENOTAZIONI"
    ADD CONSTRAINT "FK_id_passeggero" FOREIGN KEY (id_passeggero) REFERENCES public."PASSEGGERI"(id_passeggero) NOT VALID;


--
-- TOC entry 6405 (class 0 OID 0)
-- Dependencies: 6123
-- Name: CONSTRAINT "FK_id_passeggero" ON "PRENOTAZIONI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_passeggero" ON public."PRENOTAZIONI" IS 'FK per collegare prenotazioni con passeggero';


--
-- TOC entry 6136 (class 2606 OID 16679)
-- Name: PAGAMENTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAGAMENTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT;


--
-- TOC entry 6406 (class 0 OID 0)
-- Dependencies: 6136
-- Name: CONSTRAINT "FK_id_prenotazione" ON "PAGAMENTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."PAGAMENTI" IS 'Per relazionare l''entità alla tabella PRENOTAZIONI. Non è possibile cancellare una riga di PRENOTAZIONI se esiste una all''interno di PAGAMENTI';


--
-- TOC entry 6125 (class 2606 OID 16798)
-- Name: BIGLIETTI FK_id_prenotazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BIGLIETTI"
    ADD CONSTRAINT "FK_id_prenotazione" FOREIGN KEY (id_prenotazione) REFERENCES public."PRENOTAZIONI"(id_prenotazione) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 6407 (class 0 OID 0)
-- Dependencies: 6125
-- Name: CONSTRAINT "FK_id_prenotazione" ON "BIGLIETTI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_prenotazione" ON public."BIGLIETTI" IS 'FK che collega la tabella a quella delle PRENOTAZIONI';


--
-- TOC entry 6128 (class 2606 OID 16590)
-- Name: TRATTE_INTERMEDIE FK_id_stazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_stazione" FOREIGN KEY (id_stazione) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 6408 (class 0 OID 0)
-- Dependencies: 6128
-- Name: CONSTRAINT "FK_id_stazione" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_stazione" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle STAZIONI';


--
-- TOC entry 6130 (class 2606 OID 16619)
-- Name: ORARI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa);


--
-- TOC entry 6409 (class 0 OID 0)
-- Dependencies: 6130
-- Name: CONSTRAINT "FK_id_tariffa" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."ORARI" IS 'FK per legare alla tabella TARIFFE';


--
-- TOC entry 6134 (class 2606 OID 16653)
-- Name: PREZZI FK_id_tariffa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tariffa" FOREIGN KEY (id_tariffa) REFERENCES public."TARIFFE"(id_tariffa) ON DELETE CASCADE;


--
-- TOC entry 6410 (class 0 OID 0)
-- Dependencies: 6134
-- Name: CONSTRAINT "FK_id_tariffa" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tariffa" ON public."PREZZI" IS 'per collegare alla tabella TARIFFE. Inoltre, se un elemento collegato di TARIFFE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI.';


--
-- TOC entry 6129 (class 2606 OID 16585)
-- Name: TRATTE_INTERMEDIE FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE_INTERMEDIE"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 6411 (class 0 OID 0)
-- Dependencies: 6129
-- Name: CONSTRAINT "FK_id_tratta" ON "TRATTE_INTERMEDIE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."TRATTE_INTERMEDIE" IS 'FK per collegare alla tabella delle tratte "principali"';


--
-- TOC entry 6131 (class 2606 OID 16624)
-- Name: ORARI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta);


--
-- TOC entry 6412 (class 0 OID 0)
-- Dependencies: 6131
-- Name: CONSTRAINT "FK_id_tratta" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."ORARI" IS 'FK per legare alla tabella TRATTE';


--
-- TOC entry 6135 (class 2606 OID 16648)
-- Name: PREZZI FK_id_tratta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PREZZI"
    ADD CONSTRAINT "FK_id_tratta" FOREIGN KEY (id_tratta) REFERENCES public."TRATTE"(id_tratta) ON DELETE CASCADE;


--
-- TOC entry 6413 (class 0 OID 0)
-- Dependencies: 6135
-- Name: CONSTRAINT "FK_id_tratta" ON "PREZZI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_tratta" ON public."PREZZI" IS 'Collega alla tabella TRATTE. Inoltre, se un elemento collegato di TRATTE viene eliminato, verrà eliminato l''elemento corrispondente sulla tabella PREZZI. ';


--
-- TOC entry 6132 (class 2606 OID 16749)
-- Name: ORARI FK_id_veicolo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORARI"
    ADD CONSTRAINT "FK_id_veicolo" FOREIGN KEY (id_veicolo) REFERENCES public."VEICOLI"(id_veicolo) ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 6414 (class 0 OID 0)
-- Dependencies: 6132
-- Name: CONSTRAINT "FK_id_veicolo" ON "ORARI"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_id_veicolo" ON public."ORARI" IS 'FK che collega alla tabella VEICOLI. Se esiste una corrispondenza nella tabella ORARI, non posso cancellare la riga corrispondente in VEICOLI';


--
-- TOC entry 6126 (class 2606 OID 16568)
-- Name: TRATTE FK_stazione_arrivo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_arrivo_id" FOREIGN KEY (stazione_arrivo_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 6415 (class 0 OID 0)
-- Dependencies: 6126
-- Name: CONSTRAINT "FK_stazione_arrivo_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_arrivo_id" ON public."TRATTE" IS 'FK che collega stazione di arrivo alla tabella STAZIONI';


--
-- TOC entry 6127 (class 2606 OID 16563)
-- Name: TRATTE FK_stazione_partenza_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TRATTE"
    ADD CONSTRAINT "FK_stazione_partenza_id" FOREIGN KEY (stazione_partenza_id) REFERENCES public."STAZIONI"(id_stazione);


--
-- TOC entry 6416 (class 0 OID 0)
-- Dependencies: 6127
-- Name: CONSTRAINT "FK_stazione_partenza_id" ON "TRATTE"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "FK_stazione_partenza_id" ON public."TRATTE" IS 'FK che collega stazione di partenza alla tabella STAZIONI';


-- Completed on 2025-12-18 20:05:02

--
-- PostgreSQL database dump complete
--

\unrestrict TJvut1bQq2gZxKRNbuPy7U9mjReWs6tFmEHavSVdpq0C1JdDbJzdUtaclflRysE

