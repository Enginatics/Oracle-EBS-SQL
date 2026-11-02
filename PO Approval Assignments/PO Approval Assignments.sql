/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Assignments
-- Description: Active PO document approval group assignments with HR jobs or positions.
-- Person Name lists the people currently assigned to the position, or to the job when the assignment has no position. With Employee Name entered, it shows only that person.
-- Show Approval Group Amounts adds the rules of each approval group as on the Approval Groups form, one row per rule, including rules with an inactive date.
-- Excel Example Output: https://www.enginatics.com/example/po-approval-assignments/
-- Library Link: https://www.enginatics.com/reports/po-approval-assignments/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
haouv2.name hr_organization,
(
select /*+ use_concat */
rtrim(dbms_xmlgen.convert(xmlagg(xmlelement(e,max(ppx.full_name)||','||chr(10)) order by max(ppx.full_name)).extract('//text()').getclobval(),1),','||chr(10))
from
per_assignments_x pax,
per_people_x ppx
where
(ppca.position_id=pax.position_id or ppca.position_id is null and ppca.job_id=pax.job_id) and
pax.assignment_type in ('E','C') and
pax.person_id=ppx.person_id and
2=2
group by
ppx.person_id
) person_name,
pp.name position,
pjv.name job,
pcf.control_function_name document_type,
pcga.control_group_name approval_group,
pcga.description approval_group_description,
&approval_group_amount_columns
ppca.start_date,
xxen_util.user_name(ppca.created_by) created_by,
xxen_util.client_time(ppca.creation_date) creation_date,
xxen_util.user_name(ppca.last_updated_by) last_updated_by,
xxen_util.client_time(ppca.last_update_date) last_update_date,
xxen_util.meaning(pcf.document_type_code,'DOCUMENT TYPE',201) document_type_,
xxen_util.meaning(pcf.document_subtype,'NTN_DOC_TYPE',0) document_subtype
from
po_position_controls_all ppca,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2,
(select pjv.* from per_jobs_vl pjv where sysdate between pjv.date_from and nvl (pjv.date_to, sysdate)) pjv,
(select pp.* from per_positions pp where sysdate between pp.date_effective and nvl (pp.date_end, sysdate)) pp,
po_control_groups_all pcga,
po_control_functions pcf,
(
select
x.control_group_id,
x.control_rule_id,
x.object_code,
x.rule_type_code,
x.object,
x.rule_type,
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
xxen_util.meaning(pcr.object_code,'CONTROLLED_OBJECT',201) object,
xxen_util.meaning(pcr.rule_type_code,'CONTROL_TYPE',201) rule_type,
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
po_control_groups_all pcga,
po_control_rules pcr
where
'&show_approval_group_amounts'='Y' and
pcga.control_group_id=pcr.control_group_id
) x
) pcr
where
1=1 and
sysdate between ppca.start_date and nvl(ppca.end_date,sysdate) and
ppca.org_id=haouv.organization_id and
ppca.organization_id=haouv2.organization_id(+) and
ppca.job_id=pjv.job_id(+) and
ppca.position_id=pp.position_id(+) and
ppca.control_group_id=pcga.control_group_id(+) and
ppca.control_function_id=pcf.control_function_id(+) and
ppca.control_group_id=pcr.control_group_id(+)
order by
haouv.name,
pjv.name,
pp.name,
pcga.control_group_name,
pcf.control_function_name,
decode(pcr.object_code,'DOCUMENT_TOTAL',1,'ACCOUNT_RANGE',2,'ITEM_CATEGORY_RANGE',3,'ITEM_RANGE',4,'LOCATION',5,6),
pcr.rule_type_code,
pcr.control_rule_id
