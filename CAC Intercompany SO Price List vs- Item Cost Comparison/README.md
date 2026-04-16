---
layout: default
title: 'CAC Intercompany SO Price List vs. Item Cost Comparison | Oracle EBS SQL Report'
description: 'Report to show the internal SO price lists, source org item costs and compare against the "To Org" item costs and PII (profit in inventory) amounts. This…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Intercompany, Price, List, hz_cust_site_uses_all, mtl_intercompany_parameters, hz_cust_acct_sites_all'
permalink: /CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/
---

# CAC Intercompany SO Price List vs. Item Cost Comparison – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-so-price-list-vs-item-cost-comparison/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the internal SO price lists, source org item costs and compare against the "To Org" item costs and PII (profit in inventory) amounts.  This report is used to ensure the profit in inventory (PII) cost model is working correctly.

Parameters:
===========
Price Effective Date: the date the sales order list prices are effective (mandatory).
Currency Conversion Date:  the exchange rate conversion date to use to convert the sales price to the same currency as the item cost (mandatory).
Currency Conversion Type:  the desired currency conversion type to use to convert the sales price to the same currency as the item cost (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
Category Set:  any item category you wish, typically the Cost or Product Line category set (optional).
Item Number:  enter the specific item numbers(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
To Org Code:  enter the specific To Org you wish to report (optional).
To Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
To Org Ledger:  enter the specific "To Org" ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2010 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_so_price_cost_pii_rept.sql
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== =========================================
-- |     1.0  26 Nov 2010 Douglas Volz    Created initial Report
-- |    1.18 13 Dec 2018 Douglas Volz     Add Source Org OU to the InterCo_OUs inline table, to ensure 
-- |                                      uniqueness.  Add Source Org joins for Src_Org item costs.
-- |                                      Removed Release 11i edits.  Replaced gl.name with gl.short_name.
-- |    1.19 17 Jun 2019 Douglas Volz     Replace Oracle function apps.qp_price_list_pvt.get_product_uom_code
-- |                                      with "and ucr.uom_code = qpa.product_uom_code".  Comment out Source
-- |                                      and To Org Added Costs columns.
-- |    1.20 21 Aug 2019 Douglas Volz     Removed client-specific SQL logic.
-- |    1.21 25 Oct 2019 Douglas Volz     Correction to p_price_effective_date parameter
-- |    1.22 17 Jul 2022 Douglas Volz     Changes for multi-language lookup values.  Changed
-- |                                      back to Oracle QP price packages, to get price list
-- |                                      information based on both category or item-specific price lists.
-- |    1.23 28 Nov 2023 Andy Haack       Added G/L security for the "To Org" G/L and removed tabs.
-- |    1.24 06 Feb 2024 Douglas Volz     Fix for G/L Daily Rates and add "To Org" inventory security.
-- |    1.25 25 Jun 2024 Douglas Volz     Reinstall missing parameters, Item Number and To Operating Unit.
-- +=============================================================================+*/

## Report Parameters
Price Effective Date, Currency Conversion Date, Currency Conversion Type, PII Cost Type, PII Sub-Element, Assignment Set, Cost Type, Category Set, Item Number, To Org Code, To Operating Unit, To Org Ledger

## Oracle EBS Tables Used
[hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [mtl_intercompany_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_intercompany_parameters), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [qp_list_headers_b](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_b), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl), [qp_list_lines](https://www.enginatics.com/library/?pg=1&find=qp_list_lines), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_category_sets_tl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_tl), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany SO Price List vs. Item Cost Comparison 11-Jul-2022 140147.xlsx](https://www.enginatics.com/example/cac-intercompany-so-price-list-vs-item-cost-comparison/) |
| Blitz Report™ XML Import | [CAC_Intercompany_SO_Price_List_vs_Item_Cost_Comparison.xml](https://www.enginatics.com/xml/cac-intercompany-so-price-list-vs-item-cost-comparison/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-intercompany-so-price-list-vs-item-cost-comparison/](https://www.enginatics.com/reports/cac-intercompany-so-price-list-vs-item-cost-comparison/) |

## Case Study & Technical Analysis: CAC Intercompany SO Price List vs. Item Cost Comparison

### Executive Summary
The **CAC Intercompany SO Price List vs. Item Cost Comparison** report is a high-value financial control tool used to validate the "Profit in Inventory" (PII) cost model. It performs a three-way comparison between the Internal Sales Order (ISO) price, the Source Organization's item cost, and the Destination Organization's item cost. This ensures that intercompany margins are calculated correctly and that the transfer price covers the cost of goods sold plus the intended markup.

### Business Challenge
Global organizations often move goods between entities with a markup (Profit in Inventory).
*   **Margin Integrity**: If the transfer price (Price List) is lower than the source cost, the sending entity loses money on the transfer.
*   **PII Accuracy**: The "Profit in Inventory" element in the destination cost must accurately reflect the difference between the transfer price and the source cost.
*   **Currency Fluctuations**: Comparing costs and prices across different currencies (e.g., USD to EUR) adds a layer of complexity that manual spreadsheets struggle to handle.

### Solution
This report automates the complex reconciliation of intercompany costs and prices.
*   **Currency Conversion**: Automatically converts sales prices to the same currency as the item cost using a user-specified exchange rate and date.
*   **PII Validation**: Explicitly calculates and reports the PII amount, allowing for immediate verification against the PII Cost Type.
*   **Sourcing Logic**: Uses the Assignment Set to determine the valid sourcing rules, ensuring the comparison reflects the actual supply chain flow.

### Technical Architecture
The report executes a sophisticated analysis across multiple modules:
*   **Pricing**: Retrieves data from `qp_list_headers` and `qp_list_lines`.
*   **Costing**: Queries `cst_item_costs` for both the Source and Destination organizations.
*   **Sourcing Rules**: Integrates with `mrp_sourcing_rules` and `mrp_sr_assignments` to identify the valid supply paths.
*   **GL Integration**: Uses `gl_daily_rates` to handle currency conversions dynamically.

### Parameters
*   **Price Effective Date**: (Mandatory) Date for price lookup.
*   **Currency Conversion Date/Type**: (Mandatory) Parameters to standardize the currency for comparison.
*   **PII Cost Type**: (Mandatory) The cost type holding the profit element (e.g., 'PII').
*   **Cost Type**: (Mandatory) The standard cost type (e.g., 'Frozen').
*   **Assignment Set**: (Mandatory) Defines the supply chain network to analyze.

### Performance
*   **Complex Calculation**: This is a computation-heavy report due to the need to resolve sourcing rules and perform currency conversions for every item.
*   **Strategic Use**: Best run for specific categories or operating units rather than a full database dump, especially in large environments.

### FAQ
**Q: What is PII?**
A: Profit in Inventory (PII) represents the intercompany profit included in the inventory value of the receiving organization. It must be eliminated for consolidated financial reporting.

**Q: Why do I need an Assignment Set?**
A: The Assignment Set tells the report which Source Organization supplies the Destination Organization, which is essential for picking the correct source cost for comparison.

**Q: Does it handle different currencies?**
A: Yes, the report includes mandatory parameters for Currency Conversion Date and Type to normalize all figures to a single currency.


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
