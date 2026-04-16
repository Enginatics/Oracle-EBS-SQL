---
layout: default
title: 'QA Collection Plan Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, or delete Quality Collection Plans and all child entities. This upload manages: - Collection Plan headers (name, type, dates…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Collection, Plan, qa_plans, mtl_parameters, qa_plan_transactions'
permalink: /QA%20Collection%20Plan%20Upload/
---

# QA Collection Plan Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create, update, or delete Quality Collection Plans and all child entities.

This upload manages:
- Collection Plan headers (name, type, dates, multirow flag)
- Plan Transactions (transaction assignments, mandatory/background flags)
- Collection Triggers (trigger conditions per transaction)
- Plan Elements (collection element assignments, prompts, flags)
- Element Values (value lookups per element)
- Action Triggers (trigger sequences and conditions per element)
- Actions (action assignments per trigger)
- Action Outputs (output variable mappings per action)

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

## Report Parameters
Upload Mode, Organization, Plan Type, Collection Plan From, Collection Plan To

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plan_transactions](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions), [qa_plan_transactions_v](https://www.enginatics.com/library/?pg=1&find=qa_plan_transactions_v), [qa_plan_collection_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_collection_triggers), [qa_txn_collection_triggers_v](https://www.enginatics.com/library/?pg=1&find=qa_txn_collection_triggers_v), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups), [qa_plan_char_action_triggers](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_action_triggers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/qa-collection-plan-upload/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Upload.xml](https://www.enginatics.com/xml/qa-collection-plan-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-upload/](https://www.enginatics.com/reports/qa-collection-plan-upload/) |



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
