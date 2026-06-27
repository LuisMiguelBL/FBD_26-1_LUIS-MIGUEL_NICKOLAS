# Query Examples: MediFlow

This document contains SELECT queries designed to demonstrate database relationships, reporting capability, and operational data retrieval for the MediFlow clinic system in Serra Talhada, PE.

---

## 1. Appointment Queries (Consultas de Agenda)

### Query 1.1: Complete Appointment Schedule
Retrieves all appointments with patient, doctor, and receptionist names for Serra Talhada care operations.
```sql
SELECT 
    a.id AS appointment_id,
    a.date,
    a.time,
    a.status,
    p.full_name AS patient_name,
    ed.full_name AS doctor_name,
    er.full_name AS receptionist_name
FROM appointment a
JOIN patient p ON a.cpf_patient = p.cpf
JOIN doctor d ON a.cpf_doctor = d.cpf_employee
JOIN employee ed ON d.cpf_employee = ed.cpf
LEFT JOIN receptionist r ON a.cpf_receptionist = r.cpf_employee
LEFT JOIN employee er ON r.cpf_employee = er.cpf
ORDER BY a.date, a.time;
```

### Query 1.2: Filter Active/Completed Appointments for a Specific Doctor
Lists completed consultations for Dr. Ricardo Oliveira Melo.
```sql
SELECT 
    a.id,
    a.date,
    a.time,
    p.full_name AS patient_name
FROM appointment a
JOIN patient p ON a.cpf_patient = p.cpf
JOIN employee ed ON a.cpf_doctor = ed.cpf
WHERE ed.full_name LIKE '%Ricardo Oliveira Melo%'
  AND a.status = 'Completed';
```

### Query 1.3: Total Appointments by Patient
Counts how many appointments each patient has registered.
```sql
SELECT 
    p.full_name AS patient_name,
    COUNT(a.id) AS total_appointments
FROM patient p
LEFT JOIN appointment a ON p.cpf = a.cpf_patient
GROUP BY p.full_name
ORDER BY total_appointments DESC;
```

### Query 1.4: Appointments Filtered by Date Range
Lists all appointments scheduled for early July 2026.
```sql
SELECT 
    a.id,
    a.date,
    a.time,
    a.status,
    p.full_name AS patient_name
FROM appointment a
JOIN patient p ON a.cpf_patient = p.cpf
WHERE a.date BETWEEN '2026-07-01' AND '2026-07-05';
```

### Query 1.5: Doctor Agenda Availability Check
Checks for any scheduling conflicts for doctors on a specific date.
```sql
SELECT 
    ed.full_name AS doctor_name,
    a.date,
    a.time,
    COUNT(*) AS total_booked
FROM appointment a
JOIN employee ed ON a.cpf_doctor = ed.cpf
GROUP BY ed.full_name, a.date, a.time
HAVING COUNT(*) > 1;
```

---

## 2. Payment Queries (Controle Financeiro e Faturamento)

### Query 2.1: Revenue and Billing Report per Doctor
Calculates accumulated billing and appointment counts per physician for completed paid services.
```sql
SELECT 
    ed.full_name AS doctor_name,
    COUNT(pay.id) AS total_paid_services,
    SUM(pay.amount) AS total_revenue
FROM payment pay
JOIN appointment a ON pay.appointment_id = a.id
JOIN employee ed ON a.cpf_doctor = ed.cpf
WHERE pay.payment_status = 'Paid'
GROUP BY ed.full_name
HAVING SUM(pay.amount) > 100.00
ORDER BY total_revenue DESC;
```

### Query 2.2: Outstanding Payments (Pending Billing)
Lists all pending payments along with patient contact details.
```sql
SELECT 
    pay.id AS payment_id,
    p.full_name AS patient_name,
    pp.phone AS contact_phone,
    pay.amount,
    pay.payment_method
FROM payment pay
JOIN appointment a ON pay.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
LEFT JOIN PatientPhone pp ON p.cpf = pp.cpf_patient
WHERE pay.payment_status = 'Pending';
```

