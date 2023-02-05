/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Deferred COGS Out-of-Balance
-- Description: Report to find the out-of-balance deferred COGS entries by organization, item and sales order number.  You do not need to run Create Accounting as this report uses the pre-Create Accounting material accounting entries.

/* +=============================================================================+
-- |  Copyright 2019 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_dist_xla_oob_dcogs_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- Starting accounting date for the transaction lines
-- |  p_trx_date_to      -- Ending accounting date for the transaction lines
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find the out-of-balance deferred COGS entries.  
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 Jun 2019 Douglas Volz   Initial Coding, based on version 1.25 for
-- |                                     the xxx_mtl_dist_xla_detail_rept.sql.
-- |  1.1     06 Feb 2020 Douglas Volz   Adding Operating Unit and Org Code parameters. 
-- |  1.2     20 Apr 2020 Douglas Volz   Changed to multi-lang views for the item
-- |                                     master, item category sets and operating units.   
-- |  1.3     26 Jul 2020 Douglas Volz   Removed Ledger, Operating Unit, subinventory,
-- |                                     Item Type, Subledger Accounting tables and joins. 
-- |                                     Removed Create Accounting from this report;
-- |                                     get the quantities from mmt, when the item
-- |                                     cost is zero the DCOGS entries are not
-- |                                     recorded on the COGS Recognition Txn Type.
-- |  1.4     29 Jun 2022 Douglas Volz   Added back Ledger, Operating Unit, item type, plus
-- |                                     added language tables for item status and UOM.   
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-deferred-cogs-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-deferred-cogs-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mtl_acct.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	mtl_acct.item_number Item_Number,
	mtl_acct.item_description Item_Description,
	fcl.meaning Item_Type,
	mtl_acct.inventory_item_status_code Item_Status,
	-- Revision for version 1.4
	ml1.meaning Make_Buy_Code,
	-- Revision for version 1.1
&category_columns
	ml2.meaning Accounting_Line_Type,
	-- Comment this out to net the two lines to zero
	-- mtl_acct.transaction_type_name Transaction_Type,
	mtl_acct.transaction_source Transaction_Source,
	mtl_acct.document_order_num Sales_Order_Number,
	decode(mtl_acct.transaction_source,
		'Internal order', mtl_acct.order_type,
		'RMA',mtl_acct.order_type,
		'Sales order', mtl_acct.order_type,
		null) Order_Type,
	mtl_acct.primary_uom_code UOM_Code,
	-- Net the SO line to see if it nets to zero
	sum(mtl_acct.primary_quantity) Net_Deferred_COGS_Quantity,
	gl.currency_code Curr_Code,
	sum(mtl_acct.mta_amount) Net_Deferred_COGS_Amount
from	gl_code_combinations gcc,
	-- Revision for version 1.4
	mfg_lookups ml1,
	mfg_lookups ml2,
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,   -- inv_organization_id
	hr_all_organization_units_vl haou2,  -- operating unit
	gl_ledgers gl,
	-- End revision for version 1.4
	-- Revision for version 1.3
	-- Remove subledger accounting tables and replace with oap
	org_acct_periods oap,
	-- ==========================================================================
	-- Use this inline table to fetch the DCOGS material transactions
	-- Do not group results, select by cost element id to avoid cross-joining quantities.
	-- ==========================================================================
	( 
	 -- ===========================================
	 -- Now get the deferred COGS accounting entries
	 -- ===========================================
	 select	mp.organization_code organization_code,
		mp.organization_id organization_id,
		mmt.acct_period_id acct_period_id,
		mta.reference_account reference_account,
		mta.inv_sub_ledger_id inv_sub_ledger_id,
		msiv.concatenated_segments item_number,
		msiv.description item_description,
		-- Revision for version 1.4
		msiv.inventory_item_status_code,
		msiv.planning_make_buy_code,
		msiv.item_type item_type,
		-- For category SQL
		msiv.inventory_item_id,
		-- End revision for version 1.4
 		mta.accounting_line_type accounting_line_type,
 		mtt.transaction_type_name transaction_type_name,
		mtst.transaction_source_type_name transaction_source,
		Decode(mmt.transaction_source_type_id,
			 1, (select poh.segment1                                              -- Purchase Order
			    from   po_headers_all poh
			    where  poh.po_header_id          = mmt.transaction_source_id),
			 2, (select ooh.order_number                                          -- Sales order
			     from   oe_order_headers_all ooh,
				    oe_order_lines_all ool
			     where  ooh.header_id             = ool.header_id
			     and    ool.line_id               = mmt.trx_source_line_id),
			 -- Revision for version 1.20, remove concatonated acct segments
			 -- 3, (select concatenated_segments -- Account
			 --    from   gl_code_combinations_kfv gcc
			 --    where  gcc.code_combination_id = mmt.distribution_account_id),
			 3, 'Account',                                               -- Account
			 4, (select ooh.order_number                                          -- Move order
			     from   ont.oe_order_headers_all ooh,
				    ont.oe_order_lines_all ool
			     where  ooh.header_id             = ool.header_id
			     and    ool.line_id               = mmt.trx_source_line_id),
			 5, (select we.wip_entity_name                                        -- Job or Schedule
			     from   wip_entities we
			     where  we.wip_entity_id          = mmt.transaction_source_id),
			 6, (select mgd.segment1                                              -- Account alias
			     from   mtl_generic_dispositions mgd
			     where  mgd.disposition_id        = mmt.transaction_source_id),
			 7, (select prh.segment1                                              -- Internal requisition
			     from   po_requisition_headers_all prh
			     where  prh.requisition_header_id = mmt.transaction_source_id),
			 8, (select ooh.order_number                                          -- Internal order
			     from   ont.oe_order_headers_all ooh,
				    ont.oe_order_lines_all ool
			     where  ooh.header_id             = ool.header_id
			     and    ool.line_id               = mmt.trx_source_line_id),
			 9, (select mcch.cycle_count_header_name                              -- Cycle count
			     from   mtl_cycle_count_headers mcch
			     where  mcch.cycle_count_header_id = mmt.transaction_source_id),
			10, (select mpi.description                                           -- Physical inventory
			     from   mtl_physical_inventories mpi
			     where  mpi.physical_inventory_id = mmt.transaction_source_id),
			11, (select description                                               -- Std cost update
			     from   cst_cost_updates ccu
			     where  ccu.cost_update_id        = mmt.cost_update_id),
			12, (select ooh.order_number                                          -- RMA
			     from   ont.oe_order_headers_all ooh,
				    ont.oe_order_lines_all ool
			     where  ooh.header_id             = ool.header_id
			     and    ool.line_id               = mmt.trx_source_line_id),
			13, decode(mmt.transaction_action_id,                                 -- Inventory
				 -- Revision for version 1.4 shorten document number
				 1, 'Issue from Stores',                                             -- Issue from stores
				 2, 'Sub Xfer',                                                      -- Subinventory transfer
				 3, 'Direct Xfer',                                                   -- Direct organization transfer
				 5, 'Planning Xfer',                                                 -- Planning transfer
				 6, 'Ownership Xfer',                                                -- Ownership xfer / consignment
				 9, (select ooh.order_number                                         -- Logical Intercompany Sales
				     from   ont.oe_order_headers_all ooh,
					    ont.oe_order_lines_all ool,
					    mtl_material_transactions mmt_parent
			 	     where  ooh.header_id             = ool.header_id
				     and    ool.line_id               = mmt_parent.trx_source_line_id
				     and    mmt.parent_transaction_id = mmt_parent.transaction_id),
				10, (select ooh.order_number                                         -- Logical Intercompany Receipt
				     from   ont.oe_order_headers_all ooh,
					    ont.oe_order_lines_all ool,
					    mtl_material_transactions mmt_parent
				     where  ooh.header_id             = ool.header_id
				     and    ool.line_id               = mmt_parent.trx_source_line_id
				     and    mmt.parent_transaction_id = mmt_parent.transaction_id),
				12, 'Intransit Receipt',                                             -- Intransit Receipt
				13, (select ooh.order_number                                         -- Logical Intercompany Sales Return
				     from   ont.oe_order_headers_all ooh,
					    ont.oe_order_lines_all ool
				     where  ooh.header_id             = ool.header_id
				     and    ool.line_id               = mmt.trx_source_line_id),
				14, (select ooh.order_number                                         -- Logical Intercompany Sales Return
				     from   ont.oe_order_headers_all ooh,
					    ont.oe_order_lines_all ool,
					    mtl_material_transactions mmt_parent
			 	     where  ooh.header_id             = ool.header_id
				     and    ool.line_id               = mmt_parent.trx_source_line_id
				     and    mmt.parent_transaction_id = mmt_parent.transaction_id),
				15, 'Logical Intransit Receipt',                                     -- Logical Intransit Receipt
				21, 'Intransit Shipment',                                            -- Intransit Shipment
				22, 'Logical Intransit Shipment',                                    -- Logical Intransit Shipment
				24, ' Average Cost Update',                                          -- Average Cost Update
				-- Revision for version 1.20
				27, 'Receipt into Stores',                                            -- Receipt into Stores
				mtst.transaction_source_type_name )) document_order_num,
		 nvl((  select ottt.name
		        from   oe_order_lines_all ool,
			      oe_order_headers_all ooh,
			      oe_transaction_types_tl ottt 
		        where  ooh.order_type_id	       = ottt.transaction_type_id
		        and    ooh.header_id		  = ool.header_id
		        and    mmt.trx_source_line_id	  = ool.line_id
		        and    ottt.language		  = userenv('lang')),'') order_type,
		 mmt.transaction_id,
		 mmt.parent_transaction_id,
		 decode(
		    mta.accounting_line_type,
		    7, 'WIP',
		    14, 'Intransit',
		    1, decode(
			 mmt.transaction_action_id,
			 2, decode(sign(mta.primary_quantity),
				   -1, mmt.subinventory_code,
				   1, mmt.transfer_subinventory,
				   mmt.subinventory_code),
			 3, decode(
			       mmt.organization_id,
			       mta.organization_id, mmt.subinventory_code,
			       mmt.transfer_subinventory),
			 21, decode(sign(mta.primary_quantity),
				    -1, mmt.subinventory_code,
				    1, mmt.transfer_subinventory,
				    mmt.subinventory_code),
			 22, decode(sign(mta.primary_quantity),
				    -1, mmt.subinventory_code,
				    1, mmt.transfer_subinventory,
				    mmt.subinventory_code),
			 28, decode(sign(mta.primary_quantity),
				    -1, mmt.subinventory_code,
				    1, mmt.transfer_subinventory,
				    mmt.subinventory_code),
			 mmt.subinventory_code
			 ),
		    mmt.subinventory_code)
		    subinventory_code,
		 -- Revision for version 1.4
		 -- msiv.primary_uom_code,
		 muomv.uom_code primary_uom_code,
		 -- Revision for version 1.3
		 -- decode(
		 --       mmt.transaction_action_id,
		 --       24, mmt.quantity_adjusted,
		 --       -- Revision for version 1.15
		 --       decode(mta.base_transaction_value, 0, mta.primary_quantity,
		 -- 	  abs(mta.primary_quantity) * decode(sign(mta.base_transaction_value), 1,1,-1))) primary_quantity,
		 -1 * mmt.primary_quantity primary_quantity,
		 mta.base_transaction_value mta_amount
	 from	mtl_transaction_accounts mta,
		mtl_material_transactions mmt,
		mtl_transaction_types mtt,
		mtl_system_items_vl msiv,
		-- Revision for version 1.4
		mtl_item_status_vl misv,
		mtl_units_of_measure_vl muomv,
		-- End revision for version 1.4
		mtl_txn_source_types mtst,
		mtl_parameters mp
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 -- If the item cost is zero the Credit to DCOGS is not
	 -- recorded to mtl_transaction_accounts.
	 where	mta.transaction_id (+)   = mmt.transaction_id
	 and	mta.accounting_line_type = 36 -- Deferred COGS
	 and	mmt.transaction_type_id  = mtt.transaction_type_id
	 and	mmt.organization_id      = msiv.organization_id
	 and	mmt.inventory_item_id    = msiv.inventory_item_id
	 and	mp.organization_id       = msiv.organization_id
	 and	mmt.transaction_source_type_id   = mtst.transaction_source_type_id
	 -- Revision for version 1.4
	 and	msiv.primary_uom_code           = muomv.uom_code
	 and	msiv.inventory_item_status_code = misv.inventory_item_status_code
	 -- End revision for version 1.4
	 -- ========================================================
	 -- Material Transaction date and accounting code joins
	 -- ========================================================
	 and	4=4	                -- p_trx_date_from and p_trx_date_to
	 -- ========================================================
	 -- Limit to only Sales Order and RMA material transactions
	 -- ========================================================
	 and	mmt.transaction_source_type_id in (2,12)
	 and	mta.transaction_source_type_id in (2,12)
	 and	mta.accounting_line_type = 36 -- Deferred COGS
	) mtl_acct
-- Revision for version 1.4
where	ml1.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                  = mtl_acct.planning_make_buy_code
and	ml2.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml2.lookup_code                  = mtl_acct.accounting_line_type
and	fcl.lookup_type (+)              = 'ITEM_TYPE'
and	fcl.lookup_code (+)              = mtl_acct.item_type
-- ========================================================
-- Using base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ========================================================
and	hoi.org_information_context      = 'Accounting Information'
and	hoi.organization_id              = mtl_acct.organization_id
and	hoi.organization_id              = haou.organization_id -- this gets the organization name
and	haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and	gl.name                          = decode('&p_ledger', null, gl.name, '&p_ledger')                         -- p_ledger
and	haou2.name                       = decode('&p_operating_unit', null, haou2.name, '&p_operating_unit')      -- p_operating_unit
-- Avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- ========================================================
-- End revision for version 1.4
-- Revision for version 1.3
-- Remove subledger accounting tables join to mta and oap instead
-- ========================================================
and	gcc.code_combination_id (+)  = mtl_acct.reference_account
and	oap.acct_period_id           = mtl_acct.acct_period_id
and	oap.organization_id          = mtl_acct.organization_id
group by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating Unit
	mtl_acct.organization_code,
	mtl_acct.organization_id,
	oap.period_name,
	&segment_columns2
	mtl_acct.item_number,
	mtl_acct.item_description,
	fcl.meaning, -- Item Type
	mtl_acct.inventory_item_status_code,
	ml1.meaning, -- Make Buy Code
	-- Revision for version 1.4, for category SQL
	mtl_acct.inventory_item_id,
	-- End revision for version 1.1
	ml2.meaning, -- Acct Line Type
	-- End revision for version 1.4
	-- Comment this out to net the two lines to zero
	-- mtl_acct.transaction_type_name
	mtl_acct.transaction_source,
	mtl_acct.document_order_num,
	mtl_acct.order_type,
	mtl_acct.primary_uom_code,
	gl.currency_code
having	(sum(mtl_acct.primary_quantity) <> 0
	 and
	 sum(mtl_acct.mta_amount)       <> 0
	)
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating Unit
	mtl_acct.organization_code,
	oap.period_name,
	&segment_columns2
	mtl_acct.item_number,
	ml2.meaning, -- Accounting_Line_Type
	mtl_acct.transaction_source,
	mtl_acct.document_order_num