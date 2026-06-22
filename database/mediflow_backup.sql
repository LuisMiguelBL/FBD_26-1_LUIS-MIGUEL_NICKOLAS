--
-- PostgreSQL database dump
--

\restrict UfDAwTySgaloOzUg6SBbgAKBr3QEHLUPPDOZ2w5MfjSk3tQh1sFbtocvWm81mDG

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-21 21:27:03 -03

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16416)
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    id integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    status character varying(20) NOT NULL,
    CONSTRAINT check_appointment_status_values CHECK (((status)::text = ANY ((ARRAY['Scheduled'::character varying, 'Confirmed'::character varying, 'Cancelled'::character varying, 'Rescheduled'::character varying, 'Completed'::character varying])::text[])))
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16415)
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
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 225
-- Name: appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_id_seq OWNED BY public.appointment.id;


--
-- TOC entry 229 (class 1259 OID 16460)
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    cpf_employee character varying NOT NULL,
    crm character varying(20) NOT NULL,
    schedule_status character varying(20) NOT NULL
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16510)
-- Name: doctorspeciality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctorspeciality (
    cpf_doctor character varying NOT NULL,
    id_speciality integer NOT NULL
);


ALTER TABLE public.doctorspeciality OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16426)
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
-- TOC entry 228 (class 1259 OID 16446)
-- Name: employeephone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employeephone (
    cpf_employee character varying NOT NULL,
    phone character varying NOT NULL
);


ALTER TABLE public.employeephone OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16398)
-- Name: insurance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insurance (
    id integer NOT NULL,
    insurance_name character varying(100) NOT NULL,
    ans_code character varying(20)
);


ALTER TABLE public.insurance OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16397)
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
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 221
-- Name: insurance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.insurance_id_seq OWNED BY public.insurance.id;


--
-- TOC entry 235 (class 1259 OID 16562)
-- Name: make; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.make (
    cpf_doctor character varying NOT NULL,
    cpf_receptionist character varying NOT NULL,
    cpf_patient character varying NOT NULL,
    id_appointment integer NOT NULL,
    issue_date date,
    payment_method character varying,
    payment_status character varying,
    amount numeric,
    prescription_details text,
    CONSTRAINT check_make_amount_positive CHECK ((amount >= (0)::numeric)),
    CONSTRAINT check_payment_status_values CHECK (((payment_status)::text = ANY ((ARRAY['Paid'::character varying, 'Pending'::character varying, 'Cancelled'::character varying, 'Refunded'::character varying])::text[])))
);


ALTER TABLE public.make OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16492)
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
-- TOC entry 234 (class 1259 OID 16548)
-- Name: patientphone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patientphone (
    cpf_patient character varying NOT NULL,
    phone character varying NOT NULL
);


ALTER TABLE public.patientphone OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16477)
-- Name: receptionist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receptionist (
    cpf_employee character varying NOT NULL,
    shift character varying(20) NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE public.receptionist OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16529)
-- Name: receptionistsector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receptionistsector (
    cpf_receptionist character varying NOT NULL,
    id_sector integer NOT NULL
);


ALTER TABLE public.receptionistsector OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16407)
-- Name: sector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sector (
    id integer NOT NULL,
    sector_description character varying(100) NOT NULL
);


ALTER TABLE public.sector OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16406)
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
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 223
-- Name: sector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sector_id_seq OWNED BY public.sector.id;


--
-- TOC entry 220 (class 1259 OID 16389)
-- Name: speciality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.speciality (
    id integer NOT NULL,
    specialty_name character varying(100) NOT NULL
);


ALTER TABLE public.speciality OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16388)
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
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 219
-- Name: speciality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.speciality_id_seq OWNED BY public.speciality.id;


--
-- TOC entry 4380 (class 2604 OID 16419)
-- Name: appointment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN id SET DEFAULT nextval('public.appointment_id_seq'::regclass);


--
-- TOC entry 4378 (class 2604 OID 16401)
-- Name: insurance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance ALTER COLUMN id SET DEFAULT nextval('public.insurance_id_seq'::regclass);


--
-- TOC entry 4379 (class 2604 OID 16410)
-- Name: sector id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector ALTER COLUMN id SET DEFAULT nextval('public.sector_id_seq'::regclass);


