# System Requirements: MediFlow

The following requirements were derived from the domain description of the MediFlow medical clinic management system.

## Functional Requirements

1. The system must store each patient's personal data, including full name, CPF, phone number, address and health insurance plan.
2. The system must record the appointment history, storing the current status of each appointment (scheduled, rescheduled or cancelled).
3. The database must store the medical specialties and availability schedules associated with each physician.
4. The system must store electronic medical records for each visit, registering reported symptoms, diagnosis and requested exams.
5. Each medical prescription issued must be linked to the patient and the physician who prescribed it, and must be saved to the patient's history.
6. The system must record payments made, identifying whether the appointment was private or covered by health insurance.
7. Staff data must be stored along with their respective roles, enabling access control to the system.
8. The system must allow the extraction of billing reports by period and total number of appointments completed.
9. Each registered person (patient or employee) must have a unique CPF registered in the database.
10. Each physician must have a unique CRM number registered in the database.
11. Each user (patient or employee) must have a unique email address.
12. Each health insurance provider must have a unique registration code.
13. The system must prevent scheduling conflicts by ensuring that a physician cannot have more than one appointment scheduled for the same date and time.

## Non-Functional Requirements

14. A patient's appointment history must be retrievable in a centralized manner using their unique identifier.

---

Back to: [Domain description](domain_description.md)

Next: [Conceptual data dictionary](conceptual_data_dictionary.md)