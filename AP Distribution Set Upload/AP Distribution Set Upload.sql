/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Distribution Set Upload
-- Description: Creates and updates Payables distribution sets and their lines - the Excel equivalent of the Distribution Sets form (Setup > Invoice > Distribution Sets).
-- Each row is one distribution set line, with the distribution set header columns repeated on every line. The header values are taken from the first row of each distribution set. Leave the line columns blank to create or update a distribution set header only.
-- Each distribution set is processed as a whole: the percentages of all its lines, including existing lines not in the upload file, must add up to 100 (Full) or to 0 (Skeleton), otherwise none of its rows are saved. The same applies when any other line of the set fails validation.
-- Line Number identifies the line within the distribution set. Set Delete Line to Yes to delete a line. A distribution set cannot be deleted, as in the form - enter an Inactive On date instead.
-- For project related lines, enter Project, Task, Expenditure Type and Expenditure Organization. The account is then derived by the Projects account generator, exactly as in the form.
-- Excel Example Output: https://www.enginatics.com/example/ap-distribution-set-upload/
-- Library Link: https://www.enginatics.com/reports/ap-distribution-set-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
adsa.distribution_set_name distribution_set,
(select alc.displayed_field from ap_lookup_codes alc where alc.lookup_type='NLS TRANSLATION' and alc.lookup_code='PERCENT DIST '||adsa.total_percent_distribution) set_type,
adsa.description,
adsa.inactive_date inactive_on,
xxen_util.display_flexfield_context(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category) set_attribute_category,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE1',adsa.rowid,adsa.attribute1) set_attribute1,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE2',adsa.rowid,adsa.attribute2) set_attribute2,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE3',adsa.rowid,adsa.attribute3) set_attribute3,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE4',adsa.rowid,adsa.attribute4) set_attribute4,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE5',adsa.rowid,adsa.attribute5) set_attribute5,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE6',adsa.rowid,adsa.attribute6) set_attribute6,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE7',adsa.rowid,adsa.attribute7) set_attribute7,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE8',adsa.rowid,adsa.attribute8) set_attribute8,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE9',adsa.rowid,adsa.attribute9) set_attribute9,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE10',adsa.rowid,adsa.attribute10) set_attribute10,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE11',adsa.rowid,adsa.attribute11) set_attribute11,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE12',adsa.rowid,adsa.attribute12) set_attribute12,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE13',adsa.rowid,adsa.attribute13) set_attribute13,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE14',adsa.rowid,adsa.attribute14) set_attribute14,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SETS',adsa.attribute_category,'ATTRIBUTE15',adsa.rowid,adsa.attribute15) set_attribute15,
adsla.distribution_set_line_number line_number,
adsla.percent_distribution percentage,
gcck.concatenated_segments account,
xxen_util.segments_description(gcck.code_combination_id) account_description,
adsla.description line_description,
adsla.type_1099 income_tax_type,
ppa.segment1 project,
pt.task_number task,
adsla.expenditure_type,
haouv_exp.name expenditure_organization,
xxen_util.display_flexfield_context(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE1',adsla.rowid,adsla.attribute1) line_attribute1,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE2',adsla.rowid,adsla.attribute2) line_attribute2,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE3',adsla.rowid,adsla.attribute3) line_attribute3,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE4',adsla.rowid,adsla.attribute4) line_attribute4,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE5',adsla.rowid,adsla.attribute5) line_attribute5,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE6',adsla.rowid,adsla.attribute6) line_attribute6,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE7',adsla.rowid,adsla.attribute7) line_attribute7,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE8',adsla.rowid,adsla.attribute8) line_attribute8,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE9',adsla.rowid,adsla.attribute9) line_attribute9,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE10',adsla.rowid,adsla.attribute10) line_attribute10,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE11',adsla.rowid,adsla.attribute11) line_attribute11,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE12',adsla.rowid,adsla.attribute12) line_attribute12,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE13',adsla.rowid,adsla.attribute13) line_attribute13,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE14',adsla.rowid,adsla.attribute14) line_attribute14,
xxen_util.display_flexfield_value(200,'AP_DISTRIBUTION_SET_LINES',adsla.attribute_category,'ATTRIBUTE15',adsla.rowid,adsla.attribute15) line_attribute15,
null delete_line,
adsa.distribution_set_id,
null upload_row
from
ap_distribution_sets_all adsa,
hr_all_organization_units_vl haouv,
ap_distribution_set_lines_all adsla,
gl_code_combinations_kfv gcck,
pa_projects_all ppa,
pa_tasks pt,
hr_all_organization_units_vl haouv_exp
where
1=1 and
adsa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
adsa.org_id=haouv.organization_id and
adsa.distribution_set_id=adsla.distribution_set_id(+) and
adsla.dist_code_combination_id=gcck.code_combination_id(+) and
adsla.project_id=ppa.project_id(+) and
adsla.task_id=pt.task_id(+) and
adsla.expenditure_organization_id=haouv_exp.organization_id(+)
