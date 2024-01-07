/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Application Categories
-- Description: Oracle application -> Blitz Report assignment via lookup XXEN_REPORT_APPS_CATEGORIES.

This setup controls how automatically imported BI publisher reports and concurrent programs are assigned to Blitz Report categories.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-application-categories/
-- Library Link: https://www.enginatics.com/reports/blitz-report-application-categories/
-- Run Report: https://demo.enginatics.com/

select
trim(regexp_substr(flv.description,'[^,]+',1,rowgen.column_value)) category,
fav.application_name,
flv.lookup_code application_short_name
from
fnd_lookup_values flv,
table(xxen_util.rowgen(regexp_count(flv.description,',')+1)) rowgen,
fnd_application_vl fav
where
flv.language=userenv('lang') and
flv.description is not null and
flv.lookup_code not like 'ALL%' and
flv.lookup_type='XXEN_REPORT_APPS_CATEGORIES' and
flv.view_application_id=0 and
flv.security_group_id=0 and
flv.lookup_code=fav.application_short_name(+)
order by
category,
fav.application_name
