/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Scheduler Jobs
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/dba-scheduler-jobs/
-- Library Link: https://www.enginatics.com/reports/dba-scheduler-jobs/
-- Run Report: https://demo.enginatics.com/

select
dsj.*
from
dba_scheduler_jobs dsj
order by
dsj.next_run_date desc nulls last,
dsj.owner