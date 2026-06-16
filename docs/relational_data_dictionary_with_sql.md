# Relational Data Dictionary with SQL: MediFlow

This document describes the relational schema derived from the ER diagram, including data types, constraints and SQL definitions for each table.

---

## Tables

### speciality

Stores medical specialties.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| specialty_name | VARCHAR(100) | NOT NULL | e.g. Cardiology, Pediatrics |

```sql
-- speciality
-- Stores the available medical specialties.
CREATE TABLE IF NOT EXISTS speciality (
    id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL
);
```

---

### insurance

Stores health insurance providers.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| insurance_name | VARCHAR(100) | NOT NULL | - |
| ans_code | VARCHAR(20) | - | Official health plan registration code |

```sql
-- insurance
-- Stores health insurance providers available to patients.
CREATE TABLE IF NOT EXISTS insurance (
    id SERIAL PRIMARY KEY,
    insurance_name VARCHAR(100) NOT NULL,
    ans_code VARCHAR(20)
);
```

---

### sector

Stores clinic sectors where receptionists work.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| sector_description | VARCHAR(100) | NOT NULL | e.g. Reception, Financial, Administrative |

```sql
-- sector
-- Stores the clinic sectors where receptionists are assigned.
CREATE TABLE IF NOT EXISTS sector (
    id SERIAL PRIMARY KEY,
    sector_description VARCHAR(100) NOT NULL
);
```

---

### appointment

Stores scheduled appointments between doctors and patients.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| date | DATE | NOT NULL | - |
| time | TIME | NOT NULL | Combined with date to avoid conflicts |
| status | VARCHAR(20) | NOT NULL | e.g. Scheduled, Rescheduled, Cancelled |

```sql
-- appointment
-- Stores scheduled appointments between doctors and patients.
-- The combination of doctor_id, date and time must be unique to prevent scheduling conflicts.
CREATE TABLE IF NOT EXISTS appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL
       
);
```

---

### employee

Stores all employees of the clinic. `Doctor` and `Receptionist` are specializations of this entity.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf | VARCHAR(11) | PRIMARY KEY | Numbers only |
| full_name | VARCHAR(100) | NOT NULL | - |
| email | VARCHAR(100) | NOT NULL | - |
| birth_date | DATE | NOT NULL | - |
| street | VARCHAR(100) | NOT NULL | Part of composite address |
| number | VARCHAR(10) | NOT NULL | Part of composite address |
| neighborhood | VARCHAR(100) | NOT NULL | Part of composite address |
| zip_code | VARCHAR(10) | NOT NULL | Part of composite address |
| city | VARCHAR(100) | NOT NULL | Part of composite address |
| login | VARCHAR(50) | NOT NULL, UNIQUE | - |
| password | VARCHAR(255) | NOT NULL | - |

```sql
-- employee
-- Stores all employees of the clinic (doctors, receptionists and other staff).
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
```

---

### EmployeePhone

| Column         | Type    | Constraints | Notes |
|----------------|---------|------------|------|
| cpf_employee   | VARCHAR | PRIMARY KEY, FOREIGN KEY → employee(cpf_employee) | Employee identifier |
| phone          | VARCHAR | PRIMARY KEY | Phone number |

```sql
-- EmployeePhone

CREATE TABLE IF NOT EXISTS EmployeePhone (
    cpf_employee VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_employee, phone),

    FOREIGN KEY (cpf_employee)
        REFERENCES employee(cpf)
        ON DELETE CASCADE
);
```

---

### doctor

Specialization of `employee`. Stores doctor-specific attributes.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf_employee | VARCHAR | PRIMARY KEY, FOREIGN KEY → employee(cpf) | - |
| crm | VARCHAR(20) | NOT NULL, UNIQUE | Doctor identifier |
| schedule_status | VARCHAR(20) | NOT NULL | e.g. Active, On Leave, On Vacation |


```sql
-- doctor
-- Specialization of employee. Stores doctor-specific attributes.
CREATE TABLE IF NOT EXISTS doctor (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL
);
```

---

### DoctorSpeciality

Stores the doctors’ specializations.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf_doctor| VARCHAR | PRIMARY KEY, FOREIGN KEY → doctor(cpf_employee) | - |
| id_speciality | INT | PRIMARY KEY, FOREIGN KEY → specialit(id)  | - |

