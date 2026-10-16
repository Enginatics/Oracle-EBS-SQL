# Case Study & Technical Analysis: EAM Work Requests

## Executive Summary
The EAM Work Requests report lists maintenance work requests in Oracle Enterprise Asset Management, one row per request. Each row shows the requested asset, its priority and type, the requester and the contact details, and the work order that was created from the request, if any. Maintenance coordinators and planners use it to see the open request backlog, the age of each request, and which requests are overdue against their expected resolution date. The report runs in Excel through Blitz Report, so the backlog can be sorted and shared with maintenance supervisors.

## Business Challenge
*   **Request backlog control:** Requests submitted by operators and departments must be triaged, and those without a work order must be identified before they are forgotten.
*   **Service level tracking:** Overdue requests, measured against the expected resolution date, need to be visible to the maintenance supervisor.
*   **Traceability to work orders:** Each request must be linked to its work order and the status of that work order, so that completion can be confirmed.
*   **Asset and department accountability:** Requests must be attributed to the owning department and the asset group that will carry the repair.

## The Solution
*   **Request register:** The report reads the work request register for the organization and presents the request number, description, status, priority, request type and asset.
*   **Ageing measures:** Days Open is calculated from the creation date for requests that are neither rejected nor complete, and Overdue flags open requests whose expected resolution date has passed.
*   **Work order link:** The linked work order name, its system status, and its scheduled and completion dates are shown beside the request.
*   **Requester details:** The requester, the person it was created for, the contact preference, phone and e-mail are resolved to readable values.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_EAM_WORK_REQUESTS`: the work request register, holding the request number, status, priority, type, asset, dates and contact details.
*   `MTL_PARAMETERS`: the maintenance organization code.
*   `MTL_SYSTEM_ITEMS_VL`: the asset group item and its description.
*   `BOM_DEPARTMENTS`: the owning department of the request.
*   `WIP_ENTITIES`: the work order entity created from the request.
*   `WIP_DISCRETE_JOBS`: the work order status type and its scheduled and completion dates.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  `WIP_EAM_WORK_REQUESTS` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  The request joins to `MTL_SYSTEM_ITEMS_VL` on the asset group and organization, as an outer join, so requests without an asset group are kept.
3.  The request joins to `BOM_DEPARTMENTS` on the owning department ID, again as an outer join.
4.  The request joins to `WIP_ENTITIES` on the work order entity ID, and then to `WIP_DISCRETE_JOBS` on the same entity ID.
5.  Output is ordered by organization code, creation date descending and request number.

## Parameters & Filtering
*   **Organization Code:** selects the maintenance organization.
*   **Creation Date From** and **Creation Date To:** bound the creation date of the request.
*   **Status:** filters on the work request status.
*   **Open Only:** restricts the output to requests that are still open.
*   **Without Work Order:** shows only requests that have no work order yet.
*   **Priority** and **Request Type:** filter by the priority and type of the request.
*   **Owning Department:** filters on the department that owns the request.
*   **Asset Group** and **Asset Number:** limit the requests to one asset group or asset.

## Performance & Optimization
*   The main query starts from the request register, so the driving filter is the organization set from `ORG_ACCESS_VIEW` and the creation date range.
*   The work order link uses outer joins, so requests without a work order are returned without a second query.
*   Days Open and Overdue are computed as simple expressions on the request row, so no additional lookup table is needed.
*   Names of users and the lookup meanings are produced by `XXEN_UTIL` functions, which keeps the SQL to one pass over the register.

## FAQ
**Q: How are overdue work requests identified in this report?**
A: A request is marked overdue when its status is neither rejected nor complete and its expected resolution date is earlier than the current date.

**Q: How many days has a work request been open?**
A: The Days Open column is the number of days between the creation date and the current date, shown only for requests that are neither rejected nor complete.

**Q: How can I find requests that have not yet been turned into work orders?**
A: Set the Without Work Order parameter, which returns only requests with no linked work order.
