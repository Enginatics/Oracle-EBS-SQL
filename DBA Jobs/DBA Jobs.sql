/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Jobs
-- Description: 
-- Excel Example Output: https://www.enginatics.com/example/dba-jobs/
-- Library Link: https://www.enginatics.com/reports/dba-jobs/
-- Run Report: https://demo.enginatics.com/

select
dj.*
from
dba_jobs dj
order by
dj.broken,
dj.next_date desc,
dj.priv_user
