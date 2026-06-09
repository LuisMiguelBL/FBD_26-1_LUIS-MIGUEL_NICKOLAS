-- 1. specialty

CREATE TABLE specialty (
    id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL
);

-- 2. insurance

CREATE TABLE insurance (
    id SERIAL PRIMARY KEY,
    insurance_name VARCHAR(100) NOT NULL,
    ans_code VARCHAR(20)
);

-- 3. sector

CREATE TABLE sector (
    id SERIAL PRIMARY KEY,
    sector_description VARCHAR(100) NOT NULL
);

-- 4. employee

CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    street VARCHAR(100) NOT NULL,
    number VARCHAR(10) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

--5. doctor 

CREATE TABLE doctor (
    employee_id INTEGER PRIMARY KEY REFERENCES employee(id) ON DELETE CASCADE,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL,
    specialty_id INTEGER NOT NULL REFERENCES specialty(id) ON DELETE CASCADE
);

-- 6. receptionist 

CREATE TABLE receptionist (
    employee_id INTEGER PRIMARY KEY REFERENCES employee(id) ON DELETE CASCADE,
    shift VARCHAR(20) NOT NULL,
    sector_id INTEGER NOT NULL REFERENCES sector(id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL
);

-- 7. patient 

CREATE TABLE patient (
    cpf VARCHAR(11) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    street VARCHAR(100) NOT NULL,
    number VARCHAR(10) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL, 
    city VARCHAR(100) NOT NULL,
    insurance_id INTEGER REFERENCES insurance(id) ON DELETE CASCADE
);

-- 8. appointment

CREATE TABLE appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    doctor_id INTEGER NOT NULL REFERENCES doctor(employee_id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT,
    UNIQUE (doctor_id, date, time)
);

-- 9. medical_prescription 

CREATE TABLE medical_prescription (
    id SERIAL PRIMARY KEY,
    prescription_details TEXT NOT NULL, 
    issue_date DATE NOT NULL,
    doctor_id INTEGER NOT NULL REFERENCES doctor(employee_id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT
);

-- 10. payment

CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    amount NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    appointment_id INTEGER NOT NULL REFERENCES appointment(id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT
);
