---
layout: default
last_modified_at: 2026-10-19
title: 'PAY Batch Element Entry | Oracle EBS SQL Report'
description: 'Batch Element Entry (BEE) batch lines with their batch header, line status, element, input values and validation or transfer messages. Input Values lists…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, PAY, Batch, Element, Entry, per_all_people_f, pay_element_types_f_vl, pay_input_values_f_vl'
permalink: /PAY%20Batch%20Element%20Entry/
report_name: 'PAY Batch Element Entry'
report_web_name: pay-batch-element-entry
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Batch Element Entry – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-batch-element-entry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
Batch Element Entry (BEE) batch lines with their batch header, line status, element, input values and validation or transfer messages.

Input Values lists the line's values with the input value names of the element in display sequence, which is the order in which BEE assigns Value 1 to Value 15.

Use Line Status Error to review lines that failed validation or transfer before correcting and revalidating the batch.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Batch Name, Batch Status, Line Status, Element Name, Effective Date From, Effective Date To, Batch Creation Date From, Batch Creation Date To

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [pay_element_types_f_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [pay_input_values_f_vl](https://www.enginatics.com/library/?pg=1&find=pay_input_values_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [pay_message_lines](https://www.enginatics.com/library/?pg=1&find=pay_message_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [pay_batch_headers](https://www.enginatics.com/library/?pg=1&find=pay_batch_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [pay_batch_lines](https://www.enginatics.com/library/?pg=1&find=pay_batch_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [PAY Payroll Process Summary](/PAY%20Payroll%20Process%20Summary/ "PAY Payroll Process Summary Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [PAY Employee Payroll History](/PAY%20Employee%20Payroll%20History/ "PAY Employee Payroll History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Batch%20Element%20Entry/PAY%20Batch%20Element%20Entry.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PAY Batch Element Entry 15-Oct-2026 022635.xlsx](https://www.enginatics.com/example/pay-batch-element-entry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) |
| Blitz Report™ XML Import | [PAY_Batch_Element_Entry.xml](https://www.enginatics.com/xml/pay-batch-element-entry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) |
| SQL Source | [PAY Batch Element Entry.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Batch%20Element%20Entry/PAY%20Batch%20Element%20Entry.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-batch-element-entry/](https://www.enginatics.com/reports/pay-batch-element-entry/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry) |

## Case Study & Technical Analysis: PAY Batch Element Entry

### Executive Summary
This report lists Batch Element Entry (BEE) batches in Oracle Payroll with their batch headers, each batch line, the element and its input values, and any validation or transfer messages. BEE is the tool that payroll teams use to load element entries in bulk, such as one-off earnings, deductions or recurring elements for many employees, and this report shows the state of each line after validation and transfer. It is used by payroll administrators to find the lines that failed, to read the messages that explain each failure, and to correct and revalidate the batch before the payroll run. The Input Values column gives the values in the order BEE assigns them, so the entry can be checked against the element definition.

### Business Challenge
*   **Failed lines delay the payroll:** A batch line that fails validation or transfer does not create its element entry, and the payroll run can miss the amount.
*   **Reading the messages:** Each line can carry several messages, and the reason must be readable in one place.
*   **Matching values to inputs:** The meaning of Value 1 to Value 15 depends on the input value names of the element, so the entries must be read with those names.

### The Solution
*   Shows each batch with its business group, batch name, reference, source, status and the action to take if an entry exists.
*   Shows each line with its sequence, status, assignment and employee name and number, element name, entry type, effective dates and cost allocation.
*   Lists the input values of the line as name and value pairs, with the names taken from the element's input values in display sequence.
*   Shows the number of line messages, the first line message and the first batch message, so the reason for an error appears on the same row.
*   Shows who created the batch and when, using the user name and client time.

### Technical Architecture (High Level)
#### Primary Tables
*   `PAY_BATCH_HEADERS`: the batch, with its name, reference, source, status, business group and creation details.
*   `PAY_BATCH_LINES`: the batch lines, with the element, assignment, effective dates, entry type, input values 1 to 15, line status and cost allocation.
*   `PAY_MESSAGE_LINES`: the validation and transfer messages, for either a batch or a batch line.
*   `PAY_INPUT_VALUES_F_VL`: the input values of each element, with name and display sequence.
*   `PAY_ELEMENT_TYPES_F_VL`: the element name, effective on the entry date.
*   `PER_ALL_PEOPLE_F` and `PER_ALL_ASSIGNMENTS_F`: the employee name and number, and the assignment number.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group name.

#### Logical Relationships
1. `PAY_BATCH_HEADERS` is joined to the business group in `HR_ALL_ORGANIZATION_UNITS_VL`, and to `PAY_BATCH_LINES` on the batch identifier.
2. Each line is outer joined to its assignment, and the assignment is matched by the effective date of the line.
3. The employee name and number are taken from the person record effective on the line's effective date.
4. The input value names are ranked within each element by display sequence, and each rank is matched to the corresponding value on the line.
5. Line messages are joined by the batch line identifier, and the batch message by the batch identifier with source type H.

### Parameters & Filtering
*   **Business Group:** limits the batches to one business group.
*   **Batch Name** and **Batch Status:** select a batch, or batches with a status.
*   **Line Status:** selects lines with one status, such as Error.
*   **Element Name:** limits the lines to one element.
*   **Effective Date From** and **Effective Date To:** bound the effective date of the lines.
*   **Batch Creation Date From** and **Batch Creation Date To:** bound the date the batch was created.

### Performance & Optimization
*   The input value names are summarized by element and input value in an inline view before they are ranked, so the names are not read from the raw input value rows for each line.
*   The message lookups use the first message in sequence, so each line returns one message rather than all of them.
*   Input value columns are shown only where the line has a value in that position, which keeps the output free of empty pairs.

### FAQ
**Q: How do I find the lines that failed in a batch?**
A: Set Line Status to Error and enter the Batch Name. The Line Message column shows the first message of each failed line.

**Q: Why do the input values appear with names?**
A: BEE assigns Value 1 to Value 15 in the display sequence of the element's input values, and the report shows each value with that name.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-batch-element-entry)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
