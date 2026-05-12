# Conceptual Data Dictionary: MediFlow
 
This document describes all entities, attributes, semantic types, constraints and keys of the MediFlow medical clinic management system.
 
> **Note:** A generalization entity `Person` is used in the ER diagram, from which `Patient` and `Employee` are derived as specializations. `Employee` is further specialized into `Doctor` and `Receptionist/Administrative`.
 
---
 
## Person/Role Entities
 
### Person
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CPF | Brazilian individual taxpayer ID | Simple | Yes | Numbers only |
| FULL_NAME | Person's full legal name | Composite | Yes | - |
| EMAIL | Personal email address | Simple | Yes | - |
| PHONE | Contact phone number | Simple | Yes | May be changed to multivalued |
| BIRTH_DATE | Date of birth | Simple | Yes | Age is derived from this field |
| ADDRESS | Residential address | Composite | Yes | Divided into street, number, neighborhood, ZIP code and city |
 
---
 
### Patient *(specialization of Person)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_INSURANCE | Patient's health insurance plan | Simple | No | Foreign key referencing Insurance |
 
---
 
### Employee *(specialization of Person)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| LOGIN | Login credential for system access | Simple | Yes | - |
| PASSWORD | Password for system access | Simple | Yes | - |
 
---
 
### Doctor *(specialization of Employee)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| CRM | Regional Medical Council registration number | Simple | Yes | Doctor's identifier |
| SCHEDULE_STATUS | Indicates whether the doctor is available for appointments | Simple | Yes | e.g. Active, On Leave, On Vacation |
| ID_SPECIALTY | Doctor's medical specialty | Simple | Yes | Foreign key referencing Specialty |
 
---
 
### Receptionist/Administrative *(specialization of Employee)*
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_SECTOR | Area of work within the clinic | Simple | Yes | Foreign key referencing Sector |
 
---
 
## Service Entities
 
### Appointment
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_APPOINTMENT | Unique appointment identifier | Simple | Yes | Auto-generated |
| DATE | Scheduled date for the appointment | Simple | Yes | Used to prevent scheduling conflicts |
| TIME | Scheduled time for the appointment | Simple | Yes | Combined with DATE to avoid conflicts |
| STATUS | Current status of the appointment | Simple | Yes | e.g. Scheduled, Rescheduled, Cancelled |
 
---
 
### Medical Prescription
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_PRESCRIPTION | Unique prescription identifier | Simple | Yes | Auto-generated |
| PRESCRIPTION_DETAILS | Prescribed medications and dosages | Simple | Yes | - |
| ISSUE_DATE | Date the prescription was issued | Simple | Yes | - |
 
---
 
### Payment
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_PAYMENT | Unique payment identifier | Simple | Yes | Auto-generated |
| AMOUNT | Total amount charged for the appointment | Simple | Yes | - |
| PAYMENT_METHOD | Method of payment used | Simple | Yes | e.g. Cash, Card, Insurance |
| PAYMENT_STATUS | Indicates whether payment has been received | Simple | Yes | Paid or Pending |
 
---
 
## Support Entities
 
### Specialty
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_SPECIALTY | Unique specialty identifier | Simple | Yes | - |
| SPECIALTY_NAME | Name of the medical specialty | Simple | Yes | e.g. Cardiology, Pediatrics |
 
---
 
### Insurance
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_INSURANCE | Unique insurance plan identifier | Simple | Yes | Auto-generated |
| INSURANCE_NAME | Name of the insurance provider | Simple | Yes | - |
| ANS_CODE | Official health plan registration code | Simple | No | - |
 
---
 
### Sector
 
| Attribute | Description | Semantic Type | Required | Notes |
|---|---|---|---|---|
| ID_SECTOR | Unique sector identifier | Simple | Yes | Auto-generated |
| SECTOR_DESCRIPTION | Description of the sector | Simple | Yes | e.g. Reception, Financial, Administrative |
 
---
 
Back to: [Database requirements](requirements.md)
See also: [ER diagram](../media/er_diagram.png)
Next: [Relational mapping](relational_mapping.md)
 