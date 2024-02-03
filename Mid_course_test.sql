-- Q1:
SELECT DISTINCT replacement_cost FROM film
ORDER BY replacement_cost 

-- Q2:
SELECT
CASE
	WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
	WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
	ELSE 'high'
END AS category,
COUNT(*) AS SO_LUONG
FROM film
GROUP BY category

-- Q3:
SELECT film.title, film.length, film_category.category_id, public.category.name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN public.category ON film_category.category_id = public.category.category_id
WHERE public.category.name = 'Drama' OR public.category.name = 'Sports'
ORDER BY film.length DESC

-- Q4:
SELECT category.name, COUNT(*) AS SO_LUONG
FROM film_category
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY COUNT(*) DESC

-- Q5:
SELECT actor.first_name ||' '|| actor.last_name AS full_name, 
  COUNT(*) AS SO_LUONG
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.first_name ||' '|| actor.last_name
ORDER BY COUNT(*) DESC

-- Q6:
SELECT address.address, customer.first_name ||' '|| customer.last_name AS full_name
FROM address
LEFT JOIN customer ON address.address_id = customer.address_id
WHERE customer.first_name ||' '|| customer.last_name IS NULL

-- Q7:
SELECT a.city, SUM(d.amount) AS revenue
FROM city AS a
  JOIN address AS b ON a.city_id = b.city_id
  JOIN customer AS c ON b.address_id = c.address_id
  JOIN payment AS d ON c.customer_id = d.customer_id
GROUP BY a.city
ORDER BY SUM(d.amount) DESC

-- Q8:
SELECT CONCAT(a.city,',',' ',e.country), 
SUM(d.amount) AS revenue
FROM city AS a
	JOIN address AS b ON a.city_id = b.city_id
	JOIN customer AS c ON b.address_id = c.address_id
	JOIN payment AS d ON c.customer_id = d.customer_id
	JOIN country AS e ON a.country_id = e.country_id
GROUP BY  CONCAT(a.city,',',' ',e.country)
ORDER BY SUM(d.amount)
