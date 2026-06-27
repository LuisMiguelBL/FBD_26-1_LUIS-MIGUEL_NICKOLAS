--
-- PostgreSQL database dump
--

\restrict lgcThvCcOQx3g8exEeTffWrcBpdUfb98M1xZQemDFjMzuzX2U5UBhXIsXX5D38W

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-27 10:38:25 -03

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
-- TOC entry 5 (class 2615 OID 16603)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 16768)
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    id integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    status character varying(20) NOT NULL,
    cpf_patient character varying(11) NOT NULL,
    cpf_doctor character varying NOT NULL,
    cpf_receptionist character varying,
    CONSTRAINT check_appointment_status_values CHECK (((status)::text = ANY ((ARRAY['Scheduled'::character varying, 'Confirmed'::character varying, 'Cancelled'::character varying, 'Rescheduled'::character varying, 'Completed'::character varying])::text[])))
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16767)
-- Name: appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_id_seq OWNER TO postgres;

--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 233
-- Name: appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_id_seq OWNED BY public.appointment.id;


--
-- TOC entry 227 (class 1259 OID 16665)
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    cpf_employee character varying NOT NULL,
    crm character varying(20) NOT NULL,
    schedule_status character varying(20) NOT NULL
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16715)
-- Name: doctorspeciality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctorspeciality (
    cpf_doctor character varying NOT NULL,
    id_speciality integer NOT NULL
);


ALTER TABLE public.doctorspeciality OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16631)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    cpf character varying(11) NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    birth_date date NOT NULL,
    street character varying(100) NOT NULL,
    number character varying(10) NOT NULL,
    neighborhood character varying(100) NOT NULL,
    zip_code character varying(10) NOT NULL,
    city character varying(100) NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    CONSTRAINT check_employee_birth_date CHECK ((birth_date <= CURRENT_DATE)),
    CONSTRAINT check_employee_cpf_length CHECK ((length((cpf)::text) = 11)),
    CONSTRAINT check_employee_email_format CHECK (((email)::text ~~ '%@%.%'::text)),
    CONSTRAINT check_employee_zip_code CHECK (((zip_code)::text ~ '^[0-9]{5}-[0-9]{3}$'::text))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16651)
-- Name: employeephone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employeephone (
    cpf_employee character varying NOT NULL,
    phone character varying NOT NULL
);


ALTER TABLE public.employeephone OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16614)
-- Name: insurance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insurance (
    id integer NOT NULL,
    insurance_name character varying(100) NOT NULL,
    ans_code character varying(20)
);


ALTER TABLE public.insurance OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16613)
-- Name: insurance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.insurance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.insurance_id_seq OWNER TO postgres;

--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 221
-- Name: insurance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.insurance_id_seq OWNED BY public.insurance.id;


--
-- TOC entry 238 (class 1259 OID 16817)
-- Name: medical_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_record (
    id integer NOT NULL,
    appointment_id integer NOT NULL,
    symptoms text NOT NULL,
    diagnosis text NOT NULL,
    requested_exams text
);


ALTER TABLE public.medical_record OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16816)
-- Name: medical_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medical_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medical_record_id_seq OWNER TO postgres;

--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 237
-- Name: medical_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medical_record_id_seq OWNED BY public.medical_record.id;


--
-- TOC entry 229 (class 1259 OID 16697)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    cpf character varying(11) NOT NULL,
    full_name character varying(100) NOT NULL,
    birth_date date NOT NULL,
    street character varying(100) NOT NULL,
    number character varying(10) NOT NULL,
    neighborhood character varying(100) NOT NULL,
    zip_code character varying(10) NOT NULL,
    city character varying(100) NOT NULL,
    insurance_id integer,
    CONSTRAINT check_patient_birth_date CHECK ((birth_date <= CURRENT_DATE)),
    CONSTRAINT check_patient_cpf_length CHECK ((length((cpf)::text) = 11)),
    CONSTRAINT check_patient_zip_code CHECK (((zip_code)::text ~ '^[0-9]{5}-[0-9]{3}$'::text))
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16753)
-- Name: patientphone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patientphone (
    cpf_patient character varying NOT NULL,
    phone character varying NOT NULL
);


ALTER TABLE public.patientphone OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16800)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    appointment_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(50) NOT NULL,
    payment_status character varying(20) NOT NULL,
    CONSTRAINT check_payment_amount_positive CHECK ((amount >= (0)::numeric)),
    CONSTRAINT check_payment_status_values CHECK (((payment_status)::text = ANY ((ARRAY['Paid'::character varying, 'Pending'::character varying, 'Cancelled'::character varying, 'Refunded'::character varying])::text[])))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16799)
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_id_seq OWNER TO postgres;

