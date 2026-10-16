# Case Study & Technical Analysis: FND Debug and Trace Settings

## Executive Summary
The FND Debug and Trace Settings report lists the Oracle E-Business Suite profile option values that switch on debug logging, SQL trace or a custom initialization SQL statement, at every level where they can be set. It also lists concurrent programs that have SQL trace enabled. System administrators and DBAs use it to find debug and trace settings that were left on after an investigation, because these settings slow down processing and fill the FNDLOGMESSAGES table and the database trace directory. The report runs in Excel via Blitz Report, and each row shows who last changed the setting and when.

## Business Challenge
*   **Forgotten diagnostic settings:** Debug and trace profile options are often switched on during a support case and never reset, which degrades performance for all users.
*   **Log table growth:** Debug logging writes to FNDLOGMESSAGES, which can grow quickly and affect maintenance and backup windows.
*   **Multi-level configuration:** A profile option can be set at site, application, responsibility, user, server, operating unit or combined server and responsibility levels, so the active value is not always visible at the site level.
*   **Traceable changes:** An administrator needs to know who changed a setting and when before reverting it.

## The Solution
*   **Broad name detection:** Profile options whose internal names contain DEBUG or TRACE are selected, excluding file, directory, path, URL, location and module settings that do not switch logging on.
*   **Named exceptions:** The debug log enabled option and the custom initialization SQL statement are included by their internal names.
*   **Noise suppression:** Values of N, No, F, 0, Off and None are excluded, so only active settings appear.
*   **Level resolution:** Each setting is shown with its level name, such as the application, responsibility, user, node, or operating unit, and with the last update details.
*   **Trace-enabled programs:** Concurrent programs with SQL trace enabled are listed as a separate setting type.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_PROFILE_OPTIONS_VL`: the profile option definitions, with internal and user names.
*   `FND_PROFILE_OPTION_VALUES`: the values set at each level, with level identifiers and last update details.
*   `FND_APPLICATION_VL`: application names for application-level and concurrent program settings.
*   `FND_RESPONSIBILITY_VL`: responsibility names for responsibility-level and operating unit settings.
*   `FND_NODES`: server node names for server-level settings.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: operating unit names for operating unit-level settings.
*   `FND_CONCURRENT_PROGRAMS_VL`: concurrent programs with SQL trace enabled.

### Logical Relationships
1. `FND_PROFILE_OPTIONS_VL` is joined to `FND_PROFILE_OPTION_VALUES` on application and profile option identifiers.
2. The level identifier decides which lookup supplies the level name: `FND_APPLICATION_VL` for application level, `FND_RESPONSIBILITY_VL` for responsibility and operating unit responsibility levels, `FND_NODES` for server level and `HR_ALL_ORGANIZATION_UNITS_VL` for operating unit level. User level uses the user name function.
3. The result is unioned with concurrent programs that have trace enabled, joined to `FND_APPLICATION_VL`.
4. The final output is ordered by setting type, name, level and level name.

## Parameters & Filtering
*   **Setting Type:** Limits the output to profile option settings or to concurrent programs with SQL trace enabled.
*   **Level:** Limits the output to one profile option level, such as Site, Application, Responsibility, User, Server, Operating Unit or Server+Responsibility.

The SQL text does not reference these two parameters through bind variables, so the rows listed are the full set of matching settings described above.

## Performance & Optimization
*   The profile option name filter uses regular expressions on `FND_PROFILE_OPTIONS_VL`, which is a small definition table, so the main cost is in the value join.
*   Values of N, No, F, 0, Off and None are removed in the value filter before the level lookups, so only active settings reach the outer joins.
*   Level lookups are outer joins with decode or case expressions, so each setting resolves to at most one row in each lookup table.
*   The query does not use aggregation or analytic functions.

## FAQ
**Q: How do I find debug or SQL trace settings that are still switched on?**
A: Run the report; every row is an active debug or trace setting, with its level, level name and last updated by and date.

**Q: Why does a setting appear for a responsibility rather than the site?**
A: Profile option values are stored per level, so a value set for one responsibility appears on its own row with the responsibility name as the level name.

**Q: Which concurrent programs are running with SQL trace enabled?**
A: Rows with the setting type Concurrent Program show the programs whose SQL trace flag is set, with the application name as the level name.
