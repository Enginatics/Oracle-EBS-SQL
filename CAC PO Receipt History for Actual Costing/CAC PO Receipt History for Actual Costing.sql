/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Receipt History for Actual Costing
-- Description: Report to show Purchase Order (PO) Receipt History for non-Standard Cost inventory organizations, by PO receipt date range.  You may also use this report for Standard Cost organizations but the CAC PO Receipt History for Item Costing report may be a better choice, as the following columns will have zero or empty values for Standard Cost organizations:  prior costed quantity, prior cost and new onhand quantity.

/* +=============================================================================+
-- | Copyright 2006 - 2022 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_history.sql
-- |
-- |  Parameters:
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_trx_date_from        -- Starting transaction date for the PO Receipt History
-- |  p_trx_date_to          -- Ending transaction date for the PO Receipt History
-- |  p_item_number          -- Enter a specific item number to review.  If you 
-- |                            enter a blank or null value you get all items.
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |
-- | Description:
-- | Report to show PO Receipt History for non-standard cost inventory organizations,
-- | by PO receipt date range.
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     28 May 2006 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     04 Jan 2019 Douglas Volz   Added transaction date range, inventory
-- |                                    org and specific item parameters.
-- | 1.2     30 Aug 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                    and item categories for cost and inventory.
-- | 1.3     27 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- | 1.4     05 Jul 2022 Douglas Volz   Modify for multi-language tables, change UOM to
-- |                                    primary, and changes for Non-Standard Costing.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-po-receipt-history-for-actual-costing/
-- Library Link: https://www.enginatics.com/reports/cac-po-receipt-history-for-actual-costing/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 he.full_name Buyer,
 mmt.transaction_id Transaction_Id,
 msiv.concatenated_segments Item,
 msiv.description Item_Description,
 -- Revision for version 1.2
 fcl.meaning Item_Type,
 -- Revision for version 1.4
 -- msiv.inventory_item_status_code Item_Status,
 misv.inventory_item_status_code_tl Item_Status,
 ml1.meaning Make_Buy_Code,
 -- End revision for version 1.4
 -- Revision for version 1.2
&category_columns
 poh.segment1 PO_Number, 
 pol.line_num PO_Line,
 pr.release_num PO_Release,
 mmt.transaction_date Transaction_Date,
 -- Revision for version 1.4
 -- msiv.primary_uom_code UOM,
 muomv.uom_code Primary_UOM_Code,
 mmt.prior_costed_quantity Prior_Costed_Quantity,
 -- Revision for version 1.4, change to primary quantity
 -- mmt.transaction_quantity Transaction_Quantity,
 mmt.primary_quantity Primary_Quantity,
 mmt.transaction_quantity + mmt.prior_costed_quantity New_Onhand_Quantity,
 round(nvl(mcacd.prior_cost,0),5) Prior_Cost,
 round(nvl(mcacd.actual_cost,0),5) PO_Unit_Price,
 round(nvl(mcacd.new_cost,0),5) New_Cost,
 round(nvl(mcacd.new_cost,0) - nvl(mcacd.prior_cost,0),5) Cost_Change
from mtl_material_transactions mmt,
 mtl_cst_actual_cost_details mcacd,
 rcv_transactions rt,
 mtl_system_items_vl msiv,
 -- Revision for version 1.4
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 -- End revision for version 1.4
 po_headers_all poh,
 po_lines_all pol,
 po_line_locations_all pll,
 po_releases_all pr,
 hr_employees he,
 mtl_parameters mp,
 -- Revision for version 1.2
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou, -- inv_organization_id
 hr_all_organization_units_vl haou2,  -- operating unit
 gl_ledgers gl
where mmt.inventory_item_id    = msiv.inventory_item_id
and mmt.organization_id   = msiv.organization_id
and mmt.transaction_source_type_id = 1 -- purchase orders
and mmt.transaction_id  = mcacd.transaction_id
and mcacd.cost_element_id  = 1 -- material costs
and mmt.rcv_transaction_id  = rt.transaction_id
and he.employee_id  (+)     = msiv.buyer_id -- Need the outer join in employee id, not always defined
and rt.po_header_id   = poh.po_header_id
and rt.po_line_id   = pol.po_line_id
and rt.po_line_location_id  = pll.line_location_id
and poh.po_header_id                = pol.po_header_id  
and pll.po_release_id  = pr.po_release_id (+)
and mp.organization_id              = rt.organization_id
-- Revision for version 1.4
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.4
-- Revision for version 1.2
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = hoi.org_information3   -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and 1=1                             -- p_trx_date_from, p_trx_date_to, p_item_number, p_org_code, p_operating_unit, p_ledger
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 msiv.concatenated_segments, -- Item
 mmt.transaction_date, -- Transaction Date
 poh.segment1, -- PO Number
 pol.line_num, -- PO_Line
 pr.release_num -- PO_Release