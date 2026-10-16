# Case Study & Technical Analysis: AP Distribution Set Upload

## Executive Summary
The AP Distribution Set Upload report is a spreadsheet-based maintenance tool for Oracle Payables distribution sets. It is the Excel equivalent of the Distribution Sets form (Setup > Invoice > Distribution Sets). Accounts payable setup teams use it to create new distribution sets, change their lines and percentages, and retire sets by entering an inactive date, without keying each set through the form one line at a time. Because it is an upload, the same file carries the header and line data for many sets, which makes it practical for initial setup of a new operating unit or for a large clean-up of allocation rules.

## Business Challenge
*   **Form-by-form keying:** Each distribution set must be built line by line in the Distribution Sets form, which is slow when an organization maintains dozens of allocation sets.
*   **Percentage integrity:** A distribution set only works when its line percentages total 100 (Full) or 0 (Skeleton). Errors are easy to make when lines are typed one at a time.
*   **Set lifecycle:** A distribution set cannot be deleted in the form. Teams need a controlled way to stop using a set while keeping its history.

## The Solution
*   **One row per line:** Each row is one distribution set line, and the header columns (set name, description, set type, inactive date, attribute values) repeat on every line. The header values are read from the first row of each set.
*   **Whole-set validation:** Each set is processed as a unit. The percentages of all its lines, including existing lines not in the file, must total 100 or 0, otherwise none of its rows are saved.
*   **Line deletion and retirement:** Setting Delete Line to Yes removes a single line. Entering an Inactive On date retires the set, mirroring the form, since the set itself is never deleted.
*   **Projects account generation:** For project-related lines the account is derived by the Projects account generator, so the upload produces the same accounting result as the form.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_DISTRIBUTION_SETS_ALL`: the distribution set header, including the set name, total percent distribution, inactive date and the set-level descriptive flexfield attributes.
*   `AP_DISTRIBUTION_SET_LINES_ALL`: the lines of each set, with line number, percentage, distribution code combination, project, task, expenditure details and line-level attributes.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield combination that holds the account string and its description.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task referenced by project-related lines.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the set and the expenditure organization of each line.
*   `AP_LOOKUP_CODES`: translated labels for the set type, derived from the total percent distribution.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the current user is allowed to see.

### Logical Relationships
1.  The header table `AP_DISTRIBUTION_SETS_ALL` is restricted to operating units in `MO_GLOB_ORG_ACCESS_TMP` and joined to its operating unit in `HR_ALL_ORGANIZATION_UNITS_VL`.
2.  Each header is outer joined to its lines in `AP_DISTRIBUTION_SET_LINES_ALL` on the distribution set ID, so sets without lines still appear.
3.  Each line is outer joined to `GL_CODE_COMBINATIONS_KFV` for the account, to `PA_PROJECTS_ALL` and `PA_TASKS` for project data, and to `HR_ALL_ORGANIZATION_UNITS_VL` for the expenditure organization.
4.  The set type label is looked up in `AP_LOOKUP_CODES` using the set's total percent distribution.

## Parameters & Filtering
*   **Upload Mode:** Selects the Full or Skeleton rule, which decides whether the lines of each set must total 100 or 0 percent.
*   **Operating Unit:** Limits the sets to one operating unit, which is where each distribution set is owned.
*   **Distribution Set:** Narrows the extract to a named set, so one set can be reviewed or re-uploaded.

## Performance & Optimization
*   **Access-restricted driving rows:** The main filter is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so only operating units granted to the user drive the extract.
*   **Outer joins to optional data:** Lines, projects, tasks and expenditure organizations are outer joined, so header-only sets and non-project lines are returned without separate passes.
*   **Flexfield display functions:** Descriptive flexfield values are resolved through `xxen_util` display functions, which keeps the SELECT list readable but adds per-row function calls on wide sets.

## FAQ
**Q: How do I add a new line to an existing AP distribution set without changing the others?**
A: Enter a row with the set name and a new Line Number, and the line percentages must still total 100 or 0 across all lines of the set, including the existing ones.

**Q: Why was my whole distribution set rejected when only one line had an error?**
A: Each set is processed as a whole, so if any line of the set fails validation, none of its rows are saved.

**Q: Can I delete a distribution set with this upload?**
A: No. As in the Distribution Sets form, a set cannot be deleted; enter an Inactive On date to retire it, and set Delete Line to Yes only to remove individual lines.
