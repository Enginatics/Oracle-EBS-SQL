# Case Study & Technical Analysis: EAM PM Schedule Upload

## Executive Summary
This upload creates and updates Oracle Enterprise Asset Management preventive maintenance schedules. A schedule covers the header for an asset or asset group, its activity group, its scheduling rules and optional last service readings. Maintenance planners use it to set up or revise the service plan for a plant's equipment in one workbook, rather than through the Preventive Maintenance form asset by asset. It is used by EAM administrators and planners who maintain large fleets of meter-based and calendar-based services. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Large service plans:** Each asset can carry several activities, each with its own interval, and maintaining them one at a time is slow.
*   **Mixed scheduling rules:** Runtime or meter intervals, day intervals and fixed list dates must be combined correctly on one schedule.
*   **Continuity of service history:** Last service readings and dates determine when the next service falls due, and they must be carried into the new schedule.
*   **Set name governance:** Schedules that share a set name must reference a consistent set, which may need to be created on the fly.

## The Solution
*   **Row model by column group:** A row can hold header values, an activity entry, a scheduling rule and a last service reading, and the upload infers the level from the populated columns.
*   **Activity entries:** Each Act Activity column adds an activity to a rule-based schedule, with its interval multiple and repeat flag.
*   **Scheduling rules:** Day Interval, Runtime Meter and List Date rules are added, changed in place, or removed with Delete Rule.
*   **Last service readings:** Last service readings are uploaded per meter, and the last service dates recorded by work order completion are shown read only.
*   **Set name creation:** A new Set Name can be entered with its description, end date and local flag, and the upload creates it.

## Technical Architecture (High Level)
### Primary Tables
*   `EAM_PM_SCHEDULINGS`: the PM schedule header, with type, scheduling method, rescheduling point, base date, base reading and effectivity dates.
*   `EAM_PM_ACTIVITIES`: the activity associations of each schedule, with the activity association id.
*   `EAM_PM_SCHEDULING_RULES`: the day interval, meter and list date rules attached to a schedule.
*   `EAM_PM_LAST_SERVICE`: the last service readings and previous readings per meter and work order job.
*   `EAM_PM_SET_NAMES`: the PM set names.
*   `MTL_EAM_ASSET_ACTIVITIES`: the activities defined for an asset.
*   `CSI_ITEM_INSTANCES` and `MTL_SYSTEM_ITEMS_B_KFV`: the asset instance and the asset group or activity item.
*   `CSI_COUNTERS_VL`: the meters used by runtime rules and last service readings.
*   `EAM_WO_STATUSES_V` and `WIP_ENTITIES`: the work order status for generation and the job for a last service reading.

### Logical Relationships
1. `EAM_PM_SCHEDULINGS` is the header source. Its activity association id falls back to the first activity of the schedule when none is set.
2. The header joins to `CSI_ITEM_INSTANCES` for asset maintenance objects, and to `MTL_SYSTEM_ITEMS_B_KFV` for asset groups.
3. The activity joins through `MTL_EAM_ASSET_ACTIVITIES` to the activity item, on activity association and organization.
4. Rule rows join `EAM_PM_SCHEDULING_RULES` to the header on schedule id, and the meter joins to `CSI_COUNTERS_VL` as an outer join.
5. Last service rows join `EAM_PM_LAST_SERVICE` on the activity association, and the job joins to `WIP_ENTITIES` as an outer join.
6. The three row sets are combined with UNION ALL, and each set is included only when its update flag is Y.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing schedules.
*   **Organization:** restricts the schedules to one organization, limited to those the responsibility can access.
*   **Update Activities:** includes the activity rows in the download, and defaults to Yes.
*   **Update Rules:** includes the scheduling rule rows in the download.
*   **Update Last Service:** includes the last service rows in the download.

## Performance & Optimization
*   The organization test on `ORG_ACCESS_VIEW` limits every block to the organizations the responsibility can access.
*   Each child block is included only when its parameter is Y, so a header-only download does not read rules or last service data.
*   The activity lookup falls back to a minimum activity association id per schedule, which gives each schedule one deterministic header row.

## FAQ
**Q: Why do my work orders not appear after I upload a schedule?**
A: Uploading a schedule does not generate work orders. Run the Create Preventive Maintenance Work Order concurrent program after the upload.

**Q: How do I remove a scheduling rule?**
A: Set Delete Rule on the rule row. A changed rule is updated in place, and a rule row without a rule id is added.
