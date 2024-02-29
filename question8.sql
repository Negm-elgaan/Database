SELECT
	*
FROM
	water_quality
WHERE
	subjective_quality_score = 10 
    AND
    visit_count > 1 ;
