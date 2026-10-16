---
layout: default
last_modified_at: 2026-10-16
title: 'QA Quality Results | Oracle EBS SQL Report'
description: 'One row per collection result and characteristic, so results from any number of collection plans stack in a single extract instead of one column per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Quality, Enginatics, Results, wip_entities, po_headers_all, po_vendors'
permalink: /QA%20Quality%20Results/
report_name: 'QA Quality Results'
report_web_name: qa-quality-results
module: 'Quality'
module_url: /modules/quality/
---

# QA Quality Results – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qa-quality-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results).
**Oracle EBS module:** [Quality](/modules/quality/ "Oracle EBS Quality reports") · [all Quality reports](/modules/quality/)  

## Overview
One row per collection result and characteristic, so results from any number of collection plans stack in a single extract instead of one column per characteristic. Use Collection Plan like to pull a whole family of plans in one run, for example INC_MRC%.

Oracle Quality stores every element value as a string in a generic column of qa_results, and the plan's element definition decides which column holds which characteristic. Result is therefore text. Result Number carries the numeric conversion for Number elements so the values can be charted or averaged, and Date elements arrive as YYYY/MM/DD.

Only the elements an operator fills in are listed as characteristic rows. The context elements a plan collects, being item, revision, lot, serial, subinventory, quantity, job, purchase order, supplier and customer, are columns on every row instead, so they can be filtered and pivoted without appearing as results.

Result Date is when the result was recorded. Exclude Empty Results defaults to Yes, so clear it to also list elements that are enabled on the plan but were left blank.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Collection Plan, Collection Plan like, Result Date From, Result Date To, Collection Element, Item, Lot Number, Exclude Empty Results

## Oracle EBS Tables Used
[wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [qa_results](https://www.enginatics.com/library/?pg=1&find=qa_results&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [qa_plans](https://www.enginatics.com/library/?pg=1&find=qa_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [qa_plan_chars](https://www.enginatics.com/library/?pg=1&find=qa_plan_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [qa_chars](https://www.enginatics.com/library/?pg=1&find=qa_chars&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [QA Collection Plans](/QA%20Collection%20Plans/ "QA Collection Plans Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Quality%20Results/QA%20Quality%20Results.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [QA Quality Results 18-Aug-2026 103121.xlsx](https://www.enginatics.com/example/qa-quality-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) |
| Blitz Report™ XML Import | [QA_Quality_Results.xml](https://www.enginatics.com/xml/qa-quality-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) |
| SQL Source | [QA Quality Results.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QA%20Quality%20Results/QA%20Quality%20Results.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qa-quality-results/](https://www.enginatics.com/reports/qa-quality-results/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results) |

## Case Study & Technical Analysis: QA Quality Results

### Executive Summary
QA Quality Results gives one row for each collected result and characteristic in Oracle Quality, so that results from any number of collection plans can be analysed together in Excel. Oracle Quality stores each element value in a generic column of the results table, and the plan's element definition decides which column holds which characteristic. This report reads those columns and returns them as one stacked list. Quality engineers, supplier quality managers and production supervisors use it to trend inspection results, compare defect rates across items and suppliers, and investigate a family of related plans.

### Business Challenge
*   **Scattered Results:** Each plan stores its results in generic columns, so a standard extract shows a different column meaning for each plan.
*   **Trend Analysis:** Quality managers need numeric results over time to chart and average, which requires converting text values.
*   **Plan Families:** Organizations often run many similar plans, such as one per incoming material family, and need them summarized together.
*   **Context Fields:** Item, lot, serial, supplier and purchase order details must be filterable with the results they describe.

### The Solution
*   **Stacked Result Rows:** Each characteristic that a user filled in becomes one row, so plans with different elements share a single layout.
*   **Typed Result Values:** The result is returned as text, and the numeric result column converts number elements for charting and averaging.
*   **Context On Every Row:** Organization, item, revision, lot, serial, subinventory, quantity, job, purchase order, supplier and customer appear as columns.
*   **Plan Pattern Search:** The collection plan like parameter returns every plan matching a pattern.

### Technical Architecture (High Level)
#### Primary Tables
*   `QA_RESULTS`: the result records, with the context columns and the generic character, comment and sequence columns that hold the element values.
*   `QA_PLANS`: the collection plans, with their names and descriptions.
*   `QA_PLAN_CHARS`: the elements enabled on each plan, with their prompts, unit of measure and result column names.
*   `QA_CHARS`: the element definitions, with their names and data types.
*   `MTL_PARAMETERS`: the organizations.
*   `MTL_SYSTEM_ITEMS_VL`: the items with their concatenated segments.
*   `WIP_ENTITIES`: the jobs referenced by the results.
*   `PO_HEADERS_ALL`: the purchase orders referenced by the results.
*   `PO_VENDORS`: the suppliers.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customers.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

#### Logical Relationships
1.  Each result in `QA_RESULTS` is joined to its plan in `QA_PLANS` and to the enabled elements of that plan in `QA_PLAN_CHARS`.
2.  Each plan element is joined to its definition in `QA_CHARS`.
3.  The result column named by each plan element decides which generic column supplies the value, and a decode expression returns the matching column.
4.  Items are outer joined to `MTL_SYSTEM_ITEMS_VL`, and organizations to `MTL_PARAMETERS`.
5.  Jobs, purchase orders, suppliers and customers are returned through correlated subqueries.
6.  Only the character, comment and sequence element columns are read, and the outer query orders the stacked rows by plan and collection.

### Parameters & Filtering
*   **Organization:** Restricts the results to one organization.
*   **Collection Plan and Collection Plan like:** Select one plan or a pattern of plans.
*   **Result Date From and Result Date To:** Limit the results to the date they were recorded.
*   **Collection Element:** Restricts the output to one characteristic.
*   **Item and Lot Number:** Select the results for one item or one lot.
*   **Exclude Empty Results:** Yes by default, so blank elements are not listed. Clearing it includes enabled elements that were left blank.

### Performance & Optimization
*   **Organization Access First:** Results are limited to permitted organizations before the element decoding is evaluated.
*   **Enabled Elements Only:** The plan element join keeps only enabled elements and only those stored in the character, comment and sequence columns.
*   **Decode Per Column:** Each element picks its value with a decode on the column number, so no extra join to the results is needed.
*   **Correlated Context Lookups:** Job, purchase order, supplier and customer names are read through correlated subqueries that return one value each.

### FAQ
**Q: How do I get numeric results that I can average?**
A: Use the Result Number column. It is populated for number elements whose result is a valid number, and the text Result column keeps the original value.

**Q: Why does a plan element not appear for a result?**
A: Only elements that an operator filled in are listed. Clear the Exclude Empty Results parameter to include enabled elements that were left blank.

**Q: How do I pull every result for a family of plans?**
A: Enter a pattern such as INCMRC% in the Collection Plan like parameter.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qa-quality-results)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
