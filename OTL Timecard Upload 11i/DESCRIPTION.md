# Case Study & Technical Analysis: OTL Timecard Upload 11i

## Executive Summary
The OTL Timecard Upload 11i report creates, updates and deletes Oracle Time and Labor (OTL, also known as HXC) timecards from a spreadsheet. It uses the public TimeStore deposit API, so the timecards follow the same rules as self-service time entry. It is an Excel-based alternative for timekeepers and payroll or projects administrators who must enter or correct timecards for many employees, and it supports both project charging and payroll element hours. Each row is one timecard line for one day, and the upload groups lines into timecards by employee and timecard period.

## Business Challenge
*   **Bulk time entry:** Timekeepers entering corrections or late time for many employees cannot do it efficiently in self-service screens one timecard at a time.
*   **Project charging accuracy:** Hours charged to projects must reference a valid project, task and expenditure type under the right operating unit, and errors are costly to correct later.
*   **Approval control:** Timecards must be saved, submitted and routed for approval in a controlled way, and resubmission after a change needs to happen automatically.
*   **Protected records:** Timecards already transferred to Projects, Payroll or Purchasing must not be changed, and users need to see which timecards are protected before they try.

## The Solution
*   **Row per day and classification:** Each row carries the employee, date, classification and hours. Rows of the same employee and period are deposited as one timecard.
*   **Project or payroll classification:** A line is either a project line, with project, task and expenditure type, or a payroll line, with an hours type that is a payroll element.
*   **Save or submit per row:** Leaving Submit blank saves the timecard in Working status, and setting Submit to Yes on any row starts the approval workflow for the timecard.
*   **Update and delete handling:** Downloaded lines carry the building block IDs needed to update through the deposit API, and deleting every line of a timecard removes the timecard.

## Technical Architecture (High Level)
### Primary Tables
*   `HXC_TIMECARD_SUMMARY`: the timecard header, with its approval status, submission date, start time and resource.
*   `HXC_TIME_BUILDING_BLOCKS`: the timecard, day and detail building blocks that hold the time entries.
*   `HXC_TIME_ATTRIBUTE_USAGES` and `HXC_TIME_ATTRIBUTES`: the attributes attached to each detail, which carry the project, task, expenditure type or element.
*   `HXC_TRANSACTIONS` and `HXC_TRANSACTION_DETAILS`: the transfer history, used to flag timecards already transferred.
*   `PER_ALL_PEOPLE_F`: the employee, with name and employee number, effective on the timecard start date.
*   `PAY_ELEMENT_TYPES_F`: the payroll element name for payroll lines.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task of project lines.

### Logical Relationships
1.  `HXC_TIMECARD_SUMMARY` is joined to the employee in `PER_ALL_PEOPLE_F` on the resource ID, with the employee record effective on the timecard start date.
2.  The day building block is joined to the timecard on the timecard ID and version, and restricted to the day scope and an open-ended date.
3.  The detail building block is joined to the day building block, restricted to the detail scope.
4.  Attribute usages link the detail to its attributes. Only PROJECTS and element attribute categories are kept.
5.  Project and task are outer joined from the PROJECTS attribute values, and the payroll element name is looked up by the element type ID and the day's date.
6.  A subquery checks the transfer history, so a timecard with a successful retrieval transaction is flagged as transferred.

## Parameters & Filtering
*   **Upload Mode:** Create returns an empty template, and Create, Update downloads existing timecards for review, correction or deletion.
*   **Employee:** Limits the download to one employee.
*   **Period Start Date From and Period Start Date To:** Restrict the timecards to a range of period start dates.
*   **Approval Status:** Limits the download to timecards in one approval status.
*   **Organization:** Restricts the download to employees whose primary assignment belongs to the organization at the start of the timecard period.

## Performance & Optimization
*   **Scope-specific joins:** The day and detail scopes are filtered on their scope values and open-ended dates, so only current building blocks are read.
*   **Attribute category filter:** Only PROJECTS and element attribute categories are joined, so other attributes do not multiply the rows.
*   **Transfer check as a subquery:** Transfer status is tested with an EXISTS subquery, so each detail is checked once and the main rows are not multiplied.

## FAQ
**Q: How do I submit a timecard for approval through the upload?**
A: Set Submit to Yes on any row of the timecard. The OTL approval workflow then starts for the timecard.
**Q: What happens if I change a timecard that is already approved?**
A: The upload resubmits it for approval automatically, and the update creates a new timecard version that re-routes approval.
**Q: Why can I not change some downloaded timecards?**
A: Timecards already transferred to Projects, Payroll or Purchasing are protected, and the report flags them as transferred.
