---
layout: default
title: 'QA Collection Plan Element Values | Oracle EBS SQL Report'
description: 'Lists the allowed values behind every list-validated Oracle Quality collection element - the entries an operator can pick when entering quality results…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Collection, Plan, Element, Values, qa_plans, mtl_parameters, qa_plan_chars'
permalink: /QA%20Collection%20Plan%20Element%20Values/
---

# QA Collection Plan Element Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-collection-plan-element-values/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists the allowed values behind every list-validated Oracle Quality collection element - the entries an operator can pick when entering quality results, and the collection element master values each plan was seeded from.

Oracle Quality holds these values in two independent places. A collection plan carries its own value list, and the collection element carries a master list. A plan is seeded from the master but is not tied to it afterwards: it can carry codes that were never in the master, override a master value's description, and leave master values out. The Value Level column says which is which. Plan means the value is offered on this collection plan, and is what quality results entry or a quality results upload must validate against. Element means the value is defined on the collection element master but was not carried into this plan, so it is not offered here.

On a Plan row, Element Master Description shows the master's own wording for the same short code, In Element Master flags whether the code exists in the master at all, and Description Overridden flags the rows where the plan's wording differs from the master's.

Result Column is the qa_results column this element's value is stored in, so a short code can be traced to the column that will hold it. Collection results are stored generically, so this mapping is what turns a stored value back into a business meaning.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type and Collection Element. Enabled Elements Only restricts to elements still enabled on the plan. Value Level isolates one of the two levels, and Short Code finds a particular value across plans.

## Report Parameters
Organization, Collection Plan, Plan Type, Collection Element, Enabled Elements Only, Value Level, Short Code

## Oracle EBS Tables Used
[qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [qa_plan_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_plan_char_value_lookups), [qa_char_value_lookups](https://www.enginatics.com/library/?pg=1&find=qa_char_value_lookups), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QA Collection Plan Elements](/QA%20Collection%20Plan%20Elements/ "QA Collection Plan Elements Oracle EBS SQL Report"), [QA Collection Plan Transactions](/QA%20Collection%20Plan%20Transactions/ "QA Collection Plan Transactions Oracle EBS SQL Report"), [QA Collection Plan Actions](/QA%20Collection%20Plan%20Actions/ "QA Collection Plan Actions Oracle EBS SQL Report"), [QA Collection Plan Relationships](/QA%20Collection%20Plan%20Relationships/ "QA Collection Plan Relationships Oracle EBS SQL Report"), [QA Collection Plan Upload](/QA%20Collection%20Plan%20Upload/ "QA Collection Plan Upload Oracle EBS SQL Report"), [QA Quality Results](/QA%20Quality%20Results/ "QA Quality Results Oracle EBS SQL Report"), [QA Plan Relationship Upload](/QA%20Plan%20Relationship%20Upload/ "QA Plan Relationship Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Collection Plan Element Values 14-Aug-2026 112043.xlsx](https://www.enginatics.com/example/qa-collection-plan-element-values/) |
| Blitz Report™ XML Import | [QA_Collection_Plan_Element_Values.xml](https://www.enginatics.com/xml/qa-collection-plan-element-values/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-collection-plan-element-values/](https://www.enginatics.com/reports/qa-collection-plan-element-values/) |



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
