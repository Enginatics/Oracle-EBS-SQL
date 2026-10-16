---
layout: default
last_modified_at: 2026-10-16
title: 'QA Collection Plan Element Values | Oracle EBS SQL Report'
description: 'Lists the allowed values behind every list-validated Oracle Quality collection element - the entries an operator can pick when entering quality results…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Collection, Plan, Element, Values, qa_plans, mtl_parameters, qa_plan_chars'
permalink: /QA%20Collection%20Plan%20Element%20Values/
report_name: 'QA Collection Plan Element Values'
report_web_name: qa-collection-plan-element-values
module: 'Quality'
module_url: /modules/quality/
---

# QA Collection Plan Element Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-element-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
Lists the allowed values behind every list-validated Oracle Quality collection element - the entries an operator can pick when entering quality results, and the collection element master values each plan was seeded from.

Oracle Quality holds these values in two independent places. A collection plan carries its own value list, and the collection element carries a master list. A plan is seeded from the master but is not tied to it afterwards: it can carry codes that were never in the master, override a master value's description, and leave master values out. The Value Level column says which is which. Plan means the value is offered on this collection plan, and is what quality results entry or a quality results upload must validate against. Element means the value is defined on the collection element master but was not carried into this plan, so it is not offered here.

On a Plan row, Element Master Description shows the master's own wording for the same short code, In Element Master flags whether the code exists in the master at all, and Description Overridden flags the rows where the plan's wording differs from the master's.

Result Column is the qa_results column this element's value is stored in, so a short code can be traced to the column that will hold it. Collection results are stored generically, so this mapping is what turns a stored value back into a business meaning.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type and Collection Element. Enabled Elements Only restricts to elements still enabled on the plan. Value Level isolates one of the two levels, and Short Code finds a particular value across plans.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Enabled Elements Only, Value Level, Short Code

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [qa_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_char_value_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Element%20Values/QA%20Collection%20Plan%20Element%20Values.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Element Values 14-Aug-2026 112043.xlsx](https://www.enginatics.com/example/qa-collection-plan-element-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Element_Values.xml](https://www.enginatics.com/xml/qa-collection-plan-element-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) |
| SQL Source | [QA Collection Plan Element Values.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Collection%20Plan%20Element%20Values/QA%20Collection%20Plan%20Element%20Values.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-collection-plan-element-values/](https://www.enginatics.com/reports/qa-collection-plan-element-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values) |

## Case Study & Technical Analysis: QA Collection Plan Element Values

### Executive Summary
The QA Collection Plan Element Values report lists the allowed values behind every list-validated Oracle Quality collection element. These are the entries an operator can pick when recording quality results, and the master values each collection plan was seeded from. It is written for quality engineers, Oracle Quality administrators and implementation consultants who must confirm which codes a plan will accept before results are entered or loaded. The report separates the two places where Oracle Quality keeps these values, the plan's own value list and the collection element master, so that differences between them are visible.
### Business Challenge
*   **Validating result entry:** Quality results entered against a plan must use codes the plan offers, and an implementer needs to see that list before operators use it.
*   **Plan drift from the master:** A plan is seeded from the element master but is not tied to it afterwards, so codes can be added to a plan that are absent from the master, or descriptions can differ.
*   **Interpreting stored results:** Collection results are stored generically, so a short code must be traced to the result column that holds it in order to be given a business meaning.

### The Solution
*   **Two value levels, one list:** Each row is marked as either Plan, meaning the value is offered on the plan, or Element, meaning it exists on the master but was not carried into the plan.
*   **Master comparison:** For plan values, the element master's description for the same short code is shown, along with whether the code exists in the master at all.
*   **Override detection:** Rows where the plan's wording differs from the master's are flagged as overridden.
*   **Result column mapping:** The result column in which each element's value is stored is returned, linking a short code to its storage location.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_PLANS`: the collection plans, with name, description and plan type.
*   `QA_PLAN_CHARS`: the elements attached to each plan, with prompt, sequence, result column and enabled and mandatory flags.
*   `QA_CHARS`: the collection element master, with its name, type, datatype and context.
*   `QA_PLAN_CHAR_VALUE_LOOKUPS`: the value list carried by each plan for each element.
*   `QA_CHAR_VALUE_LOOKUPS`: the master value list for each element.
*   `MTL_PARAMETERS`: the inventory organisation of each plan.

#### Logical Relationships
1. `QA_PLANS` joins to `MTL_PARAMETERS` as an outer join on the organisation identifier, so plans without an organisation, such as templates, are still listed.
2. Plan elements join to `QA_PLANS` on the plan identifier and to `QA_CHARS` on the element identifier.
3. Plan value lists join to the plan elements on the plan and element identifiers, and to the master value list on the element and short code, as an outer join.
4. The Element branch selects master values that have no matching plan value, using a `not exists` condition on the plan value list.
5. The two branches are combined with `union all` and ordered by organisation, plan name, prompt sequence, element name and short code.

### Parameters & Filtering
*   **Organization:** Restricts the plans to one inventory organisation.
*   **Collection Plan:** Restricts the output to one plan.
*   **Plan Type:** Restricts the plans to one plan type.
*   **Collection Element:** Restricts the output to one element.
*   **Enabled Elements Only:** Restricts the output to elements that are enabled on the plan.
*   **Value Level:** Isolates the Plan or Element level.
*   **Short Code:** Finds one code across all plans and elements.

### Performance & Optimization
*   **Access-controlled plans:** Plans are limited to organisations in the access view for the current responsibility, or to organisation zero, which holds the template plans.
*   **Two-branch design:** The plan level and element level are separate branches, each with its own driving set, so the anti-join for element-only values is evaluated only in the second branch.
*   **Outer joins for master values:** Master descriptions are attached with outer joins, so plan values that are not in the master remain in the output.

### FAQ
**Q: Which values can an operator pick when entering quality results on a collection plan?**
A: Rows with the Plan value level are the values offered on that plan, and they are what quality results entry must validate against.

**Q: What does it mean when a value is listed as Element?**
A: The value is defined on the collection element master but was not carried into the plan, so it is not offered on that plan.

**Q: How do I see which plan values have different wording from the master?**
A: Read the Description Overridden column, which is set where the plan's description differs from the element master's description for the same short code.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-collection-plan-element-values)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
