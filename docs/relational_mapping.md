**A Relational Mapping is the process of transforming an Entity-Relationship Diagram (ERD) into tables in a relational database.**

**In other words, it defines how entities, attributes, and relationships from the ERD will be represented as tables, columns, primary keys, and foreign keys.**

Employee(**cpf**, full_name, email, birth_date, street, number, neighborhood, zip_code, city, login, password)

Doctor (**cpf_employee**, crm, schedule_status)

Receptionist (**cpf_employee**, shift, status)

Patient (**cpf**, full_name, birth_date, street, number, neighborhood, zip_code, city, insurance_id)

Sector(**id**, sector_description)

Insurance(**id**, insurance_name, ans_code)

Speciality(**id**, speciality_name)

DoctorSpeciality(**cpf_doctor**, **id_speciality**)

ReceptionistSector(**cpf_receptionist**, **id_sector**)

EmployeePhone(**cpf_employee**, phone)

PatientPhone(**cpf_patient**, phone)

Appointment(**id**, date, time, status, cpf_patient, cpf_doctor, cpf_receptionist)

Payment(**id**, amount, payment_method, payment_status, appointment_id)

MedicalRecord(**id**, symptoms, diagnosis, requested_exams, appointment_id)

Prescription(**id**, prescription_details, issue_date, appointment_id)

Next: [Relational Data Dictionary with SQL](relational_data_dictionary_with_sql.md)