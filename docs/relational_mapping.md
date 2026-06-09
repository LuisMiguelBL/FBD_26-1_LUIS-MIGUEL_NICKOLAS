**A Relational Mapping is the process of transforming an Entity-Relationship Diagram (ERD) into tables in a relational database.**

**In other words, it defines how entities, attributes, and relationships from the ERD will be represented as tables, columns, primary keys, and foreign keys.**

doctor (**cpf**, full_name, login, bith_date, password,email, endereco_numero, cep, cidade, bairro, rua, crm, shedulte_status )

receptionist (**cpf**, full_name, login, bith_date, password,email, endereco_numero, cep, cidade, bairro, rua, turno, status )

patient (**cpf**, full_name, login, bith_date, password,email, endereco_numero, cep, cidade, bairro, rua )

sector(**id**, sector_description)

insurance(**id**, insurance_name, ans_code)

appointment(**id_appointment**, date, time, status)