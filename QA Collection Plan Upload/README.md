---
layout: default
last_modified_at: 2026-10-19
title: 'QA Collection Plan Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, or delete Quality Collection Plans and all child entities. This upload manages: - Collection Plan headers (name, type, dates…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Collection, Plan, qa_plans, mtl_parameters, qa_plan_transactions'
permalink: /QA%20Collection%20Plan%20Upload/
report_name: 'QA Collection Plan Upload'
report_web_name: qa-collection-plan-upload
---

# QA Collection Plan Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload).

## Overview
Upload to create, update, or delete Quality Collection Plans and all child entities.

This upload manages:
- Collection Plan headers (name, type, dates, multirow flag)
- Plan Transactions (transaction assignments, mandatory/background flags)
- Collection Triggers (trigger conditions per transaction)
- Plan Elements (collection element assignments, prompts, flags)
- Element Values (value lookups per element)
- Action Triggers (trigger sequences and conditions per element)
- Actions (action assignments per trigger, including assign type, assigned element, alert action set and action, status code)
- Action Outputs (output variable mappings per action)

Multiple actions of the same action type can coexist under one action trigger (e.g. two Assign value actions with different formulas, or two Send email actions with different alert sets). Actions are identified by the natural key (action trigger, action name, assign type, assigned element, alert action set, alert action, status code, action message); changing any of these fields creates a new action rather than updating an existing one. Use Delete=Yes to remove an obsolete action.

CAR (Corrective Action Request) actions are not yet supported.

Upload Modes
============

Create
------
Opens an empty spreadsheet for entering new Collection Plans and child entities.

Create, Update
--------------
Downloads existing Collection Plans matching filters for review and update.
New rows can be added to create additional plans in the same upload.

Row Types
=========
The upload uses a hierarchical structure with 8 row types:
1. Plan Header
2. Transaction
3. Collection Trigger
4. Element
5. Element Value
6. Action Trigger
7. Action
8. Action Output

