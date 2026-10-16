# Case Study & Technical Analysis: WIP Material Transaction Upload

## Executive Summary
This upload issues components to, and returns components from, Oracle Work in Process (WIP) jobs. The download returns one row for each component requirement of the selected jobs, with the operation, department, supply subinventory and locator filled in and the required, issued and open quantities shown. Shop floor supervisors and material controllers use it to issue many components to jobs at once, and to return unused material, in one spreadsheet. It is an R12 upload that runs in Excel through Blitz Report™.

## Business Challenge
*   **Batch material issue:** A job can need many components across several operations, and issuing them line by line in the WIP Material Transactions form is slow.
*   **Open requirements:** Planners need to see, for each component, how much of the requirement has already been issued and how much is still open.
*   **Correct stock source:** Each component must come from its supply subinventory and locator, which are often fixed for the requirement.
*   **Returns:** Material issued in excess must be returned to inventory against the same job, with the same accounting as the original issue.

## The Solution
*   Lists the component requirements of the selected discrete, lot-based and maintenance jobs, with the operation sequence, department, supply subinventory and locator already filled in.
*   Shows the date required, required quantity, quantity issued and open quantity of each requirement, so that the quantity left to issue is visible.
*   Lets the user enter a Transaction Type and a positive quantity on the rows to transact, and leaves the direction to the Transaction Type.
*   Stages the transactions in the inventory transaction interface, so they are processed by the inventory transaction manager in the same way as transactions entered in the WIP Material Transactions form.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_ENTITIES`: the jobs, with the job name and entity type.
*   `WIP_DISCRETE_JOBS`: the discrete job header, with the job status type and the assembly item.
*   `WIP_REQUIREMENT_OPERATIONS`: the component requirements of each job, with operation, department, supply type, date required, required and issued quantities, supply subinventory and supply locator.
*   `MTL_SYSTEM_ITEMS_VL`: the component item, and the assembly item through a second alias.
*   `MTL_UNITS_OF_MEASURE_VL`: the primary unit of measure of the component.
*   `BOM_DEPARTMENTS`: the department of each requirement.
*   `MTL_ITEM_LOCATIONS_KFV`: the supply locator of each requirement.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code of each job.

### Logical Relationships
1.  Each job in `WIP_ENTITIES` is joined to its organization and restricted to entity types 1, 5 and 6, which are the discrete, lot-based and maintenance job types.
2.  Each job is joined to its discrete job header on the entity and organization.
3.  Each requirement in `WIP_REQUIREMENT_OPERATIONS` is joined to its job and excludes repetitive schedule requirements, which the report does not support.
4.  The component is joined to its item in `MTL_SYSTEM_ITEMS_VL`, and the assembly is joined through the job's primary item.
5.  The department and the supply locator are outer-joined, so requirements without them are still listed.
6.  Open quantity is the required quantity less the quantity already issued, and each row is numbered as the upload row.

## Parameters & Filtering
*   **Upload Mode:** selects the upload mode of the file, which determines whether the requirements are downloaded for transacting.
*   **Organization Code:** limits the jobs to one inventory organization.
*   **Job** and **Job Status:** select jobs by name and by their status.
*   **Assembly** and **Component:** select jobs by their assembly and requirements by their component.
*   **Department:** restricts the requirements to one department.
*   **Date Required From** and **To:** bound the requirements by date required.
*   **Open Requirements Only:** restricts the output to requirements that still have an open quantity.

## Performance & Optimization
*   The requirement table is joined to the job table on the entity and organization, so the job filters limit the requirement rows that are read.
*   Repetitive schedule requirements are excluded at the requirement join, so the report reads only discrete and maintenance requirements.
*   Department and locator lookups are outer joins on identifiers, so the cost is one keyed lookup per requirement.
*   Each row carries a row number as its upload key, so the rows can be matched back to the requirement after the file is edited.

## FAQ
**Q: How is the direction of a transaction chosen?**
A: The Transaction Type decides the direction, and the Quantity is always entered as a positive number.

**Q: Which jobs can be transacted with this upload?**
A: Discrete jobs, lot-based jobs and maintenance work orders are supported, but repetitive schedules are not.

**Q: Are these transactions the same as those from the WIP Material Transactions form?**
A: Yes, the rows are staged in the inventory transaction interface and processed by the inventory transaction manager, so the resulting transactions and their effect on the requirement are the same as those of the form.
