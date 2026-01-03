# Case Study & Technical Analysis: PER Employee Grade Changes Report

## Executive Summary

The PER Employee Grade Changes report is a vital Human Resources audit and analysis tool that provides a historical record of all grade changes for employees within Oracle HR. It lists employees, their previous and new grades, and the effective dates of these changes. This report is essential for HR managers, compensation analysts, and auditors to track employee career progression, ensure fairness and consistency in grading decisions, and maintain accurate historical compensation records for compliance and internal analysis.

## Business Challenge

Employee grading is a fundamental aspect of compensation and career management. Tracking grade changes, especially in dynamic organizations, can present several challenges:

-   **Lack of Historical Visibility:** While current grade information is readily available, obtaining a consolidated historical view of all grade changes for an employee or across the organization is difficult with standard Oracle forms.
-   **Auditing Compensation Decisions:** HR and compensation teams need to audit grade changes to ensure adherence to company policies, pay equity, and regulatory compliance. Manual auditing is time-consuming and prone to human error.
-   **Impact of Grade on Pay:** Grade changes often correlate with salary adjustments. Analyzing the history of grade changes helps understand an employee's career trajectory and the factors influencing their compensation over time.
-   **Workforce Planning:** Understanding grade progression patterns can inform workforce planning, talent development initiatives, and succession planning by identifying typical career paths within the organization.

## The Solution

This report offers a clear, date-effective, and auditable solution for monitoring and analyzing employee grade changes, transforming how HR manages career progression data.

-   **Comprehensive Grade History:** It provides a detailed chronological list of all grade changes for employees, including the effective dates, allowing for precise historical analysis of career progression.
-   **Simplified Audit Trail:** The report serves as an excellent audit trail, providing objective data on grade changes that can be used to validate compensation decisions and ensure compliance with internal and external regulations.
-   **Supports Compensation Analysis:** Compensation analysts can use this report to analyze the frequency of grade changes, the movement of employees between grades, and the impact of these changes on the overall pay structure.
-   **Enhanced Workforce Insight:** By identifying patterns in grade changes, HR managers can gain valuable insights into talent development, promotional velocity, and the effectiveness of career pathing programs.

## Technical Architecture (High Level)

The report queries Oracle HR's date-effective assignment and grade tables to extract historical grade change information.

-   **Primary Tables Involved:**
    -   `per_all_people_f` (for core employee demographic data).
    -   `per_all_assignments_f` (the central date-effective table for employee assignment details, including grade ID).
    -   `per_grades` (for grade names and descriptions).
    -   `per_business_groups` (for organizational context).
    -   `per_jobs` and `per_all_positions` (for job and position details associated with the assignment).
-   **Logical Relationships:** The report leverages the date-effective nature of `per_all_assignments_f`. By querying this table and comparing the `grade_id` for an assignment across different effective dates, it identifies instances where an employee's grade has changed. It then joins to `per_grades` to retrieve the user-friendly names of the old and new grades.

## Parameters & Filtering

The report includes flexible parameters for targeted analysis of grade changes:

-   **Effective Date:** This crucial parameter allows users to specify a point in time to view grade changes up to or on that date. It is key for historical accuracy.
-   **Business Group:** Filters the report to a specific legal entity or organizational grouping, allowing for focused analysis within different parts of the enterprise.
-   **Employee Filters:** Although not explicitly listed in the `README.md` as parameters, such a report typically allows filtering by employee name or number to drill down into individual career histories.

## Performance & Optimization

As a master data report dealing with date-effective tables, it is optimized for efficient historical data retrieval.

-   **Date-Effective Table Querying:** The core tables (`_F` tables) are designed and indexed by Oracle to efficiently retrieve historical versions of records based on the `Effective Date`, ensuring fast performance even when analyzing changes over long periods.
-   **Primary Key Joins:** The queries utilize primary keys (`assignment_id`, `grade_id`) for optimal join performance across the HR tables.

## FAQ

**1. How does this report identify a 'grade change'?**
   The report identifies a grade change by comparing the employee's assigned `grade_id` on consecutive date-effective records within the `per_all_assignments_f` table. If the `grade_id` differs between two consecutive periods for the same assignment, it indicates a grade change.

**2. Can this report also show the reason for a grade change?**
   While this report shows the change itself, the direct reason for a grade change is often captured in specific HR actions or custom descriptive flexfields within the assignment record. The report could be extended to include such details if they are consistently recorded in the system.

**3. How is this report different from the 'PER Employee Salary Change' report?**
   This report focuses specifically on changes to an employee's *grade*, which is a classification of a job's complexity or level. The 'PER Employee Salary Change' report, while related, focuses on the monetary changes to an employee's *salary*. While a grade change often leads to a salary change, they are distinct pieces of information.
