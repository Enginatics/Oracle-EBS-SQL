/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Request Groups
-- Description: FND request groups and their assigned units, such as concurrent programs, request sets or applications
-- Excel Examle Output: https://www.enginatics.com/example/fnd-request-groups/
-- Library Link: https://www.enginatics.com/reports/fnd-request-groups/
-- Run Report: https://demo.enginatics.com/

select
frg.request_group_name request_group,
fav.application_name application,
frg.request_group_code,
frg.description,
decode(frgu.request_unit_type,'P','Program','A','Application','S','Set',frgu.request_unit_type) assignment_type,
decode(frgu.request_unit_type,
'P',fcpv.user_concurrent_program_name,
'A',fav2.application_name,
'S',frsv.user_request_set_name
) assignment_name,
fav2.application_name assignment_application,
xxen_util.user_name(frg.created_by) group_created_by,
xxen_util.client_time(frg.creation_date) group_creation_date,
xxen_util.user_name(frg.last_updated_by) group_last_updated_by,
xxen_util.client_time(frg.last_update_date) group_last_update_date,
xxen_util.user_name(frgu.created_by) assignment_created_by,
xxen_util.client_time(frgu.creation_date) assignment_creation_date,
xxen_util.user_name(frgu.last_updated_by) assignment_last_updated_by,
xxen_util.client_time(frgu.last_update_date) assignment_last_update_date,
frg.application_id,
frg.request_group_id
from
fnd_request_groups frg,
fnd_application_vl fav,
fnd_request_group_units frgu,
fnd_concurrent_programs_vl fcpv,
fnd_application_vl fav2,
fnd_request_sets_vl frsv
where
1=1 and
frg.application_id=fav.application_id and
frg.application_id=frgu.application_id and
frg.request_group_id=frgu.request_group_id and
frgu.unit_application_id=fav2.application_id and
decode(frgu.request_unit_type,'P',frgu.unit_application_id)=fcpv.application_id(+) and
decode(frgu.request_unit_type,'P',frgu.request_unit_id)=fcpv.concurrent_program_id(+) and
decode(frgu.request_unit_type,'S',frgu.unit_application_id)=frsv.application_id(+) and
decode(frgu.request_unit_type,'S',frgu.request_unit_id)=frsv.request_set_id(+)
order by
frg.request_group_name,
fav.application_name,
frgu.request_unit_type,
assignment_name