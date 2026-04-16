---
layout: default
title: 'GL Account Analysis (Distributions) | Oracle EBS SQL Report'
description: 'Detailed GL transaction report with one line per distribution including all segments and subledger data, with amounts in both transaction currency and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Account, Analysis, (Distributions), fnd_flex_value_norm_hierarchy, gl_code_combinations_kfv, gl_je_categories_vl'
permalink: /GL%20Account%20Analysis%20%28Distributions%29/
---

# GL Account Analysis (Distributions) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-distributions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detailed GL transaction report with one line per distribution including all segments and subledger data, with amounts in both transaction currency and ledger currency.
The report includes VAT tax codes and rates for AR and AP transactions.

## Report Parameters
Ledger, Period, Period From, Period To, Posted Date From, Posted Date To, Journal Source, Journal Category, Batch, Journal, Journal Line, Tax Rate Code, Account Type, Hierarchy Segment, Hierarchy Name, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Status, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Exclude Zero Amount Lines, Show Segments with Descriptions, Show Open/Close Balances, Show Sub Ledger Contra Accounts, Show Journal Line DFF Attributes, Show Invoice DFF Attributes, Relative Period, Relative Period From, Relative Period To

## Oracle EBS Tables Used
[fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [zx_lines](https://www.enginatics.com/library/?pg=1&find=zx_lines), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Account Analysis (Distributions) - Pivot by Hierarchy 06-Nov-2024 002926.xlsx](https://www.enginatics.com/example/gl-account-analysis-distributions/) |
| Blitz Report™ XML Import | [GL_Account_Analysis_Distributions.xml](https://www.enginatics.com/xml/gl-account-analysis-distributions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-account-analysis-distributions/](https://www.enginatics.com/reports/gl-account-analysis-distributions/) |

## Case Study & Technical Analysis: GL Account Analysis (Distributions)

### Executive Summary
The **GL Account Analysis (Distributions)** report is a critical financial tool designed to provide a granular view of General Ledger transactions. It bridges the gap between high-level GL balances and detailed subledger activities, offering finance teams complete visibility into their accounting data. By presenting one line per distribution with all segments and subledger details, it facilitates accurate reconciliation and in-depth financial analysis.

### Business Challenge
Financial departments often face significant challenges when trying to reconcile General Ledger balances with underlying subledger transactions. Standard reports may aggregate data, obscuring the details needed to investigate discrepancies. This lack of visibility forces analysts to rely on manual, time-consuming processes involving multiple data dumps and Excel lookups, increasing the risk of errors and delaying financial close cycles. Furthermore, tracking tax details and ensuring compliance across AP and AR transactions can be cumbersome without a unified view.

### The Solution
This Blitz Report solution addresses these challenges by providing a comprehensive operational view of GL transactions. It extracts detailed data at the distribution level, including:
*   **Full Account Visibility**: Displays all accounting segments and descriptions.
*   **Subledger Integration**: Links GL entries back to their source in AP, AR, and FA, including invoice and payment details.
*   **Multi-Currency Support**: Shows amounts in both transaction and ledger currencies.
*   **Tax Detail**: Includes VAT tax codes and rates for AR and AP transactions, aiding in tax reporting and compliance.

By consolidating this information into a single, drill-down capable report, it significantly reduces the time required for reconciliation and audit activities.

### Technical Architecture (High Level)
The report is built on a robust SQL architecture that joins core General Ledger tables with Subledger Accounting (SLA) and specific module tables.

#### Primary Tables
*   `GL_CODE_COMBINATIONS_KFV`: Stores the accounting flexfield structures and segment values.
*   `GL_JE_CATEGORIES_VL`: Provides category names for journal entries.
*   `ZX_LINES`: Contains tax line details for transaction analysis.
*   `AP_INVOICES_ALL` & `AP_INVOICE_PAYMENTS_ALL`: Source tables for Accounts Payable data.
*   `RA_CUSTOMER_TRX_LINES_ALL` & `AR_PAYMENT_SCHEDULES_ALL`: Source tables for Accounts Receivable data.
*   `FA_DISTRIBUTION_HISTORY`: Links Fixed Assets distributions.
*   `XLA_EVENT_TYPES_TL`: Captures Subledger Accounting event types.

#### Logical Relationships
The query starts from the General Ledger journal lines and joins to `GL_CODE_COMBINATIONS` to resolve account segments. It then leverages the `JE_SOURCE` and `JE_CATEGORY` to conditionally link to respective subledger tables (AP, AR, FA) using reference columns (e.g., `REFERENCE_1`, `REFERENCE_2`). This allows the report to dynamically pull relevant details like Invoice Number or Customer Name depending on the transaction source.

### Parameters & Filtering
The report offers a wide range of parameters to allow users to slice and dice data effectively:
*   **Period & Date Ranges**: Filter by `Period`, `Posted Date`, or `Relative Period` to focus on specific financial cycles.
*   **Account Segments**: Parameters for `GL_SEGMENT1` through `GL_SEGMENT10` (and ranges) allow precise filtering by Company, Cost Center, Account, etc.
*   **Journal Attributes**: Filter by `Journal Source`, `Journal Category`, `Batch`, and `Journal` name to isolate specific entry types.
*   **Display Options**: Toggles like `Show Segments with Descriptions` and `Show Sub Ledger Contra Accounts` let users customize the output format for their specific analysis needs.

### Performance & Optimization
This report is optimized for performance in high-volume Oracle EBS environments:
*   **Direct Database Extraction**: It bypasses the heavy XML parsing layer often used in standard BI Publisher reports, delivering data directly to Excel.
*   **Indexed Retrievals**: The query utilizes standard indexes on `CODE_COMBINATION_ID`, `PERIOD_NAME`, and `JE_HEADER_ID` to ensure fast execution even when querying large date ranges.
*   **Efficient Joins**: Subledger tables are joined only when necessary based on the journal source, minimizing the processing load for non-relevant data.

### FAQ
**Q: Does this report show the original transaction currency?**
A: Yes, the report includes columns for amounts in both the original transaction currency and the functional ledger currency.

**Q: Can I use this report to reconcile tax amounts?**
A: Absolutely. The report includes specific columns for Tax Rate Codes and amounts derived from `ZX_LINES`, making it suitable for VAT and tax reconciliation.

**Q: How do I see the description for each account segment?**
A: You can enable the "Show Segments with Descriptions" parameter to include descriptive names alongside the segment codes in the output.


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
