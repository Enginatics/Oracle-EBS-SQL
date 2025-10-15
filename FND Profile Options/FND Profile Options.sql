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
xxen_util.yes(fpov.user_visible_flag) user_access_visible,
xxen_util.yes(fpov.user_changeable_flag)  user_access_updatable,
xxen_util.yes(fpov.site_enabled_flag) site_visible,
xxen_util.yes(fpov.site_update_allowed_flag) site_updatable,
xxen_util.yes(fpov.app_enabled_flag) application_visible,
xxen_util.yes(fpov.app_update_allowed_flag) application_updatable,
xxen_util.yes(fpov.resp_enabled_flag) responsibility_visible,
xxen_util.yes(fpov.resp_update_allowed_flag) responsibility_updatable,
xxen_util.yes(fpov.server_enabled_flag) server_visible,
xxen_util.yes(fpov.server_update_allowed_flag) server_updatable,
xxen_util.yes(fpov.serverresp_enabled_flag) serverresp_visible,
xxen_util.yes(fpov.serverresp_update_allowed_flag) serverresp_updatable,
xxen_util.yes(fpov.org_enabled_flag) organization_visible,
xxen_util.yes(fpov.org_update_allowed_flag) organization_updatable,
xxen_util.yes(fpov.user_enabled_flag) user_visible,
xxen_util.yes(fpov.user_update_allowed_flag) user_updatable,
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