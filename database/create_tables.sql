-- This script will create the necessary tables 
-- for the MediFlow clinic management system.

-- speciality
CREATE TABLE IF NOT EXISTS speciality (
    id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL
);

-- insurance
CREATE TABLE IF NOT EXISTS insurance (
    id SERIAL PRIMARY KEY,
    insurance_name VARCHAR(100) NOT NULL,
    ans_code VARCHAR(20)
);

-- sector
CREATE TABLE IF NOT EXISTS sector (
    id SERIAL PRIMARY KEY,
    sector_description VARCHAR(100) NOT NULL
);

-- employee
CREATE TABLE IF NOT EXISTS employee (
    cpf VARCHAR(11) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    street VARCHAR(100) NOT NULL,
    number VARCHAR(10) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- EmployeePhone
CREATE TABLE IF NOT EXISTS EmployeePhone (
    cpf_employee VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_employee, phone),

    FOREIGN KEY (cpf_employee) REFERENCES employee(cpf) ON DELETE CASCADE
);

-- doctor
CREATE TABLE IF NOT EXISTS doctor (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE RESTRICT,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL
);

-- receptionist
CREATE TABLE IF NOT EXISTS receptionist (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE RESTRICT,
    shift VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- patient
CREATE TABLE IF NOT EXISTS patient (
    cpf VARCHAR(11) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    street VARCHAR(100) NOT NULL,
    number VARCHAR(10) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    insurance_id INTEGER REFERENCES insurance(id) ON DELETE RESTRICT
);

-- DoctorSpeciality
CREATE TABLE IF NOT EXISTS DoctorSpeciality(
    cpf_doctor VARCHAR NOT NULL,
    id_speciality INT NOT NULL,

    PRIMARY KEY (cpf_doctor, id_speciality),

    FOREIGN KEY (cpf_doctor) REFERENCES doctor(cpf_employee) ON DELETE CASCADE,
    FOREIGN KEY (id_speciality) REFERENCES speciality(id) ON DELETE RESTRICT
);

-- ReceptionistSector
CREATE TABLE IF NOT EXISTS ReceptionistSector (
    cpf_receptionist VARCHAR NOT NULL,
    id_sector INT NOT NULL,

    PRIMARY KEY (cpf_receptionist, id_sector),

    FOREIGN KEY (cpf_receptionist) REFERENCES receptionist(cpf_employee) ON DELETE CASCADE,
    FOREIGN KEY (id_sector) REFERENCES sector(id) ON DELETE RESTRICT
);

-- PatientPhone 
CREATE TABLE IF NOT EXISTS PatientPhone (
    cpf_patient VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_patient, phone),

    FOREIGN KEY (cpf_patient) REFERENCES patient(cpf) ON DELETE CASCADE
);

-- appointment
CREATE TABLE IF NOT EXISTS appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    cpf_patient VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT,
    cpf_doctor VARCHAR NOT NULL REFERENCES doctor(cpf_employee) ON DELETE RESTRICT,
    cpf_receptionist VARCHAR REFERENCES receptionist(cpf_employee) ON DELETE RESTRICT,

    CONSTRAINT unique_doctor_appointment_schedule UNIQUE (cpf_doctor, date, time)
);

-- payment
CREATE TABLE IF NOT EXISTS payment (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL REFERENCES appointment(id) ON DELETE RESTRICT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL
);

-- medical_record
CREATE TABLE IF NOT EXISTS medical_record (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL UNIQUE REFERENCES appointment(id) ON DELETE RESTRICT,
    symptoms TEXT NOT NULL,
    diagnosis TEXT NOT NULL,
    requested_exams TEXT
);

-- prescription
CREATE TABLE IF NOT EXISTS prescription (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL REFERENCES appointment(id) ON DELETE RESTRICT,
    prescription_details TEXT NOT NULL,
    issue_date DATE NOT NULL
);