# DataAnalytics-Assessment
# Customer Analysis SQL Scenarios: README

This README documents the SQL-based analysis performed to address various business scenarios related to customer behavior, financial engagement, and segmentation using MySQL. Each section contains the **objective**, **approach**, and **challenges** encountered.

---

## 1. Cross-Selling Opportunity: Customers with Both Savings and Investment Plans

**Objective:** 
To identify cross-selling opportunities, we aimed to find customers who already have both a funded savings account and a funded investment plan.This helps the company to sell more specifically to customers who are already financially invested and are therefore more likely to be open to upselling or cross-selling opportunities. We defined "funded" accounts as having a positive deposit or balance (amount > 0).

**Approach:**

* Join `savings_savingsaccount` and `plans_plan` on `owner_id`.
* Ensure both the savings and investment records are "funded". (e.g., balance or deposits > 0).
* Aggregate total deposit amounts per customer.
* Sort results by total deposits.

---

## 2. Frequency-Based User Segmentation

**Objective:** The business wants to classify users based on how often they transact each month. This requires calculating average transactions per customer per month, then grouping them into categories for segmentation and personalized engagement.

**Approach:**

* Count total transactions per customer.
* Calculate tenure in months.
* Derive average transactions per month.
* Use a `CASE` statement to categorize:

  * High: >= 10/month
  * Medium: 3-9/month
  * Low: <= 2/month
 
---

## 3. Inactive Accounts Over One Year

**Objective:** For enhancing operating performance and reactivation of customers, the ops team wants to find those accounts which have not had any inflow during the past 365 days. Both savings and investment accounts are taken into account.

**Approach:**

* Join savings/investment tables with their respective transaction records..
* Use MAX(transaction_date) to find the most recent transaction per account.
* Calculate inactivity using DATEDIFF() compared to NOW().
* Filter accounts with more than 365 days of inactivity.

---

## 4. Estimating Customer Lifetime Value (CLV)

**Objective:** Marketing needed a simple yet useful model to estimate Customer Lifetime Value using account tenure and total transaction volume. The assumption is that CLV grows with both engagement (transaction volume) and customer longevity (tenure).

**Formula:**

```
CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction
```

**Assumption:** Profit per transaction = 0.1% of transaction value.

**Approach:**

* Calculate tenure as months since `date_joined`.
* Sum transaction amounts and count them for each user.
* Calculate estimated profit per transaction (0.1% of transaction value).
* Order customers by descending CLV.

---

## License

MIT License. Use freely for learning, collaboration, and project reporting.

---

## Author

Falana Feranmi Prepared this with ❤️ for Cowrywise using SQL and real-world business cases as an experienced data analyst.
