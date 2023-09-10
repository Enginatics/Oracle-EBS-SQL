/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD Applied Patches
-- Description: AD applied patches, patch runs, included bugs, filenames and actions
-- Excel Examle Output: https://www.enginatics.com/example/ad-applied-patches/
-- Library Link: https://www.enginatics.com/reports/ad-applied-patches/
-- Run Report: https://demo.enginatics.com/

select distinct
xxen_util.client_time(nvl(aprba.creation_date,apr.start_date)) start_date,
xxen_util.client_time(apr.end_date) end_date,
case when apd.patch_abstract is null and apd.driver_file_name in ('uprepare.drv','ufinalize.drv','ucutover.drv','ucleanup.drv','uactualize.drv','uabort.drv') then
decode(apd.driver_file_name,'uprepare.drv','PREPARE','ufinalize.drv','FINALIZE','ucutover.drv','CUTOVER','ucleanup.drv','CLEANUP','uactualize.drv','ACTUALIZE_ALL','uabort.drv','ABORT') else
aap.patch_name
end patch,
(
select distinct
listagg(x.bug_number,', ') within group (order by x.bug_number) over () patch_number
from
(select distinct acp.patch_driver_id, ab.bug_number from ad_comprising_patches acp, ad_bugs ab where acp.bug_id=ab.bug_id) x
where
apd.patch_driver_id=x.patch_driver_id
) included_patches,
coalesce(
apd.patch_abstract,
decode(apd.driver_file_name,'uprepare.drv','adop phase=prepare','ufinalize.drv','adop phase=finalize','ucutover.drv','adop phase=cutover','ucleanup.drv','adop phase=cleanup','uactualize.drv','adop phase=actualize_all','uabort.drv','adop phase=abort'),
decode(apd.merged_driver_flag,'Y','Merged Patch')
) patch_description,
aap.patch_type,
aat.applications_system_name instance_name,
aat.name appl_top_name,
apd.driver_file_name,
apr.patch_top,
&col_bug
&col_action
xxen_util.meaning(aprba.executed_flag,'YES_NO',0) bug_action_executed,
xxen_util.meaning(apr.success_flag,'YES_NO',0) run_success,
xxen_util.meaning(aprb.applied_flag,'YES_NO',0) bug_applied,
xxen_util.meaning(aprb.success_flag,'YES_NO',0) bug_success
from
ad_appl_tops aat,
ad_applied_patches aap,
ad_patch_drivers apd,
ad_patch_runs apr,
(select aprb.* from ad_patch_run_bugs aprb where '&show_bug'='Y') aprb,
ad_bugs ab,
(select aprba.* from ad_patch_run_bug_actions aprba where '&show_action'='Y') aprba,
ad_patch_common_actions apca,
ad_files af,
ad_file_versions afv1,
ad_file_versions afv2,
fnd_application_vl fav
where
1=1 and
aat.appl_top_id=apr.appl_top_id and
aap.applied_patch_id=apd.applied_patch_id and
apd.patch_driver_id=apr.patch_driver_id and
apr.patch_run_id=aprb.patch_run_id(+) and
aprb.bug_id=ab.bug_id(+) and
aprb.patch_run_bug_id=aprba.patch_run_bug_id(+) and
aprba.common_action_id=apca.common_action_id(+) and
aprba.file_id=af.file_id(+) and
aprba.onsite_file_version_id=afv1.file_version_id(+) and
aprba.patch_file_version_id=afv2.file_version_id(+) and
upper(aprb.application_short_name)=fav.application_short_name(+)
order by
start_date desc
&sort_action