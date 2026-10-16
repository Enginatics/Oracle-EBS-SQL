# Case Study & Technical Analysis: PAY Batch Element Entry

## Executive Summary
This report lists Batch Element Entry (BEE) batches in Oracle Payroll with their batch headers, each batch line, the element and its input values, and any validation or transfer messages. BEE is the tool that payroll teams use to load element entries in bulk, such as one-off earnings, deductions or recurring elements for many employees, and this report shows the state of each line after validation and transfer. It is used by payroll administrators to find the lines that failed, to read the messages that explain each failure, and to correct and revalidate the batch before the payroll run. The Input Values column gives the values in the order BEE assigns them, so the entry can be checked against the element definition.

## Business Challenge
*   **Failed lines delay the payroll:** A batch line that fails validation or transfer does not create its element entry, and the payroll run can miss the amount.
*   **Reading the messages:** Each line can carry several messages, and the reason must be readable in one place.
*   **Matching values to inputs:** The meaning of Value 1 to Value 15 depends on the input value names of the element, so the entries must be read with those names.

## The Solution
*   Shows each batch with its business group, batch name, reference, source, status and the action to take if an entry exists.
*   Shows each line with its sequence, status, assignment and employee name and number, element name, entry type, effective dates and cost allocation.
*   Lists the input values of the line as name and value pairs, with the names taken from the element's input values in display sequence.
*   Shows the number of line messages, the first line message and the first batch message, so the reason for an error appears on the same row.
*   Shows who created the batch and when, using the user name and client time.

## Technical Architecture (High Level)
### Primary Tables
*   `PAY_BATCH_HEADERS`: the batch, with its name, reference, source, status, business group and creation details.
*   `PAY_BATCH_LINES`: the batch lines, with the element, assignment, effective dates, entry type, input values 1 to 15, line status and cost allocation.
*   `PAY_MESSAGE_LINES`: the validation and transfer messages, for either a batch or a batch line.
*   `PAY_INPUT_VALUES_F_VL`: the input values of each element, with name and display sequence.
*   `PAY_ELEMENT_TYPES_F_VL`: the element name, effective on the entry date.
*   `PER_ALL_PEOPLE_F` and `PER_ALL_ASSIGNMENTS_F`: the employee name and number, and the assignment number.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group name.

### Logical Relationships
1. `PAY_BATCH_HEADERS` is joined to the business group in `HR_ALL_ORGANIZATION_UNITS_VL`, and to `PAY_BATCH_LINES` on the batch identifier.
2. Each line is outer joined to its assignment, and the assignment is matched by the effective date of the line.
3. The employee name and number are taken from the person record effective on the line's effective date.
4. The input value names are ranked within each element by display sequence, and each rank is matched to the corresponding value on the line.
5. Line messages are joined by the batch line identifier, and the batch message by the batch identifier with source type H.

## Parameters & Filtering
*   **Business Group:** limits the batches to one business group.
*   **Batch Name** and **Batch Status:** select a batch, or batches with a status.
*   **Line Status:** selects lines with one status, such as Error.
*   **Element Name:** limits the lines to one element.
*   **Effective Date From** and **Effective Date To:** bound the effective date of the lines.
*   **Batch Creation Date From** and **Batch Creation Date To:** bound the date the batch was created.

## Performance & Optimization
*   The input value names are summarized by element and input value in an inline view before they are ranked, so the names are not read from the raw input value rows for each line.
*   The message lookups use the first message in sequence, so each line returns one message rather than all of them.
*   Input value columns are shown only where the line has a value in that position, which keeps the output free of empty pairs.

## FAQ
**Q: How do I find the lines that failed in a batch?**
A: Set Line Status to Error and enter the Batch Name. The Line Message column shows the first message of each failed line.

**Q: Why do the input values appear with names?**
A: BEE assigns Value 1 to Value 15 in the display sequence of the element's input values, and the report shows each value with that name.

