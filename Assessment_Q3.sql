-- QUESTION 3
-- Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .


-- Get last transaction dates from savings accounts
WITH savings_last_txn AS (
    SELECT 
        plan_id,
        owner_id,
        MAX(transaction_date) AS last_txn_date,
        'savings' AS account_type
    FROM savings_savingsaccount
    GROUP BY plan_id, owner_id
),

-- Get last transaction dates from investment plans (plans_plan)
investment_last_txn AS (
    SELECT 
        id AS plan_id,
        owner_id,
        GREATEST(
            COALESCE(last_charge_date, '2015-01-01'), 
            COALESCE(last_returns_date, '2017-01-01')
           ) AS last_txn_date,
        'investment' AS account_type
    FROM plans_plan
    WHERE is_archived = 0 AND is_deleted = 0
),

-- Combine all accounts with their last transaction date
combined_last_txn AS (
    SELECT * FROM savings_last_txn
    UNION ALL
    SELECT * FROM investment_last_txn
)

SELECT
    plan_id,
    owner_id,
    account_type AS type,
    last_txn_date,
    DATEDIFF(CURDATE(), last_txn_date) AS inactivity_days
FROM combined_last_txn
WHERE last_txn_date <= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
ORDER BY inactivity_days DESC;
