--
-- PostgreSQL database dump
--

\restrict rQxoQFfZXcd4TqedQbqWmomMhixKJ9laKrwCuEyDh81Wp4fwLWh7Znf9YW5plqx

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-24 22:26:02

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
-- TOC entry 6 (class 2615 OID 16388)
-- Name: production; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA production;


ALTER SCHEMA production OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 16472)
-- Name: detail_negative_feedback; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.detail_negative_feedback (
    id_nf character varying(255),
    ref_number character varying(10),
    remarks character varying(255),
    evidence character varying(255),
    status_feedback smallint DEFAULT '-1'::integer,
    created_at timestamp(6) without time zone DEFAULT now(),
    id bigint NOT NULL
);


ALTER TABLE production.detail_negative_feedback OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16518)
-- Name: detail_negative_feedback_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.detail_negative_feedback ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.detail_negative_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16461)
-- Name: detail_sscl_transaction; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.detail_sscl_transaction (
    id_sscl character varying(100),
    part_id character varying(10),
    question_eng character varying(500),
    question_ind character varying(500),
    checker smallint,
    nahkoda smallint,
    remarks character varying(500),
    order_number smallint
);


ALTER TABLE production.detail_sscl_transaction OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16390)
-- Name: master_berth; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.master_berth (
    berth_id integer NOT NULL,
    berth_name character varying(255),
    berth_code character varying(255),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at date
);


ALTER TABLE production.master_berth OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16389)
-- Name: master_berth_berth_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.master_berth ALTER COLUMN berth_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.master_berth_berth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16405)
-- Name: master_cargo; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.master_cargo (
    cargo_id integer NOT NULL,
    cargo_name character varying(255),
    cargo_code character varying(255),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at date
);


ALTER TABLE production.master_cargo OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16404)
-- Name: master_cargo_cargo_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.master_cargo ALTER COLUMN cargo_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.master_cargo_cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16414)
-- Name: master_port; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.master_port (
    port_id integer NOT NULL,
    port_name character varying(255),
    port_code character varying(255),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at date
);


ALTER TABLE production.master_port OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16413)
-- Name: master_port_port_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.master_port ALTER COLUMN port_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.master_port_port_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16425)
-- Name: master_ship; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.master_ship (
    ship_id integer NOT NULL,
    ship_name character varying(255),
    ship_code character varying(255),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at date
);


ALTER TABLE production.master_ship OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16424)
-- Name: master_ship_ship_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.master_ship ALTER COLUMN ship_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.master_ship_ship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16466)
-- Name: negative_feedback; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.negative_feedback (
    nf_id character varying(100) NOT NULL,
    ship_id bigint,
    port_id bigint,
    status_nf smallint DEFAULT '-1'::integer,
    created_by character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    approver character varying(100),
    port_next_id integer
);


ALTER TABLE production.negative_feedback OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16480)
-- Name: negative_feedback_ref; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.negative_feedback_ref (
    ref_number character varying(10),
    eng character varying(255),
    ind character varying(255)
);


ALTER TABLE production.negative_feedback_ref OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16454)
-- Name: sscl_transaction; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.sscl_transaction (
    sscl_id character varying(100) NOT NULL,
    officer_name character varying(40),
    officer_position character varying(40),
    officer_contact character varying(40),
    ship_id bigint,
    port_id bigint,
    berth_id bigint,
    cargo_id bigint,
    date_arrival date,
    time_arrival character varying(10),
    mt_name character varying(100),
    status_sscl smallint DEFAULT '-1'::integer,
    created_by character varying(100),
    approver character varying(100),
    time_8 integer DEFAULT 0,
    time_9 integer DEFAULT 0,
    interval_8 integer DEFAULT 0,
    interval_9 integer DEFAULT 0
);


ALTER TABLE production.sscl_transaction OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16436)
-- Name: users; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.users (
    user_id bigint NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role smallint NOT NULL,
    "position" character varying(255),
    status_account character varying(255) DEFAULT 1 NOT NULL,
    token_verifier character varying(512),
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at date DEFAULT NULL::timestamp without time zone
);


ALTER TABLE production.users OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16435)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

ALTER TABLE production.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME production.users_user_id_seq
    START WITH 4
    INCREMENT BY 1
    MINVALUE 4
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4978 (class 0 OID 16472)
-- Dependencies: 231
-- Data for Name: detail_negative_feedback; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.detail_negative_feedback (id_nf, ref_number, remarks, evidence, status_feedback, created_at, id) FROM stdin;
NF-9244-20251227110321	VIQ 5.5	a	NF_1766808210293_n1xtj1.png	1	2025-12-27 11:03:35.712976	7
\.


