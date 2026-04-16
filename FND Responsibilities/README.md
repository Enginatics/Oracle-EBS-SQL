---
layout: default
title: 'FND Responsibilities | Oracle EBS SQL Report'
description: 'Active responsibilites with active user count and related setup information such as menus, data access sets, security profiles and associated ledgers and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FND, Responsibilities, gl_access_set_norm_assign, gl_ledger_set_norm_assign_v, gl_ledgers'
permalink: /FND%20Responsibilities/
---

# FND Responsibilities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibilities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Active responsibilites with active user count and related setup information such as menus, data access sets, security profiles and associated ledgers and operating units.

## Report Parameters
Responsibility Name like, User Name, Application, Access to Inventory Org, Access to Operating Unit, Access to Ledger, Access to Function, No Access to Function, Request Group, User Menu Name, Menu Name, Custom Application Responsibilities, Expand Multiple Operating Units, Show Active only, Having Active Users only

## Oracle EBS Tables Used
[gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [per_security_profiles](https://www.enginatics.com/library/?pg=1&find=per_security_profiles), [per_organization_list](https://www.enginatics.com/library/?pg=1&find=per_organization_list), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_access_sets_v](https://www.enginatics.com/library/?pg=1&find=gl_access_sets_v), [fnd_data_groups](https://www.enginatics.com/library/?pg=1&find=fnd_data_groups), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_mo_product_init](https://www.enginatics.com/library/?pg=1&find=fnd_mo_product_init), [prof](https://www.enginatics.com/library/?pg=1&find=prof), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl](https://www.enginatics.com/library/?pg=1&find=gl), [z](https://www.enginatics.com/library/?pg=1&find=z)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC AP Accrual Reconciliation Load Request](/CAC%20AP%20Accrual%20Reconciliation%20Load%20Request/ "CAC AP Accrual Reconciliation Load Request Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Responsibilities 04-Aug-2024 171326.xlsx](https://www.enginatics.com/example/fnd-responsibilities/) |
| Blitz Report™ XML Import | [FND_Responsibilities.xml](https://www.enginatics.com/xml/fnd-responsibilities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-responsibilities/](https://www.enginatics.com/reports/fnd-responsibilities/) |

## Executive Summary
The **FND Responsibilities** report provides a high-level overview of Responsibility definitions. It focuses on the setup of the responsibility itself, including its menu, request group, and data access controls.

## Business Challenge
*   **License Audit:** Counting the number of active users assigned to each responsibility.
*   **Configuration Review:** Checking which Menu and Request Group are linked to a responsibility.
*   **MOAC Analysis:** Verifying the "Multi-Org" setup (Security Profile) for each responsibility.

## The Solution
This Blitz Report aggregates responsibility data:
*   **Definition:** Responsibility Name, Key, and Application.
*   **Components:** Assigned Menu, Request Group, and Data Group.
*   **Access Control:** MO: Security Profile, GL Data Access Set.
*   **Usage:** Count of active users assigned.

## Technical Architecture
The report queries `FND_RESPONSIBILITY_VL` and joins to profile option values to determine the MOAC and GL security settings.

## Parameters & Filtering
*   **Responsibility Name:** Filter by name.
*   **Show Active only:** Hide end-dated responsibilities.
*   **Having Active Users only:** Filter to show only responsibilities that are actually being used.

## Performance & Optimization
*   **Complex Joins:** The report logic to determine the "Effective" Operating Unit or Ledger involves checking multiple profile levels, which makes the SQL complex but robust.

## FAQ
*   **Q: Does this show which users have the responsibility?**
    *   A: It shows the *count* of users. Use "FND Responsibility Access" or "FND User Responsibilities" to see the list of names.


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
