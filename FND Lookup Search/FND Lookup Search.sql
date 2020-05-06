/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Lookup Search
-- Description: Finds the best matching lookup_type for a given set of lookup_codes in a custom application base table.

Example:
Coding a sql for ap suppliers, the value of column vendor_type_lookup_code should get translated to the user visible meaning instead of the code.
The lookup_type used for translation can be found by this report entering table name AP_SUPPLIERS and column name VENDOR_TYPE_LOOKUP_CODE.
The output contains a column SQL_TEXT which can be used directly in the sql where clause:

=flv.lookup_code(+) and
flv.lookup_type(+)='VENDOR TYPE' and
flv.view_application_id(+)=201 and
flv.language(+)=userenv('lang') and
flv.security_group_id(+)=0 and
-- Excel Examle Output: https://www.enginatics.com/example/fnd-lookup-search/
-- Library Link: https://www.enginatics.com/reports/fnd-lookup-search/
-- Run Report: https://demo.enginatics.com/

select
u.value_count,
u.match_count,
u.count,
u.column_value,
u.meaning,
u.application_name,
u.lookup_type,
'xxen_util.meaning('||lower(replace(regexp_replace(:table_name, '([^_]{1})[^_]*','\1'),'_')||'.'||:column_name)||','''||u.lookup_type||''','||u.view_application_id||') '||lower(:column_name)||',' column_sql_text,
lower(replace(regexp_replace(:table_name, '([^_]{1})[^_]*','\1'),'_')||'.'||:column_name)||'=xxen_util.lookup_code(:'||lower(:column_name)||','''||u.lookup_type||''','||u.view_application_id||')' where_sql_text,
'=flv.lookup_code(+) and
flv.lookup_type(+)='''||u.lookup_type||''' and
flv.view_application_id(+)='||u.view_application_id||' and
flv.language(+)=userenv(''lang'') and
flv.security_group_id(+)=0 and' sql_text2,
'select
flv.lookup_code,
flv.meaning,
flv.description
from
fnd_lookup_values flv
where
flv.lookup_type='''||u.lookup_type||''' and
flv.view_application_id='||u.view_application_id||' and
flv.language=userenv(''lang'') and
flv.security_group_id=0
order by
flv.lookup_code' lookup_values,
u.view_application_id,
u.table_application_id
from
(
select
max(z.match_count) over () max_match_count,
decode(z.view_application_id,z.table_application_id,1,2) priority,
z.*
from
(
select
count(distinct y.column_value) over (partition by flv.lookup_type, flv.view_application_id) value_count,
count(*) over (partition by flv.lookup_type, flv.view_application_id) match_count,
y.count,
y.column_value,
flv.meaning,
flv.lookup_type,
flv.view_application_id,
(select distinct
min(fpi.application_id) keep (dense_rank first order by case when :table_name like fa.application_short_name||'\_%' escape '\' then 1 else 2 end,fpi.application_id) over () app_id
from
dba_tables dt,
fnd_oracle_userid fou,
fnd_product_installations fpi,
fnd_application fa
where
dt.table_name=:table_name and
dt.owner=fou.oracle_username and
fou.oracle_id=fpi.oracle_id and
fpi.application_id=fa.application_id) table_application_id,
fav.application_name
from
(
select distinct
count(*) over (partition by x.column_value) count,
x.column_value
from
(
select
xo.&column_name column_value
from
&table_name xo
) x
where
x.column_value is not null
) y,
fnd_lookup_values flv,
fnd_application_vl fav
where
flv.language='US' and
flv.security_group_id=0 and
to_char(y.column_value)=flv.lookup_code and
flv.view_application_id=fav.application_id
) z
) u
where
u.match_count=u.max_match_count
order by
u.match_count desc,
u.priority,
u.application_name,
u.lookup_type,
u.view_application_id,
u.count desc