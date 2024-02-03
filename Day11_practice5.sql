-- EX1:
SELECT COUNTRY.Continent,
FLOOR(AVG(CITY.Population))
FROM COUNTRY
JOIN CITY
ON CITY.CountryCode=COUNTRY.Code
GROUP BY COUNTRY.Continent

--EX2:
SELECT 
  ROUND(
    CAST(
      COUNT(texts.email_id)/COUNT(DISTINCT emails.email_id)
    AS DECIMAL),2) 
AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
WHERE texts.signup_action = 'Confirmed'
      -- ac giảng lỗi sai cho em câu này với, biết là sai mà em kb sai ở đâu TvT

--EX3:
SELECT b.age_bucket, 
  ROUND(SUM(
    CASE 
      WHEN activity_type = 'send' THEN time_spent ELSE 0 
    END) * 100.0 / SUM(time_spent), 2) as send_perc, 
  ROUND(SUM(
    CASE 
      WHEN activity_type = 'open' THEN time_spent ELSE 0 
    END) * 100.0 / SUM(time_spent), 2) as open_perc 
FROM activities AS a 
LEFT JOIN age_breakdown AS b
ON a.user_id = b.user_id 
WHERE activity_type in ('send','open')
GROUP BY b.age_bucket;

--EX4:
SELECT c.customer_id 
FROM customer_contracts AS c 
JOIN products AS p ON c.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT(p.product_category)) = (SELECT COUNT(DISTINCT(product_category)) FROM products);

--EX5:
SELECT emp.reports_to AS employee_id,
    mng.name,
    COUNT(emp.reports_to) AS reports_count,
    ROUND(AVG(emp.age),0) AS average_age
FROM Employees AS emp
JOIN Employees AS mng
ON emp.reports_to = mng.employee_id
GROUP BY emp.reports_to
ORDER BY emp.reports_to

--EX6:
SELECT product_name, SUM(unit) as unit
FROM orders 
LEFT JOIN products 
ON orders.product_id = products.product_id
WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY orders.product_id
HAVING SUM(unit) >= 100

--EX7:
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes
  ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL;
