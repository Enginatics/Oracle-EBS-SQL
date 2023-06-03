/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Account Summary
-- Description: Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the report size, to display or not display purchase information (purchase order, line, release) and WIP outside processing information (WIP job and OSP resource code).  And if you accrue expense receipts at time of receipt, for expense destinations when there is no item number, this report will get the expense category information and put it into the columns for the first category set.

(Note: this report has not been tested with encumbrance entries.)

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Purchase Orders:  display the purchase order, line and release information.  Enter Yes or No, use to limit the report size (mandatory).
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP Outside Processing:  display the WIP job and outside processing resource.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Supplier Name:  enter the specific supplier you wish to report (optional).
PO Number:  enter the specific purchase order number you wish to report (optional).
Destination Code:  enter the purchase order destination type you wish to report (optional).  You can choose Inventory, Expense or Shop Floor (WIP outside processing).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.15    17 Sep 2021 Douglas Volz   Parameter changes, adding item number, PO number.
-- |  1.16    08 Jul 2022 Douglas Volz   Subledger Accounting performance improvements
-- |                                     and parameter to show or not show PO information.
-- |  1.17    14 Aug 2022 Douglas Volz   Revision for expense/no item receipts.
-- |                                     Combine SLA and Non-SLA Receiving Acct Reports.  Make
-- |                                     Show SLA, Show PO and Show WIP OSP dynamic SQL parameters.
-- |  1.18    21 Aug 2022 Douglas Volz   Streamline dynamic SQL code.
-- |  1.19    03 Sep 2022 Douglas Volz   Language translations for Accounting Line Types.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-receiving-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-account-summary/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 acct_dist.organization_code Org_Code,
 oap.period_name Period_Name,
 &segment_columns
 acct_dist.item_number Item_Number,
 acct_dist.item_description Item_Description,
 -- Revision for version 1.13
 acct_dist.item_type Item_Type,
        -- Revision for version 1.17
 -- If the item does not exist, get the expense category information
&category_columns
 -- Revision for version 1.19
 nvl(flv2.meaning, acct_dist.accounting_line_type) Accounting_Line_Type,
 flv1.meaning Transaction_Type,
 -- End revision for version 1.19
 -- Revision for version 1.16
 acct_dist.vendor_name Supplier_Name,
 pl.displayed_field Destination_Type,
 -- Revision for version 1.18
 &p_show_purchase_order
 &p_show_project
 -- End fix for version 1.18
 -- Fix for version 1.9 and 1.17
 &p_show_wip_osp
 -- Revision for version 1.17, preventing Expense Receipts to be reported
 -- acct_dist.primary_uom_code UOM_Code,
 (select muomv.uom_code
  from mtl_units_of_measure_vl muomv
  where muomv.uom_code    = acct_dist.primary_uom_code) UOM_Code,
 -- End revision for version 1.17
 sum(acct_dist.primary_quantity) Quantity,
 gl.currency_code Currency_Code,
 sum(acct_dist.amount) Amount
