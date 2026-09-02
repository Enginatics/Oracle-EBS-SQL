---
layout: default
title: 'PER Location Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, and delete HR Locations. Supports all country-specific address styles with address field validation. Includes site flags…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Location, fnd_timezones_vl, hr_locations_all, hr_locations_all_tl'
permalink: /PER%20Location%20Upload/
---

# PER Location Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-location-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create, update, and delete HR Locations.

Supports all country-specific address styles with address field validation.

Includes site flags (Ship-To, Bill-To, Receiving, Office, Internal) with autocorrection for Ship-To and Receiving flags based on the Ship-To Location relationship.

Includes the Descriptive Flexfield attributes with validation.

Business group security restricts downloaded locations to the user's current business group plus global locations. New locations can optionally be made local by assigning the location to the user's current business group. If not assigned to a business group, the location is a global location. 

Legal Address locations are protected from inactivation and deletion. The upload cannot set or change the Legal Address Flag. This is for information only.

By default, new locations are created with themselves as the ship to location (self-referencing)

The upload will automatically set the ship to site flag based on the ship to location. When the ship to site is self-referencing, the ship to flag and receiving flag are always set to Yes. If the ship to location references a different location, the ship to site flag will be set to No. 

If the ship to site flag is set to Yes, the receiving site flag is also set to Yes. Otherwise, the receiving site flag will be set as specified in the upload excel. 


## Report Parameters
Upload Mode, Default Address Style, Location Name, Location Name Like, Location Status, Country, Global, Legal Address, Bill To Site, Ship To Site, Receiving Site, Internal Site, Office Site

## Oracle EBS Tables Used
[fnd_timezones_vl](https://www.enginatics.com/library/?pg=1&find=fnd_timezones_vl), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [hr_locations_all_tl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_tl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/per-location-upload/) |
| Blitz Report™ XML Import | [PER_Location_Upload.xml](https://www.enginatics.com/xml/per-location-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/per-location-upload/](https://www.enginatics.com/reports/per-location-upload/) |



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
