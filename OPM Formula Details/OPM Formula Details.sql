/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Formula Details
-- Description: Oracle Process Manufacturing (OPM) Product Development formula details: the ingredient, product and by-product lines of each formula with quantities, UOM, scrap factor, scaling type, planned product percentage and yield contribution. Supports formulation review and data quality checks.
-- Excel Examle Output: https://www.enginatics.com/example/opm-formula-details/
-- Library Link: https://www.enginatics.com/reports/opm-formula-details/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ffm.formula_no,
ffm.formula_vers,
ffm.formula_desc1,
gsv.meaning formula_status,
ffm.total_input_qty,
ffm.total_output_qty,
decode(fmd.line_type,-1,'Ingredient',1,'Product',2,'By-Product') line_type,
fmd.line_no,
msiv.concatenated_segments item,
msiv.description item_description,
fmd.qty,
fmd.detail_uom uom,
fmd.scrap_factor,
gl.meaning scale_type,
fmd.prod_percent,
xxen_util.yes(fmd.contribute_yield_ind) contributes_to_yield
from
fm_form_mst ffm,
fm_matl_dtl fmd,
mtl_system_items_vl msiv,
org_organization_definitions ood,
gmd_status_vl gsv,
gem_lookups gl
where
1=1 and
fmd.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ffm.formula_id=fmd.formula_id and
fmd.inventory_item_id=msiv.inventory_item_id and
fmd.organization_id=msiv.organization_id and
fmd.organization_id=ood.organization_id and
gsv.status_code(+)=ffm.formula_status and
gl.lookup_type(+)='SCALE_TYPE' and
gl.lookup_code(+)=fmd.scale_type
order by
ood.organization_code,
ffm.formula_no,
ffm.formula_vers,
fmd.line_no