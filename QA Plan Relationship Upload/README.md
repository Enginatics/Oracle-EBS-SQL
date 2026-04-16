---
layout: default
title: 'QA Plan Relationship Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, or delete Quality Collection Plan parent-child relationships using the standard Oracle API qassparentchildpkg. This upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Plan, Relationship, mtl_parameters, qa_plans, qa_pc_plan_relationship'
permalink: /QA%20Plan%20Relationship%20Upload/
---

# QA Plan Relationship Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-plan-relationship-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Organization, Parent Plan, Child Plan

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship), [qa_pc_element_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_element_relationship), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [qa_pc_criteria](https://www.enginatics.com/library/?pg=1&find=qa_pc_criteria)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/qa-plan-relationship-upload/) |
| Blitz Report™ XML Import | [QA_Plan_Relationship_Upload.xml](https://www.enginatics.com/xml/qa-plan-relationship-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-plan-relationship-upload/](https://www.enginatics.com/reports/qa-plan-relationship-upload/) |



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
