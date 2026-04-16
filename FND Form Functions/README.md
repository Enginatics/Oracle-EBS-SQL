---
layout: default
title: 'FND Form Functions | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Form, Functions, fnd_form_functions_vl, fnd_application_vl, fnd_form_vl'
permalink: /FND%20Form%20Functions/
---

# FND Form Functions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-form-functions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Function Name, User Function Name like, Function Type, Form Application Name, Form Application Short Name, Form Name, User Form Name, Responsibility Name, HTML Call contains

## Oracle EBS Tables Used
[fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND FNDLOAD Object Transfer](/FND%20FNDLOAD%20Object%20Transfer/ "FND FNDLOAD Object Transfer Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Form Functions 21-Jul-2017 172941.xlsx](https://www.enginatics.com/example/fnd-form-functions/) |
| Blitz Report™ XML Import | [FND_Form_Functions.xml](https://www.enginatics.com/xml/fnd-form-functions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-form-functions/](https://www.enginatics.com/reports/fnd-form-functions/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
