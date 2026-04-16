---
layout: default
title: 'QP Modifier Details | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Modifier Details Report for QP Application: Advanced Pricing Source: Modifier Details (XML) Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Modifier, Details, fnd_application_vl, qp_secu_list_headers_vl, qp_segments_b'
permalink: /QP%20Modifier%20Details/
---

# QP Modifier Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-modifier-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Modifier Details Report for QP
Application: Advanced Pricing
Source: Modifier Details (XML)
Short Name: QPXPRMLS_XML
DB package: QP_QPXPRMLS_XMLP_PKG

he Modifier Details (columns) are repeated across all rows pertaining to the Modifier
The List Line Details (columns) are repeated across all rows pertaining to the List Line

For a given modifier the row sequence is:
-  Modifier Level Qualifiers (sorted by qualifier group, qualifier grouping number)
- Modifier List Lines (sorted by list line number)

For each Modifier List the row sequence is:
- List Line record type
- List Line - Qualifiers (sorted by qualifier group, qualifier grouping number)
- List Line - Price Breaks
- List Line - Pricing Attributes 

You can filter on the Record Type column to restrict the data based on what you want to review (e.g just the Modifier Qualifiers, or just the Modifier Lines, or just the Line Level Qualifiers etc).


## Report Parameters
Modifier Number From, Modifier Number To, Modifier Name From, Modifier Name To, Modifier Version From, Modifier Version To, Start Date Active, End Date Active, Active Modifier Only, Active Modifier Lines Only, Item Name, Item Category, Customer Name, Customer Class, Price List

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl), [qp_segments_b](https://www.enginatics.com/library/?pg=1&find=qp_segments_b), [qp_prc_contexts_b](https://www.enginatics.com/library/?pg=1&find=qp_prc_contexts_b), [qp_qualifiers_v](https://www.enginatics.com/library/?pg=1&find=qp_qualifiers_v), [qp_lookups](https://www.enginatics.com/library/?pg=1&find=qp_lookups), [qp_list_lines](https://www.enginatics.com/library/?pg=1&find=qp_list_lines), [qp_rltd_modifiers](https://www.enginatics.com/library/?pg=1&find=qp_rltd_modifiers), [qp_modifier_summary_v](https://www.enginatics.com/library/?pg=1&find=qp_modifier_summary_v), [qp_price_breaks_v](https://www.enginatics.com/library/?pg=1&find=qp_price_breaks_v), [qp_pricing_attr_v](https://www.enginatics.com/library/?pg=1&find=qp_pricing_attr_v), [qp_pricing_attr_get_v](https://www.enginatics.com/library/?pg=1&find=qp_pricing_attr_get_v), [q1](https://www.enginatics.com/library/?pg=1&find=q1), [q2](https://www.enginatics.com/library/?pg=1&find=q2), [q3](https://www.enginatics.com/library/?pg=1&find=q3), [q4](https://www.enginatics.com/library/?pg=1&find=q4), [q5](https://www.enginatics.com/library/?pg=1&find=q5), [q6](https://www.enginatics.com/library/?pg=1&find=q6)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QP Modifier Details - Default 24-Feb-2024 004246.xlsx](https://www.enginatics.com/example/qp-modifier-details/) |
| Blitz Report™ XML Import | [QP_Modifier_Details.xml](https://www.enginatics.com/xml/qp-modifier-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-modifier-details/](https://www.enginatics.com/reports/qp-modifier-details/) |

## Case Study & Technical Analysis: QP Modifier Details Report

### Executive Summary

The QP Modifier Details report is a crucial configuration and audit tool for Oracle Advanced Pricing (QP). It provides a comprehensive and hierarchical view of all pricing modifiers, including discounts, surcharges, freight charges, and promotions, along with their associated qualifiers and price breaks. This report is indispensable for pricing analysts, sales managers, and system configurators to understand complex pricing strategies, audit modifier setups, troubleshoot pricing discrepancies, and ensure accurate and compliant application of all pricing adjustments.

### Business Challenge

Oracle Advanced Pricing modifiers are highly flexible, allowing for complex pricing strategies based on numerous conditions. However, managing and understanding these configurations can be a significant challenge:

-   **Opaque Modifier Logic:** It's often difficult to see how different modifiers are defined, what conditions (qualifiers) trigger them, and how they interact with each other to affect the final price. This lack of transparency complicates pricing analysis.
-   **Configuration Complexity:** Modifiers can have multiple list lines, price breaks, pricing attributes, and qualifiers defined at both the modifier and line level. Retrieving all this detail from standard Oracle forms is a tedious, multi-step process.
-   **Troubleshooting Pricing Errors:** When an incorrect discount is applied (or not applied), diagnosing the issue requires a deep dive into modifier setups. Without a consolidated report, identifying the exact rule causing the problem is very time-consuming.
-   **Compliance and Audit:** Ensuring that all discounts and charges are applied according to company policy and legal regulations requires clear, auditable documentation of modifier configurations.

### The Solution

This report offers a powerful, configurable, and hierarchical solution for analyzing and auditing pricing modifiers, transforming how organizations manage their pricing strategies.

-   **Comprehensive Modifier Overview:** It presents a detailed list of modifiers, their lines, associated qualifiers, and price breaks in a structured, hierarchical format. This provides a holistic view of the entire modifier setup.
-   **Configurable Detail Levels:** The report allows users to filter by `Record Type` (e.g., Modifier Level Qualifiers, List Line Price Breaks, List Line Pricing Attributes), enabling focus on specific aspects of the modifier setup for targeted analysis or troubleshooting.
-   **Transparent Pricing Logic:** By detailing all the components of a modifier, the report provides unprecedented transparency into how discounts and charges are calculated and applied by the Oracle Pricing Engine.
-   **Streamlined Audit and Compliance:** It serves as a robust audit trail for all pricing modifier configurations, facilitating compliance checks and ensuring that pricing strategies are implemented as intended.

### Technical Architecture (High Level)

The report queries core Oracle Advanced Pricing tables to extract and present detailed modifier configurations.

-   **Primary Tables/Views Involved:**
    -   `qp_secu_list_headers_vl` (the central view for pricing list headers, including modifiers).
    -   `qp_list_lines` (for individual lines within a modifier, defining the actual adjustment).
    -   `qp_qualifiers_v` (for qualifier definitions at both modifier and list line levels).
    -   `qp_price_breaks_v` (for price break definitions associated with modifier lines).
    -   `qp_pricing_attr_v` and `qp_pricing_attr_get_v` (for pricing attributes that influence how modifiers are applied).
    -   `qp_lookups` (for translating various lookup codes).
-   **Logical Relationships:** The report starts by retrieving modifier headers. It then hierarchically links to their associated `qp_qualifiers_v` (for modifier-level qualifiers). For each modifier `list_line`, it further joins to `qp_qualifiers_v` (for line-level qualifiers), `qp_price_breaks_v`, and `qp_pricing_attr_v` to construct the complete, multi-level definition of the modifier.

### Parameters & Filtering

The report offers extensive parameters for precise filtering and detailed data inclusion:

-   **Modifier Identification:** `Modifier Number From/To`, `Modifier Name From/To`, `Modifier Version From/To` allow for specific targeting of modifiers.
-   **Date-Effective Filters:** `Start Date Active` and `End Date Active` are crucial for analyzing currently active or historically defined modifiers.
-   **Status Filters:** `Active Modifier Only` and `Active Modifier Lines Only` allow focusing on currently operational parts of the pricing setup.
-   **Contextual Filters:** `Item Name`, `Item Category`, `Customer Name`, `Customer Class`, and `Price List` enable filtering for modifiers relevant to specific products, customers, or pricing scenarios.

### Performance & Optimization

As a detailed configuration report with hierarchical data, it is optimized by strong filtering and efficient joining strategies.

-   **Date-Effective Filtering:** The `Start Date Active` and `End Date Active` parameters are critical for performance, allowing the database to efficiently retrieve only the relevant active modifier definitions.
-   **Hierarchical Retrieval:** The report's structured query logic is designed to efficiently traverse the hierarchical relationships between modifiers, lines, qualifiers, and price breaks.
-   **Parameter-Driven Scope:** Extensive filtering capabilities (by modifier, item, customer) are crucial for narrowing the data set, preventing the report from attempting to process excessively broad or complex configurations when not required.

### FAQ

**1. What is the difference between a 'Modifier' and a 'Price List' in Oracle Advanced Pricing?**
   A 'Price List' defines the base selling price for an item. A 'Modifier' is an adjustment to that base price, such as a discount (e.g., 10% off), a surcharge (e.g., a shipping fee), or a promotional offer (e.g., Buy One Get One Free). This report focuses on the detailed setup of these modifiers.

**2. How do 'Qualifiers' affect a modifier?**
   Qualifiers are conditions that must be met for a modifier to be applicable. For example, a discount modifier might have a qualifier that says "Only apply if Customer Class is 'Wholesale'". This report details all these qualifiers, helping to understand the conditions under which a modifier will activate.

**3. Can this report help troubleshoot why a specific discount is not appearing on a sales order?**
   Yes. By using the filtering parameters to find the expected modifier and then examining its `List Line - Qualifiers` and `List Line - Pricing Attributes` sections, you can verify if the order (customer, item, quantity, etc.) meets all the conditions defined for that modifier to be applied by the pricing engine.


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