--
-- TOC entry 4976 (class 0 OID 16461)
-- Dependencies: 229
-- Data for Name: detail_sscl_transaction; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.detail_sscl_transaction (id_sscl, part_id, question_eng, question_ind, checker, nahkoda, remarks, order_number) FROM stdin;
SSCL-8815-20251228091110	1A	Pre-arrival information is exchanged (6.5, 21.2)	Pertukaran informasi Pre-arrival (6.5, 21.2)	1	1		1
SSCL-8815-20251228091110	1A	International shore fire connection is available (5.5, 19.4.3.1)	Tersedia International shore fire connection (5.5, 19.4.3.1)	1	1		2
SSCL-8815-20251228091110	1A	Transfer hoses are of suitable construction (18.2)	Transfer hose dibuat dari bahan yang sesuai (18.2)	1	1		3
SSCL-8815-20251228091110	1A	Terminal information booklet reviewed (15.2.2)	Terminal information booklet direview (15.2.2)	1	1		4
SSCL-8815-20251228091110	1A	Pre-berthing information is exchanged (21.3, 22.3)	Pertukaran informasi Pre-berthing (21.3, 22.3)	1	1		5
SSCL-8815-20251228091110	1A	Pressure/vacuum valves and/or high velocity vents are operational (11.1.8)	Pressure/vacuum valves dan/atau high velocity vents beroperasi (11.1.8)	1	1		6
SSCL-8815-20251228091110	1A	Fixed and portable oxygen analysers are operational (2.4)	Fixed dan portable oxygen analysers beroperasi (2.4)	1	1		7
SSCL-8815-20251228091110	1B	Inert gas system pressure and oxygen recorders are operational (11.1.5.2, 11.1.11)	Pencatat tekanan dan oksigen pada Inert gas system beroperasi  dengan baik (11.1.5.2, 11.1.11)	1	1		1
SSCL-8815-20251228091110	1B	Inert gas system and associated equipment are operational (11.1.5.2, 11.1.11)	Inert gas system dan peralatan pendukungnya beroperasi dengan baik (11.1.5.2, 11.1.11)	1	1		2
SSCL-8815-20251228091110	1B	Cargo tank atmospheres’ oxygen content is less than 8% (11.1.3)	Kandungan oksigen pada atmosfer tanki kargo kurang dari 8% (11.1.3)	1	1		3
SSCL-8815-20251228091110	1B	Cargo tank atmospheres are at positive pressure (11.1.3)	Atmosfer tanki kargo berada pada tekanan positif (11.1.3)	1	1		4
SSCL-8815-20251228091110	2	Pre-arrival information is exchanged (6.5, 21.2)	Pertukaran informasi Pre-arrival (6.5, 21.2)	1	1		1
SSCL-8815-20251228091110	2	International shore fire connection is available (5.5, 19.4.3.1, 19.4.3.5)	Tersedia International shore fire connection (5.5, 19.4.3.1, 19.4.3.5)	1	1		2
SSCL-8815-20251228091110	2	Transfer equipment is of suitable construction (18.1, 18.2)	Peralatan transfer dibuat dari bahan yang sesuai (18.1, 18.2)	1	1		3
SSCL-8815-20251228091110	2	Terminal information booklet transmitted to tanker (15.2.2)	Terminal information booklet di berikan ke kapal (15.2.2)	1	1		4
SSCL-8815-20251228091110	2	Pre-berthing information is exchanged (21.3, 22.3)	Pertukaran informasi Pre-berthing (21.3, 22.3)	1	1		5
SSCL-8815-20251228091110	3	Fendering is effective (22.4.1)	Fender berfungsi dengan efektif (22.4.1)	1	1		1
SSCL-8815-20251228091110	3	Mooring arrangement is effective (22.2, 22.4.3)	Mooring arrangement berjalan dengan efektif (22.2, 22.4.3)	1	1		2
SSCL-8815-20251228091110	3	Access to and from the tanker is safe (16.4)	Akses yang aman untuk menuju dan dari kapal (16.4)	1	1		3
SSCL-8815-20251228091110	3	Scuppers and savealls are plugged (23.7.4, 23.7.5)	Lubang saluran pembuangan dan bak penampungan di atas kapal sumbatnya telah terpasang (23.7.4, 23.7.5)	1	1		4
SSCL-8815-20251228091110	3	Cargo system sea connections and overboard discharges are secured (23.7.3)	Kargo sistem jalur air laut dan sistem pembuangan ke laut telah ditutup (23.7.3)	1	1		5
SSCL-8815-20251228091110	3	Very high frequency and ultra high frequency transceivers are set to low power mode (4.11.6, 4.13.2.2)	Very high frequency dan ultra high frequency transceivers diatur ke low power mode (4.11.6, 4.13.2.2)	1	1		6
SSCL-8815-20251228091110	3	External openings in superstructures are controlled (23.1)	Seluruh pintu keluar/masuk pada bagian dek kapal tertutup dan terpantau (23.1)	1	1		7
SSCL-8815-20251228091110	3	Pumproom ventilation is effective (10.12.2)	Ventilasi yang memadai pada pumproom (10.12.2)	1	1		8
SSCL-8815-20251228091110	3	Medium frequency/high frequency radio antennae are isolated (4.11.4, 4.13.2.1)	Antena radio frekuensi sedang/tinggi dimatikan (4.11.4, 4.13.2.1)	1	1		9
SSCL-8815-20251228091110	3	Accommodation spaces are at positive pressure (23.2)	Ruang akomodasi  berada pada tekanan positif (23.2)	1	1		10
SSCL-8815-20251228091110	3	Fire control plans are readily available (9.11.2.5)	Fire control plans telah tersedia (9.11.2.5)	1	1		11
SSCL-8815-20251228091110	4	Fendering is effective (22.4.1)	Fender berfungsi dengan efektif (22.4.1)	1	1		1
SSCL-8815-20251228091110	4	Tanker is moored according to the terminal mooring plan (22.2, 22.4.3)	Kapal tertambat sesuai terminal mooring plan (22.2, 22.4.3)	1	1		2
SSCL-8815-20251228091110	4	Access to and from the terminal is safe (16.4)	Akses yang aman untuk menuju dan dari kapal (16.4)	1	1		3
SSCL-8815-20251228091110	4	Spill containment and sumps are secure (18.4.2, 18.4.3, 23.7.4, 23.7.5)	Penampungan tumpahan dan bak penampung diposisikan dengan aman (18.4.2, 18.4.3, 23.7.4, 23.7.5)	1	1		4
SSCL-8815-20251228091110	5A	Tanker is ready to move at agreed notice period (9.11, 21.7.1.1, 22.5.4)	Kapal siap berolah gerak saat terdapat permintaan (9.11, 21.7.1.1, 22.5.4)	1	1		1
SSCL-8815-20251228091110	5A	Effective tanker and terminal communications are established (21.1.1, 21.1.2)	Komunikasi antara kapal dan terminal telah disepakati (21.1.1, 21.1.2)	1	1		2
SSCL-8815-20251228091110	5A	Transfer equipment is in safe condition (isolated, drained and de-pressurised) (18.4.1)	Peralatan transfer dalam kondisi yang baik (diisolasi/ditutup, dikeringkan dan de-pressurised) (18.4.1)	1	1		3
SSCL-8815-20251228091110	5A	Operation supervision and watchkeeping is adequate (7.9, 23.11)	Terdapat pengawasan operasi dan pengawas jaga yang memadai (7.9, 23.11)	1	1		4
SSCL-8815-20251228091110	5A	There are sufficient personnel to deal with an emergency (9.11.2.2, 23.11)	Terdapat personil yang cukup untuk menghadapi keadaan darurat. (9.11.2.2, 23.11)	1	1		5
SSCL-8815-20251228091110	5A	Smoking restrictions and designated smoking areas are established (4.10, 23.10)	Pembatasan merokok dan area khusus merokok ditetapkan (4.10, 23.10)	1	1		6
SSCL-8815-20251228091110	5A	Naked light restrictions are established (4.10.1)	Pembatasan api yang terbuka/menyala ditetapkan (4.10.1)	1	1		7
SSCL-8815-20251228091110	5A	Control of electrical and electronic devices is agreed (4.11, 4.12)	Kontrol listrik dan perangkat elektronik lainnya disepakati (4.11, 4.12)	1	1		8
SSCL-8815-20251228091110	5A	Means of emergency escape from both tanker and terminal are established (20.5)	Sarana penyelamatkan diri saat keadaan darurat dari kapal dan terminal telah disepakati (20.5)	1	1		9
SSCL-8815-20251228091110	5A	Firefighting equipment is ready for use (5, 19.4, 23.8)	Peralatan pemadam kebakaran siap digunakan (5, 19.4, 23.8)	1	1		10
SSCL-8815-20251228091110	5A	Oil spill clean-up material is available (20.4)	Bahan pembersih tumpahan minyak tersedia (20.4)	1	1		11
SSCL-8815-20251228091110	5A	Manifolds are properly connected (23.6.1)	Manifold terhubung dengan benar (23.6.1)	1	1		12
SSCL-8815-20251228091110	5A	Sampling and gauging protocols are agreed (23.5.3.2, 23.7.7.5)	Prosedur pengambilan sampel dan pengukuran disepakati (23.5.3.2, 23.7.7.5)	1	1		13
SSCL-8815-20251228091110	5A	Procedures for cargo, bunkers and ballast handling operations are agreed (21.4, 21.5, 21.6)	Prosedur untuk penanganan operasi kargo, bunker, dan ballast disepakati (21.4, 21.5, 21.6)	1	1		14
SSCL-8815-20251228091110	5A	Cargo transfer management controls are agreed (12.1)	Pengaturan pengelolaan transfer kargo disepakati (12.1)	1	1		15
SSCL-8815-20251228091110	5A	Cargo tank cleaning requirements, including crude oil washing, are agreed (12.3, 12.5, 21.4.1)	Persyaratan cargo tank cleaning, termasuk crude oil washing (COW), disepakati (12.3, 12.5, 21.4.1)	1	1		16
SSCL-8815-20251228091110	5A	Cargo tank gas freeing arrangements agreed (12.4)	Pengaturan free gas tangki kargo disepakati (12.4)	1	1		17
SSCL-8815-20251228091110	5A	Cargo and bunker slop handling requirements agreed (12.1, 21.2, 21.4)	Persyaratan penanganan kargo dan bunker slop disepakati (12.1, 21.2, 21.4)	1	1		18
SSCL-8815-20251228091110	5A	Routine for regular checks on cargo transferred are agreed (23.7.2)	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati (23.7.2)	1	1		19
SSCL-8815-20251228091110	5A	Emergency signals and shutdown procedures are agreed (12.1.6.3, 18.5, 21.1.2)	Sinyal darurat dan prosedur shutdown disepakati (12.1.6.3, 18.5, 21.1.2)	1	1		20
SSCL-8815-20251228091110	5A	Safety data sheets are available (1.4.4, 20.1, 21.4)	Tersedia safety data sheets (1.4.4, 20.1, 21.4)	1	1		21
SSCL-8815-20251228091110	5A	Hazardous properties of the products to be transferred are discussed (1.2, 1.4)	Sifat berbahaya dari produk yang akan ditransfer disepakati (1.2, 1.4)	1	1		22
SSCL-8815-20251228091110	5A	Electrical insulation of the tanker/terminal interface is effective (12.9.5, 17.4, 18.2.14)	Isolasi listrik yang memadai pada sambungan kapal / terminal (12.9.5, 17.4, 18.2.14)	1	1		23
SSCL-8815-20251228091110	5A	Tank venting system and closed operation procedures are agreed (11.3.3.1, 21.4, 21.5, 23.3.3)	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati (11.3.3.1, 21.4, 21.5, 23.3.3)	1	1		24
SSCL-8815-20251228091110	5A	Vapour return line operational parameters are agreed (11.5, 18.3, 23.7.7)	Parameter operasional vapour return line disepakati (11.5, 18.3, 23.7.7)	1	1		25
SSCL-8815-20251228091110	5A	Measures to avoid back-filling are agreed (12.1.13.7)	Tindakan untuk menghindari tenakan balik disepakati (12.1.13.7)	1	1		26
SSCL-8815-20251228091110	5A	Status of unused cargo and bunker connections is satisfactory (23.7.1, 23.7.6)	Informasi status jalur pipa kargo dan bunker yang tidak digunakan terlihat jelas (23.7.1, 23.7.6)	1	1		27
SSCL-8815-20251228091110	5A	Portable very high frequency and ultra high frequency radios are intrinsically safe (4.12.4, 21.1.1)	Radio portabel very high frequency dan ultra high frequency adalah intrinsically safe (4.12.4, 21.1.1)	1	1		28
SSCL-8815-20251228091110	5A	Procedures for receiving nitrogen from terminal to cargo tank are agreed (12.1.14.8)	Prosedur untuk penyaluran nitrogen dari terminal ke tangki kargo disepakati (12.1.14.8)	1	1		29
SSCL-8815-20251228091110	5B	Inhibition certificate received (if required) from manufacturer	Inhibition Certificate diterima (jika diperlukan) dari pabrik	1	1		1
SSCL-8815-20251228091110	5B	Appropriate personal protective equipment identified and available (4.8.1)	Alat pelindung diri yang sesuai telah diidentifikasi dan tersedia (4.8.1)	1	1		2
SSCL-8815-20251228091110	5B	Countermeasures against personal contact with cargo are agreed (1.4)	Tindakan penanggulangan terhadap personil terpapar dengan kargo disepakati (1.4)	1	1		3
SSCL-8815-20251228091110	5B	Cargo handling rate and relationship with valve closure times and automatic shutdown systems is agreed (16.8, 21.4, 21.5, 21.6)	Laju aliran saat kargo handling berhubungan dengan waktu penutupan valve dan automatic shutdown systems disepakati (16.8, 21.4, 21.5, 21.6)	1	1		4
SSCL-8815-20251228091110	5B	Cargo system gauge operation and alarm set points are confirmed (12.1.6.6.1)	Cargo system gauge operation dan set point alarm (high level dan high-high level) dikonfirmasi (12.1.6.6.1)	1	1		5
SSCL-8815-20251228091110	5B	Adequate portable vapour detection instruments are in use (2.4)	Peralatan vapour detection portabel yang memadai berfungsi (2.4)	1	1		6
SSCL-8815-20251228091110	5B	Information on firefighting media and procedures is maind (5, 19)	Informasi tentang media pemadaman kebakaran dan prosedurnya disosialisasikan (5, 19)	1	1		7
SSCL-8815-20251228091110	5B	Transfer hoses confirmed suitable for the product being handled (18.2)	Transfer hose dikonfirmasi sesuai untuk produk yang ditangani (18.2)	1	1		8
SSCL-8815-20251228091110	5B	Confirm cargo handling is only by a permanent installed pipeline system	Konfirmasikan bahwa handling kargo hanya dengan sistem instalasi pipa yang terpasang permanen	1	1		9
SSCL-8815-20251228091110	5B	Procedures are in place to receive nitrogen from the terminal for inerting or purging (12.1.14.8)	Tersedia prosedur untuk menerima nitrogen dari terminal untuk inerting atau pembersihan tangki (12.1.14.8)	1	1		10
SSCL-8815-20251228091110	5C	Inhibition certificate received (if required) from manufacturer	Inhibition Certificate diterima (jika diperlukan) dari pabrik	1	1		1
SSCL-8815-20251228091110	5C	Water spray system is operational (5.3.1, 19.4.3)	Sistem water spray beroperasi (5.3.1, 19.4.3)	1	1		2
SSCL-8815-20251228091110	5C	Appropriate personal protective equipment is identified and available (4.8.1)	Alat pelindung diri yang sesuai telah diidentifikasi dan tersedia (4.8.1)	1	1		3
SSCL-8815-20251228091110	5C	Remote control valves are operational	Remote control valve beroperasi	1	1		4
SSCL-8815-20251228091110	5C	Cargo pumps and compressors are operational	Pompa kargo dan kompresor beroperasi	1	1		5
SSCL-8815-20251228091110	5C	Maximum working pressures are agreed between tanker and terminal (21.4, 21.5, 21.6)	Tekanan kerja maksimum disepakati antara kapal dan terminal (21.4, 21.5, 21.6)	1	1		6
SSCL-8815-20251228091110	5C	Reliquefaction or boil-off control equipment is operational	Peralatan kontrol reliquefaction atau boil-off berfungsi	1	1		7
SSCL-8815-20251228091110	5C	Gas detection equipment is appropriately set for the cargo (2.4)	Peralatan gas detection diatur dengan tepat sesuai jenis kargo (2.4)	1	1		8
SSCL-8815-20251228091110	5C	Cargo system gauge operation and alarm set points are confirmed (12.1.6.6.1)	Cargo system gauge operation dan set point alarm (high level dan high-high level) dikonfirmasi (12.1.6.6.1)	1	1		9
SSCL-8815-20251228091110	8	Fendering is effective 	Fender berfungsi dengan efektif	1	1		9
SSCL-8815-20251228091110	5C	Emergency shutdown systems are tested and operational (18.5)	Sistem emergency shutdown telah diuji dan berfungsi (18.5)	1	1		10
SSCL-8815-20251228091110	5C	Cargo handling rate and relationship with valve closure times and automatic shutdown systems is agreed (16.8, 21.4, 21.5, 21.6)	Laju aliran saat kargo handling berhubungan dengan waktu penutupan valve dan automatic shutdown systems disepakati (16.8, 21.4, 21.5, 21.6)	1	1		11
SSCL-8815-20251228091110	5C	Maximum/minimum temperatures/pressures of the cargo to be transferred are agreed (21.4, 21.5, 21.6)	Suhu/tekanan maksimum/minimum kargo yang akan ditransfer disepakati (21.4, 21.5, 21.6)	1	1		12
SSCL-8815-20251228091110	5C	Cargo tank relief valve settings are confirmed (12.11, 21.2, 21.4)	Pengaturan relief valve pada tangki kargo dikonfirmasi (12.11, 21.2, 21.4)	1	1		13
SSCL-8815-20251228091110	6	Tanker manoeuvring readiness	Kesiapan manuver kapal tanker	1	1		1
SSCL-8815-20251228091110	6	Security protocols	Protokol keamanan	1	1		2
SSCL-8815-20251228091110	6	Effective tanker/terminal communications	Komunikasi antara kapal /terminal telah disepakati	1	1		3
SSCL-8815-20251228091110	6	Operational supervision and watchkeeping	Pengawasan operasi dan pengawas jaga	1	1		4
SSCL-8815-20251228091110	6	Dedicated smoking areas and naked lights restrictions	Area khusus merokok dan pembatasan api yang terbuka/menyala	1	1		5
SSCL-8815-20251228091110	6	Maximum wind, current and sea/swell criteria or other environmental factors	Kriteria maksimum kecepatan angin, arus, dan gelombang atau faktor lingkungan lainnya	1	1		6
SSCL-8815-20251228091110	6	Limits for cargo, bunkers and ballast handling	Batasan untuk penanganan operasi kargo, bunker, dan ballast	1	1		7
SSCL-8815-20251228091110	6	Pressure surge control	Pengaturan tekanan tinggi	1	1		8
SSCL-8815-20251228091110	6	Cargo transfer management procedures	Prosedur  cargo transfer management	1	1		9
SSCL-8815-20251228091110	6	Routine for regular checks on cargo transferred are agreed	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati	1	1		10
SSCL-8815-20251228091110	6	Emergency signals	Sinyal darurat	1	1		11
SSCL-8815-20251228091110	6	Cargo transfer management procedures	Prosedur  cargo transfer management	1	1		12
SSCL-8815-20251228091110	6	Routine for regular checks on cargo transferred are agreed	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati	1	1		13
SSCL-8815-20251228091110	6	Emergency signals	Sinyal darurat	1	1		14
SSCL-8815-20251228091110	6	Tank venting system	Sistem ventilasi tangki	1	1		15
SSCL-8815-20251228091110	6	Closed operations	Operasi tertutup	1	1		16
SSCL-8815-20251228091110	6	Vapour return line	Vapour return line	1	1		17
SSCL-8815-20251228091110	6	Nitrogen supply from terminal	Penyaluran nitrogen dari terminal	1	1		18
SSCL-8815-20251228091110	6	For gas tanker only: cargo tank relief valve settings	Hanya untuk kapal gas:Pengaturan relief valve pada tangki kargo	1	1		19
SSCL-8815-20251228091110	6	Exceptions and additions	Pengecualian dan tambahan	1	1		20
SSCL-8815-20251228091110	7A	Portable drip trays are correctly positioned and empty (23.7.5)	Talang penadah portabel di manifold diposisikan dengan benar dan kosong (23.7.5)	1	1		1
SSCL-8815-20251228091110	7A	Individual cargo tank inert gas supply valves are secured for cargo plan (12.1.13.4)	Setiap supply valve pada inert gas tanki kargo disesuaikan dengan rencana pemuatan kargo (12.1.13.4)	1	1		2
SSCL-8815-20251228091110	7A	Inert gas system delivering inert gas with oxygen content not more than 5% (11.1.3)	Inert gas system menghasilkan gas inert dengan kandungan oksigen tidak lebih dari 5% (11.1.3)	1	1		3
SSCL-8815-20251228091110	7A	Cargo tank high level alarms are operational (12.1.6.6.1)	Alarm high level tangki kargo berfungsi (12.1.6.6.1)	1	1		4
SSCL-8815-20251228091110	7A	All cargo, ballast and bunker tanks openings are secured (23.3)	Semua bukaan tangki kargo, ballast, dan bunker ditutup (23.3)	1	1		5
SSCL-8815-20251228091110	7B	The completed pre-arrival crude oil washing checklist, as contained in the approved crude oil washing manual, is copied to terminal (12.5.2, 21.2.3)	Pre-arrival COW check-list, sebagaimana terdapat dalam manual COW yang disetujui, disampaikan ke terminal (12.5.2, 21.2.3)	1	1		1
SSCL-8815-20251228091110	7B	Crude oil washing checklists for use before, during and after crude oil washing are in place ready to complete, as contained in the approved crude oil washing manual (12.5.2, 21.6)	Check-lists pelaksanaan COW pada kondisi sebelum, selama dan setelah kegiatan COW secara lengkap tersedia, sebagaimana terdapat dalam manual COW yang disetujui (12.5.2, 21.6)	1	1		2
SSCL-8815-20251228091110	7C	Permission for tank cleaning operations is confirmed (21.2.3, 21.4, 25.4.3)	Peizinan untuk operasi tank cleaning dikonfirmasi (21.2.3, 21.4, 25.4.3)	1	1		1
SSCL-8815-20251228091110	7C	Permission for gas freeing operations is confirmed (12.4.3)	Izin untuk operasi free gas dikonfirmasi (12.4.3)	1	1		2
SSCL-8815-20251228091110	7C	Tank cleaning procedures are agreed (12.3.2, 21.4, 21.6)	Prosedur tank cleaning disepakati (12.3.2, 21.4, 21.6)	1	1		3
SSCL-8815-20251228091110	7C	If cargo tank entry is required, procedures for entry have been agreed with the terminal (10.5)	Jika diperlukan masuk kedalam tangki kargo, prosedur masuk area confined space telah disepakati dengan terminal (10.5)	1	1		4
SSCL-8815-20251228091110	7C	Slop reception facilities and requirements are confirmed (12.1, 21.2, 21.4)	Fasilitas dan persyaratan penerimaan SLOP dikonfirmasi (12.1, 21.2, 21.4)	1	1		5
SSCL-8815-20251228091110	8	Inert gas system pressure and oxygen recording operational	Pencatat tekanan dan oksigen pada Inert gas system beroperasi  dengan baik	1	1		1
SSCL-8815-20251228091110	8	Inert gas system and all associated equipment are operational	Inert gas system dan peralatan pendukungnya beroperasi dengan baik	1	1		2
SSCL-8815-20251228091110	8	Cargo tank atmospheres are at positive pressure	Atmosfer tanki kargo berada pada tekanan positif	1	1		3
SSCL-8815-20251228091110	8	Mooring arrangement is effective	Mooring arrangement berjalan efektif	1	1		4
SSCL-8815-20251228091110	8	Access to and from the tanker is safe	Akses yang aman untuk menuju dan dari kapal	1	1		5
SSCL-8815-20251228091110	8	Scuppers and save-alls are plugged	Lubang saluran pembuangan dan bak penampungan di atas kapal sumbatnya telah terpasang	1	1		6
SSCL-8815-20251228091110	8	External openings in superstructures are controlled	Seluruh pintu keluar/masuk pada bagian dek kapal tertutup dan terpantau	1	1		7
SSCL-8815-20251228091110	8	Pumproom ventilation is effective	Ventilasi yang memadai pada pumproom	1	1		8
SSCL-8815-20251228091110	8	Tanker is ready to move at agreed notice period	Kapal siap berolah gerak saat terdapat permintaan	1	1		10
SSCL-8815-20251228091110	8	Communications are effective	Komunikasi yang baik	1	1		11
SSCL-8815-20251228091110	8	Supervision and watchkeeping is adequate	Pengawasan operasi dan pengawas jaga yang memadai	1	1		12
SSCL-8815-20251228091110	8	Sufficient personnel are available to deal with an emergency	Terdapat personil yang cukup untuk menghadapi keadaan darurat	1	1		13
SSCL-8815-20251228091110	8	Smoking restrictions and designated moking areas are complied with	Pembatasan merokok dan area khusus merokok dipatuhi	1	1		14
SSCL-8815-20251228091110	8	Naked light restrictions are complied with	Pembatasan api yang terbuka/menyala dipatuhi	1	1		15
SSCL-8815-20251228091110	8	Control of electrical devices and equipment in hazardous zones is complied with	Pengaturan peralatan listrik dan perangkat elektronik di zona berbahaya dipatuhi	1	1		16
SSCL-8815-20251228091110	8	Emergency response preparedness is Satisfactory	Kesiapsiagaan tanggap darurat sangat memuaskan	1	1		17
SSCL-8815-20251228091110	8	Electrical insulation of the tanker/terminal interface is effective	Isolasi listrik yang memadai pada sambungan kapal / terminal	1	1		18
SSCL-8815-20251228091110	8	Tank venting system and closed operation procedures are as agreed	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati	1	1		19
SSCL-8815-20251228091110	8	Individual cargo tank inert gas valves settings are as agreed	Pengaruran setiap supply valve pada inert gas tanki kargo disepakati	1	1		20
SSCL-8815-20251228091110	8	Inert gas delivery maintained at not more than 5% oxygen	Inert gas yang dihasilkann untuk menjaga kandungan oksigen tidak lebih dari 5%	1	1		21
SSCL-8815-20251228091110	8	Cargo tank high level alarms are operational	Alarm high level tangki kargo berfungsi	1	1		22
SSCL-8815-20251228091110	9	Mooring arrangement is effective	Mooring arrangement berjalan dengan efektif	1	1		1
SSCL-8815-20251228091110	9	Access to and from the tanker is safe	Akses yang aman untuk menuju dan dari kapal	1	1		2
SSCL-8815-20251228091110	9	Fendering is effective 	Fender berfungsi dengan efektif	1	1		3
SSCL-8815-20251228091110	9	Spill containment and sumps are secure	Penampungan tumpahan dan bak penampung diposisikan dengan aman	1	1		4
SSCL-8815-20251228091110	9	Communications are effective	Komunikasi yang baik	1	1		5
SSCL-8815-20251228091110	9	Supervision and watchkeeping is adequate	Pengawasan operasi dan pengawas jaga yang memadai	1	1		6
SSCL-8815-20251228091110	9	Sufficient personnel are available to deal with an emergency	Terdapat personil yang cukup untuk menghadapi keadaan darurat	1	1		7
SSCL-8815-20251228091110	9	Smoking restrictions and designated smoking areas are complied with	Pembatasan merokok dan area khusus merokok dipatuhi	1	1		8
SSCL-8815-20251228091110	9	Naked light restrictions are complied with	Pembatasan api yang terbuka/menyala dipatuhi	1	1		9
SSCL-8815-20251228091110	9	Control of electrical devices and equipment in hazardous zones is complied with	Pengaturan peralatan listrik dan perangkat elektronik di zona berbahaya dipatuhi	1	1		10
SSCL-8815-20251228091110	9	Emergency response preparedness is Satisfactory	Kesiapsiagaan tanggap darurat sangat memuaskan	1	1		11
SSCL-8815-20251228091110	9	Electrical insulation of the tanker/terminal interface is effective	Isolasi listrik yang memadai pada sambungan kapal / terminal	1	1		12
SSCL-8815-20251228091110	9	Tank venting system and closed operation procedures are as agreed	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati	1	1		13
SSCL-2487-20251229075541	1A	Pre-arrival information is exchanged (6.5, 21.2)	Pertukaran informasi Pre-arrival (6.5, 21.2)	1	1		1
SSCL-2487-20251229075541	1A	International shore fire connection is available (5.5, 19.4.3.1)	Tersedia International shore fire connection (5.5, 19.4.3.1)	1	1		2
SSCL-2487-20251229075541	1A	Transfer hoses are of suitable construction (18.2)	Transfer hose dibuat dari bahan yang sesuai (18.2)	1	1		3
SSCL-2487-20251229075541	1A	Terminal information booklet reviewed (15.2.2)	Terminal information booklet direview (15.2.2)	1	1		4
SSCL-2487-20251229075541	1A	Pre-berthing information is exchanged (21.3, 22.3)	Pertukaran informasi Pre-berthing (21.3, 22.3)	1	1		5
SSCL-2487-20251229075541	1A	Pressure/vacuum valves and/or high velocity vents are operational (11.1.8)	Pressure/vacuum valves dan/atau high velocity vents beroperasi (11.1.8)	1	1		6
SSCL-2487-20251229075541	1A	Fixed and portable oxygen analysers are operational (2.4)	Fixed dan portable oxygen analysers beroperasi (2.4)	1	1		7
SSCL-2487-20251229075541	1B	Inert gas system pressure and oxygen recorders are operational (11.1.5.2, 11.1.11)	Pencatat tekanan dan oksigen pada Inert gas system beroperasi  dengan baik (11.1.5.2, 11.1.11)	1	1		1
SSCL-2487-20251229075541	1B	Inert gas system and associated equipment are operational (11.1.5.2, 11.1.11)	Inert gas system dan peralatan pendukungnya beroperasi dengan baik (11.1.5.2, 11.1.11)	1	1		2
SSCL-2487-20251229075541	1B	Cargo tank atmospheres’ oxygen content is less than 8% (11.1.3)	Kandungan oksigen pada atmosfer tanki kargo kurang dari 8% (11.1.3)	1	1		3
SSCL-2487-20251229075541	1B	Cargo tank atmospheres are at positive pressure (11.1.3)	Atmosfer tanki kargo berada pada tekanan positif (11.1.3)	1	1		4
SSCL-2487-20251229075541	2	Pre-arrival information is exchanged (6.5, 21.2)	Pertukaran informasi Pre-arrival (6.5, 21.2)	1	1		1
SSCL-2487-20251229075541	2	International shore fire connection is available (5.5, 19.4.3.1, 19.4.3.5)	Tersedia International shore fire connection (5.5, 19.4.3.1, 19.4.3.5)	1	1		2
SSCL-2487-20251229075541	2	Transfer equipment is of suitable construction (18.1, 18.2)	Peralatan transfer dibuat dari bahan yang sesuai (18.1, 18.2)	1	1		3
SSCL-2487-20251229075541	2	Terminal information booklet transmitted to tanker (15.2.2)	Terminal information booklet di berikan ke kapal (15.2.2)	1	1		4
SSCL-2487-20251229075541	2	Pre-berthing information is exchanged (21.3, 22.3)	Pertukaran informasi Pre-berthing (21.3, 22.3)	1	1		5
SSCL-2487-20251229075541	3	Fendering is effective (22.4.1)	Fender berfungsi dengan efektif (22.4.1)	1	1		1
SSCL-2487-20251229075541	3	Mooring arrangement is effective (22.2, 22.4.3)	Mooring arrangement berjalan dengan efektif (22.2, 22.4.3)	1	1		2
SSCL-2487-20251229075541	3	Access to and from the tanker is safe (16.4)	Akses yang aman untuk menuju dan dari kapal (16.4)	1	1		3
SSCL-2487-20251229075541	3	Scuppers and savealls are plugged (23.7.4, 23.7.5)	Lubang saluran pembuangan dan bak penampungan di atas kapal sumbatnya telah terpasang (23.7.4, 23.7.5)	1	1		4
SSCL-2487-20251229075541	3	Cargo system sea connections and overboard discharges are secured (23.7.3)	Kargo sistem jalur air laut dan sistem pembuangan ke laut telah ditutup (23.7.3)	1	1		5
SSCL-2487-20251229075541	3	Very high frequency and ultra high frequency transceivers are set to low power mode (4.11.6, 4.13.2.2)	Very high frequency dan ultra high frequency transceivers diatur ke low power mode (4.11.6, 4.13.2.2)	1	1		6
SSCL-2487-20251229075541	3	External openings in superstructures are controlled (23.1)	Seluruh pintu keluar/masuk pada bagian dek kapal tertutup dan terpantau (23.1)	1	1		7
SSCL-2487-20251229075541	3	Pumproom ventilation is effective (10.12.2)	Ventilasi yang memadai pada pumproom (10.12.2)	1	1		8
SSCL-2487-20251229075541	3	Medium frequency/high frequency radio antennae are isolated (4.11.4, 4.13.2.1)	Antena radio frekuensi sedang/tinggi dimatikan (4.11.4, 4.13.2.1)	1	1		9
SSCL-2487-20251229075541	3	Accommodation spaces are at positive pressure (23.2)	Ruang akomodasi  berada pada tekanan positif (23.2)	1	1		10
SSCL-2487-20251229075541	3	Fire control plans are readily available (9.11.2.5)	Fire control plans telah tersedia (9.11.2.5)	1	1		11
SSCL-2487-20251229075541	4	Fendering is effective (22.4.1)	Fender berfungsi dengan efektif (22.4.1)	1	1		1
SSCL-2487-20251229075541	4	Tanker is moored according to the terminal mooring plan (22.2, 22.4.3)	Kapal tertambat sesuai terminal mooring plan (22.2, 22.4.3)	1	1		2
SSCL-2487-20251229075541	4	Access to and from the terminal is safe (16.4)	Akses yang aman untuk menuju dan dari kapal (16.4)	1	1		3
SSCL-2487-20251229075541	4	Spill containment and sumps are secure (18.4.2, 18.4.3, 23.7.4, 23.7.5)	Penampungan tumpahan dan bak penampung diposisikan dengan aman (18.4.2, 18.4.3, 23.7.4, 23.7.5)	1	1		4
SSCL-2487-20251229075541	5A	Tanker is ready to move at agreed notice period (9.11, 21.7.1.1, 22.5.4)	Kapal siap berolah gerak saat terdapat permintaan (9.11, 21.7.1.1, 22.5.4)	1	1		1
SSCL-2487-20251229075541	5A	Effective tanker and terminal communications are established (21.1.1, 21.1.2)	Komunikasi antara kapal dan terminal telah disepakati (21.1.1, 21.1.2)	1	1		2
SSCL-2487-20251229075541	5A	Transfer equipment is in safe condition (isolated, drained and de-pressurised) (18.4.1)	Peralatan transfer dalam kondisi yang baik (diisolasi/ditutup, dikeringkan dan de-pressurised) (18.4.1)	1	1		3
SSCL-2487-20251229075541	5A	Operation supervision and watchkeeping is adequate (7.9, 23.11)	Terdapat pengawasan operasi dan pengawas jaga yang memadai (7.9, 23.11)	1	1		4
SSCL-2487-20251229075541	5A	There are sufficient personnel to deal with an emergency (9.11.2.2, 23.11)	Terdapat personil yang cukup untuk menghadapi keadaan darurat. (9.11.2.2, 23.11)	1	1		5
SSCL-2487-20251229075541	5A	Smoking restrictions and designated smoking areas are established (4.10, 23.10)	Pembatasan merokok dan area khusus merokok ditetapkan (4.10, 23.10)	1	1		6
SSCL-2487-20251229075541	5A	Naked light restrictions are established (4.10.1)	Pembatasan api yang terbuka/menyala ditetapkan (4.10.1)	1	1		7
SSCL-2487-20251229075541	5A	Control of electrical and electronic devices is agreed (4.11, 4.12)	Kontrol listrik dan perangkat elektronik lainnya disepakati (4.11, 4.12)	1	1		8
SSCL-2487-20251229075541	5A	Means of emergency escape from both tanker and terminal are established (20.5)	Sarana penyelamatkan diri saat keadaan darurat dari kapal dan terminal telah disepakati (20.5)	1	1		9
SSCL-2487-20251229075541	5A	Firefighting equipment is ready for use (5, 19.4, 23.8)	Peralatan pemadam kebakaran siap digunakan (5, 19.4, 23.8)	1	1		10
SSCL-2487-20251229075541	5A	Oil spill clean-up material is available (20.4)	Bahan pembersih tumpahan minyak tersedia (20.4)	1	1		11
SSCL-2487-20251229075541	5A	Manifolds are properly connected (23.6.1)	Manifold terhubung dengan benar (23.6.1)	1	1		12
SSCL-2487-20251229075541	5A	Sampling and gauging protocols are agreed (23.5.3.2, 23.7.7.5)	Prosedur pengambilan sampel dan pengukuran disepakati (23.5.3.2, 23.7.7.5)	1	1		13
SSCL-2487-20251229075541	5A	Procedures for cargo, bunkers and ballast handling operations are agreed (21.4, 21.5, 21.6)	Prosedur untuk penanganan operasi kargo, bunker, dan ballast disepakati (21.4, 21.5, 21.6)	1	1		14
SSCL-2487-20251229075541	5A	Cargo transfer management controls are agreed (12.1)	Pengaturan pengelolaan transfer kargo disepakati (12.1)	1	1		15
SSCL-2487-20251229075541	5A	Cargo tank cleaning requirements, including crude oil washing, are agreed (12.3, 12.5, 21.4.1)	Persyaratan cargo tank cleaning, termasuk crude oil washing (COW), disepakati (12.3, 12.5, 21.4.1)	1	1		16
SSCL-2487-20251229075541	5A	Cargo tank gas freeing arrangements agreed (12.4)	Pengaturan free gas tangki kargo disepakati (12.4)	1	1		17
SSCL-2487-20251229075541	5A	Cargo and bunker slop handling requirements agreed (12.1, 21.2, 21.4)	Persyaratan penanganan kargo dan bunker slop disepakati (12.1, 21.2, 21.4)	1	1		18
SSCL-2487-20251229075541	5A	Routine for regular checks on cargo transferred are agreed (23.7.2)	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati (23.7.2)	1	1		19
SSCL-2487-20251229075541	5A	Emergency signals and shutdown procedures are agreed (12.1.6.3, 18.5, 21.1.2)	Sinyal darurat dan prosedur shutdown disepakati (12.1.6.3, 18.5, 21.1.2)	1	1		20
SSCL-2487-20251229075541	5A	Safety data sheets are available (1.4.4, 20.1, 21.4)	Tersedia safety data sheets (1.4.4, 20.1, 21.4)	1	1		21
SSCL-2487-20251229075541	5A	Hazardous properties of the products to be transferred are discussed (1.2, 1.4)	Sifat berbahaya dari produk yang akan ditransfer disepakati (1.2, 1.4)	1	1		22
SSCL-2487-20251229075541	5A	Electrical insulation of the tanker/terminal interface is effective (12.9.5, 17.4, 18.2.14)	Isolasi listrik yang memadai pada sambungan kapal / terminal (12.9.5, 17.4, 18.2.14)	1	1		23
SSCL-2487-20251229075541	5A	Tank venting system and closed operation procedures are agreed (11.3.3.1, 21.4, 21.5, 23.3.3)	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati (11.3.3.1, 21.4, 21.5, 23.3.3)	1	1		24
SSCL-2487-20251229075541	5A	Vapour return line operational parameters are agreed (11.5, 18.3, 23.7.7)	Parameter operasional vapour return line disepakati (11.5, 18.3, 23.7.7)	1	1		25
SSCL-2487-20251229075541	5A	Measures to avoid back-filling are agreed (12.1.13.7)	Tindakan untuk menghindari tenakan balik disepakati (12.1.13.7)	1	1		26
SSCL-2487-20251229075541	5A	Status of unused cargo and bunker connections is satisfactory (23.7.1, 23.7.6)	Informasi status jalur pipa kargo dan bunker yang tidak digunakan terlihat jelas (23.7.1, 23.7.6)	1	1		27
SSCL-2487-20251229075541	5A	Portable very high frequency and ultra high frequency radios are intrinsically safe (4.12.4, 21.1.1)	Radio portabel very high frequency dan ultra high frequency adalah intrinsically safe (4.12.4, 21.1.1)	1	1		28
SSCL-2487-20251229075541	5A	Procedures for receiving nitrogen from terminal to cargo tank are agreed (12.1.14.8)	Prosedur untuk penyaluran nitrogen dari terminal ke tangki kargo disepakati (12.1.14.8)	1	1		29
SSCL-2487-20251229075541	5B	Inhibition certificate received (if required) from manufacturer	Inhibition Certificate diterima (jika diperlukan) dari pabrik	1	1		1
SSCL-2487-20251229075541	5B	Appropriate personal protective equipment identified and available (4.8.1)	Alat pelindung diri yang sesuai telah diidentifikasi dan tersedia (4.8.1)	1	1		2
SSCL-2487-20251229075541	5B	Countermeasures against personal contact with cargo are agreed (1.4)	Tindakan penanggulangan terhadap personil terpapar dengan kargo disepakati (1.4)	1	1		3
SSCL-2487-20251229075541	5B	Cargo handling rate and relationship with valve closure times and automatic shutdown systems is agreed (16.8, 21.4, 21.5, 21.6)	Laju aliran saat kargo handling berhubungan dengan waktu penutupan valve dan automatic shutdown systems disepakati (16.8, 21.4, 21.5, 21.6)	1	1		4
SSCL-2487-20251229075541	5B	Cargo system gauge operation and alarm set points are confirmed (12.1.6.6.1)	Cargo system gauge operation dan set point alarm (high level dan high-high level) dikonfirmasi (12.1.6.6.1)	1	1		5
SSCL-2487-20251229075541	5B	Adequate portable vapour detection instruments are in use (2.4)	Peralatan vapour detection portabel yang memadai berfungsi (2.4)	1	1		6
SSCL-2487-20251229075541	5B	Information on firefighting media and procedures is maind (5, 19)	Informasi tentang media pemadaman kebakaran dan prosedurnya disosialisasikan (5, 19)	1	1		7
SSCL-2487-20251229075541	5B	Transfer hoses confirmed suitable for the product being handled (18.2)	Transfer hose dikonfirmasi sesuai untuk produk yang ditangani (18.2)	1	1		8
SSCL-2487-20251229075541	5B	Confirm cargo handling is only by a permanent installed pipeline system	Konfirmasikan bahwa handling kargo hanya dengan sistem instalasi pipa yang terpasang permanen	1	1		9
SSCL-2487-20251229075541	5B	Procedures are in place to receive nitrogen from the terminal for inerting or purging (12.1.14.8)	Tersedia prosedur untuk menerima nitrogen dari terminal untuk inerting atau pembersihan tangki (12.1.14.8)	1	1		10
SSCL-2487-20251229075541	5C	Inhibition certificate received (if required) from manufacturer	Inhibition Certificate diterima (jika diperlukan) dari pabrik	1	1		1
SSCL-2487-20251229075541	5C	Water spray system is operational (5.3.1, 19.4.3)	Sistem water spray beroperasi (5.3.1, 19.4.3)	1	1		2
SSCL-2487-20251229075541	5C	Appropriate personal protective equipment is identified and available (4.8.1)	Alat pelindung diri yang sesuai telah diidentifikasi dan tersedia (4.8.1)	1	1		3
SSCL-2487-20251229075541	5C	Remote control valves are operational	Remote control valve beroperasi	1	1		4
SSCL-2487-20251229075541	5C	Cargo pumps and compressors are operational	Pompa kargo dan kompresor beroperasi	1	1		5
SSCL-2487-20251229075541	5C	Maximum working pressures are agreed between tanker and terminal (21.4, 21.5, 21.6)	Tekanan kerja maksimum disepakati antara kapal dan terminal (21.4, 21.5, 21.6)	1	1		6
SSCL-2487-20251229075541	5C	Reliquefaction or boil-off control equipment is operational	Peralatan kontrol reliquefaction atau boil-off berfungsi	1	1		7
SSCL-2487-20251229075541	5C	Gas detection equipment is appropriately set for the cargo (2.4)	Peralatan gas detection diatur dengan tepat sesuai jenis kargo (2.4)	1	1		8
SSCL-2487-20251229075541	5C	Cargo system gauge operation and alarm set points are confirmed (12.1.6.6.1)	Cargo system gauge operation dan set point alarm (high level dan high-high level) dikonfirmasi (12.1.6.6.1)	1	1		9
SSCL-2487-20251229075541	5C	Emergency shutdown systems are tested and operational (18.5)	Sistem emergency shutdown telah diuji dan berfungsi (18.5)	1	1		10
SSCL-2487-20251229075541	5C	Cargo handling rate and relationship with valve closure times and automatic shutdown systems is agreed (16.8, 21.4, 21.5, 21.6)	Laju aliran saat kargo handling berhubungan dengan waktu penutupan valve dan automatic shutdown systems disepakati (16.8, 21.4, 21.5, 21.6)	1	1		11
SSCL-2487-20251229075541	5C	Maximum/minimum temperatures/pressures of the cargo to be transferred are agreed (21.4, 21.5, 21.6)	Suhu/tekanan maksimum/minimum kargo yang akan ditransfer disepakati (21.4, 21.5, 21.6)	1	1		12
SSCL-2487-20251229075541	5C	Cargo tank relief valve settings are confirmed (12.11, 21.2, 21.4)	Pengaturan relief valve pada tangki kargo dikonfirmasi (12.11, 21.2, 21.4)	1	1		13
SSCL-2487-20251229075541	6	Tanker manoeuvring readiness	Kesiapan manuver kapal tanker	1	1		1
SSCL-2487-20251229075541	6	Security protocols	Protokol keamanan	1	1		2
SSCL-2487-20251229075541	6	Effective tanker/terminal communications	Komunikasi antara kapal /terminal telah disepakati	1	1		3
SSCL-2487-20251229075541	6	Operational supervision and watchkeeping	Pengawasan operasi dan pengawas jaga	1	1		4
SSCL-2487-20251229075541	6	Dedicated smoking areas and naked lights restrictions	Area khusus merokok dan pembatasan api yang terbuka/menyala	1	1		5
SSCL-2487-20251229075541	6	Maximum wind, current and sea/swell criteria or other environmental factors	Kriteria maksimum kecepatan angin, arus, dan gelombang atau faktor lingkungan lainnya	1	1		6
SSCL-2487-20251229075541	6	Limits for cargo, bunkers and ballast handling	Batasan untuk penanganan operasi kargo, bunker, dan ballast	1	1		7
SSCL-2487-20251229075541	6	Pressure surge control	Pengaturan tekanan tinggi	1	1		8
SSCL-2487-20251229075541	6	Cargo transfer management procedures	Prosedur  cargo transfer management	1	1		9
SSCL-2487-20251229075541	6	Routine for regular checks on cargo transferred are agreed	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati	1	1		10
SSCL-2487-20251229075541	6	Emergency signals	Sinyal darurat	1	1		11
SSCL-2487-20251229075541	6	Cargo transfer management procedures	Prosedur  cargo transfer management	1	1		12
SSCL-2487-20251229075541	6	Routine for regular checks on cargo transferred are agreed	Pemeriksaan rutin secara teratur pada kargo yang ditransfer disepakati	1	1		13
SSCL-2487-20251229075541	6	Emergency signals	Sinyal darurat	1	1		14
SSCL-2487-20251229075541	6	Tank venting system	Sistem ventilasi tangki	1	1		15
SSCL-2487-20251229075541	6	Closed operations	Operasi tertutup	1	1		16
SSCL-2487-20251229075541	6	Vapour return line	Vapour return line	1	1		17
SSCL-2487-20251229075541	6	Nitrogen supply from terminal	Penyaluran nitrogen dari terminal	1	1		18
SSCL-2487-20251229075541	6	For gas tanker only: cargo tank relief valve settings	Hanya untuk kapal gas:Pengaturan relief valve pada tangki kargo	1	1		19
SSCL-2487-20251229075541	6	Exceptions and additions	Pengecualian dan tambahan	1	1		20
SSCL-2487-20251229075541	7A	Portable drip trays are correctly positioned and empty (23.7.5)	Talang penadah portabel di manifold diposisikan dengan benar dan kosong (23.7.5)	1	1		1
SSCL-2487-20251229075541	7A	Individual cargo tank inert gas supply valves are secured for cargo plan (12.1.13.4)	Setiap supply valve pada inert gas tanki kargo disesuaikan dengan rencana pemuatan kargo (12.1.13.4)	1	1		2
SSCL-2487-20251229075541	7A	Inert gas system delivering inert gas with oxygen content not more than 5% (11.1.3)	Inert gas system menghasilkan gas inert dengan kandungan oksigen tidak lebih dari 5% (11.1.3)	1	1		3
SSCL-2487-20251229075541	7A	Cargo tank high level alarms are operational (12.1.6.6.1)	Alarm high level tangki kargo berfungsi (12.1.6.6.1)	1	1		4
SSCL-2487-20251229075541	7A	All cargo, ballast and bunker tanks openings are secured (23.3)	Semua bukaan tangki kargo, ballast, dan bunker ditutup (23.3)	1	1		5
SSCL-2487-20251229075541	7B	The completed pre-arrival crude oil washing checklist, as contained in the approved crude oil washing manual, is copied to terminal (12.5.2, 21.2.3)	Pre-arrival COW check-list, sebagaimana terdapat dalam manual COW yang disetujui, disampaikan ke terminal (12.5.2, 21.2.3)	1	1		1
SSCL-2487-20251229075541	7B	Crude oil washing checklists for use before, during and after crude oil washing are in place ready to complete, as contained in the approved crude oil washing manual (12.5.2, 21.6)	Check-lists pelaksanaan COW pada kondisi sebelum, selama dan setelah kegiatan COW secara lengkap tersedia, sebagaimana terdapat dalam manual COW yang disetujui (12.5.2, 21.6)	1	1		2
SSCL-2487-20251229075541	7C	Permission for tank cleaning operations is confirmed (21.2.3, 21.4, 25.4.3)	Peizinan untuk operasi tank cleaning dikonfirmasi (21.2.3, 21.4, 25.4.3)	1	1		1
SSCL-2487-20251229075541	7C	Permission for gas freeing operations is confirmed (12.4.3)	Izin untuk operasi free gas dikonfirmasi (12.4.3)	1	1		2
SSCL-2487-20251229075541	7C	Tank cleaning procedures are agreed (12.3.2, 21.4, 21.6)	Prosedur tank cleaning disepakati (12.3.2, 21.4, 21.6)	1	1		3
SSCL-2487-20251229075541	7C	If cargo tank entry is required, procedures for entry have been agreed with the terminal (10.5)	Jika diperlukan masuk kedalam tangki kargo, prosedur masuk area confined space telah disepakati dengan terminal (10.5)	1	1		4
SSCL-2487-20251229075541	7C	Slop reception facilities and requirements are confirmed (12.1, 21.2, 21.4)	Fasilitas dan persyaratan penerimaan SLOP dikonfirmasi (12.1, 21.2, 21.4)	1	1		5
SSCL-2487-20251229075541	8	Inert gas system pressure and oxygen recording operational	Pencatat tekanan dan oksigen pada Inert gas system beroperasi  dengan baik	1	1	Oke sip	1
SSCL-2487-20251229075541	8	Inert gas system and all associated equipment are operational	Inert gas system dan peralatan pendukungnya beroperasi dengan baik	1	1		2
SSCL-2487-20251229075541	8	Cargo tank atmospheres are at positive pressure	Atmosfer tanki kargo berada pada tekanan positif	1	1		3
SSCL-2487-20251229075541	8	Mooring arrangement is effective	Mooring arrangement berjalan efektif	1	1		4
SSCL-2487-20251229075541	8	Access to and from the tanker is safe	Akses yang aman untuk menuju dan dari kapal	1	1		5
SSCL-2487-20251229075541	8	Scuppers and save-alls are plugged	Lubang saluran pembuangan dan bak penampungan di atas kapal sumbatnya telah terpasang	1	1		6
SSCL-2487-20251229075541	8	External openings in superstructures are controlled	Seluruh pintu keluar/masuk pada bagian dek kapal tertutup dan terpantau	1	1		7
SSCL-2487-20251229075541	8	Pumproom ventilation is effective	Ventilasi yang memadai pada pumproom	1	1		8
SSCL-2487-20251229075541	8	Fendering is effective 	Fender berfungsi dengan efektif	1	1		9
SSCL-2487-20251229075541	8	Tanker is ready to move at agreed notice period	Kapal siap berolah gerak saat terdapat permintaan	1	1		10
SSCL-2487-20251229075541	8	Communications are effective	Komunikasi yang baik	1	1		11
SSCL-2487-20251229075541	8	Supervision and watchkeeping is adequate	Pengawasan operasi dan pengawas jaga yang memadai	1	1		12
SSCL-2487-20251229075541	8	Sufficient personnel are available to deal with an emergency	Terdapat personil yang cukup untuk menghadapi keadaan darurat	1	1		13
SSCL-2487-20251229075541	8	Smoking restrictions and designated moking areas are complied with	Pembatasan merokok dan area khusus merokok dipatuhi	1	1		14
SSCL-2487-20251229075541	8	Naked light restrictions are complied with	Pembatasan api yang terbuka/menyala dipatuhi	1	1		15
SSCL-2487-20251229075541	8	Control of electrical devices and equipment in hazardous zones is complied with	Pengaturan peralatan listrik dan perangkat elektronik di zona berbahaya dipatuhi	1	1		16
SSCL-2487-20251229075541	8	Emergency response preparedness is Satisfactory	Kesiapsiagaan tanggap darurat sangat memuaskan	1	1		17
SSCL-2487-20251229075541	8	Electrical insulation of the tanker/terminal interface is effective	Isolasi listrik yang memadai pada sambungan kapal / terminal	1	1		18
SSCL-2487-20251229075541	8	Tank venting system and closed operation procedures are as agreed	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati	1	1		19
SSCL-2487-20251229075541	8	Individual cargo tank inert gas valves settings are as agreed	Pengaruran setiap supply valve pada inert gas tanki kargo disepakati	1	1		20
SSCL-2487-20251229075541	8	Inert gas delivery maintained at not more than 5% oxygen	Inert gas yang dihasilkann untuk menjaga kandungan oksigen tidak lebih dari 5%	1	1		21
SSCL-2487-20251229075541	8	Cargo tank high level alarms are operational	Alarm high level tangki kargo berfungsi	1	1		22
SSCL-2487-20251229075541	9	Mooring arrangement is effective	Mooring arrangement berjalan dengan efektif	1	1	Waduh	1
SSCL-2487-20251229075541	9	Access to and from the tanker is safe	Akses yang aman untuk menuju dan dari kapal	1	1		2
SSCL-2487-20251229075541	9	Fendering is effective 	Fender berfungsi dengan efektif	1	1		3
SSCL-2487-20251229075541	9	Spill containment and sumps are secure	Penampungan tumpahan dan bak penampung diposisikan dengan aman	1	1		4
SSCL-2487-20251229075541	9	Communications are effective	Komunikasi yang baik	1	1		5
SSCL-2487-20251229075541	9	Supervision and watchkeeping is adequate	Pengawasan operasi dan pengawas jaga yang memadai	1	1		6
SSCL-2487-20251229075541	9	Sufficient personnel are available to deal with an emergency	Terdapat personil yang cukup untuk menghadapi keadaan darurat	1	1		7
SSCL-2487-20251229075541	9	Smoking restrictions and designated smoking areas are complied with	Pembatasan merokok dan area khusus merokok dipatuhi	1	1		8
SSCL-2487-20251229075541	9	Naked light restrictions are complied with	Pembatasan api yang terbuka/menyala dipatuhi	1	1		9
SSCL-2487-20251229075541	9	Control of electrical devices and equipment in hazardous zones is complied with	Pengaturan peralatan listrik dan perangkat elektronik di zona berbahaya dipatuhi	1	1		10
SSCL-2487-20251229075541	9	Emergency response preparedness is Satisfactory	Kesiapsiagaan tanggap darurat sangat memuaskan	1	1		11
SSCL-2487-20251229075541	9	Electrical insulation of the tanker/terminal interface is effective	Isolasi listrik yang memadai pada sambungan kapal / terminal	1	1		12
SSCL-2487-20251229075541	9	Tank venting system and closed operation procedures are as agreed	Sistem ventilasi tangki dan prosedur operasi tertutup disepakati	1	1		13
\.


