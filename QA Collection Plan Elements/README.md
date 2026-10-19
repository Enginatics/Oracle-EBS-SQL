---
layout: default
last_modified_at: 2026-10-19
title: 'QA Collection Plan Elements | Oracle EBS SQL Report'
description: 'Every collection element assigned to an Oracle Quality collection plan, with the element''s prompt and sequence on the plan, its element type, datatype…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plan, Elements, mtl_units_of_measure_vl, qa_plan_char_value_lookups, qa_plans'
permalink: /QA%20Collection%20Plan%20Elements/
report_name: 'QA Collection Plan Elements'
report_web_name: qa-collection-plan-elements
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plan Elements – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-elements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
Every collection element assigned to an Oracle Quality collection plan, with the element's prompt and sequence on the plan, its element type, datatype, display length, decimal precision and unit of measure, the plan level and element level default values, and the Mandatory, Enabled, Displayed, Read Only, Information and Poplist flags. Collection plans that have no elements are listed too.

Oracle Quality stores every collection result generically in qa_results, whose character1 to character100 columns carry no meaning of their own: the element to column mapping is held per plan in qa_plan_chars.result_column_name, and each plan gets its own dynamically generated results view. This report exposes that mapping as the Result Column, shown verbatim next to the element's native Hardcoded Column so that a divergence between the two is visible at a glance. It also shows the Context Element classification, which separates a quality characteristic the operator enters from predefined reference information captured automatically from the transaction, and all three validation sources an element can use: a validation table with its additional where clause, a SQL validation string, and the number of plan level values the element offers. Use it to document or audit a Quality setup, and as the specification when building an interface or an upload that writes collection results.

Filter with the optional Organization, Collection Plan, Plan Type, Collection Element and Element Type parameters, or set Enabled Elements Only to Yes to hide elements that are disabled on the plan. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Element Type, Enabled Elements Only

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)

## Related Reports
[QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report"), [BOM Bill of Material Structure](/BOM%20Bill%20of%20Material%20Structure/ "BOM Bill of Material Structure Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Elements/QA%20Collection%20Plan%20Elements.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Elements 14-Aug-2026 071547.xlsx](https://www.enginatics.com/example/qa-collection-plan-elements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Elements.xml](https://www.enginatics.com/xml/qa-collection-plan-elements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) |
| SQL Source | [QA Collection Plan Elements.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Elements/QA%20Collection%20Plan%20Elements.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-elements/](https://www.enginatics.com/reports/qa-collection-plan-elements/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements) |

## Case Study & Technical Analysis: QA Collection Plan Elements

### Executive Summary
The QA Collection Plan Elements report lists every collection element assigned to an Oracle Quality collection plan, with its prompt and sequence on the plan, its element type, datatype, display length, decimal precision and unit of measure. It also shows the plan level and element level default values, the Mandatory, Enabled, Displayed, Read Only, Information and Poplist flags, and the validation sources of each element. Quality engineers use it to document or audit a quality setup, and integration developers use it as the specification for an interface or an upload that writes collection results. It runs in Excel through Blitz Report.

### Business Challenge
*   **Setup documentation:** A collection plan can contain many elements, and the audit of a plan requires each element's type, flags and defaults in one list.
*   **Generic result storage:** Oracle Quality stores every collection result in one generic table, so the meaning of each result column must be known before results can be read or loaded.
*   **Validation review:** An element can be validated by a table, by a SQL string or by plan level values, and each source must be checked during a Quality audit.
*   **Interface design:** A system that loads collection results needs the exact column mapping for each plan.

### The Solution
*   Lists each plan with its organization, plan type and effective dates, and each element assigned to it in the prompt sequence of the plan.
*   Shows the Result Column of each element, which is the name of the column in the plan's results view, next to the element's hardcoded column, so a difference between them is visible.
*   Shows whether the element is a Context Element, a characteristic that the operator enters, or a predefined reference captured from the transaction.
*   Shows the validation table and where clause, the SQL validation string and the number of plan level values offered by the element.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLANS`: the collection plan, with its name, description, type, effective dates and organization.
*   `QA_PLAN_CHARS`: the elements assigned to each plan, with the prompt, sequence, flags, defaults, result column name and value flags.
*   `QA_CHARS`: the element definition, with the name, element type, datatype, display length, validation and specification settings.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the plan level values of an element, counted for each plan element.
*   `MTL_PARAMETERS`: the organization code of the plan.
*   `MTL_UNITS_OF_MEASURE_VL`: the unit of measure names.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

#### Logical Relationships
1.  `QA_PLANS` is outer joined to `MTL_PARAMETERS` on the organization id, which gives the organization code of each plan.
2.  `QA_PLANS` is outer joined to `QA_PLAN_CHARS` on the plan id, so a plan with no elements is still listed.
3.  `QA_PLAN_CHARS` is outer joined to `QA_CHARS` on the character id, which supplies the element definition.
4.  The number of plan level values is a count from `QA_PLAN_CHAR_VALUE_LOOKUPS` on the plan id and character id.
5.  The organization restriction includes plans whose organization id is 0, the seeded template plans, and plans whose organization the responsibility can access.

### Parameters & Filtering
*   **Organization:** limits the plans to one inventory organization.
*   **Collection Plan:** selects one plan by name.
*   **Plan Type:** selects plans of one type.
*   **Collection Element:** selects one element by name.
*   **Element Type:** selects elements of one element type.
*   **Enabled Elements Only:** when set to Yes, hides elements that are disabled on the plan.

### Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, which restricts the plans read to the responsibility's organizations.
*   The value count is a correlated subquery that runs once per plan element, and it reads only the value lookups of that element.
*   Filtering by Collection Plan or Collection Element reduces the plan element rows before the lookups to units of measure and validation fields.
*   The unit of measure lookup uses the view with translated names, and it is an outer join on the unit code, so it adds no rows.

### FAQ
**Q: What does the Result Column show?**
A: It is the name of the column in the plan's dynamically generated results view that stores this element, as held in QA_PLAN_CHARS.RESULTCOLUMNNAME.

**Q: Why are plans with no elements listed?**
A: The plans are outer joined to their elements, so a plan without any elements appears with blank element columns.

**Q: How do I see which plans use a validation table?**
A: The Validation Table and Validation Where Clause columns show the table and its additional where clause for each element. Filter the output on those columns to find the plans.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-elements)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
