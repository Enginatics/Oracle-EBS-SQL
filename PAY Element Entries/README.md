---
layout: default
last_modified_at: 2026-10-16
title: 'PAY Element Entries | Oracle EBS SQL Report'
description: 'Element entries and their input values valid at the Effective Date, for all assignments including non-primary assignments and the assignments of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payroll, Enginatics, PAY, Element, Entries, pay_all_payrolls_f, per_all_assignments_f, per_all_people_f'
permalink: /PAY%20Element%20Entries/
report_name: 'PAY Element Entries'
report_web_name: pay-element-entries
module: 'Payroll'
module_url: /modules/payroll/
---

# PAY Element Entries – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pay-element-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries).
**Oracle EBS module:** [Payroll](/modules/payroll/ "Oracle EBS Payroll reports") · [all Payroll reports](/modules/payroll/)  

## Overview
Element entries and their input values valid at the Effective Date, for all assignments including non-primary assignments and the assignments of terminated employees whose entries are still valid at that date.

One row per element entry and input value, so that the values of an input value, for example Pay Value or Amount, can be filtered and summed across employees and elements. An entry without input values shows one row with blank input value columns.

Entry Value shows the meaning of lookup validated input values and dates in display format. Numeric Value holds the value of money, number, integer and decimal hours input values as a number. Input values validated by a value set show the stored value.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Effective Date, Business Group, Element Name, Element Classification, Payroll, Organization, Employee, Assignment Number

## Oracle EBS Tables Used
[pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [per_assignment_status_types_v](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_element_entries_f](https://www.enginatics.com/library/?pg=1&find=pay_element_entries_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_element_types_f_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_element_classifications_vl](https://www.enginatics.com/library/?pg=1&find=pay_element_classifications_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_element_entry_values_f](https://www.enginatics.com/library/?pg=1&find=pay_element_entry_values_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_input_values_f_vl](https://www.enginatics.com/library/?pg=1&find=pay_input_values_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries), [pay_cost_allocation_keyflex](https://www.enginatics.com/library/?pg=1&find=pay_cost_allocation_keyflex&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)

## Related Reports
[PAY Gross to Net Summary](/PAY%20Gross%20to%20Net%20Summary/ "PAY Gross to Net Summary Oracle EBS SQL Report"), [PAY Batch Element Entry](/PAY%20Batch%20Element%20Entry/ "PAY Batch Element Entry Oracle EBS SQL Report"), [PER Payroll Element Entry Upload](/PER%20Payroll%20Element%20Entry%20Upload/ "PER Payroll Element Entry Upload Oracle EBS SQL Report"), [PAY Employee Payroll History](/PAY%20Employee%20Payroll%20History/ "PAY Employee Payroll History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Element%20Entries/PAY%20Element%20Entries.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PAY Element Entries 15-Oct-2026 022626.xlsx](https://www.enginatics.com/example/pay-element-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) |
| Blitz Report™ XML Import | [PAY_Element_Entries.xml](https://www.enginatics.com/xml/pay-element-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) |
| SQL Source | [PAY Element Entries.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PAY%20Element%20Entries/PAY%20Element%20Entries.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pay-element-entries/](https://www.enginatics.com/reports/pay-element-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries) |

## Case Study & Technical Analysis: PAY Element Entries

### Executive Summary
This report lists the payroll element entries of every employee assignment that are valid at a chosen effective date, with their input values. It returns one row per element entry and input value, so payroll analysts can filter and total values such as pay values or amounts across employees and elements. It covers non-primary assignments and the assignments of terminated employees whose entries remain valid at that date. Payroll administrators and HR analysts use it to verify what is paid, to audit recurring deductions and allowances, and to reconcile element values against the payroll run. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Verifying pay setup:** Each employee's recurring elements and their values must be checked against the agreed terms before a payroll run.
*   **Auditing deductions and allowances:** Analysts need one list of every deduction and allowance across the workforce at a given date.
*   **Terminated employee entries:** Entries that remain valid for leavers must be visible until they are closed.
*   **Input value totals:** Pay values and amounts must be summed by element, classification or organization without manual extraction from the forms.

### The Solution
*   **Valid at a date:** Every date-tracked row is filtered to the effective date, so the list reflects the position on that day.
*   **One row per input value:** Each element entry expands to its input values, and an entry with no input values appears once with blank value columns.
*   **Readable values:** Lookup-validated values and dates are shown in display format, and money, number, integer and hours values are also provided as a number.
*   **Cost allocation:** The cost allocation key flexfield of each entry is returned with the entry.
*   **Reason and audit:** The entry reason, the creator type and the last update user and date are included.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_ALL_ASSIGNMENTS_F`: the employee assignments, with the business group, organization and status.
*   `PER_ALL_PEOPLE_F`: the employee's name and number.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the assignment status user name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and organization names.
*   `PAY_ALL_PAYROLLS_F`: the payroll name of the assignment.
*   `PAY_ELEMENT_ENTRIES_F`: the element entries, with start and end dates, entry type and creator type.
*   `PAY_ELEMENT_TYPES_F_VL`: the element name and processing type.
*   `PAY_ELEMENT_CLASSIFICATIONS_VL`: the element classification name.
*   `PAY_ELEMENT_ENTRY_VALUES_F`: the value of each input value of an entry.
*   `PAY_INPUT_VALUES_F_VL`: the input value name, unit and lookup type.
*   `PAY_COST_ALLOCATION_KEYFLEX`: the cost allocation of each entry.

#### Logical Relationships
1. `PER_ALL_ASSIGNMENTS_F` joins to `PER_ALL_PEOPLE_F` on person id, and both are restricted to the effective date.
2. The assignment joins to `PAY_ELEMENT_ENTRIES_F` on assignment id, restricted to entries valid at the effective date.
3. The entry joins to `PAY_ELEMENT_TYPES_F_VL` on element type id, and the element type to `PAY_ELEMENT_CLASSIFICATIONS_VL` on classification id.
4. Each entry joins to `PAY_ELEMENT_ENTRY_VALUES_F` as an outer join, so entries with no values remain in the result.
5. Each value joins to `PAY_INPUT_VALUES_F_VL` on input value id, and the entry joins to `PAY_COST_ALLOCATION_KEYFLEX` as an outer join.

### Parameters & Filtering
*   **Effective Date:** the date at which entries, assignments and element definitions are tested.
*   **Business Group:** restricts the rows to one business group.
*   **Element Name and Element Classification:** restrict the entries to one element or one classification.
*   **Payroll:** restricts the rows to one payroll.
*   **Organization:** restricts the rows to one organization.
*   **Employee and Assignment Number:** select one employee or one assignment.

### Performance & Optimization
*   The effective date tests are applied to every date-tracked table, so each join returns a single current row per key.
*   Input value and cost allocation joins are outer joins, so entries without values are still returned.
*   Numeric conversion is applied only to the input value types that hold numbers, so text and date values are not converted.

### FAQ
**Q: Why does an employee with a terminated assignment appear?**
A: The report includes assignments of terminated employees whose entries are still valid at the effective date.

**Q: Why is the numeric value blank for some input values?**
A: The numeric value is filled only for money, number, integer and decimal hours input values. Other input values show their value in the entry value column.

**Q: Does the report include non-primary assignments?**
A: Yes. Non-primary assignments are included, and the primary assignment flag is shown on each row.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pay-element-entries)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
