/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Groups
-- Description: PO approval groups and approval rules e.g. amount limits or account ranges
-- Excel Examle Output: https://www.enginatics.com/example/po-approval-groups
-- Library Link: https://www.enginatics.com/reports/po-approval-groups
-- Run Report: https://demo.enginatics.com/


select
x.ou,
x.approval_group,
x.description,
x.object,
initcap(x.rule_type_code) type,
x.amount_limit,
case x.object_code
when 'LOCATION' then (select hl.location_code from hr_locations hl where x.location_id=hl.location_id)
else trim (fifs.concatenated_segment_delimiter from
x.segment1_low||fifs.concatenated_segment_delimiter||
x.segment2_low||fifs.concatenated_segment_delimiter||
x.segment3_low||fifs.concatenated_segment_delimiter||
x.segment4_low||fifs.concatenated_segment_delimiter||
x.segment5_low||fifs.concatenated_segment_delimiter||
x.segment6_low||fifs.concatenated_segment_delimiter||
x.segment7_low||fifs.concatenated_segment_delimiter||
x.segment8_low||fifs.concatenated_segment_delimiter||
x.segment9_low||fifs.concatenated_segment_delimiter||
x.segment10_low||fifs.concatenated_segment_delimiter||
x.segment11_low||fifs.concatenated_segment_delimiter||
x.segment12_low||fifs.concatenated_segment_delimiter||
x.segment13_low)
end low_value,
trim (fifs.concatenated_segment_delimiter from
x.segment1_high||fifs.concatenated_segment_delimiter||
x.segment2_high||fifs.concatenated_segment_delimiter||
x.segment3_high||fifs.concatenated_segment_delimiter||
x.segment4_high||fifs.concatenated_segment_delimiter||
x.segment5_high||fifs.concatenated_segment_delimiter||
x.segment6_high||fifs.concatenated_segment_delimiter||
x.segment7_high||fifs.concatenated_segment_delimiter||
x.segment8_high||fifs.concatenated_segment_delimiter||
x.segment9_high||fifs.concatenated_segment_delimiter||
x.segment10_high||fifs.concatenated_segment_delimiter||
x.segment11_high||fifs.concatenated_segment_delimiter||
x.segment12_high||fifs.concatenated_segment_delimiter||
x.segment13_high) high_value
from
(
select
haou.name ou,
pcga.control_group_name approval_group,
pcga.description,
xxen_util.meaning(pcr.object_code,'CONTROLLED_OBJECT',201) object,
decode(pcr.object_code,
'ACCOUNT_RANGE',101,
'ITEM_CATEGORY_RANGE',401,
'ITEM_RANGE',401
) application_id,
decode(pcr.object_code,
'ACCOUNT_RANGE','GL#',
'ITEM_CATEGORY_RANGE','MCAT',
'ITEM_RANGE','MSTK'
) id_flex_code,
decode(pcr.object_code,
'ACCOUNT_RANGE',(select gl.chart_of_accounts_id from financials_system_params_all fspa, gl_ledgers gl where pcga.org_id=fspa.org_id and fspa.set_of_books_id=gl.ledger_id),
'ITEM_CATEGORY_RANGE',(select mcsb.structure_id from mtl_default_category_sets mdcs, mtl_category_sets_b mcsb where mdcs.functional_area_id=2 and mdcs.category_set_id=mcsb.category_set_id),
'ITEM_RANGE',101
) id_flex_num,
pcr.*
from
hr_all_organization_units haou,
po_control_groups_all pcga,
po_control_rules pcr
where
1=1 and
haou.organization_id=pcga.org_id and
pcga.control_group_id=pcr.control_group_id
) x,
fnd_id_flex_structures fifs
where
x.application_id=fifs.application_id(+) and
x.id_flex_code=fifs.id_flex_code(+) and
x.id_flex_num=fifs.id_flex_num(+)
order by
x.ou,
x.approval_group,
x.object,
x.rule_type_code