### Query 2.3: Payments Above Clinic Average (Subquery)
Retrieves payments where the amount charged is strictly higher than the average price charged across the clinic.
```sql
SELECT 
    pay.id,
    p.full_name AS patient_name,
    pay.amount,
    pay.payment_method
FROM payment pay
JOIN appointment a ON pay.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
WHERE pay.amount > (SELECT AVG(amount) FROM payment);
```

### Query 2.4: Breakdown by Payment Method
Summarizes total revenue collected by payment method (Credit Card, Cash, Insurance, etc.).
```sql
SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method
ORDER BY total_amount DESC;
```

### Query 2.5: Detailed Invoice View per Appointment
Combines appointment date, patient name, doctor name, and payment details for invoicing.
```sql
SELECT 
    a.id AS appointment_id,
    a.date,
    p.full_name AS patient_name,
    ed.full_name AS doctor_name,
    pay.amount,
    pay.payment_status
FROM payment pay
JOIN appointment a ON pay.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
JOIN employee ed ON a.cpf_doctor = ed.cpf;
```

---

## 3. Medical Record Queries (Prontuário Eletrônico)

### Query 3.1: Patient Electronic Health History
Retrieves all recorded clinical symptoms and diagnoses for a specific patient (e.g. Alice Bezerra Silva).
```sql
SELECT 
    a.date AS consultation_date,
    ed.full_name AS attending_physician,
    mr.symptoms,
    mr.diagnosis,
    mr.requested_exams
FROM medical_record mr
JOIN appointment a ON mr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
JOIN employee ed ON a.cpf_doctor = ed.cpf
WHERE p.full_name LIKE '%Alice Bezerra Silva%'
ORDER BY a.date DESC;
```

### Query 3.2: Consultations with Requested Exams
Lists medical records where specific lab or imaging exams were requested.
```sql
SELECT 
    mr.id AS record_id,
    p.full_name AS patient_name,
    mr.diagnosis,
    mr.requested_exams
FROM medical_record mr
JOIN appointment a ON mr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
WHERE mr.requested_exams IS NOT NULL AND mr.requested_exams <> '';
```

### Query 3.3: Search Diagnoses by Symptom Keyword
Finds all medical records containing specific symptom keywords (e.g. 'fever' or 'pain').
```sql
SELECT 
    p.full_name AS patient_name,
    mr.symptoms,
    mr.diagnosis
FROM medical_record mr
JOIN appointment a ON mr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
WHERE mr.symptoms ILIKE '%pain%' OR mr.symptoms ILIKE '%fever%';
```

### Query 3.4: Count of Medical Records per Doctor
Shows how many medical records each doctor has authored.
```sql
SELECT 
    ed.full_name AS doctor_name,
    COUNT(mr.id) AS total_records_written
FROM medical_record mr
JOIN appointment a ON mr.appointment_id = a.id
JOIN employee ed ON a.cpf_doctor = ed.cpf
GROUP BY ed.full_name;
```

### Query 3.5: Full Clinical Summary View
Unifies appointment details and full medical record documentation.
```sql
SELECT 
    a.id AS appointment_id,
    a.date,
    p.full_name AS patient,
    mr.symptoms,
    mr.diagnosis
FROM medical_record mr
JOIN appointment a ON mr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf;
```

---

## 4. Prescription Queries (Prescrições Médicas)

### Query 4.1: Active Patient Prescriptions
Retrieves issued prescriptions along with issuance dates and patient details.
```sql
SELECT 
    pr.id AS prescription_id,
    p.full_name AS patient_name,
    ed.full_name AS prescribing_doctor,
    pr.issue_date,
    pr.prescription_details
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
JOIN employee ed ON a.cpf_doctor = ed.cpf
ORDER BY pr.issue_date DESC;
```

