/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Missing Receiving Accounting Transactions
-- Description: Report to find receiving transactions where the receiving accounting entries do not exist, for PO receipts into receiving and for returns from inventory and outside processing (work in process).  To get all transactions which are missing receiving accounting entries, even for transactions where the transaction amounts are too small, set the Minimum Transaction Amount to zero (0).  And note the quantities and purchase order unit prices are expressed in the item's primary unit of measure. 

Note:  To find missing purchase order deliveries into inventory or work in process, use the CAC Missing Material Transactions and the CAC Missing WIP Transactions reports.

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  find_missing_receiving_accounting_entries.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- Starting transaction date, mandatory
-- |  p_trx_date_to      -- Ending transaction date, mandatory
-- |  p_minimum_amount   -- The absolute smallest transaction amount to be reported
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_item_number      -- Specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find receiving transactions where the receiving accounting entries do not
-- |  exist.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     14 Jul 2022 Douglas Volz   Initial Coding
-- |  1.1     15 Jul 2022 Douglas Volz   Added PO number, PO Line, decode on receipt
-- |                                     quantity.
-- |  1.2     18 Jul 2022 Douglas Volz   Correct logic for CORRECT transaction types.
-- |  1.3     23 Jul 2022 Douglas Volz   Added Parent Transaction Type to report.
-- |                                     Additional exclusions for CORRECT transactions.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-missing-receiving-accounting-transactions/
-- Library Link: https://www.enginatics.com/reports/cac-missing-receiving-accounting-transactions/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 (select oap.period_name
  from org_acct_periods oap
  where oap.organization_id            = rt.organization_id
  and rt.transaction_date           >= oap.period_start_date
  and rt.transaction_date           <  oap.schedule_close_date + 1
 ) Period_Name,
 mtst.transaction_source_type_name Transaction_Source,
 flv.meaning Transaction_Type,
 -- Revision for version 1.3
 (select flv2.meaning
  from rcv_transactions rt2,
  fnd_lookup_values flv2
  where rt2.transaction_id              = rt.parent_transaction_id
  and flv2.lookup_type                = 'RCV TRANSACTION TYPE'
  and flv2.lookup_code                = rt2.transaction_type
  and flv2.language                   = userenv('lang')
 ) Parent_Transaction_Type,
 -- End revision for version 1.3
 rt.transaction_id Transaction_Id,
 rt.parent_transaction_id Parent_Transaction_Id,
 poh.segment1 PO_Number,
 pol.line_num PO_Line,
 rt.transaction_date Transaction_Date,
 rt.creation_date Creation_Date,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
&category_columns
 -- Revision for version 1.3
 fcl.meaning Item_Type,
 fl1.meaning Allow_Costs,
 fl2.meaning Inventory_Asset,
 fl3.meaning Material_Transaction_Enabled,
 muomv.uom_code UOM_Code,
 -- End revision for version 1.3
 decode(rt.transaction_type,
  'RETURN TO VENDOR', -1 * rt.primary_quantity,
  rt.primary_quantity) Primary_Quantity,
 nvl(rt.po_unit_price,0) * rt.primary_quantity/rt.quantity PO_Unit_Price,
 round(sum(decode(rt.transaction_type, 'RETURN TO VENDOR', -1 * rt.primary_quantity, rt.primary_quantity)
    * nvl(rt.po_unit_price,0) * rt.primary_quantity/rt.quantity),2) Extended_Receipt_Amount
