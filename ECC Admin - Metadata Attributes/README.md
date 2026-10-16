---
layout: default
last_modified_at: 2026-10-16
title: 'ECC Admin - Metadata Attributes | Oracle EBS SQL Report'
description: 'Enterprise Command Centers metadata attributes – Oracle EBS Enterprise Command Center SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enterprise Command Center, Enginatics, R12 only, ECC, Admin, Metadata, Attributes, ecc_app_ds_relationships, ecc_application_tl, ecc_dataset_b'
permalink: /ECC%20Admin%20-%20Metadata%20Attributes/
report_name: 'ECC Admin - Metadata Attributes'
report_web_name: ecc-admin-metadata-attributes
module: 'Enterprise Command Center'
module_url: /modules/enterprise-command-center/
---

# ECC Admin - Metadata Attributes – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-metadata-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes).
**Oracle EBS module:** [Enterprise Command Center](/modules/enterprise-command-center/ "Oracle EBS Enterprise Command Center reports") · [all Enterprise Command Center reports](/modules/enterprise-command-center/)  

## Overview
Enterprise Command Centers metadata attributes

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Data Set, Attribute Key

## Oracle EBS Tables Used
[ecc_app_ds_relationships](https://www.enginatics.com/library/?pg=1&find=ecc_app_ds_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [ecc_application_tl](https://www.enginatics.com/library/?pg=1&find=ecc_application_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [ecc_dataset_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [ecc_dataset_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [ecc_dataset_attrs_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_attrs_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [ecc_dataset_attrs_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_attrs_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)

## Related Reports
[ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/ "ECC Admin - Data Sets Oracle EBS SQL Report"), [ECC Admin - Data Load Tracking](/ECC%20Admin%20-%20Data%20Load%20Tracking/ "ECC Admin - Data Load Tracking Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Metadata%20Attributes/ECC%20Admin%20-%20Metadata%20Attributes.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Metadata Attributes 15-Jun-2020 193045.xlsx](https://www.enginatics.com/example/ecc-admin-metadata-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) |
| Blitz Report™ XML Import | [ECC_Admin_Metadata_Attributes.xml](https://www.enginatics.com/xml/ecc-admin-metadata-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) |
| SQL Source | [ECC Admin - Metadata Attributes.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Metadata%20Attributes/ECC%20Admin%20-%20Metadata%20Attributes.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ecc-admin-metadata-attributes/](https://www.enginatics.com/reports/ecc-admin-metadata-attributes/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes) |

## ECC Admin - Metadata Attributes

### Description
This report provides a detailed view of the metadata attributes defined for Enterprise Command Center (ECC) datasets. It maps the attributes to their respective applications and datasets, offering insight into the data model exposed to the ECC dashboards.

This information is valuable for:
- **Customization**: Understanding available attributes for dashboard customization.
- **Troubleshooting**: Verifying that the correct attributes are being loaded and exposed.
- **Documentation**: Documenting the data elements available in the command center.

### Parameters
- **Application**: Filter by ECC application.
- **Data Set**: Filter by dataset.
- **Attribute Key**: Filter by specific attribute key.

### Used Tables
- `ecc_app_ds_relationships`: Application-dataset links.
- `ecc_application_tl`: Application names.
- `ecc_dataset_b`: Dataset definitions.
- `ecc_dataset_tl`: Dataset names.
- `ecc_dataset_attrs_b`: Attribute base definitions.
- `ecc_dataset_attrs_tl`: Attribute translations.

### Categories
- **Enginatics**: ECC metadata analysis.

### Related Reports
- [ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-metadata-attributes)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
