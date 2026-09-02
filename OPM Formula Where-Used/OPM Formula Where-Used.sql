/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Formula Where-Used
-- Description: Oracle Process Manufacturing (OPM) formula where-used: lists which formulas consume a given ingredient item, with the ingredient quantity and UOM, the using formula and its status, the formula's primary product, and how many recipes use that formula. Supports ingredient impact analysis for substitution, supplier change and allergen / regulatory recall.
-- Excel Examle Output: https://www.enginatics.com/example/opm-formula-where-used/
-- Library Link: https://www.enginatics.com/reports/opm-formula-where-used/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv.concatenated_segments ingredient_item,
msiv.description ingredient_description,
fmd.qty ingredient_qty,
fmd.detail_uom ingredient_uom,
fmd.scrap_factor,
ffm.formula_no,
ffm.formula_vers,
gsv.meaning formula_status,
(
select
msiv2.concatenated_segments
from
fm_matl_dtl fmd2,
mtl_system_items_vl msiv2
where
fmd2.formula_id=ffm.formula_id and
fmd2.line_type=1 and
fmd2.inventory_item_id=msiv2.inventory_item_id and
fmd2.organization_id=msiv2.organization_id and
rownum=1
) product_item,
(
select
count(distinct grv.recipe_id)
from
gmd_recipes_vl grv
where
grv.formula_id=ffm.formula_id
) recipes_using
from
fm_matl_dtl fmd,
fm_form_mst ffm,
mtl_system_items_vl msiv,
org_organization_definitions ood,
gmd_status_vl gsv
where
1=1 and
fmd.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
fmd.line_type=-1 and
fmd.formula_id=ffm.formula_id and
fmd.inventory_item_id=msiv.inventory_item_id and
fmd.organization_id=msiv.organization_id and
fmd.organization_id=ood.organization_id and
gsv.status_code(+)=ffm.formula_status
order by
ood.organization_code,
msiv.concatenated_segments,
ffm.formula_no