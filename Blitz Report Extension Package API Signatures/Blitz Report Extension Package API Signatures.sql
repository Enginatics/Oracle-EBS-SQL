/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Extension Package API Signatures
-- Description: Shows this instance's signatures of the Oracle EBS APIs that Blitz Report's extension packages call: every argument of every procedure, with its position, data type, in/out mode, whether it is defaulted, and the fields of any record argument.

Its purpose is comparison. An extension package that calls an EBS API by named parameters fails to compile where a patch level does not have that parameter (PLS-00306) or that record field (PLS-00302), the installer then drops the package, and its reports and uploads fail with PLS-00201 at runtime. Running this report here and on a working instance and comparing the two shows exactly which argument or field is absent.

Left empty, it reports every EBS API called by the extension packages installed here, and Referenced By names the calling package. That list is derived from the installed package source, so an extension package that failed to compile is not in it - name its API in the API Package Name parameter instead, which reports that package's full signature whether or not anything here calls it.

Types and constants declared in a package specification are not arguments and so do not appear here. Use the DBA Text Search report on the specification for those.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-extension-package-api-signatures/
-- Library Link: https://www.enginatics.com/reports/blitz-report-extension-package-api-signatures/
-- Run Report: https://demo.enginatics.com/

select
y.package_name,
y.procedure_name,
y.overload,
y.data_level,
y.position,
y.argument_name,
y.data_type,
y.type_name,
y.in_out,
y.defaulted,
y.referenced_by
from
(
select
ua.package_name,
ua.object_name procedure_name,
ua.overload,
ua.data_level,
ua.position,
ua.argument_name,
ua.data_type,
ua.type_owner||decode(ua.type_name,null,null,'.'||ua.type_name)||decode(ua.type_subname,null,null,'.'||ua.type_subname) type_name,
ua.in_out,
ua.defaulted,
x.referenced_by,
ua.sequence
from
(
select /*+ no_merge */
s.package_name,
s.object_name,
listagg(s.referencing_package,', ') within group (order by s.referencing_package) referenced_by
from
(
select distinct
upper(regexp_substr(us.text,'([a-z0-9_]+)\.([a-z0-9_]+)[[:space:]]*(\(|$)',1,rowgen.column_value,'i',1)) package_name,
upper(regexp_substr(us.text,'([a-z0-9_]+)\.([a-z0-9_]+)[[:space:]]*(\(|$)',1,rowgen.column_value,'i',2)) object_name,
us.name referencing_package
from
user_source us,
table(xxen_util.rowgen(regexp_count(us.text,'[a-z0-9_]+\.[a-z0-9_]+[[:space:]]*(\(|$)',1,'i'))) rowgen
where
:api_package_name is null and
us.type='PACKAGE BODY' and
us.name like 'XXEN%' and
us.name in (select us2.name from user_source us2 where us2.type='PACKAGE BODY' and us2.line=1 and us2.name like 'XXEN%' and lower(us2.text) not like '%wrapped%') and
regexp_like(us.text,'[a-z0-9_]+\.[a-z0-9_]+[[:space:]]*(\(|$)','i')
) s
where
s.package_name not like 'XXEN%'
group by
s.package_name,
s.object_name
) x,
user_arguments ua
where
x.package_name=ua.package_name and
x.object_name=ua.object_name
union all
select
ua.package_name,
ua.object_name,
ua.overload,
ua.data_level,
ua.position,
ua.argument_name,
ua.data_type,
ua.type_owner||decode(ua.type_name,null,null,'.'||ua.type_name)||decode(ua.type_subname,null,null,'.'||ua.type_subname),
ua.in_out,
ua.defaulted,
to_char(null),
ua.sequence
from
user_arguments ua
where
:api_package_name is not null and
3=3
) y
where
1=1
order by
y.package_name,
y.procedure_name,
nvl(y.overload,'1'),
y.sequence