```sql
-- DoctorSpeciality

CREATE TABLE IF NOT EXISTS DoctorSpeciality(
    cpf_doctor VARCHAR NOT NULL,

    id_speciality INT NOT NULL,

    PRIMARY KEY (cpf_doctor, id_speciality),

    FOREIGN KEY (cpf_doctor)
        REFERENCES doctor(cpf_employee),

    FOREIGN KEY (id_speciality)
        REFERENCES speciality(id)

);

```

---

### receptionist

Specialization of `employee`. Stores receptionist-specific attributes.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf_employee | VARCHAR | PRIMARY KEY, FOREIGN KEY → employee(cpf) | - |
| shift | VARCHAR(20) | NOT NULL | e.g. Morning, Afternoon, Night |
| status | VARCHAR(20) | NOT NULL | e.g. Active, On Vacation |

```sql
-- receptionist
-- Specialization of employee. Stores receptionist-specific attributes.
CREATE TABLE IF NOT EXISTS receptionist (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
    shift VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL
);
```

---

### ReceptionistSector

| Column            | Type    | Constraints | Notes |
|------------------|---------|------------|------|
| cpf_receptionist | VARCHAR | PRIMARY KEY, FOREIGN KEY → receptionist(cpf_receptionist) | - |
| id_sector        | INT     | PRIMARY KEY, FOREIGN KEY → sector(id_sector) | - |

```sql
-- ReceptionistSector

CREATE TABLE IF NOT EXISTS ReceptionistSector (
    cpf_receptionist VARCHAR NOT NULL,
    id_sector INT NOT NULL,

    PRIMARY KEY (cpf_receptionist, id_sector),

    FOREIGN KEY (cpf_receptionist)
        REFERENCES receptionist(cpf_employee),

    FOREIGN KEY (id_sector)
        REFERENCES sector(id)
);

```

---

### patient

Stores patient data. Independent from the employee hierarchy.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf | VARCHAR(11) | PRIMARY KEY | Numbers only |
| full_name | VARCHAR(100) | NOT NULL | - |
| birth_date | DATE | NOT NULL | - |
| street | VARCHAR(100) | NOT NULL | Part of composite address |
| number | VARCHAR(10) | NOT NULL | Part of composite address |
| neighborhood | VARCHAR(100) | NOT NULL | Part of composite address |
| zip_code | VARCHAR(10) | NOT NULL | Part of composite address |
| city | VARCHAR(100) | NOT NULL | Part of composite address |
| insurance_id | INTEGER | FOREIGN KEY → insurance(id) | Nullable — patient may not have insurance |

```sql
-- patient
-- Stores patient personal data. Independent from the employee hierarchy.
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
```

---

### PatientPhone

| Column       | Type    | Constraints | Notes |
|--------------|---------|------------|------|
| cpf_patient  | VARCHAR | PRIMARY KEY, FOREIGN KEY → patient(cpf_patient) | Patient identifier |
| phone        | VARCHAR | NOT NULL| Phone number |

```sql
-- EmployeePhone

CREATE TABLE IF NOT EXISTS PatientPhone (
    cpf_patient VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_patient, phone),

    FOREIGN KEY (cpf_patient)
        REFERENCES patient(cpf)
        ON DELETE CASCADE
);
```

---

### Make

| Column              | Type    | Constraints | Notes |
|---------------------|---------|------------|------|
| cpf_doctor         | VARCHAR | PRIMARY KEY, FOREIGN KEY → doctor(cpf_employee) | Doctor identifier |
| cpf_receptionist   | VARCHAR | PRIMARY KEY, FOREIGN KEY → receptionist(cpf_employee) | Receptionist identifier |
| cpf_patient        | VARCHAR | PRIMARY KEY, FOREIGN KEY → patient(cpf_patient) | Patient identifier |
| id_appointment     | INT     | PRIMARY KEY, FOREIGN KEY → appointment(id) | Appointment identifier |
| issue_date         | DATE    | - | Issue date |
| payment_method     | VARCHAR | - | Payment method used |
| payment_status     | VARCHAR | - | Payment status |
| amount             | DECIMAL | - | Total amount |
| prescription_details | TEXT  | - | Prescription details |

```sql
-- EmployeePhone

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

    FOREIGN KEY (cpf_doctor)
        REFERENCES doctor(cpf_employee),

    FOREIGN KEY (cpf_receptionist)
        REFERENCES receptionist(cpf_employee),

    FOREIGN KEY (cpf_patient)
        REFERENCES patient(cpf),

    FOREIGN KEY (id_appointment)
        REFERENCES appointment(id)
);
```

---

Back to: [Relational mapping](relational_mapping.md)