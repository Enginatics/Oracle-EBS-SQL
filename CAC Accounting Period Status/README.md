---
layout: default
title: 'CAC Accounting Period Status | Oracle EBS SQL Report'
description: 'Report to show the accounting period status for General Ledger, Inventory, Lease Management, Payables, Projects, Purchasing and Receivables. You can…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Accounting, Period, Status, hrfv_organization_hierarchies, org_acct_periods, mtl_parameters'
permalink: /CAC%20Accounting%20Period%20Status/
---

# CAC Accounting Period Status – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-accounting-period-status/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the accounting period status for General Ledger, Inventory, Lease Management, Payables, Projects, Purchasing and Receivables.  You can choose All Statuses (open or closed or never opened), Closed, Open or Never Opened periods.  And for process manufacturing (OPM), if your cost calendar has the same period end dates as your inventory accounting periods, this report will also display the OPM cost calendar status.  

Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.

Parameters
==========
Period Name - the desired inventory accounting period you wish to report (mandatory).
Report Period Option - the parameter used to combine the Period Open and Period Close reports.  The list of value choices are:  Closed, Open, Never Opened or All Statuses (mandatory).
Functional Area - the Oracle module(s) or functional area you wish to report.  To see all functional areas leave this parameter empty (optional).
Hierarchy Name - select the organization hierarchy used to open and close your inventory organizations.  If you leave this parameter blank the report will try to find any organization hierarchy having "Period", "Open", or "Close" in the hierarchy name (optional)
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  Operating Unit you wish to report, leave blank for all operating units (optional).
Ledger:  general ledger you wish to report, leave blank for all ledgers (optional).

/* +=============================================================================+
-- | SQL Code Copyright 2011-2024 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     19 Jan 2015 Douglas Volz    Combined the xxx_period_open_status_rept.sql xxx_period_close_status_rept.sql into one report.  Originally written in 2006 and 2011.
-- |  1.1     19 Jan 2015 Douglas Volz    Added OPM Cost Calendar status and Projects.
-- |  1.2     19 Dec 2016 Douglas Volz    Fixed list of value choices, was preventing purchasing operating units from being reported.
-- |  1.3     18 May 2016 Douglas Volz    Minor fix for reporting the Organization Hierarchy
-- |  1.4     03 Dec 2018 Douglas Volz    Open Periods option now checks for Summarized_Flag.
-- |  1.5     27 Oct 2019 Douglas Volz    Condense A/R, A/P, Projects, Purchasing SQL logic
-- |  1.6     16 Jan 2020 Douglas Volz    Add operating unit parameter
-- |  1.7     10 Apr 2020 Douglas Volz    Made the following multi-language changes:  Changed fnd_application to fnd_application_vl and changed hr_all_organization_units to hr_all_organization_units_vl
-- |  1.8      7 May 2020 Douglas Volz    Added fnd_product_installations to only report installed applications.
-- |  1.9     26 May 2020 Douglas Volz    Added lookup values and parameters for the organization_hierarchy_name subquery.
-- |  1.10    28 May 2020 Douglas Volz    For language translation, replaced custom Report Options LOV with compound Oracle lookup values.
-- |  1.11    21 Jun 2020 Douglas Volz    Added Organization Hierarchy as a separate parameter
-- |  1.12    07 Feb 2022 Eric Clegg      Added who columns using xxen_util functions.
-- |  1.13    13 Mar 2022 Douglas Volz    Modified for financial apps, to show blank who column values if status = Never Opened.
-- |  1.14    11 Jun 2024 Douglas Volz    Replaced tabs with spaces.  Reinstalled missing parameters.
-- +=============================================================================+*/

## Report Parameters
Period Name, Report Option, Functional Area, Hierarchy Name, Operating Unit, Ledger

