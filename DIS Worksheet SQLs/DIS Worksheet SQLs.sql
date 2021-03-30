/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Worksheet SQLs
-- Description: Discoverer worksheet SQL queries.
While the workbook documents are stored in a binary format in eul5_documents.doc_document and it's difficult extract their content (https://community.oracle.com/thread/2494216), there is an active trigger function
select ef.* from eul_us1.eul5_functions ef where ef.fun_name='eul_trigger$post_save_document'
writing each worksheets' SQL query to table ams_discoverer_sql
-- Excel Examle Output: https://www.enginatics.com/example/dis-worksheet-sqls/
-- Library Link: https://www.enginatics.com/reports/dis-worksheet-sqls/
-- Run Report: https://demo.enginatics.com/

select
ads.workbook_name workbook,
ads.worksheet_name Worksheet,
xxen_util.dis_user_name(ads.workbook_owner_name) workbook_owner,
eqs.access_count,
eqs.last_accessed,
xxen_util.dis_worksheet_sql(ads.workbook_owner_name, ads.workbook_name, ads.worksheet_name) worksheet_sql,
xxen_util.user_name(ads.last_updated_by) last_updated_by,
xxen_util.client_time(ads.last_update_date) last_update_date
from
(
select distinct
ads.workbook_owner_name,
ads.workbook_name,
ads.worksheet_name,
max(ads.last_updated_by) over (partition by ads.workbook_owner_name, ads.workbook_name, ads.worksheet_name) last_updated_by,
max(ads.last_update_date) over (partition by ads.workbook_owner_name, ads.workbook_name, ads.worksheet_name) last_update_date
from
ams_discoverer_sql ads
where
1=1
) ads,
(
select
eqs.qs_doc_owner,
eqs.qs_doc_name,
eqs.qs_doc_details,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
eqs.qs_doc_owner,
eqs.qs_doc_name,
eqs.qs_doc_details
) eqs
where
3=3 and
ads.workbook_name=eqs.qs_doc_name(+) and
ads.worksheet_name=eqs.qs_doc_details(+)
order by
ads.last_update_date desc