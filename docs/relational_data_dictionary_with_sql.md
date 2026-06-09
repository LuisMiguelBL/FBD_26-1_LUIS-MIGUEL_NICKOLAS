# Relational Data Dictionary with SQL: MediFlow

This document describes the relational schema derived from the ER diagram, including data types, constraints and SQL definitions for each table.

---

## Tables

### employee

Stores all employees of the clinic. `Doctor` and `Receptionist` are specializations of this entity.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| cpf | VARCHAR(11) | NOT NULL, UNIQUE | Numbers only |
| full_name | VARCHAR(100) | NOT NULL | - |
| email | VARCHAR(100) | NOT NULL | - |
| phone | VARCHAR(20) | NOT NULL | - |
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
```

---

### doctor

Specialization of `employee`. Stores doctor-specific attributes.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| employee_id | INTEGER | PRIMARY KEY, FOREIGN KEY → employee(id) | - |
| crm | VARCHAR(20) | NOT NULL, UNIQUE | Doctor identifier |
| schedule_status | VARCHAR(20) | NOT NULL | e.g. Active, On Leave, On Vacation |
| specialty_id | INTEGER | NOT NULL, FOREIGN KEY → specialty(id) | - |

```sql
-- doctor
-- Specialization of employee. Stores doctor-specific attributes.
CREATE TABLE doctor (
    employee_id INTEGER PRIMARY KEY REFERENCES employee(id) ON DELETE CASCADE,
    crm VARCHAR(20) NOT NULL UNIQUE,
    schedule_status VARCHAR(20) NOT NULL,
    specialty_id INTEGER NOT NULL REFERENCES specialty(id) ON DELETE CASCADE
);
```

---

### receptionist

Specialization of `employee`. Stores receptionist-specific attributes.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| employee_id | INTEGER | PRIMARY KEY, FOREIGN KEY → employee(id) | - |
| shift | VARCHAR(20) | NOT NULL | e.g. Morning, Afternoon, Night |
| sector_id | INTEGER | NOT NULL, FOREIGN KEY → sector(id) | - |
| status | VARCHAR(20) | NOT NULL | e.g. Active, On Vacation |

```sql
-- receptionist
-- Specialization of employee. Stores receptionist-specific attributes.
CREATE TABLE receptionist (
    employee_id INTEGER PRIMARY KEY REFERENCES employee(id) ON DELETE CASCADE,
    shift VARCHAR(20) NOT NULL,
    sector_id INTEGER NOT NULL REFERENCES sector(id) ON DELETE CASCADE,
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
| phone | VARCHAR(20) | NOT NULL | - |
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
| doctor_id | INTEGER | NOT NULL, FOREIGN KEY → doctor(employee_id) | - |
| patient_cpf | VARCHAR(11) | NOT NULL, FOREIGN KEY → patient(cpf) | - |

```sql
-- appointment
-- Stores scheduled appointments between doctors and patients.
-- The combination of doctor_id, date and time must be unique to prevent scheduling conflicts.
CREATE TABLE appointment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    doctor_id INTEGER NOT NULL REFERENCES doctor(employee_id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT,
    UNIQUE (doctor_id, date, time)
);
```

---

### medical_prescription

Derived from the relationship between `doctor` and `patient`. Stores prescriptions issued during appointments.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| prescription_details | TEXT | NOT NULL | - |
| issue_date | DATE | NOT NULL | - |
| doctor_id | INTEGER | NOT NULL, FOREIGN KEY → doctor(employee_id) | - |
| patient_cpf | VARCHAR(11) | NOT NULL, FOREIGN KEY → patient(cpf) | - |

```sql
-- medical_prescription
-- Derived from the relationship between doctor and patient.
-- Stores prescriptions issued during appointments.
CREATE TABLE medical_prescription (
    id SERIAL PRIMARY KEY,
    prescription_details TEXT NOT NULL,
    issue_date DATE NOT NULL,
    doctor_id INTEGER NOT NULL REFERENCES doctor(employee_id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT
);
```

---

### payment

Derived from the relationship between `appointment` and `patient`. Stores payment data for each appointment.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| amount | NUMERIC(10,2) | NOT NULL | - |
| payment_method | VARCHAR(50) | NOT NULL | e.g. Cash, Card, Insurance |
| payment_status | VARCHAR(20) | NOT NULL | e.g. Paid, Pending |
| appointment_id | INTEGER | NOT NULL, FOREIGN KEY → appointment(id) | - |
| patient_cpf | VARCHAR(11) | NOT NULL, FOREIGN KEY → patient(cpf) | - |

```sql
-- payment
-- Derived from the relationship between appointment and patient.
-- Stores payment data associated with each appointment.
CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    appointment_id INTEGER NOT NULL REFERENCES appointment(id) ON DELETE RESTRICT,
    patient_cpf VARCHAR(11) NOT NULL REFERENCES patient(cpf) ON DELETE RESTRICT
);
```

---

### specialty

Stores medical specialties.

| Column | Type | Constraints | Notes |
|---|---|---|---|
| id | SERIAL | PRIMARY KEY | Auto-generated |
| specialty_name | VARCHAR(100) | NOT NULL | e.g. Cardiology, Pediatrics |

```sql
-- specialty
-- Stores the available medical specialties.
CREATE TABLE specialty (
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

Back to: [Relational mapping](relational_mapping.md)