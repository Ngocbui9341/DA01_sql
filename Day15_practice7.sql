-- ex1: datalemur-yoy-growth-rate.
SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    spend AS curr_year_spend,
    LAG(spend) OVER (PARTITION BY product_id ORDER BY transaction_date) AS prev_year_spend,
    ROUND(100 * (spend - LAG(spend) OVER (PARTITION BY product_id ORDER BY transaction_date)) 
      /LAG(spend) OVER (PARTITION BY product_id ORDER BY transaction_date),2) AS yoy_rate
FROM user_transactions;

-- ex2: datalemur-card-launch-success.
SELECT DISTINCT(card_name),
FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) 
AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC;

-- ex3: datalemur-third-transaction.
WITH row_spend AS (
  SELECT *, 
  ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row 
  FROM transactions
)
SELECT user_id, spend, transaction_date
FROM row_spend
WHERE row = 3
  
-- ex4: datalemur-histogram-users-purchases.
SELECT transaction_date, user_id, 
COUNT(*)  AS purchase_count
FROM
  (SELECT user_id, transaction_date,
    RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS rank
  FROM user_transactions
  ) AS ranking
WHERE rank = 1
GROUP BY transaction_date, user_id;
  
-- ex5: datalemur-rolling-average-tweets.
SELECT  user_id, tweet_date,
ROUND(
  AVG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) 
AS rolling_avg_3d
FROM tweets;

-- ex6: datalemur-repeated-payments.
WITH cte AS (
SELECT transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp as current_transaction,
  LAG(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp) AS previous_transaction
FROM transactions
)
SELECT COUNT(merchant_id) as payment_count
FROM cte
WHERE current_transaction - previous_transaction <= INTERVAL '10 minutes'

-- ex7: datalemur-highest-grossing.
WITH ranked_spend AS 
(
  SELECT 
    category, 
    product, 
    SUM(spend) as total_spend,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as ranking
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)
SELECT 
  category,
  product,
  total_spend
FROM ranked_spend
WHERE ranking <=2
ORDER BY category, ranking;

-- ex8: datalemur-top-fans-rank.
WITH top_10 AS(
  SELECT 
    a.artist_name,
    DENSE_RANK() OVER (ORDER BY COUNT(b.song_id) DESC) AS artist_rank
  FROM artists AS a
  JOIN songs AS b ON a.artist_id = b.artist_id
  JOIN global_song_rank AS c ON b.song_id = c.song_id
  WHERE c.rank <= 10
  GROUP BY a.artist_name
)
SELECT artist_name, artist_rank
FROM top_10
WHERE artist_rank <= 5;
