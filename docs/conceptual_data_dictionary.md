# Conceptual Data Dictionary: MediFlow

This document describes all entities, attributes, semantic types, constraints and keys of the MediFlow medical clinic management system.

> **Note:** `Patient` and `Employee` are independent entities. `Employee` is specialized into `Doctor` and `Receptionist`. `Payment` and `Medical Prescription` are not entities — they are modeled as relationships with attributes.

---

## Person/Role Entities

### Employee

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple | Yes | Numbers only, candidate key |
| ID | Unique employee identifier | Simple | Yes | Auto-generated, candidate key |
| FULL_NAME | Employee's full legal name | Simple | Yes | - |
| EMAIL | Personal email address | Simple | Yes | - |
| PHONE | Contact phone number | Simple | Yes | - |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| STREET | Street name of residence | Simple | Yes | Part of composite address |
| NUMBER | House/Apartment number | Simple | Yes | Part of composite address |
| NEIGHBORHOOD | Neighborhood name | Simple | Yes | Part of composite address |
| ZIP_CODE | Postal code | Simple | Yes | Part of composite address |
| CITY | City name | Simple | Yes | Part of composite address |
| LOGIN | Login credential for system access | Simple | Yes | Candidate key |
| PASSWORD | Password for system access | Simple | Yes | - |

---

### Patient

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple | Yes | Numbers only, primary identifier |
| FULL_NAME | Patient's full legal name | Simple | Yes | - |
| PHONE | Contact phone number | Simple | Yes | - |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| STREET | Street name of residence | Simple | Yes | Part of composite address |
| NUMBER | House/Apartment number | Simple | Yes | Part of composite address |
| NEIGHBORHOOD | Neighborhood name | Simple | Yes | Part of composite address |
| ZIP_CODE | Postal code | Simple | Yes | Part of composite address |
| CITY | City name | Simple | Yes | Part of composite address |
| INSURANCE_ID | Patient's health insurance plan | Simple | No | Foreign key referencing Insurance |

---

### Doctor *(specialization of Employee)*

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| EMPLOYEE_ID | Reference to Employee identifier | Simple | Yes | Primary Key, Foreign key referencing Employee |
| CRM | Regional Medical Council registration number | Simple | Yes | Doctor identifier, candidate key |
| SCHEDULE_STATUS | Indicates whether the doctor is available for appointments | Simple | Yes | e.g. Active, On Leave, On Vacation |
| SPECIALTY_ID | Doctor's medical specialty | Simple | Yes | Foreign key referencing Specialty |

---

### Receptionist *(specialization of Employee)*

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| EMPLOYEE_ID | Reference to Employee identifier | Simple | Yes | Primary Key, Foreign key referencing Employee |
| SHIFT | Work shift of the receptionist | Simple | Yes | e.g. Morning, Afternoon, Night |
| SECTOR_ID | Sector where the receptionist works | Simple | Yes | Foreign key referencing Sector |
| STATUS | Current employment status | Simple | Yes | e.g. Active, On Vacation |

---

## Service Entities

### Appointment

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique appointment identifier | Simple | Yes | Auto-generated, candidate key |
| DATE | Scheduled date for the appointment | Simple | Yes | Combined with TIME and DOCTOR_ID for uniqueness |
| TIME | Scheduled time for the appointment | Simple | Yes | Combined with DATE and DOCTOR_ID for uniqueness |
| STATUS | Current status of the appointment | Simple | Yes | e.g. Scheduled, Rescheduled, Cancelled |
| DOCTOR_ID | Doctor assigned to the appointment | Simple | Yes | Foreign key referencing Doctor |
| PATIENT_CPF | Patient assigned to the appointment | Simple | Yes | Foreign key referencing Patient |

---

### Medical Prescription *(relationship attributes between Doctor and Patient)*

> Medical Prescription is not a standalone entity. The attributes below belong to the relationship between `Doctor` and `Patient`.

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique prescription identifier | Simple | Yes | Auto-generated, candidate key |
| PRESCRIPTION_DETAILS | Prescribed medications and dosages | Simple | Yes | - |
| ISSUE_DATE | Date the prescription was issued | Simple | Yes | - |
| DOCTOR_ID | Doctor who issued the prescription | Simple | Yes | Foreign key referencing Doctor |
| PATIENT_CPF | Patient who received the prescription | Simple | Yes | Foreign key referencing Patient |

---

## Payment *(relationship attributes between Appointment and Patient)*

> Payment is not a standalone entity. The attributes below belong to the relationship between `Appointment` and `Patient`.

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique payment identifier | Simple | Yes | Auto-generated, candidate key |
| AMOUNT | Total amount charged for the appointment | Simple | Yes | - |
| PAYMENT_METHOD | Method of payment used | Simple | Yes | e.g. Cash, Card, Insurance |
| PAYMENT_STATUS | Indicates whether payment has been received | Simple | Yes | Paid or Pending |
| APPOINTMENT_ID | Appointment associated with the payment | Simple | Yes | Foreign key referencing Appointment |
| PATIENT_CPF | Patient who made the payment | Simple | Yes | Foreign key referencing Patient |

---

## Support Entities

### Specialty

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique specialty identifier | Simple | Yes | Candidate key |
| SPECIALTY_NAME | Name of the medical specialty | Simple | Yes | e.g. Cardiology, Pediatrics |

---

### Insurance

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique insurance plan identifier | Simple | Yes | Auto-generated, candidate key |
| INSURANCE_NAME | Name of the insurance provider | Simple | Yes | - |
| ANS_CODE | Official health plan registration code | Simple | No | - |

---

### Sector

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique sector identifier | Simple | Yes | Auto-generated, candidate key |
| SECTOR_DESCRIPTION | Description of the sector | Simple | Yes | e.g. Reception, Financial, Administrative |

---

Back to: [System requirements](requirements.md)
See also: [ER diagram](../media/er_diagram.png)
Next: [Relational mapping](relational_mapping.md)