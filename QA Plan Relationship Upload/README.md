---
layout: default
last_modified_at: 2026-10-19
title: 'QA Plan Relationship Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, or delete Quality Collection Plan parent-child relationships using the standard Oracle API qassparentchildpkg. This upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Plan, Relationship, qa_pc_element_relationship, mtl_parameters, qa_plans'
permalink: /QA%20Plan%20Relationship%20Upload/
report_name: 'QA Plan Relationship Upload'
report_web_name: qa-plan-relationship-upload
---

# QA Plan Relationship Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-plan-relationship-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload).

## Overview
Upload to create, update, or delete Quality Collection Plan parent-child relationships using the standard Oracle API qa_ss_parent_child_pkg.

This upload manages:
- Parent-Child Plan Relationships (QA_PC_PLAN_RELATIONSHIP)
- Element Relationships between parent and child plans (QA_PC_ELEMENT_RELATIONSHIP)
- Criteria for automatic child record creation (QA_PC_CRITERIA)

Entry Modes:
- Immediate: Child data entered immediately after parent record
- Delayed: Child records entered manually later
- Automatic: Child records auto-created when parent matches criteria
- History: Child records auto-created when changes made to parent

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, Parent Plan, Child Plan

## Oracle EBS Tables Used
[qa_pc_element_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_element_relationship&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [qa_pc_criteria](https://www.enginatics.com/library/?pg=1&find=qa_pc_criteria&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)

## Related Reports
[QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Plan%20Relationship%20Upload/QA%20Plan%20Relationship%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/qa-plan-relationship-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) |
| Blitz Report™ XML Import | [QA_Plan_Relationship_Upload.xml](https://www.enginatics.com/xml/qa-plan-relationship-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) |
| SQL Source | [QA Plan Relationship Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Plan%20Relationship%20Upload/QA%20Plan%20Relationship%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-plan-relationship-upload/](https://www.enginatics.com/reports/qa-plan-relationship-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload) |

## Case Study & Technical Analysis: QA Plan Relationship Upload

### Executive Summary
The QA Plan Relationship Upload creates, updates and deletes parent and child relationships between Oracle Quality collection plans. It is written for quality administrators who set up linked collection plans, where results captured on a parent plan automatically or manually lead to child plan records. The upload maintains three things through the standard Oracle API for quality parent-child packages: the plan relationship, the element relationships between the parent and child plans, and the criteria that decide when child records are created automatically. It sits in the Quality module and is shown in Excel through Blitz Report.

### Business Challenge
*   **Linked inspection plans:** Some inspections need a child plan to record detail results once a parent plan has been completed, and each link must be defined for every parent plan.
*   **Choosing the entry mode:** The team must decide whether child data is entered immediately, later by hand, created automatically when the parent matches criteria, or created whenever the parent changes.
*   **Mapping elements between plans:** Parent and child plans need elements mapped to each other, so that values flow correctly between them.
*   **Setting up criteria:** Automatic child creation depends on criteria tests against parent elements, and these must be maintained consistently across many relationships.

### The Solution
*   **Relationship in one row:** Each row shows the organisation, parent plan, child plan, entry mode, layout mode, auto row count and default parent specification.
*   **Element mapping:** The parent element, child element and relationship type of each element pair are shown, with the link flag.
*   **Criteria detail:** Each criteria test shows the element it tests, its operator and the from and to values.
*   **Identifiers for maintenance:** The plan relationship, element relationship and criteria identifiers are returned, so an update or deletion targets the right record.
*   **Delete marker:** A delete record column allows a row to be flagged for removal through the API.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PC_PLAN_RELATIONSHIP`: the relationship between a parent plan and a child plan, with entry mode, layout mode and automatic row count.
*   `QA_PC_ELEMENT_RELATIONSHIP`: the mapping of elements between a parent and a child plan.
*   `QA_PC_CRITERIA`: the criteria that decide automatic child record creation.
*   `QA_PLANS`: the parent and child collection plans.
*   `QA_CHARS`: the collection elements of the parent, child and criteria columns.
*   `MTL_PARAMETERS`: the inventory organisation that owns the parent plan.

#### Logical Relationships
1. `MTL_PARAMETERS` joins to the parent plan in `QA_PLANS` on the organisation identifier.
2. The parent plan joins to `QA_PC_PLAN_RELATIONSHIP` on the parent plan identifier, and the child plan joins to the relationship on the child plan identifier.
3. Element relationships join to the plan relationship as an outer join, so a relationship without element mappings is still listed.
4. The parent and child elements join to `QA_CHARS` as outer joins through the element relationship.
5. Criteria join to the plan relationship as an outer join, and the criteria element joins to `QA_CHARS` as an outer join.

### Parameters & Filtering
*   **Upload Mode:** Chooses between create, update and delete operations, which determines the use of the delete record column.
*   **Organization:** Restricts the relationships to parent plans in one inventory organisation.
*   **Parent Plan:** Restricts the output to relationships from one parent plan.
*   **Child Plan:** Restricts the output to relationships to one child plan.

### Performance & Optimization
*   **Parent-driven query:** The query starts from the parent plans of the selected organisation, so the relationship table is read only for those plans.
*   **Outer joins for dependent records:** Element relationships and criteria are attached with outer joins, so a plan relationship without elements or criteria still appears for maintenance.
*   **Small configuration set:** Plan relationships are configuration records, so the output is typically small, and the main cost is the join chain across the plan and element tables.

### FAQ
**Q: How do I set up a child plan that is created automatically from a parent plan?**
A: Set the entry mode to automatic in the file, specify the criteria for the child creation, and upload the file. The description lists Automatic as the mode where child records are created when the parent matches the criteria.

**Q: What is the difference between Immediate and Delayed entry modes?**
A: Immediate means the child data is entered straight after the parent record, while Delayed means the child records are entered manually later.

**Q: Can this upload remove a parent-child relationship?**
A: Yes. The delete record column allows a relationship row to be deleted through the standard API, as the description states for the create, update and delete operations.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-plan-relationship-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
