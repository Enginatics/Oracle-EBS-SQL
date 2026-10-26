---
layout: default
last_modified_at: 2026-10-26
title: 'WSH Transit Time Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes transit times - the Transit Times form (Shipping > Setup > Regions and Zones > Transit Times). A row is one ship method of a…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, WSH, Transit, Time, mtl_interorg_ship_methods'
permalink: /WSH%20Transit%20Time%20Upload/
report_name: 'WSH Transit Time Upload'
report_web_name: wsh-transit-time-upload
---

# WSH Transit Time Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-transit-time-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload).

## Overview
Creates, updates and deletes transit times - the Transit Times form (Shipping > Setup > Regions and Zones > Transit Times). A row is one ship method of a lane, which is an origin and destination pair of locations, regions or zones, with the intransit time in days and the optional daily capacities and cost per unit.

The origin and destination of a downloaded row cannot be changed. Changing its Ship Method changes the ship method of that row. To remove a ship method from a lane, enter Yes in Delete Transit Time.

Setting Default Method to Yes removes the flag from the lane's other ship methods, as the form does, and the Message names them.

Regions are the country, state, city and postal code regions already defined in Regions and Zones; the upload does not create regions. A location or region name that occurs more than once is followed by its description in brackets.

An internal location that belongs to an organization accepts only the ship methods of the carrier services enabled for its inventory organization, as the form's list does. Lanes between inventory organizations defined in Shipping Networks are downloaded as well, when their organizations' locations are set.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Origin Type, Origin, Destination Type, Destination, Ship Method

## Oracle EBS Tables Used
[mtl_interorg_ship_methods](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_ship_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)

## Related Reports
[PO Internal Requisitions and Sales Orders](/PO%20Internal%20Requisitions%20and%20Sales%20Orders/ "PO Internal Requisitions and Sales Orders Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Shipping Networks Missing Interco OU Relationships](/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/ "CAC Shipping Networks Missing Interco OU Relationships Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Transit%20Time%20Upload/WSH%20Transit%20Time%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wsh-transit-time-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) |
| Blitz Report™ XML Import | [WSH_Transit_Time_Upload.xml](https://www.enginatics.com/xml/wsh-transit-time-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) |
| SQL Source | [WSH Transit Time Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Transit%20Time%20Upload/WSH%20Transit%20Time%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wsh-transit-time-upload/](https://www.enginatics.com/reports/wsh-transit-time-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-transit-time-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
