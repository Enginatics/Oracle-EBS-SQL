---
layout: default
last_modified_at: 2026-10-16
title: 'FND Responsibility Menu Exclusions | Oracle EBS SQL Report'
description: 'Responsibility menu exclusions – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Responsibility, Menu, Exclusions, fnd_application_vl, fnd_responsibility_vl, fnd_resp_functions'
permalink: /FND%20Responsibility%20Menu%20Exclusions/
report_name: 'FND Responsibility Menu Exclusions'
report_web_name: fnd-responsibility-menu-exclusions
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Responsibility Menu Exclusions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-menu-exclusions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Responsibility menu exclusions

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Responsibility Name, Excluded User Function Name, Excluded Function Name, Excluded Menu Name

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions), [fnd_resp_functions](https://www.enginatics.com/library/?pg=1&find=fnd_resp_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)

## Related Reports
[FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Menu%20Exclusions/FND%20Responsibility%20Menu%20Exclusions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Responsibility Menu Exclusions 23-Jan-2018 063112.xlsx](https://www.enginatics.com/example/fnd-responsibility-menu-exclusions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) |
| Blitz Report™ XML Import | [FND_Responsibility_Menu_Exclusions.xml](https://www.enginatics.com/xml/fnd-responsibility-menu-exclusions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) |
| SQL Source | [FND Responsibility Menu Exclusions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Menu%20Exclusions/FND%20Responsibility%20Menu%20Exclusions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-responsibility-menu-exclusions/](https://www.enginatics.com/reports/fnd-responsibility-menu-exclusions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-menu-exclusions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
