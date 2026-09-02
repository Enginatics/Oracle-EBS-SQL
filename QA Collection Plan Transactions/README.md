---
layout: default
title: 'QA Collection Plan Transactions | Oracle EBS SQL Report'
description: 'Every collection transaction an Oracle Quality collection plan is attached to, with the trigger conditions that decide whether collection actually fires…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plan, Transactions, qa_plan_transactions, qa_txn_collection_triggers, qa_plans'
permalink: /QA%20Collection%20Plan%20Transactions/
---

# QA Collection Plan Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Every collection transaction an Oracle Quality collection plan is attached to, with the trigger conditions that decide whether collection actually fires, the Mandatory Collection, Background Collection and Enabled flags, and each trigger's field, database field, datatype, operator and low and high values. Attachments that collect unconditionally are listed too, with a blank Collection Trigger.

Attaching a collection plan to a transaction is what makes Oracle Quality collect anything at all: until a plan is attached to a transaction such as Receiving Transactions or Completion Transactions it is only a definition, and nothing is ever collected against it. Trigger conditions narrow that further, so the attachment on its own does not tell you when collection happens - a plan attached to Completion Transactions with a trigger of Item equals a single assembly collects for that assembly and no other. Mandatory Collection means the transaction cannot be saved without quality results, and Background Collection means results are collected without prompting the operator.

A plan can be attached to the same transaction more than once, each attachment carrying its own trigger conditions. Transaction Attachments counts how many attachments the plan has for that transaction, so one attachment with several triggers can be told apart from several separate attachments. Trigger Field is the form prompt the trigger tests and Trigger Database Field is the column behind it, both taken from the transaction's own trigger list in qa_txn_collection_triggers, so a condition can be traced from the prompt an implementer sees to the column a data load has to supply.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Transaction and Collection Trigger. Mandatory Collection Only and Enabled Transactions Only restrict to attachments carrying those flags. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

## Report Parameters
Organization, Collection Plan, Plan Type, Transaction, Collection Trigger, Mandatory Collection Only, Enabled Transactions Only

## Oracle EBS Tables Used
[qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions), [qa_txn_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_txn_collection_triggers), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Transactions 14-Aug-2026 112113.xlsx](https://www.enginatics.com/example/qa-collection-plan-transactions/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Transactions.xml](https://www.enginatics.com/xml/qa-collection-plan-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-transactions/](https://www.enginatics.com/reports/qa-collection-plan-transactions/) |



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
