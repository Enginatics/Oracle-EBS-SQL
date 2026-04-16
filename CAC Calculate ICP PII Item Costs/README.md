---
layout: default
title: 'CAC Calculate ICP PII Item Costs | Oracle EBS SQL Report'
description: 'Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item. Report gets the PII…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Calculate, ICP, PII, gl_ledgers, mrp_sourcing_rules, mrp_sr_receipt_org_v'
permalink: /CAC%20Calculate%20ICP%20PII%20Item%20Costs/
---

# CAC Calculate ICP PII Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Report gets the PII item costs across organizations, by joining the sourcing rule information from the first "hop" to the sourcing rule information to the second "hop".  In addition, if an item has a source organization in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.

Note:  there is one hidden parameter: 
1) Numeric Sign for PII which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts.  Defaulted as positive (+1).

Displayed Parameters:
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).  May or may not be the same as the Cost Type parameter.
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Currency Conversion Date:  the exchange rate conversion date that was used to set the standard costs (mandatory).
Currency Conversion Type:  the exchange rate conversion type that was used to set the standard costs (mandatory).
Period Name:  the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes (mandatory).
Include Transfers to Same OU:  allows you to include or exclude transfers within the same Operating Unit (OU).  Defaulted to include these internal transfers.
From Organization: the shipping from inventory organization you wish to report (optional).
To Organization: the shipping to inventory organization you wish to report (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set.
Category Set 2:  the second item category set to report, typically the Inventory Category Set.
Item Number:  enter a specific item number you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2009-23 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     26 Sep 2009 Douglas Volz   Initial Coding
-- | 1.34     05 May 2021 Douglas Volz   Add Make Buy Code.
-- | 1.35    26 Feb 2022 Douglas Volz   Add category sets and To Org and From Org
-- |                                    parameters. Add two hidden parameters,
-- |                                    Include Same OU Transfers and set Sign
-- |                                    for PII Amounts (p_sign_pii), to determine 
-- |                                    if PII is entered as a positive or negative.
-- | 1.36     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins
-- | 1.37     28 Jan 2024 Douglas Volz   Make Include Transfers to Same OU a displayed parameter. 
+=============================================================================+*/

## Report Parameters
Assignment Set, Cost Type, PII Cost Type, PII Sub-Element, Currency Conversion Date, Currency Conversion Type, Period Name, Include Transfers to Same OU, From Organization, To Organization, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_receipt_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org_v), [mrp_sr_source_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org_v), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Calculate ICP PII Item Costs 26-Jun-2023 171332.xlsx](https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs/) |
| Blitz Report™ XML Import | [CAC_Calculate_ICP_PII_Item_Costs.xml](https://www.enginatics.com/xml/cac-calculate-icp-pii-item-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/) |

## Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs

### Executive Summary
The **CAC Calculate ICP PII Item Costs** report is a specialized financial tool designed for multinational corporations with complex intercompany supply chains. It calculates the **Profit in Inventory (PII)**, also known as Intercompany Profit (ICP), embedded in the standard costs of items as they move between inventory organizations. By analyzing sourcing rules and cost structures across "hops" (transfer points), this report enables finance teams to accurately eliminate intercompany profits for consolidated financial reporting and ensure transfer pricing compliance.

### Business Challenge
In multi-entity organizations, goods are often transferred between subsidiaries at a markup (transfer price). While this markup is recognized as revenue for the selling entity, it represents an unrealized profit for the consolidated group until the goods are sold to an external customer. Challenges include:
*   **Unrealized Profit Tracking:** Difficulty in identifying how much of an item's standard cost is actually intercompany profit.
*   **Currency Fluctuations:** Complexity in converting costs from source to destination currencies using specific historical rates.
*   **Multi-Leg Transfers:** Tracking costs through multiple layers of the supply chain (e.g., Factory -> Hub -> Distribution Center).
*   **Compliance:** Ensuring that inventory valuations exclude internal profits for regulatory reporting.

### The Solution
The **CAC Calculate ICP PII Item Costs** report provides a granular view of intercompany profit at the item level. It allows users to:
*   **Trace Sourcing:** Automatically identifies the source organization for each item based on MRP Sourcing Rules and Assignment Sets.
*   **Calculate PII:** Computes the PII amount by comparing the source organization's cost (minus its own upstream PII) with the destination organization's cost.
*   **Handle Currencies:** Applies specific currency conversion rates (e.g., corporate rates at the time of standard setting) to ensure accurate cross-border cost comparisons.
*   **Simulate Adjustments:** Helps in calculating the necessary adjustments to the "PII" cost element to align with the calculated values.

### Technical Architecture (High Level)
The report logic is built around the concept of "hops" in the supply chain.
*   **Sourcing Logic:** It queries `MRP_SOURCING_RULES`, `MRP_SR_ASSIGNMENTS`, and related views to determine the flow of goods (Source Org $\rightarrow$ Destination Org).
*   **Cost Extraction:** It retrieves item costs from `CST_ITEM_COSTS` for both the source and destination organizations.
*   **PII Calculation:**
    *   *Source Cost Basis:* Takes the Source Org's total cost and subtracts any existing PII (to avoid cascading profit on profit).
    *   *Currency Conversion:* Converts the Source Cost Basis to the Destination Org's currency using `GL_DAILY_RATES`.
    *   *Comparison:* Compares the converted source cost with the destination's standard cost components to isolate the profit margin.
*   **Sign Handling:** Uses a hidden parameter (`p_sign_pii`) to handle different conventions for storing PII (positive or negative values).

### Parameters & Filtering
The report requires specific configuration to yield accurate results:
*   **Assignment Set:** The specific set of sourcing rules to use for determining the supply chain network.
*   **Cost Types:**
    *   *Cost Type:* The main standard cost type (e.g., Frozen).
    *   *PII Cost Type:* The specific cost type where PII values are stored/reported.
*   **PII Sub-Element:** The specific cost sub-element (resource or overhead) used to track PII.
*   **Currency Settings:** Conversion Date and Type to align with the organization's standard setting policy.
*   **Include Transfers to Same OU:** A toggle to include or exclude transfers within the same Operating Unit (often treated differently for tax purposes).

### Performance & Optimization
*   **Materialized Views:** Relies on MRP views (`MRP_SR_RECEIPT_ORG_V`, `MRP_SR_SOURCE_ORG_V`) which abstract complex sourcing logic but require efficient indexing on assignment sets.
*   **Organization Filtering:** Filters out disabled organizations and inactive items early in the process to reduce processing overhead.
*   **Outer Joins:** Uses outer joins for sourcing rules to ensure that items with defined source orgs in the item master (but no specific sourcing rule) are still captured if applicable.

### FAQ
**Q: What is "PII" or "ICP"?**
A: PII stands for Profit in Inventory, and ICP stands for Intercompany Profit. They refer to the profit margin added by a selling entity within the same corporate group, which must be eliminated for consolidated reporting.

**Q: How does the report handle currency conversion?**
A: It uses the *Currency Conversion Date* and *Type* parameters to look up rates in the General Ledger. This is crucial because standard costs are often set using a fixed exchange rate for the year.

**Q: Does this report update the costs?**
A: No, it is a calculation and reporting tool. The results are typically used to create a mass update (e.g., via an interface or API) to adjust the PII cost elements in the system.

**Q: Why is there a "Sign for PII" parameter?**
A: Different implementations track PII differently—some as a positive cost element (additive) and others as a contra-asset (negative). This parameter ensures the math works correctly for your specific setup.


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
