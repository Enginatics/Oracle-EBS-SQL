# PER Employee Assignments - Case Study

## Executive Summary
The **PER Employee Assignments** report is a comprehensive Human Resources (HR) master data extract. It provides a detailed snapshot of the workforce, combining personal demographic information with employment assignment details. This report is the backbone for HR reporting, headcount analysis, and integration with third-party payroll or benefits systems. It allows HR managers and administrators to view the complete profile of an employee—who they are, where they work, what they do, and how they are compensated—in a single, flattened view.

## Business Challenge
Oracle HRMS is a highly normalized and "date-tracked" system. Information about a single employee is split across dozens of tables (People, Assignments, Jobs, Positions, Grades, Locations, etc.). Furthermore, the system maintains a full history of changes.
*   **Complexity:** Querying "active employees" is not simple; one must account for effective dates, assignment statuses (Active, Suspended, Terminated), and person types (Employee, Contractor).
*   **Data Fragmentation:** A manager might need to see an employee's email (Person table), Job Title (Job table), Department (Organization table), and Location (Location table) simultaneously.
*   **Historical Reporting:** Businesses often need to know "Who reported to Manager X on December 31st last year?" rather than just current data.

## Solution
The **PER Employee Assignments** report solves these challenges by joining the disparate HR tables into a cohesive dataset. It handles the date-tracking logic to ensure that data is accurate *as of* the requested effective date.

**Key Features:**
*   **Holistic View:** Combines Person data (Name, SSN, DOB, Nationality) with Assignment data (Job, Position, Grade, Organization, Location).
*   **Date-Effective Reporting:** Users can specify an "Effective Date" to see the workforce status at any point in time (past, present, or future).
*   **Flexible Filtering:** Supports filtering by Person Name, Employee Number, Organization, Business Group, or Person Type.
*   **Profile Information:** Can include additional profile details stored in Flexfields.

## Technical Architecture
The report navigates the complex Oracle HRMS schema, specifically focusing on "Date Tracked" tables.

**Primary Tables:**
*   `per_all_people_f`: Stores personal details. The `_f` suffix indicates it is a date-tracked table (contains `effective_start_date` and `effective_end_date`).
*   `per_all_assignments_f`: Stores employment details (link to Job, Position, Organization). Also date-tracked.
*   `per_jobs_vl` / `per_all_positions`: Definitions of Jobs and Positions.
*   `hr_all_organization_units_vl`: Definitions of Departments/Organizations.
*   `per_assignment_status_types`: Defines if an assignment is "Active", "Suspend", "Terminate", etc.

**Key Logic:**
*   **Date Tracking:** The query typically includes a `WHERE` clause like `:p_effective_date BETWEEN effective_start_date AND effective_end_date` to retrieve the correct version of the record.
*   **Outer Joins:** Used extensively (e.g., for Supervisors, Grades, or Locations) to ensure that employees are listed even if some optional fields are missing.

## Frequently Asked Questions

**Q: What does "Effective Date" mean?**
A: In Oracle HR, every change (e.g., a promotion) creates a new row in the database with a start and end date. The "Effective Date" parameter tells the report which of these rows to retrieve. If you run the report for last year, you will see the employee's job title *as it was last year*.

**Q: Why do I see multiple rows for the same person?**
A: This can happen if an employee has multiple assignments (e.g., a primary job and a secondary role) or if the report is not correctly filtering by effective date (though this report is designed to handle that).

**Q: Does this report include Contingent Workers (Contractors)?**
A: Yes, the report typically filters by "Person Type." You can select Employees, Contingent Workers, or both, depending on the parameters used.

**Q: Can I see terminated employees?**
A: Yes. If you set the Effective Date to a date *after* their termination, their assignment status will reflect "Terminated" (or they might be excluded depending on the specific filter logic for "Active" assignments). To see them as active, you would set the Effective Date to a time *before* they left.