### Query 4.2: Prescriptions Issued by Specific Doctor
Lists all prescriptions issued by Dr. Ana Beatriz Souza.
```sql
SELECT 
    pr.id,
    pr.issue_date,
    p.full_name AS patient_name,
    pr.prescription_details
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
JOIN employee ed ON a.cpf_doctor = ed.cpf
WHERE ed.full_name LIKE '%Ana Beatriz Souza%';
```

### Query 4.3: Search Prescriptions by Medication Keyword
Searches for prescriptions containing specific medications (e.g. 'Aspirin' or 'Ibuprofen').
```sql
SELECT 
    p.full_name AS patient_name,
    pr.issue_date,
    pr.prescription_details
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
WHERE pr.prescription_details ILIKE '%Aspirin%' 
   OR pr.prescription_details ILIKE '%Ibuprofen%';
```

### Query 4.4: Count of Prescriptions Issued per Patient
Counts how many prescriptions each patient has received.
```sql
SELECT 
    p.full_name AS patient_name,
    COUNT(pr.id) AS total_prescriptions
FROM patient p
JOIN appointment a ON p.cpf = a.cpf_patient
JOIN prescription pr ON a.id = pr.appointment_id
GROUP BY p.full_name;
```

### Query 4.5: Prescriptions Issued on a Given Date
Finds all prescriptions issued on a specific date in Serra Talhada.
```sql
SELECT 
    pr.id,
    p.full_name AS patient_name,
    pr.prescription_details
FROM prescription pr
JOIN appointment a ON pr.appointment_id = a.id
JOIN patient p ON a.cpf_patient = p.cpf
WHERE pr.issue_date = '2026-07-01';
```

---

## 5. Support & Entity Queries (Outras Tabelas do Domínio)

### Query 5.1: Patients Without Insurance (Simple Filter)
Lists all private patients who do not have a registered health insurance plan.
```sql
SELECT cpf, full_name, birth_date, city 
FROM patient
WHERE insurance_id IS NULL;
```

### Query 5.2: Insurance Patient Count (LEFT JOIN + Grouping)
Lists all health insurance providers and the total number of enrolled patients.
```sql
SELECT 
    i.insurance_name,
    COUNT(p.cpf) AS patient_count
FROM insurance i
LEFT JOIN patient p ON i.id = p.insurance_id
GROUP BY i.insurance_name
ORDER BY patient_count DESC;
```

### Query 5.3: Patient Contact Phones (Multivalued Attribute)
Lists patients along with their registered contact phone numbers in Serra Talhada.
```sql
SELECT 
    p.full_name AS patient_name,
    ph.phone AS phone_number
FROM patient p
JOIN PatientPhone ph ON p.cpf = ph.cpf_patient
ORDER BY p.full_name;
```

### Query 5.4: Doctors with Paid Appointments (Correlated Subquery)
Finds doctors who have at least one appointment with a payment status of 'Paid'.
```sql
SELECT 
    ed.full_name AS doctor_name,
    d.crm
FROM doctor d
JOIN employee ed ON d.cpf_employee = ed.cpf
WHERE EXISTS (
    SELECT 1 
    FROM appointment a
    JOIN payment pay ON a.id = pay.appointment_id
    WHERE a.cpf_doctor = d.cpf_employee 
      AND pay.payment_status = 'Paid'
);
```

### Query 5.5: Doctors and Specialties (N:M Relationship)
Lists doctors and their respective medical specialties in the clinic.
```sql
SELECT 
    ed.full_name AS doctor_name,
    d.crm,
    s.specialty_name
FROM doctor d
JOIN employee ed ON d.cpf_employee = ed.cpf
JOIN DoctorSpeciality ds ON d.cpf_employee = ds.cpf_doctor
JOIN speciality s ON ds.id_speciality = s.id;
```

---

Back to: [Relational data dictionary with SQL](relational_data_dictionary_with_sql.md)