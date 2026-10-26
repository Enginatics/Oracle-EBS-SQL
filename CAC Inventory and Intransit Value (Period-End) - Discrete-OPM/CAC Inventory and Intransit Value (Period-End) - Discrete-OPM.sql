/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory and Intransit Value (Period-End) - Discrete/OPM
-- Description: Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations. If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot. In either case this report uses the month-end quantities, based on the entered period name, OPM calendar code and OPM period code. And as these quantities come from the month-end snapshot (created when you close the inventory accounting period or run the GMF Period Close Process) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.
-- Notes:
-- 1) OPM intransit balances based upon last two years of Intransit Shipments. As of Release 12.2.13, OPM does not have a month-end snapshot for intransit quantities or balances.
-- 2) This report assumes you use both OPM and Discrete Manufacturing. If you only use Discrete Manufacturing, use the CAC Inventory and Intransit Value (Period-End) report instead.
-- Discrete and OPM Parameters:
-- ============================
-- Period Name (Closed): the closed inventory accounting period you wish to report (mandatory).
-- Cost Type: enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
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
-- -- | Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- | 1.0 27 Sep 2009 Douglas Volz Initial Coding
-- -- | 1.29 04 Jun 2024 Douglas Volz Fix SQL error for Intransit code section, due to duplicate transactions in GXEH
-- -- | (ORA-01427: single-row subquery returns more than one row).
-- -- | 1.30 09 Jun 2024 Douglas Volz Fix Intransit joins for UOMs, organizations and for duplicate Intransit quantities.
-- -- | 1.31 25 Jun 2024 Douglas Volz Add Period Code join for Intransit, to avoid cross-joining.
-- -- | 1.32 27 Jun 2024 Douglas Volz Get intransit account based on the Shipping Network, to avoid duplicate quantities.
-- -- | 1.33 28 Jun 2024 Douglas Volz Base Intransit SQL logic on two years of Intransit Shipments, not on mtlsupply.
-- -- | 1.34 30 Jun 2024 Douglas Volz Get default intransit account in case the Shipping Network has been deleted or changed.
-- -- | 1.35 08 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs and qtys.
-- -- | 1.36 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end-discrete-opm/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/
-- Run Report: https://demo.enginatics.com/

