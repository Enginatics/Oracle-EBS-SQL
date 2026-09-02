/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Lot Genealogy
-- Description: Oracle Process Manufacturing (OPM) batch lot genealogy: the parent-to-child lot relationships (which ingredient lots produced which product lots), enriched with each lot's material status, grade, origination and expiration dates. Supports recall, quality and where-used lot traceability.
-- Excel Examle Output: https://www.enginatics.com/example/opm-batch-lot-genealogy/
-- Library Link: https://www.enginatics.com/reports/opm-batch-lot-genealogy/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv_c.concatenated_segments item,
mln_c.lot_number lot,
mms.status_code lot_status,
mln_c.grade_code lot_grade,
mln_c.origination_date,
mln_c.expiration_date,
msiv_p.concatenated_segments parent_item,
mln_p.lot_number parent_lot,
decode(mog.object_type,1,'Lot',2,'Lot resulting from WIP',5,'Serial') object_type
from
mtl_object_genealogy mog,
mtl_lot_numbers mln_c,
mtl_lot_numbers mln_p,
mtl_system_items_vl msiv_c,
mtl_system_items_vl msiv_p,
mtl_material_statuses_vl mms,
org_organization_definitions ood
where
1=1 and
mln_c.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mog.object_id=mln_c.gen_object_id and
mog.parent_object_id=mln_p.gen_object_id(+) and
mln_c.inventory_item_id=msiv_c.inventory_item_id and
mln_c.organization_id=msiv_c.organization_id and
mln_p.inventory_item_id=msiv_p.inventory_item_id(+) and
mln_p.organization_id=msiv_p.organization_id(+) and
mln_c.status_id=mms.status_id(+) and
mln_c.organization_id=ood.organization_id
order by
ood.organization_code,
msiv_c.concatenated_segments,
mln_c.lot_number