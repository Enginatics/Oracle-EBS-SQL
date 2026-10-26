/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing Material Accounting Transactions
-- Description: Report to find material accounting entries where the material transaction's costed flag says that the transaction has been costed but the material accounting entries do not exist. If you enter Yes for "Only Costed Items" the report ignores material transactions where the transaction item cost does not exist (null value) or where the item's inventory asset setting in the item master is set to No. If you enter No for "Only Costed Items" the report includes material transactions where the item cost does not exist or where the item's inventory asset setting is set to No. To get all transactions which are missing the material accounting entries, even for transactions where the transaction amounts are too small, set the "Only Costed Items" to No and the Minimum Transaction Amount to zero (0).
-- Notes:
-- 1) For PO Receipts the Transaction Cost column displays the purchase order unit price.
-- 2) For Cost Updates the Transaction Cost column displays the item cost differences between the old and new costs.
-- 3) The Item Cost column shows average or standard costs at the time and date of the transaction.
-- 4) For Pick Transactions, Move Order Transfers, Subinventory Transfers and Direct Transfers, the Transfer Transaction Id column indicates the second half of the transfer, for the receipt back into the receiving subinventory (which never has any material accounting entries).
-- / +=============================================================================+
-- -- | Copyright 2009 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.1 11 Nov 2009 Douglas Volz Added Org Code and transaction ID
-- -- | 1.2 12 Nov 2009 Douglas Volz Added item and description
-- -- | 1.3 06 Jan 2010 Douglas Volz Made dates a parameter
-- -- | 1.4 12 Jan 2010 Douglas Volz Added quantity and unit cost columns
-- -- | 1.5 14 Jul 2022 Douglas Volz Added comparison to WIP material accounting
-- -- | 1.6 19 Jul 2022 Douglas Volz Modify to be run for all material transactions
-- -- | 1.7 20 Jul 2022 Douglas Volz Add parameter for only costed items and transactions.
-- -- | 1.8 21 Jul 2022 Douglas Volz Added transaction cost, WIP job and job status
-- -- | 1.9 23 Jul 2022 Douglas Volz Added Ledger and Operating Unit columns.
-- -- | 1.10 25 Jul 2022 Douglas Volz Added transfer transaction id column
-- -- | 1.11 11 Jul 2023 Douglas Volz Fix for expense subinventories, remove tabs and restrict to only orgs you have access to.
-- -- | 1.12 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-missing-material-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
mtst.transaction_source_type_name transaction_source,
mtt.transaction_type_name transaction_type,
(select we.wip_entity_name from wip_entities we where mmt.transaction_source_type_id=5 and mmt.transaction_source_id=we.wip_entity_id) wip_job,
(select xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) from wip_discrete_jobs wdj where mmt.transaction_source_type_id=5 and mmt.transaction_source_id=wdj.wip_entity_id) job_status,
mmt.transaction_id,
mmt.transfer_transaction_id,
mmt.transaction_date,
mmt.creation_date,
msiv.concatenated_segments item_number,
msiv.description item_description,
&category_columns
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
xxen_util.yes(msiv.costing_enabled_flag) allow_costs,
xxen_util.yes(msiv.inventory_asset_flag) inventory_asset,
xxen_util.yes(msiv.mtl_transactions_enabled_flag) material_transaction_enabled,
msi.secondary_inventory_name subinventory_code,
msi.description subinventory_description,
msiv.primary_uom_code uom_code,
decode(mmt.transaction_type_id,24,mmt.quantity_adjusted,mmt.primary_quantity) primary_or_adjusted_quantity,
mmt.transaction_cost,
decode(mmt.transaction_type_id,24,mmt.transaction_cost,mmt.new_cost) item_cost,
round(decode(mmt.transaction_type_id,24,mmt.quantity_adjusted,mmt.primary_quantity)*decode(mmt.transaction_type_id,24,mmt.transaction_cost,mmt.new_cost),2) extended_inventory_amount,
(select cct.cost_type from cst_cost_types cct where mp.primary_cost_method=cct.cost_type_id) cost_method,
(select cic.item_cost from cst_item_costs cic where mmt.inventory_item_id=cic.inventory_item_id and nvl(mmt.transfer_organization_id,mmt.organization_id)=cic.organization_id and mp.primary_cost_method=cic.cost_type_id) current_item_cost,
mmt.error_code,
mmt.error_explanation
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
org_acct_periods oap,
mtl_system_items_vl msiv,
mtl_secondary_inventories msi
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mmt.organization_id and
mmt.costed_flag is null and
(mmt.primary_quantity<=0 or mmt.transaction_action_id not in (2,3,28)) and
not exists (select null from mtl_transaction_accounts mta where mmt.transaction_id=mta.transaction_id) and
abs(round(decode(mmt.transaction_type_id,24,mmt.quantity_adjusted,mmt.primary_quantity)*decode(mmt.transaction_type_id,24,mmt.transaction_cost,mmt.new_cost),2))>=:p_minimum_amount and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.transaction_source_type_id=mtst.transaction_source_type_id and
mmt.acct_period_id=oap.acct_period_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
mmt.organization_id=msi.organization_id and
mmt.subinventory_code=msi.secondary_inventory_name and
(msi.asset_inventory=1 or msi.asset_inventory=2 and mmt.transaction_source_type_id=1)
order by
ledger,
operating_unit,
org_code,
oap.period_name,
transaction_type,
mmt.transaction_id
