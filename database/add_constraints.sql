-- add_constraints.sql
-- This script implements data validation rules to ensure database integrity.

-- 1. Personal Identification Constraints
-- Ensures CPFs have exactly 11 characters.
ALTER TABLE employee ADD CONSTRAINT check_employee_cpf_length CHECK (length(cpf) = 11);
ALTER TABLE patient ADD CONSTRAINT check_patient_cpf_length CHECK (length(cpf) = 11);

-- 2. Communication and Address Constraints
-- Basic email format validation.
ALTER TABLE employee ADD CONSTRAINT check_employee_email_format CHECK (email LIKE '%@%.%');

-- Ensures ZIP code follows the Brazilian pattern XXXXX-XXX
ALTER TABLE employee ADD CONSTRAINT check_employee_zip_code CHECK (zip_code ~ '^[0-9]{5}-[0-9]{3}$');
ALTER TABLE patient ADD CONSTRAINT check_patient_zip_code CHECK (zip_code ~ '^[0-9]{5}-[0-9]{3}$');

-- 3. Date Validations
-- Ensures birth dates are not in the future.
ALTER TABLE employee ADD CONSTRAINT check_employee_birth_date CHECK (birth_date <= CURRENT_DATE);
ALTER TABLE patient ADD CONSTRAINT check_patient_birth_date CHECK (birth_date <= CURRENT_DATE);

-- 4. Financial Constraints
-- Prevents negative billing amounts.
ALTER TABLE Make ADD CONSTRAINT check_make_amount_positive CHECK (amount >= 0);

-- 5. Status Constraints
-- Restricts status values to predefined business categories.
ALTER TABLE Make ADD CONSTRAINT check_payment_status_values 
CHECK (payment_status IN ('Paid', 'Pending', 'Cancelled', 'Refunded'));

ALTER TABLE appointment ADD CONSTRAINT check_appointment_status_values 
CHECK (status IN ('Scheduled', 'Confirmed', 'Cancelled', 'Rescheduled', 'Completed'));
