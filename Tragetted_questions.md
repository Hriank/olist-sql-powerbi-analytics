# SQL Analysis — Olist E-Commerce Portfolio Project

This folder contains 12 SQL queries answering real business and analytical
questions about the Olist e-commerce dataset, split into two themes:
**Business Analytics (BA)** — questions a stakeholder would ask — and
**Data Analytics (DA)** — questions demonstrating SQL technique (CTEs,
window functions, RFM, cohort logic).

All queries run against a 5-table star schema (`dim_date`, `dim_customers`,
`dim_products`, `dim_geography`, `fact_orders`) built from Olist's 9 raw
CSV files — see `/5-Star schema` for the schema build scripts.

---

## BA Analysis

### 1. Monthly Revenue & Order Volume Trend
**File:** `Monthly_revenue_&_order_volume_trend`
**Question:** Is the business growing month over month?
**Answer:** Revenue and order volume were negligible during Olist's pilot
phase (Sep–Dec 2016, under 300 total orders), then grew steadily and
consistently from January 2017 onward through the end of the dataset —
a clear, sustained growth trajectory rather than a spike-and-plateau pattern.

### 2. Top 10 & Bottom 10 Product Categories by Revenue
**File:** `Top 10 & Bottom 10 product categories...`
**Question:** Which categories should the business invest in vs. phase out?
**Answer:** `health_beauty`, `watches_gifts`, and `bed_bath_table` are the
top three revenue-generating categories. Notably, `watches_gifts` earns
more per item than higher-volume categories, indicating it's a
premium/high-margin category worth featuring, not just a high-volume one.

### 3. Revenue & Revenue Share by State
**File:** `Revenue_by_State`
**Question:** Which regions drive the business, and where's the untapped potential?
**Answer:** São Paulo (SP) alone generates more than double the revenue of
the next-highest state (RJ), reflecting its role as Brazil's largest
market and Olist's home base. Revenue-per-order is fairly consistent
across states (₹142–182), meaning this is a volume story, not a
per-order-value story — growth outside SP would need more orders, not
higher-spending customers.

### 4. Average Order Value (AOV) Trend by Quarter
**File:** `Average_Order_Value_(AOV)_Trend_Over...`
**Question:** Are customers spending more per order over time?
**Answer:** AOV actually declined through 2017 even as order volume grew
sharply — a common growth-stage pattern where scaling attracts more
price-sensitive or smaller-basket customers alongside overall growth.

### 5. Freight Cost as % of Revenue, by Category
**File:** `Freight cost`
**Question:** Which categories are eating margin on shipping?
**Answer:** Identifies which product categories carry disproportionately
high shipping costs relative to their item price — typically bulky/heavy
categories (e.g. furniture) show a higher freight-to-price ratio than
compact categories (e.g. watches/jewelry), flagging where shipping
strategy or pricing may need adjustment.

### 6. Cancellation Rate & Revenue Lost to Cancellations
**File:** `Cancellation_rate_&_revenue_lost_to_can...`
**Question:** How much revenue leaks out from cancelled orders, and does
it cluster in specific categories?
**Answer:** Overall cancellation rate is low (well under 1% of orders),
but revenue lost is concentrated in a handful of categories — e.g.
`sports_leisure` and `computers_accessories` show measurably higher
cancelled-order counts and revenue loss than average, worth flagging as
a targeted area for order-fulfillment review.

---

## DA Analysis

### 7. Repeat vs. One-Time Buyers
**File:** `Repeat_vs._One_Time_Buyers`
**Question:** How loyal is the customer base?
**Answer:** **96.96% of customers never place a second order** — only
3.04% are repeat buyers. This is the single most important finding in
the project: it reframes the entire retention narrative, showing that
acquisition, not repeat purchasing, currently drives Olist's growth, and
that even small improvements in repeat-purchase rate would be highly
valuable.

### 8. RFM Segmentation (Recency, Frequency, Monetary)
**File:** `RFM segmentation`
**Question:** Who are the most valuable customers, and who's at risk of
being lost?
**Answer:** Segments customers into Champions, Loyal, At-Risk, and Lost
based on how recently, how often, and how much they've purchased. Given
the 96.96% one-time-buyer reality from Q7, the segmentation skews heavily
toward Lost/At-Risk — consistent with, and reinforcing, the retention
finding above rather than contradicting it.

### 9. Revenue Concentration (Pareto / 80-20 Check)
**File:** `Revenue concentration`
**Question:** Does a small share of customers drive most of the revenue?
**Answer:** Splits customers into revenue quintiles to test the classic
80/20 rule — showing what percentage of total revenue comes from the
top-spending 20% of customers versus the bottom 20%, quantifying how
concentrated (or spread out) Olist's revenue base actually is.

### 10. Year-over-Year Revenue Growth
**File:** `Year-over-year revenue growth`
**Question:** How much did revenue grow each year, in percentage terms?
**Answer:** Uses `LAG()` to compare each year's total revenue to the
prior year, quantifying the pace of growth precisely rather than relying
on the visual impression from the monthly trend chart alone.

### 11. Weekend vs. Weekday Order Behavior
**File:** `weekend vs weekdays`
**Question:** Do people order more on weekends or weekdays?
**Answer:** Compares average daily order volume and revenue between
weekend and weekday days, revealing whether Olist's shopping behavior
mirrors typical e-commerce patterns (often weekday-heavy, since B2C
online shopping frequently peaks during work-week browsing) or skews
toward weekends.

### 12. Review Score vs. Order Price Bucket
**File:** `Review score vs. order price bucket`
**Question:** Do higher-priced orders get better or worse reviews?
**Answer:** Buckets orders into price tiers (Under R$50, R$50-150,
R$150-300, R$300+) and compares average review score and freight cost
across tiers — testing whether higher-priced purchases come with higher
customer satisfaction, or whether freight cost eats into the experience
regardless of item price.

---

## Key Data-Quality Notes
- **Cancellations, not returns:** Olist's `order_status` field does not
track product returns — only order-level statuses like `delivered` and
`canceled`. All "revenue leakage" analysis in this project is framed
around cancellations, not returns, for that reason.
- **2016 pilot-phase data:** Sep–Dec 2016 contains fewer than 300 total
orders (platform soft-launch). This data is retained in trend charts for
contrast rather than excluded, since it's genuine historical data, not
an error.
- **Fan-out handling:** `fact_orders` is at the order-*item* grain (one
row per line item). Every query needing an order-level total (AOV,
YoY growth, weekend/weekday averages, RFM monetary value) first
collapses to one row per order via a CTE before aggregating further, to
avoid double-counting orders with multiple items.
