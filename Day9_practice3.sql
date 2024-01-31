-- ex1:
SELECT 
SUM(CASE
    WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0
  END) AS mobile_views,
SUM(CASE   
    WHEN device_type = 'laptop' THEN 1 ELSE 0
  END) AS laptop_views
FROM viewership;

-- ex2:
SELECT *,
CASE 
    WHEN x + y > z AND x + z > y AND y + z > x 
    THEN 'Yes' 
    ELSE 'No'
END as triangle
FROM Triangle

-- ex3:
SELECT
    ROUND(SUM(
    CASE 
      WHEN call_category IS NULL THEN 1 
      WHEN call_category = 'n/a' THEN 1
      ELSE 0
    END) * 100.0 / COUNT(case_id), 1) AS call_percentage
FROM callers;

-- ex4:
SELECT name FROM customer
WHERE NOT referee_id = 2
OR referee_id IS NULL

-- ex5:
select survived,
sum(
  case
    when pclass = 1 then 1 else 0 
  end) as first_class,
sum(
  case
    when pclass = 2 then 1 else 0 
  end) as second_class,
sum(
  case
    when pclass = 3 then 1 else 0 
  end) as third_class
from titanic
group by survived;
