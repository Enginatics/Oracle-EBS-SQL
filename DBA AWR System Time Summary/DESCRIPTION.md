# Executive Summary
The **DBA AWR System Time Summary** report quantifies the absolute time spent on various database activities. While percentages are useful for composition, absolute values (seconds or microseconds) are necessary for capacity planning and quantifying the impact of changes. For example, knowing that "SQL Execution" dropped from 50,000 seconds to 20,000 seconds proves the success of a tuning exercise.

# Business Challenge
*   **Quantifying Improvement**: "We added an index. How many CPU seconds did we save per hour?"
*   **Capacity Planning**: "Our workload is growing by 500 CPU-seconds per week. When will we max out the server?"
*   **Billing/Chargeback**: "How much database time is the 'Payroll' module consuming?"

# Solution
This report displays the raw values from the Oracle Time Model.

**Key Features:**
*   **DB CPU**: Total CPU time used by the database.
*   **DB Time**: Total time spent in database calls (CPU + Wait).
*   **Background CPU**: CPU used by background processes (LGWR, DBWR).

# Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Stores cumulative time values.
*   `DBA_HIST_SNAPSHOT`: Used to calculate deltas between snapshots.

# Impact
*   **ROI Justification**: Provides hard numbers to justify hardware purchases or consulting fees.
*   **Trend Analysis**: Tracks the growth of specific workload components over months or years.
*   **Performance Baselines**: Establishes a "normal" baseline for comparison during incidents.
