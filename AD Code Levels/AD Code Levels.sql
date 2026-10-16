/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD Code Levels
-- Description: Code level and baseline of each Oracle EBS product and product family, as maintained by the patching utilities in ADTRACKABLEENTITIES.
-- Patch readme files and My Oracle Support notes state prerequisites as code levels, for example R12.AD.C.Delta.15 for AD code level C.15.
-- Excel Example Output: https://www.enginatics.com/example/ad-code-levels/
-- Library Link: https://www.enginatics.com/reports/ad-code-levels/
-- Run Report: https://demo.enginatics.com/

select
ate.abbreviation,
ate.name,
ate.type,
ate.codelevel code_level,
ate.baseline
from
ad_trackable_entities ate
where
1=1
order by
ate.type,
ate.abbreviation
