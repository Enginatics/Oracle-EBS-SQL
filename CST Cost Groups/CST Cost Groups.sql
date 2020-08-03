/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Cost Groups
-- Description: Master data report that lists all item cost groups along with their corresponding GL posting codes and descriptions.
-- Excel Examle Output: https://www.enginatics.com/example/cst-cost-groups/
-- Library Link: https://www.enginatics.com/reports/cst-cost-groups/
-- Run Report: https://demo.enginatics.com/

select
ccg.cost_group,
xxen_util.meaning(ccg.cost_group_type,'CST_COST_GROUP_TYPE',700) type,
ccg.description,
ccg.disable_date,
xxen_util.meaning(nvl2(ccg.organization_id,null,'Y'),'YES_NO',0) multi_org,
haouv.name organization,
xep.name legal_entity,
xxen_util.concatenated_segments(ccga.material_account) material,
xxen_util.concatenated_segments(ccga.material_overhead_account) material_overhead,
xxen_util.concatenated_segments(ccga.resource_account) resource_,
xxen_util.concatenated_segments(ccga.outside_processing_account) outside_processing,
xxen_util.concatenated_segments(ccga.overhead_account) overhead,
xxen_util.concatenated_segments(ccga.expense_account) expense,
xxen_util.concatenated_segments(ccga.average_cost_var_account) cost_variance,
xxen_util.concatenated_segments(ccga.encumbrance_account) encumbrance,
xxen_util.concatenated_segments(ccga.purchase_price_var_account) purchase_price_variance,
xxen_util.segments_description(ccga.material_account) material_descr,
xxen_util.segments_description(ccga.material_overhead_account) material_overhead_descr,
xxen_util.segments_description(ccga.resource_account) resource_descr,
xxen_util.segments_description(ccga.outside_processing_account) outside_processing_descr,
xxen_util.segments_description(ccga.overhead_account) overhead_descr,
xxen_util.segments_description(ccga.expense_account) expense_descr,
xxen_util.segments_description(ccga.average_cost_var_account) cost_variance_descr,
xxen_util.segments_description(ccga.encumbrance_account) encumbrance_descr,
xxen_util.segments_description(ccga.purchase_price_var_account) purchase_price_variance_descr
from
cst_cost_groups ccg,
xle_entity_profiles xep,
hr_all_organization_units_vl haouv,
cst_cost_group_accounts ccga
where
ccg.legal_entity=xep.legal_entity_id(+) and
ccg.organization_id=haouv.organization_id(+) and
ccg.cost_group_id=ccga.cost_group_id(+) and
ccg.organization_id=ccga.organization_id(+)