--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 235
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- TOC entry 240 (class 1259 OID 16837)
-- Name: prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription (
    id integer NOT NULL,
    appointment_id integer NOT NULL,
    prescription_details text NOT NULL,
    issue_date date NOT NULL
);


ALTER TABLE public.prescription OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16836)
-- Name: prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescription_id_seq OWNER TO postgres;

--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 239
-- Name: prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_id_seq OWNED BY public.prescription.id;


--
-- TOC entry 228 (class 1259 OID 16682)
-- Name: receptionist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receptionist (
    cpf_employee character varying NOT NULL,
    shift character varying(20) NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE public.receptionist OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16734)
-- Name: receptionistsector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receptionistsector (
    cpf_receptionist character varying NOT NULL,
    id_sector integer NOT NULL
);


ALTER TABLE public.receptionistsector OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16623)
-- Name: sector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sector (
    id integer NOT NULL,
    sector_description character varying(100) NOT NULL
);


ALTER TABLE public.sector OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16622)
-- Name: sector_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sector_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sector_id_seq OWNER TO postgres;

--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 223
-- Name: sector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sector_id_seq OWNED BY public.sector.id;


--
-- TOC entry 220 (class 1259 OID 16605)
-- Name: speciality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.speciality (
    id integer NOT NULL,
    specialty_name character varying(100) NOT NULL
);


ALTER TABLE public.speciality OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16604)
-- Name: speciality_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.speciality_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.speciality_id_seq OWNER TO postgres;

--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 219
-- Name: speciality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.speciality_id_seq OWNED BY public.speciality.id;


--
-- TOC entry 4391 (class 2604 OID 16771)
-- Name: appointment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN id SET DEFAULT nextval('public.appointment_id_seq'::regclass);


--
-- TOC entry 4389 (class 2604 OID 16617)
-- Name: insurance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance ALTER COLUMN id SET DEFAULT nextval('public.insurance_id_seq'::regclass);


--
-- TOC entry 4393 (class 2604 OID 16820)
-- Name: medical_record id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_record ALTER COLUMN id SET DEFAULT nextval('public.medical_record_id_seq'::regclass);


--
-- TOC entry 4392 (class 2604 OID 16803)
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- TOC entry 4394 (class 2604 OID 16840)
-- Name: prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription ALTER COLUMN id SET DEFAULT nextval('public.prescription_id_seq'::regclass);


--
-- TOC entry 4390 (class 2604 OID 16626)
-- Name: sector id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector ALTER COLUMN id SET DEFAULT nextval('public.sector_id_seq'::regclass);


--
-- TOC entry 4388 (class 2604 OID 16608)
-- Name: speciality id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speciality ALTER COLUMN id SET DEFAULT nextval('public.speciality_id_seq'::regclass);


--
-- TOC entry 4620 (class 0 OID 16768)
-- Dependencies: 234
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (id, date, "time", status, cpf_patient, cpf_doctor, cpf_receptionist) FROM stdin;
1	2026-07-01	08:00:00	Completed	00011122233	11122233344	77788899900
2	2026-07-01	09:30:00	Completed	44455566677	55566677788	77788899900
3	2026-07-02	14:00:00	Confirmed	88899900011	33344455566	22233344455
4	2026-07-02	15:00:00	Completed	12121212121	44433322211	22211100099
5	2026-07-03	10:00:00	Scheduled	34343434343	88877766655	66655544433
\.


--
-- TOC entry 4613 (class 0 OID 16665)
-- Dependencies: 227
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (cpf_employee, crm, schedule_status) FROM stdin;
11122233344	CRM/PE 12345	Active
55566677788	CRM/PE 67890	Active
33344455566	CRM/PE 11223	Active
44433322211	CRM/PE 44556	Active
88877766655	CRM/PE 77889	Active
\.


--
-- TOC entry 4616 (class 0 OID 16715)
-- Dependencies: 230
-- Data for Name: doctorspeciality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctorspeciality (cpf_doctor, id_speciality) FROM stdin;
11122233344	1
55566677788	2
33344455566	3
44433322211	4
88877766655	5
\.


