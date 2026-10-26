/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory to G/L Reconciliation (Restricted by Org Access)
-- Description: For Discrete Costing, this report compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory and WIP balances, generated when the inventory accounting period is closed, plus a calculated month-end receiving value). Inventory balances includes Receiving, Onhand Inventory (Stock), Intransit and Work in Process (WIP). This report automatically discovers your valuation accounts based on your setups, such as the Cost Method (Standard, Average, FIFO or LIFO Costing), and also if using Project Manufacturing (PJM - Cost Group Accounting) or Warehouse Management (WMS - Cost Group Accounting) or even if using Category Accounts. But note as maintenance work orders are normally charged to expense accounts, maintenance (EAM) work orders are not included in this report. Also note this report does not break out the perpetual account values by cost element; it assumes the elemental cost accounts by subinventory or cost group are the same as the material account, as the stored month-end perpetual inventory balances are only stored by organization, accounting period and item, but not by cost element.
-- / +=============================================================================+
-- -- | Copyright 2010-23 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: XXXINVRECONREPT.sql
-- -- |
-- -- | Parameters:
-- -- | PPERIODNAME -- Enter the Period Name you wish to reconcile balances for (mandatory)
-- -- | PLEDGER -- general ledger you wish to report, for all ledgers left this parameter blank
-- -- | ============================================================================
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 24 Sep 2004 Douglas Volz Initial Coding based on earlier work with
-- -- | the following scripts and designs:
-- -- | XXXGLRECON.sql,
-- -- | XXXPERPETUALINVRECONSUM.sql,
-- -- | XXXPERPETUALRCVRECONSUM.sql,
-- -- | XXXPERPETUALWIPRECONSUM.sql,
-- -- | MD050 Inventory Reconciliation
-- -- | 1.1 28 Jun 2010 Douglas Volz Updated design and code for Release 12,
-- -- | changed GLSETSOFBOOKS to GLLEDGERS
-- -- | 1.2 14 Nov 2010 Douglas Volz Modified for Cost SIG Presentation
-- -- | 1.3 11 Mar 2014 Douglas Volz Changed the COA segments to be generic and removed
-- -- | the second product line join to glcodecombinations
-- -- | 1.4 07 Apr 2014 Douglas Volz Added join condition to avoid secondary ledgers and
-- -- | added an explicit tochar on the accounts
-- -- | ml.lookupcode to avoid an "invalid number" SQL error.
-- -- | 1.5 20 Jul 2016 Douglas Volz Added condition to avoid summary journals
-- -- | 1.6 18 May 2020 Douglas Volz Avoid disabled inventory organizations.
-- -- | 1.7 07 Dec 2020 Douglas Volz/Andy Haack Only report inventory organization ledgers. Initial Blitz version.
-- -- | 1.8 22 Feb 2023 Douglas Volz Add in Receiving Value, fixes for Category Accounting.
-- -- | 1.9 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-restricted-by-org-access/
-- Run Report: https://demo.enginatics.com/

