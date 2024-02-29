#CREATE TABLE fake_employee
#(
#	phone_number VARCHAR(15)
#)
#INSERT INTO fake_employee
#(
#	phone_number
#)
#SELECT 
#	phone_number	
#FROM 
#	employee 
#WHERE
#	employee_name = 'Bello Azibo' ;
#SELECT 
#	*
#FROM
#	fake_employee;
SET SQL_SAFE_UPDATES = 0 ;
UPDATE 
	fake_employee
SET 
	phone_number = '+99643864786';

