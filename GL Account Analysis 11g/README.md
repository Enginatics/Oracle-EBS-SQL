---
layout: default
title: 'GL Account Analysis 11g | Oracle EBS SQL Report'
description: 'Backwards compatible version (for 11g databases) of the detail GL transaction report with one line per transaction including all segments and subledger…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Account, Analysis, 11g, ra_rules, ra_customer_trx_lines_all, hz_cust_accounts'
permalink: /GL%20Account%20Analysis%2011g/
---

# GL Account Analysis 11g – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-11g/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Backwards compatible version (for 11g databases) of the detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.

## Report Parameters
Ledger, Period, Period From, Period To, Posted Date From, Posted Date To, Journal Source, Journal Category, Batch, Journal, Journal Line, Account Type, Hierarchy Segment, Hierarchy Name, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Status, Transaction Currency, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Show Segments with Descriptions

## Oracle EBS Tables Used
[ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=fa_deprn_detail), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [pa_draft_revenues_all](https://www.enginatics.com/library/?pg=1&find=pa_draft_revenues_all), [pa_agreements_all](https://www.enginatics.com/library/?pg=1&find=pa_agreements_all), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-account-analysis-11g/) |
| Blitz Report™ XML Import | [GL_Account_Analysis_11g.xml](https://www.enginatics.com/xml/gl-account-analysis-11g/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-account-analysis-11g/](https://www.enginatics.com/reports/gl-account-analysis-11g/) |

## GL Account Analysis 11g - Case Study & Technical Analysis

### Executive Summary
The **GL Account Analysis 11g** report is a specialized version of the standard General Ledger account analysis tool, optimized for Oracle E-Business Suite environments running on Oracle Database 11g. It provides a detailed, transaction-level view of GL activity, linking journal entries back to their subledger sources (AP, AR, PO, etc.). This report ensures that organizations on older database versions can still access high-performance, granular financial data without compatibility issues.

### Business Challenge
Financial analysis often requires drilling down from a GL balance to the individual transactions that comprise it.
- **Database Compatibility:** Newer reports often utilize SQL features specific to Oracle Database 12c or 19c, breaking functionality for legacy 11g environments.
- **Data Linearity:** Tracing a GL journal line back to the specific invoice, receipt, or purchase order involves navigating complex data models (SLA, Subledger tables).
- **Currency Visibility:** Analysts need to see amounts in both the entered transaction currency and the accounted ledger currency to reconcile foreign exchange differences.
- **Performance:** Querying millions of journal lines and joining them to subledger details can be extremely slow without optimized SQL.

### Solution
The **GL Account Analysis 11g** report bridges the gap between the General Ledger and subledgers, providing a unified view of financial transactions. It is specifically engineered to perform efficiently on the 11g optimizer.

**Key Features:**
- **11g Compatibility:** Uses SQL syntax and hints optimized for the 11g cost-based optimizer.
- **Subledger Drilldown:** Automatically links GL journals to their source documents in AP, AR, FA, PO, Projects, and Inventory.
- **Full Segment Detail:** Displays all accounting flexfield segments for detailed analysis.
- **Dual Currency:** Shows both entered and accounted amounts.
- **Flexible Filtering:** Allows filtering by Date Range, Period, Account Segments, Source, and Category.

### Technical Architecture
The report uses a "star" query approach or optimized joins starting from `GL_JE_LINES` and `XLA_AE_LINES` to fetch subledger details.

#### Key Tables and Views
- **`GL_JE_HEADERS` & `GL_JE_LINES`**: The core General Ledger journal tables.
- **`GL_IMPORT_REFERENCES`**: The bridge table linking GL lines to Subledger Accounting (SLA) lines.
- **`XLA_AE_HEADERS` & `XLA_AE_LINES`**: The Subledger Accounting repository, which holds the detailed accounting entries.
- **`XLA_TRANSACTION_ENTITIES`**: Links SLA entries to the source transaction tables.
- **Subledger Tables**:
    - **AP**: `AP_INVOICES_ALL`, `AP_CHECKS_ALL`, `AP_SUPPLIERS`
    - **AR**: `RA_CUSTOMER_TRX_ALL`, `AR_CASH_RECEIPTS_ALL`, `HZ_CUST_ACCOUNTS`
    - **FA**: `FA_ADDITIONS_B`, `FA_TRANSACTION_HEADERS`
    - **PO**: `PO_HEADERS_ALL`, `RCV_TRANSACTIONS`
    - **PA**: `PA_PROJECTS_ALL`, `PA_EXPENDITURE_ITEMS_ALL`

#### Core Logic
1.  **GL Selection:** Selects journal lines from `GL_JE_LINES` based on the period and account filters.
2.  **SLA Linkage:** Joins to `GL_IMPORT_REFERENCES` and then `XLA_AE_LINES` to find the subledger entry.
3.  **Source Identification:** Uses the `ENTITY_CODE` and `SOURCE_ID_INT_1` from `XLA_TRANSACTION_ENTITIES` to determine the source system (e.g., 'AP_INVOICES').
4.  **Conditional Joins:** Dynamically joins to the appropriate subledger tables (e.g., if Source is AP, join to `AP_INVOICES_ALL`) to retrieve document numbers, dates, and descriptions.
5.  **11g Optimization:** May use specific optimizer hints (like `/*+ LEADING(gl) USE_NL(xla) */`) to ensure the execution plan remains efficient on the older database engine.

### Business Impact
- **Legacy Support:** Extends the lifespan of reporting capabilities for organizations not yet upgraded to the latest database versions.
- **Audit Trail:** Provides a complete, unbroken audit trail from financial statements down to source documents.
- **Reconciliation:** Simplifies the reconciliation of subledger modules to the General Ledger.
- **Operational Insight:** Gives finance users immediate access to transaction details without needing to navigate through multiple Oracle forms.


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
