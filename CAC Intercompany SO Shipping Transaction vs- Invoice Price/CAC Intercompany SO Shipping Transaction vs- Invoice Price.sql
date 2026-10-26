/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Shipping Transaction vs. Invoice Price
-- Description: Report to compare the transaction item cost from the selling internal org to the invoice sales price the selling internal organization is charging the internal receiving organization.
-- / +=============================================================================+
-- -- | Copyright 2017 - 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxverifysopricevscosttxn.sql
-- -- |
-- -- | Parameters:
-- -- | ptrxdatefrom -- starting shipping transaction date, mandatory
-- -- | ptrxdateto -- ending shipping transaction date, mandatory
-- -- |
-- -- | Description:
-- -- | Report to compare the transaction item cost from the selling internal org
-- -- | to the invoice sales price the selling internal organization is charging the
-- -- | receiving organization.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 01 May 2017 Douglas Volz Initial Coding
-- -- | 1.1 03 Sep 2019 Douglas Volz Add Ledger, Operating Unit, Item Type, Status
-- -- | and item categories for cost and inventory.
-- -- | 1.2 27 Jan 2020 Douglas Volz Added Ledger, Operating Unit and Org Code
-- -- | parameters.
-- -- | 1.3 09 Jul 2022 Douglas Volz Changes for multi-language lookup values.
-- -- | 1.4 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-intercompany-so-shipping-transaction-vs-invoice-price/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.item_description,
x.item_type,
x.item_status,
x.make_buy_code,
&category_columns
x.transaction_type,
x.item_internal_order_flag,
x.item_internal_order_enabled,
x.item_invoiceable,
x.item_invoice_enabled,
x.transaction_id,
x.transaction_date,
x.sales_order_number,
x.so_line_number,
x.uom_code,
x.ship_quantity,
x.unit_cost,
x.sales_unit_price,
nvl(x.sales_unit_price,0)-x.unit_cost unit_margin,
x.sales_quantity_invoiced
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
mtt.transaction_type_name transaction_type,
xxen_util.yes(msiv.internal_order_flag) item_internal_order_flag,
xxen_util.yes(msiv.internal_order_enabled_flag) item_internal_order_enabled,
xxen_util.yes(msiv.invoiceable_item_flag) item_invoiceable,
xxen_util.yes(msiv.invoice_enabled_flag) item_invoice_enabled,
to_char(mmt.transaction_id) transaction_id,
mmt.transaction_date,
ooha.order_number sales_order_number,
oola.line_number so_line_number,
msiv.primary_uom_code uom_code,
mmt.primary_quantity ship_quantity,
mmt.new_cost unit_cost,
(select max(rctla.unit_selling_price) from ra_customer_trx_lines_all rctla where to_char(oola.line_id)=rctla.interface_line_attribute6 and rctla.interface_line_context='INTERCOMPANY') sales_unit_price,
(select sum(rctla.quantity_invoiced) from ra_customer_trx_lines_all rctla where to_char(oola.line_id)=rctla.interface_line_attribute6 and rctla.interface_line_context='INTERCOMPANY') sales_quantity_invoiced,
msiv.inventory_item_id,
msiv.organization_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
oe_order_lines_all oola,
oe_order_headers_all ooha,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=mmt.organization_id and
mmt.transaction_source_type_id=8 and
mmt.transaction_action_id<>28 and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.trx_source_line_id=oola.line_id and
oola.header_id=ooha.header_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id
) x
order by
x.ledger,
x.operating_unit,
x.org_code,
x.item_number,
x.transaction_date,
x.sales_order_number,
x.so_line_number
