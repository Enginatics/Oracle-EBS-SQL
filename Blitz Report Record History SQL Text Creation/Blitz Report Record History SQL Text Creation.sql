/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Record History SQL Text Creation
-- Description: Creates a string for the record history columns, based on a table alias.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-record-history-sql-text-creation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-record-history-sql-text-creation/
-- Run Report: https://demo.enginatics.com/

select
'xxen_util.user_name('||:table_alias||'.created_by) '||nvl2(:prefix,:prefix||'_',null)||'created_by,
xxen_util.client_time('||:table_alias||'.creation_date) '||nvl2(:prefix,:prefix||'_',null)||'creation_date,
xxen_util.user_name('||:table_alias||'.last_updated_by) '||nvl2(:prefix,:prefix||'_',null)||'last_updated_by,
xxen_util.client_time('||:table_alias||'.last_update_date) '||nvl2(:prefix,:prefix||'_',null)||'last_update_date,' sql_text
from
dual