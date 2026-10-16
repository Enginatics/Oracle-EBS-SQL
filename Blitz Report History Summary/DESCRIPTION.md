# Case Study & Technical Analysis: Blitz Report History Summary

## Executive Summary
The Blitz Report History Summary is an administrative report that summarises how often each Blitz Report has been executed and how long those executions took. It is written for Blitz Report administrators and Oracle EBS system owners who need to understand which reports are used most, which take the longest, and who runs them. For each report it shows the number of runs, the average, maximum and total run time, the number of distinct users, and the most frequent user. It is part of the Blitz Report toolset rather than a finance or supply chain report, and it supports capacity planning and the decision of where to tune or retire reports.

## Business Challenge
*   **Knowing which reports matter:** Administrators need to see which reports are run most often before they change, retire or migrate them.
*   **Locating slow executions:** Long-running reports affect concurrent processing and user experience, and the maximum and total run time show where effort should go.
*   **Understanding adoption:** The number of distinct users per report shows whether a report serves one team or the whole organisation.
*   **Governance of usage:** Owners need to exclude system reports or their own test runs so that the statistics reflect real business use.

## The Solution
*   **Execution statistics per report:** The report counts completed runs for each report and computes average, maximum and total duration in seconds, which are then formatted as readable times.
*   **User analysis:** It counts the distinct submitting users and identifies the most frequent one, using the number of runs per user to rank them.
*   **Report classification:** Each report is returned with its type and category, so the summary can be grouped by function.
*   **Creator and update trail:** Created by and last updated by names, with their dates, are returned for every report.
*   **Spreadsheet analysis:** Running the report in Excel through Blitz Report lets administrators sort by count or duration and build their own pivots.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORTS_V`: the view of Blitz Report definitions, supplying the report name, type, creation and update details.
*   `XXEN_REPORT_RUNS`: one row per report execution, holding the creation and completion dates, the completion message and the submitting user.

### Logical Relationships
1. `XXEN_REPORTS_V` is joined to `XXEN_REPORT_RUNS` as an outer join on the report identifier, so reports with no runs are still eligible.
2. The inner query keeps only completed runs, those with a completion date and no completion message.
3. Duration is calculated as the difference between completion and creation date, multiplied by 86400 to give seconds.
4. Analytic functions partition by report identifier to produce the counts, averages, maxima, sums and distinct user counts.
5. The outer query collapses the analytic output to one row per report and orders the result by run count, with the highest first.

## Parameters & Filtering
*   **Report Name:** Restricts the summary to one Blitz Report by name.
*   **Submitted By:** Limits the runs counted to those submitted by one user.
*   **Submitted within Days:** Restricts the runs to those created within the given number of days, so the statistics reflect recent activity.
*   **Exclude System Reports:** When set, removes built-in reports from the summary so that only user-defined reports are counted.
*   **Exclude own Submissions:** When set, removes the runs submitted by the current user, so that an administrator's own testing does not distort the figures.

## Performance & Optimization
*   **Completed runs only:** The inner filter excludes runs without a completion date or with a completion message, so only meaningful durations are aggregated.
*   **Single-pass analytics:** Counts, averages, maxima and sums are computed by analytic functions over the same partition, so the report table is read once per aggregate rather than joined repeatedly.
*   **Most frequent user by ranking:** The most frequent user is found with a `keep (dense_rank last)` expression rather than a separate query, which keeps the summary to one statement.
*   **Scalar lookups for names:** User names are resolved through a function call, and the category is derived by a function for each report.

## FAQ
**Q: How do I see which Blitz Reports are run most often?**
A: Run Blitz Report History Summary and read the count column, which is sorted in descending order by default.

**Q: How is the average run time of a Blitz Report calculated?**
A: The duration of each completed run is the difference between its completion and creation dates in seconds, and the average is the sum of those durations divided by the number of runs.

**Q: Does the summary include my own test runs?**
A: Set Exclude own Submissions to Yes to remove the runs submitted by the current user from the statistics.
