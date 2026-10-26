/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions, including gross costs, profit in inventory (commonly abbreviated as PII or ICP - InterCompany Profit).
-- Production overheads (resource overheads) are reported per WIP operation and overhead, from the department overhead rates of the two cost types. Move-based overheads earn on the operation quantity completed (Item basis) or once per operation (Lot basis); resource-based overheads earn on the applied resource units (Resource Units basis) or on the applied resource units at the resource rate of each cost type (Resource Value basis), for the overheads assigned to the resource. For these rows the WIP Quantity is this overhead basis quantity.
-- The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session. And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes. The To Currency columns are blank when no conversion rate exists for the date and type.
-- -- =================================================================
-- Copyright 2022 Douglas Volz Consulting, Inc.
-- All rights reserved.
-- Permission to use this code is granted provided the original author is acknowledged
-- Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- =================================================================
-- Hidden Parameters:
-- psignpii: Hidden parameter to set the sign of the profit in inventory amounts. This parameter determines if PII is normally entered as a positive or negative amount.
-- Displayed Parameters:
-- Cost Type (New): the new cost type to be reported, mandatory
-- Cost Type (Old): the old cost type to be reported, mandatory
-- PII Cost Type (New): the new PIICostType you wish to report
-- PII Cost Type(Old): the prior or old PIICostType you wish to report such as PII or ICP (mandatory)
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (mandatory)
-- Currency Conversion Date (New): the new currency conversion date, mandatory
-- Currency Conversion Date (Old): the old currency conversion date, mandatory
-- Currency Conversion Type (New): the desired currency conversion type to use for cost type 1, mandatory
-- Currency Conversion Type (Old ): the desired currency conversion type to use for cost type 2, mandatory
-- To Currency Code: the currency you are converting into
-- Category Set 1: the first item category set to report, typically the Cost or Product Line CategorySet
-- Category Set 2: the second item category set to report, typically the Inventory CategorySet
-- All WIP Jobs: enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs.
-- Org Code: specific inventory organization you wish to report (optional)
-- Operating Unit: operating unit you wish to report, leave blank for all operating units (optional)
-- Ledger: general ledger you wish to report, leave blank for all ledgers (optional)
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.6 08 Jun 2022 Douglas Volz Create PII version based on WIP Pending Cost Adjust Rept.
-- -- | 1.7 19 Sep 2026 Enginatics Add production (resource) overhead cost adjustments,
-- -- | correct the net value, percentage and FX columns.
-- -- | 1.8 28 Sep 2026 Enginatics Report rows without a currency conversion rate.
-- -- | 1.10 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-wip-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select
z.ledger,
z.operating_unit,
z.org_code,
z.organization_name,
z.class_code wip_class,
xxen_util.meaning(z.class_type,'WIP_CLASS_TYPE',700) class_type,
z.wip_entity_name wip_job,
xxen_util.meaning(z.status_type,'WIP_JOB_STATUS',700) job_status,
z.date_released,
z.date_completed,
z.last_update_date,
z.item_number,
z.item_description,
&category_columns
xxen_util.meaning(z.item_type,'ITEM_TYPE',3) item_type,
z.item_status,
xxen_util.meaning(z.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
xxen_util.meaning(z.wip_supply_type,'WIP_SUPPLY',700) supply_type,
z.transaction_type,
z.resource_code,
z.overhead_code,
z.op_seq_num operation_seq_number,
z.res_seq_num resource_seq_number,
xxen_util.meaning(z.basis_type,'CST_BASIS',700) basis_type,
xxen_util.meaning(z.ovhd_basis_type,'CST_BASIS',700) overhead_basis_type,
z.currency_code,
z.uom_code,
round(z.material1,5) new_material_cost,
round(z.material2,5) old_material_cost,
round(z.moh1,5) new_material_overhead_cost,
round(z.moh2,5) old_material_overhead_cost,
round(z.resource1,5) new_resource_cost,
round(z.resource2,5) old_resource_cost,
round(z.osp1,5) new_outside_processing_cost,
round(z.osp2,5) old_outside_processing_cost,
round(z.overhead1,5) new_overhead_cost,
round(z.overhead2,5) old_overhead_cost,
round(z.item_cost1,5) new_gross_item_cost,
round(z.item_cost2,5) old_gross_item_cost,
round(z.pii1,5) new_pii_cost,
round(z.pii2,5) old_pii_cost,
round(z.item_cost1,5)-z.pii_sign*round(z.pii1,5) new_net_item_cost,
round(z.item_cost2,5)-z.pii_sign*round(z.pii2,5) old_net_item_cost,
round(z.item_cost1,5)-round(z.item_cost2,5) gross_item_cost_difference,
case
when round(z.item_cost1,5)=round(z.item_cost2,5) then 0
when round(z.item_cost2,5)=0 then 100
else round((z.item_cost1-z.item_cost2)/z.item_cost2*100,2)
end gross_percent_difference,
round(z.pii1,5)-round(z.pii2,5) pii_item_cost_difference,
case
when round(z.pii1-z.pii2,5)=0 then 0
when round(z.pii1-z.pii2,5)=round(z.pii1,5) then 100
when round(z.pii2-z.pii1,5)=round(z.pii2,5) then -100
else round((z.pii1-z.pii2)/z.pii2*100,1)
end pii_percent_difference,
round(z.item_cost1,5)-z.pii_sign*round(z.pii1,5)-(round(z.item_cost2,5)-z.pii_sign*round(z.pii2,5)) net_item_cost_difference,
z.wip_quantity,
z.value_sign*round(z.item_cost1*z.quantity1,2) new_gross_wip_value,
z.value_sign*round(z.pii_sign*z.pii1*z.quantity1,2) new_pii_value,
z.value_sign*round((z.item_cost1-z.pii_sign*z.pii1)*z.quantity1,2) new_net_wip_value,
z.value_sign*round(z.item_cost2*z.quantity2,2) old_gross_wip_value,
z.value_sign*round(z.pii_sign*z.pii2*z.quantity2,2) old_pii_value,
z.value_sign*round((z.item_cost2-z.pii_sign*z.pii2)*z.quantity2,2) old_net_wip_value,
z.value_sign*(round(z.item_cost1*z.quantity1,2)-round(z.item_cost2*z.quantity2,2)) gross_wip_value_difference,
abs(round(z.item_cost1*z.quantity1,2)-round(z.item_cost2*z.quantity2,2)) abs_wip_value_difference,
z.value_sign*round(z.pii_sign*(z.pii1-z.pii2)*z.quantity1,2) pii_value_difference,
z.value_sign*round(z.item_cost1*z.quantity1-z.item_cost2*z.quantity2-z.pii_sign*(z.pii1*z.quantity1-z.pii2*z.quantity2),2) net_wip_value_difference,
z.rate1 new_fx_rate,
z.rate2 old_fx_rate,
z.rate1-z.rate2 exchange_rate_difference,
z.value_sign*round(z.material1*z.rate1*z.quantity1,2) "&p_to_currency_code New Material Value",
z.value_sign*round(z.material2*z.rate2*z.quantity2,2) "&p_to_currency_code Old Material Value",
z.value_sign*round(z.moh1*z.rate1*z.quantity1,2) "&p_to_currency_code New Material Ovhd Value",
z.value_sign*round(z.moh2*z.rate2*z.quantity2,2) "&p_to_currency_code Old Material Ovhd Value",
z.value_sign*round(z.resource1*z.rate1*z.quantity1,2) "&p_to_currency_code New Resource Value",
z.value_sign*round(z.resource2*z.rate2*z.quantity2,2) "&p_to_currency_code Old Resource Value",
z.value_sign*round(z.osp1*z.rate1*z.quantity1,2) "&p_to_currency_code New OSP Value",
z.value_sign*round(z.osp2*z.rate2*z.quantity2,2) "&p_to_currency_code Old OSP Value",
z.value_sign*round(z.overhead1*z.rate1*z.quantity1,2) "&p_to_currency_code New Overhead Value",
z.value_sign*round(z.overhead2*z.rate2*z.quantity2,2) "&p_to_currency_code Old Overhead Value",
z.value_sign*round(z.item_cost1*z.quantity1*z.rate1,2) "&p_to_currency_code New Gross WIP Value",
z.value_sign*round(z.item_cost2*z.quantity2*z.rate2,2) "&p_to_currency_code Old Gross WIP Value",
z.value_sign*(round(z.item_cost1*z.quantity1*z.rate1,2)-round(z.item_cost2*z.quantity2*z.rate2,2)) "&p_to_currency_code Gross WIP Value Diff",
abs(round(z.item_cost1*z.quantity1*z.rate1,2)-round(z.item_cost2*z.quantity2*z.rate2,2)) "&p_to_currency_code Abs WIP Value Diff",
z.value_sign*round(z.pii_sign*z.pii1*z.rate1*z.quantity1,2) "&p_to_currency_code New PII Value",
z.value_sign*round(z.pii_sign*z.pii2*z.rate2*z.quantity2,2) "&p_to_currency_code Old PII Value",
z.value_sign*round(z.pii_sign*(z.pii1*z.rate1-z.pii2*z.rate2)*z.quantity1,2) "&p_to_currency_code PII Value Difference",
z.value_sign*round((z.item_cost1-z.pii_sign*z.pii1)*z.rate1*z.quantity1,2) "&p_to_currency_code New Net Value",
z.value_sign*round((z.item_cost2-z.pii_sign*z.pii2)*z.rate2*z.quantity2,2) "&p_to_currency_code Old Net Value",
z.value_sign*round(((z.item_cost1-z.pii_sign*z.pii1)*z.rate1*z.quantity1-(z.item_cost2-z.pii_sign*z.pii2)*z.rate2*z.quantity2),2) "&p_to_currency_code Net Value Difference",
z.value_sign*round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate1,2) "&p_to_currency_code Gross Value Diff-New Rate",
z.value_sign*round(z.pii_sign*(z.pii1-z.pii2)*z.rate1*z.quantity1,2) "&p_to_currency_code PII Value Diff-New Rate",
z.value_sign*(round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate1,2)-round(z.pii_sign*(z.pii1-z.pii2)*z.rate1*z.quantity1,2)) "&p_to_currency_code Net Value Diff-New Rate",
z.value_sign*round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate2,2) "&p_to_currency_code Gross Value Diff-Old Rate",
z.value_sign*round(z.pii_sign*(z.pii1-z.pii2)*z.rate2*z.quantity1,2) "&p_to_currency_code PII Value Diff-Old Rate",
z.value_sign*(round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate2,2)-round(z.pii_sign*(z.pii1-z.pii2)*z.rate2*z.quantity1,2)) "&p_to_currency_code Net Value Diff-Old Rate",
z.value_sign*(round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate1,2)-round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate2,2)) "&p_to_currency_code Gross Value FX Diff",
z.value_sign*(round(z.pii_sign*(z.pii1-z.pii2)*z.rate1*z.quantity1,2)-round(z.pii_sign*(z.pii1-z.pii2)*z.rate2*z.quantity1,2)) "&p_to_currency_code PII Value FX Diff",
z.value_sign*(round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate1,2)-round(z.pii_sign*(z.pii1-z.pii2)*z.rate1*z.quantity1,2)-(round((z.item_cost1*z.quantity1-z.item_cost2*z.quantity2)*z.rate2,2)-round(z.pii_sign*(z.pii1-z.pii2)*z.rate2*z.quantity1,2))) "&p_to_currency_code Net Value FX Diff"
from
(
select
y.ledger,
y.operating_unit,
y.org_code,
y.organization_name,
y.currency_code,
y.organization_id,
y.inventory_item_id,
y.wip_entity_name,
y.class_code,
y.class_type,
y.status_type,
y.date_released,
y.date_completed,
y.last_update_date,
y.transaction_type,
y.resource_code,
y.overhead_code,
y.op_seq_num,
y.res_seq_num,
y.basis_type,
y.ovhd_basis_type,
y.wip_supply_type,
y.value_sign,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
misv.inventory_item_status_code_tl item_status,
msiv.planning_make_buy_code,
msiv.primary_uom_code uom_code,
decode(y.row_type,'O',round(decode(y.overhead_rate1,0,y.quantity2,y.quantity1),3),y.quantity) wip_quantity,
decode(y.row_type,'O',y.quantity1,y.quantity) quantity1,
decode(y.row_type,'O',y.quantity2,y.quantity) quantity2,
decode(y.cost_source,'M',nvl(cic1.material_cost,0),0) material1,
decode(y.cost_source,'M',nvl(cic2.material_cost,0),0) material2,
decode(y.cost_source,'M',round(nvl(cic1.material_overhead_cost,0)-decode(y.this_level,'Y',nvl(cic1.tl_material_overhead,0),0),5),0) moh1,
decode(y.cost_source,'M',round(nvl(cic2.material_overhead_cost,0)-decode(y.this_level,'Y',nvl(cic2.tl_material_overhead,0),0),5),0) moh2,
decode(y.cost_source,'M',nvl(cic1.resource_cost,0),'R',decode(y.cost_element_id,3,nvl(crc1.resource_rate,0),0),0) resource1,
decode(y.cost_source,'M',nvl(cic2.resource_cost,0),'R',decode(y.cost_element_id,3,nvl(crc2.resource_rate,0),0),0) resource2,
decode(y.cost_source,'M',nvl(cic1.outside_processing_cost,0),'R',decode(y.cost_element_id,4,nvl(crc1.resource_rate,0),0),0) osp1,
decode(y.cost_source,'M',nvl(cic2.outside_processing_cost,0),'R',decode(y.cost_element_id,4,nvl(crc2.resource_rate,0),0),0) osp2,
decode(y.cost_source,'M',nvl(cic1.overhead_cost,0),'O',y.overhead_rate1,0) overhead1,
decode(y.cost_source,'M',nvl(cic2.overhead_cost,0),'O',y.overhead_rate2,0) overhead2,
decode(y.cost_source,'M',round(nvl(cic1.item_cost,0)-decode(y.this_level,'Y',nvl(cic1.tl_material_overhead,0),0),5),'R',nvl(crc1.resource_rate,0),y.overhead_rate1) item_cost1,
decode(y.cost_source,'M',round(nvl(cic2.item_cost,0)-decode(y.this_level,'Y',nvl(cic2.tl_material_overhead,0),0),5),'R',nvl(crc2.resource_rate,0),y.overhead_rate2) item_cost2,
decode(y.cost_source,'M',nvl(cic1.item_cost,0),'R',nvl(crc1.resource_rate,0),y.overhead_rate1*y.quantity1) filter1,
decode(y.cost_source,'M',nvl(cic2.item_cost,0),'R',nvl(crc2.resource_rate,0),y.overhead_rate2*y.quantity2) filter2,
decode(y.currency_code,:p_to_currency_code,1,(select gdr1.conversion_rate from gl_daily_conversion_types gdct1, gl_daily_rates gdr1 where 4=4 and 5=5 and 11=11 and gdct1.conversion_type=gdr1.conversion_type and y.currency_code=gdr1.from_currency)) rate1,
decode(y.currency_code,:p_to_currency_code,1,(select gdr2.conversion_rate from gl_daily_conversion_types gdct2, gl_daily_rates gdr2 where 6=6 and 7=7 and gdct2.conversion_type=gdr2.conversion_type and y.currency_code=gdr2.from_currency and gdr2.to_currency=:p_to_currency_code)) rate2,
decode(y.row_type,'R',0,'O',0,decode(msiv.inventory_asset_flag,'Y',nvl((select sum(cicd.item_cost) from cst_cost_types cct, cst_item_cost_details cicd, bom_resources br where 12=12 and 14=14 and cct.cost_type_id=cicd.cost_type_id and y.organization_id=cicd.organization_id and y.inventory_item_id=cicd.inventory_item_id and cicd.resource_id=br.resource_id),0),0)) pii1,
decode(y.row_type,'R',0,'O',0,decode(msiv.inventory_asset_flag,'Y',nvl((select sum(cicd.item_cost) from cst_cost_types cct, cst_item_cost_details cicd, bom_resources br where 13=13 and 14=14 and cct.cost_type_id=cicd.cost_type_id and y.organization_id=cicd.organization_id and y.inventory_item_id=cicd.inventory_item_id and cicd.resource_id=br.resource_id),0),0)) pii2,
decode(sign(:p_sign_pii),-1,-1,1) pii_sign
from
(
select
j.ledger,
j.operating_unit,
j.org_code,
j.organization_name,
j.currency_code,
j.organization_id,
j.wip_entity_name,
j.class_code,
j.class_type,
j.status_type,
j.date_released,
j.date_completed,
j.last_update_date,
nvl(d.inventory_item_id,j.primary_item_id) inventory_item_id,
d.row_type,
decode(d.row_type,'C','M',d.row_type) cost_source,
d.transaction_type,
d.resource_code,
d.overhead_code,
d.op_seq_num,
d.res_seq_num,
d.basis_type,
d.ovhd_basis_type,
d.wip_supply_type,
decode(d.row_type,'C',-1,1) value_sign,
case when d.row_type='C' and j.class_type in (1,5) then 'Y' end this_level,
d.quantity,
d.resource_id,
d.cost_element_id,
d.overhead_rate1,
d.overhead_rate2,
d.quantity1,
d.quantity2,
case
when d.row_type in ('C','M') then nvl((select cic.cost_type_id from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type1 and cct.cost_type_id=cic.cost_type_id and j.organization_id=cic.organization_id and nvl(d.inventory_item_id,j.primary_item_id)=cic.inventory_item_id),1)
when d.row_type='R' then nvl((select crc.cost_type_id from cst_cost_types cct, cst_resource_costs crc where cct.cost_type=:p_cost_type1 and cct.cost_type_id=crc.cost_type_id and j.organization_id=crc.organization_id and d.resource_id=crc.resource_id),1)
end cost_type_id1,
case
when d.row_type in ('C','M') then nvl((select cic.cost_type_id from cst_cost_types cct, cst_item_costs cic where cct.cost_type=:p_cost_type2 and cct.cost_type_id=cic.cost_type_id and j.organization_id=cic.organization_id and nvl(d.inventory_item_id,j.primary_item_id)=cic.inventory_item_id),1)
when d.row_type='R' then nvl((select crc.cost_type_id from cst_cost_types cct, cst_resource_costs crc where cct.cost_type=:p_cost_type2 and cct.cost_type_id=crc.cost_type_id and j.organization_id=crc.organization_id and d.resource_id=crc.resource_id),1)
end cost_type_id2
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
haou.name organization_name,
gl.currency_code,
wdj.organization_id,
wdj.wip_entity_id,
we.wip_entity_name,
wdj.primary_item_id,
wdj.class_code,
wac.class_type,
wdj.status_type,
wdj.date_released,
wdj.date_completed,
wdj.last_update_date
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
wip_discrete_jobs wdj,
wip_entities we,
wip_accounting_classes wac
where
1=1 and
9=9 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=wdj.organization_id and
wdj.date_closed is null and
nvl(wdj.issue_zero_cost_flag,'N')='N' and
wdj.wip_entity_id=we.wip_entity_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wac.class_type not in (4,6,7)
) j,
(
select
'C' row_type,
wdj.wip_entity_id,
to_number(null) inventory_item_id,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mtt.transaction_type_id=44) transaction_type,
null resource_code,
null overhead_code,
to_number(null) op_seq_num,
to_number(null) res_seq_num,
1 basis_type,
to_number(null) ovhd_basis_type,
to_number(null) wip_supply_type,
wdj.quantity_completed quantity,
to_number(null) resource_id,
to_number(null) cost_element_id,
to_number(null) overhead_rate1,
to_number(null) overhead_rate2,
to_number(null) quantity1,
to_number(null) quantity2
from
wip_discrete_jobs wdj
where
wdj.quantity_completed+wdj.quantity_scrapped<>0
union all
select
'M' row_type,
wro.wip_entity_id,
wro.inventory_item_id,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mtt.transaction_type_id=decode(sign(wro.quantity_issued),1,35,43)) transaction_type,
null resource_code,
null overhead_code,
wro.operation_seq_num op_seq_num,
null res_seq_num,
nvl(wro.basis_type,1) basis_type,
null ovhd_basis_type,
wro.wip_supply_type,
wro.quantity_issued quantity,
null resource_id,
null cost_element_id,
null overhead_rate1,
null overhead_rate2,
null quantity1,
null quantity2
from
wip_requirement_operations wro
where
wro.quantity_issued<>0
union all
select
'R' row_type,
wor.wip_entity_id,
null inventory_item_id,
xxen_util.meaning(decode(br.cost_element_id,3,1,4,3),'WIP_TRANSACTION_TYPE',700) transaction_type,
br.resource_code,
null overhead_code,
wor.operation_seq_num op_seq_num,
wor.resource_seq_num res_seq_num,
wor.basis_type,
null ovhd_basis_type,
(select max(wro.wip_supply_type) from wip_requirement_operations wro where wor.wip_entity_id=wro.wip_entity_id and wor.operation_seq_num=wro.operation_seq_num) wip_supply_type,
round(wor.applied_resource_units,3) quantity,
wor.resource_id,
br.cost_element_id,
null overhead_rate1,
null overhead_rate2,
null quantity1,
null quantity2
from
wip_operation_resources wor,
bom_resources br
where
wor.applied_resource_units<>0 and
wor.resource_id=br.resource_id and
br.cost_element_id in (3,4)
union all
select
'O' row_type,
o.wip_entity_id,
null inventory_item_id,
xxen_util.meaning(2,'WIP_TRANSACTION_TYPE',700) transaction_type,
o.resource_code,
o.overhead_code,
o.op_seq_num,
o.res_seq_num,
o.res_basis_type basis_type,
o.ovhd_basis_type,
(select max(wro.wip_supply_type) from wip_requirement_operations wro where o.wip_entity_id=wro.wip_entity_id and o.op_seq_num=wro.operation_seq_num) wip_supply_type,
null quantity,
null resource_id,
null cost_element_id,
nvl(sum(decode(o.side,1,o.overhead_rate)),0) overhead_rate1,
nvl(sum(decode(o.side,2,o.overhead_rate)),0) overhead_rate2,
nvl(sum(decode(o.side,1,o.quantity)),0) quantity1,
nvl(sum(decode(o.side,2,o.quantity)),0) quantity2
from
(
select
wo.wip_entity_id,
null resource_code,
br_ovhd.resource_code overhead_code,
wo.operation_seq_num op_seq_num,
to_number(null) res_seq_num,
to_number(null) res_basis_type,
cdo.basis_type ovhd_basis_type,
cdo.side,
cdo.overhead_rate,
decode(cdo.basis_type,1,wo.quantity_completed,2,1) quantity
from
wip_operations wo,
(
select
rowgen.column_value side,
cdo.organization_id,
cdo.department_id,
cdo.overhead_id,
cdo.cost_type_id,
cdo.basis_type,
nvl(cdo.rate_or_amount,0) overhead_rate
from
table(xxen_util.rowgen(2)) rowgen,
cst_cost_types cct,
cst_department_overheads cdo
where
cct.cost_type=decode(rowgen.column_value,1,:p_cost_type1,:p_cost_type2) and
(cdo.cost_type_id=cct.cost_type_id or cdo.cost_type_id=1 and cct.cost_type_id<>1 and (cdo.organization_id,cdo.department_id,cdo.overhead_id) not in (select cdo2.organization_id, cdo2.department_id, cdo2.overhead_id from cst_department_overheads cdo2 where cct.cost_type_id=cdo2.cost_type_id))
) cdo,
bom_resources br_ovhd
where
wo.quantity_completed<>0 and
wo.organization_id=cdo.organization_id and
wo.department_id=cdo.department_id and
cdo.basis_type in (1,2) and
cdo.overhead_id=br_ovhd.resource_id
union all
select
wor.wip_entity_id,
br.resource_code,
br_ovhd.resource_code overhead_code,
wor.operation_seq_num op_seq_num,
wor.resource_seq_num res_seq_num,
wor.basis_type res_basis_type,
cdo.basis_type ovhd_basis_type,
cdo.side,
cdo.overhead_rate,
decode(cdo.basis_type,3,wor.applied_resource_units,4,wor.applied_resource_units*nvl((select max(crc.resource_rate) keep (dense_rank first order by decode(crc.cost_type_id,1,2,1)) from cst_resource_costs crc where wor.organization_id=crc.organization_id and wor.resource_id=crc.resource_id and crc.cost_type_id in (cdo.requested_cost_type_id,1)),0)) quantity
from
wip_operations wo,
wip_operation_resources wor,
bom_resources br,
cst_resource_overheads cro,
(
select
rowgen.column_value side,
cct.cost_type_id requested_cost_type_id,
cdo.organization_id,
cdo.department_id,
cdo.overhead_id,
cdo.cost_type_id,
cdo.basis_type,
nvl(cdo.rate_or_amount,0) overhead_rate
from
table(xxen_util.rowgen(2)) rowgen,
cst_cost_types cct,
cst_department_overheads cdo
where
cct.cost_type=decode(rowgen.column_value,1,:p_cost_type1,:p_cost_type2) and
(cdo.cost_type_id=cct.cost_type_id or cdo.cost_type_id=1 and cct.cost_type_id<>1 and (cdo.organization_id,cdo.department_id,cdo.overhead_id) not in (select cdo2.organization_id, cdo2.department_id, cdo2.overhead_id from cst_department_overheads cdo2 where cct.cost_type_id=cdo2.cost_type_id))
) cdo,
bom_resources br_ovhd
where
wo.wip_entity_id=wor.wip_entity_id and
wo.operation_seq_num=wor.operation_seq_num and
wo.organization_id=wor.organization_id and
wor.applied_resource_units<>0 and
wor.resource_id=br.resource_id and
wo.organization_id=cdo.organization_id and
wo.department_id=cdo.department_id and
cdo.basis_type in (3,4) and
cdo.cost_type_id=cro.cost_type_id and
cdo.organization_id=cro.organization_id and
cdo.overhead_id=cro.overhead_id and
wor.resource_id=cro.resource_id and
cdo.overhead_id=br_ovhd.resource_id
) o
group by
o.wip_entity_id,
o.resource_code,
o.overhead_code,
o.op_seq_num,
o.res_seq_num,
o.res_basis_type,
o.ovhd_basis_type
) d
where
j.wip_entity_id=d.wip_entity_id and
(d.row_type<>'O' or j.date_released is not null)
) y,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
cst_item_costs cic1,
cst_item_costs cic2,
cst_resource_costs crc1,
cst_resource_costs crc2
where
15=15 and
y.organization_id=msiv.organization_id and
y.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
decode(y.row_type,'C',y.inventory_item_id,'M',y.inventory_item_id)=cic1.inventory_item_id(+) and
y.organization_id=cic1.organization_id(+) and
y.cost_type_id1=cic1.cost_type_id(+) and
decode(y.row_type,'C',y.inventory_item_id,'M',y.inventory_item_id)=cic2.inventory_item_id(+) and
y.organization_id=cic2.organization_id(+) and
y.cost_type_id2=cic2.cost_type_id(+) and
y.resource_id=crc1.resource_id(+) and
y.organization_id=crc1.organization_id(+) and
y.cost_type_id1=crc1.cost_type_id(+) and
y.resource_id=crc2.resource_id(+) and
y.organization_id=crc2.organization_id(+) and
y.cost_type_id2=crc2.cost_type_id(+) and
(y.row_type not in ('C','M') or cic1.cost_type_id=1 or cic1.based_on_rollup_flag=1 and cic1.item_cost is not null or cic1.based_on_rollup_flag=2) and
(y.row_type<>'R' or crc1.resource_id is not null)
) z
where
(:p_all_wip_jobs='Y' or nvl(abs(round(z.filter1*z.rate1,5)-round(z.filter2*z.rate2,5))+abs(round(z.pii1*z.rate1,5)-round(z.pii2*z.rate2,5)),abs(round(z.filter1,5)-round(z.filter2,5))+abs(round(z.pii1,5)-round(z.pii2,5)))<>0)
order by
z.ledger,
z.operating_unit,
z.org_code,
z.organization_name,
z.class_code,
z.wip_entity_name,
z.transaction_type,
z.item_number,
z.op_seq_num,
z.res_seq_num