--
-- TOC entry 4611 (class 0 OID 16631)
-- Dependencies: 225
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (cpf, full_name, email, birth_date, street, number, neighborhood, zip_code, city, login, password) FROM stdin;
11122233344	Ricardo Oliveira Melo	ricardo.melo@mediflow.com	1985-03-12	Rua Enock Inácio de Oliveira	540	Nossa Senhora da Penha	56903-000	Serra Talhada	rmelo	hashed_pw_1
55566677788	Ana Beatriz Souza	ana.souza@mediflow.com	1990-07-22	Avenida Afonso Magalhães	1200	São Cristóvão	56903-450	Serra Talhada	asouza	hashed_pw_2
33344455566	Marcos Antônio Lima	marcos.lima@mediflow.com	1978-11-30	Rua Agostinho Nunes de Magalhães	45	Nossa Senhora da Conceição	56903-120	Serra Talhada	mlima	hashed_pw_3
77788899900	Patrícia Gomes Santos	patricia.santos@mediflow.com	1995-01-20	Rua Comandante Superior	89	Centro	56900-000	Serra Talhada	psantos	hashed_pw_4
22233344455	Luís Felipe Cavalcanti	luis.felipe@mediflow.com	1988-09-10	Rua Lindoso e Cabral	210	Ipsep	56912-050	Serra Talhada	lfelipe	hashed_pw_5
44433322211	Sérgio Magalhães Neto	sergio.m@mediflow.com	1982-05-15	Rua Enock Inácio de Oliveira	100	Centro	56900-000	Serra Talhada	smagalhaes	hashed_pw_6
88877766655	Fernanda Lima Castro	fernanda.l@mediflow.com	1987-08-25	Rua Joaquim Conrado de Lorena e Sá	50	São Cristóvão	56903-460	Serra Talhada	flima	hashed_pw_7
22211100099	Cláudio Ferreira Vaz	claudio.v@mediflow.com	1992-02-14	Rua Tiburtino Nogueira	200	Ipsep	56912-010	Serra Talhada	cferreira	hashed_pw_8
66655544433	Beatriz Costa Lima	beatriz.c@mediflow.com	1996-10-05	Rua Cornélio Soares	300	Nossa Senhora da Penha	56903-230	Serra Talhada	bcosta	hashed_pw_9
99900011122	Juliana Paes Melo	juliana.p@mediflow.com	1994-12-12	Rua Ademar Xavier	150	Várzea	56912-340	Serra Talhada	jpaes	hashed_pw_10
\.


--
-- TOC entry 4612 (class 0 OID 16651)
-- Dependencies: 226
-- Data for Name: employeephone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employeephone (cpf_employee, phone) FROM stdin;
11122233344	87999991111
55566677788	87977773333
33344455566	87988884444
77788899900	87999995555
22233344455	87988886666
44433322211	87999990001
88877766655	87988880002
22211100099	87977770003
66655544433	87966660004
99900011122	87955550005
\.


--
-- TOC entry 4608 (class 0 OID 16614)
-- Dependencies: 222
-- Data for Name: insurance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.insurance (id, insurance_name, ans_code) FROM stdin;
1	HealthPlus	101020
2	BlueShield	303040
3	SafeLife	505060
4	MediCare	707080
5	GlobalHealth	909010
\.


--
-- TOC entry 4624 (class 0 OID 16817)
-- Dependencies: 238
-- Data for Name: medical_record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medical_record (id, appointment_id, symptoms, diagnosis, requested_exams) FROM stdin;
1	1	Chest pain and fatigue	Mild Hypertension	Electrocardiogram and Blood Test
2	2	Persistent fever and cough	Acute Bronchitis	Chest X-Ray
3	3	Right knee pain after sports	Ligament Strain	Magnetic Resonance Imaging
4	4	Skin redness and itching on arms	Contact Dermatitis	Allergy Panel
5	5	Routine checkup request	Healthy / Routine Assessment	Complete Blood Count
\.


--
-- TOC entry 4615 (class 0 OID 16697)
-- Dependencies: 229
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient (cpf, full_name, birth_date, street, number, neighborhood, zip_code, city, insurance_id) FROM stdin;
00011122233	Alice Bezerra Silva	1998-12-05	Rua Cornélio Soares	15	Nossa Senhora da Penha	56903-230	Serra Talhada	1
44455566677	Roberto Ferreira Lima	1982-04-14	Rua Inocêncio Oliveira	302	Centro	56900-000	Serra Talhada	2
88899900011	Clara Maria Mendes	2010-10-30	Rua Joaquim Conrado de Lorena e Sá	77	São Cristóvão	56903-460	Serra Talhada	\N
12121212121	Fernando Costa Júnior	1975-01-08	Rua Tiburtino Nogueira	101	Ipsep	56912-010	Serra Talhada	3
34343434343	Júlia Magalhães	1992-04-15	Rua Ademar Xavier	500	Várzea	56912-340	Serra Talhada	4
\.


