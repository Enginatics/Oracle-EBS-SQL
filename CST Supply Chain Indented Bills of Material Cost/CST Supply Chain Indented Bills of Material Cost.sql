/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Supply Chain Indented Bills of Material Cost
-- Description: Imported Oracle standard Supply Chain Indented Bills of Material Cost report
Application: Bills of Material
This report is based on the (static) Oracle Supply Chain Indented Bills of Material Cost Report and merely sums up the available information from the Cost Type.  It does not do a Cost Rollup and as a result, the "Extended Cost" column might not add up to the total item cost for the assembly especially  if changes have been made to the bills of material, routing or item costs, since the last cost rollup.  If this is the case, run a Supply Chain Cost Rollup in Pending or some other cost type (such as Current) for reporting purposes, to synchronize the cost information and then use this report, using the same cost type, to correctly report your item costs.

Source: Supply Chain Indented Bills of Material Cost Report (XML)
Short Name: CSTRSCCRI_XML
DB package: BOM_CSTRSCCR_XMLP_PKG

-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2020 Eric Clegg     Initial Coding
-- |  2.0     22 Jun 2022 Douglas Volz   Corrected Extended Cost column to only show this level costs.
-- |  3.0     31 Aug 2022 Douglas Volz   Added Effectivity Date and Assignment Set parameters and cost type column.

-- Excel Examle Output: https://www.enginatics.com/example/cst-supply-chain-indented-bills-of-material-cost/
-- Library Link: https://www.enginatics.com/reports/cst-supply-chain-indented-bills-of-material-cost/
-- Run Report: https://demo.enginatics.com/

select distinct
ood0.organization_code,
ood0.organization_name,
gl.currency_code,
msiv0.concatenated_segments assembly,
msiv0.description assembly_description,
--mck.concatenated_segments category,
msiv.concatenated_segments component,
msiv.description component_description,
msiv.primary_uom_code uom,
csbs.sort_order comp_sort_order,
lpad('.',csbs.bom_level-1,'.')||to_char(csbs.bom_level-1) comp_level_code,
bcb.operation_seq_num,
csbs.component_quantity,
decode(csbs.extended_quantity,1, csbs.component_quantity,csbs.extended_quantity) extended_quantity,
csbs.component_revision comp_last_rev,
xxen_util.meaning(csbs.include_in_cost_rollup,'SYS_YES_NO',700) include_in_rollup,
xxen_util.meaning(nvl(cic.based_on_rollup_flag,2),'SYS_YES_NO',700) based_on_rollup,
xxen_util.meaning(nvl(cic.inventory_asset_flag,2),'SYS_YES_NO',700) inventory_asset,
xxen_util.meaning(csbs.phantom_flag,'SYS_YES_NO',700) phantom,
xxen_util.meaning(nvl(bcb.basis_type,1),'CST_BASIS',700)||bcb.component_yield_factor basis_type,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
bcb.component_yield_factor component_yield_factor,
bcb.planning_factor ,
cic.shrinkage_rate shrinkage_rate,
cic.item_cost,
cce.cost_element,
br.resource_code sub_element,
bd.department_code department,
case when cicd.cost_element_id in (3,4) then xxen_util.meaning(nvl(br.allow_costs_flag,1),'SYS_YES_NO',700) end costed,
xxen_util.meaning(cicd.basis_type,'CST_BASIS_SHORT',700) basis,
br.unit_of_measure,
nvl(cicd.usage_rate_or_amount,0) usage_rate_or_amount,
decode(cicd.cost_element_id,2,csbs.extended_quantity,5,csbs.extended_quantity,1)*cicd.basis_factor*cicd.net_yield_or_shrinkage_factor basis_factor,
decode(cicd.cost_element_id,2,1,5,1,csbs.extended_quantity)*cicd.usage_rate_or_amount ext_usage_rate_or_amount,
decode(cicd.cost_element_id,3,cicd.resource_rate,4,cicd.resource_rate,to_number(NULL)) res_unit_cost,
-- Revision for version 2, suppress previous level costs to agree with standard Oracle report and extended costs column to add up to the total item costs
/*decode(decode(csbs.phantom_flag,1,1,0)*decode(csbs.assembly_organization_id,csbs.component_organization_id,1,0),1,decode(cicd.level_type,2,1,decode(cicd.cost_element_id,3,0,4,0,5,0,decode(:p_phantom_mat,1,1,0)))*
decode(csbs.extend_cost_flag,2,0,csbs.extended_quantity*decode(cicd.item_cost,cicd.yielded_cost,0,cicd.item_cost)), decode(csbs.extend_cost_flag,2,0,csbs.extended_quantity*cicd.item_cost)) res_extended_cost,*/
decode(csbs.sort_order,0,0,decode(cicd.level_type,
    2, 0,
    1, decode(decode(csbs.phantom_flag,1,1,0)*decode(csbs.assembly_organization_id,csbs.component_organization_id,1,0),1,decode(cicd.level_type,2,1,decode(cicd.cost_element_id,3,0,4,0,5,0,decode(:p_phantom_mat,1,1,0)))*
       decode(csbs.extend_cost_flag,2,0,csbs.extended_quantity*decode(cicd.item_cost,cicd.yielded_cost,0,cicd.item_cost)), decode(csbs.extend_cost_flag,2,0,csbs.extended_quantity*cicd.item_cost))
)) extended_cost,
-- End revision for version 2
-- Revision for version 3
(select cct.cost_type from cst_cost_types cct where cct.cost_type_id = cic.cost_type_id) Cost_Type,
decode(csbs.assembly_item_id,-1,1,2) sort_order2,
csbs.rollup_id
from
cst_sc_bom_structures csbs,
org_organization_definitions ood0,
org_organization_definitions ood,
gl_ledgers gl,
mtl_system_items_vl msiv0,
mtl_system_items_vl msiv,
/*mtl_category_sets_tl mcst,
mtl_item_categories mic,
mtl_categories_kfv mck,*/
bom_components_b bcb,
cst_item_costs cic,
cst_cost_elements cce,
cst_item_cost_details cicd,
bom_resources br,
bom_departments bd
where
--csbs.top_inventory_item_id=137 and
1=1 and
csbs.rollup_id=:p_rollup_id and
csbs.top_organization_id=ood0.organization_id and
ood0.set_of_books_id=gl.ledger_id and
csbs.component_organization_id=ood.organization_id and
csbs.top_inventory_item_id=msiv0.inventory_item_id and
csbs.top_organization_id=msiv0.organization_id and
csbs.component_item_id=msiv.inventory_item_id and
csbs.component_organization_id=msiv.organization_id and
csbs.component_sequence_id=bcb.component_sequence_id(+) and
/*mcst.category_set_id=:p_category_set_id and
mcst.language=userenv('lang') and
mcst.category_set_id=mic.category_set_id and
msiv.organization_id=mic.organization_id and
msiv.inventory_item_id=mic.inventory_item_id and
mic.category_id=mck.category_id and*/
csbs.component_item_id=cic.inventory_item_id(+) and
csbs.component_organization_id=cic.organization_id(+) and
cic.cost_type_id(+)=:p_cost_type_id and
cic.cost_type_id=cicd.cost_type_id(+) and
cicd.inventory_item_id=csbs.component_item_id and
cicd.organization_id=csbs.component_organization_id and
cicd.resource_id is not null and
cce.cost_element_id(+)=cicd.cost_element_id and 
br.resource_id(+)=cicd.resource_id and
bd.department_id(+)=cicd.department_id
order by
csbs.rollup_id,
msiv0.concatenated_segments,
csbs.sort_order