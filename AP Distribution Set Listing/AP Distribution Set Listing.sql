/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Distribution Set Listing
-- Description: Payables distribution sets and their lines with account, percentage, income tax type, tax classification and project details, one row per distribution set line.
-- Equivalent to the Oracle standard Distribution Set Listing (APXGDGDL). The Status parameter evaluates active or inactive as of the Effective Date.
-- Excel Example Output: https://www.enginatics.com/example/ap-distribution-set-listing/
-- Library Link: https://www.enginatics.com/reports/ap-distribution-set-listing/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
adsa.distribution_set_name distribution_set,
adsa.description,
adsa.inactive_date,
adsla.distribution_set_line_number line_number,
adsla.description line_description,
gcck.concatenated_segments account,
xxen_util.segments_description(gcck.code_combination_id) account_description,
adsla.percent_distribution,
adsla.type_1099 income_tax_type,
adsla.vat_code tax_classification,
ppa.segment1 project,
pt.task_number task,
adsla.expenditure_type,
haouv_exp.name expenditure_organization,
xxen_util.user_name(adsa.created_by) created_by,
xxen_util.client_time(adsa.creation_date) creation_date,
xxen_util.user_name(adsa.last_updated_by) last_updated_by,
xxen_util.client_time(adsa.last_update_date) last_update_date,
xxen_util.user_name(adsla.last_updated_by) line_last_updated_by,
xxen_util.client_time(adsla.last_update_date) line_last_update_date
from
ap_distribution_sets_all adsa,
ap_distribution_set_lines_all adsla,
hr_all_organization_units_vl haouv,
gl_code_combinations_kfv gcck,
pa_projects_all ppa,
pa_tasks pt,
hr_all_organization_units_vl haouv_exp
where
1=1 and
adsa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
adsa.distribution_set_id=adsla.distribution_set_id and
adsa.org_id=haouv.organization_id and
adsla.dist_code_combination_id=gcck.code_combination_id(+) and
adsla.project_id=ppa.project_id(+) and
adsla.task_id=pt.task_id(+) and
adsla.expenditure_organization_id=haouv_exp.organization_id(+)
order by
haouv.name,
adsa.distribution_set_name,
adsla.distribution_set_line_number
