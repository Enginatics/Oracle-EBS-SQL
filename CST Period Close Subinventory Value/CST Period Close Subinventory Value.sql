/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Period Close Subinventory Value
-- Description: Summary report that lists selected operating units with corresponding sub inventory code and Inventory value on a historic basis.
-- Excel Examle Output: https://www.enginatics.com/example/cst-period-close-subinventory-value/
-- Library Link: https://www.enginatics.com/reports/cst-period-close-subinventory-value/
-- Run Report: https://demo.enginatics.com/

with oap as (
select
oap.period_name,
ood.organization_code,
ood.organization_name,
oap.schedule_close_date,
oap.period_start_date,
ood.organization_id,
oap.acct_period_id
from
gl_ledgers gl,
org_organization_definitions ood,
org_acct_periods oap
where
1=1 and
oap.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
gl.ledger_id=ood.set_of_books_id and
ood.organization_id=oap.organization_id and
oap.open_flag='N' and
oap.summarized_flag='Y'
)
select
cpcs.period_name period,
cpcs.schedule_close_date close_date,
cpcs.organization_name organization,
cpcs.organization_code,
cpcs.subinventory_code subinventory,
nvl(msi.description,xxen_util.meaning('1','CST_PER_CLOSE_MISC',700)) description,
ccg.cost_group,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
&category_columns
cpcs.rollback_value value,
cpcs.rollback_quantity quantity,
cpcs.rollback_value/xxen_util.zero_to_null(cpcs.rollback_quantity) item_cost,
&last_po_columns
from
(
select
sum(cpcs.rollback_quantity) rollback_quantity,
sum(cpcs.rollback_value) rollback_value,
oap.period_name,
oap.schedule_close_date,
oap.organization_code,
oap.organization_name,
cpcs.subinventory_code,
cpcs.cost_group_id,
cpcs.inventory_item_id,
cpcs.organization_id
from
oap,
cst_period_close_summary cpcs
where
oap.acct_period_id=cpcs.acct_period_id and
oap.organization_id=cpcs.organization_id
group by
oap.period_name,
oap.schedule_close_date,
oap.schedule_close_date,
oap.organization_code,
oap.organization_name,
cpcs.subinventory_code,
cpcs.cost_group_id,
cpcs.inventory_item_id,
cpcs.organization_id
) cpcs,
mtl_secondary_inventories msi,
mtl_system_items_vl msiv,
(select mdcs.category_set_id from mtl_default_category_sets mdcs where mdcs.functional_area_id=5) mdcs,
cst_cost_groups ccg,
(
select distinct
max(decode(mtt.transaction_type_name,'PO Receipt',mmt.actual_cost)) keep (dense_rank last order by decode(mtt.transaction_type_name,'PO Receipt',mmt.transaction_date)) over (partition by mmt.organization_id,mmt.inventory_item_id,mmt.subinventory_code) last_purchase_price,
max(decode(mtt.transaction_type_name,'PO Receipt',mmt.transaction_date)) over (partition by mmt.organization_id,mmt.inventory_item_id,mmt.subinventory_code) last_po_receipt_date,
max(decode(mtt.transaction_type_name,'Miscellaneous receipt',mmt.transaction_date)) over (partition by mmt.organization_id,mmt.inventory_item_id,mmt.subinventory_code) last_misc_receipt_date,
mmt.organization_id,
mmt.inventory_item_id,
mmt.subinventory_code
from
oap,
mtl_transaction_types mtt,
mtl_material_transactions mmt
where
'&show_last_po_details'='Y' and
mtt.transaction_type_name in ('PO Receipt','Miscellaneous receipt') and
mtt.transaction_type_id=mmt.transaction_type_id and
oap.schedule_close_date>=mmt.transaction_date
) mmt
where
cpcs.organization_id=msi.organization_id(+) and
cpcs.subinventory_code=msi.secondary_inventory_name(+) and
cpcs.cost_group_id=ccg.cost_group_id(+) and
cpcs.organization_id=msiv.organization_id(+) and
cpcs.inventory_item_id=msiv.inventory_item_id(+) and
cpcs.inventory_item_id=mmt.inventory_item_id(+) and
cpcs.organization_id=mmt.organization_id(+) and
cpcs.subinventory_code=mmt.subinventory_code(+)
order by
organization_code,
subinventory,
cost_group,
item,
close_date desc