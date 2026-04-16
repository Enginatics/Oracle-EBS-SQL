---
layout: default
title: 'FND Responsibility Access 11i | Oracle EBS SQL Report'
description: 'Responsibilites and related data such as users, concurrent programs, menus, functions, forms, data access set and security profiles and associated ledgers…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Responsibility, Access, 11i, fnd_form_functions_vl, fnd_form_vl, fnd_menu_entries_vl'
permalink: /FND%20Responsibility%20Access%2011i/
---

# FND Responsibility Access 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-access-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Responsibilites and related data such as users, concurrent programs, menus, functions, forms, data access set and security profiles and associated ledgers and operating units.
This report basically answers all system access related questions. It shows which users or responsibilities have acess to which functions, forms, concurrent programs, ledgers, operating units or inventory organizations.

Depending on parameter selection, this report shows for example:

- responsibilities and related menus and request groups
- responsibilities, menus, included forms, functions and their full menu navigation path
- users and their assigned active responsibilities
- users, assigned responsibilities and the concurrent programs they have access to
- concurrent programs and the responsibilities that they can be run from
- forms or functions and the responsibilities and users that can access them
- responsibilities and navigation paths to access a certain form or function from a given user
- operating units that a particular responsibility or user has access to through MOAC security profiles or profile option 'MO: Operating Unit'

The parameters 'User', 'Form', 'Function' and 'Concurrent Program' are optional and can either be populated to filter records for a particular value only or entered with % to show all values or left blank to not show data related to that parameter. If the user parameter is left blank for example, then the report does not show any user names and shows information related to responsibility level only.

Example: To show all users having access to the user maintenance form, enter parameters as follows:
User Name: %
User Form Name: Define Application User

Please note that the SQL currently doesn't consider menu exclusions yet, which means that it's not 100% accurate as excluded functions would still show up in the report.

## Report Parameters
Responsibility Name, User Name like, Application, Access to Inventory Org, Access to Operating Unit, Concurrent Program Name like, Concurrent Progr. (all languages), Concurrent Program Short Name, Request Group, Menu Entry like, User Function Name like, Function Name, User Form Name like, Form Name, User Menu Name, Menu Name, Expand Multiple Operating Units

## Oracle EBS Tables Used
[fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl), [fnd_menu_entries_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries_vl), [fnd_menus_tl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_tl), [per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups), [fnd_request_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_request_group_units), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_request_sets_vl](https://www.enginatics.com/library/?pg=1&find=fnd_request_sets_vl), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl), [usr](https://www.enginatics.com/library/?pg=1&find=usr), [fnd_compiled_menu_functions](https://www.enginatics.com/library/?pg=1&find=fnd_compiled_menu_functions), [func](https://www.enginatics.com/library/?pg=1&find=func), [nav](https://www.enginatics.com/library/?pg=1&find=nav), [fnd_mo_product_init](https://www.enginatics.com/library/?pg=1&find=fnd_mo_product_init), [prof](https://www.enginatics.com/library/?pg=1&find=prof), [org](https://www.enginatics.com/library/?pg=1&find=org)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Resources](/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/ "PA Revenue, Cost, Budgets by Resources Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Work Breakdown Structure](/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/ "PA Revenue, Cost, Budgets by Work Breakdown Structure Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-responsibility-access-11i/) |
| Blitz Report™ XML Import | [FND_Responsibility_Access_11i.xml](https://www.enginatics.com/xml/fnd-responsibility-access-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-responsibility-access-11i/](https://www.enginatics.com/reports/fnd-responsibility-access-11i/) |

## Executive Summary
This report provides a comprehensive view of system access for Oracle EBS 11i environments. It details the relationships between users, responsibilities, menus, functions, forms, and data access sets (including ledgers and operating units). It is designed to answer critical security questions regarding "who has access to what" at a granular level.

## Business Challenge
In Oracle EBS 11i, security is defined across multiple layers: users are assigned responsibilities, responsibilities are assigned menus, and menus contain functions and forms. Additionally, data access is controlled via security profiles and operating unit assignments. Auditing this complex web of permissions to ensure compliance (e.g., SOX) or to troubleshoot access issues is difficult and time-consuming when relying on standard screens or disparate reports.

## The Solution
The **FND Responsibility Access 11i** report consolidates all access information into a single view. It allows security administrators and auditors to:
- Identify which users have access to specific critical functions or forms.
- Review the full menu navigation path for responsibilities.
- Verify operating unit access for users and responsibilities.
- Audit concurrent program access.

## Technical Architecture
The report joins core FND security tables including `fnd_user`, `fnd_responsibility`, `fnd_menus`, `fnd_form_functions`, and `fnd_request_groups`. It also incorporates HR security tables like `per_security_profiles` and `hr_operating_units` to determine data access.
*Note: The current SQL does not fully account for menu exclusions, so excluded functions may still appear in the output.*

## Parameters & Filtering
The report supports flexible filtering to target specific access queries:
- **User Name:** Filter by specific users or use `%` for all.
- **Responsibility Name:** Focus on specific responsibilities.
- **Form/Function Name:** Find who can access specific system capabilities.
- **Concurrent Program:** Audit access to specific reports or processes.
- **Operating Unit:** Check access to specific business entities.

## Performance & Optimization
The report is optimized for reporting but involves complex joins across the security model. For best performance, it is recommended to provide at least one high-level filter (e.g., User Name or Responsibility Name) rather than running it wide open for the entire system.

## FAQ
**Q: Does this report show 11i specific data?**
A: Yes, this version is specifically tailored for the 11i data model.

**Q: Does it show if a user is end-dated?**
A: Yes, user and responsibility effective dates are considered.

**Q: Why might a function show up even if I excluded it?**
A: As noted in the description, the current SQL logic does not filter out menu exclusions.


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