with mp as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
mp.organization_id,
to_number(hoi.org_information2) legal_entity_id,
nvl(cwa.cost_organization_id,mp.organization_id) cost_organization_id,
nvl(mp.process_enabled_flag,'N') process_enabled_flag,
mp.default_cost_group_id,
case
when mp.cost_group_accounting=1 then 'Y'
when mp.organization_id in (select pop.organization_id from pjm_org_parameters pop) then 'Y'
when mp.primary_cost_method in (2,5,6) then 'Y'
when mp.process_enabled_flag='Y' then null
when mp.wms_enabled_flag='Y' then 'Y'
end cost_group_accounting,
(select max(mca.category_set_id) from mtl_category_accounts mca where mp.organization_id=mca.organization_id) category_set_id,
mp.intransit_inv_account,
gl.currency_code
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cm_whse_asc cwa
where
1=1 and
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
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
:p_show_opm_inventory='Y' and
:p_cost_type is null and
7=7 and
8=8 and
mp.process_enabled_flag='Y' and
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
:p_show_opm_inventory='Y' and
cmm.cost_mthd_code=upper(:p_cost_type) and
7=7 and
8=8 and
mp.process_enabled_flag='Y' and
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
onhand.ledger,
onhand.operating_unit,
onhand.org_code,
onhand.period_name,
&segment_columns
onhand.item_number,
onhand.item_description,
xxen_util.meaning(onhand.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(onhand.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
onhand.currency_code,
onhand.item_cost,
onhand.subinventory_or_intransit,
onhand.description,
onhand.asset,
onhand.uom_code,
onhand.onhand_quantity,
onhand.onhand_value
from
(
select
y.ledger,
y.operating_unit,
y.org_code,
y.period_name,
y.organization_id,
y.inventory_item_id,
y.item_number,
y.item_description,
y.item_type,
y.inventory_item_status_code,
y.planning_make_buy_code,
y.currency_code,
round(decode(cic.inventory_item_id,null,y.rollback_value/decode(y.rollback_quantity,0,1,y.rollback_quantity),cic.item_cost),5) item_cost,
y.subinventory_code,
nvl(y.subinventory_code,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700)) subinventory_or_intransit,
decode(y.subinventory_code,null,xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700),y.subinventory_description) description,
xxen_util.yes(decode(y.asset_inventory,2,null,'Y')) asset,
y.primary_uom_code uom_code,
round(y.rollback_quantity,3) onhand_quantity,
round(decode(cic.inventory_item_id,null,y.rollback_value,y.rollback_quantity*cic.item_cost),2) onhand_value,
y.material_account
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
mp.ledger,
mp.operating_unit,
mp.organization_code org_code,
oap.period_name,
mp.currency_code,
mp.organization_id,
mp.default_cost_group_id,
mp.cost_group_accounting,
mp.category_set_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
msiv.primary_uom_code,
cpcs.subinventory_code,
sum(cpcs.rollback_quantity) rollback_quantity,
sum(cpcs.rollback_value) rollback_value
from
mp,
org_acct_periods oap,
cst_period_close_summary cpcs,
mtl_system_items_vl msiv
where
4=4 and
6=6 and
mp.process_enabled_flag='N' and
mp.organization_id=oap.organization_id and
oap.acct_period_id=cpcs.acct_period_id and
cpcs.rollback_quantity<>0 and
cpcs.organization_id=msiv.organization_id and
cpcs.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y'
group by
mp.ledger,
mp.operating_unit,
mp.organization_code,
oap.period_name,
mp.currency_code,
mp.organization_id,
mp.default_cost_group_id,
mp.cost_group_accounting,
mp.category_set_id,
msiv.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
msiv.primary_uom_code,
cpcs.subinventory_code
) x,
mtl_secondary_inventories msub
where
x.organization_id=msub.organization_id(+) and
x.subinventory_code=msub.secondary_inventory_name(+)
) y,
(select cic.organization_id, cic.inventory_item_id, nvl(cic.item_cost,0) item_cost from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type and cct.cost_type_id=cic.cost_type_id) cic
where
y.organization_id=cic.organization_id(+) and
y.inventory_item_id=cic.inventory_item_id(+) and
(cic.inventory_item_id is not null or :p_cost_type is null)
union all
select
mp.ledger,
mp.operating_unit,
mp.organization_code org_code,
q.period_name,
q.organization_id,
q.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
mp.currency_code,
c.item_cost,
q.subinventory_code,
q.subinventory_code subinventory_or_intransit,
msub.description,
xxen_util.yes('Y') asset,
msiv.primary_uom_code uom_code,
q.primary_quantity onhand_quantity,
round(q.primary_quantity*c.item_cost,2) onhand_value,
msub.material_account
from
mp,
(
select
gpb.organization_id,
gpb.inventory_item_id,
oap.period_name,
gpb.subinventory_code,
sum(gpb.primary_quantity) primary_quantity
from
mp,
org_acct_periods oap,
gmf_period_balances gpb
where
:p_show_opm_inventory='Y' and
4=4 and
mp.process_enabled_flag='Y' and
mp.organization_id=oap.organization_id and
oap.organization_id=gpb.organization_id and
oap.acct_period_id=gpb.acct_period_id
group by
gpb.organization_id,
gpb.inventory_item_id,
oap.period_name,
gpb.subinventory_code
having
sum(gpb.primary_quantity)<>0
) q,
c,
mtl_system_items_vl msiv,
mtl_secondary_inventories msub
where
6=6 and
mp.organization_id=q.organization_id and
q.organization_id=c.organization_id and
q.inventory_item_id=c.inventory_item_id and
q.organization_id=msiv.organization_id and
q.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y' and
q.organization_id=msub.organization_id and
q.subinventory_code=msub.secondary_inventory_name and
msub.asset_inventory=1
union all
select
mp.ledger,
mp.operating_unit,
mp.organization_code org_code,
oap.period_name,
x.organization_id,
x.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
mp.currency_code,
round(x.itr_item_cost,9) item_cost,
null subinventory_code,
xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700) subinventory_or_intransit,
xxen_util.meaning(3,'MSC_CALENDAR_TYPE',700) description,
xxen_util.yes('Y') asset,
msiv.primary_uom_code uom_code,
round(sum(x.intransit_quantity),3) onhand_quantity,
round(sum(x.itr_intransit_value),2) onhand_value,
x.code_combination_id material_account
from
mp,
org_acct_periods oap,
(
select
y.organization_id,
y.from_organization_id,
y.inventory_item_id,
y.code_combination_id,
sum(y.itr_intransit_value)/decode(sum(y.intransit_quantity),0,1,sum(y.intransit_quantity)) itr_item_cost,
sum(y.intransit_quantity) intransit_quantity,
sum(y.itr_intransit_value) itr_intransit_value
from
(
select
z.organization_id,
z.from_organization_id,
z.inventory_item_id,
nvl(mip.intransit_inv_account,z.intransit_inv_account) code_combination_id,
z.intransit_quantity,
decode(:p_cost_type,null,decode(z.opm_processed_flag,'Y',nvl(z.itr_intransit_value,0),nvl(c.item_cost*z.intransit_quantity,0)),nvl(c.item_cost*z.intransit_quantity,0)) itr_intransit_value
from
(
select
decode(mmt.fob_point,1,mmt.transfer_organization_id,2,mmt.organization_id) organization_id,
decode(mmt.fob_point,1,mmt.organization_id,2,mmt.transfer_organization_id) from_organization_id,
mmt.inventory_item_id,
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
:p_show_opm_inventory='Y' and
4=4 and
mp.process_enabled_flag='Y' and
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
:p_show_opm_inventory='Y' and
4=4 and
mp.process_enabled_flag='Y' and
mp.organization_id=oap.organization_id and
mmt.transaction_action_id=12 and
mmt.transaction_date<oap.schedule_close_date+1 and
decode(mmt.fob_point,1,mmt.organization_id,2,mmt.transfer_organization_id)=mp.organization_id and
mmt.transfer_transaction_id in (select mmt_ship.transaction_id from mtl_material_transactions mmt_ship where mmt_ship.transaction_action_id=21 and mmt_ship.transaction_date>=oap.period_start_date-730 and mmt_ship.transaction_date<oap.schedule_close_date+1 and decode(mmt_ship.fob_point,1,mmt_ship.transfer_organization_id,2,mmt_ship.organization_id)=mp.organization_id) and
mmt.transaction_id=mtln.transaction_id(+) and
mmt.transfer_organization_id=msiv_from.organization_id and
mmt.inventory_item_id=msiv_from.inventory_item_id
) z,
c,
mtl_interorg_parameters mip
where
z.organization_id=c.organization_id(+) and
z.inventory_item_id=c.inventory_item_id(+) and
z.from_organization_id=mip.from_organization_id(+) and
z.organization_id=mip.to_organization_id(+)
) y
group by
y.organization_id,
y.from_organization_id,
y.inventory_item_id,
y.code_combination_id
having
sum(y.intransit_quantity)<>0
) x,
mtl_system_items_vl msiv
where
4=4 and
6=6 and
mp.organization_id=oap.organization_id and
mp.organization_id=x.organization_id and
x.organization_id=msiv.organization_id and
x.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_asset_flag='Y'
group by
mp.ledger,
mp.operating_unit,
mp.organization_code,
oap.period_name,
x.organization_id,
x.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
mp.currency_code,
round(x.itr_item_cost,9),
msiv.primary_uom_code,
x.code_combination_id
) onhand,
mtl_item_status_vl misv,
gl_code_combinations gcc
where
3=3 and
onhand.inventory_item_status_code=misv.inventory_item_status_code and
onhand.material_account=gcc.code_combination_id(+)
order by
onhand.ledger,
onhand.operating_unit,
onhand.org_code,
onhand.item_number,
onhand.subinventory_or_intransit
