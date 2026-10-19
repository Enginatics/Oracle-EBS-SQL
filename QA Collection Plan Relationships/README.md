---
layout: default
last_modified_at: 2026-10-19
title: 'QA Collection Plan Relationships | Oracle EBS SQL Report'
description: 'Every Oracle Quality parent child collection plan relationship, at one row per parent element to child element mapping. Each row names both plans with…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plan, Relationships, qa_pc_plan_relationship, qa_plan_chars, qa_pc_element_relationship'
permalink: /QA%20Collection%20Plan%20Relationships/
report_name: 'QA Collection Plan Relationships'
report_web_name: qa-collection-plan-relationships
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plan Relationships – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
Every Oracle Quality parent child collection plan relationship, at one row per parent element to child element mapping. Each row names both plans with their descriptions and plan types, the relationship type, the data entry mode and layout mode that govern how the child rows are presented, the automatic row count and default parent specification flag, and the element relationship operator that says what the parent value does to the child value, together with the plan level prompt of each mapped element. A relationship that has no element mapping yet is still listed, as a single row.

Oracle Quality lets one collection plan drive another: when results are entered against the parent, a child plan is created and selected element values are copied, summed, averaged or otherwise derived into it. That behaviour is held in three tables which no single Oracle window exposes together - qa_pc_plan_relationship for the pairing and its data entry behaviour, qa_pc_element_relationship for the element by element mapping, and qa_pc_criteria for the conditions under which the child is created at all. This report is the one place the whole chain is visible, which is what makes it the reference when documenting a Quality setup, auditing which plans feed which, or specifying an interface that has to reproduce the derived values a parent plan writes into its children.

Criteria are a gate on the relationship rather than an attribute of one element mapping, so they are aggregated onto every row of that relationship: Criteria Count gives the number of conditions and Criteria renders them as readable expressions. Because aggregated text cannot be filtered, the Criteria Element parameter restricts to the relationships that are gated by a given collection element.

Filter with the optional Organization, Parent Plan, Child Plan and Collection Element parameters, or narrow on the relationship behaviour itself with Element Relationship and Data Entry Mode. Organization and Collection Element match either side of the relationship, so a single value returns everything that touches that organization or that element as parent or as child. Leaving Organization blank returns every relationship whose parent plan the responsibility has inventory organization access to, plus the relationships between seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

Inventory organization security is applied to the parent plan only. A relationship whose parent plan the responsibility can see is listed in full, including the name, description and plan type of a child plan in an organization the responsibility has no access to, because a relationship spans two plans and suppressing the child would leave the row meaningless.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Parent Plan, Child Plan, Collection Element, Element Relationship, Data Entry Mode, Criteria Element

## Oracle EBS Tables Used
[qa_pc_plan_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_plan_relationship&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [qa_pc_element_relationship](https://www.enginatics.com/library/?pg=1&find=qa_pc_element_relationship&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [qa_pc_criteria](https://www.enginatics.com/library/?pg=1&find=qa_pc_criteria&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Relationships/QA%20Collection%20Plan%20Relationships.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Relationships 14-Aug-2026 112012.xlsx](https://www.enginatics.com/example/qa-collection-plan-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Relationships.xml](https://www.enginatics.com/xml/qa-collection-plan-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) |
| SQL Source | [QA Collection Plan Relationships.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Relationships/QA%20Collection%20Plan%20Relationships.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-relationships/](https://www.enginatics.com/reports/qa-collection-plan-relationships/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships) |

## Case Study & Technical Analysis: QA Collection Plan Relationships

### Executive Summary
This report lists every parent and child collection plan relationship in Oracle Quality, at one row per parent element to child element mapping. Quality engineers and metrology specialists use it when documenting a quality setup, auditing which plans feed which, or specifying an interface that must reproduce the values a parent plan writes into its children. Each row names both plans with their descriptions and types, the relationship behavior, the data entry and layout modes, the criteria that gate the child, and the element relationship operator. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Undocumented plan chains:** One collection plan can create child plans automatically, and the chain is hard to see from the Oracle windows.
*   **Derived values:** Summed, averaged or copied values that a parent writes into its children must be reproduced in any external interface.
*   **Gating criteria:** A child plan is created only when its criteria are met, and those conditions are not visible on the element mapping.
*   **Organization boundaries:** Parent plans are secured by inventory organization, and a relationship must still be understood when the child sits in another organization.

### The Solution
*   **One row per mapping:** Each parent element to child element mapping is listed, and a relationship with no mapping yet is listed once.
*   **Plan identity:** The parent and child plan names, descriptions, types and organizations are returned, with the child plan shown in full even when its organization is not accessible.
*   **Behavior flags:** The relationship type, data entry mode, layout mode, automatic row count and default parent specification flag are shown as readable meanings.
*   **Criteria rendering:** The number of criteria and a readable list of their conditions are returned for each relationship.
*   **Operator meaning:** The element relationship type states what the parent value does to the child value.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PC_PLAN_RELATIONSHIP`: the pairing of a parent plan and a child plan, with the relationship type, data entry mode, layout mode and default flags.
*   `QA_PC_ELEMENT_RELATIONSHIP`: the element by element mapping within a relationship, with the element relationship type and link flag.
*   `QA_PC_CRITERIA`: the conditions under which the child is created, with operator and low and high values.
*   `QA_PLANS`: the parent and child plans, with name, description, type and organization id.
*   `QA_PLAN_CHARS`: the element prompts for each plan.
*   `QA_CHARS`: the element names.
*   `MTL_PARAMETERS`: the inventory organization code of each plan.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. `QA_PC_PLAN_RELATIONSHIP` joins to `QA_PLANS` twice, once as the parent plan and once as the child plan, on plan id.
2. Each plan joins to `MTL_PARAMETERS` on organization id as an outer join, which gives the organization code.
3. `QA_PC_PLAN_RELATIONSHIP` joins to `QA_PC_ELEMENT_RELATIONSHIP` on plan relationship id as an outer join, so relationships without mappings remain.
4. The parent and child characters join to `QA_CHARS` on character id, and their prompts come from `QA_PLAN_CHARS` for the matching plan.
5. Criteria are read from `QA_PC_CRITERIA` on plan relationship id, and they are summarized per relationship in the criteria count and the criteria list.

### Parameters & Filtering
*   **Organization:** matches either the parent or the child side of the relationship.
*   **Parent Plan and Child Plan:** restrict the relationships to one parent or child plan.
*   **Collection Element:** matches either side of the mapping.
*   **Element Relationship and Data Entry Mode:** restrict the rows to one relationship behavior or data entry mode.
*   **Criteria Element:** restricts the output to relationships gated by a given collection element.

### Performance & Optimization
*   The parent plan is filtered by the organization access view, and seeded template plans with organization id zero are always allowed.
*   The criteria list is an aggregated subquery per relationship, so the criteria text is built once for each relationship row.
*   The Criteria Element parameter narrows the relationships before the aggregated text is produced, because aggregated text cannot be filtered in the outer query.

### FAQ
**Q: Why does a row show a blank Organization Code?**
A: Seeded template plans are not owned by an inventory organization, so their organization code is blank.

**Q: Why can I see a child plan in an organization I cannot access?**
A: Inventory organization security applies to the parent plan only. The child plan is shown in full so the relationship is not left incomplete.

**Q: How do I find all relationships gated by one element?**
A: Enter the element in the Criteria Element parameter. The criteria list then shows the conditions for each relationship that uses it.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-relationships)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
