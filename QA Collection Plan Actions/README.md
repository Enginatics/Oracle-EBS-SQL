---
layout: default
last_modified_at: 2026-10-19
title: 'QA Collection Plan Actions | Oracle EBS SQL Report'
description: 'Lists every action rule defined against an Oracle Quality collection plan - the trigger condition that fires the rule, the action it runs, the element it…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plan, Actions, qa_plan_char_action_outputs, qa_chars, qa_plans'
permalink: /QA%20Collection%20Plan%20Actions/
report_name: 'QA Collection Plan Actions'
report_web_name: qa-collection-plan-actions
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plan Actions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-actions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
Lists every action rule defined against an Oracle Quality collection plan - the trigger condition that fires the rule, the action it runs, the element it assigns, the alert it raises and the collection elements bound into its message - as a union of the rules attached to the collection plan itself and the rules defined on the collection element master, discriminated by an Action Level column. Trigger conditions that carry no action are listed too.

Oracle Quality evaluates these rules while quality results are entered. A rule is a trigger condition on one collection element - the element is entered, equals a value, falls outside its specification limits - paired with one or more actions. The rules are stored in two independent places. A collection plan carries its own rules in qa_plan_char_action_triggers and qa_plan_char_actions, and a collection element carries master rules in qa_char_action_triggers and qa_char_actions. The two are not linked: an element master rule is never copied into a plan, it simply applies to every plan that uses the element. The Action Level column says which is which. Plan means the rule is defined on this collection plan. Element means the rule is defined on the collection element master and therefore applies to every plan carrying that element, this one included.

Online Action separates the actions the results entry engine evaluates inline, as values are entered, from the actions it defers to background processing. The inline ones - display a message to the operator, reject the input, assign a value to a collection element - are the class of action that can change or refuse the data a results load submits. The deferred ones - alerts, workflow, holds - do not alter the collected values inline.

Assign Type and Assigned Element are populated only where the action assigns a value to another collection element; the formula or SQL statement itself is in Action Message. Output Variable and Output Element are a matched pair listing the tokens bound into that message and the collection element each token reads, so a formula referencing several elements can be resolved from the row. A trigger bound may be a literal or a statistical limit, and both are rendered. Status Code is the status string the action assigns to the quality result; Oracle Quality stores it as free text with no lookup behind it, so it is shown exactly as it was configured and is not translated.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Collection Element and Action. Online Actions Only restricts to the actions evaluated inline during results entry, Enabled Elements Only to elements still enabled on the plan, and Action Level isolates plan level or element level rules. Element level rules are shown against the collection plans that use the element, so a rule on an element that no collection plan uses is not listed. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Action, Online Actions Only, Enabled Elements Only, Action Level

