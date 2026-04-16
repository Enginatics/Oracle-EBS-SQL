---
layout: default
title: 'GL Journal Upload | Oracle EBS SQL Report'
description: 'GL Journal Upload Templates are provided for the following Journal Types - Functional Actuals - Foreign Actuals - Budget Journals - Encumbrance Journals…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Journal, dual'
permalink: /GL%20Journal%20Upload/
---

# GL Journal Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-journal-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
GL Journal Upload

Templates are provided for the following Journal Types
- Functional Actuals
- Foreign Actuals
- Budget Journals
- Encumbrance Journals

Submit for Approval
---------------------------
Imported Journals requiring approval can be submitted for approval after import if they are eligble.

Submit Journal Post
---------------------------
Imported Journals can be submitted for immediate posting after import if they are eligible.
In order to submit journals for posting, the current responsibility must have access to post journals.

## Report Parameters
Journal Type, Allow Foreign Currency, Attach Upload file to Journal, Submit for Approval, Submit Journal Post, Check if Journal Balanced

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Journal Upload - Functional Actuals (with attachment) 25-Mar-2026 142142.xlsm](https://www.enginatics.com/example/gl-journal-upload/) |
| Blitz Report™ XML Import | [GL_Journal_Upload.xml](https://www.enginatics.com/xml/gl-journal-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-journal-upload/](https://www.enginatics.com/reports/gl-journal-upload/) |

## GL Journal Upload - Case Study & Technical Analysis

### Executive Summary
The **GL Journal Upload** is a productivity tool and interface designed to streamline the creation of General Ledger journal entries from Excel. It serves as a robust alternative to the standard Oracle WebADI (Web Applications Desktop Integrator), offering templates for various journal types including Functional Actuals, Foreign Actuals, Budgets, and Encumbrances. It supports advanced features like attachment handling, approval submission, and automated posting.

### Business Use Cases
*   **Month-End Accruals**: Enables finance users to quickly upload large batches of month-end accrual journals from Excel calculations.
*   **Budget Loading**: Facilitates the upload of budget data prepared in Excel models directly into Oracle GL.
*   **Intercompany Transactions**: Streamlines the entry of complex intercompany journals that may involve multiple lines and currency conversions.
*   **Data Migration**: Used during implementations to load historical balances or open conversion balances.
*   **Process Efficiency**: Reduces manual data entry errors and processing time compared to entering journals form-by-form in the Oracle application.

### Technical Analysis

#### Core Tables
*   `GL_INTERFACE`: The standard open interface table where journal data is staged.
*   `GL_JE_BATCHES`: The destination table for created journal batches.
*   `GL_JE_HEADERS`: The destination table for created journal headers.
*   `GL_JE_LINES`: The destination table for created journal lines.
*   `GL_DAILY_RATES`: Accessed if foreign currency conversion is required.

#### Key Joins & Logic
*   **Interface Processing**: The tool inserts data into `GL_INTERFACE` and then typically triggers the standard "Journal Import" concurrent program (`GLLEZL`) to validate and import the data into the core GL tables.
*   **Validation**:
    *   Validates the `CODE_COMBINATION_ID` or segment values against the Chart of Accounts.
    *   Checks that the accounting period is open.
    *   Verifies that the journal balances (Debits = Credits) if the "Check if Journal Balanced" parameter is enabled.
*   **Post-Import Actions**: The tool includes logic to automatically submit the "Posting" program or the "Approval" workflow based on the user's parameter selection.

#### Key Parameters
*   **Journal Type**: Specifies the template/logic to use (Functional, Foreign, Budget, Encumbrance).
*   **Allow Foreign Currency**: Enables the entry of currency codes and conversion rates.
*   **Attach Upload file**: A feature to attach the source Excel file to the created Journal Header in Oracle for audit purposes.
*   **Submit for Approval**: Triggers the GL Journal Approval workflow.
*   **Submit Journal Post**: Triggers the posting process immediately after import.


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
