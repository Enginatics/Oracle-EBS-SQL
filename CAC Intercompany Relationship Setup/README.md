---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Intercompany Relationship Setup | Oracle EBS SQL Report'
description: 'Report to show accounts used for the intercompany parameters and relationships across operating units. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Intercompany, Relationship, Setup, qp_list_headers_tl, mtl_intercompany_parameters, hr_all_organization_units_vl'
permalink: /CAC%20Intercompany%20Relationship%20Setup/
report_name: 'CAC Intercompany Relationship Setup'
report_web_name: cac-intercompany-relationship-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Intercompany Relationship Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-relationship-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.3     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [mtl_transaction_flow_lines](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_flow_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [mtl_transaction_flow_headers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_flow_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)

## Related Reports
[ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intercompany%20Relationship%20Setup/CAC%20Intercompany%20Relationship%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany Relationship Setup 23-Jun-2022 155938.xlsx](https://www.enginatics.com/example/cac-intercompany-relationship-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) |
| Blitz Report™ XML Import | [CAC_Intercompany_Relationship_Setup.xml](https://www.enginatics.com/xml/cac-intercompany-relationship-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) |
| SQL Source | [CAC Intercompany Relationship Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intercompany%20Relationship%20Setup/CAC%20Intercompany%20Relationship%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-intercompany-relationship-setup/](https://www.enginatics.com/reports/cac-intercompany-relationship-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intercompany-relationship-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
