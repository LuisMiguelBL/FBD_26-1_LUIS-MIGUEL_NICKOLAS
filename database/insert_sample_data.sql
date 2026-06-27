-- This script populates the MediFlow database with sample data for testing purposes.
-- It follows the referential integrity order, inserting base tables first.
-- All addresses are based on real locations in Serra Talhada, PE.
-- Each table contains at least 5 records as per project requirements.

-- 1. speciality
-- Clinical areas available in the clinic.
INSERT INTO speciality (specialty_name) VALUES 
('Cardiology'), 
('Pediatrics'), 
('Orthopedics'), 
('Dermatology'), 
('General Practice');

-- 2. insurance
-- Health insurance plans accepted by the clinic.
INSERT INTO insurance (insurance_name, ans_code) VALUES 
('HealthPlus', '101020'), 
('BlueShield', '303040'), 
('SafeLife', '505060'), 
('MediCare', '707080'), 
('GlobalHealth', '909010');

-- 3. sector
-- Departments within the clinic.
INSERT INTO sector (sector_description) VALUES 
('Main Reception'), 
('Emergency Wing'), 
('Specialized Clinics'), 
('Financial Dept'), 
('Administration');

-- 4. employee
-- Clinic staff including doctors and administrative personnel.
-- 10 employees to allow for 5 doctors and 5 receptionists.
INSERT INTO employee (cpf, full_name, email, birth_date, street, number, neighborhood, zip_code, city, login, password) VALUES 
('11122233344', 'Ricardo Oliveira Melo', 'ricardo.melo@mediflow.com', '1985-03-12', 'Rua Enock Inácio de Oliveira', '540', 'Nossa Senhora da Penha', '56903-000', 'Serra Talhada', 'rmelo', 'hashed_pw_1'),
('55566677788', 'Ana Beatriz Souza', 'ana.souza@mediflow.com', '1990-07-22', 'Avenida Afonso Magalhães', '1200', 'São Cristóvão', '56903-450', 'Serra Talhada', 'asouza', 'hashed_pw_2'),
('33344455566', 'Marcos Antônio Lima', 'marcos.lima@mediflow.com', '1978-11-30', 'Rua Agostinho Nunes de Magalhães', '45', 'Nossa Senhora da Conceição', '56903-120', 'Serra Talhada', 'mlima', 'hashed_pw_3'),
('77788899900', 'Patrícia Gomes Santos', 'patricia.santos@mediflow.com', '1995-01-20', 'Rua Comandante Superior', '89', 'Centro', '56900-000', 'Serra Talhada', 'psantos', 'hashed_pw_4'),
('22233344455', 'Luís Felipe Cavalcanti', 'luis.felipe@mediflow.com', '1988-09-10', 'Rua Lindoso e Cabral', '210', 'Ipsep', '56912-050', 'Serra Talhada', 'lfelipe', 'hashed_pw_5'),
('44433322211', 'Sérgio Magalhães Neto', 'sergio.m@mediflow.com', '1982-05-15', 'Rua Enock Inácio de Oliveira', '100', 'Centro', '56900-000', 'Serra Talhada', 'smagalhaes', 'hashed_pw_6'),
('88877766655', 'Fernanda Lima Castro', 'fernanda.l@mediflow.com', '1987-08-25', 'Rua Joaquim Conrado de Lorena e Sá', '50', 'São Cristóvão', '56903-460', 'Serra Talhada', 'flima', 'hashed_pw_7'),
('22211100099', 'Cláudio Ferreira Vaz', 'claudio.v@mediflow.com', '1992-02-14', 'Rua Tiburtino Nogueira', '200', 'Ipsep', '56912-010', 'Serra Talhada', 'cferreira', 'hashed_pw_8'),
('66655544433', 'Beatriz Costa Lima', 'beatriz.c@mediflow.com', '1996-10-05', 'Rua Cornélio Soares', '300', 'Nossa Senhora da Penha', '56903-230', 'Serra Talhada', 'bcosta', 'hashed_pw_9'),
('99900011122', 'Juliana Paes Melo', 'juliana.p@mediflow.com', '1994-12-12', 'Rua Ademar Xavier', '150', 'Várzea', '56912-340', 'Serra Talhada', 'jpaes', 'hashed_pw_10');

-- 5. EmployeePhone
-- Contact numbers for employees.
INSERT INTO EmployeePhone (cpf_employee, phone) VALUES 
('11122233344', '87999991111'),
('55566677788', '87977773333'),
('33344455566', '87988884444'),
('77788899900', '87999995555'),
('22233344455', '87988886666'),
('44433322211', '87999990001'),
('88877766655', '87988880002'),
('22211100099', '87977770003'),
('66655544433', '87966660004'),
('99900011122', '87955550005');

-- 6. doctor
-- Link employees to medical roles and CRMs.
INSERT INTO doctor (cpf_employee, crm, schedule_status) VALUES 
('11122233344', 'CRM/PE 12345', 'Active'),
('55566677788', 'CRM/PE 67890', 'Active'),
('33344455566', 'CRM/PE 11223', 'Active'),
('44433322211', 'CRM/PE 44556', 'Active'),
('88877766655', 'CRM/PE 77889', 'Active');

