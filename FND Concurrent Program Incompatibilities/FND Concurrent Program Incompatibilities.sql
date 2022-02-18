/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Program Incompatibilities
-- Description: Concurrent Program Incompatibilities
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-program-incompatibilities/
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-program-incompatibilities/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
fcpv.user_concurrent_program_name program,
fcpv.concurrent_program_name short_name,
fav2.application_name incompatible_application_name,
fcpv2.user_concurrent_program_name incompatible_program,
fcpv2.concurrent_program_name incompatible_short_name,
decode(fcps.to_run_type,'P', 'Program', 'S', 'Set') scope,
decode(fcps.incompatibility_type,'G','Global','D','Domain') type,
xxen_util.user_name(fcps.created_by) created_by,
xxen_util.client_time(fcps.creation_date) creation_date,
xxen_util.user_name(fcps.last_updated_by) last_updated_by,
xxen_util.client_time(fcps.last_update_date) last_update_date
from
fnd_concurrent_program_serial fcps,
fnd_concurrent_programs_vl fcpv,
fnd_concurrent_programs_vl fcpv2,
fnd_application_vl fav,
fnd_application_vl fav2
where
1=1 and
fcps.running_application_id=fcpv.application_id and
fcps.running_concurrent_program_id=fcpv.concurrent_program_id and
fcps.to_run_application_id=fcpv2.application_id and
fcps.to_run_concurrent_program_id=fcpv2.concurrent_program_id and
fcps.running_application_id=fav.application_id and
fcps.to_run_application_id=fav2.application_id
order by
fav.application_name,
fcpv.user_concurrent_program_name,
fcpv.concurrent_program_name,
fav2.application_name,
fcpv2.user_concurrent_program_name