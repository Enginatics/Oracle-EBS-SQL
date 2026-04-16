---
layout: default
title: 'CAC Inventory Account Alias Setup | Oracle EBS SQL Report'
description: 'Report to show accounts assigned for inventory account aliases / +=============================================================================+ -- |…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Account, Alias, mtl_generic_dispositions, mtl_parameters, gl_code_combinations'
permalink: /CAC%20Inventory%20Account%20Alias%20Setup/
---

# CAC Inventory Account Alias Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-account-alias-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show accounts assigned for inventory account aliases

/* +=============================================================================+
-- |  Copyright 2011 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
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

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Account Alias Setup 23-Jun-2022 160834.xlsx](https://www.enginatics.com/example/cac-inventory-account-alias-setup/) |
| Blitz Report™ XML Import | [CAC_Inventory_Account_Alias_Setup.xml](https://www.enginatics.com/xml/cac-inventory-account-alias-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-account-alias-setup/](https://www.enginatics.com/reports/cac-inventory-account-alias-setup/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
