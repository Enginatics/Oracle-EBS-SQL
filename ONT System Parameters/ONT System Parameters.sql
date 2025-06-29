/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT System Parameters
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/ont-system-parameters/
-- Library Link: https://www.enginatics.com/reports/ont-system-parameters/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ospdv.name parameter_name,
ospdv.description,
xxen_util.yes(ospdv.seeded_flag) seeded,
xxen_util.yes(ospdv.enabled_flag) enabled,
xxen_util.meaning(ospdv.category_code,'OM_PARAMETER_CATEGORY',660) category,
(select ffvs.flex_value_set_name from fnd_flex_value_sets ffvs where ospdv.value_set_id=ffvs.flex_value_set_id) flex_value_set_name,
xxen_util.meaning(ospdv.open_orders_check_flag,'OPEN_ORDERS_ACTION',660) open_orders_check_flag,
ospa.parameter_value,
xxen_util.user_name(ospa.created_by) created_by,
xxen_util.client_time(ospa.creation_date) creation_date,
xxen_util.user_name(ospa.last_updated_by) last_updated_by,
xxen_util.client_time(ospa.last_update_date) last_update_date,
ospdv.parameter_code,
ospdv.category_code
from
oe_sys_parameter_def_vl ospdv,
oe_sys_parameters_all ospa,
hr_all_organization_units_vl haouv
where
1=1 and
ospdv.parameter_code=ospa.parameter_code(+) and
ospa.org_id=haouv.organization_id(+)
order by
haouv.name,
ospdv.name