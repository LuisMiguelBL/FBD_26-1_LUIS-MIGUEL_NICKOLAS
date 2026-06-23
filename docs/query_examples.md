# Query Examples: MediFlow

This document contains the SELECT queries used to retrieve data from the MediFlow database. Each query is designed to demonstrate the relationships between tables and to provide insights into the clinic's operations.

---

## 1. Simple Filter (WHERE)

Lists all patients who do not have health insurance, i.e., whose `insurance_id` is null.

```sql
SELECT cpf, full_name, birth_date, city 
FROM patient
WHERE insurance_id IS NULL;
```

---

## 2. JOIN Between at Least 3 Tables

Retrieves a list of medical appointments made, including the full name of the patient, the doctor, and the date, time and amount charged for the appointment.

```sql
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
```

---

## 3. GROUP BY + HAVING

Calculates the total accumulated revenue and the number of appointments per doctor, displaying only doctors who generated more than R$ 200.00 in appointments.

```sql
SELECT 
    e.full_name AS doctor_name,
    COUNT(m.id_appointment) AS total_appointments,
    SUM(m.amount) AS total_billing
FROM Make m
JOIN employee e ON m.cpf_doctor = e.cpf
GROUP BY e.full_name
HAVING SUM(m.amount) > 200.00;
```

---

## 4. Subquery

Lists patients and the amount paid for appointments where the amount charged is strictly higher than the average price charged for all appointments at the clinic.

```sql
SELECT 
    p.full_name,
    m.amount AS paid_amount
FROM Make m
JOIN patient p ON m.cpf_patient = p.cpf
WHERE m.amount > (
    SELECT AVG(amount) 
    FROM Make
);
```

---

## 5. LEFT JOIN with Grouping

Lists all insurance providers and the total number of patients associated with each one.

```sql
SELECT 
    i.insurance_name,
    COUNT(p.cpf) AS patient_count
FROM insurance i
LEFT JOIN patient p ON i.id = p.insurance_id
GROUP BY i.insurance_name
ORDER BY patient_count DESC;
```

---

## 6. Multivalued Attribute

Lists patients and their contact phone numbers.

```sql
SELECT 
    p.full_name AS patient_name,
    ph.phone AS phone_number
FROM patient p
JOIN PatientPhone ph ON p.cpf = ph.cpf_patient
ORDER BY p.full_name;
```

---

## 7. Text Filter with LIKE and Logical Operators

Lists employees whose full name contains the word "Lima" or "Oliveira".

```sql
SELECT 
    full_name,
    email
FROM employee
WHERE full_name LIKE '%Lima%' OR full_name LIKE '%Oliveira%';
```

---

## 8. Advanced Query with Correlated Subquery (EXISTS)

Lists the doctors who have at least one appointment with a payment status of "Paid".

```sql
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
```

---

Back to: [Relational data dictionary with SQL](relational_data_dictionary_with_sql.md)