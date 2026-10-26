/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Comparison
-- Description: Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To Org). Put the smallest cost type into Cost Type 1, as the values for cost type 1 are always reported even if not in cost type 2. Note that the Source Org and the Compared To Org default from the inventory organization as set for your session.
-- / +=============================================================================+
-- -- | Copyright 2006 - 2020 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | 1.14 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Parameters:
-- -- | porgcode1 -- The inventory organization that is the source
-- -- | porgcode2 -- The inventory organization that is the target
-- -- | pcosttype1 -- The source comparison cost type
-- -- | pcosttype2 -- The target comparison cost type
-- -- | pcurrconvtype -- Conversion conversion type, to convert the Source
-- -- | org, orgcode1, into the currency of the ToOrg,
-- -- | orgcode2
-- -- | pcurrconvdate -- The currency conversion date, typically a month-end
-- -- | date
-- -- | pmincostdiff -- Minimum material cost diff. to show on the report
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to compare the item costs from two cost types in any two inventory orgs,
-- -- | converting the OrgCode 1 (SourceOrg) into the currency of OrgCode 2 (ToOrg).
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 02 APR 2006 Douglas Volz Initial Coding
-- -- | 1.1 14 Apr 2006 Douglas Volz Final Coding for client
-- -- | 1.4 13 JUN 2006 Douglas Volz Added nvl to all material costs columns
-- -- | 1.5 02 NOV 2009 Douglas Volz Changed to compare the item costs for two orgs
-- -- | across different currencies
-- -- | 1.6 21 Nov 2016 Douglas Volz Take out currencies, allow comparison within
-- -- | the same inventory org but using different
-- -- | cost types
-- -- | 1.7 18 Dec 2018 Douglas Volz Add currencies back in
-- -- | 1.8 30 Aug 2019 Douglas Volz Add cost and inventory item categories,
-- -- | item type and item status.
-- -- | 1.9 01 Sep 2020 Douglas Volz Added costs by cost element.
-- -- | 1.10 11 Sep 2020 Douglas Volz Added ability to report cost type1 even when
-- -- | the item is not in cost type1. Made cic2 a
-- -- | table select to avoid sql outer join errors.
-- -- | 1.11 24 Oct 2020 Douglas Volz Fix bug to convert into any currency, not just USD.
-- -- | 1.12 02 Nov 2020 Douglas Volz Again, fix to report cost type 1 even when the
-- -- | item is not in cost type 2.
-- -- | 1.13 05 Jan 2022 Douglas Volz Add lot size, shrinkage rate, based on rollup
-- -- | flags. Change calc. for percent difference.
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-item-cost-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-comparison/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.primary_uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
msiv.std_lot_size,
&category_columns
mp.organization_code org1,
cct1.cost_type cost_type1,
xxen_util.yes(decode(cic1.inventory_asset_flag,1,'Y')) org1_inventory_asset,
xxen_util.meaning(cic1.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) org1_based_on_rollup,
cic1.lot_size org1_lot_size,
cic1.shrinkage_rate org1_shrinkage_rate,
gl.currency_code,
round(nvl(cic1.material_cost,0),5) org1_material_cost,
round(nvl(cic1.material_overhead_cost,0),5) org1_material_overhead_cost,
round(nvl(cic1.resource_cost,0),5) org1_resource_cost,
round(nvl(cic1.outside_processing_cost,0),5) org1_outside_processing_cost,
round(nvl(cic1.overhead_cost,0),5) org1_overhead_cost,
round(nvl(cic1.item_cost,0),5) org1_item_cost,
o2.conversion_rate currency_conversion_rate,
round(nvl(cic1.item_cost,0)*o2.conversion_rate,5) converted_org1_cost,
o2.ledger ledger2,
o2.operating_unit operating_unit2,
o2.organization_code org2,
cic2.cost_type cost_type2,
xxen_util.yes(decode(cic2.inventory_asset_flag,1,'Y')) org2_inventory_asset,
xxen_util.meaning(cic2.based_on_rollup_flag,'CST_BONROLLUP_VAL',700) org2_based_on_rollup,
cic2.lot_size org2_lot_size,
cic2.shrinkage_rate org2_shrinkage_rate,
o2.currency_code org2_currency_code,
round(nvl(cic2.material_cost,0),5) org2_material_cost,
round(nvl(cic2.material_overhead_cost,0),5) org2_material_overhead_cost,
round(nvl(cic2.resource_cost,0),5) org2_resource_cost,
round(nvl(cic2.outside_processing_cost,0),5) org2_outside_processing_cost,
round(nvl(cic2.overhead_cost,0),5) org2_overhead_cost,
round(nvl(cic2.item_cost,0),5) org2_item_cost,
o2.conversion_rate currency_conversion_rate,
round(nvl(cic1.material_cost,0)*o2.conversion_rate-nvl(cic2.material_cost,0),5) material_difference,
round(nvl(cic1.material_overhead_cost,0)*o2.conversion_rate-nvl(cic2.material_overhead_cost,0),5) material_overhead_difference,
round(nvl(cic1.resource_cost,0)*o2.conversion_rate-nvl(cic2.resource_cost,0),5) resource_difference,
round(nvl(cic1.outside_processing_cost,0)*o2.conversion_rate-nvl(cic2.outside_processing_cost,0),5) outside_processing_difference,
round(nvl(cic1.overhead_cost,0)*o2.conversion_rate-nvl(cic2.overhead_cost,0),5) overhead_difference,
round(nvl(cic1.item_cost,0)*o2.conversion_rate-nvl(cic2.item_cost,0),5) item_cost_difference,
case
when round(nvl(cic1.item_cost,0)*o2.conversion_rate-nvl(cic2.item_cost,0),5)=0 then 0
when round(nvl(cic1.item_cost,0)*o2.conversion_rate-nvl(cic2.item_cost,0),5)=round(nvl(cic1.item_cost,0)*o2.conversion_rate,5) then 100
when round(nvl(cic1.item_cost,0)*o2.conversion_rate,5)=0 then -100
else round(round(nvl(cic1.item_cost,0)*o2.conversion_rate-nvl(cic2.item_cost,0),5)/(nvl(cic1.item_cost,0)*o2.conversion_rate)*100,1)
end percent
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
(
select
mp2.organization_code,
nvl(gl2.short_name,gl2.name) ledger,
haouv_ou2.name operating_unit,
gl2.currency_code,
decode(gl1.currency_code,gl2.currency_code,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gdct.user_conversion_type=:user_conversion_type and gdct.conversion_type=gdr.conversion_type and gl1.currency_code=gdr.from_currency and gl2.currency_code=gdr.to_currency and gdr.conversion_date=:conversion_date)) conversion_rate
from
mtl_parameters mp1,
hr_organization_information hoi1,
gl_ledgers gl1,
mtl_parameters mp2,
hr_organization_information hoi2,
hr_all_organization_units_vl haouv_ou2,
gl_ledgers gl2
where
mp1.organization_code=:p_org_code1 and
mp1.organization_id=hoi1.organization_id and
hoi1.org_information_context='Accounting Information' and
to_number(hoi1.org_information1)=gl1.ledger_id and
mp2.organization_code=:p_org_code2 and
mp2.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp2.organization_id=hoi2.organization_id and
hoi2.org_information_context='Accounting Information' and
to_number(hoi2.org_information3)=haouv_ou2.organization_id and
to_number(hoi2.org_information1)=gl2.ledger_id
) o2,
cst_item_costs cic1,
cst_cost_types cct1,
mtl_system_items_vl msiv,
(
select
cic2.inventory_item_id,
cct2.cost_type,
cic2.inventory_asset_flag,
cic2.based_on_rollup_flag,
cic2.lot_size,
cic2.shrinkage_rate,
cic2.material_cost,
cic2.material_overhead_cost,
cic2.resource_cost,
cic2.outside_processing_cost,
cic2.overhead_cost,
cic2.item_cost
from
mtl_parameters mp2,
cst_item_costs cic2,
cst_cost_types cct2
where
4=4 and
mp2.organization_id=cic2.organization_id and
cic2.cost_type_id=cct2.cost_type_id
) cic2
where
1=1 and
5=5 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cic1.organization_id and
cic1.cost_type_id=cct1.cost_type_id and
cic1.organization_id=msiv.organization_id and
cic1.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_id=cic2.inventory_item_id(+)
order by
ledger,
operating_unit,
cost_type1,
item_number,
org1
