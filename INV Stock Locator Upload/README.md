---
layout: default
title: 'INV Stock Locator Upload | Oracle EBS SQL Report'
description: 'Create, update and delete Stock Locators. Note on entering a locator as a concatenated segment value: if a segment value contains the KFF delimiter…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Stock, Locator, mtl_item_locations_kfv, mtl_parameters, mtl_material_statuses_vl'
permalink: /INV%20Stock%20Locator%20Upload/
---

# INV Stock Locator Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-stock-locator-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create, update and delete Stock Locators.

Note on entering a locator as a concatenated segment value: if a segment value contains the KFF delimiter character or a backslash (\), each such character must be preceded with a backslash. For example, with delimiter '.', the segment value '1\4\4.' must be written as '1\\4\\4\.'

## Report Parameters
Upload Mode, Organization Code, Subinventory, Locator, Locator From, Locator To, Locator Type, Status

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/inv-stock-locator-upload/) |
| Blitz Report™ XML Import | [INV_Stock_Locator_Upload.xml](https://www.enginatics.com/xml/inv-stock-locator-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-stock-locator-upload/](https://www.enginatics.com/reports/inv-stock-locator-upload/) |



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