--
-- TOC entry 4377 (class 2604 OID 16392)
-- Name: speciality id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speciality ALTER COLUMN id SET DEFAULT nextval('public.speciality_id_seq'::regclass);


--
-- TOC entry 4588 (class 0 OID 16416)
-- Dependencies: 226
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (id, date, "time", status) FROM stdin;
1	2026-07-01	08:00:00	Scheduled
2	2026-07-01	09:30:00	Confirmed
3	2026-07-02	14:00:00	Scheduled
4	2026-07-02	15:00:00	Cancelled
5	2026-07-03	10:00:00	Rescheduled
\.


--
-- TOC entry 4591 (class 0 OID 16460)
-- Dependencies: 229
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
-- TOC entry 4594 (class 0 OID 16510)
-- Dependencies: 232
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
-- TOC entry 4589 (class 0 OID 16426)
-- Dependencies: 227
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
-- TOC entry 4590 (class 0 OID 16446)
-- Dependencies: 228
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
-- TOC entry 4584 (class 0 OID 16398)
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
-- TOC entry 4597 (class 0 OID 16562)
-- Dependencies: 235
-- Data for Name: make; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.make (cpf_doctor, cpf_receptionist, cpf_patient, id_appointment, issue_date, payment_method, payment_status, amount, prescription_details) FROM stdin;
11122233344	77788899900	00011122233	1	2026-07-01	Credit Card	Paid	250.00	Aspirin 100mg once a day for 30 days.
55566677788	77788899900	44455566677	2	2026-07-01	Insurance	Paid	150.00	Ibuprofen oral suspension for child.
33344455566	22233344455	88899900011	3	2026-07-02	Cash	Pending	300.00	Knee brace and physical therapy recommended.
44433322211	22211100099	12121212121	4	2026-07-02	Debit Card	Paid	250.00	Topical cream for dermatitis applied twice daily.
88877766655	66655544433	34343434343	5	2026-07-03	Insurance	Paid	200.00	Annual checkup, no immediate medication required.
\.


--
-- TOC entry 4593 (class 0 OID 16492)
-- Dependencies: 231
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
-- TOC entry 4596 (class 0 OID 16548)
-- Dependencies: 234
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
-- TOC entry 4592 (class 0 OID 16477)
-- Dependencies: 230
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
-- TOC entry 4595 (class 0 OID 16529)
-- Dependencies: 233
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
-- TOC entry 4586 (class 0 OID 16407)
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
-- TOC entry 4582 (class 0 OID 16389)
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
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 225
-- Name: appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_id_seq', 5, true);


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 221
-- Name: insurance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.insurance_id_seq', 5, true);


--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 223
-- Name: sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sector_id_seq', 5, true);


--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 219
-- Name: speciality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.speciality_id_seq', 5, true);


--
-- TOC entry 4398 (class 2606 OID 16425)
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (id);


--
-- TOC entry 4406 (class 2606 OID 16471)
-- Name: doctor doctor_crm_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_crm_key UNIQUE (crm);


--
-- TOC entry 4408 (class 2606 OID 16469)
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (cpf_employee);


--
-- TOC entry 4414 (class 2606 OID 16518)
-- Name: doctorspeciality doctorspeciality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_pkey PRIMARY KEY (cpf_doctor, id_speciality);


--
-- TOC entry 4400 (class 2606 OID 16445)
-- Name: employee employee_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_login_key UNIQUE (login);


--
-- TOC entry 4402 (class 2606 OID 16443)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (cpf);


--
-- TOC entry 4404 (class 2606 OID 16454)
-- Name: employeephone employeephone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employeephone
    ADD CONSTRAINT employeephone_pkey PRIMARY KEY (cpf_employee, phone);


--
-- TOC entry 4394 (class 2606 OID 16405)
-- Name: insurance insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (id);


--
-- TOC entry 4420 (class 2606 OID 16572)
-- Name: make make_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.make
    ADD CONSTRAINT make_pkey PRIMARY KEY (cpf_doctor, cpf_receptionist, cpf_patient, id_appointment);


--
-- TOC entry 4412 (class 2606 OID 16504)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (cpf);


