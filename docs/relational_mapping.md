**A Relational Mapping is the process of transforming an Entity-Relationship Diagram (ERD) into tables in a relational database.**

**In other words, it defines how entities, attributes, and relationships from the ERD will be represented as tables, columns, primary keys, and foreign keys.**

Employee(**cpf**, full_name, email, bith_date, street, number, neighborhood, zip_code, city,login,password )

Doctor (**cpf_employee**, crm, shedulte_status )

Receptionist (**cpf_employee**, shift, status )

Patient (**cpf**, full_name, bith_date, street, number, neighborhood, zip_code, city, insurance_id )

Sector(**id**, sector_description)

Insurance(**id**, insurance_name, ans_code)

Appointment(**id_appointment**, date, time, status)

Speciality(**id**, speciality_name)

DoctorSpeciality(**cpf_doctor**, **id_speciality**)

ReceptionistSector(**cpf_receptionist**, **id_sector**)

EmployeePhone(**cpf_employee**, phone)

PatientPhone(**cpf_patient**,phone)


Make( **cpf_doctor**,**cpf_receptionist**, **cpf_patient**,**id_appointment**, issue_data, payment_method, payment_status, amount, prescrption_details)

Next: [Relational Data Dictionary with SQL](relational_data_dictionary_with_sql.md)