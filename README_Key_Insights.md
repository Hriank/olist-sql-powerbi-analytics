# Olist E-Commerce — Key Insights & Business Recommendations

This document synthesizes the findings from the 12 SQL queries
(`README_SQL_Analysis.md`) and the Power BI dashboard (`README_PowerBI.md`)
into the "so what" — the insights and recommendations a business stakeholder
would actually act on.

---

## 1. The business is growing, but growth is acquisition-driven, not retention-driven

- Revenue and order volume were negligible during Olist's 2016 pilot phase
  (under 300 orders total), then grew steadily and consistently from January
  2017 onward — a sustained trajectory, not a spike-and-plateau.
- However, **96.96% of customers never place a second order** — only 3.04%
  are repeat buyers.
- RFM segmentation confirms this: the customer base skews heavily toward
  **At-Risk / Lost** segments, consistent with the one-time-buyer reality.

**Recommendation:** Growth today is almost entirely a new-customer-acquisition
story. Retention is the single biggest untapped lever — even a small
improvement in repeat-purchase rate (e.g. via post-purchase email flows,
loyalty incentives, or a second-purchase discount) would materially change
the revenue trajectory, since the current base is barely being monetized
beyond the first order.

---

## 2. Revenue is concentrated in a few categories and one region

- `health_beauty`, `watches_gifts`, and `bed_bath_table` are the top three
  revenue-generating categories.
- `watches_gifts` earns more **per item** than higher-volume categories —
  it's a premium/high-margin category, not just a high-volume one.
- **São Paulo (SP)** generates more than double the revenue of the
  next-highest state (RJ) — expected, given it's Brazil's largest market and
  Olist's home base.
- Revenue-per-order is fairly consistent across states (roughly R$142–182),
  meaning regional differences are driven by **order volume**, not
  higher-spending customers.

**Recommendation:** Feature `watches_gifts` more prominently — it's a margin
opportunity, not just a volume one. For geographic growth, the lever outside
SP is **more orders**, not premium pricing — invest in demand generation
(marketing, seller onboarding, logistics coverage) in high-potential states
rather than pricing strategy.

---

## 3. Average order value is quietly declining even as the business scales

- AOV declined through 2017 even as order volume grew sharply.

**Recommendation:** This is a normal growth-stage pattern (scaling brings in
more price-sensitive, smaller-basket customers) but it's worth monitoring —
if AOV keeps falling as CAC (customer acquisition cost) rises, unit economics
could quietly erode even while top-line revenue looks healthy. Track AOV
alongside acquisition cost, not in isolation.

---

## 4. Shipping cost is a hidden margin problem in specific categories

- Freight cost as a percentage of item price is disproportionately high for
  bulky/heavy categories (e.g. furniture-adjacent categories) compared to
  compact, high-value categories (e.g. watches/jewelry).

**Recommendation:** Review pricing or shipping strategy for high freight-ratio
categories specifically — either build freight cost into the item price more
aggressively, negotiate better shipping rates for bulky categories, or
deprioritize promoting those categories where margin is already thin.

---

## 5. Cancellations are rare overall, but concentrated enough to act on

- Overall cancellation rate is low (well under 1% of orders).
- However, revenue lost to cancellations clusters in specific categories —
  notably `sports_leisure` and `computers_accessories`, which show
  measurably higher cancellation counts and revenue loss than average.

**Recommendation:** Cancellations aren't a business-wide problem, but they're
a targeted one. A fulfillment/inventory review focused specifically on
`sports_leisure` and `computers_accessories` sellers would likely recover
more lost revenue than a blanket policy change.

---

## 6. Revenue concentration is moderate, not extreme

- Revenue quintile analysis (Pareto/80-20 check) shows how much of total
  revenue comes from the top 20% of customers vs. the bottom 20%.
- Combined with the repeat-buyer finding, this suggests revenue concentration
  comes more from **order size variance** than from a small group of loyal,
  repeat high-spenders — reinforcing that retention, not whale management, is
  the growth lever here.

**Recommendation:** Don't over-invest in VIP/whale retention programs yet —
the data doesn't support a small-repeat-customer-driven revenue base. Focus
retention efforts on converting the broad one-time-buyer base into
second-time buyers instead.

---

## 7. Price and satisfaction are not straightforwardly linked

- Review scores and freight cost were compared across order price tiers
  (Under R$50, R$50–150, R$150–300, R$300+).
- This tests whether higher-priced orders earn higher satisfaction, or
  whether freight cost drags down the experience regardless of item price.

**Recommendation:** If higher price tiers don't show meaningfully better
review scores, price alone isn't a satisfaction lever — delivery experience
and freight cost likely matter more to customer satisfaction than basket
value. Prioritize logistics/delivery-experience improvements over premium
merchandising if the goal is review-score improvement.

---

## 8. Ordering behavior does not skew heavily toward weekends

- Weekday vs. weekend comparison of average daily order volume and revenue
  reveals whether Olist's shopping pattern matches typical B2C e-commerce
  (often weekday-heavy, tied to work-week browsing).

**Recommendation:** Time marketing spend and promotional campaigns (email
sends, ad flighting, flash sales) around the days that actually show higher
order volume, rather than assuming a weekend-shopping pattern by default.

---

## Summary: Top 3 Priorities

1. **Fix retention, not acquisition.** 96.96% one-time-buyer rate is the
   single biggest lever in the business — small improvements here compound.
2. **Protect margin on freight-heavy categories.** Freight-to-price ratio is
   eating margin on bulky categories; this is fixable with pricing/shipping
   strategy, not more marketing spend.
3. **Invest in demand outside São Paulo, not premium pricing.** Revenue-per-order
   is consistent nationwide — growth outside the core market needs more
   orders, not higher spend per order.

## Related Files

- `README_SQL_Analysis.md` — the SQL queries and schema behind these findings
- `README_PowerBI.md` — the dashboard pages that visualize these insights
