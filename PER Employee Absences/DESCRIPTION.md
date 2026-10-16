# Case Study & Technical Analysis: PER Employee Absences

## Executive Summary
This report lists employee absence and attendance records in Oracle HRMS, showing absence type and category, start and end dates, duration in days and hours, reason, authorizing and replacement persons, and approval status. It is used by HR operations and line managers for leave management, absence tracking and compliance reporting. Each record is placed with the employee's current job, position, location and organization, so absences can be analyzed by where people work. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Leave balance and tracking:** HR needs a complete list of absences by type and period to manage leave and entitlements.
*   **Approval control:** Absences awaiting approval must be visible, and the authorizing person must be identifiable.
*   **Coverage planning:** Managers need to know who is covering a role during an absence.
*   **Compliance reporting:** Statutory and internal reports require absence duration, category and reason for each employee.

## The Solution
*   **Duration in days and hours:** Each absence shows its days and hours, together with its start and end times where recorded.
*   **Category and type:** The absence type name and its category, such as sickness or leave, are returned with their meanings.
*   **Approval status:** The approval status of each absence is shown as a readable meaning.
*   **People and cover:** The authorizing person and the replacement person are returned for each absence.
*   **Current employment context:** The job, position, location and organization are taken from the employee's primary assignment as at the run date.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ABSENCE_ATTENDANCES`: the absence or attendance record, with dates, duration, notification, projected dates, approval status and the authorizing and replacement person ids.
*   `PER_ABSENCE_ATTENDANCE_TYPES`: the absence type and its category.
*   `PER_ABS_ATTENDANCE_REASONS`: the reason for the absence.
*   `PER_ALL_PEOPLE_F`: the employee, the authorizing person and the replacement person, each restricted to the current date.
*   `PER_ALL_ASSIGNMENTS_F`: the primary assignment, restricted to the current date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the organization.
*   `PER_JOBS_VL`: the job name.
*   `HR_ALL_POSITIONS_F_TL`: the position name.
*   `HR_LOCATIONS_ALL`: the location code.

### Logical Relationships
1. `PER_ABSENCE_ATTENDANCES` joins to the employee's current `PER_ALL_PEOPLE_F` row on person id, and to the business group through that row.
2. The absence type joins on the absence attendance type id, and the reason joins as an outer join on the reason id.
3. The authorizing and replacement persons join to `PER_ALL_PEOPLE_F` as outer joins, each on its own person id.
4. The employee's primary assignment joins on person id, restricted to the primary flag and the employee assignment type.
5. The assignment reaches the organization, job, position and location through their identifiers, all as outer joins.

## Parameters & Filtering
*   **Business Group:** restricts the employees to one business group.
*   **Person Full Name:** selects one employee.
*   **Absence Type:** restricts the records to one absence type.
*   **Absence Date From and Absence Date To:** bound the absences by date.
*   **Organization:** restricts the employees to one organization.

## Performance & Optimization
*   The people and assignment views are restricted to the current date in inline views, so each employee is matched to one current row.
*   Position and language joins are restricted to the session language, so each position name is returned once.
*   The authorizing and replacement person joins are outer joins, so absences without a cover person are still listed.

## FAQ
**Q: Why does an absence show a blank job or position?**
A: The job, position and location are taken from the employee's primary assignment. A record without that assignment shows blank values.

**Q: How are the approver and cover fields filled?**
A: The authorizing person and the replacement person are the people recorded on the absence. They are blank when they were not recorded.

**Q: How do I see absences for one period?**
A: Set Absence Date From and Absence Date To to the period. The rows are ordered by business group, employee name and absence start date.
