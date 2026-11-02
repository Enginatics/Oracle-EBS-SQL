---
layout: default
last_modified_at: 2026-11-02
title: 'MRP Sourcing Rule Upload | Oracle EBS SQL Report'
description: 'MRP Sourcing Rule Upload ======================== - Upload new Sourcing Rules and Bills of Distribution - Download, update and delete existing Sourcing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, MRP, Sourcing, Rule, mrp_sourcing_rules, mtl_parameters, mrp_sr_receipt_org_v'
permalink: /MRP%20Sourcing%20Rule%20Upload/
report_name: 'MRP Sourcing Rule Upload'
report_web_name: mrp-sourcing-rule-upload
---

# MRP Sourcing Rule Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-sourcing-rule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload).

## Overview
MRP Sourcing Rule Upload
========================
- Upload new Sourcing Rules and Bills of Distribution
- Download, update and delete existing Sourcing Rules, their receiving organizations and their sources

Each row is one source (a shipping organization or a supplier) of one receiving organization of a sourcing rule. The rule and receiving organization columns repeat on every row of the rule. All rows of a rule are saved together through the Oracle sourcing rule API, so an error on one row rejects the whole rule.

Planning Active is set by the upload: Yes when the allocation percentages of each rank of each receiving organization add up to 100.

Delete Option
- Sourcing Rule: deletes the whole rule
- Shipping Org: deletes the source of the row
A receiving organization entry cannot be deleted by the upload, as the Oracle API rejects it; delete its sources, delete the whole rule, or remove it in the Sourcing Rule form.

Use Sourcing Rule Type, Sourcing Rule Organization and Include Global Sourcing Rules to select the rules to download.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Sourcing Rule Type, Include Global Sourcing Rules, Sourcing Rule Organization, Sourcing Rule Name, Sourcing Rule Name Like

## Oracle EBS Tables Used
[mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [mrp_sr_receipt_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [mrp_sr_source_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [MRP Sourcing Rules and Bills of Distribution](/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/ "MRP Sourcing Rules and Bills of Distribution Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Sourcing%20Rule%20Upload/MRP%20Sourcing%20Rule%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/mrp-sourcing-rule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) |
| Blitz Report™ XML Import | [MRP_Sourcing_Rule_Upload.xml](https://www.enginatics.com/xml/mrp-sourcing-rule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) |
| SQL Source | [MRP Sourcing Rule Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Sourcing%20Rule%20Upload/MRP%20Sourcing%20Rule%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-sourcing-rule-upload/](https://www.enginatics.com/reports/mrp-sourcing-rule-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rule-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
