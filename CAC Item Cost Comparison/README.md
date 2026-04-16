---
layout: default
title: 'CAC Item Cost Comparison | Oracle EBS SQL Report'
description: 'Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, Cost, Comparison, gl_daily_rates, gl_daily_conversion_types, cst_item_costs'
permalink: /CAC%20Item%20Cost%20Comparison/
---

# CAC Item Cost Comparison – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-comparison/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To Org).  Put the smallest cost type into Cost Type 1, as the values for cost type 1 are always reported even if not in cost type 2.  Note that the Source Org and the Compared To Org default from the inventory organization as set for your session.

/* +=============================================================================+
-- |  Copyright 2006 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       | 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_org_code1            -- The inventory organization that is the source
-- |  p_org_code2            -- The inventory organization that is the target 
-- |  p_cost_type1           -- The source comparison cost type
-- |  p_cost_type2           -- The target comparison cost type
-- |  p_curr_conv_type       -- Conversion conversion type, to convert the Source
-- |                            org, org_code1, into the currency of the To_Org,
-- |                            org_code2
-- |  p_curr_conv_date       -- The currency conversion date, typically a month-end
-- |                            date
-- |  p_min_cost_diff        -- Minimum material cost diff. to show on the report
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- |
-- |  Description:
-- |  Report to compare the item costs from two cost types in any two inventory orgs,
-- |  converting the Org_Code 1 (Source_Org) into the currency of Org_Code 2 (To_Org).
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.1     14 Apr 2006 Douglas Volz   Final Coding for client
-- |  1.4     13 JUN 2006 Douglas Volz   Added nvl to all material costs columns
-- |  1.5     02 NOV 2009 Douglas Volz   Changed to compare the item costs for two orgs
-- |                                     across different currencies
-- |  1.6     21 Nov 2016 Douglas Volz   Take out currencies, allow comparison within
-- |                                     the same inventory org but using different
-- |                                     cost types
-- |  1.7     18 Dec 2018 Douglas Volz   Add currencies back in
-- |  1.8     30 Aug 2019 Douglas Volz   Add cost and inventory item categories,
-- |                                     item type and item status.
-- |  1.9     01 Sep 2020 Douglas Volz   Added costs by cost element.
-- |  1.10    11 Sep 2020 Douglas Volz   Added ability to report cost type1 even when
-- |                                     the item is not in cost type1. Made cic2 a
-- |                                     table select to avoid sql outer join errors.
-- |  1.11    24 Oct 2020 Douglas Volz   Fix bug to convert into any currency, not just USD.
-- |  1.12    02 Nov 2020 Douglas Volz   Again, fix to report cost type 1 even when the
-- |                                     item is not in cost type 2.
-- |  1.13    05 Jan 2022 Douglas Volz   Add lot size, shrinkage rate, based on rollup
-- |                                     flags.  Change calc. for percent difference.
+=============================================================================+*/



## Report Parameters
Cost Type 1, Compared to Cost Type 2, Source Org (Org Code 1), Compared to Org (Org Code 2), Minimum Cost Difference, Currency Conversion Type, Currency Conversion Date, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Comparison 23-Jun-2022 212444.xlsx](https://www.enginatics.com/example/cac-item-cost-comparison/) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Comparison.xml](https://www.enginatics.com/xml/cac-item-cost-comparison/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-cost-comparison/](https://www.enginatics.com/reports/cac-item-cost-comparison/) |

## Case Study & Technical Analysis: CAC Item Cost Comparison

### Executive Summary
The **CAC Item Cost Comparison** report is a strategic sourcing and transfer pricing tool. It enables the comparison of item costs between two different inventory organizations, even if they use different currencies. This is critical for "Make vs. Buy" decisions (e.g., "Is it cheaper to make this in Plant A or Plant B?") and for validating intercompany transfer prices.

### Business Challenge
Global supply chains involve moving goods between entities with different cost structures and currencies.
*   **Currency Barrier**: Comparing a cost of 100 USD in the US to 90 EUR in Germany requires real-time currency conversion to be meaningful.
*   **Cost Structure**: Plant A might have lower labor but higher overhead than Plant B. A simple total cost comparison hides these trade-offs.
*   **Data Volume**: Manually looking up costs for thousands of items across two orgs is impossible.

### Solution
This report automates the cross-org comparison.
*   **Currency Normalization**: Converts the "Source Org" cost into the "Target Org" currency using a user-defined exchange rate type and date.
*   **Side-by-Side**: Displays Cost Type 1 (Source) and Cost Type 2 (Target) next to each other, with a calculated variance.
*   **Element Visibility**: Can optionally break down the comparison by cost element (Material, Labor, etc.) to show *where* the difference lies.

### Technical Architecture
The report performs a complex join across organizations:
*   **Self-Join**: Joins `cst_item_costs` to itself (once for Org 1, once for Org 2).
*   **Currency Engine**: Uses `gl_daily_rates` to fetch the exchange rate between the functional currencies of the two organizations.
*   **Item Matching**: Matches items based on the Item Number (Segment 1), assuming a shared Item Master.

### Parameters
*   **Org Code 1 (Source)**: The reference organization.
*   **Org Code 2 (Target)**: The comparison organization.
*   **Currency Conversion**: (Mandatory) Date and Type for the FX calculation.
*   **Min Cost Diff**: (Optional) Filter to show only significant variances.

### Performance
*   **Heavy Join**: Joining two large cost tables can be slow.
*   **Filtering**: Using the "Min Cost Diff" parameter is highly recommended to reduce the output to actionable items only.

### FAQ
**Q: Can I compare the same org to itself?**
A: Yes, you can use this to compare two different Cost Types (e.g., Frozen vs. Pending) within the same organization, effectively acting as a "Cost Impact" report.

**Q: What if the item doesn't exist in the second org?**
A: The report typically uses an outer join, so it will show the item in Org 1 with a null value for Org 2 (or vice versa).

**Q: Does it handle different Units of Measure?**
A: The report assumes the Primary UOM is the same. If Org 1 uses "Each" and Org 2 uses "Dozen", the comparison will be skewed unless a conversion is applied (which this report typically does not do automatically).


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
