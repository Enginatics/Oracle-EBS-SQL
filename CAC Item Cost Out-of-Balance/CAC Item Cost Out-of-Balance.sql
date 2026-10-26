/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Out-of-Balance
-- Description: Report to compare summary and detail item cost information and show any out-of-balances. Any difference may cause an inventory reconciliation issue between the G/L and the inventory perpetual balances.
-- / +=============================================================================+
-- -- | Copyright 2009-2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemcostdiffrept.sql
-- -- |
-- -- | Parameters: None
-- -- |
-- -- | Description:
-- -- | Report to compare summary and detail item cost information and show any out-of-balances.
-- -- | Any difference may cause an inventory reconciliation issue between the G/L
-- -- | and the inventory perpetual balances.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Oct 2009 Douglas Volz Initial Coding
-- -- | 1.1 16 Mar 2010 Douglas Volz Updated with Make/Buy flags
-- -- | 1.2 08 Nov 2010 Douglas Volz Updated with additional columns and parameters
-- -- | 1.3 10 Dec 2012 Douglas Volz Compare summary and detail item cost information.
-- -- | 1.4 29 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, operating unit and lookup values. Add
-- -- | Ledger and Operating Unit columns and parameters.
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-cost-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cct.cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
&category_columns
msiv.primary_uom_code uom_code,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_asset_flag,1,'Y')) inventory_asset,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.shrinkage_rate,
max(nvl(cic.material_cost,0)) sum_material_cost,
max(nvl(cic.material_overhead_cost,0)) sum_material_overhead_cost,
max(nvl(cic.resource_cost,0)) sum_resource_cost,
max(nvl(cic.outside_processing_cost,0)) sum_outside_processing_cost,
max(nvl(cic.overhead_cost,0)) sum_overhead_cost,
max(nvl(cic.item_cost,0)) sum_item_cost,
sum(decode(cicd.cost_element_id,1,nvl(cicd.item_cost,0),0)) material_cost,
sum(decode(cicd.cost_element_id,2,nvl(cicd.item_cost,0),0)) material_overhead_cost,
sum(decode(cicd.cost_element_id,3,nvl(cicd.item_cost,0),0)) resource_cost,
sum(decode(cicd.cost_element_id,4,nvl(cicd.item_cost,0),0)) outside_processing_cost,
sum(decode(cicd.cost_element_id,5,nvl(cicd.item_cost,0),0)) overhead_cost,
sum(nvl(cicd.item_cost,0)) detail_item_cost,
max(nvl(cic.item_cost,0))-sum(nvl(cicd.item_cost,0)) item_cost_difference
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
cst_item_costs cic,
cst_cost_types cct,
cst_item_cost_details cicd
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
nvl(haou.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.organization_id=cic.organization_id and
msiv.inventory_item_id=cic.inventory_item_id and
mp.primary_cost_method=cic.cost_type_id and
cic.cost_type_id=cct.cost_type_id and
cic.inventory_item_id=cicd.inventory_item_id(+) and
cic.organization_id=cicd.organization_id(+) and
cic.cost_type_id=cicd.cost_type_id(+)
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
mp.organization_code,
cct.cost_type,
msiv.concatenated_segments,
msiv.description,
msiv.inventory_item_id,
msiv.organization_id,
msiv.primary_uom_code,
msiv.inventory_item_status_code,
msiv.item_type,
msiv.planning_make_buy_code,
msiv.costing_enabled_flag,
cic.inventory_asset_flag,
cic.based_on_rollup_flag,
cic.shrinkage_rate
having
abs(sum(nvl(cicd.item_cost,0))-max(nvl(cic.item_cost,0)))>.00001
order by
ledger,
operating_unit,
org_code,
cost_type,
item_number
