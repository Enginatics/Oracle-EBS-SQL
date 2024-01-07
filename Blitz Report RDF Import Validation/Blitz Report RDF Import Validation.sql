/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report RDF Import Validation
-- Description: Validates the import of RDF concurrent programs
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-rdf-import-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-rdf-import-validation/
-- Run Report: https://demo.enginatics.com/

select
fcpv.user_concurrent_program_name,
fcpv.concurrent_program_name,
fav.application_name,
fav.application_short_name,
fav.basepath application_top,
fe.execution_file_name,
fcpv2.concurrent_program_name bip_concurrent_program,
fcpv2.user_concurrent_program_name bip_concurrent_program_name,
xxen_util.user_name(fcpv2.created_by) bip_created_by,
xxen_util.client_time(fcpv2.creation_date) bip_creation_date,
uo.object_name db_package_name,
uo.status,
uo.created,
uo.last_ddl_time,
xrv.report_name,
xrv.category,
xxen_util.user_name(xrv.created_by) xrv_created_by,
xxen_util.client_time(xrv.creation_date) xrv_creation_date,
fcpv.application_id,
fcpv.concurrent_program_id
from
fnd_concurrent_programs_vl fcpv,
fnd_concurrent_programs_vl fcpv2,
fnd_application_vl fav,
fnd_executables fe,
(
select
regexp_substr(xrv.description,chr(10)||'Short Name: (.+)',1,1,null,1) short_name,
regexp_substr(xrv.description,chr(10)||'DB package: (.+)',1,1,null,1) bip_package,
xrv.*
from
xxen_reports_v xrv
where
xrv.description like 'Imported from BI Publisher%'
) xrv,
user_objects uo
where
1=1 and
fcpv.execution_method_code='P' and
fcpv.executable_application_id=fav.application_id and
fcpv.executable_id=fe.executable_id and
fcpv.executable_application_id=fe.application_id and
fcpv.concurrent_program_name||'_XML'=fcpv2.concurrent_program_name(+) and
fcpv.concurrent_program_name||'_XML'=xrv.short_name(+) and
fcpv.concurrent_program_name=uo.object_name(+) and
uo.object_type(+)='PACKAGE'
order by
fcpv2.creation_date desc,
fav.application_short_name