---
layout: default
last_modified_at: 2026-10-19
title: 'CAC AP Accrual Reconciliation Summary by Match Type | Oracle EBS SQL Report'
description: 'Use this report to summarize the A/P Accrual entries from the Accrual Reconcilation Report tables, by operating unit, accrual match type and inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Accrual, Reconciliation, Summary, mtl_transaction_types, fnd_lookup_values_vl, cst_ap_po_reconciliation'
permalink: /CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/
report_name: 'CAC AP Accrual Reconciliation Summary by Match Type'
report_web_name: cac-ap-accrual-reconciliation-summary-by-match-type
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC AP Accrual Reconciliation Summary by Match Type – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-summary-by-match-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Use this report to summarize the A/P Accrual entries from the Accrual Reconcilation Report tables, by operating unit, accrual match type and inventory organization.  Use this report for summary reconciliation purposes, to justify the "at time of receipt" accrual balances for your inventory and expense A/P accrual accounts.

Parameters:
===========
Transaction Date From:  enter the accrual starting transaction date you wish to report.  Defaults to the earliest date found (mandatory).
Transaction Date To:  enter the accrual ending transaction date you wish to report.  Defaults to the latest date found (mandatory).
Operating Unit:  operating unit you wish to report (optional).
Ledger:  general ledger you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2011-2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Nov 2011 Douglas Volz   Initial Coding based on xxx_ap_accrual_summary_rept.sql
-- |                                     Retrofitted to R12 A/P Accrual tables
-- |  1.1     07 May 2019 Douglas Volz   Modified for upgrade client
-- |  1.2     06 Feb 2020 Douglas Volz   Added Ledger parameter.
-- |  1.3     09 Apr 2020 Douglas Volz   Commented out capr.inventory_transaction_id column
-- |                                     Was added by Oracle for consignment transactions in
-- |                                     Release 12.1.6.
-- |  1.4     15 Apr 2020 Douglas Volz   Undid modifications for upgrade client
-- |  1.5     17 Feb 2025 Douglas Volz   Formatted for Blitz Report.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [cst_ap_po_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_ap_po_reconciliation&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [cst_misc_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_misc_reconciliation&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)

## Related Reports
[CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [QP Qualifier Group Upload](/QP%20Qualifier%20Group%20Upload/ "QP Qualifier Group Upload Oracle EBS SQL Report"), [CAC Receiving Activity Summary](/CAC%20Receiving%20Activity%20Summary/ "CAC Receiving Activity Summary Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-ap-accrual-reconciliation-summary-by-match-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) |
| Blitz Report™ XML Import | [CAC_AP_Accrual_Reconciliation_Summary_by_Match_Type.xml](https://www.enginatics.com/xml/cac-ap-accrual-reconciliation-summary-by-match-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) |
| SQL Source | [CAC AP Accrual Reconciliation Summary by Match Type.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-ap-accrual-reconciliation-summary-by-match-type/](https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-summary-by-match-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type) |

## Case Study & Technical Analysis: CAC AP Accrual Reconciliation Summary by Match Type

### Executive Summary
The **CAC AP Accrual Reconciliation Summary by Match Type** is a strategic financial report designed to streamline the month-end closing process for Oracle Cost Management. It provides a high-level aggregation of the Accounts Payable (AP) Accrual liability, categorized by **Match Type** (e.g., PO Match, Consignment, Miscellaneous). This summary view allows Finance teams to quickly understand the composition of their accrual balance without getting lost in the details of thousands of individual transactions.

### Business Challenge
The "Received Not Invoiced" (RNI) account is often one of the most difficult accounts to reconcile.
*   **Data Volume:** A typical organization may have thousands of open receipts at any given time. Standard reports often list these line-by-line, making it difficult to spot trends or anomalies.
*   **Source Identification:** When the General Ledger balance doesn't match the Subledger, it's hard to know where to look. Is the variance due to standard Purchase Orders, Consignment inventory, or manual journal entries?
*   **Efficiency:** Reviewing detailed reports for high-level variance analysis is inefficient and delays the period close.

### Solution
This report solves these challenges by summarizing the data already present in the Oracle Accrual Reconciliation tables.
*   **Categorization:** Groups transactions by `Accrual Match Type`, instantly showing how much of the balance is due to standard PO matching vs. other sources.
*   **Drill-Down Path:** Serves as the starting point for reconciliation. Users can identify a high-value category (e.g., "Miscellaneous Accrual") and then run detailed reports for just that category.
*   **Multi-Org Support:** Aggregates data by Operating Unit and Inventory Organization, providing a clear view of liabilities across the enterprise.

### Technical Architecture
The report leverages the standard Oracle Accrual Reconciliation architecture:
*   **Data Source:** Queries `CST_AP_PO_RECONCILIATION` and `CST_MISC_RECONCILIATION`. These tables are populated by the standard **Accrual Reconciliation Load Run** concurrent program.
*   **Integration:** Joins with `HR_ALL_ORGANIZATION_UNITS` and `GL_LEDGERS` to provide meaningful organizational context.
*   **Logic:** The SQL focuses on aggregation, summing the `AMOUNT` columns based on the `ACCRUAL_MATCH_TYPE` code.

### Parameters & Filtering
*   **Transaction Date From/To:** (Mandatory) Defines the period for the reconciliation. These dates should align with your accounting period.
*   **Operating Unit:** (Optional) Filter by specific Operating Unit to reconcile one entity at a time.
*   **Ledger:** (Optional) Filter by Ledger for higher-level financial reporting.

### Performance & Optimization
*   **Prerequisite:** The **Accrual Reconciliation Load Run** program must be executed *before* running this report. If the load program hasn't run, this report will return no data or outdated data.
*   **Speed:** Extremely fast. Since it queries a dedicated reporting table (`CST_AP_PO_RECONCILIATION`) rather than raw transaction tables, it typically completes in seconds.

### FAQ
**Q: Why is the report output empty?**
A: This report relies on the `CST_AP_PO_RECONCILIATION` table. You must run the **Accrual Reconciliation Load Run** concurrent request for the specific Operating Unit and period before running this report.

**Q: What does "Match Type" mean?**
A: The Match Type indicates the nature of the accrual entry. Common types include:
*   **PO Match:** Standard accrual from a Purchase Order receipt.
*   **Consignment:** Accrual related to consigned inventory consumption.
*   **Write-Off:** Entries that have been written off but are still in the history tables.

**Q: Can I use this for "On Receipt" and "Period End" accruals?**
A: This report is designed for **On Receipt** accruals (Perpetual Accruals). Period End accruals are typically handled differently in the General Ledger.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-reconciliation-summary-by-match-type)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
