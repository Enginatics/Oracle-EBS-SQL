---
layout: default
last_modified_at: 2026-10-16
title: 'INV Organization Parameters | Oracle EBS SQL Report'
description: 'Oracle EBS Inventory SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, R12 only, INV, Organization, Parameters, mtl_material_statuses_vl, hr_all_organization_units_vl, cst_cost_types'
permalink: /INV%20Organization%20Parameters/
report_name: 'INV Organization Parameters'
report_web_name: inv-organization-parameters
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Organization Parameters – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-organization-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Country, Organization Code

## Oracle EBS Tables Used
[mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [mtl_parameters_view](https://www.enginatics.com/library/?pg=1&find=mtl_parameters_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)

## Related Reports
[CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Organization%20Parameters/INV%20Organization%20Parameters.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Organization Parameters 18-Aug-2024 120822.xlsx](https://www.enginatics.com/example/inv-organization-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) |
| Blitz Report™ XML Import | [INV_Organization_Parameters.xml](https://www.enginatics.com/xml/inv-organization-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) |
| SQL Source | [INV Organization Parameters.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Organization%20Parameters/INV%20Organization%20Parameters.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-organization-parameters/](https://www.enginatics.com/reports/inv-organization-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-organization-parameters)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
