# Case Study & Technical Analysis: PAY Element Entries

## Executive Summary
This report lists the payroll element entries of every employee assignment that are valid at a chosen effective date, with their input values. It returns one row per element entry and input value, so payroll analysts can filter and total values such as pay values or amounts across employees and elements. It covers non-primary assignments and the assignments of terminated employees whose entries remain valid at that date. Payroll administrators and HR analysts use it to verify what is paid, to audit recurring deductions and allowances, and to reconcile element values against the payroll run. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Verifying pay setup:** Each employee's recurring elements and their values must be checked against the agreed terms before a payroll run.
*   **Auditing deductions and allowances:** Analysts need one list of every deduction and allowance across the workforce at a given date.
*   **Terminated employee entries:** Entries that remain valid for leavers must be visible until they are closed.
*   **Input value totals:** Pay values and amounts must be summed by element, classification or organization without manual extraction from the forms.

## The Solution
*   **Valid at a date:** Every date-tracked row is filtered to the effective date, so the list reflects the position on that day.
*   **One row per input value:** Each element entry expands to its input values, and an entry with no input values appears once with blank value columns.
*   **Readable values:** Lookup-validated values and dates are shown in display format, and money, number, integer and hours values are also provided as a number.
*   **Cost allocation:** The cost allocation key flexfield of each entry is returned with the entry.
*   **Reason and audit:** The entry reason, the creator type and the last update user and date are included.

## Technical Architecture (High Level)
### Primary Tables
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

### Logical Relationships
1. `PER_ALL_ASSIGNMENTS_F` joins to `PER_ALL_PEOPLE_F` on person id, and both are restricted to the effective date.
2. The assignment joins to `PAY_ELEMENT_ENTRIES_F` on assignment id, restricted to entries valid at the effective date.
3. The entry joins to `PAY_ELEMENT_TYPES_F_VL` on element type id, and the element type to `PAY_ELEMENT_CLASSIFICATIONS_VL` on classification id.
4. Each entry joins to `PAY_ELEMENT_ENTRY_VALUES_F` as an outer join, so entries with no values remain in the result.
5. Each value joins to `PAY_INPUT_VALUES_F_VL` on input value id, and the entry joins to `PAY_COST_ALLOCATION_KEYFLEX` as an outer join.

## Parameters & Filtering
*   **Effective Date:** the date at which entries, assignments and element definitions are tested.
*   **Business Group:** restricts the rows to one business group.
*   **Element Name and Element Classification:** restrict the entries to one element or one classification.
*   **Payroll:** restricts the rows to one payroll.
*   **Organization:** restricts the rows to one organization.
*   **Employee and Assignment Number:** select one employee or one assignment.

## Performance & Optimization
*   The effective date tests are applied to every date-tracked table, so each join returns a single current row per key.
*   Input value and cost allocation joins are outer joins, so entries without values are still returned.
*   Numeric conversion is applied only to the input value types that hold numbers, so text and date values are not converted.

## FAQ
**Q: Why does an employee with a terminated assignment appear?**
A: The report includes assignments of terminated employees whose entries are still valid at the effective date.

**Q: Why is the numeric value blank for some input values?**
A: The numeric value is filled only for money, number, integer and decimal hours input values. Other input values show their value in the entry value column.

**Q: Does the report include non-primary assignments?**
A: Yes. Non-primary assignments are included, and the primary assignment flag is shown on each row.
