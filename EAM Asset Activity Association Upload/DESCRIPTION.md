# Case Study & Technical Analysis: EAM Asset Activity Association Upload

## Executive Summary
The EAM Asset Activity Association Upload report maintains the links between maintenance activities and the assets they apply to in Oracle Enterprise Asset Management. An activity is linked to an asset group, a specific asset number, or a rebuildable item, and each link carries its own dates, priority, cause, type, shutdown type, owning department and WIP accounting class. Maintenance planners and EAM administrators use the Excel upload to create new associations, update existing ones in bulk, and review current settings, in place of maintaining each association record by record in the application.

## Business Challenge
*   **Large maintenance libraries:** Plants with many assets and recurring activities need many activity associations, which are slow to create one by one.
*   **Consistent planning attributes:** Priority, cause, type, shutdown type, source and tagging requirement must be set consistently across assets of the same class.
*   **Ownership and accounting:** Each association names an owning department and a WIP accounting class, and these determine who executes the work and how it is costed.
*   **Start and end control:** Activities that apply only for a period need active from and to dates maintained in bulk.

## The Solution
*   **Create and update in one file:** The upload creates associations that do not exist and updates existing ones, using the activity, maintenance object type and maintenance object as the business key.
*   **Full attribute coverage:** Dates, priority, cause, activity type, shutdown type, activity source, owning department, WIP class, tagging flag and the descriptive flexfield attributes can all be set in the file.
*   **Readable codes:** Coded attributes are displayed with their meanings, so the file can be reviewed without looking up lookup codes.
*   **Prerequisite checks:** The description lists the items and instances that must already exist, so a failed row can be traced to a missing setup object.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_EAM_ASSET_ACTIVITIES`: the activity association, with its object type, object ID, dates, codes, department, class and flexfield attributes.
*   `MTL_PARAMETERS`: the maintenance organization, which supplies the organization code.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the activity item and the asset group or rebuildable item, joined twice under different aliases.
*   `CSI_ITEM_INSTANCES`: the serialised instance of an asset, found from the instance ID when the object type is an asset number.
*   `BOM_DEPARTMENTS`: the owning department.

### Logical Relationships
1.  `MTL_EAM_ASSET_ACTIVITIES` is joined to `MTL_PARAMETERS` on organization ID, which supplies the maintenance organization code.
2.  The activity item is joined on the asset activity item ID and the organization, so each row shows the activity name.
3.  The asset group or rebuildable item is outer joined on the inventory item ID and organization, so activity associations with an asset number still appear.
4.  `CSI_ITEM_INSTANCES` is outer joined only when the maintenance object type is 3, using the maintenance object ID as the instance ID.
5.  The owning department is outer joined to `BOM_DEPARTMENTS`, and template activities are excluded through the template flag.

## Parameters & Filtering
*   **Upload Mode:** Selects the update behaviour. The query returns rows only when the mode includes update.
*   **Maintenance Organization:** Limits the associations to one maintenance organization.
*   **Activity:** Limits the rows to one activity item.

## Performance & Optimization
*   **Organization-driven filter:** The join to `MTL_PARAMETERS` and the maintenance organization parameter keep the scan within one maintenance organization.
*   **Template activities excluded:** The template flag test removes template rows, so only live associations are returned.
*   **Conditional instance join:** `CSI_ITEM_INSTANCES` is reached only through a decode that returns the instance ID for object type 3, so other rows are not matched to instances.
*   **Outer joins for optional objects:** Asset groups, instances and departments are outer joined, so associations without those values are retained.

## FAQ
**Q: Can I delete an asset activity association with this upload?**
A: The description states that deletion is not supported by the public API in this version, so existing associations are created or updated only.
**Q: What must exist before I upload an association?**
A: The activity item must already exist in the maintenance organization, and the asset group, asset instance or rebuildable item must exist in the item and instance setup. The description recommends the INV Item Upload for creating activity items.
**Q: How does the upload decide whether to create or update a row?**
A: It uses the activity, the maintenance object type and the maintenance object ID as the natural key, which maps to the activity and either the asset group or the asset number.