--
-- TOC entry 4966 (class 0 OID 16390)
-- Dependencies: 219
-- Data for Name: master_berth; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.master_berth (berth_id, berth_name, berth_code, created_at, deleted_at) FROM stdin;
1	AA	AC	2025-08-28 04:00:24.170697	\N
\.


--
-- TOC entry 4968 (class 0 OID 16405)
-- Dependencies: 221
-- Data for Name: master_cargo; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.master_cargo (cargo_id, cargo_name, cargo_code, created_at, deleted_at) FROM stdin;
1	A	A	2025-08-29 01:15:50.106728	\N
2	Batu Bara	001	2025-12-23 14:59:23.05847	\N
\.


--
-- TOC entry 4970 (class 0 OID 16414)
-- Dependencies: 223
-- Data for Name: master_port; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.master_port (port_id, port_name, port_code, created_at, deleted_at) FROM stdin;
1	Kalimantan	V.1.0	2025-08-26 02:19:44.555242	\N
\.


--
-- TOC entry 4972 (class 0 OID 16425)
-- Dependencies: 225
-- Data for Name: master_ship; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.master_ship (ship_id, ship_name, ship_code, created_at, deleted_at) FROM stdin;
1	KAPAL INDO	vk.0.0.1	2025-08-25 06:02:09.22146	2025-08-25
11	KAPAL Jaya	V00	2025-08-28 03:39:40.835598	2025-08-28
12	KAPAL I	h	2025-08-28 03:40:41.481506	2025-08-28
13	AA	m	2025-08-28 13:21:53.493652	2025-12-28
15	MT JAYA ABADI	0200	2025-12-28 13:06:31.55633	\N
14	MT KARYA	002	2025-12-23 14:58:57.312558	\N
\.


