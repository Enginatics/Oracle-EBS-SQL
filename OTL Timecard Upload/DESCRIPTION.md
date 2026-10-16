# Case Study & Technical Analysis: OTL Timecard Upload

## Executive Summary
This upload creates, updates, submits and deletes Oracle Time and Labor (OTL) timecards. It is an Excel-based alternative to employee self-service time entry: a timekeeper or project administrator downloads the timecards of employees, enters or corrects hours by day and classification, and uploads them. Each line is charged either to a project, task and expenditure type, or to a payroll element. The upload calls the public TimeStore deposit API, so the rules of self-service time entry, including approval routing, apply to every timecard. It is used for timecard catch-up at period end, for bulk corrections after a project reclassification, and for resubmitting timecards that were rejected. Blitz Report™ provides the spreadsheet layout used for these corrections.

## Business Challenge
*   **Late or missing time entry:** Employees who do not enter their time on schedule delay project costing and payroll, and the timekeeper must catch up on their behalf.
*   **Reclassifying time:** Hours charged to the wrong project, task or expenditure type must be corrected across many days and employees.
*   **Approval routing:** Corrected timecards must go back through the approval workflow, and the approval status of each timecard must be visible.

## The Solution
*   Downloads timecards by employee and timecard period, with one row for each timecard line and day, showing the classification, hours and comments.
*   Shows the approval status, the submission date and whether the timecard has been transferred to a recipient application.
*   Derives the period starting date from the employee's Oracle Time and Labor preferences, so rows are grouped into the correct timecard.
*   Accepts a Submit flag on any row of a timecard to start the approval workflow, and it re-submits timecards that are already Submitted or Approved when they are updated.
*   Accepts a Delete Line flag, and deleting all lines of a timecard deletes the whole timecard.

## Technical Architecture (High Level)
### Primary Tables
*   `HXC_TIMECARD_SUMMARY`: the timecard header, with the resource, approval status, submission date and start time.
*   `HXC_TIME_BUILDING_BLOCKS`: the timecard, day and detail building blocks, with the scope, date range and measure.
*   `HXC_TIME_ATTRIBUTES` and `HXC_TIME_ATTRIBUTE_USAGES`: the classification attributes of each detail, such as project, task and expenditure type, or the element.
*   `HXC_TRANSACTIONS` and `HXC_TRANSACTION_DETAILS`: the deposit history, used to decide whether a line has been transferred.
*   `PER_ALL_PEOPLE_F`: the employee name and number, effective on the timecard date.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project number and task number.
*   `PAY_ELEMENT_TYPES_F`: the payroll element name of a payroll classification.

### Logical Relationships
1. `HXC_TIMECARD_SUMMARY` is joined to the employee in `PER_ALL_PEOPLE_F` on the resource identifier, with the employee effective on the start of the timecard.
2. The day building block is a child of the timecard, and the detail building block is a child of the day.
3. Each detail links to its attributes through `HXC_TIME_ATTRIBUTE_USAGES`, and to `HXC_TIME_ATTRIBUTES` for the values.
4. A project classification is taken from the project and task identifiers in the attribute values, and an element classification from the element identifier in the attribute category.
5. The project, task and element are outer joined, so payroll and project lines are both returned.
6. A detail is marked as transferred when a successful retrieval transaction exists for its building block.

## Parameters & Filtering
*   **Upload Mode:** selects create with an empty template, or create and update with existing timecards downloaded.
*   **Employee:** limits the download to one employee.
*   **Period Start Date From** and **Period Start Date To:** bound the start date of the timecard periods.
*   **Approval Status:** limits the timecards to one approval status.
*   **Organization:** limits the employees to those whose primary assignment is in the organization at the start of the period.

## Performance & Optimization
*   The day and detail building blocks are selected by scope and by an open-ended date, so only current versions of each building block are read.
*   The transfer check is an EXISTS test on the deposit history, so it returns one answer for each detail without a separate join.
*   Attribute values are read only for the project and element classifications, which reduces the rows read from the attribute tables.

## FAQ
**Q: How do I resubmit a rejected timecard?**
A: Download the timecard, correct the lines, and set Submit to Yes on any row of that timecard. Upload with Create, Update.

**Q: Why can I not change a timecard?**
A: Timecards already transferred to Projects, Payroll or Purchasing are protected, and the upload cannot modify them.

**Q: Which responsibility should run the upload?**
A: Run it under a responsibility whose operating unit matches the projects being charged, such as the OTL or Projects responsibility that the employees use.
