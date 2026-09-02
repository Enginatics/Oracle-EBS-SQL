---
layout: default
title: 'QA Collection Plan Elements | Oracle EBS SQL Report'
description: 'Every collection element assigned to an Oracle Quality collection plan, with the element''s prompt and sequence on the plan, its element type, datatype…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plan, Elements, mtl_units_of_measure_vl, qa_plan_char_value_lookups, qa_plans'
permalink: /QA%20Collection%20Plan%20Elements/
---

# QA Collection Plan Elements – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-elements/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Every collection element assigned to an Oracle Quality collection plan, with the element's prompt and sequence on the plan, its element type, datatype, display length, decimal precision and unit of measure, the plan level and element level default values, and the Mandatory, Enabled, Displayed, Read Only, Information and Poplist flags. Collection plans that have no elements are listed too.

Oracle Quality stores every collection result generically in qa_results, whose character1 to character100 columns carry no meaning of their own: the element to column mapping is held per plan in qa_plan_chars.result_column_name, and each plan gets its own dynamically generated results view. This report exposes that mapping as the Result Column, shown verbatim next to the element's native Hardcoded Column so that a divergence between the two is visible at a glance. It also shows the Context Element classification, which separates a quality characteristic the operator enters from predefined reference information captured automatically from the transaction, and all three validation sources an element can use: a validation table with its additional where clause, a SQL validation string, and the number of plan level values the element offers. Use it to document or audit a Quality setup, and as the specification when building an interface or an upload that writes collection results.

Filter with the optional Organization, Collection Plan, Plan Type, Collection Element and Element Type parameters, or set Enabled Elements Only to Yes to hide elements that are disabled on the plan. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Element Type, Enabled Elements Only

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plan Element Values](/QA%20Collection%20Plan%20Element%20Values/ "QA Collection Plan Element Values Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Elements 14-Aug-2026 071547.xlsx](https://www.enginatics.com/example/qa-collection-plan-elements/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Elements.xml](https://www.enginatics.com/xml/qa-collection-plan-elements/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-elements/](https://www.enginatics.com/reports/qa-collection-plan-elements/) |



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
