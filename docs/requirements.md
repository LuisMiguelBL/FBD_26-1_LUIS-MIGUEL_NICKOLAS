# Database Requirements: MediFlow
 
The following requirements were derived from the domain description of the MediFlow medical clinic management system.
 
## Data Storage Requirements
 
1. The system must store each patient's personal data, including full name, CPF, phone number, address and health insurance plan.
2. The system must record the appointment history, storing the current status of each appointment (scheduled, rescheduled or cancelled).
3. The database must store the medical specialties and availability schedules associated with each physician.
4. The system must store electronic medical records for each visit, registering reported symptoms, diagnosis and requested exams.
5. Each medical prescription issued must be linked to the patient and the physician who prescribed it, and must be saved to the patient's history.
6. The system must record payments made, identifying whether the appointment was private or covered by health insurance.
7. Staff data must be stored along with their respective roles, enabling access control to the system.
8. The database must support the extraction of billing reports by period and total number of appointments completed.
 
## Query and Constraint Requirements
 
9. A patient's appointment history must be retrievable in a centralized manner using their unique identifier.
10. The system must ensure that each physician has a unique schedule, preventing two appointments from being booked at the same time slot.
 
---
 
Back to: [Domain description](domain_description.md)
Next: [Conceptual data dictionary](conceptual_data_dictionary.md)
 