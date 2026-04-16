---
layout: default
title: 'MRP Sourcing Rule Assignment Upload | Oracle EBS SQL Report'
description: 'MRP Sourcing Rule Assignment Upload ============================= - Upload new Assignment Sets and Sourcing Rule Assignments - Update Existing Assignment…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, MRP, Sourcing, Rule, Assignment, mrp_assignment_sets, mrp_sr_assignments_v, mrp_sourcing_rules'
permalink: /MRP%20Sourcing%20Rule%20Assignment%20Upload/
---

# MRP Sourcing Rule Assignment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-sourcing-rule-assignment-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MRP Sourcing Rule Assignment Upload
=============================
- Upload new Assignment Sets and Sourcing Rule Assignments
- Update Existing Assignment Sets and Sourcing Rule Assignments

Notes:
If an Assignment Organization is specified, then this determines the selecatable items. 
If an Assignment Organization is not specified, then the Master Organization determines the selectable Items.
The selectable Assignment Organizations is not restricted by the Master Organization. 
This is the same logic as used in the Sourcing Assignments form


## Report Parameters
Master Organization Code, Upload Mode, Assignment Set, Assignment Type, Sourcing Rule Type, Sourcing Rule Name, Organization Code, Category, Item, Customer, Customer Number, Customer Operating Unit

## Oracle EBS Tables Used
[mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mrp_sr_assignments_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments_v), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [MRP Sourcing Rules and Bills of Distribution](/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/ "MRP Sourcing Rules and Bills of Distribution Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/mrp-sourcing-rule-assignment-upload/) |
| Blitz Report™ XML Import | [MRP_Sourcing_Rule_Assignment_Upload.xml](https://www.enginatics.com/xml/mrp-sourcing-rule-assignment-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-sourcing-rule-assignment-upload/](https://www.enginatics.com/reports/mrp-sourcing-rule-assignment-upload/) |

## MRP Sourcing Rule Assignment Upload - Case Study & Technical Analysis

### Executive Summary
The **MRP Sourcing Rule Assignment Upload** is a configuration tool used to mass-maintain the "Assignment Sets" that determine how the planning engine sources material. It allows users to assign Sourcing Rules to Items, Categories, or Organizations in bulk.

### Business Challenge
Sourcing rules control the supply chain network (e.g., "Buy Item X from Supplier Y" or "Transfer Item Z from Warehouse A to Warehouse B").
-   **Network Redesign:** "We are closing a warehouse and need to repoint 10,000 items to source from a new distribution center."
-   **New Product Introduction:** "We just launched a new product line (Category 'NEW_TECH') and need to assign the standard sourcing rule to all 50 items in that category."
-   **Maintenance:** "We need to switch the sourcing for all 'Steel' items from 'Global' to 'Local' rules."

### Solution
The **MRP Sourcing Rule Assignment Upload** automates the assignment process.

**Key Features:**
-   **Hierarchy Support:** Supports assignments at all levels: Item-Org, Item, Category-Org, Category, Organization, and Global.
-   **Bulk Processing:** Can upload thousands of assignments in a single run.
-   **Validation:** Ensures that the Sourcing Rules and Items exist before creating the assignment.

### Technical Architecture
The tool interfaces with the Sourcing Rule Assignment tables.

#### Key Tables and Views
-   **`MRP_ASSIGNMENT_SETS`**: Defines the set of assignments (e.g., "Supplier Scheduling Set").
-   **`MRP_SR_ASSIGNMENTS`**: The table linking the Sourcing Rule to the assignment level (Item, Category, etc.).
-   **`MRP_SOURCING_RULES`**: The definition of the rule itself.

#### Core Logic
1.  **Parameter Check:** Validates the Assignment Set name.
2.  **Level Determination:** Determines the assignment level (e.g., Item vs. Category) based on the provided columns.
3.  **Execution:** Inserts or updates records in `MRP_SR_ASSIGNMENTS`.

### Business Impact
-   **Strategic Agility:** Allows companies to rapidly reconfigure their supply chain network in response to business changes.
-   **Accuracy:** Ensures consistent sourcing logic across large groups of items.
-   **Time Savings:** Eliminates days of manual clicking in the Sourcing Rule Assignment form.


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
