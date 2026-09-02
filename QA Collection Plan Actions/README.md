---
layout: default
title: 'QA Collection Plan Actions | Oracle EBS SQL Report'
description: 'Lists every action rule defined against an Oracle Quality collection plan - the trigger condition that fires the rule, the action it runs, the element it…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plan, Actions, qa_plan_char_action_outputs, qa_chars, qa_plans'
permalink: /QA%20Collection%20Plan%20Actions/
---

# QA Collection Plan Actions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-actions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists every action rule defined against an Oracle Quality collection plan - the trigger condition that fires the rule, the action it runs, the element it assigns, the alert it raises and the collection elements bound into its message - as a union of the rules attached to the collection plan itself and the rules defined on the collection element master, discriminated by an Action Level column. Trigger conditions that carry no action are listed too.

Oracle Quality evaluates these rules while quality results are entered. A rule is a trigger condition on one collection element - the element is entered, equals a value, falls outside its specification limits - paired with one or more actions. The rules are stored in two independent places. A collection plan carries its own rules in qa_plan_char_action_triggers and qa_plan_char_actions, and a collection element carries master rules in qa_char_action_triggers and qa_char_actions. The two are not linked: an element master rule is never copied into a plan, it simply applies to every plan that uses the element. The Action Level column says which is which. Plan means the rule is defined on this collection plan. Element means the rule is defined on the collection element master and therefore applies to every plan carrying that element, this one included.

Online Action separates the actions the results entry engine evaluates inline, as values are entered, from the actions it defers to background processing. The inline ones - display a message to the operator, reject the input, assign a value to a collection element - are the class of action that can change or refuse the data a results load submits. The deferred ones - alerts, workflow, holds - do not alter the collected values inline.

Assign Type and Assigned Element are populated only where the action assigns a value to another collection element; the formula or SQL statement itself is in Action Message. Output Variable and Output Element are a matched pair listing the tokens bound into that message and the collection element each token reads, so a formula referencing several elements can be resolved from the row. A trigger bound may be a literal or a statistical limit, and both are rendered. Status Code is the status string the action assigns to the quality result; Oracle Quality stores it as free text with no lookup behind it, so it is shown exactly as it was configured and is not translated.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Collection Element and Action. Online Actions Only restricts to the actions evaluated inline during results entry, Enabled Elements Only to elements still enabled on the plan, and Action Level isolates plan level or element level rules. Element level rules are shown against the collection plans that use the element, so a rule on an element that no collection plan uses is not listed. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Action, Online Actions Only, Enabled Elements Only, Action Level

## Oracle EBS Tables Used
[qa_plan_char_action_outputs](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_outputs), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_plan_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_actions), [qa_actions](https://www.enginatics.com/library/?pg=1&find=qa_actions), [alr_action_sets](https://www.enginatics.com/library/?pg=1&find=alr_action_sets), [alr_actions](https://www.enginatics.com/library/?pg=1&find=alr_actions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [qa_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_char_action_triggers), [qa_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_char_actions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Actions 14-Aug-2026 111941.xlsx](https://www.enginatics.com/example/qa-collection-plan-actions/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Actions.xml](https://www.enginatics.com/xml/qa-collection-plan-actions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-actions/](https://www.enginatics.com/reports/qa-collection-plan-actions/) |



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