--
-- TOC entry 4418 (class 2606 OID 16556)
-- Name: patientphone patientphone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientphone
    ADD CONSTRAINT patientphone_pkey PRIMARY KEY (cpf_patient, phone);


--
-- TOC entry 4410 (class 2606 OID 16486)
-- Name: receptionist receptionist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionist
    ADD CONSTRAINT receptionist_pkey PRIMARY KEY (cpf_employee);


--
-- TOC entry 4416 (class 2606 OID 16537)
-- Name: receptionistsector receptionistsector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_pkey PRIMARY KEY (cpf_receptionist, id_sector);


--
-- TOC entry 4396 (class 2606 OID 16414)
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (id);


--
-- TOC entry 4392 (class 2606 OID 16396)
-- Name: speciality speciality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speciality
    ADD CONSTRAINT speciality_pkey PRIMARY KEY (id);


--
-- TOC entry 4422 (class 2606 OID 16472)
-- Name: doctor doctor_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE CASCADE;


--
-- TOC entry 4425 (class 2606 OID 16519)
-- Name: doctorspeciality doctorspeciality_cpf_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_cpf_doctor_fkey FOREIGN KEY (cpf_doctor) REFERENCES public.doctor(cpf_employee);


--
-- TOC entry 4426 (class 2606 OID 16524)
-- Name: doctorspeciality doctorspeciality_id_speciality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctorspeciality
    ADD CONSTRAINT doctorspeciality_id_speciality_fkey FOREIGN KEY (id_speciality) REFERENCES public.speciality(id);


--
-- TOC entry 4421 (class 2606 OID 16455)
-- Name: employeephone employeephone_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employeephone
    ADD CONSTRAINT employeephone_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE CASCADE;


--
-- TOC entry 4430 (class 2606 OID 16573)
-- Name: make make_cpf_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.make
    ADD CONSTRAINT make_cpf_doctor_fkey FOREIGN KEY (cpf_doctor) REFERENCES public.doctor(cpf_employee);


--
-- TOC entry 4431 (class 2606 OID 16583)
-- Name: make make_cpf_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.make
    ADD CONSTRAINT make_cpf_patient_fkey FOREIGN KEY (cpf_patient) REFERENCES public.patient(cpf);


--
-- TOC entry 4432 (class 2606 OID 16578)
-- Name: make make_cpf_receptionist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.make
    ADD CONSTRAINT make_cpf_receptionist_fkey FOREIGN KEY (cpf_receptionist) REFERENCES public.receptionist(cpf_employee);


--
-- TOC entry 4433 (class 2606 OID 16588)
-- Name: make make_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.make
    ADD CONSTRAINT make_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id);


--
-- TOC entry 4424 (class 2606 OID 16505)
-- Name: patient patient_insurance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_insurance_id_fkey FOREIGN KEY (insurance_id) REFERENCES public.insurance(id) ON DELETE CASCADE;


--
-- TOC entry 4429 (class 2606 OID 16557)
-- Name: patientphone patientphone_cpf_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientphone
    ADD CONSTRAINT patientphone_cpf_patient_fkey FOREIGN KEY (cpf_patient) REFERENCES public.patient(cpf) ON DELETE CASCADE;


--
-- TOC entry 4423 (class 2606 OID 16487)
-- Name: receptionist receptionist_cpf_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionist
    ADD CONSTRAINT receptionist_cpf_employee_fkey FOREIGN KEY (cpf_employee) REFERENCES public.employee(cpf) ON DELETE CASCADE;


--
-- TOC entry 4427 (class 2606 OID 16538)
-- Name: receptionistsector receptionistsector_cpf_receptionist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_cpf_receptionist_fkey FOREIGN KEY (cpf_receptionist) REFERENCES public.receptionist(cpf_employee);


--
-- TOC entry 4428 (class 2606 OID 16543)
-- Name: receptionistsector receptionistsector_id_sector_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receptionistsector
    ADD CONSTRAINT receptionistsector_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id);


-- Completed on 2026-06-21 21:27:03 -03

--
-- PostgreSQL database dump complete
--

\unrestrict UfDAwTySgaloOzUg6SBbgAKBr3QEHLUPPDOZ2w5MfjSk3tQh1sFbtocvWm81mDG

