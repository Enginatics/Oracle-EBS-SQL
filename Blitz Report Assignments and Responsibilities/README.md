---
layout: default
title: 'Blitz Report Assignments and Responsibilities | Oracle EBS SQL Report'
description: 'Lists all responsibilities, users, and the bitz reports that they can access, presumed they had their Blitz Report Access profile option set to ''User'''
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Assignments, Responsibilities, fnd_profile_option_values, fnd_profile_options, fnd_user_resp_groups'
permalink: /Blitz%20Report%20Assignments%20and%20Responsibilities/
---

# Blitz Report Assignments and Responsibilities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-assignments-and-responsibilities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists all responsibilities, users, and the bitz reports that they can access, presumed they had their Blitz Report Access profile option set to 'User'

## Report Parameters
Responsibility Name, Report Name, Category, User Name, Show Users

## Oracle EBS Tables Used
[fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility), [fnd_form_functions](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions), [fnd_compiled_menu_functions](https://www.enginatics.com/library/?pg=1&find=fnd_compiled_menu_functions), [per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list), [xroac](https://www.enginatics.com/library/?pg=1&find=xroac), [xxen_report_assignments](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Assignments and Responsibilities 14-Oct-2023 123917.xlsx](https://www.enginatics.com/example/blitz-report-assignments-and-responsibilities/) |
| Blitz Report™ XML Import | [Blitz_Report_Assignments_and_Responsibilities.xml](https://www.enginatics.com/xml/blitz-report-assignments-and-responsibilities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-assignments-and-responsibilities/](https://www.enginatics.com/reports/blitz-report-assignments-and-responsibilities/) |

## Blitz Report Assignments and Responsibilities - Case Study & Technical Analysis

### Executive Summary

**Blitz Report Assignments and Responsibilities** is a security matrix report. Unlike the standard "Assignments" report which lists the rules defined in the system, this report explodes those rules to show the effective access for every user. It answers the question: "Which users can run which reports, and through which responsibilities?"

### Business Challenge

*   **Effective Access:** A report might be assigned to the "General Ledger Super User" responsibility. To know exactly *who* can run it, you need to know everyone who has that responsibility.
*   **SoD (Segregation of Duties):** Ensuring that no single user has access to conflicting reports (e.g., "Vendor Master Maintenance" and "Payment Run") across different responsibilities.
*   **License Compliance:** Determining the total count of unique users who have access to Blitz Report functionality.

### Solution

This report joins the Blitz Report assignment rules with the Oracle EBS User and Responsibility tables (`FND_USER`, `FND_USER_RESP_GROUPS`). It provides a flattened view of access rights.

*   **User-Centric View:** Select a user to see every report they can run across all their responsibilities.
*   **Report-Centric View:** Select a report to see every user who can run it.
*   **Responsibility Analysis:** Audit the report content of specific responsibilities.

### Technical Architecture

This report performs a complex join between the Blitz Report security model and the Oracle FND security model.

#### Key Tables & Joins

*   **`XXEN_REPORT_ASSIGNMENTS`:** The rules defining which report belongs to which responsibility/user.
*   **`FND_USER` & `FND_RESPONSIBILITY`:** Standard Oracle security tables.
*   **`FND_USER_RESP_GROUPS`:** The link between users and responsibilities (including effective dates).
*   **`FND_PROFILE_OPTION_VALUES`:** Checks the `Blitz Report Access` profile option to ensure the user actually has the UI access to run reports.

#### Logic

1.  **Identify Assignments:** Finds all active report assignments.
2.  **Expand Responsibilities:** For responsibility-level assignments, it finds all valid users who hold that responsibility within the active date range.
3.  **Profile Check:** It verifies that the user has the necessary profile options enabled to access the Blitz Report form.

### Parameters

*   **Responsibility Name:** Filter by a specific responsibility.
*   **Report Name:** Filter for a specific report.
*   **Category:** Filter by report category.
*   **User Name:** Filter for a specific user.
*   **Show Users:** Toggle to expand the output to list individual users (if 'No', it might just show the responsibility linkage).

### FAQ

**Q: Why does a user appear in this report but cannot see the report in Oracle?**
A: Check the "Effective Dates" on their responsibility assignment. Also, ensure the `Blitz Report Access` profile option is set correctly for that user or responsibility.

**Q: Does this include "Site" level assignments?**
A: Yes, if a report is assigned at the Site level, it is technically available to all users, and this report should reflect that breadth of access.


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
