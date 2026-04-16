---
layout: default
title: 'FND User Login Page Favorites | Oracle EBS SQL Report'
description: 'User''s HTML favourites from table icxcustommenuentries – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, User, Login, Page, icx_custom_menu_entries, fnd_responsibility_vl, fnd_form_functions_vl'
permalink: /FND%20User%20Login%20Page%20Favorites/
---

# FND User Login Page Favorites – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-login-page-favorites/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
User's HTML favourites from table icx_custom_menu_entries

## Report Parameters
User Name

## Oracle EBS Tables Used
[icx_custom_menu_entries](https://www.enginatics.com/library/?pg=1&find=icx_custom_menu_entries), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Menu Entry Upload](/FND%20Menu%20Entry%20Upload/ "FND Menu Entry Upload Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Login Page Favorites 20-Jan-2019 123147.xlsx](https://www.enginatics.com/example/fnd-user-login-page-favorites/) |
| Blitz Report™ XML Import | [FND_User_Login_Page_Favorites.xml](https://www.enginatics.com/xml/fnd-user-login-page-favorites/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-login-page-favorites/](https://www.enginatics.com/reports/fnd-user-login-page-favorites/) |

## Executive Summary
The **FND User Login Page Favorites** report lists the "Favorites" (or "Top Ten") links that users have configured on their Oracle EBS home page. This provides insight into which functions are most frequently used or deemed most important by the user base.

## Business Challenge
During system upgrades, UI redesigns, or role changes, it is helpful to know what shortcuts users rely on. Losing these personalizations can cause user frustration. Additionally, administrators may want to analyze usage patterns to see which functions are actually being prioritized by users.

## The Solution
This report extracts the user-defined favorites from the `icx_custom_menu_entries` table. It allows administrators to:
- Backup user favorites before a system refresh.
- Analyze common favorites to improve global menu design.
- Troubleshoot issues where a user claims a favorite link is broken.

## Technical Architecture
The report queries `icx_custom_menu_entries` and joins to `fnd_form_functions_vl` and `fnd_responsibility_vl` to provide the human-readable names of the functions and responsibilities associated with the favorites.

## Parameters & Filtering
- **User Name:** Filter for a specific user to see their favorites.

## Performance & Optimization
This report is lightweight and runs quickly.

## FAQ
**Q: Can I use this to copy favorites from one user to another?**
A: This report *reads* the data. To copy favorites, you would need a separate script or API to insert records into the `icx_custom_menu_entries` table based on this output.

**Q: Does this include the "Navigator" menu?**
A: No, this is specifically for the "Favorites" list usually displayed on the right side or center of the EBS Home Page.


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
