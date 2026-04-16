---
layout: default
title: 'GL Financial Statement and Drilldown (FSG) | Oracle EBS SQL Report'
description: 'The GL Financial Statement and Drilldown (FSG) Report empowers users to generate comprehensive reports on financial balances while providing detailed…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Financial, Statement, Drilldown, (FSG), dual'
permalink: /GL%20Financial%20Statement%20and%20Drilldown%20%28FSG%29/
---

# GL Financial Statement and Drilldown (FSG) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-financial-statement-and-drilldown-fsg/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
The GL Financial Statement and Drilldown (FSG) Report empowers users to generate comprehensive reports on financial balances while providing detailed insights through drilldown capabilities. This tool allows users to link Excel cells directly to Oracle data via built-in functions, ensuring that data can be refreshed as needed to reflect the most up-to-date information.
Key features include:
1. Balance and Detail Reporting: Generate high-level balance reports and drill down into the details, including journal entries and subledger transactions.
2. Oracle Data Integration: Seamlessly link Excel cells to Oracle data, with the ability to refresh the data for real-time updates.
3. Drilldown Functionality: Access detailed information at various levels, including balances, journal entries, and subledger details.
4. Migration Tools: Converters are available to migrate reports from Oracle FSG, GL Wand, and Spreadsheet Server to this solution.

For a quick demonstration, refer to our YouTube video.
<a href="https://youtu.be/dsRWXT2bem8" rel="nofollow" target="_blank">https://youtu.be/dsRWXT2bem8</a>

Important: Please do not delete the "Financial Statement Generator" sheet or modify the Advanced Custom Properties in the Excel output, as these are essential for the proper functioning of the report.

## Report Parameters
Ledger

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Financial Statement and Drilldown (FSG) - Income Summary Statement 04-Apr-2026 124502.xlsm](https://www.enginatics.com/example/gl-financial-statement-and-drilldown-fsg/) |
| Blitz Report™ XML Import | [GL_Financial_Statement_and_Drilldown_FSG.xml](https://www.enginatics.com/xml/gl-financial-statement-and-drilldown-fsg/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-financial-statement-and-drilldown-fsg/](https://www.enginatics.com/reports/gl-financial-statement-and-drilldown-fsg/) |

## GL Financial Statement and Drilldown (FSG) - Case Study & Technical Analysis

### Executive Summary
The **GL Financial Statement and Drilldown (FSG)** report is a powerful financial reporting tool designed to bridge the gap between static Oracle FSG reports and dynamic Excel-based analysis. It allows finance teams to generate comprehensive financial statements (Balance Sheets, Income Statements) directly in Excel with the ability to drill down from high-level balances to individual journal lines and subledger details. This tool often serves as a modern alternative to the traditional Financial Statement Generator (FSG) or third-party tools like GL Wand, offering real-time data integration.

### Business Use Cases
*   **Financial Reporting Package**: Automates the creation of monthly board packs and management accounts by linking Excel templates directly to live Oracle GL data.
*   **Ad-Hoc Analysis**: Enables financial analysts to quickly query account balances and investigate variances without running multiple static concurrent requests.
*   **Reconciliation**: Facilitates the reconciliation of GL balances to subledger transactions by providing an immediate drill-down path to the source data.
*   **Migration Strategy**: Acts as a destination format for migrating legacy FSG reports or reports from other Excel-based tools (Spreadsheet Server, GL Wand) into a unified reporting platform.
*   **Audit Support**: Provides auditors with a transparent view of financial figures, allowing them to trace reported numbers back to the underlying transactions efficiently.

### Technical Analysis

#### Core Tables
*   `GL_BALANCES`: The primary source for account balance information.
*   `GL_JE_LINES`: Accessed during the drill-down process to show transaction details.
*   `GL_CODE_COMBINATIONS`: Used to resolve account segments.
*   `GL_LEDGERS`: Defines the ledger context for the report.
*   *(Note: The report logic is likely encapsulated in a PL/SQL package or complex view to handle the dynamic nature of FSG row/column definitions, hence the reference to `dual` in some documentation).*

#### Key Joins & Logic
*   **Dynamic Row/Column Construction**: Unlike standard SQL reports, this tool likely interprets FSG row and column set definitions to construct the grid dynamically in Excel.
*   **Balance Aggregation**: It aggregates data from `GL_BALANCES` based on the period, currency, and actual_flag parameters.
*   **Drill-down Mechanism**: The "drill-down" capability is typically implemented via hyperlinks or connected queries that pass the context (Period, Account, Ledger) of the selected cell to a secondary query that fetches the journal lines (`GL_JE_LINES`) and subledger details.

#### Key Parameters
*   **Ledger**: The financial entity to report on.
*   **Period**: The accounting period for the report.
*   **Currency**: The currency view (Entered, Accounted, or Translated).
*   **Content Set**: (Optional) Used to override segment values or expand the report across segment ranges.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
