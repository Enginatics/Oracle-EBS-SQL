# Case Study & Technical Analysis: Blitz Report Extension Package API Signatures

## Executive Summary
The Blitz Report Extension Package API Signatures report shows the signature of every Oracle EBS API that Blitz Report™ extension packages call on the current instance. It lists each procedure argument with its position, data type, in or out mode, defaulted flag and, for record arguments, the fields of the record. Its main use is comparison. Support engineers and DBAs run it on a failing instance and on a working one, then compare the two to find the argument or record field that a patch level does not provide. The report is aimed at DBAs and technical administrators who maintain Blitz Report on Oracle EBS.

## Business Challenge
*   **Silent package loss:** When an extension package calls an EBS API by named parameter and that parameter or field is missing, the package fails to compile and the installer drops it.
*   **Delayed failure:** The reports and uploads that depend on the dropped package then fail at runtime with PLS-00201, which points away from the real cause.
*   **Patch-level differences:** Two instances at different EBS patch levels can expose different API signatures, so a fix on one may not transfer to another.
*   **Unclear calling dependencies:** It is not obvious which EBS APIs the extension packages depend on, or which package calls each one.

## The Solution
*   **Signature listing:** Every argument of every procedure is listed with its position, data type, mode, defaulted flag and type name.
*   **Record field expansion:** Record type arguments are shown with their nested fields, so a missing field can be identified by name.
*   **Caller attribution:** For APIs discovered from the installed source, the referencing extension packages are listed beside each API.
*   **Targeted lookup:** Naming a specific API package reports its full signature whether or not any installed package calls it, which covers packages that failed to compile.

## Technical Architecture (High Level)
### Primary Tables
*   `USER_SOURCE`: the source text of the installed packages. The report searches it for qualified package and procedure references.
*   `USER_ARGUMENTS`: the argument definitions of the packages, with position, data level, type, mode and default flag.

### Logical Relationships
1.  A discovery branch reads the source text of the installed `XXEN` package bodies from `USER_SOURCE`, skipping wrapped packages.
2.  A row generator expands each body into one candidate reference per qualified name match, and the regular expression extracts the package and object name from each match.
3.  The candidates are grouped by package and object, with the calling package names combined into one Referenced By value.
4.  The grouped APIs are joined to `USER_ARGUMENTS` on package and object name, so every argument of each called API is returned.
5.  When an API package name is supplied, a second branch returns `USER_ARGUMENTS` directly for that package, without the source search.
6.  The two branches are unioned and ordered by package, procedure, overload and argument sequence.

## Parameters & Filtering
*   **API Package Name:** When set, reports that package's full signature, whether or not any installed package calls it. This is the route for packages that failed to compile.
*   **API Procedure Name:** Limits the output to one procedure within the package.
*   **Argument Name:** Finds one argument by name across the selected APIs, which is the quickest way to check whether a parameter exists.

## Performance & Optimization
*   **Discovery only when needed:** The source search branch runs only when no API package name is given, so a targeted lookup avoids scanning all extension package source.
*   **Wrapped source excluded:** Packages whose source is wrapped are skipped, since their text cannot be searched.
*   **Regular expression row generation:** The source text is expanded into candidate matches with a row generator, so each package body is parsed once per match position rather than with procedural code.
*   **Grouped reference list:** Referencing packages are aggregated with a single grouped pass, so each called API appears once with its callers.

## FAQ
**Q: How do I check whether an EBS API parameter is missing on my instance?**
A: Enter the API Package Name and, if needed, the API Procedure Name or Argument Name, then compare the output with the same report run on a working instance.

**Q: Why does an extension package not appear in the list when it fails to compile?**
A: The discovery search reads installed package source, and a package that failed to compile is not in that list, so name its API in the API Package Name parameter instead.

**Q: Does this report list types and constants from package specifications?**
A: No. Only procedure arguments and record fields appear, so use the DBA Text Search report on the package specification for types and constants.
