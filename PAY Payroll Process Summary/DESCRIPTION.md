# Case Study & Technical Analysis: PAY Payroll Process Summary

## Executive Summary
The PAY Payroll Process Summary report lists Oracle Payroll processes, which are the payroll actions of every action type, with the number of assignment actions in each status, the count of messages and the first message of each process. It covers payroll runs, prepayments, costing, transfers to the ledger and other payroll processes in one list. Payroll operations teams use it to monitor the progress of payroll runs, to find processes with errors or assignment actions in error, and to diagnose failures from the first message. The Errors Only parameter lets the report run as a scheduled alert. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Run monitoring:** Payroll runs are made up of many assignment actions, and operators need to see how many are complete, in error, skipped or still unprocessed.
*   **Failure diagnosis:** When a process fails, the reason is recorded in message lines, and the first message is the fastest way to start an investigation.
*   **Multiple process types:** Payroll runs, prepayments, costing and ledger transfers are all payroll actions, and they need to be monitored from one list.
*   **Timely alerts:** Failed processes must be found before payments or ledger transfers are delayed.

## The Solution
*   **Status breakdown:** Assignment actions are counted by status: complete, in error, marked for retry, unprocessed and skipped.
*   **Message counts:** Process-level messages and assignment-action-level messages are counted together.
*   **First message logic:** The first process-level message is shown, or, if none exists, the first fatal assignment action message.
*   **Run context:** Each process shows its payroll, consolidation set, element set, assignment set, batch, concurrent request, program, requester and actual start and completion times.
*   **Error filter:** Errors Only lists processes that are in error or have assignment actions in error.

## Technical Architecture (High Level)
### Primary Tables
*   `PAY_PAYROLL_ACTIONS`: the payroll processes, with action type, status, effective date, time period and request identifier.
*   `PAY_ASSIGNMENT_ACTIONS`: the assignment actions of each process, aggregated here by status.
*   `PAY_MESSAGE_LINES`: the process-level and assignment-action-level messages.
*   `PAY_ALL_PAYROLLS_F`: the payroll name, valid on the effective date.
*   `PAY_CONSOLIDATION_SETS`, `PAY_ELEMENT_SETS`, `HR_ASSIGNMENT_SETS`, `PAY_BATCH_HEADERS`: the set and batch names attached to a process.
*   `PER_TIME_PERIODS`: the period name and date earned.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group.
*   `FND_CONCURRENT_REQUESTS`, `FND_CONCURRENT_PROGRAMS_VL`: the concurrent request and program that ran the process.

### Logical Relationships
1. `PAY_PAYROLL_ACTIONS` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on business group, and outer joined to `PER_TIME_PERIODS` on time period.
2. An inline view aggregates `PAY_ASSIGNMENT_ACTIONS` by payroll action, counting the assignment actions in each status.
3. `PAY_PAYROLL_ACTIONS` is outer joined to `FND_CONCURRENT_REQUESTS`, and that to `FND_CONCURRENT_PROGRAMS_VL` on application and program identifiers.
4. The payroll, consolidation set, element set, assignment set and batch names are scalar lookups on the process identifiers.
5. Message counts are two scalar subqueries, one on process-level lines and one on assignment action lines through `PAY_ASSIGNMENT_ACTIONS`.

## Parameters & Filtering
*   **Business Group:** Restricts the processes to one business group.
*   **Payroll:** Restricts the processes to one payroll.
*   **Action Type and Action Status:** Restrict the processes by type and by status.
*   **Effective Date From and To:** Restrict the processes by effective date.
*   **Request Id:** Returns the process started by one concurrent request.
*   **Errors Only:** When set, lists only processes in error or with assignment actions in error, suitable for a scheduled alert.

## Performance & Optimization
*   The assignment action counts are pre-aggregated in an inline view per payroll action, so the status breakdown does not require a correlated subquery per process.
*   Message counts and the first message are scalar subqueries on the message lines, so their cost grows with the number of messages on each process.
*   The first message uses `max` with `keep (dense_rank first)` ordered by line sequence, which returns the earliest message in one lookup.
*   The output is ordered by effective date, business group, payroll, action type and request identifier.

## FAQ
**Q: How do I set up an alert for failed payroll processes?**
A: Run the report with Errors Only set to Yes, and schedule it so that processes in error are listed.

**Q: Which message is shown as First Message?**
A: The first process-level message is shown. If there is none, the first fatal assignment action message is shown.

**Q: What does the Messages column count?**
A: It counts the process-level messages and the assignment action-level messages of each process.
