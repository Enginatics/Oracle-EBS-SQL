# Case Study & Technical Analysis: PER Employee Length of Service

## Executive Summary
The PER Employee Length of Service report lists the active employees of an Oracle HRMS business group with their calculated length of service in years and months. It is based on the adjusted service date, or the original hire date when no adjusted date is set, and it shows the milestone years, the next service anniversary, the age and the current assignment. Human resources teams use it for recognition programs, for benefits and leave eligibility that depend on tenure, and for workforce tenure analysis. The report runs in Excel through Blitz Report, where the rows can be sorted and filtered further.

## Business Challenge
*   **Recognition programs:** Service awards are given at fixed milestone years, and HR needs the list of employees who reach each milestone.
*   **Benefit eligibility:** Entitlements such as leave accrual or pension vesting depend on service years, and the adjusted service date must be used rather than the hire date when a prior service adjustment exists.
*   **Workforce planning:** Tenure distribution by organization, location and grade shows where experience is concentrated and where succession risk sits.
*   **Accurate dates:** A service calculation that ignores a break in service or an adjusted date gives the wrong entitlement, so the report starts from the periods of service.

## The Solution
*   Calculates service years and service months from the adjusted service date, or the original date of hire where no adjustment is recorded.
*   Shows the milestone years, which are the completed service years that are multiples of five, and the next service anniversary date.
*   Shows the age from the date of birth, the hire date and the adjusted service date.
*   Shows the current assignment: organization, job, position, grade, location, supervisor and assignment status, with the employment category.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ALL_PEOPLE_F`: the employee record, with the employee number, name, date of birth, sex and original date of hire.
*   `PER_PERIODS_OF_SERVICE`: the period of service, with the adjusted service date and the actual termination date.
*   `PER_ALL_ASSIGNMENTS_F`: the primary employee assignment, with its organization, job, position, grade, location, supervisor and status.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the user status of the assignment.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the assignment organization.
*   `PER_JOBS_VL`, `HR_ALL_POSITIONS_F_TL`, `PER_GRADES_VL` and `HR_LOCATIONS_ALL`: the job, position, grade and location names.

### Logical Relationships
1.  `PER_ALL_PEOPLE_F` is restricted to the rows valid today, and joined to `PER_PERIODS_OF_SERVICE` on the person id, where the actual termination date is empty.
2.  `PER_ALL_ASSIGNMENTS_F` is restricted to the rows valid today, and the primary assignment of type E is taken for each person.
3.  The business group comes from `HR_ALL_ORGANIZATION_UNITS_VL` on the person's business group id, and the assignment organization from a second organization join.
4.  The supervisor is an outer join to a second copy of the people view valid today, and the job, position, grade and location are outer joins to their reference views.
5.  Service years and months are computed from the months between the current date and the adjusted or hire date.

## Parameters & Filtering
*   **Business Group:** the business group whose employees are listed.
*   **Organization:** limits the employees to one assignment organization.
*   **Minimum Service Years:** keeps the employees whose service years are at least the value entered.
*   **Location:** limits the employees to one work location.

## Performance & Optimization
*   The people and assignment tables are filtered to their current effective rows in inline views, so each person has one row for the current date.
*   The supervisor is read through a second copy of the current people view, joined by an outer join, so it does not add rows for employees without a supervisor.
*   The service calculation is performed once in the select list, and the ordering reuses the same expression, so the sort does not change the result.
*   Business Group and Organization are the most selective parameters, and should be set on a large workforce.

## FAQ
**Q: How is length of service calculated?**
A: Service years are the whole number of years between the adjusted service date, or the original hire date if none is set, and today. Service months are the remaining months.

**Q: Which employees are listed?**
A: Active employees with a primary employee assignment of type E and no actual termination date on their period of service.

**Q: How is the milestone year determined?**
A: A milestone year is shown when the service years are a multiple of five and greater than zero. Otherwise the column is blank.
