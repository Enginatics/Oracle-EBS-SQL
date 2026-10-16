# Case Study & Technical Analysis: PA Project Upload

## Executive Summary
The PA Project Upload is a Blitz Report upload that creates and updates projects in Oracle Projects. It covers project identifiers, dates, billing setup, currency and burden schedules, cross-charge and transfer price settings, work types, calendars, role lists, job groups and flexfield attributes. Project accountants and project managers use it to set up new projects from a template in bulk, and to maintain existing projects such as their dates, project manager and billing flags. The upload calls the Oracle project public API, so the validations of the Projects forms apply to every row. The workflow runs in Excel through Blitz Report.

## Business Challenge
*   **Bulk project setup:** New projects are often created in batches from a standard template, and each one needs many interdependent billing and accounting fields.
*   **Project manager changes:** When a project manager changes, the current assignment must be closed and the new one started, without losing the history of the project.
*   **Consistent billing setup:** Labor and non-labor schedules, bill rate schedules, burden schedules and currency settings must be applied consistently across projects of the same type.
*   **Controlled updates:** Only the fields that change should be sent to the system, so that unchanged values are not overwritten by a spreadsheet re-upload.

## The Solution
*   **Template-driven creation:** A template project supplies default values such as project type, organization and billing setup, and the template project manager can be replaced after creation.
*   **Changed-field updates:** Using the Create, Update upload mode, the project is downloaded with its current values, and only modified fields are sent back.
*   **Manager assignment rules:** A project manager change end-dates the current active manager assignment and assigns the new manager from the current date, or simply assigns the new manager when no active one exists.
*   **Creation-only fields:** Customer and PM product code are set when the project is created and are not changed by a later update.

## Technical Architecture (High Level)
### Primary Tables
*   `PA_PROJECTS_ALL`: the project header, with number, name, long name, dates, type, status, currencies, billing and burden schedule references and flags.
*   `PA_PROJECT_STATUSES`: the project status, restricted to status type PROJECT.
*   `PA_PROJECT_PARTIES`: the project role assignments, including the project manager.
*   `PER_ALL_PEOPLE_F`: the project manager's name.
*   `PA_PROJECT_CUSTOMERS`, `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer linked to the project.
*   `PA_STD_BILL_RATE_SCHEDULES_ALL` and `PA_IND_RATE_SCHEDULES_ALL_BG`: the standard bill rate schedules and the individual rate schedules used for revenue, invoice and capital interest.
*   `PA_CC_TP_SCHEDULES_BG`: the cross-charge transfer price schedules.
*   `PA_DISTRIBUTION_RULES`, `PA_WORK_TYPES_VL`, `PA_ROLE_LISTS`, `PA_PROBABILITY_MEMBERS` and `PA_INVOICE_FORMATS`: the distribution rule, work type, role list, probability and invoice format.
*   `GL_DAILY_CONVERSION_TYPES`: the currency conversion types for project, functional and billing rates.
*   `JTF_CALENDARS_VL`, `HR_LOCATIONS_ALL` and `PER_JOB_GROUPS_V`: the calendar, location and job groups.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit, carrying-out organization and accessible organizations.

### Logical Relationships
1.  `PA_PROJECTS_ALL` joins to `PA_PROJECT_STATUSES` on the status code, and to the operating unit and carrying-out organization in `HR_ALL_ORGANIZATION_UNITS_VL`.
2.  The project manager is found by joining `PA_PROJECT_PARTIES` with role type 1 and an active end date, then `PER_ALL_PEOPLE_F` on the resource person ID.
3.  Each currency conversion type ID joins to `GL_DAILY_CONVERSION_TYPES`, and each schedule ID joins to its bill rate or burden schedule.
4.  Work type, calendar, location, role list, probability and job group join on their identifiers as outer joins.
5.  The customer is a correlated lookup on `PA_PROJECT_CUSTOMERS`, and templates are excluded by the template flag.

## Parameters & Filtering
*   **Upload Mode:** selects the download or the create and update action.
*   **Operating Unit:** limits the projects to one organization within the accessible set.
*   **Project Number** and **Project Name:** identify the project to download or update.
*   **Project Type:** restricts the output to one project type.
*   **Project Status:** restricts the output to one project status.

## Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so only projects of accessible organizations are read.
*   The template project name is a scalar subquery on the template project ID, so each row costs one lookup.
*   Lookup meanings are produced by the `XXEN_UTIL` helpers, so the lookup tables are read through one shared function rather than repeated joins in each column.
*   Project manager and customer lookups are restricted by their active date and by `ROWNUM`, which returns one value per project.

## FAQ
**Q: What happens to the old project manager when a new one is assigned?**
A: The current active project manager assignment is end-dated, and the new manager is assigned from today. If no active manager exists, the new one is simply assigned.

**Q: Which fields can be changed after a project is created?**
A: Most fields can be changed, including dates, billing setup, flags and flexfield attributes. Customer and PM product code are set on creation only.

**Q: Why should Microsoft Project not be used as the PM product?**
A: The description states that Microsoft Project blocks date updates because of Oracle bug 12954344, so Primavera is the default PM product code.
