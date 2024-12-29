/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Period Close Pending Transactions
-- Description: Summary report to display the pending transaction counts as found in the Inventory Account Periods Close form, checking open receipts, pending shipments, failed inventory, WIP, etc

The Period Count shows the pending transactions occurring within the specified period.
The Period Close Count shows the count of pending transactions as at the scheduled period close date of the specified period. 
The Period Close Count are the counts displayed in the Pending Transactions Inventory Account Periods Close Form.  
This is the accumulated count of pending transactions upto the shceduled close date of the specified period, except for the count of  'Unprocessed Shipping Transactions' which are not carried over to the next period. 

Period count queries are sourced from procedure CST_AccountingPeriod_PUB.Get_PendingTcount (CSTPAPEB.pls 120.18.12020000.8)

-- Excel Examle Output: https://www.enginatics.com/example/inv-period-close-pending-transactions/
-- Library Link: https://www.enginatics.com/reports/inv-period-close-pending-transactions/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.period_name,
x.transaction_type,
x.resolution,
x.period_count,
x.transaction_count period_close_count,
x.period_start_date,
x.schedule_close_date,
x.display_seq form_display_seq
from
(
/* Queries are taken from CST_AccountingPeriod_PUB.Get_PendingTcount $Header: CSTPAPEB.pls 120.18.12020000.8 */
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Unprocessed Material' transaction_type,
sum(case when trunc(nvl(mmtt.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end) period_count,
count(*) transaction_count,
'Required' resolution,
1 display_seq
from
org_organization_definitions ood,
org_acct_periods oap,
mtl_material_transactions_temp mmtt
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = mmtt.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(mmtt.transaction_date,sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
nvl(mmtt.transaction_status,0) <> 2
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select  /*+ index (mmt mtl_material_transactions_n10) */
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Uncosted Material/WSM',
sum(case when trunc(nvl(mmt.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Required',
2
from
org_organization_definitions ood,
org_acct_periods oap,
mtl_material_transactions mmt
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = mmt.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(mmt.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
costed_flag in('N','E')
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Pending WIP Costing',
sum(case when trunc(nvl(wcti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Required',
3
from
org_organization_definitions ood,
org_acct_periods oap,
wip_cost_txn_interface wcti
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = wcti.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(wcti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity)
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
wsm.period_name,
wsm.period_start_date,
wsm.schedule_close_date,
wsm.organization_code,
'Pending WSM Interface',
sum(wsm.period_count),
sum(wsm.txn_count),
'Required',
4
from
( select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  sum(case when trunc(nvl(wsmti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end) period_count,
  count(*) txn_count
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsm_split_merge_txn_interface wsmti
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = wsmti.organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wsmti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wsmti.process_status <> 4 -- wip_constants.completed
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
  union all
  select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  sum(case when trunc(nvl(wlmti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
  count(*)
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsm_lot_move_txn_interface wlmti
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = wlmti.organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wlmti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wlmti.status <> 4 -- wip_constants.completed
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
  union all
  select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  sum(case when trunc(nvl(wlsmi.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
  count(*)
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsm_lot_split_merges_interface wlsmi
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = wlsmi.organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wlsmi.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wlsmi.process_status <> 4 -- wip_constants.completed
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
) wsm
group by
wsm.period_name,
wsm.period_start_date,
wsm.schedule_close_date,
wsm.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Pending LCM Interface',
sum(case when trunc(nvl(clai.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Required',
5
from
org_organization_definitions ood,
org_acct_periods oap,
mtl_parameters mp,
cst_lc_adj_interface clai
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = clai.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(clai.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
ood.organization_id = mp.organization_id and
nvl(mp.lcm_enabled_flag, 'N') = 'Y'
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Pending Receiving',
sum(case when trunc(nvl(rti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Recommended',
6
from
org_organization_definitions ood,
org_acct_periods oap,
rcv_transactions_interface rti
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = rti.to_organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(rti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
rti.destination_type_code in ('INVENTORY','SHOP FLOOR')
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Pending Material',
sum(case when trunc(nvl(mti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Recommended',
7
from
org_organization_definitions ood,
org_acct_periods oap,
mtl_transactions_interface mti
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = mti.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(mti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
mti.process_flag <> 9
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Pending Shop Floor Move',
sum(case when trunc(nvl(wmti.transaction_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Recommended',
8
from
org_organization_definitions ood,
org_acct_periods oap,
wip_move_txn_interface wmti
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = wmti.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(wmti.transaction_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity)
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code,
'Incomplete Work Orders',
sum(case when trunc(nvl(wdj.scheduled_completion_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) then 1 else 0 end),
count(*),
'Recommended',
9
from
org_organization_definitions ood,
org_acct_periods oap,
mtl_parameters mp,
wip_discrete_jobs wdj,
wip_entities we
where
1=1 and
ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ood.organization_id = wdj.organization_id and
ood.organization_id = oap.organization_id and
trunc(nvl(wdj.scheduled_completion_date, sysdate)) <= inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
ood.organization_id = mp.organization_id and
wdj.wip_entity_id = we.wip_entity_id and
wdj.organization_id = we.organization_id and
nvl(mp.eam_enabled_flag, 'N') = 'Y' and
wdj.status_type = 3 and  -- released
we.entity_type = 6
group by
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
ood.organization_code
--
union
--
select
wsh.period_name,
wsh.period_start_date,
wsh.schedule_close_date,
wsh.organization_code,
'Unprocessed Shipping Transactions',
sum(wsh.txn_count),
sum(wsh.txn_count),
'Recommended',
10
from
( select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  count(*) txn_count
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsh_delivery_details wdd,
  wsh_delivery_assignments_v wda,
  wsh_new_deliveries wnd,
  wsh_delivery_legs wdl,
  wsh_trip_stops wts
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = wdd.organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wts.actual_departure_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wdd.source_code = 'OE' and
  wdd.released_status = 'C' and
  wdd.inv_interfaced_flag in ('N' ,'P') and
  wda.delivery_detail_id = wdd.delivery_detail_id and
  wnd.delivery_id = wda.delivery_id and
  wnd.status_code in ('CL','IT') and
  wdl.delivery_id = wnd.delivery_id and
  wts.pending_interface_flag in ('Y', 'P') and
  wdl.pick_up_stop_id = wts.stop_id
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
  union
  select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  count(*)
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsh_delivery_details wdd,
  wsh_delivery_assignments wda,
  wsh_new_deliveries wnd,
  wsh_delivery_legs wdl,
  wsh_trip_stops wts,
  oe_order_lines_all oel,
  po_requisition_lines_all pl
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = pl.destination_organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wts.actual_departure_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wdd.source_code = 'OE' and
  wdd.released_status = 'C' and
  wdd.inv_interfaced_flag in ('N' ,'P') and
  wda.delivery_detail_id = wdd.delivery_detail_id and
  wnd.delivery_id = wda.delivery_id and
  wnd.status_code in ('CL','IT') and
  wdl.delivery_id = wnd.delivery_id and
  wts.pending_interface_flag in ('Y', 'P') and
  wdd.source_line_id = oel.line_id and
  wdd.source_document_type_id = 10 and
  oel.source_document_line_id = pl.requisition_line_id and
  pl.destination_organization_id <> pl.source_organization_id and
  pl.destination_type_code = 'EXPENSE' and
  wdl.pick_up_stop_id = wts.stop_id and
  wts.stop_location_id = wnd.initial_pickup_location_id
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
  union
  select
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code,
  count(*)
  from
  org_organization_definitions ood,
  org_acct_periods oap,
  wsh_delivery_details wdd,
  wsh_delivery_assignments wda,
  wsh_new_deliveries wnd,
  wsh_delivery_legs wdl,
  wsh_trip_stops wts,
  oe_order_lines_all oel,
  po_requisition_lines_all pl,
  mtl_interorg_parameters mip
  where
  1=1 and
  ood.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
  ood.organization_id = pl.destination_organization_id and
  ood.organization_id = oap.organization_id and
  trunc(nvl(wts.actual_departure_date, sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,ood.legal_entity) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,ood.legal_entity) and
  wdd.source_code = 'OE' and
  wdd.released_status = 'C' and
  wdd.inv_interfaced_flag in ('N' ,'P') and
  wda.delivery_detail_id = wdd.delivery_detail_id and
  wnd.delivery_id = wda.delivery_id and
  wnd.status_code in ('CL','IT') and
  wdl.delivery_id = wnd.delivery_id and
  wts.pending_interface_flag in ('Y', 'P') and
  wdd.source_line_id = oel.line_id and
  wdd.source_document_type_id = 10 and
  oel.source_document_line_id = pl.requisition_line_id and
  pl.destination_organization_id <> pl.source_organization_id and
  pl.destination_organization_id = mip.to_organization_id and
  pl.source_organization_id = mip.from_organization_id and
  mip.intransit_type = 1 and
  pl.destination_type_code <> 'EXPENSE' and
  wdl.pick_up_stop_id = wts.stop_id and
  wts.stop_location_id = wnd.initial_pickup_location_id
  group by
  oap.period_name,
  oap.period_start_date,
  oap.schedule_close_date,
  ood.organization_code
) wsh
group by
wsh.period_name,
wsh.period_start_date,
wsh.schedule_close_date,
wsh.organization_code
) x
order by
x.organization_code,
x.period_start_date desc,
x.display_seq