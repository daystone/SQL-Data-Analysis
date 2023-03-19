USE superhero;

-- Return all DC or Marvel characters
SELECT
	superhero_name,
    publisher_name
FROM superhero s
JOIN publisher p ON s.publisher_id = p.id
WHERE publisher_name IN ('Marvel Comics', 'DC Comics')
ORDER BY superhero_name;

-- Which powers are more prevelant amongst characters
-- power appears more than 100 times
SELECT 
    sp.power_name,
    COUNT(*) AS power_count
FROM superhero s
JOIN hero_power hp ON s.id = hp.hero_id
JOIN superpower sp ON hp.power_id = sp.id
GROUP BY power_name
HAVING power_count > 100
ORDER BY power_count DESC;

-- Which powers are more prevelant amongst publishers
-- DC and Marvel are the two most notable publishers
-- No other publisher in the top 25
SELECT 
    p.publisher_name,
    sp.power_name,
    COUNT(sp.power_name) AS power_count
FROM superhero s
JOIN publisher p ON s.publisher_id = p.id
JOIN hero_power hp ON s.id = hp.hero_id
JOIN superpower sp ON hp.power_id = sp.id
WHERE publisher_name REGEXP 'Marvel|DC'
GROUP BY p.publisher_name, sp.power_name
ORDER BY power_count DESC;

-- Character alignment (Good, bad, neutral) in relation to overall attributes and their universe
SELECT
	s.superhero_name,
	p.publisher_name,
	a.alignment,
    SUM(ha.attribute_value) AS total_attributes
FROM superhero s
JOIN hero_attribute ha
	ON s.id = ha.hero_id
JOIN alignment a
	ON s.alignment_id = a.id
JOIN publisher p
	ON s.publisher_id = p.id
WHERE alignment IS NOT NULL 
GROUP BY s.superhero_name, p.publisher_name, a.alignment
ORDER BY total_attributes DESC
LIMIT 30;

-- Classify attribute totals for characters
SELECT 
	superhero_name,
    SUM(attribute_value) AS attribute_total,
    CASE
		WHEN SUM(attribute_value) > 1000 THEN 'Class 5'
        WHEN SUM(attribute_value) > 600 THEN 'Class 4'
        WHEN SUM(attribute_value) > 400 THEN 'Class 3'
        WHEN SUM(attribute_value) > 200 THEN 'Class 2'
        ELSE 'Class 1'
	END AS attribute_classification
FROM superhero s
JOIN hero_attribute ha
	ON s.id = ha.hero_id
GROUP BY superhero_name
ORDER BY attribute_total DESC;

-- Return characters and their attribute when it is equal to the max value for attributes
SELECT 
	s.superhero_name,
    a.attribute_name,
    ha.attribute_value
FROM superhero s
JOIN hero_attribute ha 
	ON s.id = ha.hero_id
JOIN attribute a
	ON ha.attribute_id = a.id
WHERE ha.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute)
ORDER BY s.superhero_name;



	