from rcv_transactions rt,
 po_lines_all pol,
 po_headers_all poh,
 mtl_system_items_vl msiv,
 mtl_units_of_measure_vl muomv,
 mtl_txn_source_types mtst,
 mtl_parameters mp,
 fnd_lookup_values flv,
 -- Revision for version 1.3
 fnd_common_lookups fcl, -- Item Type
 fnd_lookups fl1, -- allow costs, YES_NO
 fnd_lookups fl2, -- inventory_asset_flag, YES_NO
 fnd_lookups fl3, -- mtl_transactions_enabled_flag, YES_NO
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
 -- End revision for version 1.3
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where rt.organization_id              = msiv.organization_id
-- Requisitions and RMAs do not have PO Header Ids and are not accounted with receiving accounting entries.
-- Inventory accrues the internal requisition receipt and RMAs and do not have an accounting entry for receiving.
and rt.po_header_id                 = poh.po_header_id
and rt.po_line_id                   = pol.po_line_id
and pol.item_id                     = msiv.inventory_item_id
and msiv.primary_uom_code           = muomv.uom_code
and mp.organization_id         = msiv.organization_id
and rt.transaction_type in ('RECEIVE','RETURN TO VENDOR','CORRECT')
and mtst.transaction_source_type_id = 1 -- Purchase Order
-- ========================================================
-- Find missing receiving accounting entries
-- ========================================================
-- Find receiving transactions which have no accounting entries
and not exists
 (select 'x'
  from rcv_receiving_sub_ledger rrsl
  where rrsl.rcv_transaction_id = rt.transaction_id)
-- Revision for version 1.3
-- Avoid CORRECT transactions where the parent is either not accounted for
-- or where Oracle Inventory or WIP will do the receipt accounting. 
and     rt.parent_transaction_id not in 
 (select rt2.transaction_id
  from rcv_transactions rt2
  where rt2.transaction_id = rt.parent_transaction_id
  and rt2.transaction_type in ('ACCEPT','DELIVER','REJECT','RETURN TO RECEIVING', 'TRANSFER')
  and rt.transaction_type = 'CORRECT'
 )
-- End revision for version 1.3
-- Transfer of ownership consigned entries do not hit receiving accounts
and nvl(rt.consigned_flag,'N')      = 'N'
-- ========================================================
-- Lookup joins
-- ========================================================
and flv.lookup_type                 = 'RCV TRANSACTION TYPE'
and flv.lookup_code                 = rt.transaction_type
and flv.language                    = userenv('lang')
-- Revision for version 1.3
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
and fl2.lookup_type                 = 'YES_NO'
and fl2.lookup_code                 = msiv.inventory_asset_flag
and fl3.lookup_type                 = 'YES_NO'
and fl3.lookup_code                 = msiv.mtl_transactions_enabled_flag
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- End revision for version 1.3
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id            
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
group by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating Unit 
 mp.organization_code,
 rt.organization_id,
 rt.transaction_id,
 mtst.transaction_source_type_name, -- Purchase Order
 flv.meaning, -- Transaction Type
 rt.transaction_id,
 rt.parent_transaction_id,
 -- Revision for version 1.3
 rt.parent_transaction_id,
 poh.segment1, -- PO Number
 pol.line_num, -- PO Line
 rt.transaction_date,
 rt.creation_date,
 msiv.concatenated_segments,
 msiv.description,
 msiv.inventory_item_id,
 msiv.organization_id,
 fcl.meaning, -- Item Type
 fl1.meaning, -- Allow Costs
 fl2.meaning, -- Inventory Asset
 fl3.meaning, -- Mtl Trx Enabled
 muomv.uom_code,
 decode(rt.transaction_type,
  'RETURN TO VENDOR', -1 * rt.primary_quantity,
  rt.primary_quantity),
 rt.transaction_type,
 nvl(rt.po_unit_price,0),
 nvl(rt.po_unit_price,0) * rt.primary_quantity/rt.quantity
having abs(round(sum(decode(rt.transaction_type, 'RETURN TO VENDOR', -1 * rt.primary_quantity, rt.primary_quantity) * nvl(rt.po_unit_price,0) * rt.primary_quantity/rt.quantity),2)
    ) >= :p_minimum_amount -- Extended_Receipt_Amount
-- Order by Ledger, Operating Unit, Org Code, Transaction Source and Transaction Date
order by 1,2,3,5,12