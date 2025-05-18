-- QUESTION 4
-- For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest

SELECT 
    u.id AS customer_id,
    CONCAT(first_name," ",last_name) As names,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
      -- Estimated CLV formula
    (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * AVG(s.amount * 0.001) AS estimated_clv
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON s.owner_id = u.id
GROUP BY u.id, names, u.date_joined
ORDER BY estimated_clv DESC;