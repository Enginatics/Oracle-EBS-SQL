---
layout: default
last_modified_at: 2026-10-16
title: 'CSI Installed Base Extended Attributes Summary | Oracle EBS SQL Report'
description: 'Master data report of extended Installed Base attribute levels and names – Oracle EBS Installed Base SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Installed Base, Enginatics, CSI, Installed, Base, Extended, csi_iea_values, csi_i_extended_attribs'
permalink: /CSI%20Installed%20Base%20Extended%20Attributes%20Summary/
report_name: 'CSI Installed Base Extended Attributes Summary'
report_web_name: csi-installed-base-extended-attributes-summary
module: 'Installed Base'
module_url: /modules/installed-base/
---

# CSI Installed Base Extended Attributes Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/csi-installed-base-extended-attributes-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary).
**Oracle EBS module:** [Installed Base](/modules/installed-base/ "Oracle EBS Installed Base reports") · [all Installed Base reports](/modules/installed-base/)  

## Overview
Master data report of extended Installed Base attribute levels and names

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[csi_iea_values](https://www.enginatics.com/library/?pg=1&find=csi_iea_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary), [csi_i_extended_attribs](https://www.enginatics.com/library/?pg=1&find=csi_i_extended_attribs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)

## Related Reports
[AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CSI%20Installed%20Base%20Extended%20Attributes%20Summary/CSI%20Installed%20Base%20Extended%20Attributes%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CSI Installed Base Extended Attributes Summary 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/csi-installed-base-extended-attributes-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) |
| Blitz Report™ XML Import | [CSI_Installed_Base_Extended_Attributes_Summary.xml](https://www.enginatics.com/xml/csi-installed-base-extended-attributes-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) |
| SQL Source | [CSI Installed Base Extended Attributes Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CSI%20Installed%20Base%20Extended%20Attributes%20Summary/CSI%20Installed%20Base%20Extended%20Attributes%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/csi-installed-base-extended-attributes-summary/](https://www.enginatics.com/reports/csi-installed-base-extended-attributes-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary) |

## Executive Summary
The **CSI Installed Base Extended Attributes Summary** report is a master data management tool for the Oracle Installed Base. It lists the "Extended Attributes" (user-defined fields) that have been configured to track additional technical or business data for item instances. This report helps administrators understand the data model extensions that have been applied to the standard Installed Base functionality.

## Business Challenge
Standard fields (Item, Serial Number, Owner) are often insufficient for complex products. Companies use Extended Attributes to track specific data like "Software Version," "Calibration Date," or "IP Address."
*   **Configuration Visibility**: As these attributes are custom-defined, it can be hard to get a clear list of what attributes exist and where they are used.
*   **Data Governance**: Ensuring that attributes are named consistently and applied to the correct item categories.
*   **Reporting**: Knowing the attribute names is a prerequisite for building custom reports that query this data.

## Solution
This report provides a dictionary of the defined Extended Attributes.

**Key Features:**
*   **Attribute Definition**: Lists the Attribute Name, Level, and other definition details.
*   **Value Analysis**: Can potentially show the distribution of values (depending on the specific query implementation) or just the structure.

## Architecture
The report queries `CSI_I_EXTENDED_ATTRIBS` and `CSI_IEA_VALUES`.

**Key Tables:**
*   `CSI_I_EXTENDED_ATTRIBS`: Defines the attribute structure (metadata).
*   `CSI_IEA_VALUES`: Stores the actual values assigned to specific instances.

## Impact
*   **System Documentation**: Acts as a data dictionary for the custom attributes in the Installed Base.
*   **Report Development**: Assists developers in finding the correct column/attribute names when building custom queries.
*   **Standardization**: Helps enforce naming conventions for new attributes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=csi-installed-base-extended-attributes-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
