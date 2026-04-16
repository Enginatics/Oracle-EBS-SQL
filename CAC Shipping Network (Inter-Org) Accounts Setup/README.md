---
layout: default
title: 'CAC Shipping Network (Inter-Org) Accounts Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for the inter-org shipping network. If the accounts are missing or invalid the account segments are shown as blank entries. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Shipping, Network, (Inter-Org), mtl_interorg_parameters, org_organization_definitions, mtl_parameters'
permalink: /CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/
---

# CAC Shipping Network (Inter-Org) Accounts Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-shipping-network-inter-org-accounts-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show accounts used for the inter-org shipping network.  If the accounts are missing or invalid the account segments are shown as blank entries.

/* +=============================================================================+
-- |  Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_interorg_setup_accts_rept.sql
-- |
-- |  Parameters:
-- |  p_from_org_code       -- Specific from inventory organization you wish to report (optional)
-- |  p_from_operating_unit -- From operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional) 
-- |  Description:
-- |  Report to show accounts used for the inter-org shipping network.  If the
-- |  accounts are missing or invalid the account segments are shown as blank entries.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     28 Oct 2010 Douglas Volz   Added ledger parameter
-- |  1.2     25 Sep 2014 Douglas Volz   Removed mfg_lookup for FOB point, was 
-- |                                     skipping direct transfers
-- |  1.3     07 Jan 2015 Douglas Volz   Minor bug fixes
-- |  1.4     08 Oct 2015 Douglas Volz   Modify for latest client's COA
-- |  1.5     06 Oct 2016 Douglas Volz   Modified for latest client's COA
-- |  1.6     16 Jan 2017 Douglas Volz   Added Internal Order Flag Required,
-- |                                     Elemental Visibility Enabled and
-- |                                     Profit in Inventory Account
-- |  1.7     21 Jan 2017 Douglas Volz   Added Manual Receipt required for expenses flag
-- |  1.8     17 Jul 2018 Douglas Volz   Modified chart of accounts for client
-- |  1.9     16 Oct 2018 Douglas Volz   Retrofitted to Release 11i and added To-Org
-- |                                     Operating Unit
-- |  1.10    18 Oct 2018 Douglas Volz   Added InterOrg Transfer Code and Percentage
-- |  1.11    11 Jul 2019 Douglas Volz   Changed to G/L short name, chg to Release 12
-- |  1.12    17 Jan 2020 Douglas Volz   Add Org Code and Operating Unit parameters.
-- |  1.13    20 Apr 2020 Douglas Volz   Add outer join for gl code combinations, for
-- |                                     invalid or missing accounts (CCIDs).
-- |  1.14    27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/

## Report Parameters
From Org Code, From Operating Unit, From Ledger

## Oracle EBS Tables Used
[mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Shipping Network (Inter-Org) Accounts Setup 08-Jul-2022 195805.xlsx](https://www.enginatics.com/example/cac-shipping-network-inter-org-accounts-setup/) |
| Blitz Report™ XML Import | [CAC_Shipping_Network_Inter_Org_Accounts_Setup.xml](https://www.enginatics.com/xml/cac-shipping-network-inter-org-accounts-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-shipping-network-inter-org-accounts-setup/](https://www.enginatics.com/reports/cac-shipping-network-inter-org-accounts-setup/) |

## Case Study & Technical Analysis: CAC Shipping Network (Inter-Org) Accounts Setup

### Executive Summary
The **CAC Shipping Network (Inter-Org) Accounts Setup** report is a critical financial control report. It documents the configuration of the "Shipping Network"—the rules and accounts that govern inventory transfers between organizations. This setup determines *how* transfers happen (Direct vs. Intransit) and *where* the money goes.

### Business Challenge
*   **Inter-Company Reconciliation**: If Org A (USA) ships to Org B (UK), the Inter-Company Receivable/Payable accounts must be set up correctly to eliminate upon consolidation.
*   **Intransit Visibility**: If the "Intransit Inventory" account is missing or wrong, goods in transit will disappear from the balance sheet.
*   **Transfer Failures**: Transactions will fail in the interface if the required accounts are not defined.

### Solution
This report audits the `mtl_interorg_parameters` table.
*   **Flow**: `From Org` -> `To Org`.
*   **Method**: Intransit (2-step) or Direct (1-step).
*   **FOB Point**: Shipment (Title passes at dock) or Receipt (Title passes at destination).
*   **Accounts**: Inter-Org Receivables, Payables, Intransit Inventory, Transfer Credit.

### Technical Architecture
*   **Tables**: `mtl_interorg_parameters`, `gl_code_combinations`.
*   **Logic**: Checks for null or invalid CCIDs in the setup.

### Parameters
*   **From Org / To Org**: (Optional) Filter specific lanes.

### Performance
*   **Fast**: Configuration data.

### FAQ
**Q: What is "FOB Point"?**
A: "Free On Board". It determines ownership during transit.
    *   FOB Shipment: Receiving Org owns it while on the truck.
    *   FOB Receipt: Shipping Org owns it while on the truck.
**Q: Why are the accounts blank?**
A: If the transfer type is "Direct", Intransit accounts are not required.


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
