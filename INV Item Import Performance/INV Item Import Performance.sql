/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Import Performance
-- Description: Analytical report by item to predict performance of inventory item load background processes. If the number of items processed per second is decreasing with increasing total items processed, then the interface SQLs are most likely using a wrong nonselective index and should be corrected.
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-import-performance/
-- Library Link: https://www.enginatics.com/reports/inv-item-import-performance/
-- Run Report: https://demo.enginatics.com/

select
x.request_id,
x.program,
x.description,
x.requested_by,
x.created_by,
xxen_util.client_time(x.actual_start_date) actual_start_date,
xxen_util.client_time(x.actual_completion_date) actual_completion_date,
x.seconds,
xxen_util.time(x.seconds) time,
x.item_count,
x.total_item_count,
round(x.item_count/xxen_util.zero_to_null(x.seconds),3) items_per_second,
round(x.total_item_count/xxen_util.zero_to_null(x.seconds),2) total_items_per_second,
xxen_util.client_time(x.min_creation_date) min_creation_date
from
(
select distinct
msib.request_id,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 /*alecdc*/ or fcr.request_type='M' then fcr.description else fcpt.user_concurrent_program_name end program,
fcr.description,
xxen_util.user_name(fcr.requested_by) requested_by,
xxen_util.user_name(msib.created_by) created_by,
fcr.actual_start_date,
fcr.actual_completion_date,
(nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date)*86400 seconds,
count(distinct msib.inventory_item_id) over (partition by msib.created_by, msib.request_id) item_count,
count(*) over (partition by msib.created_by, msib.request_id) total_item_count,
min(msib.creation_date) over (partition by msib.created_by, msib.request_id) min_creation_date
from
mtl_system_items_b msib,
fnd_concurrent_requests fcr,
fnd_concurrent_programs_tl fcpt
where
1=1 and
msib.request_id=fcr.request_id and
fcr.program_application_id=fcpt.application_id(+) and
fcr.concurrent_program_id=fcpt.concurrent_program_id(+) and
fcpt.language(+)=userenv('lang')
) x
where
2=2
order by
x.request_id desc