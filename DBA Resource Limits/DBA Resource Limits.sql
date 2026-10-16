/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Resource Limits
-- Description: Current and highest utilization since instance startup of database resources such as processes, sessions and transactions, compared to their limits.
-- A Max Percent close to 100 shows that the instance reached the limit since startup. Reaching the processes or sessions limit causes ORA-00020 or ORA-00018 for new connections.
-- In a pluggable database, the database shows resource limits only in the container root. There the report shows the current number of processes and sessions against their parameter limits instead, without the highest utilization.
-- Schedule the report with Max Percent From, for example 90, to get an email only when a limit is nearly reached.
-- Excel Example Output: https://www.enginatics.com/example/dba-resource-limits/
-- Library Link: https://www.enginatics.com/reports/dba-resource-limits/
-- Run Report: https://demo.enginatics.com/

select
x.inst_id,
x.resource_name,
x.current_utilization,
x.max_utilization,
x.initial_allocation,
x.limit_value,
x.current_percent,
x.max_percent
from
(
select
y.*,
case when y.limit_value not in ('UNLIMITED','0') then y.current_utilization/to_number(y.limit_value)*100 end current_percent,
case when y.limit_value not in ('UNLIMITED','0') then y.max_utilization/to_number(y.limit_value)*100 end max_percent
from
(
select
grl.inst_id,
grl.resource_name,
grl.current_utilization,
grl.max_utilization,
trim(grl.initial_allocation) initial_allocation,
trim(grl.limit_value) limit_value
from
gv$resource_limit grl
union all
select
gp.inst_id,
gp.name resource_name,
decode(gp.name,'processes',(select count(*) from gv$process gp2 where gp.inst_id=gp2.inst_id),(select count(*) from gv$session gs where gp.inst_id=gs.inst_id)) current_utilization,
null max_utilization,
gp.value initial_allocation,
gp.value limit_value
from
gv$parameter gp
where
gp.name in ('processes','sessions') and
not exists (select null from gv$resource_limit grl)
) y
) x
where
1=1
order by
nvl(x.max_percent,x.current_percent) desc nulls last,
x.inst_id,
x.resource_name
