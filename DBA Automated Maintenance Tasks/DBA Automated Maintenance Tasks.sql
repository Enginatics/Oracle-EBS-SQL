/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Automated Maintenance Tasks
-- Description: There are several automated jobs and 'advisors' running by default in an Oracle database that are often not required or should not run in Oracle EBS environments. Their status and history can be queried by the following SQLs:
select dao.* from dba_autotask_operation dao
select dajh.* from dba_autotask_job_history dajh

- Automatic Optimizer Statistics Collection
For EBS, the automated DB statistics collection must be deactivated by setting DB initialization parameter _optimizer_autostats_job=false, and concurrent 'Gather Schema Statistics' scheduled instead, see note 396009.1 <a href="https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=396009.1" rel="nofollow" target="_blank">https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=396009.1</a>

- Automatic Segment Advisor
Identifies segments that have space available for reclamation, and makes recommendations on how to defragment those segments. This process causes significant IO overhead and we therefore recommend disabling the automated scheduling. It can be run on demand instead, in case DBAs would want to take action on optimizing the storage.

- Automatic SQL Tuning Advisor
Examines the performance of high-load SQL statements, and makes recommendations on how to tune those statements. In EBS environents, such automated tuning recommendations are typically useless, as the majority of performance issues is caused by incorrect custom SQL coding, e.g. lack of where-clause restrictions to allow index access or coding that prevents the optimizer from executing queries efficiently. The automatic tuning advisor can not optimize such SQLs, as it can not modify the SQL logic, which is required for most scenarios. We recommend deactivating the advisor to reduce processing overhead.

- Automatic Database Diagnostic Monitor (ADDM)
This job runs after each AWR snapshot and creates performance tuning recommendations. In environments which are  not actively monitored by DBAs such as development or test systems, this should be deactivated by setting alter system set "_addm_auto_enable"=false.
Blitz Report's DBA AWR reports give better and more detailed insights into performance bottlenecks, such as wait times or problematic SQLs.

To deactivate automated tasks individually, execute the following commands:
exec dbms_auto_task_admin.disable(client_name=>'auto optimizer stats collection',operation=>null,window_name=>null);
exec dbms_auto_task_admin.disable(client_name=>'auto space advisor',operation=>null,window_name=>null);
exec dbms_auto_task_admin.disable(client_name=>'sql tuning advisor', operation=>null,window_name=>null);

To deactivate all automated tasks completely, execute the following commands:
exec dbms_auto_task_admin.disable;
alter system set "_addm_auto_enable"=false;
-- Excel Examle Output: https://www.enginatics.com/example/dba-automated-maintenance-tasks/
-- Library Link: https://www.enginatics.com/reports/dba-automated-maintenance-tasks/
-- Run Report: https://demo.enginatics.com/

select
dawc.*
from
dba_autotask_window_clients dawc