# SQL Proof Point: Olist Delivery Performance & Retention Analysis

## Business question (locked)
Which sellers and regions are underperforming on delivery time, and how is that
impacting review scores and repeat-purchase behavior?

This is the anchor for every query in this project. Every step should build toward
answering it — not general EDA.

## Dataset
Olist Brazilian E-Commerce Public Dataset (Kaggle: olistbr/brazilian-ecommerce)
9 CSVs: orders, order_items, order_payments, order_reviews, customers, sellers,
products, product_category_name_translation, geolocation

## Language constraint: SQL-only, no Python
This project exists to be a clean, unambiguous SQL proof point — distinct from the
Python-heavy work elsewhere in the portfolio (BioBERT, KKBox, FAERS). Python should
not appear anywhere in this repo.
- Data loading: `psql \copy` or `COPY`, not pandas/scripts
- Query writing/running: raw SQL via psql or a client (DBeaver/pgAdmin)
- Validation spot-checks: SQL (`SELECT * ... LIMIT`), not notebook cells
- If a chart is wanted for the README, build it manually from query output
  (spreadsheet or BI tool) rather than reaching for matplotlib/pandas

## Ownership legend
🤖 Agent-owned (Antigravity can execute directly)
🧠 Usman-owned (core learning — agent should NOT complete this silently)
🤝 Joint (agent proposes, Usman reviews/approves before proceeding)

---

## Step 1 — Environment & ingestion 🤖
- Set up PostgreSQL instance (local or cloud)
- Download Olist CSVs, create schema, load all 9 tables
- Verify row counts against Kaggle documentation as a sanity check
- Confirm foreign key relationships resolve cleanly (no orphaned IDs) before proceeding

## Step 2 — Schema & relationship mapping 🧠
- Usman draws the ER diagram by hand (or in a tool) from the 9 tables, tracing how
  orders → order_items → sellers/products, and orders → reviews/payments connect
- Goal: Usman can explain the join path for any two tables without looking it up
- Agent should NOT pre-generate this diagram — check Usman's version against the
  actual schema and flag errors only

## Step 3 — Query scoping 🤝
- Agent proposes a list of ~8-10 candidate queries that would answer the business
  question (delivery time by seller/region, review score correlation, repeat
  purchase rate by delivery speed tier, etc.)
- Usman reviews and cuts/reorders based on what's actually needed to answer the
  question — avoid scope creep into unrelated exploration

## Step 4 — Core query writing 🧠 (agent checks, doesn't write first)
For each locked query, Usman writes the SQL first. Required techniques across the
set (not every query needs all of these, but the set as a whole must include):
  - Multi-table joins (3+ tables)
  - CTEs for staged logic
  - Window functions (ROW_NUMBER, LAG/LEAD, running totals) — e.g. ranking sellers
    by delivery delay, or computing days-since-last-order per customer
  - Subqueries (correlated or not) — e.g. flagging orders above average delay for
    their region
- Agent reviews each query for correctness and efficiency, explains issues rather
  than rewriting silently

## Step 5 — Validation against ground truth 🤝
- Before trusting any result, spot-check manually against a handful of raw rows
  (per Usman's standing rule: verify before committing)
- Flag any query returning suspiciously clean or suspiciously null results

## Step 6 — Synthesis into business recommendation 🧠
- Usman writes a short (half-page) summary: which sellers/regions are the problem,
  what the review/retention impact looks like, and what action Olist should take
- This is the STAR-method payoff — not a list of query outputs, but a recommendation

## Step 7 — Repo & documentation 🤖
- Structure repo: /sql (query files, numbered and commented), /docs (ER diagram,
  findings summary), README with business question, method, and headline finding
- README should lead with the business question and the one-line answer, not a
  tool inventory

## Verification checkpoints (confirm before marking done)
- [ ] Row counts post-load match Kaggle source
- [ ] No orphaned foreign keys across joins
- [ ] Every required technique (joins, CTEs, window functions, subqueries) appears
      at least once and is explainable by Usman without notes
- [ ] Findings spot-checked against raw data, not just trusted from query output
- [ ] README leads with business question + recommendation, not just schema/tools
