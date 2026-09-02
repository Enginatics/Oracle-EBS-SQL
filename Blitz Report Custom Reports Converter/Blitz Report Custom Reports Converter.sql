/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Custom Reports Converter
-- Description: Lists Oracle EBS concurrent programs that are candidates for conversion to Blitz Report - RDF reports, BI Publisher reports, and other data-extract concurrent programs - with usage statistics. Select the programs to convert with the Convert Program column, then upload the file. The upload submits a host concurrent program that gathers each selected program's source artifacts (.rdf, .ldt, data definition, template, related packages and custom dependencies) into a single zip file for analysis by Enginatics.

With Include Custom Views set to Yes, the list additionally shows custom database views whose name starts with the Custom Object Prefix. Selecting a view gathers its definition and its custom dependency closure into the same zip - use this to extract the views that Discoverer-migrated or other custom reports are based on.

On instances running NoetixViews, the NOETIX_SYS query views are listed as program type Noetix View. Selecting one gathers the complete view definition closure - the view, its NOETIX_SYS helper views and packages, and the security wrapper views - into a noetix subfolder of the zip, as input for migrating Noetix based reporting to Blitz Report. Excel4apps Reports Wand programs show as program type Excel4apps and gather their report SQL.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-custom-reports-converter/
-- Library Link: https://www.enginatics.com/reports/blitz-report-custom-reports-converter/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
cast(null as varchar2(240)) gather_status,
null modified_columns_,
cast(null as varchar2(10)) convert_program,
x.application,
x.program,
x.short_name,
x.program_type,
x.executable,
x.method,
x.execution_file_name,
x.output_format,
x.run_count,
x.distinct_users,
x.last_run_date,
x.first_run_date,
x.created_by,
x.creation_date,
x.concurrent_program_id,
x.application_id,
upper(:customer_abbreviation) customer_abbreviation,
upper(:custom_prefix) custom_prefix,
cast(null as number) request_id_,
rownum upload_row
from
(
select
fav.application_name application,
fcpv.user_concurrent_program_name program,
fcpv.concurrent_program_name short_name,
case
when fev.executable_name like 'XXE4A%' then 'Excel4apps'
when exists (select null from xdo_ds_definitions_b xddb where xddb.data_source_code=fcpv.concurrent_program_name and xddb.application_short_name=fav.application_short_name) then 'BI Publisher'
when fev.execution_method_code='P' then 'RDF'
else 'Data Extract'
end program_type,
fev.executable_name executable,
xxen_util.meaning(fev.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) method,
fev.execution_file_name,
xxen_util.meaning(fcpv.output_file_type,'CP_OUTPUT_FILE_TYPE',0) output_format,
nvl(stats.run_count,0) run_count,
nvl(stats.distinct_users,0) distinct_users,
xxen_util.client_time(stats.last_run_date) last_run_date,
xxen_util.client_time(stats.first_run_date) first_run_date,
xxen_util.user_name(fcpv.created_by) created_by,
xxen_util.client_time(fcpv.creation_date) creation_date,
fcpv.concurrent_program_id,
fcpv.application_id
from
fnd_application_vl fav,
fnd_concurrent_programs_vl fcpv,
fnd_executables_vl fev,
(
select
fcr.concurrent_program_id,
fcr.program_application_id,
count(*) run_count,
count(distinct fcr.requested_by) distinct_users,
max(fcr.actual_start_date) last_run_date,
min(fcr.actual_start_date) first_run_date
from
fnd_concurrent_requests fcr
group by
fcr.concurrent_program_id,
fcr.program_application_id
) stats
where
3=3 and
fav.application_id=fcpv.application_id and
fcpv.executable_application_id=fev.application_id and
fcpv.executable_id=fev.executable_id and
fcpv.concurrent_program_id=stats.concurrent_program_id(+) and
fcpv.application_id=stats.program_application_id(+) and
nvl(fcpv.enabled_flag,'Y')='Y'
union all
select
dv.owner application,
dv.view_name program,
dv.view_name short_name,
'Custom View' program_type,
null executable,
'View' method,
null execution_file_name,
null output_format,
to_number(null) run_count,
to_number(null) distinct_users,
to_date(null) last_run_date,
to_date(null) first_run_date,
null created_by,
xxen_util.client_time(do.created) creation_date,
to_number(null) concurrent_program_id,
to_number(null) application_id
from
dba_views dv,
dba_objects do
where
2=2 and
:include_custom_views='Y' and
dv.owner=do.owner and
dv.view_name=do.object_name and
do.object_type='VIEW'
union all
select
'Noetix' application,
dv.view_name program,
dv.view_name short_name,
'Noetix View' program_type,
null executable,
'View' method,
null execution_file_name,
null output_format,
to_number(null) run_count,
to_number(null) distinct_users,
to_date(null) last_run_date,
to_date(null) first_run_date,
null created_by,
xxen_util.client_time(do.created) creation_date,
to_number(null) concurrent_program_id,
to_number(null) application_id
from
dba_views dv,
dba_objects do
where
dv.owner='NOETIX_SYS' and
dv.view_name not like 'XXK%' and
dv.view_name not like '%#' and
dv.view_name not like '%\_BASE' escape '\' and
dv.view_name not like 'N\_%' escape '\' and
dv.owner=do.owner and
dv.view_name=do.object_name and
do.object_type='VIEW'
) x
where
1=1