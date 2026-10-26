/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item ABC Assignment Upload
-- Description: Assigns items to ABC classes within an ABC assignment group, changes an item's ABC class, or removes the assignment, as the ABC Assignment Updates window (Inventory > Planning > ABC Codes > ABC Assignments).
-- The ABC group and its classes are set up in the ABC Groups window; an item can be assigned to any class of the group, also when the ABC compile did not include it.
-- Excel Example Output: https://www.enginatics.com/example/inv-item-abc-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-abc-assignment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
maag.assignment_group_name abc_group,
msiv.concatenated_segments item,
msiv.description item_description,
mac.abc_class_name abc_class,
mac.description abc_class_description,
null delete_assignment,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_abc_assignment_groups maag,
mtl_abc_assignments maa,
mtl_abc_classes mac,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=maag.organization_id and
maag.assignment_group_id=maa.assignment_group_id and
maa.abc_class_id=mac.abc_class_id and
maa.inventory_item_id=msiv.inventory_item_id and
maag.organization_id=msiv.organization_id