--
-- TOC entry 4977 (class 0 OID 16466)
-- Dependencies: 230
-- Data for Name: negative_feedback; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.negative_feedback (nf_id, ship_id, port_id, status_nf, created_by, created_at, approver, port_next_id) FROM stdin;
NF-9244-20251227110321	14	1	1	Admin	2025-12-27 11:03:35.704044	Admin	1
\.


--
-- TOC entry 4979 (class 0 OID 16480)
-- Dependencies: 232
-- Data for Name: negative_feedback_ref; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.negative_feedback_ref (ref_number, eng, ind) FROM stdin;
VIQ 5.5	\N	\N
\.


--
-- TOC entry 4975 (class 0 OID 16454)
-- Dependencies: 228
-- Data for Name: sscl_transaction; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.sscl_transaction (sscl_id, officer_name, officer_position, officer_contact, ship_id, port_id, berth_id, cargo_id, date_arrival, time_arrival, mt_name, status_sscl, created_by, approver, time_8, time_9, interval_8, interval_9) FROM stdin;
SSCL-8815-20251228091110	a	a	212	14	1	1	2	2025-12-28	09:10	bambang	1	Admin	Admin	2	2	0	0
SSCL-2487-20251229075541	HERU	STAFF	09	15	1	1	2	2025-12-29	07:55	SIGIT	1	ADMIN	Admin	3	4	2	3
\.