## Oracle EBS Tables Used
[hrfv_organization_hierarchies](https://www.enginatics.com/library/?pg=1&find=hrfv_organization_hierarchies), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Inventory Periods Not Closed or Summarized](/CAC%20Inventory%20Periods%20Not%20Closed%20or%20Summarized/ "CAC Inventory Periods Not Closed or Summarized Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Accounting Period Status 23-Jun-2022 144348.xlsx](https://www.enginatics.com/example/cac-accounting-period-status/) |
| Blitz Report™ XML Import | [CAC_Accounting_Period_Status.xml](https://www.enginatics.com/xml/cac-accounting-period-status/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-accounting-period-status/](https://www.enginatics.com/reports/cac-accounting-period-status/) |

## CAC Accounting Period Status Report

### Executive Summary
The CAC Accounting Period Status report provides a consolidated view of the accounting period statuses across multiple Oracle E-Business Suite modules. This report is an essential tool for financial controllers and system administrators, offering a clear and comprehensive overview of which periods are open, closed, or never opened for General Ledger, Inventory, Payables, Projects, Purchasing, and Receivables. By providing a centralized view of period statuses, the report helps to ensure a smooth and timely period-end closing process.

### Business Challenge
The period-end closing process in Oracle E-Business Suite can be a complex and time-consuming task, involving multiple modules and a large number of steps. Without a clear and consolidated view of the period statuses, organizations may face:
- **Delayed Period-End Closing:** The period-end closing process can be delayed if periods are not opened or closed in the correct sequence.
- **Inaccurate Financial Reporting:** If transactions are posted to the wrong period, it can lead to inaccurate financial reporting and reconciliation issues.
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of the period statuses across all modules, which can make it difficult to manage the period-end closing process effectively.
- **Manual Processes:** The process of manually checking the period statuses in each module is time-consuming and prone to errors.

### The Solution
The CAC Accounting Period Status report provides a clear and consolidated view of the period statuses across all relevant modules, helping organizations to:
- **Streamline the Period-End Closing Process:** By providing a centralized view of all period statuses, the report helps to ensure that periods are opened and closed in the correct sequence, which can help to streamline the period-end closing process and reduce the risk of delays.
- **Improve Financial Accuracy:** The report helps to ensure that transactions are posted to the correct period, which is essential for accurate financial reporting and reconciliation.
- **Enhance Visibility:** The report provides a centralized and easy-to-read view of all period statuses, making it easier to manage the period-end closing process effectively.
- **Increase Efficiency:** The report automates the process of checking the period statuses, which can save a significant amount of time and effort.

### Technical Architecture (High Level)
The report is based on a query of several key tables in the Oracle E-Business Suite. The primary tables used include:
- **gl_period_statuses:** This table stores the period statuses for the General Ledger module.
- **org_acct_periods:** This table stores the period statuses for the Inventory module.
- **ap_acct_period_all:** This table stores the period statuses for the Payables module.
- **pa_period_statuses_all:** This table stores the period statuses for the Projects module.
- **po_period_statuses_all:** This table stores the period statuses for the Purchasing module.
- **ar_period_statuses_all:** This table stores the period statuses for the Receivables module.

### Parameters & Filtering
The report includes several parameters that allow you to customize the output to your specific needs. The key parameters include:
- **Period Name:** This parameter allows you to select the accounting period that you want to report on.
- **Report Period Option:** This parameter allows you to filter the report by the period status (e.g., open, closed, never opened).
- **Functional Area:** This parameter allows you to filter the report by a specific Oracle module.
- **Hierarchy Name:** This parameter allows you to select the organization hierarchy that is used to open and close your inventory organizations.
- **Operating Unit and Ledger:** These parameters allow you to filter the report by a specific operating unit or ledger.

### Performance & Optimization
The CAC Accounting Period Status report is designed to be efficient and fast. It uses direct table access to retrieve the data, which is much faster than relying on intermediate views or APIs. The report is also designed to minimize the use of complex joins and subqueries, which helps to ensure that it runs quickly and efficiently.

### FAQ
**Q: What is a functional area?**
A: A functional area is a specific Oracle E-Business Suite module, such as General Ledger, Inventory, or Payables.

**Q: What is an organization hierarchy?**
A: An organization hierarchy is a hierarchical structure that is used to represent the relationships between different organizations in your business. It is often used to control the opening and closing of inventory periods.

**Q: Can I use this report to see the period statuses for all of my operating units and ledgers?**
A: Yes, you can leave the "Operating Unit" and "Ledger" parameters blank to run the report for all operating units and ledgers that you have access to.

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
