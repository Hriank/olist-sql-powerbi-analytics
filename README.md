# Olist E-Commerce — SQL & Power BI Analytics Project

An end-to-end analytics project on the **Olist Brazilian E-Commerce
dataset**, combining SQL-based data analysis with an interactive Power BI
dashboard. Built to demonstrate both **data analytics** (SQL technique: CTEs,
window functions, RFM segmentation, cohort-style logic) and **business
analytics** (translating raw transactional data into decisions a stakeholder
could act on).

---

## Project Overview

Olist is a Brazilian e-commerce marketplace that connects small businesses to
major online sales channels. This project uses their public, anonymized
dataset (~100k orders, 2016–2018) to answer two kinds of questions:

- **Business Analytics (BA):** revenue trends, category performance,
  regional performance, shipping economics, cancellation impact
- **Data Analytics (DA):** customer loyalty, RFM segmentation, revenue
  concentration (Pareto), YoY growth, behavioral patterns

The project is built in three layers:

```
Raw Olist CSVs (9 tables)
        │
        ▼
   SQL Layer  ──▶  5-table star schema + 12 analytical queries
        │
        ▼
  Power BI Layer  ──▶  7-page interactive dashboard
        │
        ▼
  Business Insights  ──▶  Key findings & recommendations
```

## Repository Structure

```
├── /5-Star schema/                          # Schema build scripts (raw CSVs → star schema)
├── *.sql                                    # 12 analytical SQL queries (BA + DA)
├── Olist_Business_Overview_Dashboard.pbix   # Power BI dashboard
├── README.md                                # This file
├── README_SQL_Analysis.md                   # SQL schema, queries, and technique breakdown
├── README_PowerBI.md                        # Dashboard pages, visuals, and data model
└── README_Key_Insights.md                   # Business insights & recommendations
```

## Data Model

A 5-table star schema built from Olist's 9 raw CSV files:

- `fact_orders` (order-line-item grain)
- `dim_date`, `dim_customers`, `dim_products`, `dim_geography`

> Full schema details in [`README_SQL_Analysis.md`](README_SQL_Analysis.md).

## Tech Stack

| Layer | Tools |
|---|---|
| Data source | [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle) |
| Database / SQL | PostgreSQL-style SQL (CTEs, window functions, `FILTER`, `NTILE`) |
| BI / Visualization | Power BI Desktop |

## Highlights

- **12 SQL queries** spanning BA and DA themes, all built on a clean star
  schema with fan-out-safe, order-level aggregation logic
- **7-page Power BI dashboard**: Executive Dashboard, Revenue & Time
  Analytics, Customer Analytics, Order & Review Analytics, plus three
  focused breakdown pages (categories, states, freight cost)
- **Headline finding:** 96.96% of customers never place a second order —
  reframing the business as acquisition-driven rather than retention-driven,
  and identifying retention as the single largest untapped growth lever

## Where to Look

| Want to see... | Go to |
|---|---|
| The SQL schema and all 12 queries, with technique breakdown | [`README_SQL_Analysis.md`](README_SQL_Analysis.md) |
| The dashboard pages and how they map to the SQL analysis | [`README_PowerBI.md`](README_PowerBI.md) |
| The business takeaways and recommendations | [`README_Key_Insights.md`](README_Key_Insights.md) |

## How to Run This Project

1. Download the [Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) from Kaggle.
2. Run the schema build scripts in `/5-Star schema` to load the raw CSVs into
   a PostgreSQL (or compatible) database as the 5-table star schema.
3. Run any of the 12 `.sql` files in the repo root to reproduce the analysis.
4. Open `Olist_Business_Overview_Dashboard.pbix` in Power BI Desktop and
   point the data source at your database to reproduce the dashboard.

## Data-Quality Notes

- Olist's `order_status` field tracks cancellations, not product returns —
  all "revenue leakage" analysis in this project refers to cancellations.
- September–December 2016 data reflects Olist's platform soft-launch (under
  300 total orders) and is retained in trend views for historical context.

---

*Dataset: [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), licensed for public/educational use on Kaggle.*
