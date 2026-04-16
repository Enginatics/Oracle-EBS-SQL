---
layout: default
title: 'FND Responsibility Menu Exclusions | Oracle EBS SQL Report'
description: 'Responsibility menu exclusions – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Responsibility, Menu, Exclusions, fnd_application_vl, fnd_responsibility_vl, fnd_resp_functions'
permalink: /FND%20Responsibility%20Menu%20Exclusions/
---

# FND Responsibility Menu Exclusions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-menu-exclusions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Responsibility menu exclusions

## Report Parameters
Responsibility Name, Excluded User Function Name, Excluded Function Name, Excluded Menu Name

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_resp_functions](https://www.enginatics.com/library/?pg=1&find=fnd_resp_functions), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Responsibility Menu Exclusions 23-Jan-2018 063112.xlsx](https://www.enginatics.com/example/fnd-responsibility-menu-exclusions/) |
| Blitz Report™ XML Import | [FND_Responsibility_Menu_Exclusions.xml](https://www.enginatics.com/xml/fnd-responsibility-menu-exclusions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-responsibility-menu-exclusions/](https://www.enginatics.com/reports/fnd-responsibility-menu-exclusions/) |

## Executive Summary
The **FND Responsibility Menu Exclusions** report documents the specific functions and menus that have been explicitly excluded from responsibilities. This is a critical component of security auditing, ensuring that broad responsibilities are properly restricted according to the principle of least privilege.

## Business Challenge
Organizations often create generic responsibilities (e.g., "Super User") and then restrict them for specific roles by excluding sensitive functions or menus. However, these exclusions are often hidden in sub-tabs of the responsibility definition form. Without a clear report, it is easy to overlook missing exclusions or fail to document how a responsibility differs from its base menu definition, leading to potential security gaps.

## The Solution
This report provides a clear list of all menu and function exclusions defined at the responsibility level. It helps security teams:
- Verify that intended restrictions are actually in place.
- Document the differences between similar responsibilities.
- Troubleshoot why a user cannot access a function they expect to see (if it was inadvertently excluded).

## Technical Architecture
The report queries the `fnd_resp_functions` table, which stores the exclusion rules, and joins it with `fnd_responsibility_vl`, `fnd_form_functions_vl`, and `fnd_menus_vl` to provide human-readable names for the excluded items.

## Parameters & Filtering
- **Responsibility Name:** Filter for a specific responsibility to see its exclusions.
- **Excluded Function/Menu Name:** Search for a specific function to see which responsibilities have excluded it.

## Performance & Optimization
This report queries a specific set of configuration tables and is generally very fast and lightweight.

## FAQ
**Q: What is the difference between a menu exclusion and a function exclusion?**
A: A menu exclusion hides an entire submenu and all its contents. A function exclusion hides a specific action or screen, regardless of where it appears in the menu structure.

**Q: Does this report show the final resulting menu?**
A: No, it only lists the *exclusions*. To see the full resulting access, use the **FND Responsibility Access** report.


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
