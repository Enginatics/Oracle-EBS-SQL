---
layout: default
title: 'MSC Sourcing Rule Assignment Upload | Oracle EBS SQL Report'
description: 'MSC Sourcing Rule Assignment Upload ============================= - Upload new Assignment Sets and Sourcing Rule Assignments - Update Existing Assignment…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, MSC, Sourcing, Rule, Assignment, msc_assignment_sets, msc_sr_assignments_v, msc_sourcing_rules'
permalink: /MSC%20Sourcing%20Rule%20Assignment%20Upload/
---

# MSC Sourcing Rule Assignment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-sourcing-rule-assignment-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MSC Sourcing Rule Assignment Upload
=============================
- Upload new Assignment Sets and Sourcing Rule Assignments
- Update Existing Assignment Sets and Sourcing Rule Assignments

Notes:
If an Assignment Organization is specified, then this determines the selecatable items. 
If an Assignment Organization is not specified, then the Master Organization determines the selectable Items.
The selectable Assignment Organizations is not restricted by the Master Organization. 
This is the same logic as used in the Sourcing Assignments form


## Report Parameters
Planning Instance, Master Organization Code, Upload Mode, Assignment Set, Assignment Type, Sourcing Rule Type, Sourcing Rule Name, Organization Code, Category, Item, Customer, Customer Number, Customer Operating Unit, Region/Zone, Condition, Include Collected Data

## Oracle EBS Tables Used
[msc_assignment_sets](https://www.enginatics.com/library/?pg=1&find=msc_assignment_sets), [msc_sr_assignments_v](https://www.enginatics.com/library/?pg=1&find=msc_sr_assignments_v), [msc_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=msc_sourcing_rules), [msc_trading_partners](https://www.enginatics.com/library/?pg=1&find=msc_trading_partners), [msc_trading_partner_sites](https://www.enginatics.com/library/?pg=1&find=msc_trading_partner_sites), [msc_regions](https://www.enginatics.com/library/?pg=1&find=msc_regions), [sra_query](https://www.enginatics.com/library/?pg=1&find=sra_query)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report"), [MSC Vertical Plan](/MSC%20Vertical%20Plan/ "MSC Vertical Plan Oracle EBS SQL Report"), [MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [MSC Plan Order Upload](/MSC%20Plan%20Order%20Upload/ "MSC Plan Order Upload Oracle EBS SQL Report"), [MSC Pegging Hierarchy 11i](/MSC%20Pegging%20Hierarchy%2011i/ "MSC Pegging Hierarchy 11i Oracle EBS SQL Report"), [MSC Pegging Hierarchy](/MSC%20Pegging%20Hierarchy/ "MSC Pegging Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/msc-sourcing-rule-assignment-upload/) |
| Blitz Report™ XML Import | [MSC_Sourcing_Rule_Assignment_Upload.xml](https://www.enginatics.com/xml/msc-sourcing-rule-assignment-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-sourcing-rule-assignment-upload/](https://www.enginatics.com/reports/msc-sourcing-rule-assignment-upload/) |

## MSC Sourcing Rule Assignment Upload - Case Study & Technical Analysis

### Executive Summary
The **MSC Sourcing Rule Assignment Upload** is a configuration tool for the ASCP environment. Similar to the MRP version, it allows for the mass maintenance of Sourcing Rule Assignments. However, this tool is specifically designed for the **MSC** (ASCP) schema, which is often separate from the transactional (MRP/ERP) schema.

### Business Challenge
In distributed environments, sourcing rules might need to be maintained directly in the planning instance or synchronized from the source.
-   **Simulation:** "We want to test a new sourcing strategy in a simulation plan without changing the production system. We need to upload these assignments to the planning instance only."
-   **Volume:** "We have 50,000 assignments to update. The forms are too slow."

### Solution
The **MSC Sourcing Rule Assignment Upload** allows bulk updates to the ASCP assignment sets.

**Key Features:**
-   **Direct ASCP Update:** Updates the tables in the planning schema (`MSC_`).
-   **Hierarchy Support:** Supports Item, Category, Organization, and Global levels.
-   **Validation:** Ensures referential integrity with ASCP master data.

### Technical Architecture
The tool interfaces with the MSC assignment tables.

#### Key Tables and Views
-   **`MSC_ASSIGNMENT_SETS`**: Defines the assignment set.
-   **`MSC_SR_ASSIGNMENTS`**: The table linking rules to items/orgs.
-   **`MSC_SOURCING_RULES`**: The rule definitions.

#### Core Logic
1.  **Context:** Operates within the context of a specific Planning Instance.
2.  **Processing:** Inserts or updates records in `MSC_SR_ASSIGNMENTS`.
3.  **Collection Flag:** Can optionally include collected data or only local (simulation) data.

### Business Impact
-   **Simulation Capability:** Enables powerful "what-if" analysis by allowing planners to rapidly change sourcing logic in a test plan.
-   **Efficiency:** Drastically reduces the time required to set up or modify large supply chain networks.


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