--
-- TOC entry 4974 (class 0 OID 16436)
-- Dependencies: 227
-- Data for Name: users; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.users (user_id, full_name, email, password, role, "position", status_account, token_verifier, created_at, deleted_at) FROM stdin;
2	Bambang	nahkoda@gmail.com	$2b$10$pdYUly1xmXUGQpjtXYDEFeVXcd8BlCtSFlcllM7s8nV4JRW/mDeN6	2	Nahkoda	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoZW50aWNhdGVkIjp0cnVlLCJmdWxsX25hbWUiOiJCYW1iYW5nIiwicm9sZSI6MiwicG9zaXRpb24iOiJOYWhrb2RhIiwiaWF0IjoxNzU0OTYxNDA4LCJleHAiOjE3NTQ5Njg2MDh9.5QNyn6Vf9MYHeN0xKREg_LkYXXdki5gra25SALFZA_s	2025-08-11 17:52:19.684714	\N
39	v	renryuuka@gmail.com	$2b$10$Ysf/Ny0KOCB5KteUXV.P1.NnqZmiEcuvak4a2LwtKAaG7NEVjZQhG	2	Verifier	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoZW50aWNhdGVkIjp0cnVlLCJmdWxsX25hbWUiOiJ2Iiwicm9sZSI6MiwicG9zaXRpb24iOiJWZXJpZmllciIsImlhdCI6MTc2NjQ3MTA4OSwiZXhwIjoxNzY2NDkyNjg5fQ.A5CgkOlAmgbrw_-VtmRbhfedDcm2yan0f08WvPeij2k	2025-12-23 13:22:03.550065	\N
1	Admin	admin@gmail.com	$2b$10$YdqEwgQXttQTrFpSIO3VJerYW6W48pTxLdWfnn5oNEnpwnUBCyLyq	1	Super Admin	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoZW50aWNhdGVkIjp0cnVlLCJmdWxsX25hbWUiOiJBZG1pbiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicm9sZSI6MSwicG9zaXRpb24iOiJTdXBlciBBZG1pbiIsImlhdCI6MTc2Njk2OTcyMCwiZXhwIjoxNzY2OTkxMzIwfQ.HvPYXtlfLay4yqe30b8FBxUMDfXFhutpVglGMVGAZDg	2025-08-09 08:58:25.630398	\N
40	Hai	hai@gmail.com	$2b$10$XBcXiWI6XJor0IjwahydouqO/vol56kXjWH39a5PfU7gCAbPTodna	3	Checker	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoZW50aWNhdGVkIjp0cnVlLCJmdWxsX25hbWUiOiJIYWkiLCJyb2xlIjozLCJwb3NpdGlvbiI6IkNoZWNrZXIiLCJpYXQiOjE3NjY0NzM1MDYsImV4cCI6MTc2NjQ5NTEwNn0.k9ChVc_IkyEuc9tenYqbOzF9ohLg2jfO_gusOSVLPME	2025-12-23 14:04:29.4893	\N
\.


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 233
-- Name: detail_negative_feedback_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.detail_negative_feedback_id_seq', 7, true);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 218
-- Name: master_berth_berth_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.master_berth_berth_id_seq', 1, true);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 220
-- Name: master_cargo_cargo_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.master_cargo_cargo_id_seq', 2, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 222
-- Name: master_port_port_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.master_port_port_id_seq', 1, true);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 224
-- Name: master_ship_ship_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.master_ship_ship_id_seq', 15, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 226
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.users_user_id_seq', 41, true);


