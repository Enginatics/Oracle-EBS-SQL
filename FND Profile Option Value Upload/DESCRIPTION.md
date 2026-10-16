# Case Study & Technical Analysis: FND Profile Option Value Upload

## Executive Summary
This upload creates, updates and deletes profile option values at every level that Oracle E-Business Suite supports: site, application, responsibility, user, server and operating unit. It matches the System Profile Values form, so the same levels and validations apply. System administrators and EBS technical consultants use it to set or align configuration across environments, for example when a set of profile options must be reproduced in a new instance or when many responsibilities need the same value. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Configuration at scale:** Profile options that control reporting, security and processing must be set consistently for many users, responsibilities and operating units.
*   **Level precision:** The same option can be set at several levels, and a value on the wrong level silently overrides or is overridden by another.
*   **Validated values:** Profile options that point to a responsibility, application or user must be entered with the correct visible name, not an internal id.
*   **Environment copies:** Moving configuration from one instance to another needs a repeatable, reviewable file rather than manual form entry.

## The Solution
*   **All supported levels:** Site, Application, Responsibility, User, Server and Operating Unit values are returned, and only the levels the option definition allows are offered.
*   **Visible values:** The Value column shows the name of the responsibility, application, user or operating unit rather than its id, and a stored value is also accepted.
*   **Delete by clearing:** Clearing the value of an existing row deletes the profile option value at that level.
*   **Server-specific settings:** The Server column applies only to profile options with the server and responsibility hierarchy, to set a value for a responsibility on one server.
*   **Row messages:** Validations that depend on the responsibility being updated cannot be evaluated in the file, so the value is saved as entered and the row message says so.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_PROFILE_OPTIONS_VL`: the profile option definitions, with user name, internal name and active dates.
*   `FND_PROFILE_OPTION_VALUES`: the stored values, with level id, level value and profile option value.
*   `FND_APPLICATION_VL`: the application names for application-level values and for responsibility applications.
*   `FND_RESPONSIBILITY_VL`: the responsibility names for responsibility and server-responsibility values.
*   `FND_USER`: the user names for user-level values.
*   `FND_NODES`: the server names for server and server-responsibility values.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit names for operating unit values.

### Logical Relationships
1. `FND_PROFILE_OPTIONS_VL` joins to `FND_PROFILE_OPTION_VALUES` on application id and profile option id.
2. The level value is resolved according to the level id, which is decoded to Site, Application, Responsibility, User, Server, Operating Unit or Server-Responsibility.
3. For application levels, the level value joins to `FND_APPLICATION_VL`. For responsibility levels, it joins to `FND_RESPONSIBILITY_VL` on responsibility id and application id.
4. For user levels, it joins to `FND_USER`. For server levels, it joins to `FND_NODES` on node id, and for operating unit levels, to `HR_ALL_ORGANIZATION_UNITS_VL`.
5. The stored value is passed through the display function, which renders it in its visible form.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing values.
*   **Profile Option:** restricts the download to one profile option by its user name.
*   **Profile Option Code:** restricts the download to one profile option by its internal name.
*   **Application:** restricts the download to profile options of one application.
*   **Level:** restricts the download to one level.
*   **Level Value:** restricts the download to one responsibility, user, application or operating unit.

## Performance & Optimization
*   Only active profile option definitions are returned, using the start and end active dates, so retired options do not appear.
*   Level values are joined with decoded keys, so each value is looked up in only the table that its level requires.
*   The display function resolves stored values on demand, so the list of values is built per option rather than for every row.

## FAQ
**Q: How do I delete a profile option value?**
A: Clear the Value column on the existing row. The value is removed at that level.

**Q: Why does my row say the value was saved without validation?**
A: Some validations depend on the responsibility being updated and cannot be evaluated in the file. The value is saved as entered, and the row message says so.

**Q: How do I set a value for one server?**
A: Use the Server column with a profile option that has the server and responsibility hierarchy, and a responsibility level.