## Oracle EBS Tables Used
[qa_plan_char_action_outputs](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_outputs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_plan_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_actions](https://www.enginatics.com/library/?pg=1&find=qa_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [alr_action_sets](https://www.enginatics.com/library/?pg=1&find=alr_action_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [alr_actions](https://www.enginatics.com/library/?pg=1&find=alr_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_char_action_outputs](https://www.enginatics.com/library/?pg=1&find=qa_char_action_outputs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_char_action_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions), [qa_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_char_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)

## Related Reports
[QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Actions/QA%20Collection%20Plan%20Actions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Actions 14-Aug-2026 111941.xlsx](https://www.enginatics.com/example/qa-collection-plan-actions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Actions.xml](https://www.enginatics.com/xml/qa-collection-plan-actions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) |
| SQL Source | [QA Collection Plan Actions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Actions/QA%20Collection%20Plan%20Actions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-actions/](https://www.enginatics.com/reports/qa-collection-plan-actions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions) |

## Case Study & Technical Analysis: QA Collection Plan Actions

### Executive Summary
This report lists every action rule defined for an Oracle Quality collection plan. A rule is a trigger condition on one collection element, such as the element being entered, equalling a value, or falling outside its specification limits, paired with one or more actions. The report shows the rules attached to the collection plan itself and the rules defined on the collection element master, distinguished by an Action Level column. Quality engineers, quality managers and EBS functional consultants use it to review how results entry behaves for a plan, to find the inline actions that can reject or change data during a results load, and to confirm which alerts, workflows and holds will fire after results are collected.

### Business Challenge
*   **Hidden rules:** Action rules are stored in two places, on the plan and on the element master, and a reviewer who looks at only one of them misses part of the behaviour.
*   **Inline actions change data:** Some actions run while results are entered and can refuse input or assign values, and these must be known before a results load.
*   **Deferred actions notify people:** Alerts, workflows and holds run in background processing, and their owners need to know which plans can trigger them.

### The Solution
*   Lists each trigger and action for a plan, labelled Plan or Element, with the trigger sequence, operator and trigger low and high values.
*   Shows the action name, whether it is an online action evaluated during results entry, and the status code it assigns to the result.
*   Shows the assigned element and assign type, where the action assigns a value to another element, and the alert action set and alert action.
*   Shows whether the element and the action are enabled, and who created and last updated each rule.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLANS`: the collection plan, with its name, description, type and organization.
*   `MTL_PARAMETERS`: the inventory organization of the plan.
*   `QA_CHARS`: the collection elements.
*   `QA_PLAN_CHARS`: the elements as used on a plan, with prompt and enabled flag.
*   `QA_PLAN_CHAR_ACTION_TRIGGERS` and `QA_PLAN_CHAR_ACTIONS`: the plan-level trigger conditions and their actions.
*   `QA_PLAN_CHAR_ACTION_OUTPUTS`: the tokens bound into a plan-level action message.
*   `QA_CHAR_ACTION_TRIGGERS` and `QA_CHAR_ACTIONS`: the element-level trigger conditions and their actions.
*   `QA_CHAR_ACTION_OUTPUTS`: the tokens bound into an element-level action message.
*   `QA_ACTIONS`: the action definition, with its online flag and enabled flag.
*   `ALR_ACTION_SETS` and `ALR_ACTIONS`: the alert action set and alert action.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. The plan-level branch joins `QA_PLANS` to the plan trigger rows, to the element, to the plan element record, and to the action and alert.
2. The element-level branch joins the plan element record to the element's trigger rows, and to the element-level actions, which are shown against every plan that uses the element.
3. Each action's output tokens are listed with `LISTAGG` and the elements they read are resolved from `QA_CHARS`.
4. The assigned element is joined as a second instance of `QA_CHARS`, used only when the action assigns a value.
5. The two branches are combined with UNION ALL and filtered by the organization access list, with the seeded template plans included.

### Parameters & Filtering
*   **Organization** and **Collection Plan:** limit the rules to an organization and a plan.
*   **Plan Type:** selects the type of collection plan.
*   **Collection Element** and **Action:** select a collection element or an action.
*   **Online Actions Only:** restricts the output to the actions evaluated inline during results entry.
*   **Enabled Elements Only:** restricts the output to elements that are still enabled on the plan.
*   **Action Level:** shows plan-level rules, element-level rules, or both.

### Performance & Optimization
*   The organization access list is applied to the plan's organization, so rules of plans outside the user's access are not read.
*   The output tokens are aggregated with LISTAGG in correlated subqueries that run per action, which keeps one row for each trigger and action.
*   Element-level rules are reached only through the plans that carry the element, so an element used by no plan produces no rows.

### FAQ
**Q: Why does an element-level rule appear against several plans?**
A: Element master rules apply to every collection plan that uses the element, so each plan that carries the element shows the rule.

**Q: Which actions can change data during results entry?**
A: Filter with Online Actions Only set to Yes. These are the inline actions, such as displaying a message, rejecting the input or assigning a value to another element.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-actions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