--
-- TOC entry 4813 (class 2606 OID 16445)
-- Name: users email_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.users
    ADD CONSTRAINT email_key UNIQUE (email);


--
-- TOC entry 4801 (class 2606 OID 16397)
-- Name: master_berth master_berth_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_berth
    ADD CONSTRAINT master_berth_pkey PRIMARY KEY (berth_id);


--
-- TOC entry 4803 (class 2606 OID 16412)
-- Name: master_cargo master_cargo_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_cargo
    ADD CONSTRAINT master_cargo_pkey PRIMARY KEY (cargo_id);


--
-- TOC entry 4805 (class 2606 OID 16423)
-- Name: master_port master_port_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_port
    ADD CONSTRAINT master_port_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4809 (class 2606 OID 16434)
-- Name: master_ship master_ship_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_ship
    ADD CONSTRAINT master_ship_pkey PRIMARY KEY (ship_id);


--
-- TOC entry 4819 (class 2606 OID 16471)
-- Name: negative_feedback negative_feedback_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.negative_feedback
    ADD CONSTRAINT negative_feedback_pkey PRIMARY KEY (nf_id);


--
-- TOC entry 4807 (class 2606 OID 16421)
-- Name: master_port port_code_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_port
    ADD CONSTRAINT port_code_key UNIQUE (port_code);


--
-- TOC entry 4811 (class 2606 OID 16432)
-- Name: master_ship ship_code_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.master_ship
    ADD CONSTRAINT ship_code_key UNIQUE (ship_code);


--
-- TOC entry 4817 (class 2606 OID 16460)
-- Name: sscl_transaction sscl_transaction_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.sscl_transaction
    ADD CONSTRAINT sscl_transaction_pkey PRIMARY KEY (sscl_id);


--
-- TOC entry 4815 (class 2606 OID 16447)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


-- Completed on 2026-01-24 22:26:02

--
-- PostgreSQL database dump complete
--

\unrestrict rQxoQFfZXcd4TqedQbqWmomMhixKJ9laKrwCuEyDh81Wp4fwLWh7Znf9YW5plqx

