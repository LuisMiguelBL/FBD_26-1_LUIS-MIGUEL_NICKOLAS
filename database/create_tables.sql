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

-- appointment
CREATE TABLE IF NOT EXISTS appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL  
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
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL
);

-- receptionist
CREATE TABLE IF NOT EXISTS receptionist (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
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
    insurance_id INTEGER REFERENCES insurance(id) ON DELETE CASCADE
);

-- DoctorSpeciality
CREATE TABLE IF NOT EXISTS DoctorSpeciality(
    cpf_doctor VARCHAR NOT NULL,

    id_speciality INT NOT NULL,

    PRIMARY KEY (cpf_doctor, id_speciality),

    FOREIGN KEY (cpf_doctor) REFERENCES doctor(cpf_employee),
    FOREIGN KEY (id_speciality) REFERENCES speciality(id)
);

-- ReceptionistSector
CREATE TABLE IF NOT EXISTS ReceptionistSector (
    cpf_receptionist VARCHAR NOT NULL,
    id_sector INT NOT NULL,

    PRIMARY KEY (cpf_receptionist, id_sector),

    FOREIGN KEY (cpf_receptionist) REFERENCES receptionist(cpf_employee),
    FOREIGN KEY (id_sector) REFERENCES sector(id)
);

-- PatientPhone 
CREATE TABLE IF NOT EXISTS PatientPhone (
    cpf_patient VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_patient, phone),

    FOREIGN KEY (cpf_patient) REFERENCES patient(cpf) ON DELETE CASCADE
);

-- Make 
CREATE TABLE IF NOT EXISTS Make (
    cpf_doctor VARCHAR NOT NULL,
    cpf_receptionist VARCHAR NOT NULL,
    cpf_patient VARCHAR NOT NULL,
    id_appointment INT NOT NULL,

    issue_date DATE,
    payment_method VARCHAR,
    payment_status VARCHAR,
    amount DECIMAL,
    prescription_details TEXT,

    PRIMARY KEY (
        cpf_doctor,
        cpf_receptionist,
        cpf_patient,
        id_appointment
    ),

    FOREIGN KEY (cpf_doctor) REFERENCES doctor(cpf_employee),
    FOREIGN KEY (cpf_receptionist) REFERENCES receptionist(cpf_employee),
    FOREIGN KEY (cpf_patient) REFERENCES patient(cpf),
    FOREIGN KEY (id_appointment) REFERENCES appointment(id)
);