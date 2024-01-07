/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XDO Publisher Data Definitions
-- Description: XML Publisher data definitions or sources, associated concurrent programs, executables and templates.
To include complete template information, enter a template name or wildcard % in the template name parameter field.

This report also includes the source data SQL statement extracted from the publisher data template XML file which is quite useful to quickly access and review the SQL from Oracle standard XML reports and use them as templates for new blitz report creations.

Parameter 'Data Definition Search Text' performs a full text search through the data template file so that you could for example enter a particular table name to list all XML publisher reports and their SQLs selecting from that table.
-- Excel Examle Output: https://www.enginatics.com/example/xdo-publisher-data-definitions/
-- Library Link: https://www.enginatics.com/reports/xdo-publisher-data-definitions/
-- Run Report: https://demo.enginatics.com/

select
xddv.data_source_name,
xddv.data_source_code,
xddv.application_name application,
case when sysdate between xddv.start_date and nvl(xddv.end_date,sysdate) then 'Yes' else 'No' end active,
(select distinct listagg(xl0.file_name,', ') within group (order by xl0.lob_type) over (partition by xl0.application_short_name, xl0.lob_code) files from xdo_lobs xl0 where xddv.application_short_name=xl0.application_short_name and xddv.data_source_code=xl0.lob_code and xl0.lob_type='XML_SCHEMA') xml_schema,
xl.file_name data_template,
(select distinct listagg(xl0.file_name,', ') within group (order by xl0.lob_type) over (partition by xl0.application_short_name, xl0.lob_code) files from xdo_lobs xl0 where xddv.application_short_name=xl0.application_short_name and xddv.data_source_code=xl0.lob_code and xl0.lob_type='XML_SAMPLE') preview_data,
(select distinct listagg(xl0.file_name,', ') within group (order by xl0.lob_type) over (partition by xl0.application_short_name, xl0.lob_code) files from xdo_lobs xl0 where xddv.application_short_name=xl0.application_short_name and xddv.data_source_code=xl0.lob_code and xl0.lob_type='BURSTING_FILE') bursting_control_file,
fcpv.user_concurrent_program_name,
case when
fcpv.srs_flag in ('Y','Q') and
fcpv.enabled_flag='Y' and
(
exists (select null from fnd_request_group_units frgu where frgu.request_unit_type='P' and fcpv.application_id=frgu.unit_application_id and fcpv.concurrent_program_id=frgu.request_unit_id) or
exists (select null from fnd_request_group_units frgu where frgu.request_unit_type='A' and fcpv.application_id=frgu.unit_application_id and fcpv.application_id=frgu.request_unit_id)
)
then 'Yes' end conc_enabled,
fcpv.output_file_type,
fev.executable_name,
xxen_util.meaning(fev.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) execution_method,
case when fev.description is null and fev.user_executable_name<>fev.executable_name then fev.user_executable_name else fev.description end executable_description,
fev.execution_file_name,
fev.execution_file_path,
&col_template
x.*,
&col_sql
--xl.text data_template_xml
xl.application_short_name,
xxen_util.user_name(xddv.created_by) created_by,
xxen_util.client_time(xddv.creation_date) creation_date,
xxen_util.user_name(xddv.last_updated_by) last_updated_by,
xxen_util.client_time(xddv.last_update_date) last_update_date
from
(select xddv.*, fav.application_name, fav.application_id from xdo_ds_definitions_vl xddv, fnd_application_vl fav where xddv.application_short_name=fav.application_short_name) xddv,
fnd_concurrent_programs_vl fcpv,
fnd_executables_vl fev,
(select xtv.* from xdo_templates_vl xtv where '&show_template'='Y') xtv,
(select
xl.*,
xxen_util.blob_to_clob(xl.file_data) text,
xmltype(xxen_util.blob_to_clob(xl.file_data)) xml
from
xdo_lobs xl
where
xl.lob_type='DATA_TEMPLATE' and
xl.language='00' and
xl.territory='00' and
xl.file_data is not null and
xxen_util.is_xml(xxen_util.blob_to_clob(xl.file_data))='Y'
) xl,
xmltable('/dataTemplate' passing xl.xml columns
data_template_name path '@name',
data_template_description path '@description',
package_name path '@defaultPackage'
)(+) x,
xmltable('/dataTemplate["&enable_sql"="Y"]/dataQuery/*[fn:lower-case(name())="sqlstatement"]' passing xl.xml columns
sql_number for ordinality,
sql_name path '@name',
sql_text clob path 'text()[1]'
)(+) y
where
1=1 and
xddv.application_short_name=xtv.ds_app_short_name(+) and
xddv.data_source_code=xtv.data_source_code(+) and
xtv.template_status(+)='E' and
xddv.data_source_code=fcpv.concurrent_program_name(+) and
xddv.application_id=fcpv.application_id(+) and
fcpv.executable_id=fev.executable_id(+) and
fcpv.executable_application_id=fev.application_id(+) and
xddv.application_short_name=xl.application_short_name(+) and
xddv.data_source_code=xl.lob_code(+)