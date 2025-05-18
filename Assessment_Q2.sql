-- QUESTION 2
-- Calculate the average number of transactions per customer per month and categorize them:
-- "High Frequency" (≥10 transactions/month)
-- "Medium Frequency" (3-9 transactions/month)
-- "Low Frequency" (≤2 transactions/month)

WITH monthly_txns AS (
    SELECT 
        owner_id,
        YEAR(transaction_date) AS txn_year,
        MONTH(transaction_date) AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, YEAR(transaction_date), MONTH(transaction_date)
),
avg_monthly_txns AS (
    SELECT
        owner_id,
        AVG(txn_count) AS avg_txns_per_month
    FROM monthly_txns
    GROUP BY owner_id
),
categorized AS (
    SELECT
        owner_id,
        avg_txns_per_month,
        CASE
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM avg_monthly_txns
)

SELECT
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 2) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