-- 7. receptionist
-- Link employees to administrative/receptionist roles.
INSERT INTO receptionist (cpf_employee, shift, status) VALUES 
('77788899900', 'Morning', 'Active'),
('22233344455', 'Afternoon', 'Active'),
('22211100099', 'Morning', 'Active'),
('66655544433', 'Afternoon', 'Active'),
('99900011122', 'Night', 'Active');

-- 8. patient
-- Registered patients with their personal information.
INSERT INTO patient (cpf, full_name, birth_date, street, number, neighborhood, zip_code, city, insurance_id) VALUES 
('00011122233', 'Alice Bezerra Silva', '1998-12-05', 'Rua Cornélio Soares', '15', 'Nossa Senhora da Penha', '56903-230', 'Serra Talhada', 1),
('44455566677', 'Roberto Ferreira Lima', '1982-04-14', 'Rua Inocêncio Oliveira', '302', 'Centro', '56900-000', 'Serra Talhada', 2),
('88899900011', 'Clara Maria Mendes', '2010-10-30', 'Rua Joaquim Conrado de Lorena e Sá', '77', 'São Cristóvão', '56903-460', 'Serra Talhada', NULL),
('12121212121', 'Fernando Costa Júnior', '1975-01-08', 'Rua Tiburtino Nogueira', '101', 'Ipsep', '56912-010', 'Serra Talhada', 3),
('34343434343', 'Júlia Magalhães', '1992-04-15', 'Rua Ademar Xavier', '500', 'Várzea', '56912-340', 'Serra Talhada', 4);

-- 9. DoctorSpeciality
-- Linking doctors to their specific medical fields.
INSERT INTO DoctorSpeciality (cpf_doctor, id_speciality) VALUES 
('11122233344', 1), -- Ricardo in Cardiology
('55566677788', 2), -- Ana in Pediatrics
('33344455566', 3), -- Marcos in Orthopedics
('44433322211', 4), -- Sérgio in Dermatology
('88877766655', 5); -- Fernanda in General Practice

-- 10. ReceptionistSector
-- Assigning receptionists to clinic sectors.
INSERT INTO ReceptionistSector (cpf_receptionist, id_sector) VALUES 
('77788899900', 1), -- Patrícia in Main Reception
('22233344455', 4), -- Luís in Financial Dept
('22211100099', 2), -- Cláudio in Emergency Wing
('66655544433', 3), -- Beatriz in Specialized Clinics
('99900011122', 5); -- Juliana in Administration

-- 11. PatientPhone
-- Contact numbers for patients.
INSERT INTO PatientPhone (cpf_patient, phone) VALUES 
('00011122233', '87912345678'),
('44455566677', '87987654321'),
('88899900011', '8738312233'),
('12121212121', '87991912222'),
('34343434343', '87998983333');

-- 12. appointment
-- Scheduled appointments connecting doctors, patients, and receptionists.
INSERT INTO appointment (date, time, status, cpf_patient, cpf_doctor, cpf_receptionist) VALUES 
('2026-07-01', '08:00:00', 'Completed', '00011122233', '11122233344', '77788899900'),
('2026-07-01', '09:30:00', 'Completed', '44455566677', '55566677788', '77788899900'),
('2026-07-02', '14:00:00', 'Confirmed', '88899900011', '33344455566', '22233344455'),
('2026-07-02', '15:00:00', 'Completed', '12121212121', '44433322211', '22211100099'),
('2026-07-03', '10:00:00', 'Scheduled', '34343434343', '88877766655', '66655544433');

-- 13. payment
-- Financial transactions associated with completed or scheduled appointments.
INSERT INTO payment (appointment_id, amount, payment_method, payment_status) VALUES 
(1, 250.00, 'Credit Card', 'Paid'),
(2, 150.00, 'Insurance', 'Paid'),
(3, 300.00, 'Cash', 'Pending'),
(4, 250.00, 'Debit Card', 'Paid'),
(5, 200.00, 'Insurance', 'Pending');

-- 14. medical_record
-- Clinical records associated with appointments.
INSERT INTO medical_record (appointment_id, symptoms, diagnosis, requested_exams) VALUES 
(1, 'Chest pain and fatigue', 'Mild Hypertension', 'Electrocardiogram and Blood Test'),
(2, 'Persistent fever and cough', 'Acute Bronchitis', 'Chest X-Ray'),
(3, 'Right knee pain after sports', 'Ligament Strain', 'Magnetic Resonance Imaging'),
(4, 'Skin redness and itching on arms', 'Contact Dermatitis', 'Allergy Panel'),
(5, 'Routine checkup request', 'Healthy / Routine Assessment', 'Complete Blood Count');

-- 15. prescription
-- Prescriptions generated during consultations.
INSERT INTO prescription (appointment_id, prescription_details, issue_date) VALUES 
(1, 'Aspirin 100mg once daily; Losartan 50mg in the morning for 30 days.', '2026-07-01'),
(2, 'Amoxicillin 500mg every 8 hours for 7 days; Paracetamol 500mg if fever.', '2026-07-01'),
(3, 'Ibuprofen 600mg every 12 hours for 5 days; Application of ice packs.', '2026-07-02'),
(4, 'Hydrocortisone cream 1% apply twice daily; Loratadine 10mg once daily.', '2026-07-02'),
(5, 'Multivitamin supplement 1 capsule daily with lunch for 60 days.', '2026-07-03');
