-- This script will contain SELECT statements to retrieve 
-- data from the MediFlow database for various use cases.
-- Each query is designed to demonstrate the relationships between tables
-- and to provide insights into the clinic's operations.

-- 1. query with simple filter (WHERE)
-- The purpose of the query is to list all patients who do not 
-- have health insurance, that is, whose insurance_id is null.
SELECT cpf, full_name, birth_date, city 
FROM patient
WHERE insurance_id IS NULL;
--

-- 2. query with JOIN between at least 3 tables
-- The purpose of the query is to obtain a list of 
-- medical appointments made, including the full 
-- name of the patient, the doctor, and the date 
-- and time of the appointment.
SELECT 
p.full_name AS patient_name,
e.full_name AS doctor_name,
a.date AS appointment_date,
a.time AS appointment_time,
m.amount AS amount_charged
FROM Make m
JOIN patient p ON m.cpf_patient = p.cpf
JOIN appointment a ON m.id_appointment = a.id
JOIN employee e ON m.cpf_doctor = e.cpf;
--

-- 3. query with GROUP BY + HAVING
-- The purpose of the uery is calculate the total 
-- accumulated revenue and the number of consultations 
-- per doctor, displaying only the doctors who generated 
-- more than R$ 200.00 in consultations.
SELECT 
e.full_name AS doctor_name,
COUNT(m.id_appointment) AS total_appointments,
SUM(m.amount) AS total_billing
FROM Make m
JOIN employee e ON m.cpf_doctor = e.cpf
GROUP BY e.full_name
HAVING SUM(m.amount) > 200.00;
--

-- 4. query with subquery
-- The purpose of the quey is to list patients and the 
-- amount paid for consultations where the amount charged 
-- is strictly higher than the average price charged 
-- for all consultations at the clinic.
SELECT 
p.full_name,
m.amount AS paid_amount
FROM Make m
JOIN patient p ON m.cpf_patient = p.cpf
WHERE m.amount > (
SELECT AVG(amount) 
FROM Make
);
--

-- 5. query with LEFT JOIN and grouping
-- The purpose of the query is to list all insurance 
-- providers and the total number of patients.
SELECT 
i.insurance_name,
COUNT(p.cpf) AS patient_count
FROM insurance i
LEFT JOIN patient p ON i.id = p.insurance_id
GROUP BY i.insurance_name
ORDER BY patient_count DESC;
--

-- 6. query with multivalued attribute
-- The purpose of the query is to list the patients 
-- and their contact numbers.
SELECT 
p.full_name AS patient_name,
ph.phone AS phone_number
FROM patient p
JOIN PatientPhone ph ON p.cpf = ph.cpf_patient
ORDER BY p.full_name;
--

--7. query with text filter using LIKE/ILIKE and logical operators 
-- The purpose of the query is to list funtionaries 
-- whose full name contains the word "Lima" or "Oliveira".
SELECT 
full_name,
email
FROM employee
WHERE full_name LIKE '%Lima%' OR full_name LIKE '%Oliveira%';
-- 

-- 8. advanced query with correlated subquery (EXISTS/NOT EXISTS)
-- The purpose of the query is to list the doctors who have 
-- at least one appointment with a payment status of "Paid".
SELECT 
e.full_name AS doctor_name,
d.crm
FROM doctor d
JOIN employee e ON d.cpf_employee = e.cpf
WHERE EXISTS (
SELECT 1 
FROM Make m 
WHERE m.cpf_doctor = d.cpf_employee 
AND m.payment_status = 'Paid'
);
--