/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Programs and Executables
-- Description: Concurrent programs, executables and program parameters
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-programs-and-executables/
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-programs-and-executables/
-- Run Report: https://demo.enginatics.com/

select
fcpv.user_concurrent_program_name program,
fcpv.description,
fav.application_name,
fav.application_short_name,
fcpv.concurrent_program_name short_name,
xxen_util.meaning(fcpv.enabled_flag,'YES_NO',0) enabled_flag,
fev.executable_name executable_short_name,
xxen_util.meaning(fev.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) method,
fev.execution_file_name,
fcpv.execution_options options,
xxen_util.meaning(fcpv.output_file_type,'CP_OUTPUT_FILE_TYPE',0) output_format,
fcrc.request_class_name type,
fcpv.increment_proc incrementor,
xxen_util.meaning(fcpv.multi_org_category,'CONC_PROGRAM_CATEGORY',0) operating_unit_mode,
case when fcpoi.business_event_map like '%Y%' then fcpoi.business_event_map end business_events,
fcpoi.node_name1 target_node1,
fcpoi.node_name2 target_node2,
fcpoi.connstr1 two_task1,
fcpoi.connstr2 two_task2,
&column_parameters
case when fev.description is null and fev.user_executable_name<>fev.executable_name then fev.user_executable_name else fev.description end executable_description,
xxen_util.user_name(fcpv.created_by) created_by,
xxen_util.client_time(fcpv.creation_date) creation_date,
xxen_util.user_name(fcpv.last_updated_by) last_updated_by,
xxen_util.client_time(fcpv.last_update_date) last_update_date,
fcpv.concurrent_program_id
from
fnd_application_vl fav,
fnd_concurrent_programs_vl fcpv,
fnd_executables_vl fev,
(select fdfcuv.* from fnd_descr_flex_col_usage_vl fdfcuv where '&enable_parameters'='Y') fdfcuv,
fnd_flex_value_sets ffvs,
fnd_concurrent_request_class fcrc,
fnd_conc_prog_onsite_info fcpoi
where
1=1 and
fav.application_id=fcpv.application_id and
fcpv.executable_application_id=fev.application_id and
fcpv.executable_id=fev.executable_id and
fcpv.application_id=fdfcuv.application_id(+) and
'$SRS$.'||fcpv.concurrent_program_name=fdfcuv.descriptive_flexfield_name(+) and
fdfcuv.descriptive_flex_context_code(+)='Global Data Elements' and
fdfcuv.flex_value_set_id=ffvs.flex_value_set_id(+) and
fcpv.class_application_id=fcrc.application_id(+) and
fcpv.concurrent_class_id=fcrc.request_class_id(+) and
fcpv.concurrent_program_id=fcpoi.concurrent_program_id(+) and
fcpv.application_id=fcpoi.program_application_id(+)
order by
fav.application_name,
fcpv.user_concurrent_program_name,
fdfcuv.column_seq_num