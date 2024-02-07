-- ex1: datalemur-duplicate-job-listings
WITH twt_job_count AS (
    SELECT company_id, title, description,
    COUNT(job_id) AS job_count
    FROM job_listings
    GROUP BY company_id, title, description
)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM twt_job_count
WHERE job_count > 1;

-- ex2: datalemur-highest-grossing
WITH CTE AS (
SELECT 
  category, 
  product, 
  SUM(spend) AS total_spend 
FROM product_spend 
WHERE transaction_date BETWEEN '2022/1/1' AND '2022/12/31'
GROUP BY category, product
)
    (SELECT * FROM CTE
     WHERE category = 'appliance'
     ORDER BY total_spend DESC
     LIMIT 2)
UNION ALL
    (SELECT * FROM CTE
     WHERE category = 'electronics'
     ORDER BY total_spend DESC
     LIMIT 2)

-- ex3: datalemur-frequent-callers
WITH twt_call_records AS (
    SELECT policy_holder_id,
    COUNT(case_id) AS call_count
    FROM callers
    GROUP BY policy_holder_id
    HAVING COUNT(case_id) >= 3
)

SELECT COUNT(policy_holder_id) AS member_count
FROM twt_call_records;

-- ex4: datalemur-page-with-no-likes
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL;

-- ex5: datalemur-user-retention
SELECT
    EXTRACT(MONTH FROM event_date) AS month,
    COUNT(DISTINCT user_id) AS user_count
FROM user_actions
WHERE
    EXTRACT(MONTH FROM event_date) = 7
    AND EXTRACT(YEAR FROM event_date) = 2022
    AND user_id IN (
        SELECT user_id
        FROM user_actions
        WHERE EXTRACT(MONTH FROM event_date) = 6
    )
GROUP BY month;

-- ex6: leetcode-monthly-transactions
SELECT 
    LEFT(trans_date,7) AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE
            WHEN state = 'approved' THEN 1 ELSE 0
        END) AS approved_count,
    SUM(amount) as trans_total_amount,
    SUM(CASE
          WHEN state = 'approved' THEN amount ELSE 0
        END) AS approved_total_amount
FROM Transactions
GROUP BY LEFT(trans_date,7), country

-- ex7: leetcode-product-sales-analysis
SELECT 
    product_id, 
    year AS first_year, 
    quantity, 
    price 
FROM Sales
WHERE (product_id, year) 
    IN (SELECT product_id, MIN(year) FROM Sales GROUP BY product_id);

-- ex8: leetcode-customers-who-bought-all-products
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING SUM(DISTINCT product_key) = (SELECT SUM(product_key) FROM Product)

-- ex9: leetcode-employees-whose-manager-left-the-company
SELECT employee_id 
FROM Employees 
WHERE salary < 30000
AND manager_id NOT IN (SELECT employee_id FROM Employees)

-- ex10: leetcode-primary-department-for-each-employee
  -- bài này trong link bị lặp với ex1 nên em mò lên leetcode tìm lại
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y' 
OR employee_id IN
    (SELECT employee_id 
    FROM employee 
    GROUP BY employee_id
    HAVING COUNT(department_id) = 1)
-- ex11: leetcode-movie-rating
(SELECT name AS results
    FROM MovieRating AS a JOIN Users AS b ON a.user_id = b.user_id
    GROUP BY name
    ORDER BY COUNT(*) DESC, name
    LIMIT 1)
UNION ALL
(SELECT title AS results
    FROM MovieRating AS a JOIN Movies AS b ON a.movie_id = b.movie_id
    WHERE EXTRACT(YEAR_MONTH FROM created_at) = 202002
    GROUP BY title
    ORDER BY AVG(rating) DESC, title
    LIMIT 1);

-- ex12: leetcode-who-has-the-most-friends
SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;
