# Case Study & Technical Analysis: DBA Undo Statistics

## Executive Summary
This report shows undo generation, the longest running query and undo-related errors for each 10-minute interval, taken from the instance undo statistics view. Database administrators use it to diagnose ORA-01555 "snapshot too old" errors and to decide whether the undo tablespace is large enough for the workload. Because the source view keeps about four days of history, the report is a retrospective review tool. It runs in Excel through Blitz Report™, with the Hours Back parameter limiting the window examined.

## Business Challenge
*   **Snapshot too old errors:** A long query fails with ORA-01555 when the undo it needs has already been overwritten, which interrupts reports and batch jobs.
*   **Undersized undo tablespace:** When the undo tablespace is too small, undo is overwritten before its tuned retention has expired, and administrators need evidence of this.
*   **Workload correlation:** Undo generation spikes must be matched with the transactions and the longest running query active at the time.
*   **Multi-instance systems:** On Real Application Clusters each instance has its own undo, so the figures must be separated by instance.

## The Solution
*   Reports undo generated, undo generated per second and the number of transactions and concurrent transactions for each interval.
*   Shows the longest query in seconds and its SQL identifier, next to the tuned undo retention, so that the two can be compared directly.
*   Splits undo into active, unexpired and expired blocks, and counts ORA-01555 errors, out-of-space errors and unexpired steal attempts.
*   Filters by Errors only, Hours Back and Instance Id, so the view can be focused on the intervals that matter.

## Technical Architecture (High Level)
### Primary Tables
*   `GV$UNDOSTAT`: the undo statistics for each 10-minute interval, with undo blocks, transaction counts, query length and error counters per instance.
*   `GV$TABLESPACE`: maps the undo tablespace number of each instance to the tablespace name.
*   `DBA_TABLESPACES`: supplies the block size of the undo tablespace.
*   `GV$PARAMETER`: supplies the value of the UNDO_RETENTION parameter for each instance.

### Logical Relationships
1.  Each `GV$UNDOSTAT` row is linked to its undo tablespace through the instance identifier and the undo tablespace number.
2.  The block size is found by matching that tablespace name to `DBA_TABLESPACES`.
3.  The UNDO_RETENTION parameter is matched on the same instance identifier.
4.  Undo volumes are calculated as blocks multiplied by block size, and divided by the interval length in seconds to give undo per second.
5.  Error and steal counters are passed through a zero-to-null function, so that intervals without events show blank rather than zero.
6.  The result is ordered by begin time, most recent first, and then by instance.

## Parameters & Filtering
*   **Errors only:** restricts the output to intervals with at least one error or steal event.
*   **Hours Back:** limits the look-back window measured from the current time, within the four days kept by the source view.
*   **Instance Id:** restricts the output to one instance in a cluster.

## Performance & Optimization
*   The three lookups for tablespace name, block size and retention are correlated subqueries that run once per `GV$UNDOSTAT` row, so the number of intervals retained drives their cost.
*   The source view holds a bounded history of about four days, so the row count is capped without any extra archiving.
*   Zero-to-null handling of the error and steal counters leaves intervals without events blank, so intervals with events stand out when the results are scanned.
*   Converting blocks to MB with the block size is a plain arithmetic step on the view values, so no further lookup is needed for the sizes.

## FAQ
**Q: What causes an ORA-01555 snapshot too old error?**
A: The error occurs when a query needs undo that has already been overwritten, and the Longest Query Seconds column can be compared with the Tuned Undo Retention Seconds to see whether that is the case.

**Q: What do unexpired steal attempts show?**
A: Unexpired steal attempts show that undo still within its retention period was overwritten, which indicates the undo tablespace is too small for the workload.

**Q: How far back does the report go?**
A: The source view keeps about four days of history, so the Hours Back parameter can look back no further than that.
