# Olist E-Commerce — Power BI Dashboard

**File:** `Olist_Business_Overview_Dashboard.pbix`

Power BI layer of the Olist Business Overview project. This dashboard turns
the SQL analysis (see `README_SQL_Analysis.md`) into an interactive,
stakeholder-facing report built on the same 5-table star schema
(`fact_orders`, `dim_date`, `dim_customers`, `dim_products`, `dim_geography`).

## Report Pages

The report contains **7 pages**, moving from a high-level summary to focused,
theme-specific deep dives:

| # | Page | Purpose | Key visuals |
|---|---|---|---|
| 1 | **Executive Dashboard** | High-level KPI summary — the "one-screen" view for stakeholders | KPI cards, clustered column chart, line chart (trend), clustered bar chart, donut chart |
| 2 | **Revenue & Time Analytics** | Revenue and order trends over time | Clustered column chart, KPI cards, line + column combo chart, line chart |
| 3 | **Customer Analytics** | Customer behavior, loyalty, and segmentation | Donut chart, line chart, bar chart, KPI cards |
| 4 | **Order & Review Analytics** | Relationship between price, freight, and customer satisfaction | Scatter charts, clustered column chart, KPI cards |
| 5 | **Top 10 Revenue-Generating Categories** | Category-level revenue ranking | Clustered bar chart |
| 6 | **Revenue by State (Top 10)** | Geographic revenue distribution | Clustered bar chart |
| 7 | **Freight Cost % of Revenue** | Shipping cost burden by category | Bar chart |

## How Pages Map to the SQL Analysis

Each dashboard page visualizes the output of one or more SQL queries from the
SQL analysis layer:

- **Executive Dashboard** → summary KPIs pulled across most of the BA queries (revenue trend, top categories, repeat-buyer rate)
- **Revenue & Time Analytics** → Query 1 (Monthly revenue & order trend), Query 4 (AOV trend), Query 10 (YoY growth), Query 11 (weekend vs. weekday)
- **Customer Analytics** → Query 7 (Repeat vs. one-time buyers), Query 8 (RFM segmentation), Query 9 (Revenue concentration)
- **Order & Review Analytics** → Query 12 (Review score vs. price bucket), Query 5 (Freight cost)
- **Top 10 Revenue-Generating Categories** → Query 2 (Top/bottom categories by revenue)
- **Revenue by State (Top 10)** → Query 3 (Revenue & revenue share by state)
- **Freight Cost % of Revenue** → Query 5 (Freight cost as % of revenue by category)

## Data Model

- Built on the same **star schema** as the SQL layer: one fact table
  (`fact_orders`, at the order-line-item grain) joined to four dimension
  tables (`dim_date`, `dim_customers`, `dim_products`, `dim_geography`).
- Measures that require order-level totals (AOV, revenue, YoY growth) are
  written to de-duplicate multi-line-item orders, consistent with the CTE
  logic used in the SQL layer, to avoid double-counting.




