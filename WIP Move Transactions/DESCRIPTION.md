# Case Study & Technical Analysis: WIP Move Transactions

## Executive Summary
The WIP Move Transactions report lists the work in process move transactions of an organization, one row per transaction, as shown in the View Move Transactions form. It covers discrete jobs, lot based jobs, repetitive schedules and flow schedules. Each row shows the operation and department the assembly moved from and to, the intraoperation step, the quantity moved in the entered and primary units, any over-completion and scrap account, the reason and reference, and the employee who performed the move. Production supervisors and cost accountants use it to review shop floor activity by day, to trace quantities through operations, and to investigate scrap and over-completion. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Shop floor traceability:** Supervisors need to see which operation and department an assembly was moved through, and by whom, to resolve questions about where a job is.
*   **Daily production reporting:** Output must be totaled by day, so that daily production and labor reporting can be reconciled.
*   **Scrap and over-completion control:** Scrap and over-completed quantities must be visible with their scrap account and reason, so they can be reviewed and costed.
*   **Repetitive allocation:** Repetitive moves are split across the schedules they were allocated to, and each allocation must be visible with its quantity and start date.

## The Solution
*   **Move detail:** Each move transaction is shown with its from and to operation, department, intraoperation step, transaction and primary quantities, and units of measure.
*   **Allocation split:** Repetitive moves are joined to their allocations, so a move that spans several repetitive schedules appears once per schedule with the allocated quantity.
*   **Daily totals:** The transaction day is the transaction date without the time, so users can total the moves by day.
*   **Scrap and over-completion:** The over-completion flag, over-completed quantities and the scrap account are shown with the move.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_MOVE_TRANSACTIONS`: the move transaction header, with the from and to operation, department, step, quantities, reason, reference and scrap account.
*   `WIP_MOVE_TXN_ALLOCATIONS`: the allocation of a repetitive move to a schedule and quantity.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedule, with its first unit start date.
*   `WIP_ENTITIES`: the job or schedule name and entity type.
*   `WIP_LINES`: the production line.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly number and description.
*   `BOM_DEPARTMENTS`: the from and to departments.
*   `MTL_TRANSACTION_REASONS`: the transaction reason name.
*   `PER_ALL_PEOPLE_F`: the employee who performed the move.
*   `MTL_PARAMETERS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  `MTL_PARAMETERS` joins to `WIP_MOVE_TRANSACTIONS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  Each move joins to its allocations as an outer join, so moves that are not repetitive are kept once.
3.  The allocation joins to `WIP_REPETITIVE_SCHEDULES` on the schedule ID, as an outer join.
4.  The move joins to `WIP_ENTITIES` on the job ID, to `WIP_LINES` on the line ID, and to `MTL_SYSTEM_ITEMS_VL` on the primary item.
5.  The from and to departments join to `BOM_DEPARTMENTS`, the reason to `MTL_TRANSACTION_REASONS`, and the employee to `PER_ALL_PEOPLE_F` by a transaction date that falls within the person's effective dates.

## Parameters & Filtering
*   **Organization Code:** selects the organization.
*   **Date From** and **Date To:** bound the transaction date of the moves.
*   **Job:**, **Line** and **Assembly:** select a job, a production line or an assembly.
*   **From Department** and **To Department:** select the departments the move came from and went to.
*   **From Step** and **To Step:** select the intraoperation step at each end of the move.
*   **Reason:** selects the transaction reason.
*   **Employee Number:** selects the moves performed by one employee.

## Performance & Optimization
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, applied first, so the move table is read only for accessible organizations.
*   Allocations are outer joined to the move, so each move is read once and the allocations expand it only for repetitive moves.
*   The employee join uses the transaction date range against the person's effective dates, so each move matches the employee record that was effective when it was made.
*   The department, reason and line joins are keyed on primary identifiers, so each adds at most one row to a move.

## FAQ
**Q: Why does one move appear more than once?**
A: A repetitive move is shown once for each repetitive schedule it was allocated to, with the allocated quantity and the first unit start date of that schedule.

**Q: What is the difference between Quantity and Primary Quantity?**
A: Quantity is in the unit of measure the transaction was entered in, and Primary Quantity is in the primary unit of measure of the assembly.

**Q: Which transactions are not in the report?**
A: The description states that transactions still pending in the move transaction interface are not included.
