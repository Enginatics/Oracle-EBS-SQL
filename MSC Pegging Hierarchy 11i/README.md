---
layout: default
title: 'MSC Pegging Hierarchy 11i | Oracle EBS SQL Report'
description: 'ASCP Pegging Hierarchy. This reports shows the pegging hierarchy from the Top Level Demand.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, MSC, Pegging, Hierarchy, 11i, msc_full_pegging&a2m_dblink, msc_system_items&a2m_dblink, msc_boms&a2m_dblink'
permalink: /MSC%20Pegging%20Hierarchy%2011i/
---

# MSC Pegging Hierarchy 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-pegging-hierarchy-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
ASCP Pegging Hierarchy. This reports shows the pegging hierarchy from the Top Level Demand.

## Report Parameters
Planning Instance, Plan, Organization, Show Source Org. Pegging, Category Set, Category, End Assembly, Item, Project, Planner, Buyer, Make / Buy, Supply Type, Supplier, Supply Date From, Supply Date To, Exception, Demand Origination, Demand Order, Other Demand Origination, Exclude Other Demand, Demand Date From, Demand Date To, Pegging, Show End Pegs Only, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_full_pegging&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_full_pegging&a2m_dblink), [msc_system_items&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_system_items&a2m_dblink), [msc_boms&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_boms&a2m_dblink), [msc_safety_stocks&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_safety_stocks&a2m_dblink)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/msc-pegging-hierarchy-11i/) |
| Blitz Report™ XML Import | [MSC_Pegging_Hierarchy_11i.xml](https://www.enginatics.com/xml/msc-pegging-hierarchy-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-pegging-hierarchy-11i/](https://www.enginatics.com/reports/msc-pegging-hierarchy-11i/) |

## MSC Pegging Hierarchy 11i - Case Study & Technical Analysis

### Executive Summary
The **MSC Pegging Hierarchy 11i** report is the version of the pegging report designed specifically for Oracle E-Business Suite Release 11i. While the core concept is the same as the R12 version, the underlying data structures and query logic are optimized for the 11i schema.

### Business Challenge
(Same as MSC Pegging Hierarchy)
-   **Traceability:** Linking supply to demand.
-   **Impact Analysis:** Understanding the downstream effect of delays.

### Solution
(Same as MSC Pegging Hierarchy)
-   **End-to-End Trace:** Full BOM and network traversal.
-   **Multi-Org:** Cross-organization visibility.

### Technical Architecture
The report is tailored for the 11i ASCP schema.

#### Key Tables and Views
-   **`MSC_FULL_PEGGING`**: The core pegging table.
-   **`MSC_DEMANDS`** / **`MSC_SUPPLIES`**: Transaction details.
-   **`MSC_BOMS`**: Bill of Materials definitions within ASCP.

#### Core Logic
1.  **Recursive Query:** Uses Oracle's hierarchical query syntax (`CONNECT BY`) to navigate the pegging tree.
2.  **11i Specifics:** Handles specific column names and table relationships that differ from R12 (e.g., how Projects or End Assemblies are linked).

### Business Impact
-   **Legacy Support:** Ensures that organizations running on 11i still have critical visibility into their supply chain plans.
-   **Continuity:** Provides a consistent reporting experience for users who may be in the process of upgrading.


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
