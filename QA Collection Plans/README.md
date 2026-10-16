---
layout: default
last_modified_at: 2026-10-16
title: 'QA Collection Plans | Oracle EBS SQL Report'
description: 'One row per Oracle Quality collection plan, with the plan type, effective dates, instructions, specification assignment type, electronic signature mode…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plans, qa_plans, qa_plan_chars, qa_plan_char_value_lookups'
permalink: /QA%20Collection%20Plans/
report_name: 'QA Collection Plans'
report_web_name: qa-collection-plans
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plans – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plans/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
One row per Oracle Quality collection plan, with the plan type, effective dates, instructions, specification assignment type, electronic signature mode and the template plan it was copied from, together with the names of the plan's generated results view and import view and counts of the elements, element values, transactions, transaction triggers, action rules, actions, child plans and parent plans that hang off it.

Oracle Quality stores every collection result generically in qa_results, and each plan gets its own dynamically generated results view and import view that map that plan's elements onto the qa_results character columns. This report shows both view names next to a flag stating whether the view actually exists in the database, which is the quickest way to find a plan whose generated view was never built or has since been dropped, because such a plan cannot be queried or imported through it. The counts turn the report into a one page map of a Quality setup: which plans carry elements but collect nothing, which plans fire actions on data entry, and which plans are nested into a parent child structure.

Active is derived from the effective dates and is Yes while the plan is in effect today, a plan with no effective dates always being active. Specification Type states which specification the plan matches its results against at collection time, taken from the item, the supplier or the customer, or none at all. Enabled Elements counts only the elements that are enabled on the plan, so a difference against Elements identifies a plan carrying elements the operator never sees.

Filter with the optional Organization, Collection Plan, Plan Type and Collection Element parameters, Collection Element restricting the report to the plans that use that element, or set Active Plans Only or Template Plans Only to Yes. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code; Template Plans Only returns exactly those seeded plans.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Active Plans Only, Template Plans Only

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_plan_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [user_views](https://www.enginatics.com/library/?pg=1&find=user_views&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)

## Related Reports
[QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plans/QA%20Collection%20Plans.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plans 14-Aug-2026 195528.xlsx](https://www.enginatics.com/example/qa-collection-plans/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) |
| Blitz Report™ XML Import | [QA_Collection_Plans.xml](https://www.enginatics.com/xml/qa-collection-plans/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) |
| SQL Source | [QA Collection Plans.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plans/QA%20Collection%20Plans.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plans/](https://www.enginatics.com/reports/qa-collection-plans/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans) |

## Case Study & Technical Analysis: QA Collection Plans

### Executive Summary
The QA Collection Plans report lists one row per Oracle Quality collection plan, with its type, effective dates, instructions, specification type, electronic signature mode and template plan. Each row also names the plan's generated results view and import view, shows whether those views exist in the database, and counts the elements, element values, transactions, triggers, action rules, actions, and parent and child plans attached to it. Quality engineers and Quality administrators use it as a one-page map of a Quality setup. It is the quickest way to find a plan whose generated view was never built or was dropped, because such a plan cannot be queried or imported through that view. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Broken collection plans:** A plan whose generated results or import view is missing cannot be queried or imported, and its failure is not visible in the plan list.
*   **Unused elements:** Plans that carry elements which are not enabled, or elements that collect nothing, make the setup hard to maintain.
*   **Action firing on entry:** Plans with action rules fire actions on data entry, and administrators must know which plans do this.
*   **Nested plans:** Parent and child plan structures must be understood before a change to one plan affects another.

### The Solution
*   **View existence check:** The results view and import view names are shown with a Yes or No flag for whether the view exists.
*   **Setup counts:** Element, enabled element, element value, transaction, transaction trigger, action rule, action, child plan and parent plan counts are returned for each plan.
*   **Effective status:** Active is Yes when the current date falls within the plan's effective dates, and a plan with no effective dates is always active.
*   **Specification type:** The specification the plan matches against at collection time is named as item, supplier, customer, or none.
*   **Template plans:** The seeded template plans are included, and they show a blank organization code because they are not owned by an inventory organization.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLANS`: the collection plan header, with name, description, type, effective dates, specification type, signature mode, and the results and import view names.
*   `QA_PLAN_CHARS`: the plan elements, with an enabled flag for each.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the element values for lookup-based elements.
*   `QA_PLAN_TRANSACTIONS`: the transactions defined for the plan.
*   `QA_PLAN_COLLECTION_TRIGGERS`: the collection triggers attached to plan transactions.
*   `QA_PLAN_CHAR_ACTION_TRIGGERS`: the action rules on elements.
*   `QA_PLAN_CHAR_ACTIONS`: the actions that each action rule runs.
*   `QA_PC_PLAN_RELATIONSHIP`: the parent and child plan links.
*   `USER_VIEWS`: the database views, used to test whether the generated views exist.
*   `MTL_PARAMETERS`: the inventory organization code.
*   `ORG_ACCESS_VIEW`: the organizations accessible to the current responsibility.

#### Logical Relationships
1. `QA_PLANS` is outer joined to `MTL_PARAMETERS` on organization identifier.
2. The results view and import view names of `QA_PLANS` are outer joined to `USER_VIEWS`, so a missing view returns a blank match.
3. Each count is a correlated subquery on the plan identifier, with the chain of transactions, triggers, action rules and actions joined inside the subquery.
4. The template plan name is a scalar lookup on the template plan identifier.
5. Parent and child counts are subqueries on `QA_PC_PLAN_RELATIONSHIP` in each direction.

### Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organization. When blank, all plans the responsibility can access are returned, together with the template plans.
*   **Collection Plan:** Restricts the output to one plan name.
*   **Plan Type:** Restricts the output to one plan type.
*   **Collection Element:** Restricts the output to plans that use the element.
*   **Active Plans Only:** When Yes, only plans in effect today are returned.
*   **Template Plans Only:** When Yes, only the seeded template plans are returned.

### Performance & Optimization
*   Organization access is applied as an `OR` with the template organization identifier zero, so template plans are always reachable without a separate query.
*   The view existence checks are outer joins to `USER_VIEWS` on the view name, so they add one lookup per plan.
*   Element, transaction, trigger, action and relationship counts are correlated subqueries, so their cost grows with the number of plans returned.
*   The query has no analytic functions. The result is ordered by organization code and plan name.

### FAQ
**Q: How do I find a collection plan whose results view was never built?**
A: Look for plans where the Results View Exists column shows No; such a plan cannot be queried through its results view.

**Q: What does Enabled Elements show compared with Elements?**
A: Elements counts all elements on the plan, and Enabled Elements counts only the elements enabled on the plan, so a difference shows elements the operator never sees.

**Q: Which plans are template plans?**
A: The template plans are the seeded plans, which have a blank Organization Code. Setting Template Plans Only to Yes returns exactly those plans.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plans)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
