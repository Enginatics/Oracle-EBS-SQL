---
layout: default
title: 'CAC Intercompany SO Price List | Oracle EBS SQL Report'
description: 'Report to show the intercompany sales order (SO) price list information, including the item number, price list name and related information. Price list…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Intercompany, Price, List, select, hz_cust_site_uses_all, hz_cust_accounts'
permalink: /CAC%20Intercompany%20SO%20Price%20List/
---

# CAC Intercompany SO Price List – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intercompany-so-price-list/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the intercompany sales order (SO) price list information, including the item number, price list name and related information.  Price list parameter list of values are from the Intercompany Relationship Setups (from Oracle Inventory), per the price lists associated with the internal customers.

/* +=============================================================================+
-- |  Copyright 2010 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_so_price_list_rept.sql
-- |
-- |  Parameters:
-- |  p_price_effective_date -- Date the sales order list prices are effective, mandatory.
-- |  p_price_list           -- Specific intercompany price list name to report
-- |  p_item_number          -- Specific item number you wish to report, optional.
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- | 
-- |  Description:
-- |  Report to show the SO price list information, including the item number, price
-- |  list name and related information.
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 19 Sep 2010 Douglas Volz   Created initial Report based on qp_price_list_lines_v
-- |      1.1 15 Dec 2010 Douglas Volz   Cleaned up report for BO Repository
-- |      1.2 22 Dec 2010 Douglas Volz   Fix for the Price End Date logic, change
-- |                                     sysdate to '&p_price_effective_date' to
-- |      1.3 01 Dec 2014 Douglas Volz   Add Item Type column
-- |      1.4 15 Oct 2018 Douglas Volz   Get price list Ids based on intercompany
-- |                                     relationships, as opposed to hard-coding
-- |      1.5 16 Oct 2018 Douglas Volz   And get prices from Customer default price
-- |                                     list from hz_cust_accounts
-- |      1.6 20 Nov 2018 Douglas Volz   Get Item Type from fnd_common_lookups as
-- |                                     fnd_lookup_values as a duplicate 'KIT'
-- |      1.7 11 Dec 2018 Douglas Volz   Avoid using the qp_price_list_pvt package,
-- |                                     to see if this is faster.  Use the query
-- |                                     to finding the price list headers as the
-- |                                     driving query or table, including the hint
-- |                                     to make the price list header the driving table
-- |      1.8 17 Jun 2019 Douglas Volz   Replace Oracle function 
-- |                                     apps.qp_price_list_pvt.get_product_uom_code
-- |                                     with "qpa.product_uom_code".
-- |      1.9 18 Sep 2019 Douglas Volz   Added item status column and item categories
-- |     1.10 09 Jul 2022 Douglas Volz   Changed back to Oracle QP price packages, to
-- |                                     get price list information based on both
-- |                                     categoryor item-specific price lists.
-- +=============================================================================+*/

## Report Parameters
Price Effective Date, Intercompany Price List, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[select](https://www.enginatics.com/library/?pg=1&find=select), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [qp_list_headers_b](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_b), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl), [qp_list_lines](https://www.enginatics.com/library/?pg=1&find=qp_list_lines), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intercompany SO Price List 08-Jul-2022 221636.xlsx](https://www.enginatics.com/example/cac-intercompany-so-price-list/) |
| Blitz Report™ XML Import | [CAC_Intercompany_SO_Price_List.xml](https://www.enginatics.com/xml/cac-intercompany-so-price-list/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-intercompany-so-price-list/](https://www.enginatics.com/reports/cac-intercompany-so-price-list/) |

## Case Study & Technical Analysis: CAC Intercompany SO Price List

### Executive Summary
The **CAC Intercompany SO Price List** report is a specialized pricing audit tool designed for organizations managing complex intercompany supply chains. It provides a detailed view of the price lists associated with intercompany transactions, linking items to their specific price list definitions as determined by the intercompany relationship setups in Oracle Inventory. This report is crucial for ensuring that transfer prices between internal entities are correctly defined and maintained.

### Business Challenge
In a multi-entity environment, transfer pricing is a critical component of financial compliance and profitability analysis.
*   **Setup Complexity**: Intercompany price lists are assigned through complex relationships involving Customer and Supplier definitions linked to Inventory Organizations.
*   **Pricing Visibility**: It is often difficult to determine exactly which price list is active for a specific item and intercompany relationship without navigating through multiple Oracle forms.
*   **Maintenance Overhead**: Keeping thousands of intercompany prices up-to-date requires constant vigilance to prevent transaction errors or incorrect financial postings.

### Solution
This report simplifies the management of intercompany pricing by exposing the effective price list configuration.
*   **Relationship-Driven**: It derives the relevant price lists directly from the Intercompany Relationship setups, ensuring the report reflects the actual system behavior.
*   **Detailed Pricing**: Displays the Item Number, Price List Name, Price, and Effective Dates.
*   **Validation**: Helps users verify that the correct price list is being picked up for specific items and categories.

### Technical Architecture
The report logic mimics the Oracle pricing engine's retrieval method:
*   **Core Tables**: Joins `qp_list_headers_vl` and `qp_list_lines` (or `qp_price_list_lines` in older versions) to fetch pricing data.
*   **Context Derivation**: Uses `mtl_intercompany_parameters` to identify the valid price lists based on the internal customer relationships.
*   **Item Context**: Links with `mtl_system_items_vl` to provide item descriptions and category information.

### Parameters
*   **Price Effective Date**: (Mandatory) The date for which you want to see the active prices.
*   **Price List**: (Optional) Filter for a specific intercompany price list.
*   **Item Number**: (Optional) Check the price for a specific item.
*   **Category Set 1 & 2**: (Optional) Filter by item categories (e.g., Product Line, Inventory Category).

### Performance
*   **Optimized Retrieval**: The query is structured to drive from the Price List Header, which is generally the most efficient access path for this type of data.
*   **Selective Joins**: Filters by effective date early in the process to minimize the volume of price lines processed.

### FAQ
**Q: Does this show customer price lists?**
A: It focuses on price lists associated with *internal* customers used for intercompany transactions, but the underlying mechanism is the same as standard customer pricing.

**Q: Why is the Price Effective Date mandatory?**
A: Price lists are date-sensitive. The system needs a specific reference date to determine which price line is active.

**Q: Can I see expired prices?**
A: Yes, if you set the Price Effective Date to a date in the past.


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
