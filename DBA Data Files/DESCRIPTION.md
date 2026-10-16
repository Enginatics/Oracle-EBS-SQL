# Case Study & Technical Analysis: DBA Data Files

## Executive Summary
The DBA Data Files report lists every data file and temp file in the database, grouped by tablespace, with its size, free space, autoextend settings and the space still available up to its maximum size. All sizes are shown in MB. Database administrators use it to see how close each file is to its real limit, which is the figure that matters for autoextend files, and to find files left in backup mode. It can also be scheduled with a Max Used Percent threshold so that an email is sent only when a data file is close to full.

## Business Challenge
*   **Hidden capacity limits:** An autoextensible file can look small while still having room to grow, and an un-extended file with no headroom can stop a batch job. Administrators need the real limit, not the current size.
*   **Early warning of full tablespaces:** Tablespaces that fill up stop transactions and concurrent requests, so usage must be watched before it reaches capacity.
*   **Backup hygiene:** Data files left in hot backup mode need to be spotted quickly, so that the backup state can be ended.
*   **Temp space visibility:** Temp files are sized and used differently from data files, and they need their own capacity view.

## The Solution
*   **File-level sizing:** Each data file shows its total size, used size, free size and used percentage, computed from the free-space dictionary view.
*   **Autoextend-aware capacity:** Available Size and Max Used Percent are calculated against the larger of the current size and the autoextend maximum, so the figures reflect the real ceiling.
*   **Backup status flag:** The In Backup Mode column shows whether a data file is in hot backup mode and, if so, since when.
*   **Temp file coverage:** Temp files appear in the same list, with their size and available space, while usage columns are left blank because they are shown by DBA Tablespace Usage.

## Technical Architecture (High Level)
### Primary Tables
*   `DBA_DATA_FILES`: the data files, with their size, autoextend flag, maximum size, increment and status.
*   `DBA_TABLESPACES`: the tablespace contents type and block size, used for the increment calculation and for classifying files.
*   `V$BACKUP`: the backup status of each file, used for the hot backup flag.
*   `DBA_FREE_SPACE`: free extents, summed per file to give the free size.
*   `DBA_TEMP_FILES`: the temp files, which are reported in a second branch of the query.

### Logical Relationships
1.  `DBA_DATA_FILES` is joined to `DBA_TABLESPACES` on tablespace name, and to `V$BACKUP` on file number, which is an outer join so files not in backup still appear.
2.  An inline view sums `DBA_FREE_SPACE` by file ID, and this result is outer joined to the data files, so a file with no free space still returns its full size as used.
3.  A second query branch reads `DBA_TEMP_FILES` joined to `DBA_TABLESPACES`, and returns the temp file size and available size, with the usage columns set to null.
4.  The two branches are combined with UNION ALL and ordered by tablespace name and file name.

## Parameters & Filtering
*   **Tablespace:** Limits the output to one tablespace, including its data and temp files.
*   **Max Used Percent From:** Returns only files whose maximum used percentage is at or above the threshold. Setting it to 90 gives an alert-style list of files close to full.

## Performance & Optimization
*   **Hinted inline views:** The data file and free space inputs are kept as no-merge inline views, so the optimizer does not fold them into the main query.
*   **Free space aggregated per file:** `DBA_FREE_SPACE` is summed by file ID before the join, so each data file is matched to a single free-space row.
*   **Backup status outer joined:** `V$BACKUP` is outer joined by file number, so the backup check does not remove files that are not in backup.
*   **Threshold filtering on the outer query:** The Max Used Percent filter is applied to the combined result, so it is evaluated once per file, including temp files.

## FAQ
**Q: Why is Available Size different from Free Size?**
A: Available Size adds the space still available through autoextend up to the maximum size, while Free Size only counts free space inside the current file size.
**Q: How do I get an alert only for files that are nearly full?**
A: Set Max Used Percent From to a threshold such as 90 and schedule the report, so only files at or above that level are returned.
**Q: Why are the usage columns blank for temp files?**
A: Temp file usage is reported by DBA Tablespace Usage, so this report shows only the size and available space for temp files.
