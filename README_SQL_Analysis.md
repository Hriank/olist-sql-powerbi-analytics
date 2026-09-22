# Olist E-Commerce — SQL Analysis

SQL layer of the Olist Business Overview project. This folder contains the star
schema build scripts and 12 analytical queries that answer real business and
data-analytics questions using the Olist Brazilian E-Commerce dataset.

## Data Model

All queries run against a **5-table star schema** built from Olist's 9 raw CSV files:

| Table | Type | Grain |
|---|---|---|
| `fact_orders` | Fact | One row per order **line item** |
| `dim_date` | Dimension | One row per calendar date |
| `dim_customers` | Dimension | One row per customer |
| `dim_products` | Dimension | One row per product |
| `dim_geography` | Dimension | One row per state/region |

> Schema build scripts live in `/5-Star schema`.

**Important — fan-out handling:** because `fact_orders` is at the order-*item*
grain, any metric that needs an order-level total (AOV, YoY growth,
weekend/weekday averages, RFM monetary value) first collapses to one row per
order via a CTE before aggregating further. This avoids double-counting
orders that contain multiple line items.

## Queries

Queries are split into two themes: **Business Analytics (BA)** — the questions
a stakeholder would ask — and **Data Analytics (DA)** — queries built to
demonstrate SQL technique (CTEs, window functions, RFM logic, cohort-style
segmentation).

### Business Analytics (BA)

| # | Query file | Business question |
|---|---|---|
| 1 | `Monthly_revenue_&_order_volume_trend` | Is the business growing month over month? |
| 2 | `Top 10 & Bottom 10 product categories...` | Which categories should we invest in vs. phase out? |
| 3 | `Revenue_by_State` | Which regions drive the business, and where's the untapped potential? |
| 4 | `Average_Order_Value_(AOV)_Trend_Over...` | Are customers spending more per order over time? |
| 5 | `Freight cost` | Which categories are eating margin on shipping? |
| 6 | `Cancellation_rate_&_revenue_lost_to_can...` | How much revenue leaks from cancellations, and where does it cluster? |

### Data Analytics (DA)

| # | Query file | Technique / question |
|---|---|---|
| 7 | `Repeat_vs._One_Time_Buyers` | Customer loyalty split — repeat vs. one-time buyers |
| 8 | `RFM segmentation` | Recency / Frequency / Monetary customer segmentation |
| 9 | `Revenue concentration` | Pareto (80/20) check via revenue quintiles |
| 10 | `Year-over-year revenue growth` | `LAG()` window function for YoY % growth |
| 11 | `weekend vs weekdays` | Weekend vs. weekday order/revenue behavior |
| 12 | `Review score vs. order price bucket` | Review score and freight cost across price tiers |

## SQL Techniques Demonstrated

- Common Table Expressions (CTEs) for order-level de-duplication
- Window functions (`LAG`, ranking) for trend and growth analysis
- RFM segmentation logic (recency / frequency / monetary scoring)
- Percentile / quintile bucketing for Pareto (80/20) analysis
- Conditional aggregation (`CASE WHEN`) for weekday/weekend and price-tier buckets
- Multi-table joins across the star schema for category-, state-, and time-level rollups

## Data-Quality Notes

- **Cancellations, not returns:** Olist's `order_status` field only tracks
  order-level statuses (`delivered`, `canceled`, etc.) — there is no
  return/refund tracking. All "revenue leakage" analysis is framed around
  cancellations for this reason, not product returns.
- **2016 pilot-phase data:** September–December 2016 contains fewer than 300
  total orders (platform soft-launch). This is retained in trend charts for
  historical contrast rather than excluded — it's genuine data, not an error.

## How to Use

1. Run the schema build scripts in `/5-Star schema` against your database
   (Postgres/MySQL/SQL Server) to load the 9 raw Olist CSVs into the 5-table
   star schema.
2. Run each numbered query independently — they're self-contained and can be
   run in any order.
3. Query outputs feed directly into the Power BI dashboard (see
   `README_PowerBI.md`) either via direct database connection or as exported
   result sets.
