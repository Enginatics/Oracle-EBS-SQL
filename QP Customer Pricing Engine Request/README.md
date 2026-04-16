---
layout: default
title: 'QP Customer Pricing Engine Request | Oracle EBS SQL Report'
description: 'QP Customer Pricing Engine Request ============================== This report requests Item Selling Price information by Customer across Price Lists from…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Customer, Pricing, Engine, Request, xmltable, ra_terms_vl, qp_secu_list_headers_vl'
permalink: /QP%20Customer%20Pricing%20Engine%20Request/
---

# QP Customer Pricing Engine Request – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-customer-pricing-engine-request/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
QP Customer Pricing Engine Request
==============================
This report requests Item Selling Price information by Customer across Price Lists from the Pricing Engine.

The report also displays the Items Costs for the specified Organization and based on the Unit Selling Price and Item Cost, displays a Margin Analysis.

The report can be run in Summary or Detail Mode.

In Summary Mode, the report will display a summary of Applied Price Lists, List Price, Adjustment Amount, Final Unit Selling Price, Accrual Amount, Charge Amount, Item Cost, and Margin per Customer, requested Price List and Item. Summary Records can be identified in the report with Record Type=Summary

In Detail Mode, in additional to the summary information, the report will include the following record types:
- Detail Record Type which provides a breakdown of the Price List and Modifier Lines the pricing engine has applied in the calculation of the final unit selling price
- Pricing Attribute Record Type provides details of the Pricing Attributes considered by the Pricing Engine in selecting a specified Price List or Modifier
- Qualifier Attribute Record Type provides details of any Qualifier Attributes considered by the Pricing Engine in selecting a specific Price List or Modifier

Detail Record Types follow the Summary Record Type they apply to
Pricing Attribute and Qualifier Attribute Record Types follow the Detail Record Type they apply to.

Additionally, the report supports the following options:

- Use Secondary Price Lists (Yes/No)
  When No, the report will restrict to displaying Prices on the requested Price Lists only
  When Yes, then the report will check for the price on any secondary price lists defined for the requested Price List 

- Expand Price Breaks (Yes/No)
  When No, the report will display the pricing based on the requested Pricing Only
  When Yes, the report will display one line per Price Break to provide an indication of the unit selling price will vary across the Price Breaks and the impact that may have on margins

- Display Promotional Goods (Buy One Get One free type Promotions))
  When No, the report will not display any Promotional Goods the Customer maybe eligible to receive
  When Yes, the report will display any Promotional Goods the Customer maybe eligible to receive

- Display Site Pricing Differences
  When No, the report will only check the Pricing Based on the specified Customer Accounts
  When Yes, the report will also check the Pricing based on the specified Ship To/Bill To Locations. 

  If the pricing at the Customer Site is the same as at the Customer Level, only the Customer Level pricing is displayed in the report.
  If the pricing at the Customer Site differs to the pricing at the Customer Level, then both the Customer Pricing and Site Pricing is included in the report.
  If a Ship To or Bill To location is not specified, and the Display Site Pricing Differences is set to Yes, the report will check all active ship to sites for the Customer within the specified Operating Units.

It is also possible to specify some additional Order Qualifiers to be considered by the Pricing Engine. These are: 
- Organization - this is used as the Shipping Warehouse, It also determines from which Items can be selected and also determines the Organization from which the Item Costs are derived.
- Sales Agreement
- Order Source
- Order Type

Lastly the user can specify
- Pricing Request Date
- Pricing Request Quantity
- Currency Code

Unit Selling Price, Item Costs, and extended amounts are all displayed in the specified currency. The user can only select a currency that is supported by the selected Price Lists.


## Report Parameters
Report Level, Operating Unit, Customer Name, Account Number, Customer Ship To Location, Customer Bill To Location, Price List, Currency Code, Organization Code, Category Set, Category, Item, Pricing Request Qty, Unit of Measure, Pricing Request Date, Customer Order Enabled Items Only, Cost Type, Sales Agreement, Order Source, Order Type, Use Secondary Price Lists, Expand Price Breaks, Display Promotional Goods, Display Site Pricing Differences

