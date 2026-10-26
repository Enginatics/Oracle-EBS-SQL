/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Onhand Lot Value (Real-Time)
-- Description: Report for onhand inventory at the time you run the report (real-time). By organization, Lot and Subinventory. If you leave the Cost Type blank the report will value the inventory using the inventory organization's Costing Method (Standard, Average, FIFO, LIFO). If you enter a Cost Type the report will use these item costs, plus, if any item costs are missing from the entered Cost Type, get the remaining item costs from the Costing Method Cost Type. Note that consigned quantities are reported but not valued. And if you choose to report expense subinventories, they are not valued either.
-- / +=============================================================================+
-- -- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxinventoryvalrept.sql
-- -- |
-- -- | Parameters:
-- -- | pperiodname -- Accounting period you wish to report for
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | pcosttype -- Enter a Cost Type to value the quantities
-- -- | using the Cost Type Item Costs; or, if
-- -- | Cost Type is blank or null the report will
-- -- | use the stored month-end snapshot values
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | ===================================================================
-- -- | Note: if you enter a cost type this script uses the item costs
-- -- | from the cost type; if you leave the cost type
-- -- | blank it uses the item costs from the month-end snapshot.
-- -- | ===================================================================
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 27 Sep 2009 Douglas Volz Initial Coding
-- -- | 1.1 28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- -- | 1.16 23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, item categories and operating units.
-- -- | Used mfglookups for "Intransit".
-- -- | 1.17 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-onhand-lot-value-real-time/
-- Library Link: https://www.enginatics.com/reports/cac-onhand-lot-value-real-time/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
haou.name organization_name,
msiv.concatenated_segments item_number,
msiv.description item_description,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.yes(msiv.inventory_asset_flag) asset,
xxen_util.yes(decode(x.is_consigned,1,'Y')) consigned,
&category_columns
gl.currency_code,
cic.item_cost,
x.lot_number,
x.expiration_date,
x.subinventory_code subinventory,
xxen_util.yes(decode(x.asset_inventory,2,null,'Y')) asset_subinventory,
(select ccg.cost_group from cst_cost_groups ccg where x.cost_group_id=ccg.cost_group_id) cost_group,
(select ppa.segment1 from mtl_item_locations mil, pa_projects_all ppa where x.locator_id=mil.inventory_location_id and mil.project_id=ppa.project_id) project,
msiv.primary_uom_code uom_code,
x.quantity onhand_quantity,
round(nvl(cic.material_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) material_value,
round(nvl(cic.material_overhead_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) material_overhead_value,
round(nvl(cic.resource_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) resource_value,
round(nvl(cic.outside_processing_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) outside_processing_value,
round(nvl(cic.overhead_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) overhead_value,
round(nvl(cic.item_cost,0)*decode(x.is_consigned,1,0,1)*x.quantity,2) onhand_value
from
(
select
mp.organization_code,
moqd.organization_id,
moqd.inventory_item_id,
moqd.lot_number,
mln.expiration_date,
moqd.locator_id,
moqd.subinventory_code,
moqd.cost_group_id,
msi.asset_inventory,
moqd.is_consigned,
sum(moqd.primary_transaction_quantity) quantity
from
mtl_parameters mp,
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msi,
mtl_lot_numbers mln
where
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=moqd.organization_id and
moqd.organization_id=msi.organization_id and
moqd.subinventory_code=msi.secondary_inventory_name and
moqd.organization_id=mln.organization_id(+) and
moqd.inventory_item_id=mln.inventory_item_id(+) and
moqd.lot_number=mln.lot_number(+)
group by
mp.organization_code,
moqd.organization_id,
moqd.inventory_item_id,
moqd.lot_number,
mln.expiration_date,
moqd.locator_id,
moqd.subinventory_code,
moqd.cost_group_id,
msi.asset_inventory,
moqd.is_consigned
having
sum(moqd.primary_transaction_quantity)<>0
) x,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
(
select
cic.organization_id,
cic.inventory_item_id,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost
from
mtl_parameters mp,
cst_item_costs cic
where
mp.organization_id=cic.organization_id and
(
cic.cost_type_id in (select cct.cost_type_id from cst_cost_types cct where 2=2 and :p_cost_type is not null) or
cic.cost_type_id=mp.primary_cost_method and not exists (select null from cst_item_costs cic2, cst_cost_types cct where cic.organization_id=cic2.organization_id and cic.inventory_item_id=cic2.inventory_item_id and cic2.cost_type_id=cct.cost_type_id and 2=2 and :p_cost_type is not null)
)
) cic
where
1=1 and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
x.organization_id=msiv.organization_id and
x.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
x.organization_id=cic.organization_id(+) and
x.inventory_item_id=cic.inventory_item_id(+)
order by
ledger,
operating_unit,
org_code,
item_number,
x.lot_number,
subinventory
