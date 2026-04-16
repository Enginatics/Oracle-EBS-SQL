---
layout: default
title: 'CAC Receiving Account Detail | Oracle EBS SQL Report'
description: 'Report to get the receiving accounting distributions, in detail, by item, purchase order, purchase order line, release, project number, transaction date…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, R12 only, CAC, Receiving, Account, Detail, po_releases_all, mtl_units_of_measure_vl, org_acct_periods'
permalink: /CAC%20Receiving%20Account%20Detail/
---

# CAC Receiving Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-account-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the receiving accounting distributions, in detail, by item, purchase order, purchase order line, release, project number, transaction date, creation date, created by and transaction identifier.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With Show WIP Outside Processing parameter to display or not display WIP outside processing information (WIP job and OSP resource code) and Show Project Information to display or not display the project, project name and task.  And if you accrue expense receipts at time of receipt, for expense destinations when there is no item number, this report will get the expense category information and put it into the columns for the first category.

(Note: this report has not been tested with encumbrance entries.)

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information.  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project, project name and task.  Enter Yes or No, use to limit the reported columns (mandatory).
Show WIP Outside Processing:  display the WIP job and outside processing resource.  Enter Yes or No, use to limit the reported columns (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Transaction Type:  enter the transaction type to report (optional).
Minimum Absolute Amount:  enter the minimum debit or credit to report (optional).  To see all accounting entries, enter zero (0) and leave the other parameters blank.
Supplier Name:  enter the specific supplier you wish to report (optional).
PO Number:  enter the specific purchase order number you wish to report (optional).
Destination Code:  enter the purchase order destination type you wish to report (optional).  You can choose Inventory, Expense or Shop Floor (WIP outside processing).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

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





## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Project Information, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Transaction Type, Minimum Absolute Amount, Supplier Name, PO Number, Destination Code, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [&project_tables](https://www.enginatics.com/library/?pg=1&find=&project_tables), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Account Detail 03-Sep-2022 132129.xlsx](https://www.enginatics.com/example/cac-receiving-account-detail/) |
| Blitz Report™ XML Import | [CAC_Receiving_Account_Detail.xml](https://www.enginatics.com/xml/cac-receiving-account-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-receiving-account-detail/](https://www.enginatics.com/reports/cac-receiving-account-detail/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
