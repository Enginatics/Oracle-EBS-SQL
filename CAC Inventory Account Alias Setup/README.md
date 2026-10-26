---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Inventory Account Alias Setup | Oracle EBS SQL Report'
description: 'Report to show accounts assigned for inventory account aliases / +=============================================================================+ -- |…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, Account, Alias, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Inventory%20Account%20Alias%20Setup/
report_name: 'CAC Inventory Account Alias Setup'
report_web_name: cac-inventory-account-alias-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory Account Alias Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-account-alias-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show accounts assigned for inventory account aliases

/* +=============================================================================+
-- |  Copyright 2011 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- |  1.4     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_acct_alias_setup_rept.sql
-- |
-- |  Parameters:
-- |  p_ledger		-- Ledger you wish to report, enter a null for all
-- |                       ledgers. (optional)
-- | 
-- |  Description:
-- |  Report to show accounts used for account aliases
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     03 Feb 2011 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Added Ledger parameter, effective date
-- |					 and disable date
-- |  1.2     07 Oct 2015 Douglas Volz   Removed prior client's org restrictions.
-- |  1.3     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup), [mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)

## Related Reports
[CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Account%20Alias%20Setup/CAC%20Inventory%20Account%20Alias%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Account Alias Setup 23-Jun-2022 160834.xlsx](https://www.enginatics.com/example/cac-inventory-account-alias-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) |
| Blitz Report™ XML Import | [CAC_Inventory_Account_Alias_Setup.xml](https://www.enginatics.com/xml/cac-inventory-account-alias-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) |
| SQL Source | [CAC Inventory Account Alias Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20Account%20Alias%20Setup/CAC%20Inventory%20Account%20Alias%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-account-alias-setup/](https://www.enginatics.com/reports/cac-inventory-account-alias-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup) |

## Case Study & Technical Analysis: CAC Inventory Account Alias Setup

### Executive Summary
The **CAC Inventory Account Alias Setup** report is a governance and compliance tool used to audit the configuration of Inventory Account Aliases. Account aliases are powerful shortcuts in Oracle EBS that allow users to issue or receive material to/from a specific General Ledger account. This report ensures that these aliases are mapped to the correct accounts, preventing financial misstatements and unauthorized usage.

### Business Challenge
Account aliases provide flexibility but introduce risk if not managed correctly.
*   **Financial Misclassification:** If an alias is mapped to the wrong GL account (e.g., an expense account instead of an asset account), it can lead to immediate P&L errors.
*   **Lack of Control:** Without visibility, obsolete or unauthorized aliases may remain active, allowing users to bypass standard transaction controls.
*   **Audit Compliance:** Auditors frequently require proof that account mappings are reviewed and controlled.
*   **Multi-Org Complexity:** In large environments, keeping track of aliases across dozens of inventory organizations is a manual, error-prone task.

### The Solution
The **CAC Inventory Account Alias Setup** report provides a clear, consolidated view of all defined account aliases and their associated GL accounts.
*   **Configuration Audit:** Lists every alias along with its description, effective dates, and the underlying GL account segments.
*   **Cross-Org Comparison:** Allows administrators to compare alias setups across different organizations and ledgers to ensure standardization.
*   **Active Status Check:** Includes effective date and disable date fields to easily identify active vs. inactive aliases.

### Technical Architecture (High Level)
The report queries the setup tables for inventory dispositions (aliases) and joins them with financial and organizational definitions.

**Primary Tables Involved:**
*   `MTL_GENERIC_DISPOSITIONS`: The main table storing Account Alias definitions.
*   `GL_CODE_COMBINATIONS`: Stores the actual General Ledger account strings (segments) linked to the aliases.
*   `MTL_PARAMETERS`: Provides context for the inventory organization.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: Provides human-readable organization names.
*   `GL_LEDGERS`: Identifies the ledger associated with the organization.

**Logical Relationships:**
*   **Alias to Account:** The `distribution_account` column in `MTL_GENERIC_DISPOSITIONS` links to `GL_CODE_COMBINATIONS` to retrieve the account details.
*   **Organization Context:** The report joins the alias definition to the organization tables to report which organization owns the alias.

### Parameters & Filtering
*   **Organization Code:** Allows the user to audit aliases for a specific inventory organization.
*   **Operating Unit:** Filters the report by the Operating Unit that owns the inventory organizations.
*   **Ledger:** Enables filtering by the General Ledger, useful for financial controllers responsible for specific books.

### Performance & Optimization
*   **Simple Join Structure:** The query primarily involves joining setup tables (`MTL_GENERIC_DISPOSITIONS`, `GL_CODE_COMBINATIONS`), which are relatively small compared to transaction tables. This ensures the report runs very quickly.
*   **Direct Reporting:** Provides immediate visibility without the need for complex calculations or aggregations.

### FAQ
**Q: What is an Account Alias?**
A: An Account Alias is a user-friendly name (e.g., "SCRAP-METAL") that maps to a specific General Ledger account code. It simplifies data entry for users performing miscellaneous transactions.

**Q: Can I see who created the alias?**
A: While this specific report focuses on the account setup, the underlying tables do store "Created By" information, which could be added if needed.

**Q: Why is this report important for period close?**
A: Reviewing this report helps ensure that all miscellaneous transactions performed during the period were directed to valid and correct GL accounts, reducing the need for reclassification journals later.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-account-alias-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
