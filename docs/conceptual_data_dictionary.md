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
| FULL_NAME | Employee's full legal name | Composite | Yes | - |
| EMAIL | Personal email address | Simple | Yes | - |
| PHONE | Contact phone number | Simple | Yes | May be changed to multivalued |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| ADDRESS | Residential address | Composite | Yes | Divided into street, number, neighborhood, ZIP code and city |
| LOGIN | Login credential for system access | Simple | Yes | - |
| PASSWORD | Password for system access | Simple | Yes | - |

---

### Patient

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple | Yes | Numbers only, candidate key |
| FULL_NAME | Patient's full legal name | Composite | Yes | - |
| PHONE | Contact phone number | Simple | Yes | May be changed to multivalued |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| ADDRESS | Residential address | Composite | Yes | Divided into street, number, neighborhood, ZIP code and city |
| ID_INSURANCE | Patient's health insurance plan | Simple | No | Foreign key referencing Insurance |

---

### Doctor *(specialization of Employee)*

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CRM | Regional Medical Council registration number | Simple | Yes | Doctor identifier, candidate key |
| SCHEDULE_STATUS | Indicates whether the doctor is available for appointments | Simple | Yes | e.g. Active, On Leave, On Vacation |
| ID_SPECIALTY | Doctor's medical specialty | Simple | Yes | Foreign key referencing Specialty |

---

### Receptionist *(specialization of Employee)*

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| SHIFT | Work shift of the receptionist | Simple | Yes | - |
| ID_SECTOR | Sector where the receptionist works | Simple | Yes | Foreign key referencing Sector |
| STATUS | Current employment status | Simple | Yes | e.g. Active, On Vacation |

---

## Service Entities

### Appointment

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique appointment identifier | Simple | Yes | Auto-generated, candidate key |
| DATE | Scheduled date for the appointment | Simple | Yes | Used to prevent scheduling conflicts |
| TIME | Scheduled time for the appointment | Simple | Yes | Combined with DATE to avoid conflicts |
| STATUS | Current status of the appointment | Simple | Yes | e.g. Scheduled, Rescheduled, Cancelled |

---

### Medical Prescription *(relationship attributes between Doctor and Patient)*

> Medical Prescription is not a standalone entity. The attributes below belong to the relationship between `Doctor` and `Patient`.

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID | Unique prescription identifier | Simple | Yes | Auto-generated, candidate key |
| PRESCRIPTION_DETAILS | Prescribed medications and dosages | Simple | Yes | - |
| ISSUE_DATE | Date the prescription was issued | Simple | Yes | - |

---

### Payment *(relationship attributes between Appointment and Patient)*

> Payment is not a standalone entity. The attributes below belong to the relationship between `Appointment` and `Patient`.

| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_PAYMENT | Unique payment identifier | Simple | Yes | Auto-generated, candidate key |
| AMOUNT | Total amount charged for the appointment | Simple | Yes | - |
| PAYMENT_METHOD | Method of payment used | Simple | Yes | e.g. Cash, Card, Insurance |
| PAYMENT_STATUS | Indicates whether payment has been received | Simple | Yes | Paid or Pending |

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