---
layout: default
title: 'CAC Intercompany Relationship Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for the intercompany parameters and relationships across operating units. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Intercompany, Relationship, Setup, mtl_intercompany_parameters, hr_all_organization_units_vl, mtl_transaction_flow_headers'
permalink: /CAC%20Intercompany%20Relationship%20Setup/
---

# CAC Intercompany Relationship Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-relationship-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show accounts used for the intercompany parameters and relationships across operating units.

/* +=============================================================================+
-- |  Copyright 2018 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_interco_parameters_rept.sql
-- |
-- |  Parameters:
-- |  none
-- |
-- |  Description:
-- |  Report to show accounts used for the intercompany parameters and relationships
-- |  across operating units.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     16 Oct 2018 Douglas Volz   Initial Coding, based on mtl_intercompany_parameters_v
-- |  1.1      7 Mar 2020 Douglas Volz   Add Advanced Accounting Option based on view
-- |                                     mtl_transaction_flows_v.
-- |  1.2     27 Apr 2020 Douglas Volz   Changed to multi-language views for the
-- |                                     inventory orgs and operating units.
-- +=============================================================================+*/

## Report Parameters


## Oracle EBS Tables Used
[mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_transaction_flow_headers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_flow_headers), [mtl_transaction_flow_lines](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_flow_lines), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation 11i](/INV%20Intercompany%20Invoice%20Reconciliation%2011i/ "INV Intercompany Invoice Reconciliation 11i Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany Relationship Setup 23-Jun-2022 155938.xlsx](https://www.enginatics.com/example/cac-intercompany-relationship-setup/) |
| Blitz Report™ XML Import | [CAC_Intercompany_Relationship_Setup.xml](https://www.enginatics.com/xml/cac-intercompany-relationship-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-intercompany-relationship-setup/](https://www.enginatics.com/reports/cac-intercompany-relationship-setup/) |

## Case Study & Technical Analysis: CAC Intercompany Relationship Setup

### Executive Summary
The **CAC Intercompany Relationship Setup** report provides a comprehensive visualization of the intercompany accounting configuration within Oracle E-Business Suite. It details the complex web of relationships, transaction flows, and account mappings between different operating units and inventory organizations. This report is essential for Finance and Supply Chain teams to verify that intercompany transactions will be accounted for correctly, ensuring accurate financial consolidation and reconciliation.

### Business Challenge
Intercompany transactions (e.g., shipping from one legal entity to another) require precise setup in Oracle Inventory and Intercompany Invoicing.
*   **Configuration Complexity**: The setup involves multiple screens (Intercompany Relations, Shipping Networks, Transaction Flows) and is prone to human error.
*   **Reconciliation Nightmares**: Incorrect account mappings can lead to imbalances between Intercompany Receivables (AR) and Payables (AP), causing month-end close delays.
*   **Visibility Gap**: There is no standard Oracle report that provides a holistic view of the entire intercompany topology and associated GL accounts in a single output.

### Solution
This report bridges the visibility gap by extracting and consolidating intercompany setup data.
*   **Holistic View**: Displays the "From" and "To" Operating Units, the specific Inventory Organizations involved, and the Transaction Flow types.
*   **Account Verification**: Lists the specific GL accounts (COGS, Accrual, Receivables, Payables) configured for each relationship.
*   **Customer/Vendor Mapping**: Validates the mapping of internal Customers and Vendors required for Intercompany Invoicing.

### Technical Architecture
The SQL logic navigates the complex schema of Oracle Intercompany setup:
*   **Data Sources**: Queries `mtl_intercompany_parameters`, `mtl_transaction_flow_headers`, and `mtl_transaction_flow_lines`.
*   **Entity Resolution**: Joins with `hr_all_organization_units_vl` for Operating Unit names and `mtl_parameters` for Inventory Organization details.
*   **Trading Partners**: Links to `po_vendors` and `hz_parties` to show the trading partner definitions associated with the intercompany flows.

### Parameters
*   **None**: The report is designed to dump the complete intercompany configuration for the accessible entities, providing a full system landscape view.

### Performance
*   **Lightweight Execution**: As a configuration report, it queries setup tables which are generally small in volume compared to transaction tables.
*   **Fast Retrieval**: Returns results almost instantly, making it an excellent tool for ad-hoc troubleshooting during setup or testing phases.

### FAQ
**Q: Does this report show the actual intercompany transactions?**
A: No, this is a *setup* validation report. It shows how the system is configured to handle transactions, not the transactions themselves.

**Q: Why are some accounts missing in the output?**
A: If accounts are missing, it indicates a gap in the Oracle setup. This report highlights those gaps so they can be fixed before transactions occur.

**Q: Does it cover Advanced Accounting (Transaction Flows)?**
A: Yes, the report includes logic to display Advanced Accounting options derived from `mtl_transaction_flows_v`.


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
