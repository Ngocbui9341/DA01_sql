-- exercise 1
SELECT DISTINCT city FROM station
WHERE ID%2=0

-- exercise 2
SELECT 
COUNT(city) - COUNT(DISTINCT city)
FROM station

-- exercise 3
SELECT 
CEILING(AVG(salary) - AVG(REPLACE(salary,'0','')))
FROM employees

-- exercise 4
SELECT 
ROUND(CAST(SUM(item_count * order_occurrences)/SUM(order_occurrences) AS decimal),1)
FROM items_per_order;

-- exercise 5
SELECT candidate_id 
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3
ORDER BY candidate_id ASC;

-- exercise 6
SELECT user_id,DATE(MAX(post_date)) - DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date BETWEEN '2021-01-01' AND '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id) >=2;

-- exercise 7
SELECT card_name, 
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

-- exercise 8
SELECT manufacturer,
COUNT(drug) AS drug_count,
ABS(SUM(cogs - total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- exercise 9
SELECT * FROM Cinema
WHERE id%2=1 
AND description <> 'boring'
ORDER BY rating DESC

-- exercise 10
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- exercise 11
SELECT user_id,
COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

-- exercise 12
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) >=5
