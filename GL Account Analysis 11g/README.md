---
layout: default
last_modified_at: 2026-10-16
title: 'GL Account Analysis 11g | Oracle EBS SQL Report'
description: 'Backwards compatible version (for 11g databases) of the detail GL transaction report with one line per transaction including all segments and subledger…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Account, Analysis, 11g, ra_rules, ra_customer_trx_lines_all, hz_cust_accounts'
permalink: /GL%20Account%20Analysis%2011g/
report_name: 'GL Account Analysis 11g'
report_web_name: gl-account-analysis-11g
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Account Analysis 11g – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Backwards compatible version (for 11g databases) of the detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Period, Period From, Period To, Posted Date From, Posted Date To, Journal Source, Journal Category, Batch, Journal, Journal Line, Account Type, Hierarchy Segment, Hierarchy Name, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Status, Transaction Currency, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Show Segments with Descriptions

## Oracle EBS Tables Used
[ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=fa_deprn_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_draft_revenues_all](https://www.enginatics.com/library/?pg=1&find=pa_draft_revenues_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_agreements_all](https://www.enginatics.com/library/?pg=1&find=pa_agreements_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)

## Related Reports
[GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Analysis%2011g/GL%20Account%20Analysis%2011g.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-account-analysis-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) |
| Blitz Report™ XML Import | [GL_Account_Analysis_11g.xml](https://www.enginatics.com/xml/gl-account-analysis-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) |
| SQL Source | [GL Account Analysis 11g.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Analysis%2011g/GL%20Account%20Analysis%2011g.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-account-analysis-11g/](https://www.enginatics.com/reports/gl-account-analysis-11g/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-11g)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