from org_acct_periods oap,
 gl_code_combinations gcc,
 -- Revision for version 1.19
 fnd_lookup_values flv1,
 fnd_lookup_values flv2,
 -- End revision for version 1.19
 hr_organization_information hoi,
 hr_all_organization_units_vl haou, -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 po_lookup_codes pl,
 -- Revision for version 1.18
 &wip_osp_tables
 &project_tables
 -- Revision for version 1.17
 &rcv_sla_tables
 -- ==========================================================================
 -- Use this inline table to fetch the receiving transactions
 -- ==========================================================================
 (select mp.organization_code organization_code,
  rt.organization_id organization_id,
  rrsl.period_name period_name,
  rrsl.code_combination_id code_combination_id,
  rrsl.rcv_sub_ledger_id rcv_sub_ledger_id,
  msiv.concatenated_segments item_number,
  msiv.description item_description,
  -- Revision for version 1.13
  fcl.meaning item_type,
  -- Revision for version 1.17
  rsl.item_id,
  rsl.to_organization_id,
  pol.category_id,
  -- End revision for version 1.17
  rrsl.accounting_line_type accounting_line_type,
  rt.transaction_type transaction_type,
  -- Revision for version 1.16
  pov.vendor_name,
  pod.destination_type_code destination_type_code,
  -- Fix for version 1.18
  poh.segment1 po_num,
  pol.line_num po_line,
  rt.po_release_id,
  -- End fix for version 1.18
  pod.project_id project_id,
  -- Fix for version 1.18
  rt.wip_entity_id,
  rt.bom_resource_id,
  -- End fix for version 1.18
  -- Revision for version 1.14 and 1.17, preventing Expense Receipts to be reported
  -- muomv.uom_code primary_uom_code,
  msiv.primary_uom_code primary_uom_code,
  -- End revision for version 1.17
  decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
  -- Fix for version 1.8, sign of qty incorrect on CORRECTION transactions
  --   1, rt.primary_quantity, 
  --  -1, -1 * rt.primary_quantity,
     1,  1 * abs(rt.primary_quantity), 
    -1, -1 * abs(rt.primary_quantity),
    rt.primary_quantity
  -- End fix for version 1.8
     ) primary_quantity,
  nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0) amount
  from rcv_receiving_sub_ledger rrsl,
  -- Fix for version 1.10
  rcv_accounting_events rae,
  rcv_transactions rt,
  rcv_shipment_lines rsl,
  -- Fix for version 1.9
  po_headers_all poh,
  po_lines_all pol,
  -- Fix for version 1.9
  po_distributions_all pod,
  mtl_system_items_vl msiv,
  -- Revision for version 1.17, preventing Expense Receipts to be reported
  -- mtl_units_of_measure_vl muomv,
  mtl_parameters mp,
  -- Revision for version 1.13
  fnd_common_lookups fcl,
  -- Revision for version 1.16
  po_vendors pov
  -- ========================================================
  -- Material Transaction, org and item joins
  -- ========================================================
  where rrsl.rcv_transaction_id = rt.transaction_id
 -- Fix for version 1.10
  and rae.accounting_event_id = rrsl.accounting_event_id
  and rae.rcv_transaction_id  = rt.transaction_id
 -- End fix for version 1.10
  and rt.shipment_line_id     = rsl.shipment_line_id
  -- Expense destinations may not always have an item_id
  and rsl.item_id             = msiv.inventory_item_id (+) 
  and rsl.to_organization_id  = msiv.organization_id (+)
  -- Revision for version 1.17, preventing Expense Receipts to be reported
  -- and muomv.uom_code             = nvl(msiv.primary_uom_code, rt.uom_code)
  and pod.po_distribution_id  = nvl(rt.po_distribution_id, to_number(rrsl.reference3))
  and mp.organization_id      = rt.organization_id
  and rt.po_header_id         = poh.po_header_id
  and rt.po_line_id           = pol.po_line_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 4=4                       -- p_trx_date_from, p_trx_date_to, p_dest_type_code, p_item_number, p_po_number, p_org_code
  and fcl.lookup_code  (+)    = msiv.item_type
  and fcl.lookup_type  (+)    = 'ITEM_TYPE'
  -- Revision for version 1.16
  and pov.vendor_id           = poh.vendor_id
 ) acct_dist
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
-- Revision for version 1.13
where oap.period_name                 = acct_dist.period_name
and oap.organization_id             = acct_dist.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
-- Revision for version 1.19
and flv1.lookup_type                = 'RCV TRANSACTION TYPE'
and flv1.lookup_code                = acct_dist.transaction_type
and flv1.language                   = userenv('lang')
and flv2.lookup_type (+)            = 'XLA_ACCOUNTING_CLASSES'
and flv2.lookup_code (+)            = acct_dist.accounting_line_type
and flv2.language (+)               = userenv('lang')
-- End revision for version 1.19
and pl.lookup_type                  = 'DESTINATION TYPE'
and pl.lookup_code                  = acct_dist.destination_type_code
-- ========================================================
-- Dynamic SQL joins
-- ========================================================
&project_table_joins
&osp_wip_table_joins
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = acct_dist.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                             -- p_dest_type_code, p_operating_unit, p_ledger
-- ========================================================
-- Revision for version 1.17, SLA and Non-SLA joins.
-- ========================================================
&rcv_sla_table_joins
&rcv_non_sla_table_joins
-- ==========================================================
group by 
 nvl(gl.short_name, gl.name),
 haou2.name,
 acct_dist.organization_code,
 oap.period_name,
 &segment_columns_grp
 acct_dist.item_number,
 acct_dist.item_description,
 -- Revision for version 1.13
 acct_dist.item_type,
 -- Revision for version 1.17, for category subquery
 acct_dist.item_id,
 acct_dist.to_organization_id,
 acct_dist.category_id,
         -- End revision for version 1.17
 -- Revision for version 1.19
 nvl(flv2.meaning, acct_dist.accounting_line_type), -- Accounting Line Type
 flv1.meaning, -- Transaction Type
 -- End revision for version 1.19
 -- Revision for version 1.16
 acct_dist.vendor_name, -- Supplier_Name,
 pl.displayed_field, -- Destination Type
 -- Revision for version 1.17
 &group_by_purchase_order
 &group_by_project
 -- Revision for version 1.17
 &group_by_wip_osp
 -- End fix for version 1.9
 -- End revision for version 1.17
 acct_dist.primary_uom_code,
 gl.currency_code
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 acct_dist.organization_code, -- Org_Code
 oap.period_name, -- Period_Name
 &segment_columns_grp
 acct_dist.item_number, -- Item_Number
 -- Revision for version 1.19
 nvl(flv2.meaning, acct_dist.accounting_line_type), -- Accounting Line Type
 flv1.meaning, -- Transaction Type
 -- End revision for version 1.19
 pl.displayed_field -- Destination Type
 &order_by_purchase_order
 &order_by_project
 &order_by_wip_osp