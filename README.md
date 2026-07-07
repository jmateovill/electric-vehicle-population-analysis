# Washington State Electric Vehicle Population Analysis

**An end-to-end data analysis project — from raw data cleanup to executive-level business intelligence reporting.**

---

## 📌 Table of Contents

- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tools & Technologies](#tools--technologies)
- [Project Architecture](#project-architecture)
- [Key Features & Findings](#key-features--findings)
  - [Part 1: The Excel Foundation](#part-1-the-excel-foundation)
  - [Part 2: SQL Deep Dives](#part-2-sql-deep-dives)
  - [Part 3: Power BI Executive Dashboard](#part-3-power-bi-executive-dashboard)
- [Skills Demonstrated](#skills-demonstrated)
- [How to Use](#how-to-use)
- [A Note on AI Assistance](#a-note-on-ai-assistance)
- [Author](#author)

---

## Project Overview

This project is a full-cycle analysis of the electric vehicle (EV) population registered with the **Washington State Department of Licensing (DOL)**, using a public dataset of 240,000+ records. I wanted a portfolio project that didn't stop at "make a chart" — instead, it walks through the same pipeline a working data analyst would use: cleaning messy real-world data, querying it for insight, and packaging findings into a decision-ready dashboard.

The project moves through three connected phases, each handled with a different tool in a typical analytics stack:

1. **Excel** — data cleaning, standardization, and an interactive dashboard
2. **SQL (SQLite)** — deeper querying, trend analysis, and data integrity investigation
3. **Power BI** — an executive-facing dashboard built on top of the cleaned SQL data, designed for a policy/government audience

The throughline across all three phases is the story of EV adoption in Washington State: how the market grew, which vehicle types and manufacturers led that growth, and where the underlying data itself falls short of giving policymakers a full picture.

## Objectives

- Clean and standardize a real-world government dataset containing inconsistent naming conventions and misleading zero-values
- Build a reusable, rule-based data pipeline (rather than one-off manual fixes) so the cleaning logic could scale to new data
- Use SQL to analyze adoption velocity, market segmentation, and vehicle eligibility trends over time
- Identify and quantify a data quality issue (the "CAFV Eligibility Gap") that affects how usable the dataset is for real decision-making
- Translate raw findings into a business intelligence dashboard tailored to a specific audience (policymakers), with KPIs and visuals chosen deliberately for that audience
- Demonstrate a complete, tool-diverse analytics workflow: spreadsheet, database, and BI layer, connected end-to-end rather than siloed

## Tools & Technologies

**Data Preparation:** Microsoft Excel — `XLOOKUP`, mapping tables, Pivot Tables

**Data Analysis:** SQL (SQLite, queried via DB Browser for SQLite), Microsoft Excel Pivot Tables

**Data Visualization / BI:** Microsoft Excel (interactive dashboard), Microsoft Power BI (executive dashboard), Power Query, DAX

**Connectivity:** SQLite3 ODBC Driver (used to connect Power BI directly to the SQLite database rather than a static CSV import)

**Key Techniques:** Data cleaning and standardization, Pivot Tables, SQL window functions (`LAG()`), Common Table Expressions (CTEs), conditional aggregation, implicit type casting, data pipeline design, data storytelling, business intelligence dashboard design

## Project Architecture

The project is structured as a linear pipeline, with each stage's output feeding the next:

```
Raw DOL Dataset (240,000+ records)
        │
        ▼
[1] Excel — Data Cleaning & Standardization
    • XLOOKUP + central mapping table to fix ~7,600 inconsistent records
    • Resolves "false zero" values and naming mismatches
    • Output: interactive Excel dashboard
        │
        ▼
[2] SQL (SQLite) — Analysis & Data Integrity Review
    • CTEs and window functions for year-over-year adoption trends
    • Segmentation of BEV vs. PHEV market share
    • Investigation of the CAFV eligibility data gap
        │
        ▼
[3] Power BI — Executive Dashboard
    • Connects directly to SQLite via ODBC (not a flat CSV import)
    • Structured SQL View built specifically as the BI data source
    • DAX-driven KPIs and visuals for a policymaker audience
```

Repository layout:

```
├── data/       # Source and supporting data files
├── excel/      # Cleaning pipeline, mapping tables, interactive dashboard
├── sql/        # SQLite database, queries, and query preview
├── powerbi/    # Power BI dashboard file and related assets
└── README.md
```

Each subfolder (`excel/`, `sql/`, `powerbi/`) has its own README with tool-specific detail.

## Key Features & Findings

> Since the Power BI dashboard was built in the free version of Power BI Desktop, it isn't published/live. The previews below (screenshot, GIF, and video) stand in for that interactive experience.

### Part 1: The Excel Foundation

Before any analysis, the raw dataset needed to be trustworthy. I built a rule-based cleaning pipeline in Excel using `XLOOKUP` against a central mapping table to standardize ~7,600 inconsistent records — for example, normalizing entries like "Bolt Ev" to "Bolt EV" and "Bz4x" to "bZ4X" — and to resolve "false zero" values that would otherwise distort range calculations. That cleaned data fed directly into an interactive Pivot Table dashboard.

![EVPD Excel Dashboard](https://github.com/jmateovill/electric-vehicle-population-analysis/raw/main/excel/evpd-excel-dashboard-snap-1.png)
*Interactive Excel dashboard built on the cleaned dataset, using Pivot Tables and Pivot Charts.*

**Initial finding:** average electric range jumped roughly 130% in 2008, correlating with the introduction of high-capacity lithium-ion batteries in Tesla's Roadster — an early signal of the technological shift the rest of the analysis would trace.

### Part 2: SQL Deep Dives

With clean data in hand, I moved to SQLite (queried via DB Browser for SQLite) to dig into adoption trends, market segmentation, and the dataset's own blind spots.

![SQLite query preview](https://github.com/jmateovill/electric-vehicle-population-analysis/raw/main/sql/evpd-preview.gif)
*Preview of the SQL querying process — CTEs and window functions used to analyze adoption trends.*

**Adoption velocity (year-over-year growth):** I focused on the modern era (2015–2025) to filter out early statistical noise, using `LAG()` window functions to measure the pace of adoption. The data traces an early wave of hybrid hypercars in 2015, followed by a mass-market surge after the Tesla Model 3 launched in 2017.

**The PHEV renaissance:** segmenting Battery Electric Vehicles (BEVs) against Plug-in Hybrids (PHEVs) revealed a second wind for PHEVs starting in 2020, driven by the SUV segment — with the Jeep Wrangler 4xe emerging as a market leader from 2022–2024. This suggests PHEVs serve as a "bridge" technology for SUV buyers not yet ready for full electric.

**The CAFV Eligibility Gap:** a core part of this phase was investigating a real data integrity issue. Over 63% of registered EVs are labeled "Unknown Eligibility" for Clean Alternative Fuel Vehicle (CAFV) incentives — largely because newer models (2021–2025) report a 0-mile electric range due to missing manufacturer specs, not an actual lack of range. Tesla, despite being the volume leader, also holds the highest count of "Unknown" records. Only about 28% of the dataset clearly reflects vehicles that qualify for CAFV incentives, meaning the true number of eligible vehicles is likely underrepresented in official reporting — a blind spot for policymakers that the Power BI phase set out to address.

### Part 3: Power BI Executive Dashboard

The final phase packages these findings into an **Executive Overview** dashboard built for a policy/government audience making decisions around EV incentive programs.

<video src="https://github.com/user-attachments/assets/292f0fc8-06a5-4dc4-b669-2cc0f5df395f" width="320" height="240" controls></video>
*Walkthrough of the Power BI Executive Overview dashboard.*

To emulate a real-world analyst workflow rather than a static import, I connected Power BI directly to the SQLite database via the **SQLite3 ODBC Driver**, built on top of a structured SQL View created specifically as the BI data source.

**Solving the eligibility gap:** for newer BEVs, I set the 0-mile range values to `NULL` so they wouldn't distort average range calculations, while still counting those vehicles toward total CAFV-eligible EVs — a practical fix for the reporting distortion uncovered in Part 2. A tooltip/help icon also surfaces an important disclosure note from the Washington State Open Data team, who maintain the source dataset.

**KPI selection:** I chose three KPIs to match how a policymaker would actually think about this data — **Total EVs** (how many people have adopted EVs), **Eligibility %** (how many owners are actually receiving incentives), and **Average Electric Range** (how capable is the current EV fleet).

**Visualization choices:** rather than defaulting to generic charts, each visual was picked to match its question — a **stacked area graph** to compare BEV vs. PHEV population growth by model year, a **100% stacked area chart** (instead of a pie chart) to show eligibility ratio by year, a **treemap** to show which manufacturers dominate the market, and a **map** to show geographic concentration of registered EVs.

## Skills Demonstrated

- **Data cleaning & transformation:** identifying and correcting ~7,600 inconsistent records using rule-based mapping rather than manual edits
- **Spreadsheet engineering:** `XLOOKUP`, Pivot Tables, and interactive dashboard design in Excel
- **SQL querying:** CTEs, window functions (`LAG()`), conditional aggregation, and implicit casting in SQLite
- **Data integrity analysis:** diagnosing a systemic gap in a government dataset and quantifying its real-world impact
- **BI tool integration:** connecting Power BI to a SQL database via ODBC and a structured view, rather than relying on flat file imports — mirroring how this connection is typically handled in a real analytics environment
- **Dashboard/data storytelling design:** selecting KPIs and chart types (stacked area, 100% stacked area, treemap, map) based on the needs of a specific stakeholder audience
- **Audience-aware communication:** framing the same dataset differently for an internal working dashboard (Excel) vs. an executive-facing summary (Power BI)

## How to Use

1. Clone the repository:
   ```
   git clone https://github.com/jmateovill/electric-vehicle-population-analysis.git
   ```
2. **Excel dashboard:** open the files in the `excel/` folder in Microsoft Excel to explore the cleaning pipeline and interactive dashboard.
3. **SQL analysis:** open the database in `sql/` using DB Browser for SQLite (or any SQLite-compatible client) to run and inspect the analytical queries.
4. **Power BI dashboard:** open the `.pbix` file in the `powerbi/` folder using Microsoft Power BI Desktop. Note that reconnecting to the live SQLite source requires the SQLite3 ODBC Driver configured locally; the dashboard's visuals and data can otherwise be viewed as-is, or via the video preview above.

Each subfolder README includes tool-specific setup notes and additional context.

## A Note on AI Assistance

The data cleaning, SQL queries, Excel dashboard, and Power BI report in this project were built by me. This README was drafted with the help of an AI writing assistant to help organize and present the project clearly, based on my original repository content and my own answers about the project's goals and audience — the analysis and technical work itself are my own.

## Author

**John Matthew Villanueva**

- LinkedIn: [jmateovill](https://www.linkedin.com/in/jmateovill/)
- Email: jmateo.vill@gmail.com / jmateo.vill@hotmail.com

If this project is useful or interesting to you, feel free to reach out — I'm open to questions, feedback, and job opportunities.
