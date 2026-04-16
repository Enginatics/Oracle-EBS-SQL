---
layout: default
title: 'DIS Workbook Owner Export Script | Oracle EBS SQL Report'
description: 'This export of workbook owners is required to remotely export workbook XMLs on the Enginatics environments for customers requiring support when migrating…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Workbook, Owner, Export, fnd_user'
permalink: /DIS%20Workbook%20Owner%20Export%20Script/
---

# DIS Workbook Owner Export Script – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-owner-export-script/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This export of workbook owners is required to remotely export workbook XMLs on the Enginatics environments for customers requiring support when migrating from Discoverer to Blitz Report.

## Report Parameters
End User Layer

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [FND Request Groups](/FND%20Request%20Groups/ "FND Request Groups Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/dis-workbook-owner-export-script/) |
| Blitz Report™ XML Import | [DIS_Workbook_Owner_Export_Script.xml](https://www.enginatics.com/xml/dis-workbook-owner-export-script/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-workbook-owner-export-script/](https://www.enginatics.com/reports/dis-workbook-owner-export-script/) |

## DIS Workbook Owner Export Script

### Description
This script is a utility designed to facilitate the support and migration process from Oracle Discoverer to Blitz Report. It generates a list of workbook owners, which is required to remotely export workbook XML definitions.

When migrating complex Discoverer environments, it is often necessary to export workbook definitions for analysis or conversion. This script provides the necessary user information to target specific owners' workbooks for export, streamlining the migration workflow and ensuring that support teams have the correct context for troubleshooting or conversion tasks.

### Parameters
- **End User Layer**: The Discoverer End User Layer to query for workbook owners.

### Used Tables
- `fnd_user`: Oracle EBS application users table.

### Categories
- **Enginatics**: Utility script for Enginatics' migration and support services.


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
