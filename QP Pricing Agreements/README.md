---
layout: default
title: 'QP Pricing Agreements | Oracle EBS SQL Report'
description: 'Report detailing QP Pricing Agreements – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Pricing, Agreements, qp_currency_lists_tl, oe_pricing_contracts_v, oe_agreements_b'
permalink: /QP%20Pricing%20Agreements/
---

# QP Pricing Agreements – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-pricing-agreements/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report detailing QP Pricing Agreements

## Report Parameters
Agreement Name, Agreement Number, Revision, Agreement Type, Price List, Invoice To, Invoice Contact, Customer, Customer Number, Contact, Salesperson, Item, Valid on Date, Display Price Breaks, Display Pricing Attributes

## Oracle EBS Tables Used
[qp_currency_lists_tl](https://www.enginatics.com/library/?pg=1&find=qp_currency_lists_tl), [oe_pricing_contracts_v](https://www.enginatics.com/library/?pg=1&find=oe_pricing_contracts_v), [oe_agreements_b](https://www.enginatics.com/library/?pg=1&find=oe_agreements_b), [qp_secu_list_headers_v](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_v), [qp_list_lines_v](https://www.enginatics.com/library/?pg=1&find=qp_list_lines_v), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [qp_price_formulas_vl](https://www.enginatics.com/library/?pg=1&find=qp_price_formulas_vl), [mtl_customer_items_all_v](https://www.enginatics.com/library/?pg=1&find=mtl_customer_items_all_v), [qp_price_breaks_v](https://www.enginatics.com/library/?pg=1&find=qp_price_breaks_v), [qp_pricing_attributes](https://www.enginatics.com/library/?pg=1&find=qp_pricing_attributes), [qpa](https://www.enginatics.com/library/?pg=1&find=qpa), [qll](https://www.enginatics.com/library/?pg=1&find=qll), [qpb](https://www.enginatics.com/library/?pg=1&find=qpb), [qpat](https://www.enginatics.com/library/?pg=1&find=qpat)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QP Pricing Agreements 01-Sep-2024 225031.xlsx](https://www.enginatics.com/example/qp-pricing-agreements/) |
| Blitz Report™ XML Import | [QP_Pricing_Agreements.xml](https://www.enginatics.com/xml/qp-pricing-agreements/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-pricing-agreements/](https://www.enginatics.com/reports/qp-pricing-agreements/) |

## Case Study & Technical Analysis: QP Pricing Agreements Report

### Executive Summary

The QP Pricing Agreements report is a crucial sales and pricing configuration audit tool within Oracle Advanced Pricing (QP). It provides a comprehensive listing of customer-specific pricing agreements, detailing their terms, associated price lists, and any special pricing conditions. This report is indispensable for sales managers, pricing analysts, and contract administrators to understand and audit complex negotiated pricing, ensure compliance with contract terms, troubleshoot pricing discrepancies, and maintain accurate records of customer-specific pricing strategies.

### Business Challenge

For businesses with negotiated customer pricing, managing these "agreements" is vital for sales effectiveness and profitability. However, the complexities of defining and auditing these agreements in Oracle EBS can present significant challenges:

-   **Opaque Agreement Terms:** It's often difficult to get a single, consolidated view of all the pricing terms, associated price lists, and specific item prices defined within a customer pricing agreement. This fragmentation hinders effective contract management.
-   **Ensuring Consistent Application:** Without clear reporting, it's challenging to ensure that sales orders for a specific customer consistently receive the correct negotiated prices as defined in their agreement.
-   **Date-Effective Agreement Management:** Pricing agreements often have specific start and end dates or revisions. Accurately tracking which version of an agreement is valid on a given date is crucial for compliance and correct pricing.
-   **Troubleshooting Pricing Errors:** When a customer is invoiced incorrectly, diagnosing whether the issue stems from the pricing agreement setup (e.g., wrong price list assigned, incorrect item price) requires precise information on the active terms.
-   **Sales Performance Analysis:** Understanding the profitability of individual pricing agreements is essential for sales strategy, but often requires detailed data that is difficult to extract.

### The Solution

This report offers a powerful, configurable, and auditable solution for analyzing and managing customer pricing agreements, transforming how sales and pricing teams oversee their negotiated terms.

-   **Comprehensive Agreement Overview:** It presents a detailed list of pricing agreements, including their names, numbers, types, associated price lists, and key customer information. This provides a clear, at-a-glance understanding of customer-specific pricing.
-   **Date-Effective Term Visibility:** The crucial `Valid on Date` parameter allows users to view pricing agreement terms as they were defined and active on any specific date, which is vital for historical analysis, troubleshooting, and audit purposes.
-   **Configurable Detail Levels:** Parameters like `Display Price Breaks` and `Display Pricing Attributes` enable users to dynamically include more granular details about the prices and conditions within each agreement.
-   **Streamlined Audit and Compliance:** It serves as a robust audit trail for all pricing agreement configurations, facilitating compliance checks and ensuring that negotiated terms are accurately implemented and applied.

### Technical Architecture (High Level)

The report queries core Oracle Advanced Pricing and Order Management tables to extract and present detailed pricing agreement configurations.

-   **Primary Tables/Views Involved:**
    -   `oe_agreements_b` (the central table for agreement headers).
    -   `oe_pricing_contracts_v` (a view that links agreements to pricing lists).
    -   `qp_secu_list_headers_v` (for price list headers associated with agreements).
    -   `qp_list_lines_v` (for individual item prices within the associated price list).
    -   `mtl_system_items_vl` (for item master details).
    -   `hz_cust_accounts` and `hz_parties` (for customer details).
    -   `qp_price_breaks_v` and `qp_pricing_attributes` (for detailed pricing conditions).
-   **Logical Relationships:** The report starts by retrieving agreement headers from `oe_agreements_b`. It then links these agreements to their associated price lists (via `oe_pricing_contracts_v` and `qp_secu_list_headers_v`). For each price list, it retrieves item prices from `qp_list_lines_v`. The `Valid on Date` parameter is applied to these date-effective tables to ensure that only agreement terms and prices active on the specified date are retrieved.

### Parameters & Filtering

The report offers extensive parameters for precise filtering and detailed data inclusion:

-   **Agreement Identification:** `Agreement Name`, `Agreement Number`, `Revision`, `Agreement Type` allow for specific targeting of agreements.
-   **Customer Context:** `Customer`, `Customer Number`, `Invoice To`, `Invoice Contact`, `Contact` identify specific customer agreements.
-   **Salesperson & Item Filters:** `Salesperson` and `Item` enable analysis by sales representative or product.
-   **Date-Effective Filter:** `Valid on Date` is the most critical parameter, allowing users to define the point in time for which they want to retrieve active agreement data. This ensures historical accuracy.
-   **Detail Inclusion Flags:** `Display Price Breaks` and `Display Pricing Attributes` dynamically include granular pricing conditions within the report.

### Performance & Optimization

As a configuration and master data report dealing with date-effective tables, it is optimized for efficient historical and current data retrieval.

-   **Date-Effective Table Querying:** The core tables (`oe_agreements_b`, `qp_list_lines_v`) are designed and indexed by Oracle to efficiently retrieve the correct version of agreement terms and prices for a given `Valid on Date`, ensuring fast performance.
-   **Indexed Joins:** The queries leverage standard Oracle indexes on `agreement_id`, `price_list_id`, `customer_id`, and `item_id` for efficient joins between the various agreement, pricing, and customer master tables.
-   **Parameter-Driven Scope:** Filtering by `Agreement Name`, `Customer`, and `Item` significantly reduces the data volume processed, preventing the report from attempting to process excessively broad datasets when detailed analysis is not required.

### FAQ

**1. What is the primary purpose of a 'Pricing Agreement' in Oracle EBS?**
   A 'Pricing Agreement' (also known as a sales agreement or customer agreement in Order Management) defines specific, negotiated pricing and terms for a customer over a period. It allows organizations to offer special pricing to key customers that might differ from standard price list prices or promotional offers, ensuring consistent and agreed-upon pricing.

**2. How does the 'Valid on Date' parameter ensure accurate agreement terms?**
   Pricing agreements can have revisions or date-effective changes to their terms. The `Valid on Date` parameter ensures that the report retrieves the exact terms, associated price list, and item prices that were active under that agreement on the specified date, which is crucial for accurate historical analysis, auditing, and troubleshooting.

**3. Can this report help troubleshoot why a customer is not getting their agreed-upon price?**
   Yes. By running the report for the specific `Customer`, `Agreement Name`, and `Item` (with the relevant `Valid on Date`), you can verify if the item is included in the agreement, which price list is linked, and if there are any `Price Breaks` or `Pricing Attributes` that might be affecting the final price compared to what was expected.


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