--
-- TOC entry 4618 (class 0 OID 16753)
-- Dependencies: 232
-- Data for Name: patientphone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patientphone (cpf_patient, phone) FROM stdin;
00011122233	87912345678
44455566677	87987654321
88899900011	8738312233
12121212121	87991912222
34343434343	87998983333
\.


--
-- TOC entry 4622 (class 0 OID 16800)
-- Dependencies: 236
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, appointment_id, amount, payment_method, payment_status) FROM stdin;
1	1	250.00	Credit Card	Paid
2	2	150.00	Insurance	Paid
3	3	300.00	Cash	Pending
4	4	250.00	Debit Card	Paid
5	5	200.00	Insurance	Pending
\.


--
-- TOC entry 4626 (class 0 OID 16837)
-- Dependencies: 240
-- Data for Name: prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription (id, appointment_id, prescription_details, issue_date) FROM stdin;
1	1	Aspirin 100mg once daily; Losartan 50mg in the morning for 30 days.	2026-07-01
2	2	Amoxicillin 500mg every 8 hours for 7 days; Paracetamol 500mg if fever.	2026-07-01
3	3	Ibuprofen 600mg every 12 hours for 5 days; Application of ice packs.	2026-07-02
4	4	Hydrocortisone cream 1% apply twice daily; Loratadine 10mg once daily.	2026-07-02
5	5	Multivitamin supplement 1 capsule daily with lunch for 60 days.	2026-07-03
\.


--
-- TOC entry 4614 (class 0 OID 16682)
-- Dependencies: 228
-- Data for Name: receptionist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receptionist (cpf_employee, shift, status) FROM stdin;
77788899900	Morning	Active
22233344455	Afternoon	Active
22211100099	Morning	Active
66655544433	Afternoon	Active
99900011122	Night	Active
\.


--
-- TOC entry 4617 (class 0 OID 16734)
-- Dependencies: 231
-- Data for Name: receptionistsector; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receptionistsector (cpf_receptionist, id_sector) FROM stdin;
77788899900	1
22233344455	4
22211100099	2
66655544433	3
99900011122	5
\.


--
-- TOC entry 4610 (class 0 OID 16623)
-- Dependencies: 224
-- Data for Name: sector; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sector (id, sector_description) FROM stdin;
1	Main Reception
2	Emergency Wing
3	Specialized Clinics
4	Financial Dept
5	Administration
\.


--
-- TOC entry 4606 (class 0 OID 16605)
-- Dependencies: 220
-- Data for Name: speciality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.speciality (id, specialty_name) FROM stdin;
1	Cardiology
2	Pediatrics
3	Orthopedics
4	Dermatology
5	General Practice
\.


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 233
-- Name: appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_id_seq', 5, true);


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 221
-- Name: insurance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.insurance_id_seq', 5, true);


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 237
-- Name: medical_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medical_record_id_seq', 5, true);


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 235
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_id_seq', 5, true);


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 239
-- Name: prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_id_seq', 5, true);


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 223
-- Name: sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sector_id_seq', 5, true);


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 219
-- Name: speciality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.speciality_id_seq', 5, true);


--
-- TOC entry 4432 (class 2606 OID 16781)
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (id);


--
-- TOC entry 4418 (class 2606 OID 16676)
-- Name: doctor doctor_crm_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_crm_key UNIQUE (crm);


--
-- TOC entry 4420 (class 2606 OID 16674)
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (cpf_employee);


--
-- TOC entry 4426 (class 2606 OID 16723)
-- Name: doctorspeciality doctorspeciality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_pkey PRIMARY KEY (cpf_doctor, id_speciality);


--
-- TOC entry 4412 (class 2606 OID 16650)
-- Name: employee employee_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_login_key UNIQUE (login);


--
-- TOC entry 4414 (class 2606 OID 16648)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (cpf);


--
-- TOC entry 4416 (class 2606 OID 16659)
-- Name: employeephone employeephone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employeephone
    ADD CONSTRAINT employeephone_pkey PRIMARY KEY (cpf_employee, phone);


--
-- TOC entry 4408 (class 2606 OID 16621)
-- Name: insurance insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (id);


--
-- TOC entry 4438 (class 2606 OID 16830)
-- Name: medical_record medical_record_appointment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_record
    ADD CONSTRAINT medical_record_appointment_id_key UNIQUE (appointment_id);


--
-- TOC entry 4440 (class 2606 OID 16828)
-- Name: medical_record medical_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_record
    ADD CONSTRAINT medical_record_pkey PRIMARY KEY (id);


--
-- TOC entry 4424 (class 2606 OID 16709)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (cpf);


--
-- TOC entry 4430 (class 2606 OID 16761)
-- Name: patientphone patientphone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientphone
    ADD CONSTRAINT patientphone_pkey PRIMARY KEY (cpf_patient, phone);


