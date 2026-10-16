---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Receiving Account Detail | Oracle EBS SQL Report'
description: 'Receiving accounting distributions in detail by item, purchase order, release, transaction date, creation date, created by and transaction id. Show SLA…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Receiving, Account, Detail, po_releases_all, mtl_parameters, org_access_view'
permalink: /CAC%20Receiving%20Account%20Detail/
report_name: 'CAC Receiving Account Detail'
report_web_name: cac-receiving-account-detail
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Receiving Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Receiving accounting distributions in detail by item, purchase order, release, transaction date, creation date, created by and transaction id.
Show SLA Accounting = Yes reports the Subledger Accounting (Create Accounting) account, and only distributions accounted in Subledger Accounting. No reports the receiving subledger account.
Show Project Information and Show WIP Outside Processing add the project and task, and the WIP job and outside processing resource columns.
Purchasing Category is the purchase order line category, which also categorizes expense receipts without an item.
On instances with India Localization, GST columns (GST/PAN/TAN, tax, HSN/SAC, NR Tax) are also included.

/* +=============================================================================+
-- |  Copyright 2010 - 2022 Douglas Volz Consulting, Inc.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_rcv_dist_xla_detail_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     05 Apr 2010 Douglas Volz   Initial Coding based on XXX_RCV_DIST_XLA_SUM_REPT.sql
-- |  1.18    21 Aug 2022 Douglas Volz   Streamline dynamic SQL code.
-- |  1.19    03 Sep 2022 Douglas Volz   Add Accounting Line Type, Transaction Type and Minimum Amount parameters.
-- |                                     And language translations for Accounting Line Types.
-- |  1.20   08 Oct 2022 Douglas Volz    Add project task information.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Project Information, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Transaction Type, Minimum Absolute Amount, Supplier Name, PO Number, Destination Code, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)

## Related Reports
[CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC PO Receipt History for Item Costing](/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/ "CAC PO Receipt History for Item Costing Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Account%20Detail/CAC%20Receiving%20Account%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Account Detail 03-Sep-2022 132129.xlsx](https://www.enginatics.com/example/cac-receiving-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) |
| Blitz Report™ XML Import | [CAC_Receiving_Account_Detail.xml](https://www.enginatics.com/xml/cac-receiving-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) |
| SQL Source | [CAC Receiving Account Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Receiving%20Account%20Detail/CAC%20Receiving%20Account%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-receiving-account-detail/](https://www.enginatics.com/reports/cac-receiving-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail) |

## Case Study & Technical Analysis: CAC Receiving Account Detail

### Executive Summary
The **CAC Receiving Account Detail** report is a forensic accounting tool for the Receiving module. It lists the specific accounting entries (Debits and Credits) generated by receiving transactions. This is critical for reconciling the "Receiving Inspection" (Asset) and "PO Accrual" (Liability) accounts.

### Business Challenge
*   **Reconciliation**: The General Ledger shows a balance in "Receiving Inspection" that doesn't match the subledger. Which transaction caused the drift?
*   **Accrual Auditing**: Verifying that the liability was booked correctly for a specific high-value receipt.
*   **SLA Visibility**: In R12, Subledger Accounting (SLA) rules can transform accounts. Users need to see the *final* account used, not just the default from the PO.

### Solution
This report bridges the gap between Operations and Finance.
*   **Granularity**: One row per accounting line (Debit or Credit).
*   **Context**: Links the journal line back to the PO Number, Receipt Number, Item, and Project.
*   **SLA Integration**: Can optionally pull data from `xla_ae_lines` to show the final transformation rules applied.

### Technical Architecture
*   **Tables**: `rcv_receiving_sub_ledger` (Pre-SLA), `xla_ae_lines` (Post-SLA), `rcv_transactions`.
*   **Logic**: The "Show SLA Accounting" parameter toggles between the raw subledger table and the XLA engine tables.

### Parameters
*   **Show SLA Accounting**: (Mandatory) "Yes" for accurate GL matching, "No" for faster operational checks.
*   **Transaction Date From/To**: (Mandatory) Accounting period.
*   **Minimum Absolute Amount**: (Optional) Filter out small rounding differences.

### Performance
*   **Variable**: Running with "Show SLA Accounting = Yes" is slower because it joins to the massive XLA tables.

### FAQ
**Q: Why are there two entries for one receipt?**
A: A standard receipt generates a Debit to Receiving Inspection and a Credit to the Accrual Account.
**Q: Does this show "Deliver" transactions?**
A: Yes, it shows the full flow: Receive (Dr Insp / Cr Accrual) -> Deliver (Dr Inv / Cr Insp).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-receiving-account-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
