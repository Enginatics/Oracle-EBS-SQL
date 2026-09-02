---
layout: default
title: 'QA Collection Plan Relationships | Oracle EBS SQL Report'
description: 'Every Oracle Quality parent child collection plan relationship, at one row per parent element to child element mapping. Each row names both plans with…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plan, Relationships, qa_plan_chars, qa_pc_criteria, qa_chars'
permalink: /QA%20Collection%20Plan%20Relationships/
---

# QA Collection Plan Relationships – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-relationships/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Every Oracle Quality parent child collection plan relationship, at one row per parent element to child element mapping. Each row names both plans with their descriptions and plan types, the relationship type, the data entry mode and layout mode that govern how the child rows are presented, the automatic row count and default parent specification flag, and the element relationship operator that says what the parent value does to the child value, together with the plan level prompt of each mapped element. A relationship that has no element mapping yet is still listed, as a single row.

Oracle Quality lets one collection plan drive another: when results are entered against the parent, a child plan is created and selected element values are copied, summed, averaged or otherwise derived into it. That behaviour is held in three tables which no single Oracle window exposes together - qa_pc_plan_relationship for the pairing and its data entry behaviour, qa_pc_element_relationship for the element by element mapping, and qa_pc_criteria for the conditions under which the child is created at all. This report is the one place the whole chain is visible, which is what makes it the reference when documenting a Quality setup, auditing which plans feed which, or specifying an interface that has to reproduce the derived values a parent plan writes into its children.

Criteria are a gate on the relationship rather than an attribute of one element mapping, so they are aggregated onto every row of that relationship: Criteria Count gives the number of conditions and Criteria renders them as readable expressions. Because aggregated text cannot be filtered, the Criteria Element parameter restricts to the relationships that are gated by a given collection element.

Filter with the optional Organization, Parent Plan, Child Plan and Collection Element parameters, or narrow on the relationship behaviour itself with Element Relationship and Data Entry Mode. Organization and Collection Element match either side of the relationship, so a single value returns everything that touches that organization or that element as parent or as child. Leaving Organization blank returns every relationship whose parent plan the responsibility has inventory organization access to, plus the relationships between seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

Inventory organization security is applied to the parent plan only. A relationship whose parent plan the responsibility can see is listed in full, including the name, description and plan type of a child plan in an organization the responsibility has no access to, because a relationship spans two plans and suppressing the child would leave the row meaningless.

## Report Parameters
Organization, Parent Plan, Child Plan, Collection Element, Element Relationship, Data Entry Mode, Criteria Element

## Oracle EBS Tables Used
[qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_pc_criteria](https://www.enginatics.com/library/?pg=1&find=qa_pc_criteria), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_pc_element_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_element_relationship), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Relationships 14-Aug-2026 112012.xlsx](https://www.enginatics.com/example/qa-collection-plan-relationships/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Relationships.xml](https://www.enginatics.com/xml/qa-collection-plan-relationships/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-relationships/](https://www.enginatics.com/reports/qa-collection-plan-relationships/) |



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
