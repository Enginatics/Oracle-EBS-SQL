# Case Study & Technical Analysis: FND Menus

## Executive Summary
FND Menus lists every Oracle E-Business Suite menu from the Application Object Library, with its type, its description, the number of responsibilities that reference it and the number of those responsibilities that are still active. It is written for EBS security administrators, functional leads and technical consultants who need to understand which navigation menus are in use, which menu sits behind a responsibility, and which menus can be retired. The output supports menu rationalization projects and access reviews before a responsibility is changed.

## Business Challenge
*   **Menu Sprawl:** Long-running instances accumulate menus that were created for projects and are no longer attached to any responsibility.
*   **Responsibility Mapping:** When a user reports a missing function, the administrator must find the menu behind the responsibility and check its contents.
*   **Usage Insight:** Teams need to know which menus are widely shared, because changing a heavily used menu affects many users.
*   **Active Versus Expired Access:** Responsibilities with an end date still reference their menu, and these must be separated from live usage.

## The Solution
*   **Usage Counts:** Each menu shows the total number of responsibilities that point to it and the number that have not passed their end date.
*   **Zero Suppression:** The count columns return blank rather than zero for unused menus, so unused menus are easy to spot.
*   **Responsibility Lookup:** A parameter finds the menu attached to a named responsibility, which answers the question directly.
*   **Usage Ordering:** Results are sorted by responsibility count, so the most widely used menus appear first.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_MENUS_VL`: the menu definitions, with the user menu name, menu name, menu type, description and the creation and update audit columns.
*   `FND_RESPONSIBILITY`: the responsibilities, each of which references one menu and has a start and an end date.

### Logical Relationships
1.  The responsibilities are summarized in an inline view that groups `FND_RESPONSIBILITY` by menu identifier.
2.  Within that view, one count returns all responsibilities and a second count returns those whose end date is empty or later than the current date.
3.  The inline view is outer joined to `FND_MENUS_VL` on the menu identifier, so menus with no responsibilities are kept.
4.  The menu type, creator and last updater are resolved through the Blitz Report™ meaning, user name and client time functions.
5.  Rows are ordered by the responsibility count in descending order, then by user menu name.

## Parameters & Filtering
*   **User Menu Name:** Filters the menus by their translated display name.
*   **Menu Name:** Filters the menus by their internal name.
*   **Menu Type:** Restricts the output to one menu type code.
*   **Assigned To Responsibility:** Returns only the menu that is attached to the named responsibility.
*   **Menus With Responsibilities Only:** When set, excludes menus that no responsibility references.

## Performance & Optimization
*   **Pre-Aggregated Responsibilities:** Counting is done once per menu in the inline view, so the responsibility table is scanned a single time.
*   **Outer Join to the Menu View:** The aggregated counts are joined to the menu list, which keeps every menu in the result when required.
*   **Simple Ordering Key:** The sort uses the count with nulls treated as zero, so unused menus fall to the bottom without extra processing.

## FAQ
**Q: How do I find the menu behind a responsibility?**
A: Enter the responsibility name in the Assigned To Responsibility parameter. The matching menu is returned with its counts.

**Q: What is the difference between Responsibility Count and Active Responsibility Count?**
A: Responsibility Count includes every responsibility that references the menu. Active Responsibility Count excludes responsibilities whose end date has passed.

**Q: How can I list only menus that are in use?**
A: Set Menus With Responsibilities Only to Yes, and only menus referenced by at least one responsibility are returned.
