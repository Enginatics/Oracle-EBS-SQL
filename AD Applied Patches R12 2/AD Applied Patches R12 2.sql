/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD Applied Patches R12.2
-- Description: Check if a specific patch is applied in 12.2
-- Excel Examle Output: https://www.enginatics.com/example/ad-applied-patches-r12-2/
-- Library Link: https://www.enginatics.com/reports/ad-applied-patches-r12-2/
-- Run Report: https://demo.enginatics.com/

select 
decode(ad_patch.is_patch_applied(:ebs_release, :appltop_id, :patch_num &lang),'EXPLICIT','APPLIED','NOT_APPLIED','NOT APPLIED') applied_check
from dual