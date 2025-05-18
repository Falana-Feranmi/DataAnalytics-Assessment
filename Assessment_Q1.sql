-- QUESTION 1
-- Write a query to find customers with at least one funded savings plan AND one funded investment plan, 
-- sorted by total deposits.

SELECT 
    u.id AS Owner_id,
    CONCAT(first_name," ",last_name) As names,	
    COALESCE(SUM(s.confirmed_amount), 0) AS total_savings_deposit,
    COALESCE(SUM(pp.amount), 0) AS total_investment_goal,
    (COALESCE(SUM(s.confirmed_amount), 0) + COALESCE(SUM(pp.amount), 0)) AS total_deposit
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id AND s.confirmed_amount > 0
JOIN plans_plan pp ON u.id = pp.owner_id AND pp.is_fixed_investment = 1 AND pp.amount > 0
GROUP BY u.id,names
ORDER BY total_deposit DESC;