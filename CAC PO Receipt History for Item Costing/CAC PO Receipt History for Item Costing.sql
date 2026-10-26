/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Receipt History for Item Costing
-- Description: Report to show Purchase Order (PO) Receipt History for inventory organizations, for a selected PO receipt date range. If the Comparison Cost Type is not entered the report uses the Cost Type from the Primary Costing Method, such as Frozen, Average, FIFO or LIFO. And note you may use this report for any discrete costing method but the CAC PO Receipt History for Actual Costing report may be a better choice for Average, FIFO and LIFO Costing, as additional information is available, such as the prior costed quantity, prior cost and new onhand quantity.
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date for PO Receipt History (mandatory).
-- Transaction Date To: enter the ending transaction date for PO Receipt History (mandatory).
-- Comparison Cost Type: enter the cost type to compare against the PO receipts (optional). If the Comparison Cost Type is not entered the report uses Cost Type from the Primary Costing Method.
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2006 - 2023 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 28 May 2006 Douglas Volz Initial Coding based on itemcosthistory.sql
-- -- | 1.1 04 Jan 2019 Douglas Volz Added transaction date range, inventory
-- -- | org and specific item parameters.
-- -- | 1.2 30 Aug 2019 Douglas Volz Add Ledger, Operating Unit, Item Type, Status
-- -- | and item categories for cost and inventory.
-- -- | 1.3 27 Jan 2020 Douglas Volz Added OrgCode and OperatingUnit parameters.
-- -- | 1.4 05 Jul 2022 Douglas Volz Modify for multi-language tables, change UOM to
-- -- | primary, and changes for Standard Costing.
-- -- | 1.5 01 Sep 2022 Douglas Volz Add supplier information to report.
-- -- | 1.6 13 Dec 2022 Douglas Volz Fix supplier type and cost type logic.
-- -- | 1.7 11 Sep 2023 Douglas Volz Added Transaction Type to report.
-- -- | 1.8 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-po-receipt-history-for-item-costing/
-- Library Link: https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/
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
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
mmt.transaction_date,
mtt.transaction_type_name transaction_type,
aps.vendor_name supplier,
aps.segment1 supplier_number,
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) supplier_type,
pha.segment1 po_number,
pla.line_num po_line,
(select pra.release_num from po_releases_all pra where plla.po_release_id=pra.po_release_id) po_release,
msiv.primary_uom_code,
mmt.primary_quantity,
round(nvl(mmt.transaction_cost,0),5) po_unit_price,
cct.cost_type "Comparison Cost Type",
round(nvl(cic.item_cost,0),5)-round(nvl(cic.tl_material_overhead,0),5) comparison_material_item_cost,
round(nvl(cic.item_cost,0),5)-round(nvl(cic.tl_material_overhead,0),5)-round(nvl(mmt.transaction_cost,0),5) cost_difference
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
rcv_transactions rt,
ap_suppliers aps,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
mtl_system_items_vl msiv,
cst_item_costs cic,
cst_cost_types cct
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mmt.organization_id and
mmt.transaction_source_type_id=1 and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.rcv_transaction_id=rt.transaction_id and
rt.vendor_id=aps.vendor_id(+) and
rt.po_header_id=pha.po_header_id and
rt.po_line_id=pla.po_line_id and
rt.po_line_location_id=plla.line_location_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
mmt.organization_id=cic.organization_id and
mmt.inventory_item_id=cic.inventory_item_id and
cic.cost_type_id=nvl((select cct2.cost_type_id from cst_cost_types cct2 where cct2.cost_type=:p_cost_type),mp.primary_cost_method) and
cic.cost_type_id=cct.cost_type_id
order by
ledger,
operating_unit,
org_code,
item,
mmt.transaction_date,
supplier,
po_number,
po_line,
po_release
