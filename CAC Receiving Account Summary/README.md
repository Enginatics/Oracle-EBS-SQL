---
layout: default
title: 'CAC Receiving Account Summary | Oracle EBS SQL Report'
description: 'Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number. With the Show…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, R12 only, CAC, Receiving, Account, Summary, mtl_units_of_measure_vl, org_acct_periods, gl_code_combinations'
permalink: /CAC%20Receiving%20Account%20Summary/
---

# CAC Receiving Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-receiving-account-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the report size, to display or not display purchase information (purchase order, line, release) and WIP outside processing information (WIP job and OSP resource code).  And if you accrue expense receipts at time of receipt, for expense destinations when there is no item number, this report will get the expense category information and put it into the columns for the first category set.

(Note: this report has not been tested with encumbrance entries.)

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Purchase Orders:  display the purchase order, line and release information.  Enter Yes or No, use to limit the report size (mandatory).
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP Outside Processing:  display the WIP job and outside processing resource.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Supplier Name:  enter the specific supplier you wish to report (optional).
PO Number:  enter the specific purchase order number you wish to report (optional).
Destination Code:  enter the purchase order destination type you wish to report (optional).  You can choose Inventory, Expense or Shop Floor (WIP outside processing).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.15    17 Sep 2021 Douglas Volz   Parameter changes, adding item number, PO number.
-- |  1.16    08 Jul 2022 Douglas Volz   Subledger Accounting performance improvements
-- |                                     and parameter to show or not show PO information.
-- |  1.17    14 Aug 2022 Douglas Volz   Revision for expense/no item receipts.
-- |                                     Combine SLA and Non-SLA Receiving Acct Reports.  Make
-- |                                     Show SLA, Show PO and Show WIP OSP dynamic SQL parameters.
-- |  1.18    21 Aug 2022 Douglas Volz   Streamline dynamic SQL code.
-- |  1.19    03 Sep 2022 Douglas Volz   Language translations for Accounting Line Types.
-- +=============================================================================+*/


## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Purchase Orders, Show Projects, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Supplier Name, PO Number, Destination Code, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [&wip_osp_tables](https://www.enginatics.com/library/?pg=1&find=&wip_osp_tables), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Receiving Account Summary 03-Sep-2022 111842.xlsx](https://www.enginatics.com/example/cac-receiving-account-summary/) |
| Blitz Report™ XML Import | [CAC_Receiving_Account_Summary.xml](https://www.enginatics.com/xml/cac-receiving-account-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-receiving-account-summary/](https://www.enginatics.com/reports/cac-receiving-account-summary/) |


## Case Study & Technical Analysis: CAC Receiving Account Summary

### Executive Summary
The **CAC Receiving Account Summary** report is a specialized accounting tool for the "Receiving" subledger. While the "Material Account Summary" covers inventory movements, this report focuses specifically on the accrual and clearing activities that happen at the dock door.
It bridges the gap between the Purchase Order (PO) and the General Ledger (GL), providing a summarized view of:
1.  **Accruals:** The liability recorded when goods are received but not yet invoiced (Receipt Accruals).
2.  **Clearing:** The reversal of that liability when the AP Invoice is matched.
3.  **Inspection/Delivery:** The movement of value from "Receiving Inspection" to "Inventory" or "Expense".

### Business Challenge
The "Receiving" stage is a financial limbo. Goods are physically present but often not yet legally owned or invoiced.
*   **The "Accrual" Black Hole:** At month-end, Finance needs to know exactly what is sitting in the "Receiving Inventory" (or "Accrual") account. If this account doesn't reconcile, it usually means receipts haven't been delivered or invoices haven't been matched.
*   **Expense vs. Inventory:** Receipts for expense items (like office supplies) often bypass inventory but still generate accounting entries. Tracking these "Expense Destination" receipts is crucial for departmental budget analysis.
*   **SLA Complexity:** As with other subledgers, R12 Subledger Accounting (SLA) can transform the raw receiving accounts (e.g., changing a cost center based on the project code). Reporting on the raw data (`RCV_RECEIVING_SUB_LEDGER`) might not match the GL.

### The Solution
This report provides a flexible, summarized view of receiving activity.
*   **Dual-Mode Architecture:**
    *   **SLA Mode:** Joins to `XLA_DISTRIBUTION_LINKS` to show the final, transformed accounting entries that hit the GL.
    *   **Legacy Mode:** Queries `RCV_RECEIVING_SUB_LEDGER` directly for a faster, operational view of the receiving transactions.
*   **Expense Handling:** It has special logic to handle "Description-based" POs (where there is no Item Number). In these cases, it pulls the "Expense Category" to categorize the spend, ensuring that even non-stock purchases are reportable.
*   **Granularity Control:** Users can toggle "Show Purchase Orders," "Show Projects," and "Show WIP" to switch between a high-level GL summary and a detailed transaction register.

### Technical Architecture (High Level)
The query relies on a dynamic `FROM` clause (likely hidden in the `&subledger_tab` or similar variable in the full code, though the snippet shows the outer select) to switch between data sources.
*   **Core Data Source:**
    *   **Non-SLA:** `RCV_RECEIVING_SUB_LEDGER` (RRSL) is the primary source. It links `RCV_TRANSACTIONS` to `GL_CODE_COMBINATIONS`.
    *   **SLA:** The query likely joins `RCV_TRANSACTIONS` -> `RCV_RECEIVING_SUB_LEDGER` -> `XLA_DISTRIBUTION_LINKS` -> `XLA_AE_LINES`.
*   **Dynamic Grouping:** The `GROUP BY` clause changes based on the user's parameters. If `Show Purchase Orders` is 'No', the query aggregates all receipts for an item/account into a single line, significantly reducing row count.
*   **Lookup Decoding:** Extensive use of `FND_LOOKUP_VALUES` and `PO_LOOKUP_CODES` ensures that cryptic codes like "DELIVER" or "RECEIVE" are translated into user-friendly terms like "Delivery to Inventory" or "Standard Receipt".

### Parameters & Filtering
*   **Show SLA Accounting:** The critical switch for GL reconciliation.
*   **Destination Code:** Allows filtering for "Expense" (Direct to GL), "Inventory" (Stock), or "Shop Floor" (Outside Processing).
*   **Show Purchase Orders/Projects/WIP:** Toggles for detail level.
*   **Transaction Date From/To:** Defines the accounting period.

### Performance & Optimization
*   **Summary by Default:** By defaulting to a summary view (grouping by Account/Item), the report is much faster than a standard "Receiving Transaction Register" which lists every single receipt line.
*   **Conditional Joins:** The dynamic SQL ensures that tables like `PO_HEADERS_ALL` or `PA_PROJECTS_ALL` are only joined if the user explicitly asks for that data.

### FAQ
**Q: Why is the "Amount" column sometimes zero?**
A: In Receiving, you often have offsetting entries. For example, a "Delivery" transaction credits Receiving Inspection and debits Inventory. If you summarize by Item (and the accounts are the same, which is rare but possible), they might net out. More likely, you are seeing the net activity for a period.

**Q: Can I use this to reconcile the "AP Accrual" account?**
A: Yes. Filter for the Accrual Account and look at the net activity. However, the "Accrual Reconciliation Report" is a more specialized tool for matching individual PO receipts to Invoices.

**Q: What does "Shop Floor" destination mean?**
A: This refers to Outside Processing (OSP). When you receive an OSP item, you are receiving a *service* directly to a WIP Job, not a physical item into a warehouse. The accounting debits WIP Valuation, not Inventory.


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
