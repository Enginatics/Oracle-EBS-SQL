/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Lookup Values
-- Description: Lookup types and values, for example to find a lookup type for a particular lookup code value or meaning.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-lookup-values/
-- Library Link: https://www.enginatics.com/reports/fnd-lookup-values/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name view_application,
flv.lookup_type,
fltv.description type_description,
flv.lookup_code code,
flv.language,
flv.meaning,
flv.description,
flv.tag,
xxen_util.meaning(flv.enabled_flag,'YES_NO',0) enabled_flag,
flv.start_date_active,
flv.end_date_active,
xxen_util.user_name(flv.created_by) created_by,
xxen_util.client_time(flv.creation_date) creation_date,
'xxen_util.meaning(x.'||lower(flv.lookup_type)||','''||flv.lookup_type||''','||flv.view_application_id||') '||lower(flv.lookup_type)||',' sql_text,
'select
flv.lookup_code,
flv.meaning,
flv.description
from
fnd_lookup_values flv
where
flv.lookup_type(+)='''||flv.lookup_type||''' and
flv.view_application_id(+)='||flv.view_application_id||' and
flv.language(+)=userenv(''lang'') and
flv.security_group_id(+)=0
order by
flv.lookup_code' lookup_values
from
fnd_application_vl fav0,
fnd_application_vl fav,
fnd_lookup_types_vl fltv,
fnd_lookup_values flv,
fnd_languages fl
where
1=1 and
fav0.application_id=fltv.application_id and
fav.application_id=flv.view_application_id and
fltv.lookup_type=flv.lookup_type and
fltv.view_application_id=flv.view_application_id and
flv.security_group_id=0 and
flv.language=fl.language_code
order by
flv.lookup_type,
flv.lookup_code,
fl.installed_flag,
flv.language