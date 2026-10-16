# Case Study & Technical Analysis: DBA Directories

## Executive Summary
DBA Directories lists the database directory objects defined in an Oracle instance, with the operating system path each one points to and the database users granted access to it. It is built for DBAs and EBS technical consultants who must confirm that file exchange locations used by interfaces, data loads and report outputs are defined correctly and are accessible only to the intended accounts. The output supports directory audits and security reviews of file-based integrations.

## Business Challenge
*   **Path Governance:** Directory objects map a database name to an operating system path, and an incorrect or overly broad path can expose server files.
*   **Access Review:** Read, write and execute grants on directories are granted over time by different administrators, and the current set is rarely documented.
*   **Integration Troubleshooting:** When a file interface fails, the DBA needs to confirm which directory an interface uses and who can access it.
*   **Audit Evidence:** Security reviews need a dated, exportable list of directory objects and their grants.

## The Solution
*   **Directory Inventory:** The report lists every directory object with its name, its path and the schema that owns it.
*   **Grant Consolidation:** A correlated subquery aggregates all grants on each directory into one text value, so each directory appears on one row.
*   **Readable Privileges:** Each grant is shown as grantee and privilege in lower case, for example a read or write privilege beside the grantee name.
*   **Path Search:** A pattern filter on the directory path finds directories that point to a given server location.

## Technical Architecture (High Level)
### Primary Tables
*   `DBA_DIRECTORIES`: the dictionary view of directory objects, with the name, the path and the owner.
*   `DBA_TAB_PRIVS`: the dictionary view of object privileges, from which the grants on each directory are read.

### Logical Relationships
1.  Each row of `DBA_DIRECTORIES` is one directory object.
2.  A correlated subquery selects `DBA_TAB_PRIVS` rows where the owner and the table name equal the owner and the directory name of the current directory.
3.  The grantee and privilege of each matching row are concatenated and combined with LISTAGG, ordered by grantee and privilege.
4.  The result is ordered by directory name.

## Parameters & Filtering
*   **Directory Path like:** Applies a pattern match to the operating system path, so a search such as a server mount point returns the directories that use it.

## Performance & Optimization
*   **Small Dictionary Scope:** Directory objects are few in a typical EBS database, so the outer query returns a short list.
*   **Correlated Aggregation:** The grants are gathered in a single correlated LISTAGG per directory, which avoids a separate report row for each grant.
*   **Owner and Name Match:** The subquery matches on both owner and name, which keeps grants on a directory with the same name in another schema from being mixed in.
*   **No Joins to Application Tables:** The report reads only dictionary views, so it does not touch EBS transaction data.

## FAQ
**Q: How do I see which users can write to a database directory?**
A: The Grants column lists each grantee with the privilege in brackets, for example write. Read the entries for that privilege on the row for the directory.

**Q: Can I search for directories that point to a specific server path?**
A: Yes. Enter part of the path in the Directory Path like parameter to return the directories whose path matches.

**Q: Does the report show privileges granted through roles?**
A: The Grants column reads direct object privileges on each directory. Role-based access is shown in the DBA Object Access Privileges report for a given user.
