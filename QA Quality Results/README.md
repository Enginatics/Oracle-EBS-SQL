---
layout: default
title: 'QA Quality Results | Oracle EBS SQL Report'
description: 'One row per collection result and characteristic, so results from any number of collection plans stack in a single extract instead of one column per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Quality, Results, wip_entities, po_headers_all, po_vendors'
permalink: /QA%20Quality%20Results/
---

# QA Quality Results – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-quality-results/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
One row per collection result and characteristic, so results from any number of collection plans stack in a single extract instead of one column per characteristic. Use Collection Plan like to pull a whole family of plans in one run, for example INC_MRC%.

Oracle Quality stores every element value as a string in a generic column of qa_results, and the plan's element definition decides which column holds which characteristic. Result is therefore text. Result Number carries the numeric conversion for Number elements so the values can be charted or averaged, and Date elements arrive as YYYY/MM/DD.

Only the elements an operator fills in are listed as characteristic rows. The context elements a plan collects, being item, revision, lot, serial, subinventory, quantity, job, purchase order, supplier and customer, are columns on every row instead, so they can be filtered and pivoted without appearing as results.

Result Date is when the result was recorded. Exclude Empty Results defaults to Yes, so clear it to also list elements that are enabled on the plan but were left blank.

## Report Parameters
Organization, Collection Plan, Collection Plan like, Result Date From, Result Date To, Collection Element, Item, Lot Number, Exclude Empty Results

## Oracle EBS Tables Used
[wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [qa_results](https://www.enginatics.com/library/?pg=1&find=qa_results), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Quality Results 18-Aug-2026 103121.xlsx](https://www.enginatics.com/example/qa-quality-results/) |
| Blitz Report™ XML Import | [QA_Quality_Results.xml](https://www.enginatics.com/xml/qa-quality-results/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/qa-quality-results/](https://www.enginatics.com/reports/qa-quality-results/) |



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
