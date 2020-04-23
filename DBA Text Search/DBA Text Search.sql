/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Text Search
-- Description: Full text search through database source code objects such as packages, procedures, functions, triggers etc.
-- Excel Examle Output: https://www.enginatics.com/example/dba-text-search
-- Library Link: https://www.enginatics.com/reports/dba-text-search
-- Run Report: https://demo.enginatics.com/


select
ds.owner,
ds.type,
ds.name,
ds.line,
ds.text
from
dba_source ds
where
1=1
order by
ds.name,
ds.line