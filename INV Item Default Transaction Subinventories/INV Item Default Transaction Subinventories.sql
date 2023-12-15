/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Default Transaction Subinventories
-- Description: Master data report of inventory item relationships including the type of relationship between the item and the subinventory.
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-default-transaction-subinventories/
-- Library Link: https://www.enginatics.com/reports/inv-item-default-transaction-subinventories/
-- Run Report: https://demo.enginatics.com/

select
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
xxen_util.meaning(misd.default_type,'MTL_DEFAULT_SUBINVENTORY',700) default_type,
misd.subinventory_code subinventory,
mp.organization_code,
haouv.name organization,
xxen_util.user_name(misd.created_by) created_by,
xxen_util.client_time(misd.creation_date) creation_date,
xxen_util.user_name(misd.last_updated_by) last_updated_by,
xxen_util.client_time(misd.last_update_date) last_update_date
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_item_sub_defaults misd,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
haouv.organization_id=misd.organization_id and
mp.organization_id=misd.organization_id and
misd.inventory_item_id=msiv.inventory_item_id and
misd.organization_id=msiv.organization_id
order by
msiv.concatenated_segments,
mp.organization_code,
default_type