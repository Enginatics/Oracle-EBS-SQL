/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Recipe Details
-- Description: OPM (Process Manufacturing) recipe details combining recipe status, validity rules, preferences, formula product quantity and routing step / resource quantities. Supports data cleaning before cost roll up. Optionally shows an item category code via the Category Set parameter.
-- Excel Examle Output: https://www.enginatics.com/example/opm-recipe-details/
-- Library Link: https://www.enginatics.com/reports/opm-recipe-details/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv.segment1,
msiv.inventory_item_status_code,
msiv.description,
msiv.weight_uom_code,
cat.ca_code,
grv.recipe_no,
grv.recipe_description,
grv.recipe_version,
gsv_r.meaning recipe_status,
frh.routing_no,
grvr.preference validity_rule_preference,
grvr.start_date validity_rule_from_date,
gsv_v.meaning validity_rule_status,
grvr.std_qty validity_rule_qty,
grvr.detail_uom validity_rule_uom,
ff.product_qty,
ff.product_uom,
aa.step_no,
aa.step_qty,
aa.step_qty_uom,
aa.resource_code,
aa.proc_qty,
aa.proc_uom,
aa.res_usage,
aa.res_uom
from
gmd_recipes_vl grv,
org_organization_definitions ood,
gmd_recipe_validity_rules grvr,
mtl_system_items_vl msiv,
gmd_status_vl gsv_r,
gmd_status_vl gsv_v,
fm_rout_hdr frh,
(
select
mic.organization_id,
mic.inventory_item_id,
mcbk.concatenated_segments ca_code
from
mtl_item_categories mic,
mtl_categories_b_kfv mcbk,
mtl_category_sets_vl mcsv
where
mic.category_id=mcbk.category_id and
mic.category_set_id=mcsv.category_set_id and
mcsv.category_set_name=:p_category_set
) cat,
(
select
fmd.formula_id,
fmd.qty product_qty,
fmd.detail_uom product_uom
from
fm_matl_dtl fmd
where
fmd.line_type=1
group by
fmd.formula_id,
fmd.qty,
fmd.detail_uom
) ff,
(
select
frd.routing_id,
frd.routingstep_no step_no,
frd.step_qty,
gov.process_qty_uom step_qty_uom,
gor.resources resource_code,
gor.process_qty proc_qty,
gor.resource_process_uom proc_uom,
gor.resource_usage res_usage,
gor.resource_usage_uom res_uom
from
gmd_operation_resources gor,
gmd_operation_activities goa,
gmd_operations_vl gov,
fm_rout_dtl frd
where
gov.oprn_id=frd.oprn_id and
gov.oprn_id=goa.oprn_id and
gor.oprn_line_id=goa.oprn_line_id
) aa
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
grv.owner_organization_id=ood.organization_id and
grv.recipe_id=grvr.recipe_id and
grvr.organization_id=ood.organization_id and
msiv.inventory_item_id=grvr.inventory_item_id and
msiv.organization_id=grvr.organization_id and
gsv_r.status_code(+)=grv.recipe_status and
gsv_v.status_code(+)=grvr.validity_rule_status and
grv.routing_id=frh.routing_id(+) and
grv.formula_id=ff.formula_id(+) and
grv.routing_id=aa.routing_id(+) and
grvr.organization_id=cat.organization_id(+) and
grvr.inventory_item_id=cat.inventory_item_id(+) and
grv.recipe_status<>'1000'
order by
ood.organization_code,
grv.recipe_no