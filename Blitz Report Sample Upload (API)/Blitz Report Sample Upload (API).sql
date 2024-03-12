/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Sample Upload (API)
-- Description: Sample upload to be used as a template by copying (Tools>Copy Report) to create new uploads using API.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-sample-upload-api/
-- Library Link: https://www.enginatics.com/reports/blitz-report-sample-upload-api/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
xus.id,
xus.name,
xus.date_of_birth
from
xxen_upload_sample xus
where
1=1
&not_use_first_block
&report_table_select 
&report_table_name 
&report_table_where_clause 
&success_records
&processed_run
order by 4