---
layout: default
last_modified_at: 2026-10-26
title: 'CAC AP Accrual Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show the valid A/P Accrual Accounts which have been set up in the Select Accrual Accounts Form. Showing the Ledger, Operating Unit, Accrual…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Accrual, Accounts, Setup, cst_accrual_accounts, hr_all_organization_units_vl, hr_organization_information'
permalink: /CAC%20AP%20Accrual%20Accounts%20Setup/
report_name: 'CAC AP Accrual Accounts Setup'
report_web_name: cac-ap-accrual-accounts-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC AP Accrual Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-ap-accrual-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the valid A/P Accrual Accounts which have been set up in the Select Accrual Accounts Form.  Showing the Ledger, Operating Unit, Accrual Accounts, Creation Date, Created By and Last Updated By.  The A/P Accrual Load Program uses these accounts to find the Payables, Receiving and Inventory accounting accrual entries for the A/P Accrual Load results.

Parameters:
===========
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     10 Nov 2008 Douglas Volz   Initial Coding
-- |  1.1     08 Nov 2011 Douglas Volz   Modified for Release 12
-- |  1.2     15 Feb 2025 Douglas Volz   Added Ledger and Operating Unit parameters,
-- |					                 and added G/L and Operating Unit Security Controls.
-- |  1.3     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_accrual_accounts](https://www.enginatics.com/library/?pg=1&find=cst_accrual_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)

## Related Reports
[CAC Receiving Activity Summary](/CAC%20Receiving%20Activity%20Summary/ "CAC Receiving Activity Summary Oracle EBS SQL Report"), [CAC AP Accrual Reconciliation Summary by Match Type](/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/ "CAC AP Accrual Reconciliation Summary by Match Type Oracle EBS SQL Report"), [CST Miscellaneous Accrual Reconciliation](/CST%20Miscellaneous%20Accrual%20Reconciliation/ "CST Miscellaneous Accrual Reconciliation Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [CST AP and PO Accrual Reconciliation](/CST%20AP%20and%20PO%20Accrual%20Reconciliation/ "CST AP and PO Accrual Reconciliation Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20AP%20Accrual%20Accounts%20Setup/CAC%20AP%20Accrual%20Accounts%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-ap-accrual-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) |
| Blitz Report™ XML Import | [CAC_AP_Accrual_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-ap-accrual-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) |
| SQL Source | [CAC AP Accrual Accounts Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20AP%20Accrual%20Accounts%20Setup/CAC%20AP%20Accrual%20Accounts%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-ap-accrual-accounts-setup/](https://www.enginatics.com/reports/cac-ap-accrual-accounts-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup) |

## CAC AP Accrual Accounts Setup Report

### Executive Summary
The CAC AP Accrual Accounts Setup report provides a detailed listing of all valid A/P accrual accounts that have been configured in the Select Accrual Accounts form. This report is a critical tool for cost accountants and system administrators, offering a clear view of the accounts that are used to track uninvoiced receipts and other accruals. By providing a comprehensive view of the A/P accrual account setup, the report helps to ensure that the A/P Accrual Load program runs correctly and that the accrual reconciliation process is accurate and efficient.

### Business Challenge
The A/P accrual reconciliation process is a critical part of the month-end close. However, if the A/P accrual accounts are not set up correctly, it can lead to a number of challenges, including:
- **Inaccurate Accrual Balances:** If the A/P accrual accounts are not set up correctly, the A/P Accrual Load program may not be able to identify all of the relevant transactions, which can lead to inaccurate accrual balances.
- **Reconciliation Issues:** Inaccurate accrual balances can lead to reconciliation issues between the general ledger and the subledgers, which can be time-consuming and difficult to resolve.
- **Delayed Month-End Close:** The process of identifying and correcting A/P accrual account setup issues can be time-consuming, which can delay the month-end close.
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of the A/P accrual account setup, which can make it difficult to troubleshoot issues and ensure that the setup is correct.

### The Solution
The CAC AP Accrual Accounts Setup report provides a clear and detailed view of the A/P accrual account setup, helping organizations to:
- **Ensure Accuracy:** By providing a clear and comprehensive view of the A/P accrual account setup, the report helps to ensure that the A/P Accrual Load program runs correctly and that the accrual reconciliation process is accurate and efficient.
- **Streamline Reconciliation:** The report makes it easier to identify and resolve any discrepancies between the general ledger and the subledgers, which can help to streamline the reconciliation process.
- **Accelerate the Month-End Close:** By providing a proactive view of the A/P accrual account setup, the report helps to identify and resolve any issues before they can impact the month-end close.
- **Enhance Visibility:** The report provides a centralized and easy-to-read view of the A/P accrual account setup, making it easier to troubleshoot issues and ensure that the setup is correct.

### Technical Architecture (High Level)
The report is based on a query of the `cst_accrual_accounts` table. This table stores all of the valid A/P accrual accounts that have been set up in the Select Accrual Accounts form. The report also uses several other tables to retrieve additional information, such as the ledger, operating unit, and the user who created and last updated the account.

### Parameters & Filtering
The report includes two parameters that allow you to filter the output by operating unit and ledger.

- **Operating Unit:** This parameter allows you to filter the report by a specific operating unit.
- **Ledger:** This parameter allows you to select a specific ledger to view.

### Performance & Optimization
The CAC AP Accrual Accounts Setup report is designed to be efficient and fast. It uses direct table access to retrieve the data, which is much faster than relying on intermediate views or APIs. The report is also designed to minimize the use of complex joins and subqueries, which helps to ensure that it runs quickly and efficiently.

### FAQ
**Q: What is the purpose of the Select Accrual Accounts form?**
A: The Select Accrual Accounts form is used to define the A/P accrual accounts that are used by the A/P Accrual Load program. This program is used to load the A/P accrual data into the `cst_ap_po_reconciliation` table, which is the main table used for A/P accrual reconciliation.

**Q: Why is it important to have a clear understanding of the A/P accrual account setup?**
A: A clear understanding of the A/P accrual account setup is essential for ensuring the accuracy of your A/P accrual reconciliation process. It can also help you to troubleshoot any issues that you may encounter with the A/P Accrual Load program.

**Q: Can I use this report to see who created and last updated the A/P accrual accounts?**
A: Yes, the report includes the creation date, the user who created the account, the last update date, and the user who last updated the account.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-ap-accrual-accounts-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
