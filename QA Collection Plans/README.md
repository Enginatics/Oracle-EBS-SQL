---
layout: default
title: 'QA Collection Plans | Oracle EBS SQL Report'
description: 'One row per Oracle Quality collection plan, with the plan type, effective dates, instructions, specification assignment type, electronic signature mode…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plans, qa_plans, qa_plan_chars, qa_plan_char_value_lookups'
permalink: /QA%20Collection%20Plans/
---

# QA Collection Plans – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plans/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
One row per Oracle Quality collection plan, with the plan type, effective dates, instructions, specification assignment type, electronic signature mode and the template plan it was copied from, together with the names of the plan's generated results view and import view and counts of the elements, element values, transactions, transaction triggers, action rules, actions, child plans and parent plans that hang off it.

Oracle Quality stores every collection result generically in qa_results, and each plan gets its own dynamically generated results view and import view that map that plan's elements onto the qa_results character columns. This report shows both view names next to a flag stating whether the view actually exists in the database, which is the quickest way to find a plan whose generated view was never built or has since been dropped, because such a plan cannot be queried or imported through it. The counts turn the report into a one page map of a Quality setup: which plans carry elements but collect nothing, which plans fire actions on data entry, and which plans are nested into a parent child structure.

Active is derived from the effective dates and is Yes while the plan is in effect today, a plan with no effective dates always being active. Specification Type states which specification the plan matches its results against at collection time, taken from the item, the supplier or the customer, or none at all. Enabled Elements counts only the elements that are enabled on the plan, so a difference against Elements identifies a plan carrying elements the operator never sees.

Filter with the optional Organization, Collection Plan, Plan Type and Collection Element parameters, Collection Element restricting the report to the plans that use that element, or set Active Plans Only or Template Plans Only to Yes. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code; Template Plans Only returns exactly those seeded plans.

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Active Plans Only, Template Plans Only

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups), [qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers), [qa_plan_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_actions), [qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [user_views](https://www.enginatics.com/library/?pg=1&find=user_views), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plans 14-Aug-2026 195528.xlsx](https://www.enginatics.com/example/qa-collection-plans/) |
| Blitz Report™ XML Import | [QA_Collection_Plans.xml](https://www.enginatics.com/xml/qa-collection-plans/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plans/](https://www.enginatics.com/reports/qa-collection-plans/) |



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