--
-- TOC entry 4436 (class 2606 OID 16810)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 4442 (class 2606 OID 16848)
-- Name: prescription prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (id);


--
-- TOC entry 4422 (class 2606 OID 16691)
-- Name: receptionist receptionist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionist
    ADD CONSTRAINT receptionist_pkey PRIMARY KEY (cpf_employee);


--
-- TOC entry 4428 (class 2606 OID 16742)
-- Name: receptionistsector receptionistsector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_pkey PRIMARY KEY (cpf_receptionist, id_sector);


--
-- TOC entry 4410 (class 2606 OID 16630)
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (id);


--
-- TOC entry 4406 (class 2606 OID 16612)
-- Name: speciality speciality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speciality
    ADD CONSTRAINT speciality_pkey PRIMARY KEY (id);


--
-- TOC entry 4434 (class 2606 OID 16783)
-- Name: appointment unique_doctor_appointment_schedule; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT unique_doctor_appointment_schedule UNIQUE (cpf_doctor, date, "time");


--
-- TOC entry 4452 (class 2606 OID 16789)
-- Name: appointment appointment_cpf_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_cpf_doctor_fkey FOREIGN KEY (cpf_doctor) REFERENCES public.doctor(cpf_employee) ON DELETE RESTRICT;


--
-- TOC entry 4453 (class 2606 OID 16784)
-- Name: appointment appointment_cpf_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_cpf_patient_fkey FOREIGN KEY (cpf_patient) REFERENCES public.patient(cpf) ON DELETE RESTRICT;


--
-- TOC entry 4454 (class 2606 OID 16794)
-- Name: appointment appointment_cpf_receptionist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_cpf_receptionist_fkey FOREIGN KEY (cpf_receptionist) REFERENCES public.receptionist(cpf_employee) ON DELETE RESTRICT;


--
-- TOC entry 4444 (class 2606 OID 16677)
-- Name: doctor doctor_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE RESTRICT;


--
-- TOC entry 4447 (class 2606 OID 16724)
-- Name: doctorspeciality doctorspeciality_cpf_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_cpf_doctor_fkey FOREIGN KEY (cpf_doctor) REFERENCES public.doctor(cpf_employee) ON DELETE CASCADE;


--
-- TOC entry 4448 (class 2606 OID 16729)
-- Name: doctorspeciality doctorspeciality_id_speciality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_id_speciality_fkey FOREIGN KEY (id_speciality) REFERENCES public.speciality(id) ON DELETE RESTRICT;


--
-- TOC entry 4443 (class 2606 OID 16660)
-- Name: employeephone employeephone_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employeephone
    ADD CONSTRAINT employeephone_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE CASCADE;


--
-- TOC entry 4456 (class 2606 OID 16831)
-- Name: medical_record medical_record_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_record
    ADD CONSTRAINT medical_record_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(id) ON DELETE RESTRICT;


--
-- TOC entry 4446 (class 2606 OID 16710)
-- Name: patient patient_insurance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_insurance_id_fkey FOREIGN KEY (insurance_id) REFERENCES public.insurance(id) ON DELETE RESTRICT;


--
-- TOC entry 4451 (class 2606 OID 16762)
-- Name: patientphone patientphone_cpf_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientphone
    ADD CONSTRAINT patientphone_cpf_patient_fkey FOREIGN KEY (cpf_patient) REFERENCES public.patient(cpf) ON DELETE CASCADE;


--
-- TOC entry 4455 (class 2606 OID 16811)
-- Name: payment payment_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(id) ON DELETE RESTRICT;


--
-- TOC entry 4457 (class 2606 OID 16849)
-- Name: prescription prescription_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(id) ON DELETE RESTRICT;


--
-- TOC entry 4445 (class 2606 OID 16692)
-- Name: receptionist receptionist_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionist
    ADD CONSTRAINT receptionist_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE RESTRICT;


--
-- TOC entry 4449 (class 2606 OID 16743)
-- Name: receptionistsector receptionistsector_cpf_receptionist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_cpf_receptionist_fkey FOREIGN KEY (cpf_receptionist) REFERENCES public.receptionist(cpf_employee) ON DELETE CASCADE;


--
-- TOC entry 4450 (class 2606 OID 16748)
-- Name: receptionistsector receptionistsector_id_sector_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id) ON DELETE RESTRICT;


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-06-27 10:38:25 -03

--
-- PostgreSQL database dump complete
--

\unrestrict lgcThvCcOQx3g8exEeTffWrcBpdUfb98M1xZQemDFjMzuzX2U5UBhXIsXX5D38W

