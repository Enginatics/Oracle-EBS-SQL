/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Menus
-- Description: Lists all Oracle E-Business Suite menus (FND_MENUS) together with the number of responsibilities that reference each menu.

The Responsibility Count column shows the total number of responsibilities pointing at the menu; Active Responsibility Count excludes end-dated responsibilities.

Use the Assigned To Responsibility parameter to find the menu behind a specific responsibility, or Menus With Responsibilities Only to hide unused menus. Results are ordered by responsibility count so the most widely used menus appear first.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-menus/
-- Library Link: https://www.enginatics.com/reports/fnd-menus/
-- Run Report: https://demo.enginatics.com/

select
fmv.user_menu_name,
fmv.menu_name,
xxen_util.meaning(fmv.type,'MENU_TYPE',0) menu_type,
fmv.description,
xxen_util.zero_to_null(x.responsibility_count) responsibility_count,
xxen_util.zero_to_null(x.active_responsibility_count) active_responsibility_count,
xxen_util.user_name(fmv.created_by) created_by,
xxen_util.client_time(fmv.creation_date) creation_date,
xxen_util.user_name(fmv.last_updated_by) last_updated_by,
xxen_util.client_time(fmv.last_update_date) last_update_date
from
fnd_menus_vl fmv,
(
select
fr.menu_id,
count(*) responsibility_count,
count(case when nvl(fr.end_date,sysdate)>=sysdate then 1 end) active_responsibility_count
from
fnd_responsibility fr
group by
fr.menu_id
) x
where
1=1 and
fmv.menu_id=x.menu_id(+)
order by
nvl(x.responsibility_count,0) desc,
fmv.user_menu_name