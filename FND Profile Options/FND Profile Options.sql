/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Profile Options
-- Description: FND profile option definition
-- Excel Examle Output: https://www.enginatics.com/example/fnd-profile-options/
-- Library Link: https://www.enginatics.com/reports/fnd-profile-options/
-- Run Report: https://demo.enginatics.com/

select
fpov.profile_option_name profile_name,
fav.application_name application,
fpov.user_profile_option_name user_profile_name,
fpov.description,
xxen_util.meaning(fpov.hierarchy_type,'PROFILE_OPTION_HIERARCHIES',0) hierarchy_type,
xxen_util.meaning(fpov.user_visible_flag,'YES_NO',0) user_access_visible,
xxen_util.meaning(fpov.user_changeable_flag,'YES_NO',0)  user_access_updatable,
xxen_util.meaning(fpov.site_enabled_flag,'YES_NO',0) site_visible,
xxen_util.meaning(fpov.site_update_allowed_flag,'YES_NO',0) site_updatable,
xxen_util.meaning(fpov.app_enabled_flag,'YES_NO',0) application_visible,
xxen_util.meaning(fpov.app_update_allowed_flag,'YES_NO',0) application_updatable,
xxen_util.meaning(fpov.resp_enabled_flag,'YES_NO',0) responsibility_visible,
xxen_util.meaning(fpov.resp_update_allowed_flag,'YES_NO',0) responsibility_updatable,
xxen_util.meaning(fpov.server_enabled_flag,'YES_NO',0) server_visible,
xxen_util.meaning(fpov.server_update_allowed_flag,'YES_NO',0) server_updatable,
xxen_util.meaning(fpov.serverresp_enabled_flag,'YES_NO',0) serverresp_visible,
xxen_util.meaning(fpov.serverresp_update_allowed_flag,'YES_NO',0) serverresp_updatable,
xxen_util.meaning(fpov.org_enabled_flag,'YES_NO',0) organization_visible,
xxen_util.meaning(fpov.org_update_allowed_flag,'YES_NO',0) organization_updatable,
xxen_util.meaning(fpov.user_enabled_flag,'YES_NO',0) user_visible,
xxen_util.meaning(fpov.user_update_allowed_flag,'YES_NO',0) user_updatable,
fpov.sql_validation,
fpov.start_date_active,
fpov.end_date_active,
xxen_util.user_name(fpov.created_by) created_by,
xxen_util.client_time(fpov.creation_date) creation_date,
xxen_util.user_name(fpov.last_updated_by) last_updated_by,
xxen_util.client_time(fpov.last_update_date) last_update_date
from
fnd_profile_options_vl fpov,
fnd_application_vl fav
where
1=1 and
fpov.application_id=fav.application_id
order by
fpov.profile_option_name