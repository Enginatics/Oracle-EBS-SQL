---
layout: default
last_modified_at: 2026-10-16
title: 'QP Pricing Attribute Definitions | Oracle EBS SQL Report'
description: 'Lists the Pricing and Qualifiers Attributes defined for use by Advanced Pricing – Oracle EBS Advanced Pricing SQL report: free SQL, parameters and tables…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Advanced Pricing, Enginatics, Pricing, Attribute, Definitions, mtl_parameters'
permalink: /QP%20Pricing%20Attribute%20Definitions/
report_name: 'QP Pricing Attribute Definitions'
report_web_name: qp-pricing-attribute-definitions
module: 'Advanced Pricing'
module_url: /modules/advanced-pricing/
---

# QP Pricing Attribute Definitions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-pricing-attribute-definitions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions).
**Oracle EBS module:** [Advanced Pricing](/modules/advanced-pricing/ "Oracle EBS Advanced Pricing reports") · [all Advanced Pricing reports](/modules/advanced-pricing/)  

## Overview
Lists the Pricing and Qualifiers Attributes defined for use by Advanced Pricing

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)

## Related Reports
[CAC Subinventory Accounts Setup](/CAC%20Subinventory%20Accounts%20Setup/ "CAC Subinventory Accounts Setup Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Unrestricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Unrestricted by Org Access) Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Pricing%20Attribute%20Definitions/QP%20Pricing%20Attribute%20Definitions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QP Pricing Attribute Definitions 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/qp-pricing-attribute-definitions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) |
| Blitz Report™ XML Import | [QP_Pricing_Attribute_Definitions.xml](https://www.enginatics.com/xml/qp-pricing-attribute-definitions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) |
| SQL Source | [QP Pricing Attribute Definitions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20Pricing%20Attribute%20Definitions/QP%20Pricing%20Attribute%20Definitions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qp-pricing-attribute-definitions/](https://www.enginatics.com/reports/qp-pricing-attribute-definitions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions) |

## Case Study & Technical Analysis: QP Pricing Attribute Definitions Report

### Executive Summary

The QP Pricing Attribute Definitions report is a crucial configuration and audit tool for Oracle Advanced Pricing (QP). It provides a comprehensive listing of all defined pricing and qualifier attributes that are used by the Oracle Pricing Engine to determine item selling prices, discounts, and promotions. This report is indispensable for pricing analysts, system configurators, and auditors to understand the foundational elements of their pricing strategy, audit attribute setups, troubleshoot pricing discrepancies, and ensure accurate and consistent application of all pricing rules.

### Business Challenge

Oracle Advanced Pricing's flexibility stems from its ability to use various attributes (e.g., Customer Class, Item Category, Order Type) as conditions for applying prices and modifiers. However, managing and understanding these attribute definitions can be a significant challenge:

-   **Opaque Attribute Definitions:** It's often difficult to get a single, consolidated view of all the attributes defined for use by the pricing engine, including their source (e.g., from an order header, item master, or customer profile) and their internal vs. display values.
-   **Configuration Complexity:** Defining and maintaining pricing and qualifier attributes involves multiple setup steps. Errors in these definitions can lead to modifiers not applying correctly or price lists not being selected as intended.
-   **Troubleshooting Pricing Errors:** When the pricing engine does not behave as expected, the root cause is frequently a misconfigured pricing or qualifier attribute. Diagnosing these issues requires precise information on the active attribute definitions.
-   **Compliance and Audit:** Ensuring that pricing rules are based on valid and correctly configured attributes is essential for financial compliance and internal audits. Clear documentation of these definitions is a key requirement.

### The Solution

This report offers a consolidated, detailed, and easily auditable solution for analyzing and auditing pricing attribute definitions, bringing transparency to the core of the pricing engine.

-   **Comprehensive Attribute Overview:** It presents a detailed list of all defined pricing and qualifier attributes, including their internal names, user-friendly descriptions, source entities, and value sets. This provides a clear, at-a-glance understanding of how attributes are configured.
-   **Simplified Configuration Audit:** Pricing analysts and auditors can use this report to quickly review and verify attribute setups, ensuring they are correctly defined and align with the intended pricing strategy.
-   **Accelerated Troubleshooting:** When a pricing issue arises, this report provides immediate insight into the active attribute definitions, helping to quickly pinpoint and resolve misconfigurations that cause pricing discrepancies.
-   **Enhanced Documentation:** By providing transparent documentation of pricing attribute setups, the report strengthens pricing governance and makes it easier to demonstrate compliance during internal and external audits.

### Technical Architecture (High Level)

Given the `README.md` references `xmltable` and `mtl_parameters`, the report likely draws information from complex system setups, potentially involving XML-based configurations and internal Advanced Pricing definitions.

-   **Primary Tables/Components Involved:**
    -   Underlying Oracle Advanced Pricing setup tables that define pricing contexts and attributes (e.g., `QP_PRC_CONTEXTS_B`, `QP_SEGMENTS_B`, `QP_SEGMENT_MAPPINGS`).
    -   `mtl_parameters` (potentially used for organizational context or default settings influencing attributes).
    -   `xmltable` (suggests that some attribute definitions might be stored or processed using XML structures within the database, which is common for complex configurations).
-   **Logical Relationships:** The report implicitly (through the use of `xmltable` and package logic) extracts definitions of pricing and qualifier attributes. These attributes are often linked to specific pricing contexts (e.g., Order Header, Order Line) and describe how data from various Oracle EBS tables or system parameters can be used as conditions or values in pricing rules.

### Parameters & Filtering

**No Explicit Parameters:** The `README.md` indicates no specific parameters for this report. This implies that, by design, it provides a comprehensive dump of all configured pricing and qualifier attribute definitions within the system. This can be advantageous for a full, unfiltered audit of the pricing infrastructure.

### Performance & Optimization

As a configuration report, it is optimized for efficient retrieval of setup data.

-   **Low Data Volume:** The underlying attribute definition tables typically contain a manageable number of rows compared to transactional data, ensuring quick query execution.
-   **Direct Configuration Access:** The report directly accesses the core setup definitions within Oracle Advanced Pricing, minimizing complex joins to transactional data.
-   **XML Processing (if applicable):** While `xmltable` can be performance-intensive for very large XML documents, for configuration data, it is typically efficient in parsing and extracting attribute definitions.

### FAQ

**1. What is the difference between a 'Pricing Attribute' and a 'Qualifier Attribute'?**
   A 'Pricing Attribute' is a piece of information (e.g., Item Number, Customer Name) that is used in a pricing formula or to determine a base price. A 'Qualifier Attribute' is a piece of information that determines whether a specific price list or modifier is *applicable* to a transaction (e.g., if 'Customer Class = Wholesale', then apply a discount). Both are crucial for pricing logic.

**2. How do these attribute definitions relate to the Oracle Pricing Engine?**
   These definitions are the building blocks for the Oracle Pricing Engine. The engine uses these defined attributes to evaluate the conditions (qualifiers) on price lists and modifiers, and to apply pricing formulas, ultimately deriving the final selling price for a transaction. Correct attribute definitions are vital for the engine's accuracy.

**3. Since there are no parameters, how can I find a specific attribute?**
   You would run the report to get the full list and then use standard spreadsheet filtering (e.g., in Excel) to search for specific attribute names or codes. This provides a complete reference guide to all configured pricing elements.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-pricing-attribute-definitions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
