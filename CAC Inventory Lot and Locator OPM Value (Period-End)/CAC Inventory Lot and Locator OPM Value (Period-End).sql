/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Lot and Locator OPM Value (Period-End)
-- Description: Report showing amount of inventory at the end of the month for Process Manufacturing (OPM) inventory organizations, for both onhand and intransit inventory. If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot. In either case this report uses the month-end quantities, based on the entered period name, calendar code and period code. As these quantities come from the month-end snapshot, this also also allows you to specify the lot number and locator (row/rack/bin) for your onhand quantities. And as a default valuation account, this report uses the Material Account from your subinventory setups and your Intransit Account from your Shipping Network setups.
-- Note: OPM intransit balances based upon last two years of Intransit Shipments. As of Release 12.2.13, OPM does not have a month-end snapshot for intransit quantities or balances.
-- General Parameters:
-- ===================
-- Period Name (Closed): the closed inventory accounting period you wish to report (mandatory).
-- Cost Type: enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
-- Show OPM Lot Number: choose Yes to show the OPM lot number for the inventory quantities. Otherwise choose No (mandatory).
-- Show OPM Locator: choose Yes to show the OPM locator and Lot Expiration Date for the inventory quantities. Otherwise choose No (mandatory).
-- OPM Calendar Code: Choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory).
-- OPM Period Code: enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: The second item category set to report, typically the Inventory Category Set (optional).
-- Item Number: specific buy or make item you wish to report (optional).
-- Subinventory: specific area within the warehouse or inventory area you wish to report (optional).
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional).
-- Ledger: specific ledger (optional).
-- / +=============================================================================+
-- -- | Copyright 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 10 May 2024 Douglas Volz Initial Coding.
-- -- | 1.1 30 Jun 2024 Douglas Volz Cumulative fixes for OPM intransit balances and accounts.
-- -- | 1.2 02 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs and qtys.
-- -- | 1.3 30 Sep 2024 Douglas Volz Add Lot expiration date to report.
-- -- | 1.4 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-lot-and-locator-opm-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-lot-and-locator-opm-value-period-end/
-- Run Report: https://demo.enginatics.com/

