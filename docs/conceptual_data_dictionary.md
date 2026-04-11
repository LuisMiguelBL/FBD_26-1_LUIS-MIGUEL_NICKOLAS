# Conceptual Data Dictionary: MediFlow
 
This document describes all entities, attributes, semantic types, constraints and keys of the MediFlow medical clinic management system.
 
> **Note:** A generalization entity `User` is planned for the ER diagram, from which `Patient`, `Employee`, `Physician` and `Receptionist/Administrative` will be derived as specializations.
 
---
 
## Person/Role Entities
 
### Patient
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple (PK) | Yes | Numbers only |
| FULL_NAME | Patient's full legal name | Composite | Yes | - |
| EMAIL | Personal email address | Simple | Yes | - |
| PHONE | Patient's contact phone number | Simple | Yes | May be changed to multivalued |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| ADDRESS | Residential address | Composite | Yes | Divided into street, number, neighborhood, ZIP code and city |
| ID_INSURANCE | Patient's health insurance plan | Simple (FK) | No | Foreign key referencing Insurance |
 
---
 
### Employee
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple (PK) | Yes | Numbers only |
| FULL_NAME | Employee's full name | Composite | Yes | - |
| BIRTH_DATE | Date of birth | Simple | Yes | - |
 
---
 
### Physician *(specialization of Employee)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CRM | Regional Medical Council registration number | Simple | Yes | Physician identifier |
| SCHEDULE_STATUS | Indicates whether the physician is available for appointments | Simple | Yes | e.g. Active, On Leave, On Vacation |
| ID_SPECIALTY | Physician's medical specialty | Simple (FK) | Yes | Foreign key referencing Specialty |
 
---
 
### Receptionist/Administrative *(specialization of Employee)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| SECTOR | Area of work within the clinic | Simple | Yes | - |
| LOGIN | Login credential for system access | Simple | Yes | - |
| PASSWORD | Password for system access | Simple | Yes | - |
 
---
 
## Service Entities
 
### Appointment
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_APPOINTMENT | Unique appointment identifier | Simple (PK) | Yes | Auto-generated |
| DATE | Scheduled date for the appointment | Simple | Yes | Used to prevent scheduling conflicts |
| TIME | Scheduled time for the appointment | Simple | Yes | Combined with DATE to avoid conflicts |
| STATUS | Current status of the appointment | Simple | Yes | e.g. Scheduled, Rescheduled, Cancelled |
 
---
 
### Medical Prescription
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_PRESCRIPTION | Unique prescription identifier | Simple (PK) | Yes | Auto-generated |
| PRESCRIPTION_DETAILS | Prescribed medications and dosages | Simple | Yes | - |
| ISSUE_DATE | Date the prescription was issued | Simple | Yes | - |
 
---
 
### Payment
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_PAYMENT | Unique payment identifier | Simple (PK) | Yes | Auto-generated |
| AMOUNT | Total amount charged for the appointment | Simple | Yes | - |
| PAYMENT_METHOD | Method of payment used | Simple | Yes | e.g. Cash, Card, Insurance |
| PAYMENT_STATUS | Indicates whether payment has been received | Simple | Yes | Paid or Pending |
 
---
 
## Support Entities
 
### Specialty
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_SPECIALTY | Unique specialty identifier | Simple (PK) | Yes | - |
| SPECIALTY_NAME | Name of the medical specialty | Simple | Yes | e.g. Cardiology, Pediatrics |
 
---
 
### Insurance
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_INSURANCE | Unique insurance plan identifier | Simple (PK) | Yes | Auto-generated |
| INSURANCE_NAME | Name of the insurance provider | Simple | Yes | - |
| ANS_CODE | Official health plan registration code | Simple | No | - |
 
---
 
Back to: [Database requirements](requirements.md)
See also: [ER diagram](../media/er_diagram.png)
Next: [Relational mapping](relational_mapping.md)
 