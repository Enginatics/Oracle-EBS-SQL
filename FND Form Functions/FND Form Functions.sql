/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Form Functions
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-form-functions/
-- Library Link: https://www.enginatics.com/reports/fnd-form-functions/
-- Run Report: https://demo.enginatics.com/

select
fffv.function_name function,
fffv.user_function_name,
nvl(xxen_util.meaning(fffv.type,'FORM_FUNCTION_TYPE',0),fffv.type) type,
fav.application_name form_application,
ffv.form_name,
ffv.user_form_name,
fffv.parameters,
fffv.web_html_call html_call,
xxen_util.user_name(fffv.created_by) created_by,
xxen_util.client_time(fffv.creation_date) creation_date,
xxen_util.user_name(fffv.last_updated_by) last_updated_by,
xxen_util.client_time(fffv.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_form_functions_vl fffv,
fnd_form_vl ffv
where
1=1 and
fffv.application_id=ffv.application_id(+) and
fffv.form_id=ffv.form_id(+) and
ffv.application_id=fav.application_id(+)
order by
ffv.form_name,
fffv.function_name