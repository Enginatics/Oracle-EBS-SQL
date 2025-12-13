# Case Study & Technical Analysis: CAC WIP Jobs With Complete Status But Not Ready for Close

## Executive Summary
The **CAC WIP Jobs With Complete Status But Not Ready for Close** report is a "Pre-Close" validation tool. In Oracle WIP, changing a job status to "Closed" is irreversible and triggers final variance accounting. This report prevents premature closing by flagging jobs that have unresolved issues.

## Business Challenge
*   **Orphaned Costs**: If you close a job while a Purchase Order is still open (unbilled), the invoice variance might get stuck or go to a suspense account.
*   **Data Integrity**: Closing a job with unissued components means your inventory accuracy is wrong (the system thinks you used 0, but you physically used 10).
*   **Variance Spikes**: Closing a job with a huge variance (e.g., 500%) usually indicates a data entry error that should be fixed *before* closing.

## Solution
This report acts as a gatekeeper.
*   **Checks**:
    *   **Unissued Material**: Are there open requirements?
    *   **Pending Transactions**: Are there records stuck in the Open Interface?
    *   **Variance Tolerance**: Does the variance exceed the threshold (Amount or %)?
    *   **Open POs**: Are there unreceived OSP items?

## Technical Architecture
*   **Tables**: `wip_discrete_jobs`, `wip_requirement_operations`, `po_headers/lines`.
*   **Logic**: Complex set of `EXISTS` checks to validate all conditions.

## Parameters
*   **Variance Amount/Percent Threshold**: (Mandatory) Define what "Too big" means.
*   **Include Scrap**: (Mandatory) Whether to count scrap as "Complete".

## Performance
*   **Moderate**: Checks multiple sub-tables (Requirements, POs, Interfaces).

## FAQ
**Q: What should I do with the jobs on this report?**
A: Fix the issue (Issue the material, Receive the PO, Fix the interface error) *then* close the job.
