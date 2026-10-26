/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approval Groups Upload
-- Description: Creates and updates the approval groups of the Approval Groups form, with their rules, and the assignments of approval groups to positions or jobs per document type of the Approval Assignments form.
-- A row carries an approval group, optionally with one rule (Object, Type, Amount Limit, Low Value, High Value, Inactive Date), one assignment (Position or Job, Document Type, Start Date, End Date), or both. The group values are taken from the first row of each group.
-- Low Value and High Value of an account, item or item category range hold the segment values separated by the flexfield delimiter, such as 01-000-0000-0000-000. A Location rule takes the location in Low Value.
-- An operating unit that uses approval hierarchies (Use Approval Hierarchies in the Financials options) assigns positions, otherwise jobs.
-- Rules and assignments are ended with Inactive Date and End Date, not deleted.
-- Excel Example Output: https://www.enginatics.com/example/po-approval-groups-upload/
-- Library Link: https://www.enginatics.com/reports/po-approval-groups-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.control_group_id,
x.control_rule_id,
x.position_control_id,
x.row_type_sort,
haouv.name operating_unit,
x.approval_group,
x.group_description,
x.enabled,
x.object,
x.rule_type,
x.amount_limit,
x.low_value,
x.high_value,
x.inactive_date,
x.position,
x.job,
x.document_type,
x.start_date,
x.end_date,
to_number(null) upload_row
from
(
select
pcga.org_id,
pcga.control_group_id,
pcga.control_group_name approval_group,
pcga.description group_description,
xxen_util.yes(pcga.enabled_flag) enabled,
pcr.control_rule_id,
to_number(null) position_control_id,
1 row_type_sort,
xxen_util.meaning(pcr.object_code,'CONTROLLED_OBJECT',201) object,
xxen_util.meaning(pcr.rule_type_code,'CONTROL_TYPE',201) rule_type,
pcr.amount_limit,
xxen_po_upload.control_rule_value(pcr.control_rule_id,'LOW') low_value,
xxen_po_upload.control_rule_value(pcr.control_rule_id,'HIGH') high_value,
pcr.inactive_date,
to_char(null) position,
to_char(null) job,
to_char(null) document_type,
to_date(null) start_date,
to_date(null) end_date
from
po_control_groups_all pcga,
po_control_rules pcr
where
pcga.control_group_id=pcr.control_group_id
union all
select
pcga.org_id,
pcga.control_group_id,
pcga.control_group_name approval_group,
pcga.description group_description,
xxen_util.yes(pcga.enabled_flag) enabled,
to_number(null) control_rule_id,
ppca.position_control_id,
2 row_type_sort,
to_char(null) object,
to_char(null) rule_type,
to_number(null) amount_limit,
to_char(null) low_value,
to_char(null) high_value,
to_date(null) inactive_date,
(select pp.name from per_positions pp where ppca.position_id=pp.position_id) position,
(select pjv.name from per_jobs_vl pjv where ppca.job_id=pjv.job_id) job,
(select pcfa.control_function_name from po_control_functions_all pcfa where ppca.control_function_id=pcfa.control_function_id) document_type,
ppca.start_date,
ppca.end_date
from
po_control_groups_all pcga,
po_position_controls_all ppca
where
pcga.control_group_id=ppca.control_group_id
union all
select
pcga.org_id,
pcga.control_group_id,
pcga.control_group_name approval_group,
pcga.description group_description,
xxen_util.yes(pcga.enabled_flag) enabled,
to_number(null) control_rule_id,
to_number(null) position_control_id,
0 row_type_sort,
to_char(null) object,
to_char(null) rule_type,
to_number(null) amount_limit,
to_char(null) low_value,
to_char(null) high_value,
to_date(null) inactive_date,
to_char(null) position,
to_char(null) job,
to_char(null) document_type,
to_date(null) start_date,
to_date(null) end_date
from
po_control_groups_all pcga
where
pcga.control_group_id not in (select pcr.control_group_id from po_control_rules pcr) and
pcga.control_group_id not in (select ppca.control_group_id from po_position_controls_all ppca where ppca.control_group_id is not null)
) x,
hr_all_organization_units_vl haouv
where
x.org_id=haouv.organization_id and
x.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
1=1
