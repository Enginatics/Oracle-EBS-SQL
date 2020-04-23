/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Default Subinventories
-- Description: Invetory items default subinventories for shipping, receiving or move order receipt transactions
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-default-subinventories/
-- Library Link: https://www.enginatics.com/reports/inv-item-default-subinventories/
-- Run Report: https://demo.enginatics.com/

select
msiv.concatenated_segments item,
msiv.description item_description,
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
haouv.organization_id=misd.organization_id and
mp.organization_id=misd.organization_id and
misd.inventory_item_id=msiv.inventory_item_id and
misd.organization_id=msiv.organization_id
order by
msiv.concatenated_segments,
mp.organization_code,
default_type