with o as (
select /*+ materialize*/
mp.organization_id,
mp.primary_cost_method,
case when mp.cost_group_accounting=1 or mp.wms_enabled_flag='Y' or mp.organization_id in (select pop.organization_id from pjm_org_parameters pop) then 'Y' end cost_group_accounting,
mp.material_account,
mp.material_overhead_account,
mp.resource_account,
mp.overhead_account,
mp.outside_processing_account,
mp.intransit_inv_account,
gl.ledger_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
gl_ledgers gl
where
5=5 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information1)=gl.ledger_id and
gl.ledger_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='LEDGER')
),
y as (
select /*+ materialize*/ distinct
x.ledger_id,
gcc.&account_segment account
from
(
select
o.ledger_id,
decode(rowgen.column_value,1,msi.material_account,2,msi.material_overhead_account,3,msi.resource_account,4,msi.overhead_account,5,msi.outside_processing_account) account_id
from
o,
mtl_secondary_inventories msi,
table(xxen_util.rowgen(5)) rowgen
where
o.primary_cost_method=1 and
o.cost_group_accounting is null and
o.organization_id=msi.organization_id and
msi.asset_inventory=1
union all
select
o.ledger_id,
decode(rowgen.column_value,1,o.material_account,2,o.material_overhead_account,3,o.resource_account,4,o.overhead_account,5,o.outside_processing_account,6,o.intransit_inv_account) account_id
from
o,
table(xxen_util.rowgen(6)) rowgen
where
rowgen.column_value=6 or
o.primary_cost_method<>1 and
o.cost_group_accounting is null
union all
select
o.ledger_id,
decode(rowgen.column_value,1,ccga.material_account,2,ccga.material_overhead_account,3,ccga.resource_account,4,ccga.overhead_account,5,ccga.outside_processing_account) account_id
from
o,
cst_cost_group_accounts ccga,
table(xxen_util.rowgen(5)) rowgen
where
o.cost_group_accounting='Y' and
o.organization_id=ccga.organization_id
union all
select
o.ledger_id,
decode(rowgen.column_value,1,mca.material_account,2,mca.material_overhead_account,3,mca.resource_account,4,mca.overhead_account,5,mca.outside_processing_account) account_id
from
o,
mtl_category_accounts mca,
table(xxen_util.rowgen(5)) rowgen
where
o.organization_id=mca.organization_id
union all
select
o.ledger_id,
decode(rowgen.column_value,1,wac.material_account,2,wac.material_overhead_account,3,wac.resource_account,4,wac.overhead_account,5,wac.outside_processing_account) account_id
from
o,
wip_accounting_classes wac,
table(xxen_util.rowgen(5)) rowgen
where
o.organization_id=wac.organization_id and
wac.class_type not in (4,6,7)
union all
select
o.ledger_id,
mip.intransit_inv_account
from
o,
mtl_interorg_parameters mip
where
o.organization_id in (mip.from_organization_id,mip.to_organization_id)
union all
select
o.ledger_id,
rp.receiving_account_id
from
o,
rcv_parameters rp
where
o.organization_id=rp.organization_id
) x,
gl_code_combinations gcc
where
x.account_id=gcc.code_combination_id
)
select
x.period_name,
gl.name ledger,
&segment_columns
sum(x.gl_beg_balance) gl_beginning_balance,
sum(x.gl_receiving_amount) gl_receiving,
sum(x.gl_inventory_amount) gl_inventory,
sum(x.gl_wip_amount) gl_work_in_process,
sum(x.gl_payables_amount) gl_payables,
sum(x.gl_other_amount) gl_other,
sum(x.gl_end_balance) gl_ending_balance,
sum(x.receiving_value) receiving_value,
sum(x.inv_onhand_value) inventory_value,
sum(x.wip_value) wip_value,
sum(x.receiving_value+x.inv_onhand_value+x.wip_value) total_perpetual_value,
sum(x.gl_end_balance-x.receiving_value-x.inv_onhand_value-x.wip_value) difference
from
(
select
gb.period_name,
gb.ledger_id,
gb.code_combination_id,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) gl_beg_balance,
0 gl_receiving_amount,
0 gl_inventory_amount,
0 gl_wip_amount,
0 gl_payables_amount,
0 gl_other_amount,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) gl_end_balance,
0 receiving_value,
0 inv_onhand_value,
0 wip_value
from
gl_ledgers gl,
gl_balances gb,
gl_code_combinations gcc
where
gl.ledger_id in (select o.ledger_id from o) and
gl.ledger_category_code<>'SECONDARY' and
gl.bal_seg_value_option_code<>'A' and
gl.ledger_id=gb.ledger_id and
gb.period_name=:period_name and
gb.actual_flag='A' and
gb.period_type=gl.accounted_period_type and
gb.currency_code=gl.currency_code and
gb.code_combination_id=gcc.code_combination_id and
gcc.summary_flag='N' and
(gl.ledger_id,gcc.&account_segment) in (select y.ledger_id,y.account from y)
union all
select
gjh.period_name,
gjh.ledger_id,
gjl.code_combination_id,
0 gl_beg_balance,
sum(case when gjh.je_source='Cost Management' and gjh.je_category='Receiving' then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) else 0 end) gl_receiving_amount,
sum(case when gjh.je_source='Cost Management' and gjh.je_category='Inventory' then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) else 0 end) gl_inventory_amount,
sum(case when gjh.je_source='Cost Management' and gjh.je_category='WIP' then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) else 0 end) gl_wip_amount,
sum(case when gjh.je_source='Payables' then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) else 0 end) gl_payables_amount,
sum(case when gjh.je_source not in ('Cost Management','Payables') then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) else 0 end) gl_other_amount,
0 gl_end_balance,
0 receiving_value,
0 inv_onhand_value,
0 wip_value
from
gl_ledgers gl,
gl_je_headers gjh,
gl_je_lines gjl,
gl_code_combinations gcc
where
gl.ledger_id in (select o.ledger_id from o) and
gl.ledger_category_code<>'SECONDARY' and
gl.bal_seg_value_option_code<>'A' and
gl.ledger_id=gjh.ledger_id and
gjh.period_name=:period_name and
gjh.status='P' and
gjh.actual_flag='A' and
gjh.je_header_id=gjl.je_header_id and
gjh.period_name=gjl.period_name and
gjl.code_combination_id=gcc.code_combination_id and
gcc.summary_flag='N' and
(gl.ledger_id,gcc.&account_segment) in (select y.ledger_id,y.account from y)
group by
gjh.period_name,
gjh.ledger_id,
gjl.code_combination_id
union all
select
oap.period_name,
o.ledger_id,
case
when cpcs.subinventory_code is null then o.intransit_inv_account
when ccga.material_account is not null then ccga.material_account
when o.primary_cost_method=1 then msi.material_account
else o.material_account
end code_combination_id,
0 gl_beg_balance,
0 gl_receiving_amount,
0 gl_inventory_amount,
0 gl_wip_amount,
0 gl_payables_amount,
0 gl_other_amount,
0 gl_end_balance,
0 receiving_value,
sum(cpcs.rollback_value) inv_onhand_value,
0 wip_value
from
o,
org_acct_periods oap,
cst_period_close_summary cpcs,
mtl_secondary_inventories msi,
cst_cost_group_accounts ccga
where
o.organization_id=oap.organization_id and
oap.period_name=:period_name and
oap.acct_period_id=cpcs.acct_period_id and
oap.organization_id=cpcs.organization_id and
cpcs.rollback_quantity<>0 and
cpcs.organization_id=msi.organization_id(+) and
cpcs.subinventory_code=msi.secondary_inventory_name(+) and
decode(o.cost_group_accounting,'Y',cpcs.cost_group_id)=ccga.cost_group_id(+) and
cpcs.organization_id=ccga.organization_id(+)
group by
oap.period_name,
o.ledger_id,
case
when cpcs.subinventory_code is null then o.intransit_inv_account
when ccga.material_account is not null then ccga.material_account
when o.primary_cost_method=1 then msi.material_account
else o.material_account
end
union all
select
w.period_name,
w.ledger_id,
decode(rowgen.column_value,1,w.material_account,2,w.material_overhead_account,3,w.resource_account,4,w.outside_processing_account,5,w.overhead_account) code_combination_id,
0 gl_beg_balance,
0 gl_receiving_amount,
0 gl_inventory_amount,
0 gl_wip_amount,
0 gl_payables_amount,
0 gl_other_amount,
0 gl_end_balance,
0 receiving_value,
0 inv_onhand_value,
decode(rowgen.column_value,1,w.material_value,2,w.material_overhead_value,3,w.resource_value,4,w.outside_processing_value,5,w.overhead_value) wip_value
from
(
select
oap.period_name,
o.ledger_id,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.tl_scrap_var,0)-nvl(wpb.pl_material_var,0)) material_value,
sum(nvl(wpb.pl_material_overhead_in,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)) material_overhead_value,
sum(nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)) resource_value,
sum(nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)) outside_processing_value,
sum(nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)) overhead_value
from
o,
org_acct_periods oap,
wip_period_balances wpb,
wip_discrete_jobs wdj,
wip_accounting_classes wac
where
o.organization_id=oap.organization_id and
oap.period_name=:period_name and
oap.organization_id=wdj.organization_id and
(wdj.date_closed is null or wdj.date_closed>=oap.period_start_date) and
wdj.wip_entity_id=wpb.wip_entity_id and
wpb.acct_period_id<=oap.acct_period_id and
wdj.organization_id=wac.organization_id and
wdj.class_code=wac.class_code and
wac.class_type not in (4,6,7)
group by
oap.period_name,
o.ledger_id,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account
) w,
table(xxen_util.rowgen(5)) rowgen
union all
select
oap.period_name,
o.ledger_id,
rp.receiving_account_id code_combination_id,
0 gl_beg_balance,
0 gl_receiving_amount,
0 gl_inventory_amount,
0 gl_wip_amount,
0 gl_payables_amount,
0 gl_other_amount,
0 gl_end_balance,
sum(r.amount+r.adjustment_amount) receiving_value,
0 inv_onhand_value,
0 wip_value
from
(
select
n.organization_id,
sum(n.amount) amount,
sum(n.adjustment_amount) adjustment_amount
from
(
select
rs.to_organization_id organization_id,
rs.item_id inventory_item_id,
rs.destination_type_code,
rs.po_header_id,
rs.po_line_id,
rs.po_line_location_id,
rs.po_release_id,
rs.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(rs.to_org_primary_quantity,3) quantity,
rs.amount,
0 adjustment_amount
from
(
select
ms.to_organization_id,
ms.item_id,
ms.destination_type_code,
ms.po_header_id,
ms.po_line_id,
ms.po_line_location_id,
ms.po_distribution_id,
ms.po_release_id,
ms.shipment_header_id,
ms.shipment_line_id,
ms.rcv_transaction_id,
ms.to_org_primary_quantity,
round(ms.to_org_primary_quantity*round(sum(case when nvl(rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(plla.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end*nvl(rae.currency_conversion_rate,1)*rae.source_doc_quantity)/sum(rae.primary_quantity),8),2) amount
from
mtl_supply ms,
po_line_locations_all plla,
(
select
x.parent_transaction_id,
x.organization_id,
x.child_transaction_id
from
(
select
rt.transaction_id parent_transaction_id,
rt.organization_id,
connect_by_root rt.transaction_id child_transaction_id,
connect_by_isleaf isleaf
from
rcv_transactions rt
connect by
prior rt.parent_transaction_id=rt.transaction_id
start with
rt.transaction_id in (select ms.rcv_transaction_id from mtl_supply ms where ms.supply_type_code='RECEIVING' and ms.to_organization_id in (select o.organization_id from o)) and
nvl(rt.consigned_flag,'N')='N'
) x
where
x.isleaf=1
) rt,
rcv_accounting_events rae,
rcv_transactions rt_deliver,
rcv_transactions rt_correct
where
ms.rcv_transaction_id=rt.child_transaction_id and
ms.to_organization_id=rt.organization_id and
rt.parent_transaction_id=rae.rcv_transaction_id and
rt.organization_id=rae.organization_id and
ms.po_line_location_id=plla.line_location_id(+) and
ms.rcv_transaction_id=rt_deliver.parent_transaction_id(+) and
rt_deliver.transaction_type(+)='DELIVER' and
rt_deliver.transaction_id=rt_correct.parent_transaction_id(+) and
rt_correct.transaction_type(+)='CORRECT'
group by
ms.to_organization_id,
ms.item_id,
ms.destination_type_code,
ms.po_header_id,
ms.po_line_id,
ms.po_line_location_id,
ms.po_distribution_id,
ms.po_release_id,
ms.shipment_header_id,
ms.shipment_line_id,
ms.rcv_transaction_id,
ms.to_org_primary_quantity
) rs,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
rs.shipment_header_id=rsh.shipment_header_id and
rs.shipment_line_id=rsl.shipment_line_id and
rsl.source_document_code<>'REQ' and
rs.po_distribution_id=pda.po_distribution_id(+)
union all
select distinct
rae.organization_id,
rae.inventory_item_id,
pda.destination_type_code,
rae.po_header_id,
rae.po_line_id,
rae.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(case when rt.transaction_type in ('RECEIVE','MATCH') or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RECEIVE' then -rt.primary_quantity when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RETURN TO VENDOR' then rt.primary_quantity else 0 end,3) quantity,
round(round(decode(sign(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),1,-abs(rae.primary_quantity),-1,abs(rae.primary_quantity),rae.primary_quantity),3)*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)*rt.source_doc_quantity/rt.primary_quantity,2) amount,
0 adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
oap.period_name=:period_name and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type<>'DELIVER' and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.transaction_id=rae.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.reference3=pda.po_distribution_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
union all
select
mmt.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(sum(mmt.primary_quantity),3) quantity,
round(sum(mmt.primary_quantity*rt.source_doc_quantity/rt.primary_quantity*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
mtl_material_transactions mmt,
rcv_parameters rp,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
oap.period_name=:period_name and
oap.organization_id=mmt.organization_id and
mmt.transaction_date>=oap.schedule_close_date+1 and
mmt.transaction_source_type_id=1 and
mmt.organization_id=rp.organization_id and
mmt.distribution_account_id=rp.receiving_account_id and
mmt.rcv_transaction_id=rt.transaction_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id
group by
rt.transaction_id,
mmt.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
wta.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(case when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='DELIVER' then rt.primary_quantity when rt.transaction_type='RETURN TO RECEIVING' or rt.transaction_type='CORRECT' and rt_parent.transaction_type in ('RETURN TO RECEIVING','MATCH') then -rt.primary_quantity else 0 end,3) quantity,
round(-sum(wta.base_transaction_value),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
wip_transaction_accounts wta,
rcv_parameters rp,
wip_transactions wt,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
oap.period_name=:period_name and
oap.organization_id=wta.organization_id and
wta.transaction_date>=oap.schedule_close_date+1 and
wta.accounting_line_type in (4,5) and
wta.organization_id=rp.organization_id and
wta.reference_account=rp.receiving_account_id and
wta.transaction_id=wt.transaction_id and
wt.transaction_date>=oap.schedule_close_date+1 and
wt.rcv_transaction_id=rt.transaction_id and
wt.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id and
pda.destination_type_code<>'EXPENSE' and
wta.wip_entity_id=pda.wip_entity_id
group by
rt.transaction_id,
rt.transaction_type,
rt_parent.transaction_type,
rt.primary_quantity,
wta.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
wcti.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(sum(wcti.primary_quantity),3) quantity,
round(sum(wcti.primary_quantity*rt.source_doc_quantity/rt.primary_quantity*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
wip_cost_txn_interface wcti,
rcv_parameters rp,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
oap.period_name=:period_name and
oap.organization_id=wcti.organization_id and
wcti.transaction_date>=oap.schedule_close_date+1 and
wcti.transaction_type=3 and
wcti.organization_id=rp.organization_id and
wcti.receiving_account_id=rp.receiving_account_id and
wcti.rcv_transaction_id=rt.transaction_id and
wcti.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id and
pda.destination_type_code<>'EXPENSE' and
wcti.wip_entity_id=pda.wip_entity_id
group by
rt.transaction_id,
wcti.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
rt.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
0 quantity,
round(-sum(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_parameters rp,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
oap.period_name=:period_name and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type='DELIVER' and
rt.organization_id=rp.organization_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.code_combination_id=rp.receiving_account_id and
rrsl.reference3=pda.po_distribution_id and
rt.po_line_location_id=pda.line_location_id and
pda.destination_type_code<>'EXPENSE' and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
group by
rt.transaction_id,
rt.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select distinct
rae.organization_id,
rae.inventory_item_id,
pda.destination_type_code,
rae.po_header_id,
rae.po_line_id,
rae.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
0 quantity,
0 amount,
round(case when rt.transaction_type in ('RECEIVE','MATCH') or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RECEIVE' then -rt.primary_quantity when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RETURN TO VENDOR' then rt.primary_quantity else 0 end*
(nvl(rt_deliver.po_unit_price,0)*nvl(rt_deliver.currency_conversion_rate,1)*rt_deliver.source_doc_quantity/rt_deliver.primary_quantity-nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)*rt.source_doc_quantity/rt.primary_quantity),2) adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_transactions rt_deliver,
rcv_parameters rp,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
oap.period_name=:period_name and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type<>'DELIVER' and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.transaction_id=rt_deliver.parent_transaction_id and
rt_deliver.transaction_type='DELIVER' and
rt_deliver.po_unit_price<>rt.po_unit_price and
rt_deliver.transaction_date>=oap.schedule_close_date+1 and
rt.organization_id=rp.organization_id and
rp.retroprice_adj_account_id is null and
rt.transaction_id=rae.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.reference3=pda.po_distribution_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
) n
group by
n.organization_id,
n.inventory_item_id,
n.destination_type_code,
n.po_header_id,
n.po_line_id,
n.po_line_location_id,
n.po_release_id,
n.project_id,
n.receipt_num,
n.shipment_header_id,
n.wip_entity_id,
n.bom_resource_id
having
abs(sum(nvl(n.quantity,0)+nvl(n.amount,0)))>.01
) r,
o,
org_acct_periods oap,
rcv_parameters rp
where
r.organization_id=o.organization_id and
o.organization_id=oap.organization_id and
oap.period_name=:period_name and
o.organization_id=rp.organization_id
group by
oap.period_name,
o.ledger_id,
rp.receiving_account_id
) x,
gl_ledgers gl,
gl_code_combinations gcc
where
x.ledger_id=gl.ledger_id and
x.code_combination_id=gcc.code_combination_id
group by
x.period_name,
gl.name
&group_by_segments
&having_clause
order by
x.period_name,
gl.name
&group_by_segments
