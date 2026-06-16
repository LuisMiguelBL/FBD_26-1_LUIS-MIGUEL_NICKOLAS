**A Relational Mapping is the process of transforming an Entity-Relationship Diagram (ERD) into tables in a relational database.**

**In other words, it defines how entities, attributes, and relationships from the ERD will be represented as tables, columns, primary keys, and foreign keys.**

employee(**cpf**, full_name, email, bith_date, street, number, neighborhood, zip_code, city,login,password )

doctor (employee_id, crm, shedulte_status, speciality_id )

receptionist (employee_id, shift, sector_id ,status )

patient (**cpf**, full_name, email, bith_date, street, number, neighborhood, zip_code, city, insurance_id )

sector(**id**, sector_description)

insurance(**id**, insurance_name, ans_code)

appointment(**id_appointment**, date, time, status)

speciality(**id**, *id_doctor*, speciality_name)