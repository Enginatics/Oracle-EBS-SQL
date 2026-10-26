---
layout: default
last_modified_at: 2026-10-26
title: 'PER Location Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, and delete HR Locations. Supports all country-specific address styles with address field validation. Includes site flags…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, PER, Location, fnd_timezones_vl, hr_locations_all, hr_locations_all_tl'
permalink: /PER%20Location%20Upload/
report_name: 'PER Location Upload'
report_web_name: per-location-upload
---

# PER Location Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-location-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Default Address Style, Location Name, Location Name Like, Location Status, Country, Global, Legal Address, Bill To Site, Ship To Site, Receiving Site, Internal Site, Office Site

## Oracle EBS Tables Used
[fnd_timezones_vl](https://www.enginatics.com/library/?pg=1&find=fnd_timezones_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [hr_locations_all_tl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Location%20Upload/PER%20Location%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-location-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) |
| Blitz Report™ XML Import | [PER_Location_Upload.xml](https://www.enginatics.com/xml/per-location-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) |
| SQL Source | [PER Location Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Location%20Upload/PER%20Location%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-location-upload/](https://www.enginatics.com/reports/per-location-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload) |

## Case Study & Technical Analysis: PER Location Upload

### Executive Summary
The PER Location Upload report creates, updates and deletes HR Locations in Oracle E-Business Suite Human Resources from a spreadsheet. HR locations hold the physical addresses of offices, sites and buildings, and they are used across HR, Payroll, Projects and Inventory. HR administrators and implementation teams use the upload to load a new location set, to correct addresses in bulk and to set the site flags that govern shipping, receiving, billing and office use. It supports the address formats of each country and validates address fields against the style that applies.

### Business Challenge
*   **Address accuracy across countries:** Each country uses its own address layout, and a location loaded in the wrong style produces unusable addresses.
*   **Site flag consistency:** Ship-to, receiving, bill-to, office, internal and inventory organization flags interact, and an inconsistent combination breaks downstream processes.
*   **Multi-business-group security:** Locations must be visible to the right business group, while global locations are shared, so the scope of each row must be clear.
*   **Legal address protection:** Legal address locations must not be inactivated or deleted, and the upload must not change their legal status.

### The Solution
*   **Style-aware address fields:** Address fields are shown under the address style of each location, with the country-specific labels.
*   **Automatic ship-to and receiving logic:** The ship-to site flag is derived from the ship-to location relationship, and the receiving site flag follows the ship-to setting.
*   **Business group scope:** Locations are restricted to the current business group plus global locations, and a new location can be made local to the current business group.
*   **Protected records:** Legal address locations cannot be inactivated or deleted by the upload, and the legal flag is information only.

### Technical Architecture (High Level)
#### Primary Tables
*   `HR_LOCATIONS_ALL`: the location record, with its code, inactive date, address style, address lines, site flags, timezone and flexfield attributes.
*   `HR_LOCATIONS_ALL_TL`: the translated location description, read in the session language.
*   `MTL_PARAMETERS`: the inventory organization linked to the location.
*   `PER_ALL_PEOPLE_F`: the designated receiver, shown as the contact.
*   `PER_BUSINESS_GROUPS`: the business group name.
*   `FND_TIMEZONES_VL`: the timezone name for the location's timezone code.

#### Logical Relationships
1.  `HR_LOCATIONS_ALL` is joined to `HR_LOCATIONS_ALL_TL` on the location ID, restricted to the session language.
2.  The ship-to location is found by a second, outer joined reference to `HR_LOCATIONS_ALL` through the ship-to location ID, so the ship-to code can be shown.
3.  The inventory organization, designated receiver and business group are outer joined, so locations without them still appear.
4.  The business group filter keeps locations whose business group matches the current business group, or that are global, using the HR general business group function.
5.  The timezone name is read through a scalar subquery on the timezone code.

### Parameters & Filtering
*   **Upload Mode:** Selects create, update or delete behaviour for the downloaded locations.
*   **Default Address Style:** Sets the address style used for new locations.
*   **Location Name and Location Name Like:** Find a location by exact name or by part of the name.
*   **Location Status:** Restricts the output to active or inactive locations.
*   **Country:** Limits the locations to one country.
*   **Global:** Shows global locations, which are not assigned to a business group.
*   **Legal Address, Bill To Site, Ship To Site, Receiving Site, Internal Site and Office Site:** Filter the locations by their flags.

### Performance & Optimization
*   **Business group filter in the WHERE clause:** The business group test is applied to every location row, which limits the output to the current business group and global locations.
*   **Language restriction on descriptions:** The description join is restricted to the session language, so each location has one description row.
*   **Outer joins for optional links:** Ship-to location, inventory organization, receiver and business group are outer joined, so locations with none of these still appear.
*   **Flexfield display functions:** Address and location flexfield values are resolved through display functions, which add per-row calls on wide address styles.

### FAQ
**Q: Can I delete a legal address location with this upload?**
A: No. Legal address locations are protected from inactivation and deletion, and the upload cannot set or change the legal address flag.
**Q: Why does a new location show a receiving site flag of Yes?**
A: By default a new location is its own ship-to location. When the ship-to site is self-referencing, the ship-to flag and receiving flag are both set to Yes.
**Q: Which locations appear in the download?**
A: Locations in the current business group and global locations, so locations in other business groups are not shown.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-location-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
