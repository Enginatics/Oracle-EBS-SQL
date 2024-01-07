/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Menu Entries
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-menu-entries/
-- Library Link: https://www.enginatics.com/reports/fnd-menu-entries/
-- Run Report: https://demo.enginatics.com/

select
fmv.user_menu_name,
fmv.menu_name,
xxen_util.meaning(fmv.type,'MENU_TYPE',0) type,
fmev.entry_sequence sequence,
fmev.prompt,
fmt.user_menu_name sub_menu,
fffv.function_name,
fffv.user_function_name,
nvl(xxen_util.meaning(fffv.type,'FORM_FUNCTION_TYPE',0),fffv.type) function_type,
ffv.form_name,
ffv.user_form_name,
fffv.parameters,
fffv.web_html_call html_call,
xxen_util.user_name(fmev.created_by) created_by,
xxen_util.client_time(fmev.creation_date) creation_date,
xxen_util.user_name(fmev.last_updated_by) last_updated_by,
xxen_util.client_time(fmev.last_update_date) last_update_date
from
fnd_menus_vl fmv,
fnd_menu_entries_vl fmev,
fnd_menus_tl fmt,
fnd_form_functions_vl fffv,
fnd_form_vl ffv
where
1=1 and
fmv.menu_id=fmev.menu_id and
fmev.sub_menu_id=fmt.menu_id(+) and
fmt.language(+)=userenv('lang') and
fmev.function_id=fffv.function_id(+) and
fffv.application_id=ffv.application_id(+) and
fffv.form_id=ffv.form_id(+)
order by
fmv.user_menu_name,
fmev.entry_sequence