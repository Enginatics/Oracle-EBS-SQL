/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Specifications and Test Limits
-- Description: Oracle Process Manufacturing (OPM) Quality specifications and test limits: every GMD specification with its version and status, the item and grade it applies to, and each specification test's minimum, target and maximum limits, UOM, certificate-of-analysis print flag and report precision. The master reference for an organization's quality standards.
-- Excel Examle Output: https://www.enginatics.com/example/opm-specifications-and-test-limits/
-- Library Link: https://www.enginatics.com/reports/opm-specifications-and-test-limits/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
gsb.spec_name,
gsb.spec_vers,
gstl.spec_desc,
gsv.meaning spec_status,
msiv.concatenated_segments item,
msiv.description item_description,
gsb.grade,
gqt.test_code,
gqtt.test_desc,
nvl(to_char(gstv.min_value_num),gstv.min_value_char) min_value,
to_char(gstv.target_value_num) target_value,
nvl(to_char(gstv.max_value_num),gstv.max_value_char) max_value,
gstv.test_qty_uom uom,
xxen_util.yes(gstv.print_on_coa_ind) print_on_coa,
gstv.report_precision
from
gmd_specifications_b gsb,
gmd_specifications_tl gstl,
gmd_spec_tests_vl gstv,
gmd_qc_tests_b gqt,
gmd_qc_tests_tl gqtt,
mtl_system_items_vl msiv,
org_organization_definitions ood,
gmd_status_vl gsv
where
1=1 and
gsb.owner_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gsb.spec_id=gstl.spec_id and
gstl.language=userenv('lang') and
gsb.spec_id=gstv.spec_id and
gstv.test_id=gqt.test_id and
gqt.test_id=gqtt.test_id and
gqtt.language=userenv('lang') and
gsb.inventory_item_id=msiv.inventory_item_id and
gsb.owner_organization_id=msiv.organization_id and
gsb.owner_organization_id=ood.organization_id and
gsv.status_code(+)=gsb.spec_status
order by
ood.organization_code,
gsb.spec_name,
gsb.spec_vers,
gqt.test_code