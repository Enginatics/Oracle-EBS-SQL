---
layout: default
title: 'ECC Admin - Metadata Attributes | Oracle EBS SQL Report'
description: 'Enterprise Command Centers metadata attributes – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, ECC, Admin, Metadata, Attributes, ecc_app_ds_relationships, ecc_application_tl, ecc_dataset_b'
permalink: /ECC%20Admin%20-%20Metadata%20Attributes/
---

# ECC Admin - Metadata Attributes – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-metadata-attributes/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Enterprise Command Centers metadata attributes

## Report Parameters
Application, Data Set, Attribute Key

## Oracle EBS Tables Used
[ecc_app_ds_relationships](https://www.enginatics.com/library/?pg=1&find=ecc_app_ds_relationships), [ecc_application_tl](https://www.enginatics.com/library/?pg=1&find=ecc_application_tl), [ecc_dataset_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_b), [ecc_dataset_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_tl), [ecc_dataset_attrs_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_attrs_b), [ecc_dataset_attrs_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_attrs_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/ "ECC Admin - Data Sets Oracle EBS SQL Report"), [ECC Admin - Data Load Tracking](/ECC%20Admin%20-%20Data%20Load%20Tracking/ "ECC Admin - Data Load Tracking Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Metadata Attributes 15-Jun-2020 193045.xlsx](https://www.enginatics.com/example/ecc-admin-metadata-attributes/) |
| Blitz Report™ XML Import | [ECC_Admin_Metadata_Attributes.xml](https://www.enginatics.com/xml/ecc-admin-metadata-attributes/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ecc-admin-metadata-attributes/](https://www.enginatics.com/reports/ecc-admin-metadata-attributes/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
