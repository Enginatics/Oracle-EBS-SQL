---
layout: default
title: 'INV Organization Parameters | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Organization, Parameters, mtl_material_statuses_vl, hr_all_organization_units_vl, cst_cost_types'
permalink: /INV%20Organization%20Parameters/
---

# INV Organization Parameters – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-organization-parameters/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Ledger, Operating Unit, Country, Organization Code

## Oracle EBS Tables Used
[mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_parameters_view](https://www.enginatics.com/library/?pg=1&find=mtl_parameters_view), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Organization Parameters 18-Aug-2024 120822.xlsx](https://www.enginatics.com/example/inv-organization-parameters/) |
| Blitz Report™ XML Import | [INV_Organization_Parameters.xml](https://www.enginatics.com/xml/inv-organization-parameters/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-organization-parameters/](https://www.enginatics.com/reports/inv-organization-parameters/) |

## INV Organization Parameters - Case Study & Technical Analysis

### Executive Summary
The **INV Organization Parameters** report is a configuration document that details the setup of every Inventory Organization in the system. It captures the critical control flags (e.g., Negative Balances Allowed, Locator Control, Serial Control) that dictate how the warehouse operates. This report is the "Blueprint" of the inventory setup.

### Business Challenge
Inventory organizations are complex entities with hundreds of parameters. Inconsistencies can lead to:
-   **Process Failures:** "Why does Warehouse A force me to enter a Lot Number but Warehouse B doesn't?" (Answer: Different organization parameters).
-   **Financial Errors:** "Why is the Costing Method 'Standard' in the distribution center but 'Average' in the factory?"
-   **Deployment Risks:** When rolling out a new site, ensuring it matches the template of existing sites is difficult without a comparison tool.

### Solution
The **INV Organization Parameters** report dumps the full configuration of the `MTL_PARAMETERS` table. It allows for side-by-side comparison of multiple organizations to identify discrepancies.

**Key Features:**
-   **Control Flags:** Lists settings for Negative Inventory, WMS Enabled, Process Manufacturing Enabled, etc.
-   **Defaults:** Shows default accounts, picking rules, and subinventories.
-   **Costing Setup:** Details the Costing Method and General Ledger link.

### Technical Architecture
The report is a direct dump of the primary organization definition table.

#### Key Tables and Views
-   **`MTL_PARAMETERS`**: The master table for Inventory Organization setup.
-   **`HR_ALL_ORGANIZATION_UNITS`**: The HR definition of the org.
-   **`GL_LEDGERS`**: The financial ledger the org belongs to.
-   **`CST_COST_TYPES`**: The costing method definition.

#### Core Logic
1.  **Parameter Retrieval:** Selects all columns from `MTL_PARAMETERS`.
2.  **Decoding:** Resolves ID columns (like `DEFAULT_MATERIAL_COST_ID`) to readable names.
3.  **Context:** Joins to HR and GL tables to provide the Operating Unit and Ledger context.

### Business Impact
-   **Standardization:** Helps enforce a standard template across all warehouses.
-   **Troubleshooting:** The first document a consultant asks for when debugging "weird" system behavior.
-   **Change Management:** Documents the "As-Is" state before applying any configuration changes.


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
