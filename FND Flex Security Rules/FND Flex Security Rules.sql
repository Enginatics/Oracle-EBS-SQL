/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Security Rules
-- Description: Flexfield value security rules, rule elements (included or excluded flexfield value ranges), flexfields where the secured value set is used and responsibilities that the rule is assigned to.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-security-rules
-- Library Link: https://www.enginatics.com/reports/fnd-flex-security-rules
-- Run Report: https://demo.enginatics.com/


select
ffvrv.flex_value_rule_name rule_name,
ffvrv.description,
ffvrv.error_message,
&responsibility_column
ffvs.flex_value_set_name value_set_name,
&flexfield_columns
xxen_util.user_name(ffvrv.created_by) rule_created_by,
xxen_util.client_time(ffvrv.creation_date) rule_creation_date,
xxen_util.user_name(ffvrv.last_updated_by) rule_last_updated_by,
xxen_util.client_time(ffvrv.last_update_date) rule_last_update_date
from
fnd_flex_value_sets ffvs,
fnd_flex_value_rules_vl ffvrv,
(select ffvrl.* from fnd_flex_value_rule_lines ffvrl where '&show_rule_elements'='Y') ffvrl,
(select ffvru.* from fnd_flex_value_rule_usages ffvru where '&show_responsibilities'='Y') ffvru,
fnd_responsibility_vl frv,
(select fifsgv.* from fnd_id_flex_segments_vl fifsgv where '&show_flexfields'='Y') fifsgv,
fnd_id_flex_structures_vl fifsv,
fnd_id_flexs fif,
fnd_application_vl fav
where
1=1 and
ffvs.flex_value_set_id=ffvrv.flex_value_set_id and
ffvrv.flex_value_rule_id=ffvrl.flex_value_rule_id(+) and
ffvrv.flex_value_rule_id=ffvru.flex_value_rule_id(+) and
ffvru.responsibility_id=frv.responsibility_id(+) and
ffvru.application_id=frv.application_id(+) and
ffvs.flex_value_set_id=fifsgv.flex_value_set_id(+) and
fifsgv.id_flex_code=fifsv.id_flex_code(+) and
fifsgv.id_flex_num=fifsv.id_flex_num(+) and
fifsgv.application_id=fifsv.application_id(+) and
fifsv.application_id=fif.application_id(+) and
fifsv.id_flex_code=fif.id_flex_code(+) and
fif.application_id=fav.application_id(+)
order by
ffvrv.flex_value_rule_name,
frv.responsibility_name,
fav.application_name,
fif.id_flex_name,
fifsv.id_flex_structure_name,
fifsgv.segment_num,
ffvrl.include_exclude_indicator desc,
ffvrl.flex_value_low