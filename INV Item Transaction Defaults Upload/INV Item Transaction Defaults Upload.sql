/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Transaction Defaults Upload
-- Description: This upload can be used to create and update Item transaction default subinventories and locators
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-transaction-defaults-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-transaction-defaults-upload/
-- Run Report: https://demo.enginatics.com/

select
x.* 
from
(
select
null action_,
null status_,
null message_,
null modified_columns_,
'SUBINVENTORY' default_type,
decode(misd.default_type,1,'Shipping',2,'Receiving',3,'Move Order Receipt') default_for,
haouv.name organization,
msiv.concatenated_segments item,
misd.subinventory_code subinventory,
null locator
from
mtl_item_sub_defaults misd,
hr_all_organization_units_vl  haouv,
mtl_system_items_vl msiv
where
haouv.organization_id=misd.organization_id and
msiv.organization_id=haouv.organization_id and
msiv.inventory_item_id=misd.inventory_item_id and
1=1
union all 
select
null action_,
null status_,
null message_,
null modified_columns_,
'LOCATOR' default_type,
decode(mild.default_type,1,'Shipping',2,'Receiving',3,'Move Order Receipt') default_for,
haouv.name organization,
msiv.concatenated_segments item,
mild.subinventory_code subinventory,
milk.concatenated_segments locator
from
mtl_item_loc_defaults mild,
hr_all_organization_units_vl  haouv,
mtl_system_items_vl msiv,
mtl_item_locations_kfv milk
where
haouv.organization_id=mild.organization_id and
msiv.organization_id=haouv.organization_id and
msiv.inventory_item_id=mild.inventory_item_id and
mild.locator_id=milk.inventory_location_id and
mild.organization_id=milk.organization_id and
1=1
) x
where
2=2