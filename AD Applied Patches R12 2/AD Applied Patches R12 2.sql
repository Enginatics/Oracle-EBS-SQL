/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD Applied Patches R12.2
-- Description: Check if a specific patch is applied in 12.2 using ad_patch.is_patch_applied function according to MOS Doc ID 1963046.1
-- Excel Examle Output: https://www.enginatics.com/example/ad-applied-patches-r12-2/
-- Library Link: https://www.enginatics.com/reports/ad-applied-patches-r12-2/
-- Run Report: https://demo.enginatics.com/

select
adb.bug_number,
aat.name appl_top_name,
adb.language,
decode(ad_patch.is_patch_applied('R12',aat.appl_top_id,adb.bug_number,adb.language),'EXPLICIT','APPLIED','NOT_APPLIED','NOT APPLIED') status
from ad_bugs adb,
(
select
aat.name,aat.appl_top_id
from
applsys.ad_appl_tops aat,
(select distinct fat.name from applsys.fnd_appl_tops fat) fat
where
aat.name=fat.name and
&appl_top_id
) aat
where
1=1
order by adb.bug_number,aat.name,adb.language