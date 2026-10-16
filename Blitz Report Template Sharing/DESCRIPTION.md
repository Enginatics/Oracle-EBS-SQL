# Case Study & Technical Analysis: Blitz Report Template Sharing

## Executive Summary
The Blitz Report Template Sharing report lists who each Blitz Report™ template is shared with, at Site, Responsibility or User level, and who owns it. It serves two audiences. Administrators use the default view to review sharing across the template library and to find responsibilities whose menus lack the Blitz Report function. Support staff use the user view to answer one question: which templates can this EBS user actually run, and through which access path. The report reflects the same report-access rules as the run screen, so a template is not shown as usable if its underlying report is not assigned to that user.

## Business Challenge
*   **Sharing sprawl:** Templates are created by individual users and shared to sites, responsibilities or named users, and the resulting sharing picture is hard to review in the application.
*   **Menu gaps:** A responsibility can hold shared templates while its menu is missing the Blitz Report function, so the templates cannot be opened from that responsibility.
*   **Access troubleshooting:** When a user says a template is missing, support needs to see whether the template is shared to a responsibility the user holds, shared directly, or simply owned by the user.

## The Solution
*   **Sharing register:** One row per template share, showing the sharing level, the shared-with target, the owner and the creation and update details.
*   **Responsibility context:** For responsibility shares, the report shows the application, the responsibility menu and the count of Blitz Report menu entries on that menu.
*   **User access view:** With an EBS user chosen, the report lists one row per access path, covering site shares, responsibility shares the user holds, direct user shares and ownership.
*   **Report-access filter:** In user mode, rows are kept only where the underlying report is assigned to the user through site, application, request group, responsibility or user assignments.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_TEMPLATE_SHARING_V`: the sharing records for each template, with sharing level and target identifiers.
*   `XXEN_REPORT_TEMPLATES`: the templates, with their owner and their report.
*   `XXEN_REPORTS_V`: the report catalogue, supplying report name, type and category.
*   `XXEN_REPORT_ASSIGNMENTS` and `XXEN_REPORT_ASSIGNMENT_USERS`: the report assignments and the user lists that restrict them.
*   `FND_RESPONSIBILITY`, `FND_MENUS`, `FND_APPLICATION_VL` and `FND_APPLICATION`: the responsibility, its menu and owning application.
*   `FND_FORM_FUNCTIONS`, `FND_COMPILED_MENU_FUNCTIONS` and `FND_MENU_ENTRIES`: the Blitz Report functions and their presence on a menu.
*   `FND_USER`, `FND_USER_RESP_GROUPS_DIRECT` and `FND_USER_RESP_GROUPS_INDIRECT`: the user and the responsibilities granted to the user.
*   `WF_USER_ROLE_ASSIGNMENTS`: the responsibility roles held by the user, used to find the responsibilities of the selected user.

### Logical Relationships
1.  A common table expression lists the responsibilities of the selected user, from role assignments matched to responsibilities whose menus carry the Blitz Report function.
2.  Each sharing row is joined to its template, the template's report, and the report's catalogue entry.
3.  For responsibility shares, the responsibility, its application and its menu are outer joined, and the Blitz Report menu entry count is taken from `FND_MENU_ENTRIES`.
4.  In user mode, the rows are limited to shares the user can use: site shares, responsibility shares held directly or indirectly, user shares, and templates the user owns with no share reaching them.
5.  Each row is then kept only if a matching include assignment exists and no exclude assignment applies to the user.

## Parameters & Filtering
*   **Report Name, Category and Template Name:** Narrow the register to one report, one category or one template. Choosing a report also filters the template list.
*   **Template Owner:** Lists the templates owned by one user.
*   **Sharing Level:** Limits the output to Site, Responsibility or User shares.
*   **Assigned to User:** Switches the report to user mode and lists the templates that user can use, with the access path in the Assigned To User Via column.

## Performance & Optimization
*   **Responsibility list computed once:** The user's responsibilities are gathered in a common table expression, which is referenced by the assignment checks rather than recalculated in each one.
*   **Exists-based checks:** Access and exclusion tests are written as EXISTS subqueries, so each template row stops at the first matching assignment.

## FAQ
**Q: How do I find which templates a specific user can use?**
A: Enter the user name in Assigned to User. The report lists one row per access path, and the Assigned To User Via column names the level for each row.

**Q: Why does a responsibility show a blank Blitz Report Menu Entries count?**
A: A blank count on a responsibility with a shared template means its menu has no Blitz Report menu function, and the Update Menu Entries program should be run to add it.

**Q: Can a user see a template that is shared with them if the report is not assigned to them?**
A: No. In user mode the report applies the same report-access rules as the run screen, so such a template is not listed.
