-- ex1
SELECT name
FROM students
WHERE marks > 75
ORDER BY RIGHT(name,3), ID

-- ex2
SELECT user_id, 
CONCAT (UPPER (LEFT(name,1)), LOWER (RIGHT(name,LENGTH (name)-1))) 
AS name
FROM Users
ORDER BY user_id

-- ex3
SELECT manufacturer, 
'$'|| ROUND(SUM (total_sales)/1000000,0)||' '||'million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer ;

-- ex4
SELECT 
EXTRACT (month FROM submit_date) AS mth,
product_id, 
ROUND(AVG(stars),2) AS avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id;

-- ex5
SELECT sender_id,
COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(month FROM sent_date) = 8
AND EXTRACT(year FROM sent_date) = 2022
GROUP BY sender_id 
ORDER BY message_count DESC
LIMIT 2;

-- ex6
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15

-- ex7
SELECT activity_date AS day,
COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date

-- ex8
select 
count(id) as hired_employees
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date) = 2022;

-- ex9
select 
position('a' in first_name)
from worker
where first_name = 'Amitah';

-- ex10
select substring(title from length(winery)+2 for 4)
from winemag_p2;
