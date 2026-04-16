---
layout: default
title: 'OKC Contract Lines Summary | Oracle EBS SQL Report'
description: 'Summary of okc line style hierarchies, the jtf objects linked to each line level and the active and overall count of contract lines by status for each…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OKC, Contract, Lines, Summary, okc_line_styles_v, okc_subclass_top_line, okc_subclasses_v'
permalink: /OKC%20Contract%20Lines%20Summary/
---

# OKC Contract Lines Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/okc-contract-lines-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of okc line style hierarchies, the jtf objects linked to each line level and the active and overall count of contract lines by status for each line type.
This is useful for developers to see how the oracle contracts line data is structured and how the link to external objects, e.g. installed base or counters for service contracts works

## Report Parameters
Class, Category

## Oracle EBS Tables Used
[okc_line_styles_v](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_v), [okc_subclass_top_line](https://www.enginatics.com/library/?pg=1&find=okc_subclass_top_line), [okc_subclasses_v](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_v), [okc_classes_v](https://www.enginatics.com/library/?pg=1&find=okc_classes_v), [okc_line_style_sources](https://www.enginatics.com/library/?pg=1&find=okc_line_style_sources), [jtf_objects_vl](https://www.enginatics.com/library/?pg=1&find=jtf_objects_vl), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b), [okc_k_items](https://www.enginatics.com/library/?pg=1&find=okc_k_items), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [okc_statuses_b](https://www.enginatics.com/library/?pg=1&find=okc_statuses_b), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OKS Service Contracts Billing Schedule](/OKS%20Service%20Contracts%20Billing%20Schedule/ "OKS Service Contracts Billing Schedule Oracle EBS SQL Report"), [OKS Service Contracts Billing History](/OKS%20Service%20Contracts%20Billing%20History/ "OKS Service Contracts Billing History Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OKC Contract Lines Summary 11-Oct-2020 145318.xlsx](https://www.enginatics.com/example/okc-contract-lines-summary/) |
| Blitz Report™ XML Import | [OKC_Contract_Lines_Summary.xml](https://www.enginatics.com/xml/okc-contract-lines-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/okc-contract-lines-summary/](https://www.enginatics.com/reports/okc-contract-lines-summary/) |

## OKC Contract Lines Summary - Case Study & Technical Analysis

### Executive Summary
The **OKC Contract Lines Summary** report provides a structural overview of the Oracle Contracts (OKC) data model. It is primarily a technical or techno-functional report used to understand how contract lines are organized, hierarchically structured, and linked to external objects (like Inventory Items or Service Counters).

### Business Challenge
Oracle Contracts is a complex module with a highly normalized data structure.
-   **Data Visibility:** "We have thousands of contracts, but I don't understand the hierarchy. Which lines are 'Service Lines' and which are 'Usage Lines'?"
-   **Integration:** "We need to build an interface to a third-party billing system. How do we link the contract line to the specific asset being serviced?"
-   **Customization:** "We want to add a custom field to the 'Covered Product' line. What is the underlying Line Style ID for that?"

### Solution
The **OKC Contract Lines Summary** report maps the contract structure.

**Key Features:**
-   **Hierarchy Visualization:** Shows the parent-child relationships between different line styles (e.g., Service Line -> Covered Product -> Pricing Attribute).
-   **Object Linking:** Identifies the "JTF Object" linked to each line (e.g., `OKX_INSTALL_ITEM` for Installed Base items).
-   **Status Counts:** Provides a count of active vs. inactive lines for each style.

### Technical Architecture
The report queries the core OKC setup and transaction tables.

#### Key Tables and Views
-   **`OKC_LINE_STYLES_V`**: Defines the types of lines (Service, Warranty, Subscription) and their hierarchy.
-   **`OKC_K_LINES_B`**: The transaction table storing the actual contract lines.
-   **`JTF_OBJECTS_VL`**: Defines the external entities (like Inventory Items) that can be attached to a contract line.

#### Core Logic
1.  **Structure Analysis:** Starts with the top-level line styles and recursively finds their children (Sublines).
2.  **Usage Analysis:** Counts how many actual contract lines exist for each style to show which features are being used.
3.  **Metadata Exposure:** Lists the source tables and views used by each line style.

### Business Impact
-   **Developer Productivity:** Serves as a "map" for developers building extensions or reports on the Contracts module.
-   **System Health:** Helps identify unused or obsolete contract types.
-   **Data Migration:** Essential for planning data migration strategies when moving legacy contracts into Oracle.


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
