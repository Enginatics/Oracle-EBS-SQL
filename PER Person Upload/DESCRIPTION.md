# Case Study & Technical Analysis: PER Person Upload

## Executive Summary
The PER Person Upload is a Blitz Report upload that creates and updates people in Oracle Human Resources, using the People window of the Combined Person and Assignment form. It covers employees, contingent workers and applicants, with their personal details, national identifier, contact data and the Further Person Information and Additional Personal Details flexfields. HR administrators use it to load new hires, maintain personal records across many people, and record terminations and rehires. The upload applies the same HR person APIs as the form, so each change is validated and dated as it would be in the application. The workflow runs in Excel through Blitz Report.

## Business Challenge
*   **High-volume onboarding:** New employees, contingent workers and applicants must be created with the right person type and start date before payroll and assignments can be set up.
*   **Personal data maintenance:** Names, addresses, nationality, marital status and contact details change over time, and each change must be effective on a specific date.
*   **Termination and rehire:** Leavers must be terminated with a final process date and a reason, and former staff who return must be rehired without losing their history.
*   **Identifier accuracy:** People must be matched correctly, by person ID or by the employee, contingent worker or applicant number that applies to their person type.

## The Solution
*   **Person type driven APIs:** New people are created through the employee, contingent worker or applicant API, depending on the system type of the chosen person type.
*   **Datetrack handling:** Changes are dated by the Effective Date. A correction is applied if the effective date is the record start date, and otherwise a new change is inserted from that date.
*   **Termination mapping:** An entered termination date terminates an employee with an optional final process date, or ends a contingent worker placement.
*   **Rehire rule:** Changing the person type of an ex-employee to an employee type rehires the employee on the latest start date.

## Technical Architecture (High Level)
### Primary Tables
*   `PER_ALL_PEOPLE_F`: the person record, with name, identifiers, personal details, contact details and the person flexfield values, dated by effective start and end dates.
*   `PER_BUSINESS_GROUPS`: the business group that owns the person.
*   `PER_PERSON_TYPE_USAGES_F`: the person type assigned to the person over time.
*   `PER_PERSON_TYPES` and `PER_PERSON_TYPES_TL`: the person type system code and its user name.
*   `PER_PERIODS_OF_SERVICE`: the employee service period, with the start, actual termination and final process dates.
*   `PER_PERIODS_OF_PLACEMENT`: the contingent worker placement period.
*   `FND_TERRITORIES_VL`: the country of birth name.
*   `FND_LANGUAGES_VL`: the correspondence language name.

### Logical Relationships
1.  `PER_BUSINESS_GROUPS` joins to `PER_ALL_PEOPLE_F` on the business group ID, and the person is taken as at the effective date.
2.  The person joins to an inline view that selects one person type usage per person, ranking employee, contingent worker, applicant and former types by a `DECODE` order with `KEEP (DENSE_RANK FIRST)`.
3.  That person type joins to `PER_PERSON_TYPES_TL` in the user's language, which supplies the person type name shown in the upload.
4.  The latest start date and termination details come from the most recent service period and the most recent placement period, each selected with `ROW_NUMBER` on the start date.
5.  The person number is chosen by person type, using the NPW number for contingent workers, the applicant number for applicants and the employee number otherwise.

## Parameters & Filtering
*   **Upload Mode:** selects the download or the create and update action.
*   **Business Group:** the business group whose people are reported.
*   **Effective Date:** the date at which the person records are read and the changes are dated.
*   **Person Type:** restricts the output to one person type.
*   **Person Number:** selects one person by employee, contingent worker or applicant number.
*   **Full Name like:** filters on part of the full name.
*   **Organization:** limits the output to people in one organization.

## Performance & Optimization
*   The person type inline view is grouped by person ID, so each person contributes one row before the main join.
*   The service and placement period inline views are filtered by business group and start date before the `ROW_NUMBER` ranking, which limits the rows that are ranked.
*   Country and language names are scalar lookups on primary codes, so no join multiplies the person rows.
*   Flexfield values are displayed through the `XXEN_UTIL` helpers, which keeps the main query to one pass over the person table.

## FAQ
**Q: How is an existing person matched when the file is uploaded?**
A: Downloaded rows carry a hidden person ID that is used for matching. Otherwise the person is matched by the person number that applies to the person type.

**Q: What does entering a termination date do?**
A: It terminates an employee, with the final process date if one is entered, or ends a contingent worker placement.

**Q: Where are assignment details maintained?**
A: The description states that assignment details are uploaded with the PER Person Assignment Upload report.