Each child row inherits its parent context from the plan_name column.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, Plan Type, Collection Plan, Collection Plan From, Collection Plan To

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_transactions_v](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_txn_collection_triggers_v](https://www.enginatics.com/library/?pg=1&find=qa_txn_collection_triggers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_char_actions](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_actions](https://www.enginatics.com/library/?pg=1&find=qa_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [alr_action_sets](https://www.enginatics.com/library/?pg=1&find=alr_action_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [alr_actions](https://www.enginatics.com/library/?pg=1&find=alr_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [qa_plan_char_action_outputs](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_outputs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Upload/QA%20Collection%20Plan%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/qa-collection-plan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Upload.xml](https://www.enginatics.com/xml/qa-collection-plan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) |
| SQL Source | [QA Collection Plan Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Upload/QA%20Collection%20Plan%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-upload/](https://www.enginatics.com/reports/qa-collection-plan-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload) |

## Case Study & Technical Analysis: QA Collection Plan Upload

### Executive Summary
QA Collection Plan Upload creates, updates and deletes Oracle Quality collection plans and their child entities in one spreadsheet. A collection plan defines what is inspected and recorded: the transactions that trigger collection, the elements to be captured, their allowed values, and the actions that run when a result meets a condition. Quality engineers, inspection planners and implementation consultants use it to build plan sets for receiving, in-process and final inspection, or to replicate a validated plan across organizations without re-entering each element by hand.

### Business Challenge
*   **Plan Complexity:** A single collection plan has several linked layers, including transactions, triggers, elements, values, action triggers and actions, and building them through the forms takes many steps.
*   **Consistency Across Organizations:** Inspection plans must be the same wherever a product is made, and manual copying introduces differences.
*   **Automated Responses:** Alerts and corrective steps driven by quality results must reference the correct alert sets and actions.
*   **Change Control:** Modifying a plan should be a visible, reviewable change rather than a series of form edits.

### The Solution
*   **Eight Row Types:** The template holds plan header, transaction, collection trigger, element, element value, action trigger, action and action output rows, each inheriting its parent context from the plan name.
*   **Natural Key Matching:** Actions are identified by their trigger, name, assignment type, assigned element, alert set, alert and status, so a change to any of these creates a new action.
*   **Multiple Actions:** Several actions of the same type can coexist under one trigger, for example two alert actions with different alert sets.
*   **Delete Control:** A delete column removes an obsolete action when set to Yes.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLANS`: the collection plan headers, with name, description, plan type, effective dates and the multirow flag.
*   `QA_PLAN_TRANSACTIONS` and `QA_PLAN_TRANSACTIONS_V`: the transactions assigned to a plan, with their mandatory, background and enabled flags.
*   `QA_PLAN_COLLECTION_TRIGGERS` and `QA_TXN_COLLECTION_TRIGGERS_V`: the collection triggers of each plan transaction.
*   `QA_PLAN_CHARS` and `QA_CHARS`: the plan elements and their element definitions, with prompts, flags and default values.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the allowed values of each element.
*   `QA_PLAN_CHAR_ACTION_TRIGGERS`: the action triggers, with their sequence, operator and low and high values.
*   `QA_PLAN_CHAR_ACTIONS` and `QA_ACTIONS`: the actions assigned to each action trigger, and the action definitions.
*   `QA_PLAN_CHAR_ACTION_OUTPUTS`: the output variable mappings of each action.
*   `ALR_ACTION_SETS` and `ALR_ACTIONS`: the alert action sets and alert actions.
*   `MTL_PARAMETERS`: the organization of each plan.

#### Logical Relationships
1.  Each plan in `QA_PLANS` is joined to its organization in `MTL_PARAMETERS`.
2.  Plan transactions in `QA_PLAN_TRANSACTIONS` are joined to the plan, and their view `QA_PLAN_TRANSACTIONS_V` supplies the transaction description.
3.  Collection triggers are joined from each plan transaction through `QA_PLAN_COLLECTION_TRIGGERS` to `QA_TXN_COLLECTION_TRIGGERS_V`.
4.  Plan elements in `QA_PLAN_CHARS` are joined to `QA_CHARS`, and their allowed values to `QA_PLAN_CHAR_VALUE_LOOKUPS`.
5.  Action triggers in `QA_PLAN_CHAR_ACTION_TRIGGERS` are joined to each element, and actions in `QA_PLAN_CHAR_ACTIONS` to each action trigger.
6.  Action definitions, assigned elements and alert sets are outer joined from the action row, and output mappings are joined from the action to `QA_PLAN_CHAR_ACTION_OUTPUTS`.
7.  The eight row types are combined with UNION ALL, and each carries a row type number.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing plans are downloaded.
*   **Organization:** Restricts the plans to one organization.
*   **Plan Type:** Restricts the plans to one plan type.
*   **Collection Plan:** Selects one plan by name.
*   **Collection Plan From and Collection Plan To:** Limit the plans to a range of names.

### Performance & Optimization
*   **Plan Driven Extract:** Every row type joins from the plan and its organization, so the extract is bounded by the plans selected.
*   **Row Type Layering:** Each child row type adds one level of detail to the plan, so the joins are limited to the rows that exist at that level.
*   **Outer Joins for Optional Data:** Assigned elements, alert sets and alerts are outer joined, so actions that do not use them are still returned.
*   **Output Level Last:** Action outputs are read only for actions that have output mappings, which keeps the lowest level of the hierarchy to the needed rows.

### FAQ
**Q: Can I add a second action of the same type under one action trigger?**
A: Yes. Each action is identified by its natural key, so a different formula or alert set creates a separate action.

**Q: How do I remove an action from a plan?**
A: Download the plan with Create and Update, find the action row, and set Delete to Yes.

**Q: Are corrective action requests supported?**
A: No. The description states that CAR actions are not yet supported by this upload.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
