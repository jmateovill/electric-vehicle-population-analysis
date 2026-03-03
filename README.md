# Washington State Electric Vehicle Population Analysis
An End-to-End Analysis: From Data Cleaning to Market Intelligence

## Project Overview

This project investigates the adoption, technological evolution, and eligibility trends of the **Electric Vehicle (EV)** market in *Washington State*. Using a dataset of 150,000+ records, I navigated the full data lifecycle, from **initial cleaning** in **Excel** to complex relational querying in **SQL (SQLite)**, to uncover the narratives driving the shift toward electrification.

## Tech Stack

**Data Preparation:**   Microsoft Excel (`XLOOKUP`, Mapping Tables, Pivot Tables)

**Data Analysis:**  SQL (SQLite / DB Browser)

**Key Techniques:** Window Functions (`LAG`), CTEs, Conditional Aggregation, Implicit Casting.

## Part 1: The Excel Foundation

Before analysis, I built a **Scalable Data Pipeline** and **Interactive Dashboard** to resolve widespread naming inconsistencies and "False Zeros" in the dataset using [Microsoft Excel](excel/README.md).

![EVPD Excel Dashboard](excel/evpd-excel-dashboard-snap-1.png)

**Automated Standardization:** Utilized `XLOOKUP` with a central Mapping Table to fix ~7,600 "messed up" records (e.g., standardizing Bolt Ev to Bolt EV and Bz4x to bZ4X).

**Initial Finding:** Identified a 130% technological leap in average electric range in 2008, correlating to the introduction of high-capacity Lithium-Ion batteries from Tesla's Roadster model.

## Part 2: SQL Deep Dives

Transitioning to [SQLite](sql/), I performed advanced queries to analyze market velocity and segments.

![SQLite query preview](sql/evpd-preview.gif)

#### Adoption Velocity (YoY Growth):
- Focused on the Modern Era (2015–2025) to eliminate statistical noise from early outliers.
Insights: Traced the "Holy Trinity" of hybrid hypercars in 2015 and the mass-market explosion triggered by the Tesla Model 3 in 2017.
Technique: Used `LAG()` window functions to calculate the acceleration of adoption.
#### The PHEV Renaissance
- Analyzed the market share of Battery Electric (BEV) vs. Plug-in Hybrid (PHEV).
Insights: Discovered a massive second wind for PHEVs starting in 2020, driven by the SUV boom. The Jeep Wrangler 4xe emerged as a dominant market leader (2022–2024), proving that PHEVs are a preferred "bridge" for American SUV consumers.

## Data Limitations & Integrity (The "Eligibility Flaw")

A critical part of this analysis was uncovering the CAFV Eligibility Gap. While stakeholders rely on this data for incentive planning, the dataset contains a significant flaw:

The **"Unknown"** Majority: Over 63% of registered EVs are labeled with *"Unknown Eligibility."*

The **Cause**: This is primarily due to a 0-mile range representation in newer models (2021–2025) caused by shifting data maintenance policies and missing manufacturer technical specs.

The **Irony**: Tesla, despite its market dominance, holds the highest volume of "Unknown" records.

The **Reality**: Currently, only 28% of the dataset clearly reflects vehicles benefiting from CAFV incentives, suggesting that the data significantly underrepresents the actual number of eligible vehicles on the road.

## Key Findings

- Market Leadership: Tesla remains the volume leader, but the competitive landscape is shifting toward performance SUVs.

- Tech Maturity: Average battery range has evolved from a *"commuter niche"* (under 100 miles) to a "road-trip capable" standard (200+ miles).

- Incentive Gap: Data reporting lags are masking the true reach of tax incentives, creating a "blind spot" for policymakers. *(Which later on will be resolved in the 3rd part of the project, PowerBI)*

Part 3: PowerBI - *soon*

## Let's Connect!
- LinkedIn: [John Matthew Villanueva](https://www.linkedin.com/in/jmateovill/)
- Email: jmateo.vill@gmail.com