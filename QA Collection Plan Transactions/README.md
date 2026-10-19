---
layout: default
last_modified_at: 2026-10-19
title: 'QA Collection Plan Transactions | Oracle EBS SQL Report'
description: 'Every collection transaction an Oracle Quality collection plan is attached to, with the trigger conditions that decide whether collection actually fires…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plan, Transactions, qa_plan_transactions, qa_txn_collection_triggers, qa_plans'
permalink: /QA%20Collection%20Plan%20Transactions/
report_name: 'QA Collection Plan Transactions'
report_web_name: qa-collection-plan-transactions
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plan Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
Every collection transaction an Oracle Quality collection plan is attached to, with the trigger conditions that decide whether collection actually fires, the Mandatory Collection, Background Collection and Enabled flags, and each trigger's field, database field, datatype, operator and low and high values. Attachments that collect unconditionally are listed too, with a blank Collection Trigger.

Attaching a collection plan to a transaction is what makes Oracle Quality collect anything at all: until a plan is attached to a transaction such as Receiving Transactions or Completion Transactions it is only a definition, and nothing is ever collected against it. Trigger conditions narrow that further, so the attachment on its own does not tell you when collection happens - a plan attached to Completion Transactions with a trigger of Item equals a single assembly collects for that assembly and no other. Mandatory Collection means the transaction cannot be saved without quality results, and Background Collection means results are collected without prompting the operator.

A plan can be attached to the same transaction more than once, each attachment carrying its own trigger conditions. Transaction Attachments counts how many attachments the plan has for that transaction, so one attachment with several triggers can be told apart from several separate attachments. Trigger Field is the form prompt the trigger tests and Trigger Database Field is the column behind it, both taken from the transaction's own trigger list in qa_txn_collection_triggers, so a condition can be traced from the prompt an implementer sees to the column a data load has to supply.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Transaction and Collection Trigger. Mandatory Collection Only and Enabled Transactions Only restrict to attachments carrying those flags. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Plan Type, Transaction, Collection Trigger, Mandatory Collection Only, Enabled Transactions Only

## Oracle EBS Tables Used
[qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [qa_txn_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_txn_collection_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [INV Organization Parameters](/INV%20Organization%20Parameters/ "INV Organization Parameters Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Transactions/QA%20Collection%20Plan%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Transactions 14-Aug-2026 112113.xlsx](https://www.enginatics.com/example/qa-collection-plan-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Transactions.xml](https://www.enginatics.com/xml/qa-collection-plan-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) |
| SQL Source | [QA Collection Plan Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Transactions/QA%20Collection%20Plan%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-transactions/](https://www.enginatics.com/reports/qa-collection-plan-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions) |

## Case Study & Technical Analysis: QA Collection Plan Transactions

### Executive Summary
The QA Collection Plan Transactions report shows every transaction that an Oracle Quality collection plan is attached to, together with the trigger conditions that decide whether collection fires. It is written for quality engineers and Oracle Quality administrators who need to know when a collection plan actually collects results, for example on receiving or completion transactions. A plan attached to a transaction is only a definition until the attachment exists, and each trigger narrows the collection further, so the report shows both layers. For each attachment it returns the mandatory, background and enabled flags, and for each trigger the field, database column, datatype, operator and values. It sits in the Quality module.

### Business Challenge
*   **Knowing when collection happens:** A collection plan can be defined correctly and still never collect, because it has not been attached to a transaction or because its triggers do not match the transactions being processed.
*   **Mandatory collection risk:** A mandatory collection blocks saving the transaction without quality results, so administrators must know which transactions carry this requirement.
*   **Background collection:** Results collected without prompting the operator change the operator's workload and the completeness of the data.
*   **Tracing triggers to data:** A trigger shown to an implementer as a form prompt must be linked to the database column that a data load has to supply.

### The Solution
*   **Attachments by transaction:** Each row shows a plan attached to a transaction, with its mandatory, background and enabled flags.
*   **Attachment count:** The number of attachments of a plan to a transaction is shown, so several attachments with different triggers are distinguished from one.
*   **Trigger detail:** Each trigger shows its collection element, the form prompt and the database field from the transaction's trigger list, its datatype, operator and low and high values.
*   **Unconditional attachments:** Attachments with no trigger are listed with a blank trigger, so unconditional collection is visible.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLAN_TRANSACTIONS`: the attachment of a plan to a transaction, with mandatory, background and enabled flags.
*   `QA_TXN_COLLECTION_TRIGGERS`: the list of triggers available for each transaction, with the form description and database field.
*   `QA_PLANS`: the collection plans.
*   `MTL_PARAMETERS`: the inventory organisation of each plan.
*   `QA_PLAN_COLLECTION_TRIGGERS`: the trigger conditions attached to each plan attachment, with operator and values.
*   `QA_CHARS`: the collection element that each trigger tests.
*   `ORG_ACCESS_VIEW`: the organisations accessible to the current responsibility.

#### Logical Relationships
1. `QA_PLANS` joins to `MTL_PARAMETERS` as an outer join on the organisation identifier.
2. `QA_PLANS` joins to `QA_PLAN_TRANSACTIONS` on the plan identifier.
3. Each attachment joins to `QA_PLAN_COLLECTION_TRIGGERS` as an outer join on the plan transaction identifier, so unconditional attachments are kept.
4. Each trigger joins to `QA_CHARS` as an outer join on the trigger identifier, to give the element name and datatype.
5. The trigger's form description and database field are read from `QA_TXN_COLLECTION_TRIGGERS` by transaction number and trigger identifier, through scalar subqueries.
6. Results are ordered by organisation, plan name, transaction name, attachment identifier and element name.

### Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organisation.
*   **Collection Plan and Plan Type:** Restrict the output to one plan or plan type.
*   **Transaction:** Restricts the attachments to one transaction, such as receiving or completion transactions.
*   **Collection Trigger:** Restricts the output to attachments that test one trigger element.
*   **Mandatory Collection Only:** When set, restricts the output to attachments with the mandatory flag.
*   **Enabled Transactions Only:** When set, restricts the output to enabled attachments.

### Performance & Optimization
*   **Organisation access filter:** Plans are limited to the access view for the current responsibility and to organisation zero, which holds the template plans.
*   **Outer joins to keep unconditional attachments:** Trigger conditions are joined with outer joins, so an attachment without triggers returns one row with blank trigger columns.
*   **Scalar subqueries for trigger text:** Form description and database field are read from the transaction trigger list in correlated subqueries, which resolve one row per trigger.

### FAQ
**Q: Why does my collection plan not collect results for a transaction?**
A: The plan must be attached to the transaction, and its trigger conditions must match the transaction. The report shows both the attachment and the trigger conditions.

**Q: What does Mandatory Collection mean for an operator?**
A: The description states that the transaction cannot be saved without quality results when Mandatory Collection is set.

**Q: How do I trace a trigger condition to the column a data load must supply?**
A: Read the Trigger Field, which is the form prompt, and the Trigger Database Field, which is the column behind it, on the same row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
