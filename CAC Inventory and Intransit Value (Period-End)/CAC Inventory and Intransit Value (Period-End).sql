/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory and Intransit Value (Period-End)
-- Description: Report showing amount of inventory at the end of the month. If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot. In either case this report uses the month-end quantities, based on the entered period name. And as these quantities come from the month-end snapshot (created when you close the inventory accounting period) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.
-- Note: if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.
-- / +=============================================================================+
-- -- | Copyright 2009 - 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Parameters:
-- -- | pperiodname -- Accounting period you wish to report for
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all ledgers (optional)
-- -- | pcosttype -- Enter a Cost Type to value the quantities using the Cost Type Item Costs; or, if
-- -- | Cost Type is blank or null the report will use the stored month-end snapshot values
-- -- | pcategoryset1 -- The first item category set to report, typically the Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the Inventory Category Set
-- -- | pitemnumber -- The part or item number you wish to report (optional)
-- -- | psubinventory -- The specific subinventory you wish to report (optional)
-- -- |
-- -- | ===================================================================
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 27 Sep 2009 Douglas Volz Initial Coding
-- -- | 1.1 28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- -- | 1.16 23 Apr 2020 Douglas Volz Changed to multi-language views for the item master,
-- -- | item categories and operating units. Used mfglookups for "Intransit".
-- -- | 1.17 05 Mar 2022 Douglas Volz Use With statement for category, subinventory and intransit valuation accounts.
-- -- | And changed from four union all statements to only two.
-- -- | 1.18 11 Mar 2022 Douglas Volz Performance improvements for category accounting
-- -- | 1.19 20 Mar 2022 Douglas Volz Fix for category accounts (valuation accounts) and
-- -- | added subinventory description.
-- -- | 1.20 19 Oct 2022 Douglas Volz Fix for valuation accounts, causing duplicate rows.
-- -- | 1.21 21 Oct 2022 Douglas Volz Fix for detecting Cost Group Accounting.
-- -- | 1.22 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/
-- Run Report: https://demo.enginatics.com/

select
y.ledger,
y.operating_unit,
y.org_code,
y.period_name,
&segment_columns
y.item_number,
y.item_description,
xxen_util.meaning(y.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
&category_columns
y.currency_code,
round(decode(cic.inventory_item_id,null,y.rollback_value/decode(y.rollback_quantity,0,1,y.rollback_quantity),cic.item_cost),5) item_cost,
nvl(y.subinventory_code,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700)) subinventory_or_intransit,
decode(y.subinventory_code,null,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700),y.subinventory_description) description,
xxen_util.yes(decode(y.asset_inventory,2,null,'Y')) asset,
y.primary_uom_code uom_code,
round(y.rollback_quantity,3) onhand_quantity,
round(decode(cic.inventory_item_id,null,y.rollback_value,y.rollback_quantity*cic.item_cost),2) onhand_value
from
(
select
x.*,
msub.description subinventory_description,
msub.asset_inventory,
case
when x.subinventory_code is null then (select min(mip.intransit_inv_account) from mtl_interorg_parameters mip where mip.fob_point=1 and mip.to_organization_id=x.organization_id or mip.fob_point=2 and mip.from_organization_id=x.organization_id)
when x.category_set_id is not null then
(
select
max(mca.material_account) keep (dense_rank first order by mca.subinventory_code nulls last)
from
mtl_item_categories mic,
mtl_category_accounts mca
where
x.organization_id=mic.organization_id and
x.inventory_item_id=mic.inventory_item_id and
x.category_set_id=mic.category_set_id and
mic.organization_id=mca.organization_id and
mic.category_id=mca.category_id and
(mca.subinventory_code=x.subinventory_code or mca.subinventory_code is null)
)
when x.cost_group_accounting='Y' then (select ccga.material_account from cst_cost_group_accounts ccga where nvl(msub.default_cost_group_id,x.default_cost_group_id)=ccga.cost_group_id and x.organization_id=ccga.organization_id)
else msub.material_account
end material_account
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
gl.currency_code,
mp.organization_id,
mp.default_cost_group_id,
case
when mp.cost_group_accounting=1 then 'Y'
when mp.organization_id in (select pop.organization_id from pjm_org_parameters pop) then 'Y'
when mp.primary_cost_method in (2,5,6) then 'Y'
when mp.process_enabled_flag='Y' then null
when mp.wms_enabled_flag='Y' then 'Y'
end cost_group_accounting,
(select max(mca.category_set_id) from mtl_category_accounts mca where mp.organization_id=mca.organization_id) category_set_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.primary_uom_code,
cpcs.subinventory_code,
sum(cpcs.rollback_quantity) rollback_quantity,
sum(cpcs.rollback_value) rollback_value
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
cst_period_close_summary cpcs,
mtl_system_items_vl msiv
where
1=1 and
2=2 and
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
oap.acct_period_id=cpcs.acct_period_id and
cpcs.rollback_quantity<>0 and
cpcs.organization_id=msiv.organization_id and
cpcs.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y'
group by
gl.short_name,
gl.name,
haouv_ou.name,
mp.organization_code,
oap.period_name,
gl.currency_code,
mp.organization_id,
mp.default_cost_group_id,
mp.cost_group_accounting,
mp.primary_cost_method,
mp.process_enabled_flag,
mp.wms_enabled_flag,
msiv.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.primary_uom_code,
cpcs.subinventory_code
) x,
mtl_secondary_inventories msub
where
x.organization_id=msub.organization_id(+) and
x.subinventory_code=msub.secondary_inventory_name(+)
) y,
mtl_item_status_vl misv,
gl_code_combinations gcc,
(select cic.organization_id, cic.inventory_item_id, nvl(cic.item_cost,0) item_cost from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type and cct.cost_type_id=cic.cost_type_id) cic
where
y.inventory_item_status_code=misv.inventory_item_status_code and
y.material_account=gcc.code_combination_id(+) and
y.organization_id=cic.organization_id(+) and
y.inventory_item_id=cic.inventory_item_id(+) and
(cic.inventory_item_id is not null or :p_cost_type is null)
order by
y.ledger,
y.operating_unit,
y.org_code,
y.item_number,
subinventory_or_intransit
