---
layout: default
title: 'FND Forms Personalizations | Oracle EBS SQL Report'
description: 'Forms personalizations and actions – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Forms, Personalizations, fnd_form_custom_prop_values, fnd_concurrent_programs_vl, fnd_application'
permalink: /FND%20Forms%20Personalizations/
---

# FND Forms Personalizations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-forms-personalizations/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Forms personalizations and actions

## Report Parameters
Form Name, Function Name, Application Name, Description like, Last Updated By, Last Update within Days, Last Update Date From, Last Update Date To, Show Context

## Oracle EBS Tables Used
[fnd_form_custom_prop_values](https://www.enginatics.com/library/?pg=1&find=fnd_form_custom_prop_values), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_form_custom_rules](https://www.enginatics.com/library/?pg=1&find=fnd_form_custom_rules), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_form_custom_scopes](https://www.enginatics.com/library/?pg=1&find=fnd_form_custom_scopes), [fnd_industries](https://www.enginatics.com/library/?pg=1&find=fnd_industries), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_form_custom_actions](https://www.enginatics.com/library/?pg=1&find=fnd_form_custom_actions), [fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl), [fnd_form_custom_prop_list](https://www.enginatics.com/library/?pg=1&find=fnd_form_custom_prop_list)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND FNDLOAD Object Transfer](/FND%20FNDLOAD%20Object%20Transfer/ "FND FNDLOAD Object Transfer Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Forms Personalizations 21-Jul-2017 173253.xlsx](https://www.enginatics.com/example/fnd-forms-personalizations/) |
| Blitz Report™ XML Import | [FND_Forms_Personalizations.xml](https://www.enginatics.com/xml/fnd-forms-personalizations/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-forms-personalizations/](https://www.enginatics.com/reports/fnd-forms-personalizations/) |

## Executive Summary
The **FND Forms Personalizations** report is the definitive audit tool for all custom logic applied to Oracle Forms via the "Personalization" framework. It replaces the need to manually open every form to check for customizations.

## Business Challenge
*   **Upgrade Assessment:** Identifying all personalizations that need to be tested or re-implemented during an upgrade.
*   **Troubleshooting:** Checking if a "bug" is actually caused by a custom personalization rule.
*   **Logic Review:** Documenting business rules implemented via personalization (e.g., making a field mandatory).

## The Solution
This Blitz Report extracts the full personalization logic:
*   **Rule:** The Trigger Event (e.g., `WHEN-NEW-FORM-INSTANCE`) and Condition.
*   **Actions:** The specific actions taken (e.g., Property Property, Message, Builtin).
*   **Scope:** Whether the rule applies to the Site, Responsibility, or User level.

## Technical Architecture
The report joins `FND_FORM_CUSTOM_RULES`, `FND_FORM_CUSTOM_ACTIONS`, and `FND_FORM_CUSTOM_SCOPES`. It provides a flattened view of the Rule -> Action hierarchy.

## Parameters & Filtering
*   **Form Name:** Filter for personalizations on a specific screen.
*   **Description:** Search for keywords in the rule description.
*   **Show Context:** Toggle to see the scope (Site/Resp/User).

## Performance & Optimization
*   **Complex Logic:** The report handles the one-to-many relationship between Rules and Actions.

## FAQ
*   **Q: Does this show CUSTOM.pll changes?**
    *   A: No, this only shows changes made in the "Forms Personalization" window stored in the database. `CUSTOM.pll` is a file-based customization.


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
