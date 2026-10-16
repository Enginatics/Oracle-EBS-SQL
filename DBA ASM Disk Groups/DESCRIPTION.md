# Case Study & Technical Analysis: DBA ASM Disk Groups

## Executive Summary
This report lists the Automatic Storage Management (ASM) disk groups used by an Oracle database, with their redundancy, state and space figures in MB. Database administrators use it to check how full each disk group is, whether it can restore full redundancy after a disk failure and how much space remains for new files. The report returns no rows when the database does not use ASM. It runs in Excel through Blitz Report™, and the Used Percent From parameter is the threshold for spotting groups that are filling up.

## Business Challenge
*   **Storage exhaustion:** A full disk group stops datafile growth and can halt transactions, so administrators need to see used space per group before it becomes critical.
*   **Redundancy headroom:** A disk group that cannot restore its mirroring after a disk failure is exposed, and the cause is often a shortage of free space.
*   **Usable capacity:** The raw free space of a group is not the space that can be allocated to new files once mirroring is taken into account.
*   **Disk failure readiness:** Offline disks reduce capacity and must be visible in the same view as the space figures.

## The Solution
*   Shows the total, used and free space of each disk group in MB, with the used percentage calculated from the total.
*   Returns the required mirror free space and the usable file space, so the space available for new files after mirroring is visible.
*   Lists the number of offline disks, the allocation unit size and the compatibility settings of each group.
*   Presents the groups in name order, so the same groups appear in the same place across repeated runs.

## Technical Architecture (High Level)
### Primary Tables
*   `V$ASM_DISKGROUP`: the dynamic performance view that holds one row for each mounted ASM disk group, with its size, free space, redundancy type and compatibility attributes.

### Logical Relationships
1.  The report reads a single view, so there are no joins; each row is one disk group.
2.  The used space is calculated as total space less free space.
3.  The used percentage is the used space divided by the total space, with a null-safe divisor so that a group reporting no total space does not cause an error.
4.  The allocation unit size is converted from bytes to MB by dividing by 1,048,576.
5.  The results are ordered by disk group name.

## Parameters & Filtering
*   **Used Percent From:** sets the lower bound for the used percentage that the report is filtered on, so that only groups above the chosen fill level are listed.

## Performance & Optimization
*   The query reads one small dynamic view with no joins, so its cost is negligible and it can be run at any time without affecting the database workload.
*   All space figures are returned by the view itself, so no calculation requires access to the disk or file catalogue.
*   The divisor in the used percentage is wrapped in a null-safe function, which avoids a division error for any group that reports zero total space.
*   Because the view returns one row for each disk group, the output size is proportional to the number of disk groups and not to the number of files or disks.

## FAQ
**Q: Why is the usable file space negative for a disk group?**
A: A negative Usable File MB value means the disk group cannot restore full redundancy after a disk failure, so it has to be given more free space before it is considered safe.

**Q: How is the used percentage of an ASM disk group calculated?**
A: The report divides the used space, which is total MB less free MB, by the total MB and multiplies by 100.

**Q: Why does the report return no rows?**
A: The report returns no rows when the database does not use ASM, because the disk group view is then empty.
