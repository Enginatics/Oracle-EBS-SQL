# Case Study & Technical Analysis: EAM PM Schedule Upload 11i

## Executive Summary
The EAM PM Schedule Upload 11i creates and maintains Preventive Maintenance (PM) schedule definitions in Oracle Enterprise Asset Management. Each spreadsheet can carry the PM header, its activity group, its scheduling rules and optional last-service readings for an asset or asset group. Maintenance planners and EAM implementation teams use it to set up or revise recurring maintenance programs for many assets at once, following the same rules as the Preventive Maintenance form. The report runs in Excel via Blitz Report. Uploading a schedule does not create work orders; the "XMLSG - Create Preventive Maintenance Work Order" concurrent program must be run afterwards.

## Business Challenge
*   **Large maintenance programs:** Defining day-interval, runtime-meter and list-date schedules one at a time through the form is slow across a fleet of assets.
*   **Rule consistency:** Each PM schedule combines a header, activities and rules, and inconsistent setup produces missed or duplicated services.
*   **Meter-based scheduling:** Runtime and meter rules depend on meter readings and last-service values that must be recorded accurately before scheduling works.
*   **Set name governance:** Shared PM set names must be reused or created consistently across organizations.

## The Solution
*   **Hierarchical row model:** Header, activity, rule and last-service columns share one spreadsheet, and the upload infers the object level from which column groups are populated.
*   **Form-equivalent processing:** A changed rule is updated in place, a Delete Rule entry removes a rule, and a rule row without a rule identifier is added.
*   **Set name handling:** An existing set name can be referenced, or a new one created with its description, end date and local flag.
*   **Selective child download:** Update Activities, Update Rules and Update Last Service control which child details appear in the downloaded template.

## Technical Architecture (High Level)
### Primary Tables
*   `EAM_PM_SCHEDULINGS`: the PM schedule header, including type, effective dates, rescheduling point and scheduling method.
*   `EAM_PM_SCHEDULING_RULES`: the day interval, runtime meter and list date rules attached to a schedule.
*   `EAM_PM_LAST_SERVICE`: last-service meter readings and work order links for each activity association.
*   `EAM_PM_SET_NAMES`: the named sets that group PM schedules.
*   `MTL_EAM_ASSET_ACTIVITIES`: the activity associations that link a maintenance object to a PM activity.
*   `MTL_SERIAL_NUMBERS`, `MTL_SYSTEM_ITEMS_B_KFV`: the asset numbers and the asset or asset group items.
*   `EAM_METERS`: the meter definitions referenced by rules and last-service readings.
*   `WIP_ENTITIES`: the work order entity referenced by last-service rows.
*   `MFG_LOOKUPS`: the work order status meanings.
*   `MTL_PARAMETERS`, `ORG_ACCESS_VIEW`: the EAM-enabled organizations and the responsibility security.

### Logical Relationships
1. `EAM_PM_SCHEDULINGS` is joined to `MTL_EAM_ASSET_ACTIVITIES` on activity_association_id, which gives the maintenance object and the activity.
2. The maintenance object is resolved to an asset through `MTL_SERIAL_NUMBERS` for asset-type objects, or to an asset group item through `MTL_SYSTEM_ITEMS_B_KFV` for group-type objects.
3. `MTL_PARAMETERS` is joined on organization and restricted to EAM-enabled organizations in `ORG_ACCESS_VIEW`.
4. `EAM_PM_SET_NAMES` is joined on set_name_id, and `MFG_LOOKUPS` (WIP_JOB_STATUS) supplies the work order status.
5. Rules from `EAM_PM_SCHEDULING_RULES` and `EAM_METERS` are unioned to the header, as are last-service rows from `EAM_PM_LAST_SERVICE` joined to `WIP_ENTITIES` and `EAM_METERS`, each with a row sort that orders the output.

## Parameters & Filtering
*   **Upload Mode:** Create returns an empty spreadsheet for new schedules, and Create, Update downloads existing schedules for editing.
*   **Organization:** Restricts the schedules to an EAM-enabled organization that the responsibility can access.
*   **Update Activities:** Includes the activity group rows in the template; the SQL applies it through a bind comparison, and it defaults to Yes in the upload.
*   **Update Rules:** When Y, the day interval, runtime meter and list date rules of each schedule are included.
*   **Update Last Service:** When Y, the last-service readings per meter are included.

PM templates (the tmpl_flag condition) are excluded from the download.

## Performance & Optimization
*   The base query filters out template schedules and restricts organizations to EAM-enabled ones that the responsibility can access, before any child rows are added.
*   The header is produced once per schedule, and the activity, rule and last-service sections are each added by a separate `UNION ALL` branch that is switched off by its bind flag.
*   Asset and asset group item descriptions are resolved with left joins to `MTL_SYSTEM_ITEMS_B_KFV`, so schedules without an asset still appear.

## FAQ
**Q: Why is no work order created after a PM schedule upload?**
A: The upload saves the schedule only. The description states that the "XMLSG - Create Preventive Maintenance Work Order" concurrent program must be scheduled and run afterwards.

**Q: How do I delete a scheduling rule through the upload?**
A: Enter Yes in the Delete Rule column on the rule row, using the rule identifier from the downloaded template.

**Q: Can a new PM set name be created during the upload?**
A: Yes. Enter a new Set Name with Set Name Description, End Date and Local Flag, and the upload creates it through the EAM set name API.
