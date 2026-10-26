---
layout: default
last_modified_at: 2026-10-26
title: 'FND Responsibility Access | Oracle EBS SQL Report'
description: 'Responsibilites and related data such as users, concurrent programs, menus, functions, forms, data access set and security profiles and associated ledgers…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Responsibility, Access, fnd_form_functions_vl, fnd_form_vl, fnd_menu_entries_vl'
permalink: /FND%20Responsibility%20Access/
report_name: 'FND Responsibility Access'
report_web_name: fnd-responsibility-access
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Responsibility Access – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

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
Form Name: FNDSCAUS

Menu exclusions (fnd_resp_functions) are considered: functions excluded directly (rule_type F) or through an excluded menu (rule_type M) are filtered out.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Responsibility Name like, User Name like, Application, Access to Inventory Org, Access to Operating Unit, Access to Legal Entity, Access to Ledger, Concurrent Program Name like, Concurrent Progr. (all languages), Concurrent Program Short Name, Request Group, Menu Entry like, User Function Name like, Function Name, User Form Name like, Form Name, User Menu Name, Menu Name, Custom Application Responsibilities, Expand Multiple Operating Units

## Oracle EBS Tables Used
[fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_menu_entries_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_menus_tl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [xle_firstparty_information_v](https://www.enginatics.com/library/?pg=1&find=xle_firstparty_information_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [gl_access_sets_v](https://www.enginatics.com/library/?pg=1&find=gl_access_sets_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_request_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_request_group_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_request_sets_vl](https://www.enginatics.com/library/?pg=1&find=fnd_request_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_compiled_menu_functions](https://www.enginatics.com/library/?pg=1&find=fnd_compiled_menu_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_mo_product_init](https://www.enginatics.com/library/?pg=1&find=fnd_mo_product_init&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access), [fnd_resp_functions](https://www.enginatics.com/library/?pg=1&find=fnd_resp_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Access/FND%20Responsibility%20Access.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Responsibility Access 19-Jul-2023 184210.xlsx](https://www.enginatics.com/example/fnd-responsibility-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) |
| Blitz Report™ XML Import | [FND_Responsibility_Access.xml](https://www.enginatics.com/xml/fnd-responsibility-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) |
| SQL Source | [FND Responsibility Access.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Access/FND%20Responsibility%20Access.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-responsibility-access/](https://www.enginatics.com/reports/fnd-responsibility-access/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access) |

## Executive Summary
The **FND Responsibility Access** report is the "Swiss Army Knife" of security reporting. It answers the question: "Who can do what?" by linking Users -> Responsibilities -> Menus -> Functions -> Forms.

## Business Challenge
*   **SoD Analysis:** Identifying users who have access to conflicting functions (e.g., "Create Vendor" and "Pay Vendor").
*   **Access Review:** Finding all users who can access a specific sensitive form (e.g., "Bank Accounts").
*   **Deep Dive:** Tracing the full path from a User to a specific Function, including sub-menus.

## The Solution
This Blitz Report performs a deep traversal:
*   **User Access:** Lists users and their responsibilities.
*   **Menu Explosion:** Explodes the menu tree to find every function accessible to that responsibility.
*   **Context:** Shows the Operating Units and Ledgers accessible to that user/responsibility combination.

## Technical Architecture
The report joins `FND_USER`, `FND_RESPONSIBILITY`, `FND_MENUS`, and `FND_FORM_FUNCTIONS`. It uses recursive logic (or flattened tables) to traverse the menu hierarchy.

## Parameters & Filtering
*   **User Name:** Analyze a specific user.
*   **Function Name:** Find everyone who can access this function.
*   **Form Name:** Find everyone who can open this form.
*   **Access to Operating Unit:** Find everyone who can transact in a specific OU.

## Performance & Optimization
*   **Heavy Report:** Because it explodes the menu tree for every responsibility, this report can generate millions of rows if run without filters. **Always** filter by User, Responsibility, or Function.

## FAQ
*   **Q: Does it handle Menu Exclusions?**
    *   A: The description notes that it may not fully account for menu exclusions in all versions, so verify critical findings manually.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-access)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
