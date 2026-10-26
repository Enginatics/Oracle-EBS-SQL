---
layout: default
last_modified_at: 2026-10-26
title: 'CAC WIP Material Relief | Oracle EBS SQL Report'
description: 'Report to show WIP material variances on closed jobs for discrete manufacturing, in summary by inventory organization, with WIP class, job status, name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Material, Relief, cst_cost_types, cst_item_costs, cst_item_cost_details'
permalink: /CAC%20WIP%20Material%20Relief/
report_name: 'CAC WIP Material Relief'
report_web_name: cac-wip-material-relief
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Material Relief – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-material-relief/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show WIP material variances on closed jobs for discrete manufacturing, in summary by inventory organization, with WIP class, job status, name and other details.  Including any profit in inventory or PII amounts.  But unlike the more recent CAC WIP Manufacturing Variance and CAC WIP Material Usage Variance reports, this report uses the latest material issue quantities as stored on the WIP job definition, even if you run it for a prior period.  It does not rollback the component issue quantities for a prior accounting period.

Parameters:
==========
Period Name:  the accounting period you wish to report (mandatory).
Cost Type:  defaults to your Costing Method.  If blank the report uses your Costing Method Cost Type (mandatory).
PII Cost Type:  enter the cost type for your profit in inventory item costs to report (optional).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (optional).
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number you wish to report (optional)
Component Number:   specific component item you wish to report (optional)
Show Phantom Components: show the material usage variances for phantom components (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- |  Copyright 2009-24 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is acknowledged.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_relief_rept.sql
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Jan 2010 Douglas Volz   Initial Coding based on XXX_ICP_WIP_COMPONENT_VAL_REPT.sql,
-- |                                     with this report analyzing the WIP variances on
-- |                                     closed jobs.  Added org_acct_periods to limit to
-- |                                     jobs closed within the accounting period.
-- |  1.9     26 Sep 2010 Douglas Volz   Added Component Item Number to report sort.
-- |  1.10    09 Feb 2012 Douglas Volz   Included component yield in required quantities;
-- |                                     decided to not exclude WIP expense jobs as they
-- |                                     could have components with ICP issued to the job
-- |                                     and the cost accountants would need the visibility.
-- |  1.11    23 Feb 2012 Douglas Volz   Added component UOM code, to be consistent with
-- |                                     other reports.
-- |  1.12    07 Oct 2020 Andy Haack     Modify for Blitz Report with Blitz lookup functions
-- |                                     (xxen_util) and re-format sql code.
-- |  1.13    11 Jul 2022 Douglas Volz   Multi-language changes; added back PII parameters.  Changed
-- |                                     wro.component_yield_factor to nvl(wro.component_yield_factor,1).
-- |  1.14    23 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and inventory org access controls.
-- |                                     Added category set parameters.
-- |  1.15    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Cost Type, PII Cost Type, PII Sub-Element, Category Set 1, Category Set 2, Category Set 3, Class Code, Job Status, WIP Job, Assembly Number, Component Number, Show Phantom Components, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Material%20Relief/CAC%20WIP%20Material%20Relief.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Material Relief 01-Aug-2022 084256.xlsx](https://www.enginatics.com/example/cac-wip-material-relief/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) |
| Blitz Report™ XML Import | [CAC_WIP_Material_Relief.xml](https://www.enginatics.com/xml/cac-wip-material-relief/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) |
| SQL Source | [CAC WIP Material Relief.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Material%20Relief/CAC%20WIP%20Material%20Relief.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-material-relief/](https://www.enginatics.com/reports/cac-wip-material-relief/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief) |

## Executive Summary
The **CAC WIP Material Relief** report provides a detailed analysis of material variances for closed Work in Process (WIP) jobs. It focuses specifically on the "relief" side of the equation—how much material cost was relieved from WIP upon job completion—and compares it to the standard cost of the assembly. Unlike other variance reports that might re-calculate based on current conditions, this report uses the historical material issue quantities stored on the job definition, ensuring alignment with the actual transactions that occurred. It is a key tool for analyzing the Material Usage Variance component of manufacturing costs.

## Business Challenge
In a standard costing environment, Material Usage Variance (MUV) occurs when the quantity of components actually issued to a job differs from the standard quantity required. Understanding this variance is crucial for:
*   **BOM Accuracy**: Identifying if the Bill of Materials (BOM) standards are incorrect.
*   **Production Efficiency**: Detecting waste, scrap, or theft on the shop floor.
*   **Cost Control**: Monitoring the largest component of manufacturing cost (material).

However, analyzing MUV on closed jobs can be complex because it requires comparing the *actual* issues against the *standard* requirements at the time of completion, while also accounting for any Profit in Inventory (PII) if applicable.

## Solution
This report generates a summary of material relief and variances by Inventory Organization and WIP Class. It provides a granular view of the material costs relieved from WIP, allowing cost accountants to audit the specific components driving the variance.

**Key Features:**
*   **Closed Job Focus**: specifically targets jobs that have been closed, where the final variance has been recognized.
*   **Historical Accuracy**: Uses the component issue quantities as they were recorded on the job, preserving the historical context of the variance.
*   **Profit in Inventory (PII)**: Includes logic to report on PII amounts, which is critical for inter-company transfers and global manufacturing supply chains.
*   **Yield Factor Support**: Accounts for component yield factors in the requirement calculations.

## Architecture
The report joins `WIP_DISCRETE_JOBS` with `WIP_REQUIREMENT_OPERATIONS` to get the component details. It calculates the standard requirements based on the assembly completion quantity and compares this to the quantity actually issued.

**Key Tables:**
*   `WIP_DISCRETE_JOBS`: Job header and status.
*   `WIP_REQUIREMENT_OPERATIONS`: Component requirements and quantities issued.
*   `MTL_SYSTEM_ITEMS`: Item master for costs and descriptions.
*   `CST_ITEM_COSTS`: Standard costs for the components.
*   `ORG_ACCT_PERIODS`: To filter jobs closed within a specific accounting period.

## Impact
*   **Variance Explanation**: Provides the detailed data needed to explain material usage variances to management.
*   **Standard Cost Refinement**: Highlights consistent variances that suggest a need to update BOM standards.
*   **Inventory Valuation**: Ensures that the relief of inventory value from WIP is understood and accurate.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-material-relief)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
