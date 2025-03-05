/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Transactions Summary
-- Description: Summary report of Inventory item movement including transaction type, source type, and transaction ID’s.
-- Excel Examle Output: https://www.enginatics.com/example/inv-material-transactions-summary/
-- Library Link: https://www.enginatics.com/reports/inv-material-transactions-summary/
-- Run Report: https://demo.enginatics.com/

select
x.count,
&proj_cols2
&org_cols2
&item_cols2
&show_subinv_cols2
&category_columns
x.transaction_action,
x.transaction_type,
x.source_type,
x.transaction_action_id,
x.transaction_type_id,
x.transaction_source_type_id
from
(
select
count(*) count,
&proj_cols
&org_cols
&item_cols
&show_subinv_cols
xxen_util.meaning(mmt.transaction_action_id,'MTL_TRANSACTION_ACTION',700) transaction_action,
mtt.transaction_type_name transaction_type,
mtst.transaction_source_type_name source_type,
mmt.transaction_action_id,
mmt.transaction_type_id,
mmt.transaction_source_type_id
from
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
(select msiv.* from mtl_system_items_vl msiv where '&show_item'='Y') msiv,
&mtl_subinventory
mtl_parameters mp,
mtl_parameters mp2,
pa_projects_all ppa,
pa_tasks pt,
pa_projects_all ppa2,
pa_tasks pt2,
pa_projects_all ppa3,
pa_tasks pt3
where
1=1 and
mmt.transaction_type_id=mtt.transaction_type_id and
mtt.transaction_source_type_id=mtst.transaction_source_type_id(+) and
mmt.organization_id=msiv.organization_id(+) and
mmt.inventory_item_id=msiv.inventory_item_id(+) and
mmt.organization_id=mp.organization_id(+) and
mmt.transfer_organization_id=mp2.organization_id(+) and
mmt.project_id=ppa.project_id(+) and
mmt.task_id=pt.task_id(+) and
mmt.source_project_id=ppa2.project_id(+) and
mmt.source_task_id=pt2.task_id(+) and
mmt.to_project_id=ppa3.project_id(+) and
mmt.to_task_id=pt3.task_id(+)
group by
&proj_group_cols
&org_group_by
&item_group_by
&subinv_group_by
mtt.transaction_type_name,
mtst.transaction_source_type_name,
mmt.transaction_action_id,
mmt.transaction_type_id,
mmt.transaction_source_type_id
order by
count(*) desc
)x