/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII vs. Item Costs
-- Description: Report to compare the Frozen or Pending Costs against the PII item costs. If you enter a Period Name this report also shows the stored month-end from the period end snapshot (snapshot that is created when you close the inventory periods). If you leave the Period Name blank or null you will report the real-time onhand quantities. Also note that this report excludes inactive items.
-- Note: there is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts. You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type. Defaulted as positive (+1).
-- Parameters:
-- ==========
-- Cost Type: defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
-- PII Cost Type: the profit in inventory cost type you wish to report
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (optional)
-- Period Name (Closed): Accounting period you wish to report for the onhand quantities at month-end, If you leave this value blank or null you get the real-time onhand quantities.
-- Category Set 1: any item category you wish, typically the Product or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Cost category set (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2009 - 2022 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =====================================================
-- -- | 1.0 29 Sep 2009 Douglas Volz Initial Coding
-- -- | 1.4 01 May 2019 Douglas Volz Period name is now optional, if left null
-- -- | the real-time quantities are reported.
-- -- | 1.5 27 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters.
-- -- | 1.6 26 Feb 2022 Douglas Volz Changed to multi-language views for items,
-- -- | item status and UOM. Added List Price,
-- -- | Market Price and Currency Code to report.
-- -- | Exclude items with a status of Inactive.
-- -- | 1.7 26 Sep 2022 Douglas Volz Performance improvements and removed group by.
-- -- | 1.8 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-vs-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
gl.currency_code,
msiv.market_price,
msiv.list_price_per_unit list_price,
cct.cost_type,
pii.cost_type pii_cost_type,
nvl(cic.item_cost,0) item_cost,
nvl(pii.item_cost,0) pii_item_cost,
nvl(cic.item_cost,0)-decode(sign(:p_sign_pii),-1,-1,1)*nvl(pii.item_cost,0) net_item_cost,
round(nvl(pii.item_cost,0)/decode(nvl(cic.item_cost,0),0,1,cic.item_cost)*100,1) pii_percent,
:p_period_name period_name,
case
when :p_period_name is null then
nvl((select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd, mtl_secondary_inventories msi where msiv.inventory_item_id=moqd.inventory_item_id and msiv.organization_id=moqd.organization_id and moqd.organization_id=msi.organization_id and moqd.subinventory_code=msi.secondary_inventory_name and msi.asset_inventory=1),0)+
nvl((select sum(ms.to_org_primary_quantity) from mtl_supply ms, mtl_interorg_parameters mip where msiv.inventory_item_id=ms.item_id and ms.supply_type_code in ('SHIPMENT','RECEIVING') and ms.from_organization_id=mip.from_organization_id and ms.to_organization_id=mip.to_organization_id and msiv.organization_id=decode(mip.fob_point,1,mip.to_organization_id,2,mip.from_organization_id)),0)
else nvl(cpcs.quantity,0)
end quantity
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
cst_item_costs cic,
cst_cost_types cct,
(
select
cicd.organization_id,
cicd.inventory_item_id,
cct.cost_type,
sum(cicd.item_cost) item_cost
from
cst_item_cost_details cicd,
cst_cost_types cct,
bom_resources br
where
4=4 and
cicd.cost_type_id=cct.cost_type_id and
cicd.resource_id=br.resource_id
group by
cicd.organization_id,
cicd.inventory_item_id,
cct.cost_type
) pii,
(
select
cpcs.organization_id,
cpcs.inventory_item_id,
sum(cpcs.rollback_quantity) quantity
from
org_acct_periods oap,
cst_period_close_summary cpcs
where
5=5 and
:p_period_name is not null and
oap.acct_period_id=cpcs.acct_period_id and
oap.organization_id=cpcs.organization_id
group by
cpcs.organization_id,
cpcs.inventory_item_id
) cpcs
where
1=1 and
2=2 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate)>sysdate-1 and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.inventory_asset_flag='Y' and
msiv.inventory_item_status_code<>'Inactive' and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
cic.cost_type_id=cct.cost_type_id and
msiv.organization_id=pii.organization_id(+) and
msiv.inventory_item_id=pii.inventory_item_id(+) and
msiv.organization_id=cpcs.organization_id(+) and
msiv.inventory_item_id=cpcs.inventory_item_id(+)
order by
ledger,
operating_unit,
org_code,
item_number
