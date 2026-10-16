/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Text Search
-- Description: Full text search through database source code objects such as packages, procedures, functions, triggers etc.
-- The search can also be done using regular expressions.
-- To retrieve incorrect custom code such as a frequent performance issue calling the fndconcurrent\.waitforrequest\s function with a zero interval time, for example, use parameter 'Multi Line Regex search' with the following value: fndconcurrent\.waitforrequest\s\(\srequestid\s=>\s\w+\s,\sinterval\s=>\s0\s,
-- Excel Example Output: https://www.enginatics.com/example/dba-text-search/
-- Library Link: https://www.enginatics.com/reports/dba-text-search/
-- Run Report: https://demo.enginatics.com/

select ds.* from (
select
ds.owner,
ds.type,
ds.name,
ds.line,
ds.text,
to_clob(null)||&multi_line_text
null multi_line_text
from
dba_source ds
where
1=1
) ds
where
2=2
order by
ds.name,
ds.type,
ds.line