with mp as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
mp.organization_id,
to_number(hoi.org_information2) legal_entity_id,
nvl(cwa.cost_organization_id,mp.organization_id) cost_organization_id,
mp.intransit_inv_account,
gl.currency_code
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cm_whse_asc cwa
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.process_enabled_flag='Y' and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cwa.organization_id(+)
),
c as (
select /*+ materialize*/
mp.organization_id,
gic.inventory_item_id,
round(nvl(gic.acctg_cost,0),9) item_cost
from
mp,
gmf_fiscal_policies gfp,
gmf_period_statuses gps,
gl_item_cst gic
where
:p_cost_type is null and
7=7 and
8=8 and
mp.legal_entity_id=gfp.legal_entity_id and
gfp.legal_entity_id=gps.legal_entity_id and
gfp.cost_type_id=gps.cost_type_id and
gps.period_id=gic.period_id and
gps.cost_type_id=gic.cost_type_id and
mp.cost_organization_id=gic.organization_id and
gic.delete_mark=0
union all
select
mp.organization_id,
ccd.inventory_item_id,
round(sum(nvl(ccd.cmpnt_cost,0)),9) item_cost
from
mp,
gmf_period_statuses gps,
cm_mthd_mst cmm,
cm_cmpt_dtl ccd,
cm_cmpt_mst_b ccmb
where
:p_cost_type is not null and
5=5 and
7=7 and
8=8 and
mp.legal_entity_id=gps.legal_entity_id and
gps.cost_type_id=cmm.cost_type_id and
gps.period_id=ccd.period_id and
gps.cost_type_id=ccd.cost_type_id and
mp.cost_organization_id=ccd.organization_id and
ccd.delete_mark=0 and
ccd.cost_cmpntcls_id=ccmb.cost_cmpntcls_id and
ccmb.product_cost_ind=1
group by
mp.organization_id,
ccd.inventory_item_id
)
select
mp.ledger,
mp.operating_unit,
mp.organization_code org_code,
onhand.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
mp.currency_code,
c.item_cost,
onhand.subinventory_code subinventory_or_intransit,
regexp_replace(msub.description,'[^[:alnum:]'' '']',null) description,
&p_lot_number_opm
&p_locator_opm
xxen_util.meaning(msub.asset_inventory,'SYS_YES_NO',700) asset,
msiv.primary_uom_code uom_code,
sum(onhand.primary_quantity) onhand_quantity,
round(sum(onhand.primary_quantity*c.item_cost),2) onhand_value
from
mp,
(
select
gpb.organization_id,
gpb.inventory_item_id,
oap.period_name,
gpb.subinventory_code,
gpb.lot_number,
gpb.locator_id,
sum(gpb.primary_quantity) primary_quantity
from
mp,
org_acct_periods oap,
gmf_period_balances gpb
where
4=4 and
mp.organization_id=oap.organization_id and
oap.organization_id=gpb.organization_id and
oap.acct_period_id=gpb.acct_period_id
group by
gpb.organization_id,
gpb.inventory_item_id,
oap.period_name,
gpb.subinventory_code,
gpb.lot_number,
gpb.locator_id
having
sum(gpb.primary_quantity)<>0
) onhand,
c,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_secondary_inventories msub,
gl_code_combinations gcc,
mtl_item_locations_kfv milk,
mtl_material_statuses_vl mmsv,
mtl_lot_numbers mln
where
3=3 and
6=6 and
mp.organization_id=onhand.organization_id and
onhand.organization_id=c.organization_id and
onhand.inventory_item_id=c.inventory_item_id and
onhand.organization_id=msiv.organization_id and
onhand.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
onhand.organization_id=msub.organization_id and
onhand.subinventory_code=msub.secondary_inventory_name and
msub.asset_inventory=1 and
msub.material_account=gcc.code_combination_id(+) and
onhand.organization_id=milk.organization_id(+) and
onhand.locator_id=milk.inventory_location_id(+) and
milk.status_id=mmsv.status_id(+) and
onhand.organization_id=mln.organization_id(+) and
onhand.inventory_item_id=mln.inventory_item_id(+) and
onhand.lot_number=mln.lot_number(+)
group by
mp.ledger,
mp.operating_unit,
mp.organization_code,
onhand.period_name,
&segment_columns_grp
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
misv.inventory_item_status_code_tl,
msiv.planning_make_buy_code,
mp.currency_code,
c.item_cost,
onhand.subinventory_code,
msub.description,
&p_lot_number_opm_grp
&p_locator_opm_grp
msub.asset_inventory,
msiv.primary_uom_code,
onhand.inventory_item_id,
onhand.organization_id
union all
select
mp.ledger,
mp.operating_unit,
mp.organization_code org_code,
oap.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
mp.currency_code,
round(onhand.itr_item_cost,9) item_cost,
xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700) subinventory_or_intransit,
xxen_util.meaning(2,'CST_UPDATE_TXN_TYPE',700) description,
&p_lot_number_opm
&p_locator_opm
xxen_util.meaning(1,'SYS_YES_NO',700) asset,
msiv.primary_uom_code uom_code,
round(sum(onhand.intransit_quantity),3) onhand_quantity,
round(sum(onhand.itr_intransit_value),2) onhand_value
from
mp,
org_acct_periods oap,
(
select
x.organization_id,
x.from_organization_id,
x.inventory_item_id,
x.lot_number,
x.locator_id,
x.code_combination_id,
sum(x.itr_intransit_value)/decode(sum(x.intransit_quantity),0,1,sum(x.intransit_quantity)) itr_item_cost,
sum(x.intransit_quantity) intransit_quantity,
sum(x.itr_intransit_value) itr_intransit_value
from
(
select
y.organization_id,
y.from_organization_id,
y.inventory_item_id,
y.lot_number,
y.locator_id,
nvl(mip.intransit_inv_account,y.intransit_inv_account) code_combination_id,
y.intransit_quantity,
decode(:p_cost_type,null,decode(y.opm_processed_flag,'Y',nvl(y.itr_intransit_value,0),nvl(c.item_cost*y.intransit_quantity,0)),nvl(c.item_cost*y.intransit_quantity,0)) itr_intransit_value
from
(
select
decode(mmt.fob_point,1,mmt.transfer_organization_id,2,mmt.organization_id) organization_id,
decode(mmt.fob_point,1,mmt.organization_id,2,mmt.transfer_organization_id) from_organization_id,
mmt.inventory_item_id,
mtln.lot_number,
0 locator_id,
mp.intransit_inv_account,
decode(mmt.fob_point,1,inv_convert.inv_um_convert(mmt.inventory_item_id,null,-nvl(mtln.primary_quantity,mmt.primary_quantity),mmt.transaction_uom,msiv_to.primary_uom_code,null,null),2,-nvl(mtln.primary_quantity,mmt.primary_quantity)) intransit_quantity,
case
when mmt.fob_point=1 and mmt.transaction_id in (select mmt_child.parent_transaction_id from mtl_material_transactions mmt_child, gmf_xla_extract_headers gxeh where mmt_child.transaction_id=gxeh.transaction_id) then 'Y'
when mmt.fob_point=2 and mmt.transaction_id in (select gxeh.transaction_id from gmf_xla_extract_headers gxeh) then 'Y'
else 'N'
end opm_processed_flag,
decode(mmt.fob_point,
1,(select nvl(sum(gxel.component_cost),0) from mtl_material_transactions mmt_child, gmf_xla_extract_headers gxeh, gmf_xla_extract_lines gxel, gmf_fiscal_policies gfp where mmt.transaction_id=mmt_child.parent_transaction_id and mmt_child.transaction_id=gxeh.transaction_id and gxeh.header_id=gxel.header_id and gxel.journal_line_type='ITR' and gxeh.legal_entity_id=gfp.legal_entity_id and gxeh.valuation_cost_type_id=gfp.cost_type_id)*inv_convert.inv_um_convert(mmt.inventory_item_id,null,-nvl(mtln.primary_quantity,mmt.primary_quantity),mmt.transaction_uom,msiv_to.primary_uom_code,null,null),
2,(select nvl(sum(gxel.component_cost),0) from gmf_xla_extract_headers gxeh, gmf_xla_extract_lines gxel, gmf_fiscal_policies gfp where mmt.transaction_id=gxeh.transaction_id and gxeh.header_id=gxel.header_id and gxel.journal_line_type='ITR' and gxeh.legal_entity_id=gfp.legal_entity_id and gxeh.valuation_cost_type_id=gfp.cost_type_id)*-nvl(mtln.primary_quantity,mmt.primary_quantity)
) itr_intransit_value
from
mp,
org_acct_periods oap,
mtl_material_transactions mmt,
mtl_transaction_lot_numbers mtln,
mtl_system_items_vl msiv_to
where
4=4 and
mp.organization_id=oap.organization_id and
mmt.transaction_action_id=21 and
mmt.transaction_date>=oap.period_start_date-730 and
mmt.transaction_date<oap.schedule_close_date+1 and
decode(mmt.fob_point,1,mmt.transfer_organization_id,2,mmt.organization_id)=mp.organization_id and
mmt.transaction_id=mtln.transaction_id(+) and
mp.organization_id=msiv_to.organization_id and
mmt.inventory_item_id=msiv_to.inventory_item_id
union all
select
decode(mmt.fob_point,1,mmt.organization_id,2,mmt.transfer_organization_id) organization_id,
decode(mmt.fob_point,1,mmt.transfer_organization_id,2,mmt.organization_id) from_organization_id,
mmt.inventory_item_id,
mtln.lot_number,
0 locator_id,
mp.intransit_inv_account,
decode(mmt.fob_point,1,-nvl(mtln.primary_quantity,mmt.primary_quantity),2,inv_convert.inv_um_convert(mmt.inventory_item_id,null,-nvl(mtln.primary_quantity,mmt.primary_quantity),mmt.transaction_uom,msiv_from.primary_uom_code,null,null)) intransit_quantity,
case
when mmt.fob_point=1 and mmt.transaction_id in (select mmt_child.parent_transaction_id from mtl_material_transactions mmt_child, gmf_xla_extract_headers gxeh where mmt_child.transaction_id=gxeh.transaction_id) then 'Y'
when mmt.fob_point=2 and mmt.transaction_id in (select gxeh.transaction_id from gmf_xla_extract_headers gxeh) then 'Y'
else 'N'
end opm_processed_flag,
decode(mmt.fob_point,1,-nvl(mtln.primary_quantity,mmt.primary_quantity),2,inv_convert.inv_um_convert(mmt.inventory_item_id,null,-nvl(mtln.primary_quantity,mmt.primary_quantity),mmt.transaction_uom,msiv_from.primary_uom_code,null,null))*
(select nvl(sum(gxel.component_cost),0) from gmf_xla_extract_headers gxeh, gmf_xla_extract_lines gxel, gmf_fiscal_policies gfp where mmt.transaction_id=gxeh.transaction_id and gxeh.header_id=gxel.header_id and gxel.journal_line_type='ITR' and gxeh.legal_entity_id=gfp.legal_entity_id and gxeh.valuation_cost_type_id=gfp.cost_type_id) itr_intransit_value
from
mp,
org_acct_periods oap,
mtl_material_transactions mmt,
mtl_transaction_lot_numbers mtln,
mtl_system_items_vl msiv_from
where
4=4 and
mp.organization_id=oap.organization_id and
mmt.transaction_action_id=12 and
mmt.transaction_date<oap.schedule_close_date+1 and
decode(mmt.fob_point,1,mmt.organization_id,2,mmt.transfer_organization_id)=mp.organization_id and
mmt.transfer_transaction_id in (select mmt_ship.transaction_id from mtl_material_transactions mmt_ship where mmt_ship.transaction_action_id=21 and mmt_ship.transaction_date>=oap.period_start_date-730 and mmt_ship.transaction_date<oap.schedule_close_date+1 and decode(mmt_ship.fob_point,1,mmt_ship.transfer_organization_id,2,mmt_ship.organization_id)=mp.organization_id) and
mmt.transaction_id=mtln.transaction_id(+) and
mmt.transfer_organization_id=msiv_from.organization_id and
mmt.inventory_item_id=msiv_from.inventory_item_id
) y,
c,
mtl_interorg_parameters mip
where
y.organization_id=c.organization_id(+) and
y.inventory_item_id=c.inventory_item_id(+) and
y.from_organization_id=mip.from_organization_id(+) and
y.organization_id=mip.to_organization_id(+)
) x
group by
x.organization_id,
x.from_organization_id,
x.inventory_item_id,
x.lot_number,
x.locator_id,
x.code_combination_id
having
sum(x.intransit_quantity)<>0
) onhand,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
gl_code_combinations gcc,
mtl_item_locations_kfv milk,
mtl_material_statuses_vl mmsv,
mtl_lot_numbers mln
where
4=4 and
6=6 and
mp.organization_id=oap.organization_id and
mp.organization_id=onhand.organization_id and
onhand.organization_id=msiv.organization_id and
onhand.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y' and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
onhand.code_combination_id=gcc.code_combination_id(+) and
onhand.organization_id=milk.organization_id(+) and
onhand.locator_id=milk.inventory_location_id(+) and
milk.status_id=mmsv.status_id(+) and
onhand.organization_id=mln.organization_id(+) and
onhand.inventory_item_id=mln.inventory_item_id(+) and
onhand.lot_number=mln.lot_number(+)
group by
mp.ledger,
mp.operating_unit,
mp.organization_code,
oap.period_name,
&segment_columns_grp
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
misv.inventory_item_status_code_tl,
msiv.planning_make_buy_code,
mp.currency_code,
round(onhand.itr_item_cost,9),
&p_lot_number_opm_grp
&p_locator_opm_grp
msiv.primary_uom_code,
onhand.inventory_item_id,
onhand.organization_id
order by
ledger,
operating_unit,
org_code,
item_number,
subinventory_or_intransit
