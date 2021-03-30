/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Relationships
-- Description: Master listing for Inventory item relationships
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-relationships/
-- Library Link: https://www.enginatics.com/reports/inv-item-relationships/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
msiv1.concatenated_segments from_item,
msiv1.description from_item_description,
msiv2.concatenated_segments to_item,
msiv2.description to_item_description,
xxen_util.meaning(mri.relationship_type_id,'MTL_RELATIONSHIP_TYPES',700) type,
decode(mri.reciprocal_flag,'Y','Y') reciprocal,
mri.planning_enabled_flag planning_enabled,
mri.start_date,
mri.end_date,
xxen_util.user_name(mri.created_by) created_by,
xxen_util.client_time(mri.creation_date) creation_date,
xxen_util.user_name(mri.last_updated_by) last_updated_by,
xxen_util.client_time(mri.last_update_date) last_update_date
from
mtl_parameters mp,
mtl_related_items mri,
mtl_system_items_vl msiv1,
mtl_system_items_vl msiv2
where
1=1 and
mp.organization_id=msiv1.organization_id and
mp.organization_id=msiv2.organization_id and
mri.inventory_item_id=msiv1.inventory_item_id and
mri.related_item_id=msiv2.inventory_item_id
order by
mp.organization_code,
msiv1.concatenated_segments,
msiv2.concatenated_segments,
type