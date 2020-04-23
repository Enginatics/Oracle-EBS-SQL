/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ECC Concurrent Programs
-- Description: Oracle note 2495053.1 lists all concurrent program names for Enterprise Command Centers:
https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=2495053.1

This report can be used to check which of those required ECC load requests are currently scheduled.
The short code can then be used as multiple parameter value entry in other reports, e.g. https://www.enginatics.com/reports/fnd-access-control/ to see which responsibilities or users have access to schedule them, or https://www.enginatics.com/reports/fnd-concurrent-requests/ to look at past execution and schedule times.
-- Excel Examle Output: https://www.enginatics.com/example/ecc-concurrent-programs/
-- Library Link: https://www.enginatics.com/reports/ecc-concurrent-programs/
-- Run Report: https://demo.enginatics.com/

select
y.concurrent_program,
fcpv.concurrent_program_name short_name,
xxen_util.meaning(fev.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) method,
fev.execution_file_name,
(
select distinct
listagg(fcr.request_id,'; ') within group (order by fcr.request_id) over (partition by fcr.program_application_id,fcr.concurrent_program_id) request_id
from
fnd_concurrent_requests fcr
where
fcr.argument_text like '%INCREMENTAL_LOAD%' and
(fcr.phase_code='P' and fcr.hold_flag='N' or fcr.phase_code='R') and
fcpv.application_id=fcr.program_application_id and
fcpv.concurrent_program_id=fcr.concurrent_program_id
) incremental_load_request_id,
(
select distinct
max(frv.responsibility_name) keep (dense_rank last order by fcr.responsibility_id) over () responsibility
from
fnd_concurrent_requests fcr,
fnd_responsibility_vl frv
where
fcr.argument_text like '%INCREMENTAL_LOAD%' and
(fcr.phase_code='P' and fcr.hold_flag='N' or fcr.phase_code='R') and
fcpv.application_id=fcr.program_application_id and
fcpv.concurrent_program_id=fcr.concurrent_program_id and
fcr.responsibility_application_id=frv.application_id and
fcr.responsibility_id=frv.responsibility_id
) incremental_responsibility,
(
select distinct
listagg(fcr.request_id,'; ') within group (order by fcr.request_id) over (partition by fcr.program_application_id,fcr.concurrent_program_id) request_id
from
fnd_concurrent_requests fcr
where
fcr.argument_text like '%FULL_LOAD%' and
(fcr.phase_code='P' and fcr.hold_flag='N' or fcr.phase_code='R') and
fcpv.application_id=fcr.program_application_id and
fcpv.concurrent_program_id=fcr.concurrent_program_id
) full_load_request_id,
(
select distinct
max(frv.responsibility_name) keep (dense_rank last order by fcr.responsibility_id) over () responsibility
from
fnd_concurrent_requests fcr,
fnd_responsibility_vl frv
where
fcr.argument_text like '%FULL_LOAD%' and
(fcr.phase_code='P' and fcr.hold_flag='N' or fcr.phase_code='R') and
fcpv.application_id=fcr.program_application_id and
fcpv.concurrent_program_id=fcr.concurrent_program_id and
fcr.responsibility_application_id=frv.application_id and
fcr.responsibility_id=frv.responsibility_id
) full_load_responsibility
from
(
select
case when x.text like '%:%' then substr(x.text,instr(x.text,':')+2) else x.text end concurrent_program
from
(
select 'Oracle Asset Tracking Command Center Data Load' text from dual union all
select 'Assets Command Center Data Load' text from dual union all
select 'Channel Revenue Management Command Center Data Load' text from dual union all
select 'PO CLM ECC Data Load' text from dual union all
select 'Cost Management Command Center Data Load' text from dual union all
select 'Depot Command Center Data Load' text from dual union all
select 'WIP ECC Data Load' text from dual union all
select 'Enterprise Asset Management Command Center Data Load' text from dual union all
select 'Field Service Command Center Data Load' text from dual union all
select 'PER ECC Data Load' text from dual union all
select 'OIC ECC Data Load' text from dual union all
select 'Activity Dashboard: Activity Details Data Load' text from dual union all
select 'Aging Inventory Dashboard: Inventory On Hand Data Load' text from dual union all
select 'Inventory Cycle Counting Dashboard: Inventory Cycle Counting Data Load' text from dual union all
select 'Items Dashboard Data Load' text from dual union all
select 'Receiving Dashboard: Inbound Details Data Load' text from dual union all
select 'Shipping Dashboard: Delivery Details Data Load' text from dual union all
select 'iProcurement ECC Data Load' text from dual union all
select 'Receivables Command Center Data Load' text from dual union all
select 'Landed Cost Data Load' text from dual union all
select 'Lease Asset Management ECC Loader' text from dual union all
select 'Lease ECC AR Cash Data Loader' text from dual union all
select 'Lease ECC Data Loader' text from dual union all
select 'Lease Period Balances Data Load' text from dual union all
select 'Property Manager ECC Data Loader' text from dual union all
select 'OM Command Center Data Load' text from dual union all
select 'Outsourced Manufacturing Command Center Data Load' text from dual union all
select 'Payables Command Center Data Load' text from dual union all
select 'Process Manufacturing Command Center Data Load' text from dual union all
select 'PO PCC ECC Data Load' text from dual union all
select 'PO ECC Supplier Analysis Data Load' text from dual union all
select 'PO ECC Strategic Sourcing Data Load' text from dual union all
select 'Project Procurement - Item Analysis ECC Data Load' text from dual union all
select 'Project Procurement - ECC Data Load' text from dual union all
select 'Project Procurement - Procurement Plan ECC Data Load' text from dual union all
select 'Projects Costing and Accounting ECC Data Load' text from dual union all
select 'Projects Costing Budgetary Control ECC Data Load' text from dual union all
select 'Quality Command Center Data Load' text from dual union all
select 'Service Command Center Data Load' text from dual union all
select 'Service Contracts Command Center Data Load' text from dual
) x
) y,
fnd_concurrent_programs_vl fcpv,
fnd_executables_vl fev
where
y.concurrent_program=fcpv.user_concurrent_program_name(+) and
fcpv.executable_application_id=fev.application_id(+) and
fcpv.executable_id=fev.executable_id(+)
order by
y.concurrent_program