# Case Study & Technical Analysis: FND User Preferences

## Executive Summary
This report lists the user preferences stored in the Application Object Library, one row per user, module and preference name, with the value each user has set. System administrators and support analysts use it to see what preference values users hold and to compare them across accounts when a user reports that a screen or default behaves differently from others. It runs in Excel through Blitz Report™ and can be limited to one user, one module or one preference name.

## Business Challenge
*   **Support investigations:** When a user reports an unexpected default or display setting, the support team needs to see the stored preference rather than rely on the user's description.
*   **Comparing accounts:** Differences between two users with the same role are easiest to explain when their preference values can be listed side by side.
*   **Module-level review:** Preferences are kept per module, so an administrator reviewing one application needs the values for that module only.
*   **Clean-up:** Obsolete preference names and values can be identified once they are listed by user and module.

## The Solution
*   Returns the user name, module name, preference name and preference value for every stored preference.
*   Sorts the output by user name, module name and preference name, so that all the preferences of one user appear together.
*   Lets the user name, module name and preference name be entered as filters, so the list can be focused on one person, one module or one setting.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_USER_PREFERENCES`: the table that stores each preference as a row with the user name, module name, preference name and preference value.

### Logical Relationships
1.  The report reads a single table, so there are no joins and no derived columns.
2.  Each row is one preference of one user for one module, identified by the preference name.
3.  The output is ordered by user name, then module name, then preference name.

## Parameters & Filtering
*   **User Name:** lists the preferences of one user.
*   **Module Name:** lists the preferences stored for one module.
*   **Preference Name:** lists one named preference across users and modules.

## Performance & Optimization
*   With a single table and no joins, the report's cost depends only on how many preference rows match the filters.
*   Filtering on user name or module name before the sort keeps the sorted set small, which matters for systems where many users have stored preferences.
*   The report returns the stored values as they are and performs no conversion, so the results match the table exactly.

## FAQ
**Q: Which table holds the user preferences in the Application Object Library?**
A: The report reads the `FND_USER_PREFERENCES` table, which holds one row for each preference of each user in each module.

**Q: How do I see the preferences of one user for one module?**
A: Enter the user name in User Name and the module name in Module Name, and the report returns the preference names and values stored for that combination.

**Q: Are the preference values converted to readable text?**
A: No, the report shows the preference value exactly as it is stored in the table.
