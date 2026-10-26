/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Item Cost Summary
-- Description: Report to show item costs in any cost type, including the profit in inventory costs (also known as ICP or PII). For one or more inventory organizations.
-- / +=============================================================================+
-- -- | Copyright 2009-2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemcostrept.sql
-- -- |
-- -- | Parameters:
-- -- | pcosttype -- The cost type you wish to report
-- -- | ppiicosttype -- The new PII Cost Type you wish to report
-- -- | ppiisubelement -- The sub-element or resource for profit in inventory,
-- -- | such as PII or ICP (mandatory)
-- -- | pledger -- general ledger you wish to report, works with
-- -- | null or valid ledger names
-- -- | pitemnumber -- Enter the specific item number you wish to report
-- -- | porgcode -- specific organization code, works with
-- -- | null or valid organization codes
-- -- | pincludeuncosteditems -- Yes/No flag to include or not include non-costed resources
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to show item costs in any cost type
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Oct 2009 Douglas Volz Initial Coding
-- -- | 1.1 16 Mar 2010 Douglas Volz Updated with Make/Buy flags
-- -- | 1.2 08 Nov 2010 Douglas Volz Updated with additional columns and parameters
-- -- | 1.3 07 Feb 2011 Douglas Volz Added COGS and Revenue default accounts
-- -- | 1.4 15 Nov 2016 Douglas Volz Added category information
-- -- | 1.5 27 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters
-- -- | 1.6 27 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, inventory orgs and operating units.
-- -- | 1.7 21 Jun 2020 Douglas Volz Changed to multi-language views for item
-- -- | status and UOM.
-- -- | 1.8 24 Sep 2020 Douglas Volz Added List Price to report
-- -- | 1.9 29 Jan 2021 Douglas Volz Added item master dates and Inactive Items parameter
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-item-cost-summary/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-item-cost-summary/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cic.cost_type,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(decode(cic.inventory_item_id,null,msiv.inventory_asset_flag,decode(cic.inventory_asset_flag,1,'Y'))) inventory_asset,
decode(cic.inventory_item_id,null,'N/A',cic.based_on_rollup) based_on_rollup,
cic.shrinkage_rate,
gl.currency_code,
msiv.market_price,
msiv.list_price_per_unit target_or_po_list_price,
cic.material_cost,
cic.material_overhead_cost,
cic.resource_cost,
cic.outside_processing_cost,
cic.overhead_cost,
cic.item_cost,
cic.pii_costs,
&segment_columns
cic.creation_date cost_creation_date,
cic.last_update_date last_cost_update_date,
msiv.creation_date item_creation_date,
msiv.last_update_date item_last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_system_items_vl msiv,
(
select
cic.organization_id,
cic.inventory_item_id,
cct.cost_type,
cic.inventory_asset_flag,
xxen_util.meaning(cic.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) based_on_rollup,
cic.shrinkage_rate,
nvl(cic.material_cost,0) material_cost,
nvl(cic.material_overhead_cost,0) material_overhead_cost,
nvl(cic.resource_cost,0) resource_cost,
nvl(cic.outside_processing_cost,0) outside_processing_cost,
nvl(cic.overhead_cost,0) overhead_cost,
nvl(cic.item_cost,0) item_cost,
round(nvl((select sum(cicd.item_cost) from cst_item_cost_details cicd, cst_cost_types cct, bom_resources br where cic.inventory_item_id=cicd.inventory_item_id and cic.organization_id=cicd.organization_id and cicd.cost_type_id=cct.cost_type_id and cicd.resource_id=br.resource_id and 6=6 and 7=7),0),5) pii_costs,
cic.creation_date,
cic.last_update_date
from
cst_item_costs cic,
cst_cost_types cct
where
4=4 and
cic.cost_type_id=cct.cost_type_id
) cic,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=msiv.organization_id and
msiv.organization_id=cic.organization_id(+) and
msiv.inventory_item_id=cic.inventory_item_id(+) and
(cic.inventory_item_id is not null or msiv.costing_enabled_flag='N' and 5=5) and
msiv.cost_of_sales_account=gcc1.code_combination_id(+) and
msiv.sales_account=gcc2.code_combination_id(+)
order by
ledger,
operating_unit,
org_code,
cic.cost_type,
item_number
