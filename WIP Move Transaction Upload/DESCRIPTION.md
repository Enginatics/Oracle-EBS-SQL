# Case Study & Technical Analysis: WIP Move Transaction Upload

## Executive Summary
WIP Move Transaction Upload creates move transactions in Oracle Work in Process, the transactions that move completed quantities from one operation or intraoperation step to the next along a discrete job or repetitive schedule. It mirrors the Move Transactions form for moves between operations, moves into and out of Reject and Scrap, move and completion transactions, and return and move transactions. Shop floor supervisors, production planners and manufacturing accountants use it to post large volumes of moves at the end of a shift, or to post moves for a set of jobs in one spreadsheet, while keeping backflush, completion and resource charging consistent with the form.

## Business Challenge
*   **Shop Floor Volume:** A plant can record hundreds of moves each shift, and entering each one in the form delays reporting.
*   **Job Status Visibility:** Planners need to see how much quantity sits in each queue, run and move step before deciding what to move.
*   **Consistent Charging:** Moves must trigger the same backflush, completion and resource charges as the form, or costs are misstated.
*   **Compliance Records:** Where electronic records and signatures apply, the upload must create the same records as the form.

## The Solution
*   **Available Quantity Download:** In Create and Update mode the queue, run and to move steps that hold a quantity are downloaded with their available quantity, so the user enters only the quantity to move.
*   **Move Rows:** Each row is posted as a move, with the from and to operation and step, the quantity and the transaction date.
*   **Parameter Control:** Transaction types and overcompletion settings are controlled by parameters rather than by the function used to launch the upload.
*   **Record Creation:** With E-Records and E-Signatures set to Yes, discrete job moves create electronic records as the form does.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_DISCRETE_JOBS`: the discrete jobs, with their status, bill revision and primary item.
*   `WIP_ENTITIES`: the job and schedule entity names and descriptions.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedules, with their status, bill revision and first unit start date.
*   `WIP_LINES`: the production lines of repetitive schedules.
*   `WIP_OPERATIONS`: the operations of each job or schedule, with the operation sequence, the department, the standard operation and the quantities in queue, running and waiting to move.
*   `BOM_STANDARD_OPERATIONS`: the standard operation codes.
*   `BOM_DEPARTMENTS`: the department codes.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly items.
*   `MTL_PARAMETERS`: the organizations.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

### Logical Relationships
1.  Discrete jobs in `WIP_DISCRETE_JOBS` are joined to their entity in `WIP_ENTITIES` and to their assembly in `MTL_SYSTEM_ITEMS_VL`.
2.  Operations in `WIP_OPERATIONS` are joined to each job and to their standard operation and department.
3.  Each operation is expanded with a row generator into one row for each intraoperation step, queue, run and to move, and the quantity for that step is chosen by decode.
4.  The next operation of the job, the to step, is found by a correlated subquery for the first count point that follows the current operation.
5.  Repetitive schedules in `WIP_REPETITIVE_SCHEDULES` are joined to `WIP_LINES` and to their operations in the same way, with the quantities summed across the schedule's operations.
6.  The discrete and repetitive branches are combined with UNION ALL, and each row is numbered to give the upload row.

## Parameters & Filtering
*   **Organization Code:** Restricts the jobs and schedules to one organization.
*   **Sales Order, Order Line, Line, Assembly and Job:** Select the jobs and schedules to download, by sales order, line, assembly or job name.
*   **Transaction Types:** Controls the transaction type applied to the moves.
*   **Allow Overcompletion:** Controls whether moves that exceed the job quantity are allowed.
*   **E-Records and E-Signatures:** Controls whether electronic records are created for discrete job moves.

## Performance & Optimization
*   **Released Jobs Only:** Discrete jobs are restricted to released and completed status types, and repetitive schedules to the same status types, so closed work is not downloaded.
*   **Positive Availability Filter:** Only steps with a quantity greater than zero are returned, which keeps the download to actionable rows.
*   **Row Generator Expansion:** The intraoperation steps are produced by a row generator, so one operation becomes three rows without repeated table reads.
*   **Serialized and Operation Exclusions:** Serialized jobs and operations that are not standard operations are excluded at the join level, which keeps the set limited to supported work.

## FAQ
**Q: Can I update a move I entered earlier with this upload?**
A: No. An existing move is never updated. Correct it with another move, such as a backward move or a Return and move transaction.

**Q: Which rows are uploaded?**
A: Only rows where To Step and Quantity have been entered are uploaded. Rows left unchanged are not uploaded.

**Q: Are operations added on the fly supported?**
A: No. The description lists operations added on the fly as not supported, along with manual resource transactions and serialized jobs.
