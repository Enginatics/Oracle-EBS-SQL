---
layout: default
title: 'CAC WIP Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for WIP accounting classes. Parameters: Organization Code: specific inventory organization to report (optional) Operating…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, WIP, Accounts, Setup, wip_accounting_classes, mtl_parameters, mfg_lookups'
permalink: /CAC%20WIP%20Accounts%20Setup/
---

# CAC WIP Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-accounts-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show accounts used for WIP accounting classes.

Parameters:

Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Mar 2011 Douglas Volz   Added ledger parameter
-- |  1.2     18 Nov 2012 Douglas Volz   Removed client-specific COA segments and
-- |                                     organization conditions
-- |  1.3     02 Feb 2020 Douglas Volz   Outer join for accounts join, short name
-- |                                     for Ledger, Operating Unit and Org Code
-- |                                     parameters.
-- |  1.4     20 Apr 2020 Douglas Volz   Added Creation Date, Last Update Date
-- |                                     Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.5     10 Jul 2022 Douglas Volz   Account Type column now uses a lookup code.
-- |  1.6     05 Nov 2025 Douglas Volz   Added completion cost source, system option 
-- |                                     and cost type for Average and FIFO Costing.
-- +=============================================================================+*/

## Report Parameters
Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Accounts Setup 10-Jul-2022 124032.xlsx](https://www.enginatics.com/example/cac-wip-accounts-setup/) |
| Blitz Report™ XML Import | [CAC_WIP_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-wip-accounts-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-accounts-setup/](https://www.enginatics.com/reports/cac-wip-accounts-setup/) |

## Case Study & Technical Analysis: CAC WIP Accounts Setup

### Executive Summary
The **CAC WIP Accounts Setup** report is a configuration audit tool. It documents the General Ledger accounts assigned to each "WIP Accounting Class". This setup dictates where costs flow during production (e.g., which account captures Material Usage Variance).

### Business Challenge
*   **Segmentation**: "We want R&D jobs to hit a different Expense account than Production jobs." This requires separate WIP Accounting Classes.
*   **Variance Analysis**: "Why is the Labor Efficiency Variance mixed in with the Material Usage Variance?" (Answer: They are mapped to the same GL account).
*   **New Org Setup**: Verifying that the new plant has the correct account mappings before go-live.

### Solution
This report lists the mapping.
*   **Class**: The WIP Accounting Class (e.g., "Discrete", "Rework").
*   **Accounts**: Material, Material Overhead, Resource, OSP, Overhead.
*   **Variances**: Material Variance, Resource Variance, etc.
*   **Valuation**: The WIP Asset account.

### Technical Architecture
*   **Tables**: `wip_accounting_classes`, `gl_code_combinations`.
*   **Logic**: Simple dump of the class definition.

### Parameters
*   **Organization Code**: (Optional) Filter by plant.

### Performance
*   **Fast**: Configuration data.

### FAQ
**Q: Can I change these accounts while jobs are open?**
A: Generally No. The accounts are stamped on the job at creation. Changing the setup only affects *new* jobs.


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
