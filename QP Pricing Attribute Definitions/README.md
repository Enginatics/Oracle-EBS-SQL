---
layout: default
title: 'QP Pricing Attribute Definitions | Oracle EBS SQL Report'
description: 'Lists the Pricing and Qualifiers Attributes defined for use by Advanced Pricing – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Pricing, Attribute, Definitions, mtl_parameters, xmltable'
permalink: /QP%20Pricing%20Attribute%20Definitions/
---

# QP Pricing Attribute Definitions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-pricing-attribute-definitions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists the Pricing and Qualifiers Attributes defined for use by Advanced Pricing

## Report Parameters


## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [xmltable](https://www.enginatics.com/library/?pg=1&find=xmltable)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [OPM Batch Lot Cost Trends](/OPM%20Batch%20Lot%20Cost%20Trends/ "OPM Batch Lot Cost Trends Oracle EBS SQL Report"), [OPM Batch Lot Cost Details](/OPM%20Batch%20Lot%20Cost%20Details/ "OPM Batch Lot Cost Details Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [PN GL Reconciliation](/PN%20GL%20Reconciliation/ "PN GL Reconciliation Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QP Pricing Attribute Definitions 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/qp-pricing-attribute-definitions/) |
| Blitz Report™ XML Import | [QP_Pricing_Attribute_Definitions.xml](https://www.enginatics.com/xml/qp-pricing-attribute-definitions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qp-pricing-attribute-definitions/](https://www.enginatics.com/reports/qp-pricing-attribute-definitions/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
