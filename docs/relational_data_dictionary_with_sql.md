# Relational Data Dictionary with SQL: MediFlow

This document describes the relational schema derived from the ER diagram, including data types, constraints and SQL definitions for each table.

---

## Tables

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
CREATE TABLE employee (
    cpf VARCHAR(11) PRIMARY KEY,
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
CREATE TABLE doctor (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL,
    
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
CREATE TABLE receptionist (
    cpf_employee VARCHAR PRIMARY KEY REFERENCES employee(cpf) ON DELETE CASCADE,
    shift VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL
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
CREATE TABLE appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
       
);
```

---



### speciality

Stores medical specialties.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| specialty_name | VARCHAR(100) | NOT NULL | e.g. Cardiology, Pediatrics |

```sql
-- speciality
-- Stores the available medical specialties.
CREATE TABLE speciality (
    id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL
);
```


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
CREATE TABLE insurance (
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
CREATE TABLE sector (
    id SERIAL PRIMARY KEY,
    sector_description VARCHAR(100) NOT NULL
);
```

---

---

### DoctorSpeciality

Stores the doctors’ specializations.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| cpf_doctor| VARCHAR | PRIMARY KEY, FOREIGN KEY → doctor(cpf_employee) | - |
| id_speciality | INT | PRIMARY KEY, FOREIGN KEY → specialit(id)  | - |

```sql
-- DoctorSpeciality

CREATE TABLE DoctorSpeciality IF NOT EXISTS(
    cpf_doctor VARCHAR NOT NULL,

    id_speciality SERIAL NOT NULL,

    PRIMARY KEY (cpf_doctor, id_speciality),

    FOREIGN KEY (cpf_doctor)
        REFERENCES Doctor(cpf_employee),

    FOREIGN KEY (id_speciality)
        REFERENCES Speciality(id)

);

```

---

---

### ReceptionistSector

| Column            | Type    | Constraints | Notes |
|------------------|---------|------------|------|
| cpf_receptionist | VARCHAR | PRIMARY KEY, FOREIGN KEY → receptionist(cpf_receptionist) | - |
| id_sector        | INT     | PRIMARY KEY, FOREIGN KEY → sector(id_sector) | - |

```sql
-- ReceptionistSector

CREATE TABLE ReceptionistSector (
    cpf_receptionist VARCHAR NOT NULL,
    id_sector INT NOT NULL,

    PRIMARY KEY (cpf_receptionist, id_sector),

    FOREIGN KEY (cpf_receptionist)
        REFERENCES Receptionist(cpf_receptionist),

    FOREIGN KEY (id_sector)
        REFERENCES Sector(id_sector)
);

```
---

---
### EmployeePhone

| Column         | Type    | Constraints | Notes |
|----------------|---------|------------|------|
| cpf_employee   | VARCHAR | PRIMARY KEY, FOREIGN KEY → employee(cpf_employee) | Employee identifier |
| phone          | VARCHAR | PRIMARY KEY | Phone number |

```sql
-- EmployeePhone

CREATE TABLE EmployeePhone (
    cpf_employee VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_employee),

    FOREIGN KEY (cpf_employee)
        REFERENCES Employee(cpf_employee)
        ON DELETE CASCADE
);
```
---

---
### PatientPhone

| Column       | Type    | Constraints | Notes |
|--------------|---------|------------|------|
| cpf_patient  | VARCHAR | PRIMARY KEY, FOREIGN KEY → patient(cpf_patient) | Patient identifier |
| phone        | VARCHAR | NOT NULL| Phone number |

```sql
-- EmployeePhone

CREATE TABLE PatientPhone (
    cpf_patient VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,

    PRIMARY KEY (cpf_patient),

    FOREIGN KEY (cpf_patient)
        REFERENCES Patient(cpf_patient)
        ON DELETE CASCADE
);
```

---

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

CREATE TABLE Make (
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
        REFERENCES Doctor(cpf_employee),

    FOREIGN KEY (cpf_receptionist)
        REFERENCES Receptionist(cpf_employee),

    FOREIGN KEY (cpf_patient)
        REFERENCES Patient(cpf_patient),

    FOREIGN KEY (id_appointment)
        REFERENCES Appointment(id)
);
```


---

Back to: [Relational mapping](relational_mapping.md)