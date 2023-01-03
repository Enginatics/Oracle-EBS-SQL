/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Table Alias Validation
-- Description: Blitz report parameters referencing table aliases, which do not exist as a table in the main report SQL
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-table-alias-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-table-alias-validation/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xrpv.report_name,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xrpv.sql_text,
dbms_lob.substr(regexp_substr(xrpv.sql_text,'(\w+)\.\w+.',1,1,null,1)) table_alias,
dbms_lob.substr(regexp_substr(xrpv.sql_text,'\w+\.\w+(.)',1,1,null,1)) function_check,
xrpv.report_id
from
xxen_report_parameters_v xrpv
where
xrpv.anchor not like '&%' and
xrpv.report_id in (select xrca.report_id from xxen_report_categories_v xrcv, xxen_report_category_assigns xrca where xrcv.category='Enginatics' and xrcv.category_id=xrca.category_id) and
(xrpv.display_sequence>0 or xrpv.display_sequence is null) and
xrpv.sql_text is not null
) x
where
x.table_alias not in ('xrrpv') and
x.function_check<>'(' and
x.table_alias is not null and
not exists (select null from xxen_reports xr where x.report_id=xr.report_id and regexp_like(xr.sql_text,' '||x.table_alias||'\W','i')) and
not exists (select null from xxen_report_parameters_v xrpv2 where x.report_id=xrpv2.report_id and x.parameter_name=xrpv2.parameter_name and xrpv2.anchor like '&%' and regexp_like(xrpv2.sql_text,' '||x.table_alias||'\W','i'))
order by
x.report_name,
x.display_sequence