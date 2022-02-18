/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND FNDLOAD Object Transfer
-- Description: Generates FNDLOAD download and upload linux commands for automated setup transfer between environments
-- Excel Examle Output: https://www.enginatics.com/example/fnd-fndload-object-transfer/
-- Library Link: https://www.enginatics.com/reports/fnd-fndload-object-transfer/
-- Run Report: https://demo.enginatics.com/

select
'Concurrent Program' object_type,
fcpv.concurrent_program_name object_name,
'FNDLOAD apps/&apps_password_download 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct '||:output_file_location||'conc_'||fcpv.concurrent_program_name||'.ldt PROGRAM CONCURRENT_PROGRAM_NAME='||fcpv.concurrent_program_name download,
'FNDLOAD apps/&apps_password_upload 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct conc_'||fcpv.concurrent_program_name||'.ldt' upload
from
fnd_concurrent_programs_vl fcpv
where
1=1 and
:object_type='Concurrent Program'
union all
select
'Function' object_type,
fff.function_name,
'FNDLOAD apps/&apps_password_download 0 Y DOWNLOAD $FND_TOP/patch/115/import/afsload.lct '||:output_file_location||'func_'||fff.function_name||'.ldt FUNCTION FUNCTION_NAME='||fff.function_name download,
'FNDLOAD apps/&apps_password_upload 0 Y UPLOAD $FND_TOP/patch/115/import/afsload.lct func_'||fff.function_name||'.ldt' upload
from
fnd_form_functions fff
where
2=2 and
:object_type='Function'
union all
select
'Lookup' object_type,
flt.lookup_type,
'FNDLOAD apps/&apps_password_download 0 Y DOWNLOAD $FND_TOP/patch/115/import/aflvmlu.lct '||:output_file_location||'look_'||flt.lookup_type||'.ldt FND_LOOKUP_TYPE APPLICATION_SHORT_NAME='||fa.application_short_name||' LOOKUP_TYPE='||flt.lookup_type download,
'FNDLOAD apps/&apps_password_upload 0 Y UPLOAD $FND_TOP/patch/115/import/aflvmlu.lct look_'||flt.lookup_type||'.ldt' upload
from
fnd_lookup_types flt,
fnd_application fa
where
3=3 and
:object_type='Lookup' and
flt.application_id=fa.application_id
union all
select
'Profile Option' object_type,
fpo.profile_option_name object_name,
'FNDLOAD apps/&apps_password_download O Y DOWNLOAD $FND_TOP/patch/115/import/afscprof.lct '||:output_file_location||'prof_'||fpo.profile_option_name||'.ldt PROFILE PROFILE_NAME='||fpo.profile_option_name||' PROFILE_VALUES=N' download,
'FNDLOAD apps/&apps_password_upload 0 Y UPLOAD $FND_TOP/patch/115/import/afscprof.lct prof_'||fpo.profile_option_name||'.ldt' upload
from
fnd_profile_options fpo
where
5=5 and
:object_type='Profile Option'