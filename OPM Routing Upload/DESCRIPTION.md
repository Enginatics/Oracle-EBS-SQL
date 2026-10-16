# Case Study & Technical Analysis: OPM Routing Upload

## Executive Summary
This upload creates and updates Oracle Process Manufacturing (OPM) routings, the step sequences that describe how a product is made, through the public routing and routing step APIs. Process engineers and manufacturing master-data teams use it to build many routings in one spreadsheet, with each step, its operation, quantities, release types and step dependencies, rather than entering them routing by routing. It is an R12 upload that runs in Excel through Blitz Report™.

## Business Challenge
*   **Routing volume:** A process manufacturer can maintain many routings, each with several steps, and building them through the forms is slow and repetitive.
*   **Consistent step structure:** Each step must reference an operation that already exists and is effective for the routing's dates, which is easy to get wrong when keyed by hand.
*   **Step dependencies:** Steps that must wait for predecessor steps need the dependency and its delay and transfer settings recorded correctly.
*   **Controlled change:** Once a routing is in use, only some of its header fields can be changed through the public API, and the team must know which.

## The Solution
*   Writes one spreadsheet row for each routing step, with the routing header columns repeated on every step of the same routing.
*   Creates the routing header and its steps through the routing and routing step public APIs, and updates the header fields and steps that the API permits.
*   Builds step dependencies from extra rows that repeat the step number and give a different predecessor, with the delay, transfer percentage, rework code and chargeable settings.
*   Downloads existing routings of an organization for review and editing when the Create, Update mode is used.

## Technical Architecture (High Level)
### Primary Tables
*   `GMD_ROUTINGS_VL`: the routing headers, with the routing number, version, description, class, unit of measure, quantity, process loss, effective dates, status, owner and the header flexfield.
*   `FM_ROUT_DTL`: the routing steps, with the step number, operation, step quantity, release type, minimum transfer quantity, operation yield and the step flexfield.
*   `GMD_OPERATIONS_VL`: the operations that each step references by operation number and version.
*   `GMD_STATUS_VL`: the routing status descriptions.
*   `FND_USER`: the owner of the routing.
*   `MTL_PARAMETERS`: the organization code of the owning organization.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

### Logical Relationships
1.  Each routing header in `GMD_ROUTINGS_VL` is joined to its steps in `FM_ROUT_DTL` on the routing identifier.
2.  Each step is joined to its operation in `GMD_OPERATIONS_VL` on the operation identifier, so the operation number and version are read from the operation.
3.  The owning organization is joined to `MTL_PARAMETERS` for the organization code.
4.  Only routings that are not marked for deletion and that belong to an organization the responsibility can access are kept.
5.  Header and step flexfield values are displayed under the routing header and routing step flexfield contexts.
6.  Each row is numbered by routing, version and step number, and the rows of one routing must be contiguous in the file.

## Parameters & Filtering
*   **Upload Mode:** selects Create, which gives an empty template, or Create, Update, which downloads existing routings for the chosen organization.
*   **Organization Code:** the owning organization of the routings to download or create.
*   **Routing:** limits the download to one routing number.

## Performance & Optimization
*   The routing-to-step join is an equality join on routing identifier, so the cost follows the number of steps in the selected routings.
*   The organization access restriction uses `ORG_ACCESS_VIEW` once for the session, which limits the routings before the step join.
*   The flexfield values for headers and steps are displayed per row, so routings with many populated flexfield segments take longer to download.
*   Rows of the same routing must be contiguous in the file, so the upload processes each routing's header and steps as one group.

## FAQ
**Q: Which routing fields can be changed on update?**
A: Through the public API, only the Status, Routing Class, Routing UOM, Fixed Process Loss UOM, Owner and Organization can be changed at header level, and steps can be added with their quantity, release type and yield updated.

**Q: How is a step made to depend on two predecessor steps?**
A: Repeat the step number on an extra row, leave Operation blank and enter a different Depends On Step No; each row adds one predecessor, and the dependency type is always Finish-to-Start.

**Q: Can the upload create an operation that does not exist?**
A: No, operations are referenced rather than created, so each Operation number and version must already exist in the routing's organization and be effective for the routing's dates.
