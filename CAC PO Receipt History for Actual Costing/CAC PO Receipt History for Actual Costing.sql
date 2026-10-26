/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Receipt History for Actual Costing
-- Description: Report to show Purchase Order (PO) Receipt History for non-Standard Cost inventory organizations, by PO receipt date range. You may also use this report for Standard Cost organizations but the CAC PO Receipt History for Item Costing report may be a better choice, as the following columns will have zero or empty values for Standard Cost organizations: prior costed quantity, prior cost and new onhand quantity.
-- / +=============================================================================+
-- -- | Copyright 2006 - 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxitemcosthistory.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | ptrxdatefrom -- Starting transaction date for the PO Receipt History
-- -- | ptrxdateto -- Ending transaction date for the PO Receipt History
-- -- | pitemnumber -- Enter a specific item number to review. If you
-- -- | enter a blank or null value you get all items.
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- |
-- -- | Description:
-- -- | Report to show PO Receipt History for non-standard cost inventory organizations,
-- -- | by PO receipt date range.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 28 May 2006 Douglas Volz Initial Coding based on itemcosthistory.sql
-- -- | 1.1 04 Jan 2019 Douglas Volz Added transaction date range, inventory
-- -- | org and specific item parameters.
-- -- | 1.2 30 Aug 2019 Douglas Volz Add Ledger, Operating Unit, Item Type, Status
-- -- | and item categories for cost and inventory.
-- -- | 1.3 27 Jan 2020 Douglas Volz Added Org Code and Operating Unit parameters.
-- -- | 1.4 05 Jul 2022 Douglas Volz Modify for multi-language tables, change UOM to
-- -- | primary, and changes for Non-Standard Costing.
-- -- | 1.5 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-po-receipt-history-for-actual-costing/
-- Library Link: https://www.enginatics.com/reports/cac-po-receipt-history-for-actual-costing/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
(select he.full_name from hr_employees he where msiv.buyer_id=he.employee_id) buyer,
mmt.transaction_id,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
pha.segment1 po_number,
pla.line_num po_line,
(select pra.release_num from po_releases_all pra where plla.po_release_id=pra.po_release_id) po_release,
mmt.transaction_date,
msiv.primary_uom_code,
mmt.prior_costed_quantity,
mmt.primary_quantity,
mmt.transaction_quantity+mmt.prior_costed_quantity new_onhand_quantity,
round(nvl(mcacd.prior_cost,0),5) prior_cost,
round(nvl(mcacd.actual_cost,0),5) po_unit_price,
round(nvl(mcacd.new_cost,0),5) new_cost,
round(nvl(mcacd.new_cost,0)-nvl(mcacd.prior_cost,0),5) cost_change
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_material_transactions mmt,
mtl_cst_actual_cost_details mcacd,
rcv_transactions rt,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mmt.organization_id and
mmt.transaction_source_type_id=1 and
mmt.transaction_id=mcacd.transaction_id and
mcacd.cost_element_id=1 and
mmt.rcv_transaction_id=rt.transaction_id and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code
order by
ledger,
operating_unit,
org_code,
item,
mmt.transaction_date,
po_number,
po_line,
po_release
