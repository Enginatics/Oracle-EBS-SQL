---
layout: default
title: 'CAC Item List Price vs. Item Cost | Oracle EBS SQL Report'
description: 'Compare item master list price against any cost type (Cost Type 1) and also list the Standard Price (Market Price), Last PO Price, Converted Last PO Price…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, List, Price, cst_item_costs, cst_cost_types, mtl_system_items_vl'
permalink: /CAC%20Item%20List%20Price%20vs-%20Item%20Cost/
---

# CAC Item List Price vs. Item Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-list-price-vs-item-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Compare item master list price against any cost type (Cost Type 1) and also list the Standard Price (Market Price), Last PO Price, Converted Last PO Price and a secondary cost type (Cost Type 2).  All item costs and prices are in the primary UOM, using the To Currency Code.

-- | Program Name: xxx_item_target_cost_review_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type1             -- The first comparison cost type you wish to report
-- |  p_cost_type2             -- The second comparison cost type you wish to report
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed items
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    29 Sep 2020 Douglas Volz   Initial Coding based on Item Cost Summary Report
-- |  1.1    22 Oct 2020 Douglas Volz   Added the Master Target Price
-- |  1.2    26 Oct 2020 Douglas Volz   Changed as List Price is always in a common, global
-- |                                    currency, translate to this "to_currency" currency
-- |  1.3    28 Oct 2020 Douglas Volz   Fixes for the last PO, need to exclude Cancelled
-- |                                    PO Lines.  
-- |  1.4    30 Oct 2020 Douglas Volz   Add To Currency Code as a visible parameter and
-- |                                    show all item costs in that currency
-- |  1.5    04 Dec 2020 Douglas Volz   Outer join fix for PO joins to item master and
-- |                                    currency exchange rates.
-- |  1.6    06 Dec 2020 Douglas Volz   Added Target Price Percent Difference column.
+=============================================================================+*/

## Report Parameters
Comparison Cost Type, Additional Cost Type, To Currency Code, Currency Conversion Type, Currency Conversion Date, Include Uncosted Items, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item List Price vs. Item Cost 24-Jun-2022 024533.xlsx](https://www.enginatics.com/example/cac-item-list-price-vs-item-cost/) |
| Blitz Report™ XML Import | [CAC_Item_List_Price_vs_Item_Cost.xml](https://www.enginatics.com/xml/cac-item-list-price-vs-item-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-list-price-vs-item-cost/](https://www.enginatics.com/reports/cac-item-list-price-vs-item-cost/) |

## Case Study & Technical Analysis: CAC Item List Price vs. Item Cost

### Executive Summary
The **CAC Item List Price vs. Item Cost** report is a margin analysis tool that compares the official List Price (from the Item Master) against the Item Cost (Standard or Average). It also brings in the "Last PO Price" to provide a market-based reference point. This report is essential for ensuring that pricing strategies are aligned with current cost realities.

### Business Challenge
Maintaining healthy margins requires constant vigilance.
*   **Price Drift**: List prices often remain static while costs fluctuate.
*   **Currency Complexity**: A global price list in USD needs to be compared against manufacturing costs in EUR, JPY, etc.
*   **Market Reality**: The Standard Cost might be outdated; comparing against the "Last PO Price" gives a better indication of the current replacement cost.

### Solution
This report provides a multi-dimensional view of value.
*   **Currency Normalization**: Converts all figures (List Price, Cost, PO Price) to a single "To Currency" for accurate comparison.
*   **Triple Comparison**:
    1.  List Price vs. Cost Type 1 (e.g., Frozen)
    2.  List Price vs. Cost Type 2 (e.g., Pending)
    3.  List Price vs. Last PO Price
*   **Margin Calculation**: Automatically calculates the margin percentage for each comparison.

### Technical Architecture
The report integrates data from three distinct modules:
*   **Inventory**: `mtl_system_items` for List Price.
*   **Costing**: `cst_item_costs` for the internal cost.
*   **Purchasing**: `po_lines_all` (and related tables) to find the most recent Purchase Order for the item.
*   **GL**: `gl_daily_rates` for currency conversion.

### Parameters
*   **Cost Type 1**: (Mandatory) Primary cost for comparison.
*   **Cost Type 2**: (Optional) Secondary cost (e.g., Simulation).
*   **To Currency Code**: (Mandatory) The target currency for reporting.
*   **Currency Conversion Date**: (Mandatory) The date to use for exchange rates.

### Performance
*   **PO Lookup**: Finding the "Last PO" for every item can be resource-intensive. The report uses optimized logic to find the latest approved PO line.
*   **Currency**: Requires a valid exchange rate for the specified date; otherwise, conversion may fail or return null.

### FAQ
**Q: Which List Price does it use?**
A: It uses the `list_price_per_unit` field from the Master Item table (`mtl_system_items`). It does not look at Advanced Pricing modifiers.

**Q: Why is the Last PO Price blank?**
A: If the item has never been purchased (e.g., it's a Make item or a new item), there will be no PO history.

**Q: Does it include tax?**
A: Generally, Oracle PO prices and Item Costs exclude recoverable taxes (VAT/GST).


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
