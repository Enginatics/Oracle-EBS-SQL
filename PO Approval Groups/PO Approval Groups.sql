/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Groups
-- Description: PO approval groups and approval rules e.g. amount limits or account ranges
-- Excel Example Output: https://www.enginatics.com/example/po-approval-groups/
-- Library Link: https://www.enginatics.com/reports/po-approval-groups/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.approval_group,
x.description,
x.object,
initcap(x.rule_type_code) type,
x.amount_limit,
case x.object_code
when 'LOCATION' then (select hla.location_code from hr_locations_all hla where x.location_id=hla.location_id)
else (
select
replace(rtrim(listagg(decode(fis.application_column_name,
'SEGMENT1',x.segment1_low,
'SEGMENT2',x.segment2_low,
'SEGMENT3',x.segment3_low,
'SEGMENT4',x.segment4_low,
'SEGMENT5',x.segment5_low,
'SEGMENT6',x.segment6_low,
'SEGMENT7',x.segment7_low,
'SEGMENT8',x.segment8_low,
'SEGMENT9',x.segment9_low,
'SEGMENT10',x.segment10_low,
'SEGMENT11',x.segment11_low,
'SEGMENT12',x.segment12_low,
'SEGMENT13',x.segment13_low,
'SEGMENT14',x.segment14_low,
'SEGMENT15',x.segment15_low,
'SEGMENT16',x.segment16_low,
'SEGMENT17',x.segment17_low,
'SEGMENT18',x.segment18_low,
'SEGMENT19',x.segment19_low,
'SEGMENT20',x.segment20_low,
'SEGMENT21',x.segment21_low,
'SEGMENT22',x.segment22_low,
'SEGMENT23',x.segment23_low,
'SEGMENT24',x.segment24_low,
'SEGMENT25',x.segment25_low,
'SEGMENT26',x.segment26_low,
'SEGMENT27',x.segment27_low,
'SEGMENT28',x.segment28_low,
'SEGMENT29',x.segment29_low,
'SEGMENT30',x.segment30_low
)||chr(1)) within group (order by fis.segment_num),chr(1)),chr(1),max(fifs.concatenated_segment_delimiter))
from
fnd_id_flex_structures fifs,
fnd_id_flex_segments fis
where
x.application_id=fifs.application_id and
x.id_flex_code=fifs.id_flex_code and
x.id_flex_num=fifs.id_flex_num and
fifs.application_id=fis.application_id and
fifs.id_flex_code=fis.id_flex_code and
fifs.id_flex_num=fis.id_flex_num and
fis.enabled_flag='Y'
)
end low_value,
(
select
replace(rtrim(listagg(decode(fis.application_column_name,
'SEGMENT1',x.segment1_high,
'SEGMENT2',x.segment2_high,
'SEGMENT3',x.segment3_high,
'SEGMENT4',x.segment4_high,
'SEGMENT5',x.segment5_high,
'SEGMENT6',x.segment6_high,
'SEGMENT7',x.segment7_high,
'SEGMENT8',x.segment8_high,
'SEGMENT9',x.segment9_high,
'SEGMENT10',x.segment10_high,
'SEGMENT11',x.segment11_high,
'SEGMENT12',x.segment12_high,
'SEGMENT13',x.segment13_high,
'SEGMENT14',x.segment14_high,
'SEGMENT15',x.segment15_high,
'SEGMENT16',x.segment16_high,
'SEGMENT17',x.segment17_high,
'SEGMENT18',x.segment18_high,
'SEGMENT19',x.segment19_high,
'SEGMENT20',x.segment20_high,
'SEGMENT21',x.segment21_high,
'SEGMENT22',x.segment22_high,
'SEGMENT23',x.segment23_high,
'SEGMENT24',x.segment24_high,
'SEGMENT25',x.segment25_high,
'SEGMENT26',x.segment26_high,
'SEGMENT27',x.segment27_high,
'SEGMENT28',x.segment28_high,
'SEGMENT29',x.segment29_high,
'SEGMENT30',x.segment30_high
)||chr(1)) within group (order by fis.segment_num),chr(1)),chr(1),max(fifs.concatenated_segment_delimiter))
from
fnd_id_flex_structures fifs,
fnd_id_flex_segments fis
where
x.application_id=fifs.application_id and
x.id_flex_code=fifs.id_flex_code and
x.id_flex_num=fifs.id_flex_num and
fifs.application_id=fis.application_id and
fifs.id_flex_code=fis.id_flex_code and
fifs.id_flex_num=fis.id_flex_num and
fis.enabled_flag='Y'
) high_value,
x.inactive_date
from
(
select
haouv.name operating_unit,
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
hr_all_organization_units_vl haouv,
po_control_groups_all pcga,
po_control_rules pcr
where
1=1 and
haouv.organization_id=pcga.org_id and
pcga.control_group_id=pcr.control_group_id
) x
order by
x.operating_unit,
x.approval_group,
x.object,
x.rule_type_code