## Oracle EBS Tables Used
[xmltable](https://www.enginatics.com/library/?pg=1&find=xmltable), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl), [qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [xxen_qp_preq_data](https://www.enginatics.com/library/?pg=1&find=xxen_qp_preq_data), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles), [hz_cust_profile_classes](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_classes), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [qp_list_lines](https://www.enginatics.com/library/?pg=1&find=qp_list_lines), [qp_price_breaks_v](https://www.enginatics.com/library/?pg=1&find=qp_price_breaks_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QP Customer Pricing Engine Request 12-Jul-2021 095134.xlsx](https://www.enginatics.com/example/qp-customer-pricing-engine-request/) |
| Blitz Report™ XML Import | [QP_Customer_Pricing_Engine_Request.xml](https://www.enginatics.com/xml/qp-customer-pricing-engine-request/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-customer-pricing-engine-request/](https://www.enginatics.com/reports/qp-customer-pricing-engine-request/) |

## Case Study & Technical Analysis: QP Customer Pricing Engine Request Report

### Executive Summary

The QP Customer Pricing Engine Request report is a highly sophisticated pricing simulation and margin analysis tool within Oracle Advanced Pricing (QP). It enables users to simulate the Oracle Pricing Engine's behavior to determine item selling prices for specific customers across various price lists, and then calculate the potential margin by comparing against item costs. This report is indispensable for sales managers, pricing analysts, and financial controllers to understand complex pricing structures, analyze customer-specific pricing, evaluate profitability, and make informed strategic decisions regarding sales pricing and promotions.

### Business Challenge

Oracle Advanced Pricing is a powerful module, but its complexity makes it challenging to understand how the pricing engine derives a final selling price, especially with multiple price lists, modifiers, discounts, and customer-specific agreements. Organizations face significant challenges:

-   **Opaque Pricing Logic:** It is often difficult to determine *how* the pricing engine arrives at a specific price, especially when multiple price lists and modifiers (discounts, surcharges) apply. This lack of transparency hinders pricing analysis and dispute resolution.
-   **Customer-Specific Pricing Analysis:** Analyzing effective selling prices and profitability for a specific customer across a range of items or scenarios is extremely cumbersome with standard tools.
-   **Margin Erosion:** Without clear visibility into the final selling price and associated item costs, businesses risk unknowingly selling at low or negative margins, eroding profitability.
-   **Simulating "What-If" Scenarios:** Understanding the impact of potential price changes, new promotions, or different customer attributes on the final selling price and margin requires a robust simulation capability.
-   **Promotional Pricing Complexity:** Determining if a customer is eligible for promotional goods (e.g., "Buy One Get One Free") and understanding their impact on overall deal profitability is a significant challenge.

### The Solution

This report provides a powerful, configurable, and detailed simulation of the Oracle Pricing Engine, transforming how organizations analyze and manage their sales pricing.

-   **Pricing Engine Simulation:** It directly calls the Oracle Pricing Engine to determine the final unit selling price for specified items and customers, providing accurate, system-derived pricing information.
-   **Detailed Price Breakdown:** In "Detail Mode," it breaks down the final selling price into its components, showing which price lists and modifiers were applied, offering unprecedented transparency into the pricing logic.
-   **Integrated Margin Analysis:** By combining the final selling price with item costs, the report automatically calculates margins, providing critical profitability insights at the item and customer level.
-   **Flexible Scenario Analysis:** Parameters like `Use Secondary Price Lists`, `Expand Price Breaks`, `Display Promotional Goods`, and `Display Site Pricing Differences` allow users to simulate various pricing scenarios and understand their impact.
-   **Comprehensive Attribute Details:** It exposes the `Pricing Attribute` and `Qualifier Attribute` records considered by the engine, giving detailed context for why specific price lists or modifiers were chosen.

### Technical Architecture (High Level)

The report leverages Oracle's Advanced Pricing engine (QP) by initiating a pricing request and then extracting the detailed results. It integrates data from various pricing, inventory, and customer tables.

-   **Primary Tables/Components Involved:**
    -   `xxen_qp_preq_data` (likely a custom interface or package that prepares data for and calls the Oracle Pricing Engine API).
    -   `qp_secu_list_headers_vl`, `qp_list_lines`, `qp_price_breaks_v` (for price list, modifier, and price break definitions).
    -   `mtl_system_items_b_kfv` (for item master details and costs).
    -   `hz_cust_accounts`, `hz_parties`, `hz_cust_site_uses_all` (for customer and customer site details).
    -   Oracle Pricing Engine APIs (implicitly called by the `xxen_qp_preq_data` component).
-   **Logical Relationships:** The report constructs a pricing request based on the user's parameters (customer, item, quantity, date). This request is passed to the Oracle Pricing Engine (via `xxen_qp_preq_data`). The engine processes the request using its complex rules, price lists, and modifiers. The report then extracts the detailed results from the engine's output, including the final price, adjustments, applied modifiers, and the attributes that influenced the pricing decision.

### Parameters & Filtering

The report offers an extensive and critical set of parameters for precise pricing simulation and analysis:

-   **Report Level:** Crucial for selecting output detail: `Summary` (consolidated pricing) or `Detail` (breakdown of price lists, modifiers, attributes, qualifiers).
-   **Customer Context:** `Customer Name`, `Account Number`, `Customer Ship To Location`, `Customer Bill To Location` target specific customer pricing scenarios.
-   **Item Context:** `Item`, `Category Set`, `Category` allow for focused item pricing analysis.
-   **Pricing Criteria:** `Price List`, `Currency Code`, `Pricing Request Qty`, `Unit of Measure`, `Pricing Request Date` drive the pricing engine's calculation.
-   **Order Qualifiers:** `Organization Code` (as Shipping Warehouse and cost source), `Sales Agreement`, `Order Source`, `Order Type` can influence pricing and are passed to the engine.
-   **Advanced Inclusion Flags:** `Use Secondary Price Lists`, `Expand Price Breaks`, `Display Promotional Goods`, `Display Site Pricing Differences` allow for granular control over the simulation and output.

### Performance & Optimization

As a report that interacts with the complex Oracle Pricing Engine, its performance is highly dependent on effective parameter usage.

-   **Targeted Pricing Engine Calls:** Providing specific `Customer`, `Item`, and `Price List` parameters ensures that the pricing engine is invoked with a narrow scope, minimizing the processing time for each pricing request.
-   **Conditional Data Retrieval:** The `Report Level` and various `Display` and `Expand` flags (`Expand Price Breaks`, `Display Promotional Goods`) allow the report to retrieve and process more granular data only when explicitly required, preventing unnecessary overhead.
-   **Leveraging Optimized Pricing Engine:** The report relies on the inherent performance optimizations of the Oracle Pricing Engine itself, which is designed for efficient rule evaluation.

### FAQ

**1. What is the Oracle Pricing Engine and why is this report valuable for it?**
   The Oracle Pricing Engine is a complex rules engine that determines the final price of an item based on various factors like price lists, modifiers (discounts, surcharges), customer attributes, and order qualifiers. This report is valuable because it demystifies the engine's logic, showing *how* a price was derived, which is critical for troubleshooting, auditing, and understanding complex pricing structures.

**2. How does the 'Expand Price Breaks' parameter help in margin analysis?**
   Price breaks define different unit prices based on the quantity purchased (e.g., $10 for 1-10 units, $8 for 11-50 units). When `Expand Price Breaks` is 'Yes', the report will show separate lines for each price break, indicating how the unit selling price and margin would vary at different quantities. This is crucial for evaluating profitability across different order sizes.

**3. Can this report help troubleshoot why a specific discount or promotion isn't applying?**
   Yes, in `Detail Mode`, the report explicitly lists the `Modifier Lines` that were *applied* by the pricing engine. If an expected discount is missing, you can examine the `Pricing Attribute Record Type` and `Qualifier Attribute Record Type` sections for that item/customer to see what attributes were considered and why the modifier might not have qualified.


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
