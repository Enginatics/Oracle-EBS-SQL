---
layout: default
title: 'MRP Sourcing Rule Upload | Oracle EBS SQL Report'
description: 'MRP Sourcing Rule Upload ==================== - Upload new Sourcing Rules - Update Existing Sourcing Rules'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, MRP, Sourcing, Rule, mrp_sourcing_rules, mtl_parameters, mrp_sr_receipt_org_v'
permalink: /MRP%20Sourcing%20Rule%20Upload/
---

# MRP Sourcing Rule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-sourcing-rule-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MRP Sourcing Rule Upload
====================
- Upload new Sourcing Rules
- Update Existing Sourcing Rules

## Report Parameters
Upload Mode, Sourcing Rule Type, Include Global Sourcing Rules, Sourcing Rule Organization, Sourcing Rule Name, Sourcing Rule Name Like

## Oracle EBS Tables Used
[mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_sr_receipt_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org_v), [mrp_sr_source_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org_v), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [sr_query](https://www.enginatics.com/library/?pg=1&find=sr_query)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/mrp-sourcing-rule-upload/) |
| Blitz Report™ XML Import | [MRP_Sourcing_Rule_Upload.xml](https://www.enginatics.com/xml/mrp-sourcing-rule-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-sourcing-rule-upload/](https://www.enginatics.com/reports/mrp-sourcing-rule-upload/) |

## MRP Sourcing Rule Upload - Case Study & Technical Analysis

### Executive Summary
The **MRP Sourcing Rule Upload** is a tool for creating and maintaining the Sourcing Rules themselves (the "How" and "Where"). While the *Assignment Upload* determines *which* items use a rule, this tool defines *what* the rule actually does (e.g., "Buy from Supplier A with 60% allocation and Supplier B with 40%").

### Business Challenge
Defining complex sourcing logic manually is slow.
-   **Multi-Sourcing:** "We want to split our volume for this commodity: 50% to Vendor A, 30% to Vendor B, and 20% to Vendor C."
-   **Inter-Org Transfers:** "We need to define transfer rules for 50 different distribution centers."
-   **Updates:** "Vendor A is changing their name/site. We need to update 200 sourcing rules to reflect the new site."

### Solution
The **MRP Sourcing Rule Upload** allows bulk definition of these rules.

**Key Features:**
-   **Rule Definition:** Create new rules or update existing ones.
-   **Source Types:** Supports "Buy From" (Supplier), "Transfer From" (Org), and "Make At" (Org).
-   **Allocations:** Allows defining split percentages and rankings (Rank 1 vs. Rank 2).

### Technical Architecture
The tool interfaces with the Sourcing Rule definition tables.

#### Key Tables and Views
-   **`MRP_SOURCING_RULES`**: The header table for the rule.
-   **`MRP_SR_RECEIPT_ORG`**: Defines the receiving organization (for local rules).
-   **`MRP_SR_SOURCE_ORG`**: Defines the source (Supplier, Org) and allocation %.

#### Core Logic
1.  **Header Creation:** Creates the rule header in `MRP_SOURCING_RULES`.
2.  **Detail Creation:** Creates the source details (Supplier/Org, Allocation %, Rank) in `MRP_SR_SOURCE_ORG`.
3.  **Validation:** Checks that allocations sum to 100% (if required) and that suppliers/orgs are valid.

### Business Impact
-   **Procurement Strategy:** Enables the rapid implementation of strategic sourcing decisions (e.g., dual-sourcing initiatives).
-   **Network Optimization:** Facilitates the setup of complex distribution networks (Hub-and-Spoke).
-   **Data Integrity:** Ensures that sourcing rules are defined consistently and accurately.


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
