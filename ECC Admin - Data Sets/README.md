---
layout: default
title: 'ECC Admin - Data Sets | Oracle EBS SQL Report'
description: 'Enterprise Command Centers applications with data sets and load rule DB procedure names for incremental, full and metadata load. For description of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, ECC, Admin, Data, Sets, ecc_app_ds_relationships, ecc_application_tl, ecc_source_system'
permalink: /ECC%20Admin%20-%20Data%20Sets/
---

# ECC Admin - Data Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-data-sets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Enterprise Command Centers applications with data sets and load rule DB procedure names for incremental, full and metadata load.
For description of the load process, see ECC Concurrent Programs <a href="https://www.enginatics.com/reports/ecc-concurrent-programs/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-concurrent-programs/</a>

## Report Parameters
Application, Data Set

## Oracle EBS Tables Used
[ecc_app_ds_relationships](https://www.enginatics.com/library/?pg=1&find=ecc_app_ds_relationships), [ecc_application_tl](https://www.enginatics.com/library/?pg=1&find=ecc_application_tl), [ecc_source_system](https://www.enginatics.com/library/?pg=1&find=ecc_source_system), [ecc_dataset_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_b), [ecc_dataset_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_tl), [ecc_dataset_load_rules](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_load_rules), [ecc_security_rules](https://www.enginatics.com/library/?pg=1&find=ecc_security_rules)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/ "ECC Admin - Metadata Attributes Oracle EBS SQL Report"), [ECC Admin - Data Load Tracking](/ECC%20Admin%20-%20Data%20Load%20Tracking/ "ECC Admin - Data Load Tracking Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Data Sets 10-Sep-2020 115708.xlsx](https://www.enginatics.com/example/ecc-admin-data-sets/) |
| Blitz Report™ XML Import | [ECC_Admin_Data_Sets.xml](https://www.enginatics.com/xml/ecc-admin-data-sets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ecc-admin-data-sets/](https://www.enginatics.com/reports/ecc-admin-data-sets/) |

## ECC Admin - Data Sets

### Description
This report lists the data sets defined within the Enterprise Command Center (ECC) applications. It provides technical details about the load rules and database procedures responsible for data synchronization.

Key information includes:
- **Dataset Definitions**: Names and codes of datasets associated with each ECC application.
- **Load Procedures**: The specific PL/SQL procedures used for incremental, full, and metadata loads.
- **Source Systems**: Identification of the source system for the data.

This report is essential for developers and administrators who need to understand the backend configuration of ECC data flows.

### Parameters
- **Application**: Filter by ECC application.
- **Data Set**: Filter by specific dataset.

### Used Tables
- `ecc_app_ds_relationships`: Relationships between applications and datasets.
- `ecc_application_tl`: Application names.
- `ecc_source_system`: Source system definitions.
- `ecc_dataset_b`: Dataset base table.
- `ecc_dataset_tl`: Dataset translations.
- `ecc_dataset_load_rules`: Load rules configuration.
- `ecc_security_rules`: Security rules applied to datasets.

### Categories
- **Enginatics**: ECC configuration and development.

### Related Reports
- [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/)


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
