---
layout: default
title: 'CAC Missing WIP Accounting Transactions | Oracle EBS SQL Report'
description: 'Report to find work in process (WIP) accounting entries where the WIP transaction has been created but the WIP accounting entries do not exist. If you…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Missing, WIP, Accounting, cst_cost_types, cst_resource_costs, wip_transactions'
permalink: /CAC%20Missing%20WIP%20Accounting%20Transactions/
---

# CAC Missing WIP Accounting Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-missing-wip-accounting-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to find work in process (WIP) accounting entries where the WIP transaction has been created but the WIP accounting entries do not exist.  If you enter Yes for "Only Costed Resources" the report ignores WIP transactions where the resource code is defined as not allowing costs (not costed).  If you enter No for "Only Costed Resources" the report includes WIP transactions where the resource code does not allow costs as well as costed resources.  And to get all transactions which are missing the WIP accounting entries, even for transactions where the resources are not costed, set the "Only Costed Resources" to No and the Minimum Transaction Amount to zero (0).

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  missing_wip_accounting_transactions.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from         -- Starting transaction date, mandatory
-- |  p_trx_date_to           -- Ending transaction date, mandatory
-- |  p_minimum_amount        -- The absolute smallest transaction amount to be reported
-- |  p_only_costed_resources -- Only include transactions where the resource code is costed. 
-- |  p_org_code              -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit        -- Operating Unit you wish to report, leave blank for all
-- |                             operating units (optional) 
-- |  p_ledger                -- general ledger you wish to report, leave blank for all
-- |                             ledgers (optional)
-- |
-- |  Description:
-- |  Report to find WIP accounting entries where the WIP accounting entries do not
-- |  exist.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     21 Jul 2022 Douglas Volz   Initial Coding based on missing_material_accounting_transactions.sql
-- |  1.1     23 Jul 2022 Douglas Volz   Added Ledger and Operating Unit columns. 
-- +=============================================================================+*/


## Report Parameters
Transaction Date From, Transaction Date To, Minimum Transaction Amount, Only Costed Resources, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Missing WIP Accounting Transactions 23-Jul-2022 161739.xlsx](https://www.enginatics.com/example/cac-missing-wip-accounting-transactions/) |
| Blitz Report™ XML Import | [CAC_Missing_WIP_Accounting_Transactions.xml](https://www.enginatics.com/xml/cac-missing-wip-accounting-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-missing-wip-accounting-transactions/](https://www.enginatics.com/reports/cac-missing-wip-accounting-transactions/) |

## Case Study & Technical Analysis: CAC Missing WIP Accounting Transactions

### Executive Summary
The **CAC Missing WIP Accounting Transactions** report is a diagnostic tool for the Work in Process (WIP) module. It identifies WIP transactions—such as Component Issues, Resource Transactions, and Assembly Completions—that have been processed but failed to generate the corresponding accounting entries in the `WIP_TRANSACTION_ACCOUNTS` table.

### Business Challenge
*   **WIP Valuation**: If a resource is charged to a job ($100 debit to WIP) but no accounting is generated, the WIP General Ledger balance will be understated compared to the operational reality.
*   **Period Close**: Unaccounted transactions can prevent the accounting period from closing or lead to "Sweep" transactions that distort future periods.
*   **Cost Accuracy**: Missing entries mean the job cost is incomplete, leading to incorrect variance calculations upon job close.

### Solution
This report identifies the gaps.
*   **Logic**: Compares `wip_transactions` to `wip_transaction_accounts`.
*   **Resource Filter**: Can optionally ignore "Uncosted" resources (resources set up to not generate costs), reducing false positives.
*   **Scope**: Covers all WIP transaction types.

### Technical Architecture
*   **Tables**: `wip_transactions` (WT), `wip_transaction_accounts` (WTA).
*   **Join**: `WT.transaction_id = WTA.transaction_id (+)`.
*   **Condition**: `WTA.transaction_id IS NULL`.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Period.
*   **Only Costed Resources**: (Mandatory) "Yes" is recommended to avoid seeing transactions for resources that are *designed* to be free.
*   **Minimum Amount**: (Optional) To filter out zero-dollar transactions.

### Performance
*   **Efficient**: Uses standard anti-join logic.
*   **Volume**: WIP transaction volume can be high in manufacturing environments, so date filtering is important.

### FAQ
**Q: How do I fix these?**
A: These often require a data fix from Oracle Support or a specialized script to re-trigger the "WIP Cost Manager".

**Q: Does this include "Move" transactions?**
A: Only if the Move transaction includes a "Resource" charge (Shop Floor Move). Pure moves often do not generate accounting unless they trigger a resource or overhead charge.


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
