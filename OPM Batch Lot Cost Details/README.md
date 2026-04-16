---
layout: default
title: 'OPM Batch Lot Cost Details | Oracle EBS SQL Report'
description: 'OPM Batch Lot Cost Details Report This report shows the Batch Lot Costs details for completed batches in the specified from/to Date Range and for the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, OPM, Batch, Lot, Cost, xmltable, fm_form_mst, gmd_formula_class'
permalink: /OPM%20Batch%20Lot%20Cost%20Details/
---

# OPM Batch Lot Cost Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-batch-lot-cost-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
OPM Batch Lot Cost Details Report

This report shows the Batch Lot Costs details for completed batches in the specified from/to Date Range and for the specified Organization, Product, Formula Class (optional) and Batch (optional).

For each selected batch included in the report, the report details the lot cost details for that batch and for all child production batches consumed by that batch.

The quantities shown in the child batches are the actual quantities for that batch and it’s ingredients. This report does not apportion the child batch quantities based on the actual quantity consumed by the parent batches. 

The report allows the user to pull in several additional data points to allow further analysis of data based on the customer specific configuration. Specifically, for the both the batch product (same for all lines in the batch) and for the batch ingredients (are specific to each line in the batch), the following additional data can be pulled into the report.

- Item Catalog Descriptive Elements for a specific Item Catalog Group
- Item Category Segments for a specific Item Category Set
- Item Descriptive Flexfield Attributes   


## Report Parameters
Organization Code, From Date, To Date, Product, Formula Class, Batch, Cost Type, Product Category Set, Product Item Catalog, Show Product Item DFF, Ingredient Category Set, Ingredient Item Catalog, Show Ingredient Item DFF

## Oracle EBS Tables Used
[xmltable](https://www.enginatics.com/library/?pg=1&find=xmltable), [fm_form_mst](https://www.enginatics.com/library/?pg=1&find=fm_form_mst), [gmd_formula_class](https://www.enginatics.com/library/?pg=1&find=gmd_formula_class), [gl_ledger_le_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_le_v), [opm_batch_lot_costs](https://www.enginatics.com/library/?pg=1&find=opm_batch_lot_costs), [gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[OPM Batch Lot Cost Trends](/OPM%20Batch%20Lot%20Cost%20Trends/ "OPM Batch Lot Cost Trends Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Batch Lot Cost Details - Detail Pivot 01-Aug-2025 091503.xlsx](https://www.enginatics.com/example/opm-batch-lot-cost-details/) |
| Blitz Report™ XML Import | [OPM_Batch_Lot_Cost_Details.xml](https://www.enginatics.com/xml/opm-batch-lot-cost-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-batch-lot-cost-details/](https://www.enginatics.com/reports/opm-batch-lot-cost-details/) |

## Case Study & Technical Analysis: OPM Batch Lot Cost Details Report

### Executive Summary

The OPM Batch Lot Cost Details report is a granular cost analysis tool for businesses using Oracle Process Manufacturing (OPM). It provides a detailed breakdown of the actual costs for completed production batches, tracing the lot-specific costs of all ingredients, including any intermediate products produced in child batches. This report is essential for cost accountants and production managers who need to understand the true cost of their products and identify the sources of cost variations in a lot-controlled environment.

### Business Challenge

In process manufacturing, the final cost of a product is a complex accumulation of ingredient costs, resource costs, and overheads, often involving multiple production stages. Understanding this cost structure is a major challenge.

-   **Lack of Cost Transparency:** It is difficult to get a single, consolidated view that shows how the final cost of a parent batch is derived from the actual costs of its specific ingredient lots and any consumed sub-assemblies (child batches).
-   **Managing Lot Cost Variability:** The cost of raw materials can vary significantly from one procurement lot to another. Standard cost reports often obscure this reality, making it hard to see how a high-cost ingredient lot impacted the profitability of a specific batch.
-   **Manual Cost Roll-ups:** Cost accountants often resort to complex, multi-sheet spreadsheets to manually trace and roll up the costs from child batches to parent batches, a process that is both time-consuming and highly susceptible to errors.
-   **Complex Variance Analysis:** When the actual cost of a batch deviates from the standard or expected cost, pinpointing the exact cause (e.g., a specific high-cost ingredient lot, or an issue in a child batch) is extremely difficult without a detailed cost breakdown.

### The Solution

This report delivers a precise, multi-level cost breakdown for any completed OPM batch, providing the clarity needed to manage and control production costs effectively.

-   **Full Cost Tracing:** The report provides a complete cost trail, showing the parent batch and detailing the costs of all consumed ingredients, including the full cost breakdown of any child batches used in the process.
-   **Lot-Specific Cost Insight:** It displays the actual lot costs, allowing for precise analysis of how the cost of specific ingredient lots contributed to the final product cost.
-   **Automated Cost Roll-up:** The report automates the complex process of rolling up costs through a multi-level production structure, saving significant time and improving accuracy.
-   **Enhanced Data Analysis:** With flexible parameters to include item categories and descriptive flexfields for both products and ingredients, the report allows for deep, customized analysis tailored to specific business needs.

### Technical Architecture (High Level)

The report queries the core costing and batch production tables within the OPM module to construct a detailed, hierarchical view of batch costs.

-   **Primary Tables Involved:**
    -   `opm_batch_lot_costs` (the central table storing the detailed, lot-specific cost components for each batch).
    -   `gme_batch_header` (provides the header details for the production batch).
    -   `mtl_system_items_vl` (used to retrieve details for the final product and all ingredient items).
    -   `fm_form_mst` (for formula details).
-   **Logical Relationships:** The report's logic begins with a completed parent batch and retrieves all cost records from `opm_batch_lot_costs`. It then identifies ingredients that are themselves the product of another batch (child batches) and recursively fetches their cost details, presenting the information in a hierarchical structure.

### Parameters & Filtering

The report offers a powerful set of parameters for precise cost analysis:

-   **Selection Criteria:** Users can select batches based on `Organization Code`, a `Date Range`, a specific `Product`, `Formula Class`, or a specific `Batch` number.
-   **Cost Type:** Allows the user to select the specific cost method (e.g., Actual, Standard) to be reported.
-   **Extended Item Analysis:** Advanced parameters (`Product/Ingredient Category Set`, `Item Catalog`, `Show Item DFF`) allow users to bring in additional item attributes to enrich the cost analysis.

### Performance & Optimization

The report is designed to handle the potentially large volume of costing data efficiently.

-   **Index-Driven Queries:** The primary filters for the report, such as date range and batch ID, are indexed in the database, allowing for efficient retrieval of the initial data set.
-   **Focused Data Retrieval:** By requiring specific selection criteria, the report avoids attempting to process an unmanageable amount of data, ensuring that it returns results in a timely manner.

### FAQ

**1. What is the difference between this report and a standard cost roll-up?**
   A standard cost roll-up typically calculates a *projected* or *standard* cost based on the bill of materials and pre-defined standard component costs. This report, in contrast, shows the *actual* costs of a *specific, completed* production batch, based on the actual costs of the specific lots consumed.

**2. The README says the report "does not apportion the child batch quantities." What does this mean?**
   It means that if a child batch produced 1000 kg of an intermediate product, and the parent batch only consumed 200 kg of it, this report will still show the full cost details for the entire 1000 kg child batch. It provides a full picture of the consumed batches, rather than allocating a portion of their cost.

**3. Can this report be used to identify the most expensive components in my batch?**
   Absolutely. The detailed breakdown of costs by ingredient and resource makes it very easy to sort the data and identify the top contributors to the overall batch cost, which is a critical first step in any cost reduction analysis.


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
