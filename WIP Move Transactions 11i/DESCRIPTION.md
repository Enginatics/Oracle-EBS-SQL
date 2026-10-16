# Case Study & Technical Analysis: WIP Move Transactions 11i

## Executive Summary
The WIP Move Transactions 11i report lists the Oracle Work in Process move transactions of discrete jobs, lot based jobs, repetitive schedules and flow schedules, with one row per transaction. It matches the View Move Transactions form and carries the data of the standard Move Transaction Report (WIPTSMOV): the from and to operation, department and intraoperation step, the transaction and primary quantities, the reason and reference, and the over-completion and scrap accounts. Production supervisors and cost accountants use it to review the shop floor flow of a day or a week, to reconcile moves with the WIP valuation and to find moves that were over-completed or scrapped. It runs in Excel through Blitz Report.

## Business Challenge
*   **Shop floor visibility:** Moves record how many units passed each operation, and the supervisor must see the flow of work by department and step.
*   **Daily totals:** Production output is reported by day, and each move must be grouped by its transaction date without the time.
*   **Scrap and over-completion:** Scrapped and over-completed quantities post to specific accounts, and they must be reviewed for each job.
*   **Repetitive scheduling:** A repetitive move is allocated across several schedules, and each allocation must be read against its own first unit start date.

## The Solution
*   Lists each move transaction with its date, the transaction day, the job or repetitive schedule and its job type, line and assembly.
*   Shows the from and to operation sequence, operation code, department and intraoperation step, so the path of a move through the routing is visible.
*   Shows the transaction quantity in the entered unit of measure and the primary quantity in the assembly's primary unit, with the over-completion quantity.
*   Shows the reason, reference, source code, the scrap account and the user who created the move.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_MOVE_TRANSACTIONS`: one row per move transaction, with the from and to operation, department, step, quantities, reason, reference and accounts.
*   `WIP_MOVE_TXN_ALLOCATIONS`: the allocation of a repetitive move to each repetitive schedule.
*   `WIP_REPETITIVE_SCHEDULES`: the repetitive schedule, with its first unit start date and allocated quantity.
*   `WIP_ENTITIES`: the job or schedule name and its entity type.
*   `WIP_LINES`: the production line of the move.
*   `MTL_SYSTEM_ITEMS_VL`: the assembly, with its concatenated segments and description.
*   `BOM_DEPARTMENTS`: the from and to departments.
*   `MTL_TRANSACTION_REASONS`: the reason of the move.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization and the organizations of the responsibility.

### Logical Relationships
1.  `WIP_MOVE_TRANSACTIONS` is joined to `WIP_MOVE_TXN_ALLOCATIONS` on the transaction id as an outer join, so a discrete move without allocations is still listed.
2.  The allocation is joined to `WIP_REPETITIVE_SCHEDULES` on the repetitive schedule id, which supplies the schedule start date.
3.  The move is joined to `WIP_ENTITIES` on the entity id, and to `WIP_LINES` on the line id and organization.
4.  The assembly is an outer join to `MTL_SYSTEM_ITEMS_VL` on the organization and primary item id.
5.  The from and to departments are joined to `BOM_DEPARTMENTS` on the department ids, and the reason to `MTL_TRANSACTION_REASONS`.

## Parameters & Filtering
*   **Organization Code:** restricts the moves to one inventory organization.
*   **Date From** and **Date To:** bound the transaction dates of the moves.
*   **Job** and **Line:** select one job or one production line.
*   **Assembly:** selects the moves of one item.
*   **From Department** and **To Department:** select the moves that started in, or arrived at, one department.
*   **From Step** and **To Step:** select the moves by intraoperation step.
*   **Reason:** selects the moves with one reason.

## Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, so the move table is read only for the responsibility's organizations.
*   The allocation and schedule joins are outer joins on keys, so a move returns one row for each allocation, and one row when it has none.
*   The department joins are inner joins on the department ids of the move, which removes moves without a valid from or to department.
*   Restricting Date From and Date To reduces the move rows first, because the move table grows with every transaction.

## FAQ
**Q: How do I total the moves of a day for a department?**
A: Use the Transaction Day column, which is the transaction date without the time, and sum the Primary Quantity column by To Department.

**Q: Why does a repetitive move appear more than once?**
A: A repetitive move is shown once for each repetitive schedule it was allocated to, with that schedule's first unit start date and the allocated quantity.

**Q: Are pending move transactions included?**
A: No. Transactions that are still pending in the move transaction interface are not included in the report.
