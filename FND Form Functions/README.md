---
layout: default
last_modified_at: 2026-10-19
title: 'FND Form Functions | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Form, Functions, fnd_form_functions_vl, fnd_application_vl, fnd_form_vl'
permalink: /FND%20Form%20Functions/
report_name: 'FND Form Functions'
report_web_name: fnd-form-functions
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Form Functions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-form-functions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Function Name, User Function Name like, Function Type, Form Application Name, Form Application Short Name, Form Name, User Form Name, Responsibility Name, HTML Call contains

## Oracle EBS Tables Used
[fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)

## Related Reports
[Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND FNDLOAD Object Transfer](/FND%20FNDLOAD%20Object%20Transfer/ "FND FNDLOAD Object Transfer Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Form%20Functions/FND%20Form%20Functions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Form Functions 21-Jul-2017 172941.xlsx](https://www.enginatics.com/example/fnd-form-functions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) |
| Blitz Report™ XML Import | [FND_Form_Functions.xml](https://www.enginatics.com/xml/fnd-form-functions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) |
| SQL Source | [FND Form Functions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Form%20Functions/FND%20Form%20Functions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-form-functions/](https://www.enginatics.com/reports/fnd-form-functions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions) |

## Executive Summary
The **FND Form Functions** report documents the registered functions in Oracle EBS. A "Function" is the basic unit of application logic (a form, a web page, or a sub-function) that can be assigned to a menu.

## Business Challenge
*   **Security Analysis:** Identifying which functions invoke a specific Form or HTML page.
*   **Menu Construction:** Finding the correct function name to add to a new custom menu.
*   **Web vs. Form:** Distinguishing between OAF (HTML) functions and Oracle Forms functions.

## The Solution
This Blitz Report lists the function details:
*   **Function Name:** The internal developer name.
*   **User Function Name:** The friendly name seen in menus.
*   **Type:** Form, Subfunction, JSP, etc.
*   **Form/HTML Call:** The actual code or form executable being invoked.

## Technical Architecture
The report queries `FND_FORM_FUNCTIONS_VL` and joins to `FND_FORM_VL` to show the linked form (if applicable).

## Parameters & Filtering
*   **Function Name:** Search by internal name.
*   **HTML Call contains:** Useful for finding all functions that point to a specific JSP page or OAF region.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: What is a "Subfunction"?**
    *   A: It is a function that doesn't open a screen but grants permission to a specific button or logic within a screen (Function Security).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-form-functions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
