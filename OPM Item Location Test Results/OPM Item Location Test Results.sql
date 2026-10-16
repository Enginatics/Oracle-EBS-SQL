/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Item Location Test Results
-- Description: Oracle Process Manufacturing (OPM) Quality item/location test results: the QC test results recorded against inventory item, lot and subinventory samples, with the result value, the applicable specification minimum/target/maximum limits, an in-specification indicator and the sample disposition. The governing specification is resolved from the inventory spec validity rule effective for each sample's item, organization and lot. Answers what the lab results were for a given item or lot and whether they were in specification.
-- Excel Example Output: https://www.enginatics.com/example/opm-item-location-test-results/
-- Library Link: https://www.enginatics.com/reports/opm-item-location-test-results/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
nvl(gs.lot_number,gs.lot_no) lot,
gs.subinventory,
gs.sample_no,
gqt.test_code,
gqtt.test_desc,
nvl(to_char(gr.result_value_num),gr.result_value_char) result_value,
gstv.min_value_num spec_min,
gstv.target_value_num spec_target,
gstv.max_value_num spec_max,
gstv.test_qty_uom spec_uom,
xxen_util.yes(case when gr.result_value_num is not null and gstv.min_value_num is not null and gr.result_value_num between gstv.min_value_num and gstv.max_value_num then 'Y' end) in_spec,
xxen_util.meaning(gs.sample_disposition,'GMD_QC_SAMPLE_DISP',552) sample_disposition,
gs.date_drawn,
gr.result_date
from
gmd_results gr,
gmd_samples gs,
gmd_qc_tests_b gqt,
gmd_qc_tests_tl gqtt,
mtl_system_items_vl msiv,
org_organization_definitions ood,
(
select
gs2.sample_id,
max(givr.spec_id) keep (dense_rank first order by case when givr.lot_number=gs2.lot_no then 1 else 2 end, givr.start_date desc) spec_id
from
gmd_samples gs2,
gmd_inventory_spec_vrs givr,
gmd_specifications_b gsb
where
givr.organization_id=gs2.organization_id and
givr.spec_id=gsb.spec_id and
gsb.inventory_item_id=gs2.inventory_item_id and
(givr.lot_number is null or givr.lot_number=gs2.lot_no) and
(givr.start_date is null or givr.start_date<=gs2.date_drawn) and
(givr.end_date is null or givr.end_date>=gs2.date_drawn)
group by
gs2.sample_id
) vr,
gmd_spec_tests_vl gstv
where
1=1 and
gs.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gr.sample_id=gs.sample_id and
gr.test_id=gqt.test_id and
gqt.test_id=gqtt.test_id and
gqtt.language=userenv('lang') and
gs.inventory_item_id=msiv.inventory_item_id and
gs.organization_id=msiv.organization_id and
gs.organization_id=ood.organization_id and
gs.sample_id=vr.sample_id(+) and
vr.spec_id=gstv.spec_id(+) and
gr.test_id=gstv.test_id(+)
order by
ood.organization_code,
msiv.concatenated_segments,
nvl(gs.lot_number,gs.lot_no),
gs.sample_no,
gqt.test_code
