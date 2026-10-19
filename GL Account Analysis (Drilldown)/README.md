---
layout: default
last_modified_at: 2026-10-19
title: 'GL Account Analysis (Drilldown) | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. Detail GL transaction report with one line per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Account, Analysis, (Drilldown), ra_rules, ra_customer_trx_lines_all, xla_distribution_links'
permalink: /GL%20Account%20Analysis%20%28Drilldown%29/
report_name: 'GL Account Analysis (Drilldown)'
report_web_name: gl-account-analysis-drilldown
---

# GL Account Analysis (Drilldown) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown).

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. **

Detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.
For drilldown to the transaction screen please ensure the column View Transaction is present in the Displayed Columns
View Transaction

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Ledger ID, Period, Status, Journal Source, Journal Category, Batch, Batch ID, Journal, Journal Header ID, Journal Line Num, Concatenated Segments, Restrict CCIDs through GTT, Restrict JHI through GTT, Balance Type, Budget Name, Encumbrance Type, Show Segments with Descriptions, Journal Line DFF Display

## Oracle EBS Tables Used
[ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_draft_revenues_all](https://www.enginatics.com/library/?pg=1&find=pa_draft_revenues_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_agreements_all](https://www.enginatics.com/library/?pg=1&find=pa_agreements_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Analysis%20%28Drilldown%29/GL%20Account%20Analysis%20%28Drilldown%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-account-analysis-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) |
| Blitz Report™ XML Import | [GL_Account_Analysis_Drilldown.xml](https://www.enginatics.com/xml/gl-account-analysis-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) |
| SQL Source | [GL Account Analysis (Drilldown).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Analysis%20%28Drilldown%29/GL%20Account%20Analysis%20%28Drilldown%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-account-analysis-drilldown/](https://www.enginatics.com/reports/gl-account-analysis-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown) |

## GL Account Analysis (Drilldown) - Case Study & Technical Analysis

### Executive Summary

The **GL Account Analysis (Drilldown)** report is a pivotal component of the Oracle E-Business Suite financial reporting ecosystem. It is specifically engineered to serve as the drilldown target for the **GL Financial Statement and Drilldown (FSG)** report. This report bridges the gap between high-level financial statements and the granular subledger transactions that comprise them, providing finance teams with immediate access to the "why" behind the numbers.

By enabling users to navigate from a summarized FSG line item directly to the underlying journal lines and subledger details, this report significantly reduces the time required for variance analysis, auditing, and period-close reconciliation.

### Business Challenge

Financial statements provide a summarized view of an organization's health, but they often lack the detail needed to investigate anomalies. When a variance is detected in an FSG report, analysts typically face:

*   **Disconnected Data:** The need to run separate, static reports to find supporting details.
*   **Time-Consuming Analysis:** Manual correlation of account balances with journal entries.
*   **Lack of Traceability:** Difficulty in linking a specific financial statement line back to the original operational transaction (e.g., an AP invoice or AR receipt).

### The Solution

The **GL Account Analysis (Drilldown)** report solves these issues by integrating directly with the FSG reporting workflow. It acts as a dynamic detailed view that can be invoked from a summary report, providing a seamless analytical path.

#### Key Features:

*   **FSG Integration:** Designed to be the destination for drilldown actions from high-level financial statements.
*   **Subledger Visibility:** Exposes the specific subledger transactions (invoices, payments, etc.) associated with GL balances.
*   **Context-Aware:** Accepts parameters passed dynamically from the parent FSG report to ensure relevant data is displayed.
*   **Unified View:** Combines GL journal data with Subledger Accounting (SLA) details in a single output.

### Technical Architecture

The report's architecture is centered on the link between General Ledger balances and Subledger Accounting events. It uses the `GL_IMPORT_REFERENCES` table as the critical bridge.

#### Key Tables Involved:

*   **GL_BALANCES:** The source of summarized financial data.
*   **GL_JE_BATCHES, GL_JE_HEADERS, GL_JE_LINES:** The hierarchy of GL journal entries.
*   **GL_IMPORT_REFERENCES:** Links GL journal lines to XLA AE lines.
*   **XLA_AE_HEADERS & XLA_AE_LINES:** The Subledger Accounting journal entries.
*   **XLA_DISTRIBUTION_LINKS:** Connects accounting entries to the original transaction distributions.
*   **Subledger Transaction Tables:** Tables such as `AP_INVOICES_ALL`, `AR_CASH_RECEIPTS_ALL`, `PO_HEADERS_ALL`, etc., are joined to provide operational context.

#### Critical Joins:

The SQL logic prioritizes the connection from `GL_JE_LINES` to `XLA_AE_LINES` via `GL_IMPORT_REFERENCES`. From the XLA layer, it branches out to various subledger tables based on the `APPLICATION_ID` and `ENTITY_CODE`, ensuring that the correct source table is queried for each transaction type.

### Parameters & Filtering

While often invoked dynamically, the report supports standard parameters for standalone execution:

*   **Ledger & Period:** Defines the accounting context and time frame.
*   **Account Range:** Allows filtering by specific account segments (e.g., Cost Center, Natural Account).
*   **Source & Category:** Filters for specific types of journals (e.g., Payables, Receivables).
*   **Currency:** Options to view entered, accounted, or reporting currencies.

### Performance & Optimization

Given its role as a drilldown report, performance is paramount:

*   **Context-Sensitive Execution:** When triggered from an FSG, the report inherits specific context (Period, Account), naturally limiting the data scope and ensuring fast retrieval.
*   **Optimized Predicates:** The SQL uses efficient predicates to filter by Ledger ID and Period Name, leveraging standard Oracle indexes.

### FAQ

**Q: How do I use this report with an FSG?**
A: This report is configured as the "Drilldown" action for specific rows or columns within the FSG definition. When a user views the FSG output, they can click a value to launch this report for that specific intersection of data.

**Q: Does it show manual journal entries?**
A: Yes, manual GL journals are included. However, since they do not originate from a subledger, the subledger-specific columns (like Invoice Number) will be blank.

**Q: Can this report be run independently?**
A: Yes, it can be run as a standalone concurrent request or Blitz Report, provided the user supplies the necessary parameters.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-analysis-drilldown)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
