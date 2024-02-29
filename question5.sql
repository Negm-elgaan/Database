#ALX QUIZ 1 QUESTION 5
SELECT 
	*
FROM 
	employee    
WHERE
	position LIKE "Civil%"
    AND
    	(
		town_name = "Dahabu"
        OR
        address LIKE "%Avenue"
);
