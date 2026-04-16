---
layout: default
title: 'FND User Upload | Oracle EBS SQL Report'
description: 'Listing and updating all EBS users and their responsiblities – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, User, fnd_user, per_all_people_f, per_business_groups'
permalink: /FND%20User%20Upload/
---

# FND User Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Listing and updating all EBS users and their responsiblities

## Report Parameters
Upload Mode, User Name, Has Access to Responsibility, Has Access to Application, Active only, Creation Date From, Creation Date To, Created within days

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application), [fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Users](/FND%20Users/ "FND Users Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-user-upload/) |
| Blitz Report™ XML Import | [FND_User_Upload.xml](https://www.enginatics.com/xml/fnd-user-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-upload/](https://www.enginatics.com/reports/fnd-user-upload/) |

## Executive Summary
The **FND User Upload** report is a dual-purpose tool: it provides a detailed extract of user and responsibility data, and it is designed to facilitate mass updates or creation of users via the Blitz Report Upload functionality.

## Business Challenge
Managing users in bulk is time-consuming. Tasks like "Create 50 new users for the training department" or "Add the 'GL Inquiry' responsibility to these 200 users" are tedious to perform manually in the Forms interface.

## The Solution
This report extracts user data in a format that can be modified in Excel and then uploaded back into Oracle EBS (using the Blitz Report Upload framework). It streamlines:
- Mass user creation.
- Mass assignment of responsibilities.
- Updating user attributes (email, description, etc.).

## Technical Architecture
The report queries `fnd_user` and `fnd_user_resp_groups_direct`. It is structured to align with the API parameters required for the user management APIs used by the upload process.

## Parameters & Filtering
- **Upload Mode:** Controls the behavior of the upload (e.g., Create, Update).
- **User Name:** Filter for specific users to extract/update.
- **Has Access to Responsibility:** Find users with a specific responsibility (useful for cloning access).

## Performance & Optimization
The report is optimized for data extraction. When used for uploading, performance depends on the volume of records being processed by the API.

## FAQ
**Q: Can I reset passwords with this?**
A: Yes, if the upload template and API support password updates, this can be used for bulk password resets (usually to a temporary password).

**Q: Does it validate the data?**
A: The upload process typically uses standard Oracle APIs which perform validation (e.g., checking if the responsibility name is valid).


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
