#ALX QUIZ 1 QUESTION 6
SELECT
	*
FROM
	employee
WHERE
	(phone_number LIKE "%86%"
    OR
	phone_number LIKE "%11%")
    AND
    (
		employee_name LIKE "%A%"
        OR
        employee_name LIKE "%M%"
	)
    AND
		position = "Field Surveyor" ;
    
