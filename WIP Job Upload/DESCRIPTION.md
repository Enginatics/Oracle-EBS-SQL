# Case Study & Technical Analysis: WIP Job Upload

## Executive Summary
The WIP Job Upload creates and updates Oracle Work in Process discrete jobs, both standard and non-standard, together with their operations, resources and material requirements (components). Several inventory organizations can be combined in one file, and the upload submits a separate WIP Mass Load run for each organization. Production planners and manufacturing engineers use it to release large numbers of jobs from a schedule, to load job details from a planning spreadsheet and to change the dates, quantities and status of existing jobs. Blitz Report downloads the jobs with their details, so the spreadsheet can be edited and uploaded again.

## Business Challenge
*   **Mass job release:** A production schedule can call for hundreds of jobs, each with operations, resources and components, and entering them in the Discrete Jobs form is slow.
*   **Complete job detail:** The operations, resources and components of a job must all be entered, or the job's cost and material picture is incomplete.
*   **Scheduling accuracy:** A job scheduled from its routing needs a start or completion date, and the other end must be calculated from the routing lead times.
*   **Traceability:** Uploaded rows must be traceable to the job name that Oracle assigns, so the spreadsheet and the system can be reconciled.

## The Solution
*   Downloads the discrete jobs of the selected organizations, with the header fields, the operations and resources of each job, and the components when Download Components is set.
*   Accepts header, operation, resource and component fields in one upload row, so detail can be entered without separate row types.
*   Explodes the bill of material and routing for new jobs that have no detail lines in the upload, and keeps manually entered detail unchanged.
*   Schedules a job forward from its start date or backward from its completion date, using the routing lead times, and stores the dates verbatim for jobs without a routing.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_ENTITIES`: the job entity and its name, which is the job name in the system.
*   `WIP_DISCRETE_JOBS`: the job header, with type, status, quantities, dates, assembly, routing reference, schedule group, line, project and task.
*   `WIP_OPERATIONS` and `WIP_OPERATION_RESOURCES`: the operations of a job and the resources each operation uses.
*   `WIP_REQUIREMENT_OPERATIONS`: the material requirements of a job, the components.
*   `BOM_STANDARD_OPERATIONS`, `BOM_DEPARTMENTS`, `BOM_RESOURCES` and `CST_ACTIVITIES`: the operation codes, departments, resource codes and activities.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_ITEM_LOCATIONS_KFV`: the assembly, component and locator names.
*   `WIP_SCHEDULE_GROUPS`, `WIP_LINES`, `PJM_PROJECTS_MTLL_V` and `PA_TASKS`: the schedule group, line, project and task.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization code and the organizations of the responsibility.

### Logical Relationships
1.  `MTL_PARAMETERS` is joined to `WIP_DISCRETE_JOBS` on the organization id, and the job to `WIP_ENTITIES` on the entity id.
2.  Operations are outer joined to the job, and resources to the operations, on entity, operation sequence and organization.
3.  Components are read from `WIP_REQUIREMENT_OPERATIONS` for the same job, excluding supply type 6 and operation sequence zero.
4.  The operation branch and the component branch are combined with UNION ALL, so a header-only job still returns one row.
5.  The assembly, routing reference and BOM reference are scalar lookups on `MTL_SYSTEM_ITEMS_VL` through the inventory item ids.

## Parameters & Filtering
*   **Upload Mode** and **Auto Generate Job Name:** control whether jobs are created, updated or both, and whether job names are generated.
*   **Download Operations** and **Download Components:** choose whether operation, resource and component rows are included.
*   **Organization Code**, **Job**, **Job From** and **Job To**, **Job Status** and **Type** select the jobs.
*   **Assembly**, **Class**, **Schedule Group**, **Line**, **Project Number** and **Task Number** select jobs by item, class and scheduling attributes.

## Performance & Optimization
*   The organization access check is a subquery on `ORG_ACCESS_VIEW`, so each run reads only the organizations of the responsibility.
*   Operation and resource joins are switched on only when Download Operations is Y, so a header-only download skips the detail tables.
*   Component rows are read only when Download Components is Y, which keeps large material requirement sets out of a header download.
*   Lookups for assembly, item, schedule group and project are scalar subqueries on keys, so each job row adds a fixed number of lookups.

## FAQ
**Q: How do I release many jobs with their operations and components in one file?**
A: Download with Download Operations and Download Components set to Y, add the rows for the new jobs, and upload. Each job's rows are processed together, so a job is either processed in full or not at all.

**Q: Why are the operations of a new job not exploded automatically?**
A: By default the bill of material and routing are exploded only for new jobs with no detail lines in the upload. The hidden Explode Bom and Routing column overrides this default.
