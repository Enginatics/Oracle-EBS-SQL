---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Calculate ICP PII Item Costs by Where Used | Oracle EBS SQL Report'
description: 'Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item. Gets the PII item…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Calculate, ICP, PII, cst_item_cost_details, cst_cost_types, bom_resources'
permalink: /CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/
report_name: 'CAC Calculate ICP PII Item Costs by Where Used'
report_web_name: cac-calculate-icp-pii-item-costs-by-where-used
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Calculate ICP PII Item Costs by Where Used – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Gets the PII item costs by joining the sourcing rule information from the first "hop" from the sourcing rule information to the second "hop".  In addition, if an item has a source org in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.  And while calculating the profit in inventory item costs, this report also shows where these components are being used on the To Org bills of material.

Parameters:
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
From (Source) Organization:  the source organization where the goods come from (optional).
To Organization:  the organization where the goods are being shipped to (optional).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Currency Conversion Date:  the exchange rate conversion date that was used to set the standard costs (mandatory).
Currency Conversion Type:  the exchange rate conversion type that was used to set the standard costs (mandatory).
Period Name:   the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes (mandatory).
Include Transfers to Same OU:  allows you to include or exclude transfers within the same Operating Unit (OU).  Defaulted to not include these internal transfers.
Include Expense Items:  enter Yes or No to indicate if you want to include expense items on the bills of material (mandatory).  Defaulted to No.
Include Uncosted Items:  enter Yes or No to indicate if you want to include uncosted items on the bills of material (mandatory).  Defaulted to No. 
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Component Number:  enter the specific component(s) you wish to report (optional).
Assembly Number:  enter the specific assembly or assemblies you wish to report (optional).
Include Unimplemented ECOs:  enter Yes or No to indicate if you want to include engineering changes which have not been implemented (mandatory).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

Hidden Parameters:
Numeric Sign for PII:  to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount (mandatory).

-- |  Copyright 2018 - 2024 Douglas Volz Consulting, Inc., all rights reserved.
-- |  Permission to use this code is granted provided the original author is  acknowledged. No warranties, express or otherwise is included in this permission. 
-- |  
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.6     29 Jan 2024 Doug Volz      Remove tabs, add org access controls, fix for G/L Daily Rates,
-- |                                     Make three parameters non-hidden:  Include Transfers to Same OU, Include Expense Items and Include Uncosted Items.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Assignment Set, From (Source) Organization, To Organization, Cost Type, PII Cost Type, PII Sub-Element, Currency Conversion Date, Currency Conversion Type, Period Name, Include Transfers to Same OU, Include Uncosted Items, Include Expense Items, Category Set 1, Category Set 2, Category Set 3, Component Number, Assembly Number, Include Unimplemented ECOs, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs Multi-Hop](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop/ "CAC Calculate ICP PII Item Costs Multi-Hop Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Calculate ICP PII Item Costs by Where Used 20-May-2023 Vision 021803.xlsx](https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-by-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) |
| Blitz Report™ XML Import | [CAC_Calculate_ICP_PII_Item_Costs_by_Where_Used.xml](https://www.enginatics.com/xml/cac-calculate-icp-pii-item-costs-by-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) |
| SQL Source | [CAC Calculate ICP PII Item Costs by Where Used.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used) |

## Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs by Where Used

### Executive Summary
The **CAC Calculate ICP PII Item Costs by Where Used** report extends the functionality of the standard PII calculation by integrating it with the Bill of Materials (BOM) structure. It not only identifies the Intercompany Profit (ICP/PII) for specific items but also traces these items upwards to see which parent assemblies consume them. This is critical for understanding how intercompany profits roll up into finished goods and for validating the cost structure of complex manufactured products that rely on intercompany transfers.

### Business Challenge
While knowing the PII for a specific component is useful, organizations often need to know:
*   **Impact Analysis:** Which finished goods are affected by a change in the transfer price of a raw material or sub-assembly?
*   **Cost Rollup Validation:** Are the intercompany profits correctly propagating through the multi-level BOMs?
*   **Inventory Valuation:** How much PII is embedded in the on-hand inventory of finished goods, not just the components themselves?
*   **Sourcing Visibility:** Which specific assemblies are driving the demand for intercompany transfers?

### The Solution
This report provides a multi-dimensional view of PII:
*   **Component-Level PII:** Calculates the PII for the transferred item (Component) using the same robust logic as the base PII report (Sourcing Rules + Cost Comparison).
*   **Where-Used Traceability:** Links the component to its parent Assembly via the BOM, showing the quantity per assembly and yield.
*   **Contextual Data:** Displays on-hand quantities for the source component, giving a sense of the potential financial magnitude.
*   **Flexible Filtering:** Allows users to filter by specific components or assemblies to perform targeted investigations.

### Technical Architecture (High Level)
The report combines supply chain network logic with manufacturing data.
*   **Sourcing Engine:** Uses `MRP_SOURCING_RULES` and `MRP_ASSIGNMENT_SETS` to determine the "Source Org" and "To Org" relationship for the component.
*   **BOM Explosion:** Queries `BOM_STRUCTURES_B` and `BOM_COMPONENTS_B` to identify the parent-child relationships in the "To Org".
*   **Cost Calculation:**
    *   Retrieves the *Source Item Cost* (minus upstream PII).
    *   Converts it to the *To Org Currency* using `GL_DAILY_RATES`.
    *   Compares it against the *To Org Net Item Cost* to derive the *Calculated To Org PII*.
*   **Inventory Integration:** Joins with `MTL_ONHAND_QUANTITIES_DETAIL` to provide a snapshot of the component's availability in the source organization.

### Parameters & Filtering
The report offers granular control for detailed analysis:
*   **Assignment Set:** Defines the sourcing network to be analyzed.
*   **Cost Types:** Specifies the standard cost type (e.g., Frozen) and the PII cost type for comparison.
*   **BOM Filters:**
    *   *Component Number:* Focus on a specific raw material or sub-assembly.
    *   *Assembly Number:* Focus on a specific finished good.
    *   *Include Expense/Uncosted Items:* Toggles to include non-standard inventory items in the BOM structure.
    *   *Include Unimplemented ECOs:* Option to see future BOM changes.
*   **Organization Context:** From/To Organization, Operating Unit, and Ledger filters.

### Performance & Optimization
*   **Efficient Joins:** The query structure is optimized to handle the complex joins between MRP, BOM, and Costing tables.
*   **Selective Aggregation:** On-hand quantities are aggregated at the sub-query level to prevent row explosion before joining to the main dataset.
*   **Date Effectivity:** Respects the `EFFECTIVE_FROM` and `EFFECTIVE_TO` dates on BOM components to ensure only currently valid relationships are reported.

### FAQ
**Q: How is this different from the "CAC Calculate ICP PII Item Costs" report?**
A: The base report lists PII for items in a flat list. This report adds the "Where Used" dimension, showing you *which assemblies* consume those items. It's a "bottom-up" view of your product structure with PII data attached.

**Q: Why do I see "Quantity per Assembly"?**
A: This field allows you to calculate the total PII impact on one unit of the parent assembly (PII per unit * Quantity per Assembly).

**Q: Can I use this to find items with missing sourcing rules?**
A: Yes, if an item exists in a BOM but has no sourcing rule defined (and thus no calculated PII where expected), it can highlight gaps in your supply chain setup.

**Q: Does it handle phantom assemblies?**
A: The report logic respects the BOM structure. If phantom assemblies are part of the structure, their components would typically be blown through, but this report focuses on the direct parent-child link defined in the BOM tables.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-by-where-used)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
