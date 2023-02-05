/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing Material Accounting Transactions
-- Description: Report to find material accounting entries where the material transaction's costed flag says that the transaction has been costed but the material accounting entries do not exist.  If you enter Yes for "Only Costed Items" the report ignores material transactions where the transaction item cost does not exist (null value) or where the item's inventory asset setting in the item master is set to No.  If you enter No for "Only Costed Items" the report includes material transactions where the item cost does not exist or where the item's inventory asset setting is set to No.  To get all transactions which are missing the material accounting entries, even for transactions where the transaction amounts are too small, set the "Only Costed Items" to No and the Minimum Transaction Amount to zero (0).  

Notes:
1)  For PO Receipts the Transaction Cost column displays the purchase order unit price
2)  For Cost Updates the Transaction Cost column displays the item cost differences between the old and new costs.
3)  For Pick Transactions, Move Order Transfers, Subinventory Transfers and Direct Transfers, the Transfer Transaction Id column indicates the second half of the transfer, for the receipt back into the receiving subinventory, which never has any material accounting entries.

Parameters:
Transaction Date From:  Starting transaction date, mandatory
Transaction Date:  Ending transaction date, mandatory
Minimum Transaction Amount:  The absolute smallest transaction amount to be reported
Only Costed Items:  Only include items where the item master asset flag is set to Yes and where the material transaction has a non-null item cost.
Category Set 1:  The first item category set to report, typically the Cost or Product Line Category Set
Category Set 2:  The second item category set to report, typically the Inventory Category Set
Item Number:  Specific item number you wish to report (optional)
Organization Code:  Specific inventory organization you wish to report (optional)
Operating Unit:  Operating Unit you wish to report, leave blank for all operating units (optional) 
Ledger:  general ledger you wish to report, leave blank for all ledgers (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc. 
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this  permission. 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  missing_material_accounting_transactions.sql
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     11 Nov 2009 Douglas Volz   Added Org Code and transaction ID
-- |  1.2     12 Nov 2009 Douglas Volz   Added item and description
-- |  1.3     06 Jan 2010 Douglas Volz   Made dates a parameter
-- |  1.4     12 Jan 2010 Douglas Volz   Added quantity and unit cost columns
-- |  1.5     14 Jul 2022 Douglas Volz   Added comparison to WIP material accounting
-- |  1.6     19 Jul 2022 Douglas Volz   Modify to be run for all material transactions
-- |  1.7     20 Jul 2022 Douglas Volz   Add parameter for only costed items and transactions.
-- |  1.8     21 Jul 2022 Douglas Volz   Added transaction cost, WIP job and job status
-- |  1.9     23 Jul 2022 Douglas Volz   Added Ledger and Operating Unit columns.
-- |  1.10    25 Jul 2022 Douglas Volz   Added transfer transaction id column
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-missing-material-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	mtst.transaction_source_type_name Transaction_Source,
	mtt.transaction_type_name Transaction_Type,
	-- Revision for v1.8
	(select we.wip_entity_name
	 from wip_entities we
	 where we.wip_entity_id = mmt.transaction_source_id
	 and mmt.transaction_source_type_id = 5) WIP_Job,
	(select ml.meaning
	 from mfg_lookups ml, wip_discrete_jobs wdj
	 where wdj.wip_entity_id = mmt.transaction_source_id
	 and	ml.lookup_type       = 'WIP_JOB_STATUS'
	 and	ml.lookup_code      = wdj.status_type
	 and mmt.transaction_source_type_id = 5) Job_Status,
	-- End revision for v1.8
	mmt.transaction_id Transaction_Id,
	-- Revision for version 1.10
	mmt.transfer_transaction_id Transfer_Transaction_Id,
	mmt.transaction_date Transaction_Date,
	mmt.creation_date Creation_Date,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
&category_columns
	fcl.meaning Item_Type,
	fl1.meaning Allow_Costs,
	fl2.meaning Inventory_Asset,
	fl3.meaning Material_Transaction_Enabled,
	muomv.uom_code UOM_Code,
	decode(mmt.transaction_type_id,
		24, mmt.quantity_adjusted,
		mmt.primary_quantity) Primary_or_Adjusted_Quantity,
	-- Revision for v1.8
	mmt.transaction_cost Transaction_Cost,
	decode(mmt.transaction_type_id,
		24, mmt.transaction_cost,
		mmt.new_cost)  Unit_Cost,
	round(sum(decode(mmt.transaction_type_id,
			24, mmt.quantity_adjusted,
			mmt.primary_quantity) * 
		  decode(mmt.transaction_type_id,
			24, mmt.transaction_cost,
			mmt.new_cost)
		 ),2) Extended_Material_Amount,
	(select	cct.cost_type
	 from	cst_cost_types cct
	 where	cct.cost_type_id = mp.primary_cost_method) Cost_Method,
	(select	cic.item_cost cic
	 from	cst_item_costs cic
	 where	cic.inventory_item_id = mmt.inventory_item_id
	 and	cic.organization_id   = nvl(mmt.transfer_organization_id, mmt.organization_id)
	 and	cic.cost_type_id      = mp.primary_cost_method) Current_Item_Cost,
	mmt.error_code Error_Code,
	mmt.error_explanation Error_Explanation
from	mtl_material_transactions mmt,
	mtl_transaction_types mtt,
	mtl_txn_source_types mtst,
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	org_acct_periods oap,
	mtl_parameters mp,
	fnd_lookups fl1, -- allow costs, YES_NO
	fnd_lookups fl2, -- inventory_asset_flag, YES_NO
	fnd_lookups fl3, -- mtl_transactions_enabled_flag, YES_NO
	fnd_common_lookups fcl, -- Item Type
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where	mmt.transaction_type_id         = mtt.transaction_type_id
and	mmt.organization_id             = msiv.organization_id
and	mmt.inventory_item_id	        = msiv.inventory_item_id
and	msiv.primary_uom_code           = muomv.uom_code
and	mmt.transaction_source_type_id  = mtst.transaction_source_type_id
and	mp.organization_id	        = msiv.organization_id
and	oap.acct_period_id              = mmt.acct_period_id
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fl2.lookup_type                 = 'YES_NO'
and	fl2.lookup_code                 = msiv.inventory_asset_flag
and	fl3.lookup_type                 = 'YES_NO'
and	fl3.lookup_code                 = msiv.mtl_transactions_enabled_flag
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- ========================================================
-- Find missing accounting entries
-- ========================================================
-- Only get costed material transactions
and	mmt.costed_flag is null
-- Revision for version 1.7, put 'Only Costed Items' as a parameter
-- Ignore the items which are not an inventory asset
-- and	mmt.new_cost is not null
-- and	msiv.inventory_asset_flag = 'Y'
-- End revision for version 1.7
-- Ignore the half of the Pick Transactions, Move Order Transfers, Subinventory Transfers and Direct Transfers which are never costed.
-- The material accounting entries are only on the initial issue from the subinventory, not on the receipt back in.
-- and	(mmt.transaction_action_id not in (2,3,28) and mmt.primary_quantity > 0)
and mmt.transaction_id not in
	(select mmt2.transaction_id
	 from	mtl_material_transactions mmt2
	 where	mmt2.transaction_id  = mmt.transaction_id
	 and	mmt.primary_quantity > 0
	 and	mmt.transaction_action_id in (2,3,28)
	)
and not exists
	(select 'x'
	 from	mtl_transaction_accounts mta
	 where	mmt.transaction_id   = mta.transaction_id)
and	1=1                            -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
group by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating Unit  
	mp.organization_code,
	oap.period_name,
	mtst.transaction_source_type_name,
	mtt.transaction_type_name,
	-- Revision for v1.8
	mmt.transaction_source_id,
	mmt.transaction_source_type_id,
	-- End revision for v1.8
	mmt.transaction_id,
	-- Revision for version 1.10
	mmt.transfer_transaction_id,
	mmt.transaction_date,
	mmt.creation_date,
	msiv.concatenated_segments,
	msiv.description,
	msiv.inventory_item_id,
	msiv.organization_id,
	mmt.inventory_item_id,
	nvl(mmt.transfer_organization_id, mmt.organization_id),
	mmt.cost_update_id,
	mp.primary_cost_method,
	fcl.meaning, -- Item Type
	fl1.meaning, -- Allow Costs
	fl2.meaning, -- Inventory Asset
	fl3.meaning, -- Mtl Trx Enabled
	muomv.uom_code, -- UOM Code,
	decode(mmt.transaction_type_id,
		24, mmt.quantity_adjusted,
		mmt.primary_quantity), -- Primary_or_Adjusted_Quantity
	-- Revision for v1.8
	mmt.transaction_cost,
	decode(mmt.transaction_type_id,
		24, mmt.transaction_cost,
		mmt.new_cost), --  Unit_Cost
	mmt.error_code,
	mmt.error_explanation
having 	abs(round(sum(decode(mmt.transaction_type_id,
			24, mmt.quantity_adjusted,
			mmt.primary_quantity) * 
		  decode(mmt.transaction_type_id,
			24, mmt.transaction_cost,
			mmt.new_cost)
		 ),2)) >= :p_minimum_amount -- Extended_Material_Amount
order by 1,2,3,4,6,8