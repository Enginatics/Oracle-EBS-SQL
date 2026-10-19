---
layout: default
last_modified_at: 2026-10-19
title: 'OPM Batch Details and Status Summary | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) batch details and status summary: one row per production batch showing batch status and type, recipe, primary product…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Batch, Details, Status, gme_batch_header, org_organization_definitions, gmd_recipe_validity_rules'
permalink: /OPM%20Batch%20Details%20and%20Status%20Summary/
report_name: 'OPM Batch Details and Status Summary'
report_web_name: opm-batch-details-and-status-summary
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Batch Details and Status Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-batch-details-and-status-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
Oracle Process Manufacturing (OPM) batch details and status summary: one row per production batch showing batch status and type, recipe, primary product and planned/actual output quantity, planned versus actual start and completion dates, and whether the batch completed on time. Set a pending/released status with plan-date filters for a planned-production view.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Batch Number, Product Item, Batch Status, Actual Start Date From, Actual Start Date To

## Oracle EBS Tables Used
[gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [gmd_recipe_validity_rules](https://www.enginatics.com/library/?pg=1&find=gmd_recipe_validity_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [gmd_recipes_vl](https://www.enginatics.com/library/?pg=1&find=gmd_recipes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [gme_material_details](https://www.enginatics.com/library/?pg=1&find=gme_material_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)

## Related Reports
[OPM Batch Yield Variance](/OPM%20Batch%20Yield%20Variance/ "OPM Batch Yield Variance Oracle EBS SQL Report"), [OPM Batch Material Usage and Substitution Variance](/OPM%20Batch%20Material%20Usage%20and%20Substitution%20Variance/ "OPM Batch Material Usage and Substitution Variance Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Batch%20Details%20and%20Status%20Summary/OPM%20Batch%20Details%20and%20Status%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Batch Details and Status Summary 05-Jun-2026 120004.xlsx](https://www.enginatics.com/example/opm-batch-details-and-status-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) |
| Blitz Report™ XML Import | [OPM_Batch_Details_and_Status_Summary.xml](https://www.enginatics.com/xml/opm-batch-details-and-status-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) |
| SQL Source | [OPM Batch Details and Status Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Batch%20Details%20and%20Status%20Summary/OPM%20Batch%20Details%20and%20Status%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-batch-details-and-status-summary/](https://www.enginatics.com/reports/opm-batch-details-and-status-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary) |

## Case Study & Technical Analysis: OPM Batch Details and Status Summary

### Executive Summary
The OPM Batch Details and Status Summary report lists the production batches of Oracle Process Manufacturing, one row per batch. For each batch it shows the status and type, the recipe and version it was made from, the primary product, the planned and actual output quantity, the planned and actual start and completion dates, and whether the batch finished on or before its planned completion date. Production supervisors and plant planners use it to review batch execution against plan, to confirm which batches are still pending or released, and to report on on-time completion. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Plan versus actual output:** Plant managers need the planned and actual product quantity of each batch to measure yield and throughput.
*   **Schedule adherence:** Batches that finish after their planned completion date must be identified to explain delays in the production schedule.
*   **Recipe traceability:** Each batch must be traceable to the recipe and recipe version that governed its production, which matters for quality and regulatory records.
*   **Planned production view:** Planners need the batches that are pending or released, with their planned dates, to see the load on each organization.

### The Solution
*   **Batch header base:** The report starts from the batch header of each organization, which holds the batch number, status, type and planned and actual dates.
*   **Product summary:** The primary product is identified from the first product line of each batch, and its planned and actual quantities are summed from the material lines of type product.
*   **Recipe linkage:** The batch is linked through its recipe validity rule to the recipe and its version number.
*   **On-time flag:** The completed on time indicator is Yes when the actual completion date is on or before the planned completion date.

### Technical Architecture (High Level)
#### Primary Tables
*   `GME_BATCH_HEADER`: the production batch header, with batch number, status, type, recipe validity rule and planned and actual dates.
*   `GME_MATERIAL_DETAILS`: the batch material lines, used for the product lines with their planned and actual quantities and units.
*   `GMD_RECIPE_VALIDITY_RULES`: the link between the batch and the recipe.
*   `GMD_RECIPES_VL`: the recipe number and version.
*   `MTL_SYSTEM_ITEMS_VL`: the product item number and description.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  `GME_BATCH_HEADER` joins to `ORG_ORGANIZATION_DEFINITIONS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  An inline view takes the material lines of type 1 (product) and groups them by batch, returning the first product item, the summed planned and actual quantities, and the unit of the first line.
3.  The batch joins to that inline view on the batch ID, and the product item joins to `MTL_SYSTEM_ITEMS_VL` on item and organization.
4.  The batch joins to `GMD_RECIPE_VALIDITY_RULES` on the recipe validity rule ID, and that joins to `GMD_RECIPES_VL` on the recipe ID.
5.  Output is ordered by organization code and batch number.

### Parameters & Filtering
*   **Organization Code:** selects the process manufacturing organization.
*   **Batch Number:** selects one batch.
*   **Product Item:** limits the batches to one product.
*   **Batch Status:** limits the output to batches in one status, such as pending or released.
*   **Actual Start Date From** and **Actual Start Date To:** bound the actual start date of the batch.

### Performance & Optimization
*   The product quantities are pre-aggregated in an inline view grouped by batch, so the material table is read once for each batch rather than once per output row.
*   The first product line is selected with `KEEP (DENSE_RANK FIRST)` on the line number, which avoids a second join to the material table.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied to the batch header before the inline view joins.
*   Recipe and product joins are outer joins, so batches without a recipe or product line are still listed.

### FAQ
**Q: How is the on-time completion flag determined?**
A: The flag is Yes when the actual completion date is on or before the planned completion date, and blank otherwise.

**Q: Which quantity is shown as the batch output?**
A: The planned product quantity and the actual product quantity are the sums of the product lines of the batch, in the unit of its first product line.

**Q: What is the difference between a Batch and a Firm Planned Order in this report?**
A: The batch type column shows Batch for batch type 0 and Firm Planned Order for batch type 10.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-details-and-status-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
