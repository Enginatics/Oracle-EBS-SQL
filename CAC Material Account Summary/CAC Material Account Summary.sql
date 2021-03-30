/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Material Account Summary
-- Description: Report to get the material accounting entries for each item, organization, subinventory with amounts.  Including Ship From and Ship To information for inter-org transfers.  This report includes all material transactions but to keep the report smaller it does not displays WIP job information, such as WIP Accounting Class, Class Description, Assembly Number, Assembly Description or Job Order Number.
Use the Show Subinventory parameter to reduce the size of this report, as needed.  If you choose Yes you get the Subinventory Code, if you choose No you only get the Accounting Line Type for inventory, (Inventory valuation) thus greatly reducing the size of this report.

/* +=============================================================================+
-- |  Copyright 2009-20 Douglas Volz Consulting, Inc.                            |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_dist_xla_sum_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- starting transaction date for PII related transactions, mandatory
-- |  p_trx_date_to      -- ending transaction date for PII related transactions, mandatory
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_show_subinv      -- display the subinventory code or don't display the subinventory code.
-- |                        Enter a 'Y' or 'N' value.  Mandatory.  Use to limit the report size.
-- |
-- |  Description:
-- |  Report to get the material accounting entries for each item, organization and subinventory
-- |  with amounts.  Including Ship From and Ship To information for inter-org
-- |  transfers.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.19    22 Apr 2020 Douglas Volz    Put Item Type lookup code into inner queries, to avoid
-- |                                     creating outer joins errors to multiple tables (12.1.3). 
-- |                                     Put item master back into inner queries for the item type
-- |                                     lookup and changed FOB point into a lookup code for languages.
-- | 1.20    03 May 2020 Douglas Volz    Can have multiple mta rows with the same CCID, quantity
-- |                                     and accounting line type.  To avoid summing incorrectly, 
-- |                                     need to count the number of rows and then divide into the
-- |                                     total quantity sum.  However, for Standard Cost Updates,
-- |                                     use the quantity adjusted.
-- | 1.21    14 May 2020 Douglas Volz    Use multi-language table for UOM_Code, mtl_units_of_measure_vl
-- | 1.22    17 May 2020 Douglas Volz    Remove inner query group by, not needed.
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-material-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-material-account-summary/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mtl_acct.organization_code Org_Code,
	haou2_from.name From_OU,
	haou2_to.name To_OU,
	nvl((select	ml2.meaning
	     from	mfg_lookups ml2
	     where	ml2.lookup_type  = 'MTL_FOB_POINT'
	     and	ml2.lookup_code  = mtl_acct.fob_point),'') FOB_Point,
	mtl_acct.ship_from_org Ship_From_Org,
	mtl_acct.ship_to_org Ship_To_Org,
	ah.period_name Period_Name,
	&segment_columns
	mtl_acct.item_number Item_Number,
	mtl_acct.item_description Item_Description,
	mtl_acct.item_type Item_Type,
	mtl_acct.category1 "&p_category_set1",
	mtl_acct.category2 "&p_category_set2",
	-- End revision for version 1.12
	mtl_acct.acct_line_type Accounting_Line_Type,
	mtl_acct.transaction_type_name Transaction_Type,
	mtl_acct.transaction_source Transaction_Source,	
	mtl_acct.subinventory_code Subinventory,
        mtl_acct.primary_uom_code UOM_Code,
	sum(mtl_acct.primary_quantity) Quantity,
	gl.currency_code Curr_Code,
	sum(mtl_acct.Matl_Amount) Material_Amount,
	sum(mtl_acct.Matl_Ovhd_Amount) Material_Overhead_Amount,
 	sum(mtl_acct.Resource_Amount) Resource_Amount,
	sum(mtl_acct.OSP_Amount) Outside_Processing_Amount,
	sum(mtl_acct.Overhead_Amount) Overhead_Amount,
	sum(mtl_acct.mta_amount) Amount
from	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	hr_organization_information hoi_from,
	hr_all_organization_units_vl haou_from, -- inv_organization_id
	hr_all_organization_units_vl haou2_from, -- operating unit
	hr_organization_information hoi_to,
	hr_all_organization_units_vl haou_to, -- inv_organization_id
	hr_all_organization_units_vl haou2_to, -- operating unit
	gl_ledgers gl,
	xla.xla_transaction_entities ent,  -- apps synonym not working
	xla_events xe,
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al,
	-- ==========================================================================
	-- Use this inline table to fetch the WIP and non-WIP material transactions
	-- ==========================================================================
	(
	 select	mp.organization_code organization_code,
		-- Fix for version 1.6
		-- Revision for version 1.5
		decode(mmt.transaction_action_id,
			 3, mp_mmt_org.organization_code,  -- Direct Org Transfer, txn_id 3
			 9, mp_mmt_org.organization_code,  -- Logical Intercompany Sales Issue, txn_id 11
			10, mp_xfer_org.organization_code, -- Logical Intercompany Shipment Receipt, txn_id 10
			12, mp_xfer_org.organization_code, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
			13, mp_mmt_org.organization_code,  -- Logical Intercompany Receipt Return, txn_id 13
			15, mp_xfer_org.organization_code, -- Logical Intransit Receipt, txn_id 76
			-- Revision for version 1.11
			17, mp_xfer_org.organization_code, -- Logical Expense Requisition Receipt, txn_id 27
			21, mp_mmt_org.organization_code,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
			22, mp_mmt_org.organization_code,  -- Logical Intransit Shipment, tnx_id 60, 65
		    '') ship_from_org,
                decode(mmt.transaction_action_id,
			 3, mp_xfer_org.organization_code, -- Direct Org Transfer, txn_id 3
			 9, mp_xfer_org.organization_code, -- Logical Intercompany Sales Issue, txn_id 11
			10, mp_mmt_org.organization_code,  -- Logical Intercompany Shipment Receipt, txn_id 10
			12, mp_mmt_org.organization_code,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
			13, mp_xfer_org.organization_code, -- Logical Intercompany Receipt Return, txn_id 13
			15, mp_mmt_org.organization_code,  -- Logical Intransit Receipt, txn_id 76
			-- Revision for version 1.11
			17, mp_mmt_org.organization_code,  -- Logical Expense Requisition Receipt, txn_id 27
			21, mp_xfer_org.organization_code, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
			22, mp_xfer_org.organization_code, -- Logical Intransit Shipment, tnx_id 60, 65
		    '') ship_to_org,
		-- End revision for version 1.5
		-- End revision for version 1.6 
		mp.organization_id organization_id,
		-- Revision for version 1.8
                decode(mmt.transaction_action_id,
			 3, mp_mmt_org.organization_id,  -- Direct Org Transfer, txn_id 3
			 9, mp_mmt_org.organization_id,  -- Logical Intercompany Sales Issue, txn_id 11
			10, mp_xfer_org.organization_id, -- Logical Intercompany Shipment Receipt, txn_id 10
			12, mp_xfer_org.organization_id, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
			13, mp_mmt_org.organization_id,  -- Logical Intercompany Receipt Return, txn_id 13
			15, mp_xfer_org.organization_id, -- Logical Intransit Receipt, txn_id 76
			-- Revision for version 1.11
			17, mp_xfer_org.organization_id, -- Logical Expense Requisition Receipt, txn_id 27	
			21, mp_mmt_org.organization_id,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
			22, mp_mmt_org.organization_id,  -- Logical Intransit Shipment, tnx_id 60, 65
			mta.organization_id) ship_from_org_id,
		decode(mmt.transaction_action_id,
			 3, mp_xfer_org.organization_id, -- Direct Org Transfer, txn_id 3
			 9, mp_xfer_org.organization_id, -- Logical Intercompany Sales Issue, txn_id 11
			10, mp_mmt_org.organization_id,  -- Logical Intercompany Shipment Receipt, txn_id 10
			12, mp_mmt_org.organization_id,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
			13, mp_xfer_org.organization_id, -- Logical Intercompany Receipt Return, txn_id 13
			15, mp_mmt_org.organization_id,  -- Logical Intransit Receipt, txn_id 76
			-- Revision for version 1.11
			17, mp_mmt_org.organization_id,  -- Logical Expense Requisition Receipt, txn_id 27
			21, mp_xfer_org.organization_id, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
			22, mp_xfer_org.organization_id, -- Logical Intransit Shipment, tnx_id 60, 65
			mta.organization_id) ship_to_org_id,
		mmt.fob_point fob_point,
		-- End revision for version 1.8
		mmt.acct_period_id acct_period_id,
		mta.reference_account reference_account,
		-- Revision for version 1.7, comment this out, for Release 12
		mta.inv_sub_ledger_id inv_sub_ledger_id,
		mta.inventory_item_id,
		msiv.concatenated_segments item_number,
		msiv.description item_description,
		-- Revision for version 1.6 and 1.19, add in item type
		fcl.meaning item_type,
		-- Revision for version 1.12
		nvl((select	max(mc.category_concat_segs)
		     from	mtl_categories_v mc,
				mtl_item_categories mic,
				mtl_category_sets_b mcs,
				mtl_category_sets_tl mcs_tl
		     where	mic.category_set_id         = mcs.category_set_id
		     and	2=2
		     and	mic.inventory_item_id       = mta.inventory_item_id
		     and	mic.organization_id         = mta.organization_id
		     and	mc.category_id              = mic.category_id
		     and	mcs.category_set_id         = mcs_tl.category_set_id
		     and	mcs_tl.language             = userenv('lang')
		   ),'') category1,
		nvl((select	max(mc.category_concat_segs)
		     from	mtl_categories_v mc,
				mtl_item_categories mic,
				mtl_category_sets_b mcs,
				mtl_category_sets_tl mcs_tl
		     where	mic.category_set_id         = mcs.category_set_id
		     and	3=3 
		     and	mic.inventory_item_id       = mta.inventory_item_id
		     and	mic.organization_id         = mta.organization_id
		     and	mc.category_id              = mic.category_id
		     and	mcs.category_set_id         = mcs_tl.category_set_id
		     and	mcs_tl.language             = userenv('lang')
		   ),'') category2,
		-- End revision for version 1.12
		ml.meaning acct_line_type,
		mtt.transaction_type_name transaction_type_name,
		-- Revision for version 1.13
		mtst.transaction_source_type_name transaction_source,
		-- Revision for version 1.15
		decode(:p_show_subinv,                                                                    -- p_show_subinv
			'N',  decode(mta.accounting_line_type, 
				 7, ml.meaning, -- WIP
				14, ml.meaning, -- Intransit
				 1, ml.meaning, -- Subinventory / Inventory valuation
				null),
			'Y',
			decode(mta.accounting_line_type, 7, ml.meaning, 14, ml.meaning, 1,
			 decode(mmt.transaction_action_id,
				 2, decode(sign (mta.primary_quantity),
					-1, mmt.subinventory_code,
					 1, mmt.transfer_subinventory,
					mmt.subinventory_code
	                        	  ),
				 3, decode(mmt.organization_id,
					mta.organization_id, mmt.subinventory_code,
					mmt.transfer_subinventory
					  ),
				21, decode(sign (mta.primary_quantity),
					-1, mmt.subinventory_code,
					 1, mmt.transfer_subinventory,
					mmt.subinventory_code
					  ),
				22, decode(sign (mta.primary_quantity),
					-1, mmt.subinventory_code,
					 1, mmt.transfer_subinventory,
					mmt.subinventory_code
					  ),
				28, decode(sign (mta.primary_quantity),
					-1, mmt.subinventory_code,
					 1, mmt.transfer_subinventory,
					mmt.subinventory_code
					  ),
				mmt.subinventory_code
				-- Fix for version 1.6
				-- )
		                ) 
			      ),
			decode(mta.accounting_line_type, 
				 7, ml.meaning, -- WIP
				14, ml.meaning, -- Intransit
				 1, ml.meaning, -- Subinventory / Inventory valuation
				null)		
		      ) subinventory_code,
		-- End revision for version 1.15
		-- Revision for version 1.21
		muomv.uom_code primary_uom_code,
		-- Revision for version 1.20, logic fix for the transaction quantity
		decode(mmt.transaction_action_id, 
			24, mmt.quantity_adjusted,
			mta.primary_quantity/
				(select count(*)
					from	mtl_transaction_accounts mta2
					where	mta2.transaction_id       = mta.transaction_id
					and	mta2.reference_account    = mta.reference_account
					and	mta2.accounting_line_type = mta.accounting_line_type)
		) primary_quantity,
		-- Revision for version 1.13
		decode(mta.cost_element_id,
			1, mta.base_transaction_value,
			0) Matl_Amount,
		decode(mta.cost_element_id,
			2, mta.base_transaction_value,
			0) Matl_Ovhd_Amount,
	 	decode(mta.cost_element_id,
			3, mta.base_transaction_value,
			0) Resource_Amount,
		decode(mta.cost_element_id,
			4, mta.base_transaction_value,
			0) OSP_Amount,
		decode(mta.cost_element_id,
			5, mta.base_transaction_value,
			0) Overhead_Amount,
		-- End revision for version 1.13
		mta.base_transaction_value mta_amount
	 from	mtl_transaction_accounts mta,
		mtl_material_transactions mmt,
		mtl_transaction_types mtt,
		mtl_system_items_vl msiv,
		-- Revision for version 1.21
		mtl_units_of_measure_vl muomv,
		-- Revision for version 1.13
		mtl_txn_source_types mtst,
		mtl_parameters mp,
		-- Fix for version 1.6
		-- Revision for version 1.5
		-- mtl_parameters mp_owning_org, -- Owning Org
		-- End fix for version 1.6
		mtl_parameters mp_xfer_org,   -- Transfer Org
		mtl_parameters mp_mmt_org,    -- MMT Org
		-- End revision for version 1.5
		-- Revision for version 1.19
		fnd_common_lookups fcl,
		mfg_lookups ml
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 where	mta.transaction_id             = mmt.transaction_id
	 and	mmt.transaction_type_id        = mtt.transaction_type_id
	 and	msiv.organization_id           = mta.organization_id
	 and	msiv.inventory_item_id         = mta.inventory_item_id
	 and	msiv.primary_uom_code          = muomv.uom_code
	 and	mp.organization_id             = mta.organization_id
	 -- Fix for version 1.6
	 -- Revision for version 1.5
	 -- and	mp_owning_org.organization_id  = nvl(mmt.owning_organization_id, mta.organization_id)
	 -- and	mp_xfer_org.organization_id    = nvl(mmt.transfer_organization_id, mta.organization_id)
	 -- and	mp_mmt_org.organization_id     = mmt.organization_id
	 -- End revision for version 1.5
	 and	mp_xfer_org.organization_id    = nvl(mmt.transfer_organization_id, mmt.organization_id)
	 and	mp_mmt_org.organization_id     = mmt.organization_id
	 -- End fix for version 1.6
	 -- ========================================================
	 -- Material Transaction date and accounting code joins
	 -- ========================================================
	 and	4=4
	 -- ========================================================
	 -- Omit WIP transaction sources for material transactions 
	 -- ========================================================
	 -- Revision for version 1.14
	 -- Join to mta instead of mmt for faster performance
	 -- Revision for version 1.13
	 -- and	mmt.transaction_source_type_id = mtst.transaction_source_type_id
	 and	mta.transaction_source_type_id = mtst.transaction_source_type_id
	 -- End of revision for version 1.14
	 and	fcl.lookup_code (+)            = msiv.item_type
	 and	fcl.lookup_type (+)            = 'ITEM_TYPE'
	 and	ml.lookup_type                 = 'CST_ACCOUNTING_LINE_TYPE'
	 and	ml.lookup_code                 = mta.accounting_line_type
	) mtl_acct
-- ========================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ========================================================
where	hoi.org_information_context      = 'Accounting Information'
and	hoi.organization_id              = mtl_acct.organization_id
and	hoi.organization_id              = haou.organization_id   -- this gets the organization name
and	haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                              -- p_item_number, p_org_code, p_operating_unit, p_ledger
-- ========================================================
-- Revision for version 1.8
-- Joins for From and To Operating_Units
-- ========================================================
and	hoi_from.org_information_context = 'Accounting Information'
and	hoi_from.organization_id         = mtl_acct.ship_from_org_id
and	hoi_from.organization_id         = haou_from.organization_id   -- this gets the organization name
and	haou2_from.organization_id       = to_number(hoi_from.org_information3) -- this gets the operating unit id
and	hoi_to.org_information_context   = 'Accounting Information'
and	hoi_to.organization_id           = mtl_acct.ship_to_org_id
and	hoi_to.organization_id           = haou_to.organization_id   -- this gets the organization name
and	haou2_to.organization_id         = to_number(hoi_to.org_information3) -- this gets the operating unit idi
-- ========================================================
-- SLA table joins to get the exact account numbers
-- ========================================================
and	ent.entity_code                  = 'MTL_ACCOUNTING_EVENTS'
and	ent.application_id               = 707
and	xe.application_id                = ent.application_id
and	xe.event_id                      = xdl.event_id
and	ah.entity_id                     = ent.entity_id
and	ah.ledger_id                     = ent.ledger_id
and	ah.application_id                = al.application_id
and	ah.application_id                = 707
and	ah.event_id                      = xe.event_id
and	ah.ae_header_id                  = al.ae_header_id
and	al.application_id                = ent.application_id
and	al.ledger_id                     = ah.ledger_id
and	al.ae_header_id                  = xdl.ae_header_id
and	al.ae_line_num 	                 = xdl.ae_line_num
and	xdl.application_id               = ent.application_id
and	xdl.source_distribution_type     = 'MTL_TRANSACTION_ACCOUNTS'
and	mtl_acct.inv_sub_ledger_id       = xdl.source_distribution_id_num_1
-- Revision for version 1.17, outer join for CCIDs
and	gcc.code_combination_id (+)      = al.code_combination_id
-- ==========================================================
group by 
	nvl(gl.short_name, gl.name),
	haou2.name,
	mtl_acct.organization_code,
	haou2_from.name, -- From_OU
	haou2_to.name, -- To_OU
	mtl_acct.fob_point, -- FOB_Point
	mtl_acct.ship_from_org,
	mtl_acct.ship_to_org,
	ah.period_name,
	&segment_columns_grp
	mtl_acct.item_number,
	mtl_acct.item_description,
	mtl_acct.item_type,
	mtl_acct.category1,
	mtl_acct.category2,
	mtl_acct.subinventory_code,
	mtl_acct.acct_line_type,
	mtl_acct.transaction_type_name,
	mtl_acct.transaction_source,
	mtl_acct.primary_uom_code,
	gl.currency_code
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating_Unit
	mtl_acct.organization_code, -- Org_Code
	ah.period_name, -- Period_Name
	&segment_columns_grp
	mtl_acct.item_number, -- Item_Number
	mtl_acct.acct_line_type,
	mtl_acct.transaction_type_name, -- Transaction_Type	
	mtl_acct.subinventory_code -- Subinventory