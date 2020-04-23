/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Languages
-- Excel Examle Output: https://www.enginatics.com/example/fnd-languages/
-- Library Link: https://www.enginatics.com/reports/fnd-languages/
-- Run Report: https://demo.enginatics.com/

select
flv.description language,
flv.language_code,
decode(flv.installed_flag,'I','Installed','B','Base Language') installed_flag,
flv.last_update_date
from
fnd_languages_vl flv
where
1=1
order by
flv.description