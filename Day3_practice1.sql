-- exercise1
SELECT name FROM city
WHERE population >120000 
AND countrycode = 'USA'

-- exercise2
SELECT * FROM city
WHERE countrycode = 'JPN'

-- exercise3
SELECT city, state FROM station

-- exercise4
SELECT DISTINCT city FROM station
WHERE city LIKE 'a%' 
OR city LIKE 'e%'
OR city LIKE 'i%'
OR city LIKE 'o%'
OR city LIKE 'u%'

-- exercise5
SELECT DISTINCT city FROM station
WHERE city LIKE '%a' 
OR city LIKE '%e'
OR city LIKE '%i'
OR city LIKE '%o'
OR city LIKE '%u'

-- exercise6
SELECT DISTINCT city FROM station
WHERE NOT (city LIKE 'a%' 
OR city LIKE 'e%'
OR city LIKE 'i%'
OR city LIKE 'o%'
OR city LIKE 'u%')

-- exercise7
SELECT name FROM employee
ORDER BY name ASC

-- exercise8
SELECT name FROM employee
WHERE salary > 2000
AND months < 10
ORDER BY employee_id ASC

-- exercise9
SELECT product_id FROM Products
WHERE low_fats = 'Y'
AND recyclable = 'Y'

-- exercise10
SELECT name FROM customer
WHERE NOT referee_id = 2
OR referee_id IS NULL

-- exercise11
SELECT name, population, area FROM world
WHERE area >= 300000
AND population >=25000000

-- exercise12
SELECT DISTINCT author_id AS id FROM views
WHERE viewer_id = author_id 
AND article_id >= 1
ORDER BY id ASC

-- exercise13
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;

-- exercise14
select * from lyft_drivers
where yearly_salary <= 30000
or yearly_salary >= 70000;

-- exercise15
select * from uber_advertising
where money_spent >= 100000
and year = 2019;
