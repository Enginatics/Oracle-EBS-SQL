/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Internal Order Shipment Margin
-- Description: Report to display the internal sales orders/requisition shipments with COGS, margin, inter-company profit and other useful information.  This report separately gets the COGS and revenue entries for the entered date range. If the COGS information is not reported the sales order line was not shipped in the entered date range.  If the revenue nformation is not reported the sales order line was not billed in the entered date range.

/* +=============================================================================+
-- |  Copyright 2010 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_from_org_ledger         -- general ledger you wish to report, for the From Organization, optional
-- |  p_to_org_ledger           -- general ledger you wish to report, for the To Organization, optional
-- |  p_from_org_code           -- the source or from inventory organization you wish to report, optional
-- |  p_trx_date_from           -- starting transaction date for internal shipment transactions, mandatory
-- |  p_trx_date_to             -- ending transaction date for internal shipment transactions, mandatory
-- |  p_pii_cost_type           -- the profit in inventory costs you wish to report
-- |  p_pii_resource_code       -- the sub-element or resource for profit in inventory,
-- |                               such as PII or ICP 
-- |  p_curr_conv_date          -- currency conversion date
-- |  p_std_cost_curr_conv_type -- currency conversion type used to set your standard costs and
-- |                               transfer prices
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== =========================================
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     12 Nov 2009 Douglas Volz   Initial Coding based on XXX_IRO_COGS.sql
-- |  1.27     25 May 2020 Douglas Volz  Changed to multi-language views for organizations, operating units,
-- |                                     categories and units of measure.  Remove RA Batches code logic.
-- |                                     Remove sections for custom IR/ISO transactions.
-- +=============================================================================+*/
-- ======================================================== 
-- Program Outline
-- ======================================================== 
-- Section I:   Output the Report Columns for the Internal Shipment Entries
-- Section II:  Get the currency conversion rates, based on the currency conversion
--              type and currency conversion date parameters
-- Section III: Condense the 2 union all statements into one line
--              for each Transaction Id.  Also get the PII item costs.
-- Section IV:  Get the material, payables and revenue transactions
--              which represent the Internal Order activity.
--              Assume IR/ISO shipments may or may not use custom billing
--              Section IV has 2 union all reports as follows:
--	 Report 1:  Get IR/ISO COGS and Sales for Intransit Shipments
--	            where title passes upon shipment (FOB = 1, Shipment)
--	 Report 2:  Get IR/ISO COGS and Sales for IR/ISO Intransit Receipts
--	            where title passes upon receipt (FOB_Point = 2, Receipt)






-- Excel Examle Output: https://www.enginatics.com/example/cac-internal-order-shipment-margin/
-- Library Link: https://www.enginatics.com/reports/cac-internal-order-shipment-margin/
-- Run Report: https://demo.enginatics.com/

select txns_sum.from_ledger From_Ledger,
-- ========================================================
-- Section I
-- Output the Report Columns
-- ========================================================
 txns_sum.from_operating_unit From_Operating_Unit,
 txns_sum.to_ledger To_Ledger,
 txns_sum.to_operating_unit To_Operating_Unit,
 txns_sum.ship_from_org Ship_From_Org,
 txns_sum.ship_to_org Ship_To_Org,
 txns_sum.item_number Item_Number,
 txns_sum.item_description Item_Description,
 fcl.meaning Item_Type,
&category_columns
 txns_sum.customer Customer,
 txns_sum.customer_number Customer_Number,
 txns_sum.so_order_number  Sales_Order_Number,
 txns_sum.so_line_number Sales_Order_Line,
 ottt.name Order_Type,
 (select rct.trx_number
  from ra_customer_trx_all rct
  where rct.customer_trx_id = txns_sum.ar_invoice_id) AR_Invoice_Number,
 decode(txns_sum.ar_invoice_line_number, 0, null, to_char(txns_sum.ar_invoice_line_number)) AR_Line_Number,
 -- End revision for version 1.25
 decode(txns_sum.pr_number, 0, null, txns_sum.pr_number)  Requisition_Number,
 qlh_tl.name Price_List,
 mtt.transaction_type_name Transaction_Type,
 txns_sum.transaction_id Transaction_Number,
 txns_sum.transaction_date Ship_Date,
 txns_sum.lot_number Lot_Number,
 txns_sum.transaction_cost From_Org_Txn_Cost,
 txns_sum.unit_price From_Org_Unit_Price,
 txns_sum.uom_code UOM_Code,
 txns_sum.cogs_primary_quantity Ship_Quantity,
 txns_sum.quantity_invoiced Invoice_Quantity,
 txns_sum.cogs_primary_quantity - txns_sum.quantity_invoiced Quantity_Diff,
 txns_sum.from_curr_code From_Curr_Code,
 txns_sum.cogs_amount From_Org_COGS_Amount,
 txns_sum.revenue_amount From_Org_Sales_Amount,
 txns_sum.cogs_amount - txns_sum.revenue_amount From_Org_Margin_Amount,
 -- ======================================================== 
 -- Revision for version 1.10, fix the Margin Percentage
 -- Margin / Sales_Amount
 -- If the Sales Price is Zero and the Unit_Cost is Zero the Margin Percent is 0
 -- If the Sales_Amount is Zero the Margin Percent is -100 %
 -- Else do the normal calculation
 -- ======================================================== 
 case 
    -- Unit_Price is zero and Unit_Cost is zero set the margin percentage to zero
    when nvl(txns_sum.unit_price,0) = 0 and txns_sum.transaction_cost = 0 then 0
    -- Unit_Price is zero and the Unit_Cost is not zero the Margin Percent is 100 %
    when nvl(txns_sum.unit_price,0) = 0 and txns_sum.transaction_cost <> 0 then 100
    -- Else do the calculation for Margin Percentage and round the percentage
    else round((txns_sum.transaction_cost - nvl(txns_sum.unit_price,0))/ nvl(txns_sum.unit_price,0),3) * 100
        end From_Org_Margin_Percent,
 txns_sum.transaction_cost - txns_sum.unit_price From_Org_Unit_Margin,
 txns_sum.from_org_pii_cost From_Org_PII_Item_Cost,
 txns_sum.transaction_cost - txns_sum.unit_price + txns_sum.from_org_pii_cost From_Org_Net_Unit_Margin,
 txns_sum.cogs_amount - txns_sum.revenue_amount +
  round((txns_sum.from_org_pii_cost * txns_sum.cogs_primary_quantity),2) From_Org_Net_Margin_Amount,
 txns_sum.to_curr_code To_Org_Curr_Code,
 nvl(gdr.conversion_date,:conversion_date) Curr_Conv_Date,
 round(nvl(gdr.conversion_rate,1),6) Curr_Conv_Rate,
 round((txns_sum.cogs_amount - txns_sum.revenue_amount + round((txns_sum.from_org_pii_cost * txns_sum.cogs_primary_quantity),2))
   * nvl(gdr.conversion_rate,1),2) Conv_Net_Margin_Amount,
 txns_sum.to_org_pii_cost To_Org_PII_Item_Cost,
 round(txns_sum.cogs_primary_quantity * txns_sum.to_org_pii_cost,2) To_Org_PII_Amount,
 -- Conv Margin Amount + To_Org_PII_Amount
 round((txns_sum.cogs_amount - txns_sum.revenue_amount + round((txns_sum.from_org_pii_cost * txns_sum.cogs_primary_quantity),2))
   * nvl(gdr.conversion_rate,1),2) + round(txns_sum.cogs_primary_quantity * txns_sum.to_org_pii_cost,2) Conv_Net_Margin_Less_PII
from
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:conversion_date and gdct.user_conversion_type=:user_conversion_type and gdct.conversion_type=gdr.conversion_type) gdr,
 -- ========================================================
 -- Section III: Condense the 2 union all statements into one line
 --              for each Transaction Id, reports 1 - 2.
 -- ========================================================
 (select txns.from_ledger_id,
  txns.from_ledger,
  txns.from_operating_unit_id,
  txns.from_operating_unit,
  txns.to_ledger_id,
  txns.to_ledger,
  txns.to_operating_unit_id,
  txns.to_operating_unit,
  txns.ship_from_org_id,
  txns.ship_from_org,
  txns.ship_to_org_id,
  txns.ship_to_org,
  txns.from_curr_code,
  txns.to_curr_code,
  txns.inventory_item_id,
  txns.item_number,
  txns.item_description,
  txns.item_type,
  txns.customer,
  txns.customer_number,
  txns.so_order_number,
  txns.so_header_id,
  txns.so_line_number,
  txns.so_line_id,
  txns.line_type_id,
  sum(txns.pr_number) pr_number,
  txns.price_list_id,
  txns.transaction_type_id,
  txns.transaction_id,
  txns.transaction_date,
  txns.lot_number,
  round(sum(txns.transaction_cost),5) transaction_cost,
  -- From Org profit in inventory costs
  nvl((select sum(cicd.item_cost)
       from cst_item_cost_details cicd,
    cst_cost_types cct,
    bom_resources br
       where cicd.inventory_item_id = txns.inventory_item_id
       and cicd.organization_id   = txns.ship_from_org_id
       and br.resource_id         = cicd.resource_id
       and 5=5                    -- p_pii_resource_code
       and cct.cost_type_id       = cicd.cost_type_id
       and 6=6                    -- p_pii_cost_type
     ),0) from_org_pii_cost,
  -- To Org profit in inventory costs
  nvl((select sum(cicd.item_cost)
       from cst_item_cost_details cicd,
    cst_cost_types cct,
    bom_resources br
       where cicd.inventory_item_id = txns.inventory_item_id
       and cicd.organization_id   = txns.ship_to_org_id
       and br.resource_id         = cicd.resource_id
       and 5=5                    -- p_pii_resource_code
       and cct.cost_type_id       = cicd.cost_type_id
       and 6=6                    -- p_pii_cost_type
     ),0) to_org_pii_cost,
  txns.currency_code,
  txns.uom_code,
  round(sum(txns.primary_quantity),3) cogs_primary_quantity,
  round(sum(txns.COGS_amount),2) cogs_amount,
  sum(txns.ar_invoice_id) ar_invoice_id,
  sum(txns.ar_invoice_line_number) ar_invoice_line_number, 
  round(sum(txns.unit_price),5) unit_price,
  round(sum(txns.quantity_invoiced),3) quantity_invoiced,
  round(sum(txns.revenue_amount),3) revenue_amount 
 from 
 (
  -- ======================================================== 
  -- Section IV:  Get the material, payables and revenue transactions
  --              which represent the Internal Order activity.
  --              Assume IR/ISO shipments may or may not use custom billing.
  --              Section III has 7 union all reports.
  -- ======================================================== 
  -- Report 1: First get the COGS for IR/ISO Intransit Shipments
  -- where title passes upon shipment (FOB_Point = 1, Shipment)
  -- ========================================================
  select 'Rept1 IR-ISO FOB Ship' rept_section,
  gl_from_org.ledger_id from_ledger_id,
  haou_from_org.organization_id from_operating_unit_id,
  gl_to_org.ledger_id to_ledger_id,
  haou_to_org.organization_id to_operating_unit_id,
  mp_from.organization_id ship_from_org_id,
  mp_to.organization_id ship_to_org_id,
  gl_from_org.currency_code from_curr_code,
  gl_to_org.currency_code to_curr_code,
  nvl(gl_from_org.short_name, gl_from_org.name) from_ledger,
  nvl(gl_to_org.short_name, gl_to_org.name) to_ledger,
  haou_from_org.name from_operating_unit,
  haou_to_org.name to_operating_unit,
  mp_from.organization_code ship_from_org,
  mp_to.organization_code ship_to_org,
  msiv.inventory_item_id,
  msiv.concatenated_segments item_number,
  msiv.description item_description,
  msiv.item_type,
  nvl(InterCo.customer, hz.party_name) customer,
  nvl(InterCo.customer_number, hca.account_number) customer_number,
  iso.order_number so_order_number,
  iso.header_id so_header_id,
  iso_line.line_number so_line_number,
  iso_line.line_id so_line_id,
  iso_line.line_type_id,
  to_number(decode(iso.order_source_id, 10, iso.orig_sys_document_ref, -9999)) pr_number,
  iso.price_list_id price_list_id,
  mmt.transaction_type_id,
  mmt.transaction_id transaction_id,
  mmt.transaction_date transaction_date,
  mtln.lot_number lot_number,
  -- Revision for version 1.7
  mmt.actual_cost transaction_cost,
  gl_from_org.currency_code currency_code,
  -- Revision for version 1.27
  muomv.uom_code,
  decode(mmt.transaction_type_id,
   61, nvl(mtln.primary_quantity,mmt.primary_quantity),
   95, nvl(mtln.primary_quantity,mmt.primary_quantity),
   nvl(mtln.primary_quantity,mmt.primary_quantity) * -1
        ) primary_quantity,
  -- Revision for version 1.25
  -- Calculate From Org COGS
  -- Quantity X Unit_Cost
  round(decode(mmt.transaction_type_id,
    61, nvl(mtln.primary_quantity,mmt.primary_quantity),
    95, nvl(mtln.primary_quantity,mmt.primary_quantity),
    nvl(mtln.primary_quantity,mmt.primary_quantity) * -1
    -- End revision for version 1.15
       ) * nvl(mmt.actual_cost,0)
     ,2) COGS_amount,
  0 ar_invoice_id,
  0 ar_invoice_line_number,
  0 unit_price,
  0 quantity_invoiced,
  0 revenue_amount
  from mtl_system_items_vl msiv,
  -- Revision for version 1.27
  mtl_units_of_measure_vl muomv,
  mtl_material_transactions mmt,
  mtl_transaction_lot_numbers mtln,
  oe_order_headers_all iso,  
  oe_order_lines_all iso_line,
  po_requisition_headers_all prh,   
  po_requisition_lines_all prl,
  mtl_parameters mp_from,   -- from org
  mtl_parameters mp_to,  -- to org
  -- Revision for version 1.15, comment out user information 
  -- fnd_user fu_iso,
  -- fnd_user fu_iso2,
  hz_cust_accounts_all hca,
  hz_cust_acct_sites_all hcs,
  hz_cust_site_uses_all hsu,
  hz_parties hz,
  -- From Information
  hr_organization_information hoi_from_org,
  hr_all_organization_units_vl haou_from_org, -- operating unit 
  gl_ledgers gl_from_org,
  -- To Information
  hr_organization_information hoi_to_org,
  hr_all_organization_units_vl haou_to_org, -- operating unit 
  gl_ledgers gl_to_org,
  -- Inline select for Customer and Operating_Unit information
  (select HOU_to.name to_ou,
   HOU_from.name from_ou,
   hou_to.organization_id to_ou_id,
   hou_from.organization_id from_ou_id,
   rc.customer_name customer,
   rc.customer_number customer_number,
   qlh_tl.name price_list,
   nvl(hsu.price_list_id, hca.price_list_id) price_list_id
   from hz_cust_site_uses_all hsu,           -- joins to intercompany relationships
   mtl_intercompany_parameters mip,     -- intercompany ship (from) and sell to relationships
   hz_cust_acct_sites_all hcs,
   hz_cust_accounts hca,
   qp_list_headers_tl qlh_tl,
   (select cust_account_id customer_id , 
    party.party_name customer_name , 
    cust_acct.account_number customer_number,
    cust_acct.price_list_id price_list_id 
    from hz_parties party, 
    hz_cust_accounts cust_acct 
    where cust_acct.party_id = party.party_id
   ) rc, 
   hr_all_organization_units_vl hou_to,
   hr_all_organization_units_vl hou_from
   where mip.customer_site_id            = hsu.site_use_id            -- internal customer information
   and hca.cust_account_id             = hcs.cust_account_id
   and hcs.cust_acct_site_id           = hsu.cust_acct_site_id
   and rc.customer_id                  = mip.customer_id
   and qlh_tl.list_header_id           = nvl(hsu.price_list_id, hca.price_list_id)
   and qlh_tl.language                 = userenv('lang')
   and hou_to.organization_id          = mip.sell_organization_id
   and hou_from.organization_id        = mip.ship_organization_id  
   -- Fix for version 1.4, the customer type is not set correctly for internal orgs
   -- This condition was preventing the internal To Orgs from being selected
   -- and hca.customer_type                = 'I'  -- Internal Customers
  ) InterCo
  -- ======================================================== 
  -- join the organization_id and item to the internal SO
  -- ======================================================== 
  where msiv.organization_id            = iso_line.ship_from_org_id 
  and msiv.inventory_item_id          = iso_line.inventory_item_id 
  and muomv.uom_code                  = msiv.primary_uom_code
  and mp_from.organization_id         = msiv.organization_id
  and mp_to.organization_id           = prl.destination_organization_id
  -- ======================================================== 
  -- use this condition to limit this sql for internal requisitions
  -- ======================================================== 
  and iso_line.order_source_id        = 10 -- internal requisitions
  and iso_line.line_category_code in ('ORDER')
  -- ======================================================== 
  -- Use these joins for order header to line and matl transactions
  -- mmt.trx_source_line_id is populated for internal req shipments
  -- ======================================================== 
  and iso.header_id                   = iso_line.header_id
  and mmt.trx_source_line_id          = iso_line.line_id
  and mmt.transaction_id              = mtln.transaction_id (+)
  -- ======================================================== 
  -- Only report intransit-related transactions
  -- ======================================================== 
  -- Revision for version 1.17
  -- and mmt.transaction_action_id in (12, 21)
  -- Only want Intransit Shipments when the FOB_Point = 1 (Shipment)
  -- as this represents the Debit to COGS for the Intransit Shipment.
  and mmt.transaction_action_id       = 21
  and mmt.fob_point                   = 1
  -- ======================================================== 
  -- Material Transaction date joins
  -- ======================================================== 
  and 7=7    -- p_trx_date_from, p_trx_date_to
  -- ======================================================== 
  -- use these conditions to join to purchase reqs
  -- ======================================================== 
  and prh.type_lookup_code            = 'INTERNAL'
  and iso.source_document_id          = prh.requisition_header_id
  and prl.requisition_header_id       = prh.requisition_header_id
  and prl.requisition_line_id         = iso_line.source_document_line_id
  -- Revision for version 1.15, comment out user information 
  -- and fu_iso.user_id                  = prh.created_by
  -- and fu_iso2.user_id                 = prh.last_updated_by
  -- ========================================================
  -- added for customer ship-to-information; replaces use of ra_customers
  -- d.volz 6-Oct-08
  -- ========================================================
  and iso_line.sold_to_org_id         = hca.cust_account_id
  and iso_line.Ship_to_org_id         = hsu.site_use_id
  and hcs.cust_acct_site_id           = hsu.cust_acct_site_id
  and hca.cust_account_id             = hcs.cust_account_id
  and hca.party_id                    = hz.party_id
  -- ========================================================
  -- From organization information
  -- ========================================================
  and hoi_from_org.org_information_context = 'Accounting Information'
  and hoi_from_org.organization_id    = mp_from.organization_id     -- ship from org for sales and COGS
  and InterCo.from_ou_id (+)          = to_number(hoi_from_org.org_information3) -- this gets the operating unit id
  and haou_from_org.organization_id   = to_number(hoi_from_org.org_information3) -- this gets the operating unit id
  and gl_from_org.ledger_id           = to_number(hoi_from_org.org_information1) 
  and 8=8                             -- p_from_org_ledger
  and gl_from_org.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
  -- ========================================================
  -- To organization information
  -- ========================================================
  and hoi_to_org.org_information_context = 'Accounting Information'
  and hoi_to_org.organization_id      = mp_to.organization_id     -- ship to org for sales and COGS
  and InterCo.to_ou_id                = to_number(hoi_to_org.org_information3) -- this gets the operating unit id
  and haou_to_org.organization_id     = to_number(hoi_to_org.org_information3) -- this gets the operating unit id
  and gl_to_org.ledger_id             = to_number(hoi_to_org.org_information1)
  and 9=9                             -- p_to_org_ledger
  and gl_to_org.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
  -- End revision for version 1.14
  -- Only report entries which cross operating units
  -- Doing this screens out transfers to the consignment organizations
  and haou_to_org.organization_id    <> haou_from_org.organization_id
  union all
  -- ======================================================== 
  -- Report 2: Get the IR/ISO COGS for IR/ISO Intransit Receipts
  -- where title passes upon receipt (FOB_Point = 2, Receipt)
  -- ========================================================
  select 'Rept2 IR-ISO FOB Receipt' rept_section,
  gl_from_org.ledger_id from_ledger_id,
  haou_from_org.organization_id from_operating_unit_id,
  gl_to_org.ledger_id to_ledger_id,
  haou_to_org.organization_id to_operating_unit_id,
  mp_from.organization_id ship_from_org_id,
  mp_to.organization_id ship_to_org_id,
  gl_from_org.currency_code from_curr_code,
  gl_to_org.currency_code to_curr_code,
  nvl(gl_from_org.short_name, gl_from_org.name) from_ledger,
  nvl(gl_to_org.short_name, gl_to_org.name) to_ledger,
  haou_from_org.name from_operating_unit,
  haou_to_org.name to_operating_unit,
  mp_from.organization_code ship_from_org,
  mp_to.organization_code ship_to_org,
  msiv.inventory_item_id,
  msiv.concatenated_segments item_number,
  msiv.description item_description,
  msiv.item_type,
  hz.party_name customer,
  hca.account_number customer_number,
  iso.order_number so_order_number,
  iso.header_id so_header_id,
  iso_line.line_number so_line_number,
  iso_line.line_id so_line_id,
  iso_line.line_type_id,
  to_number(decode (iso.order_source_id, 10, iso.orig_sys_document_ref, -9999)) pr_number,
  iso.price_list_id price_list_id,
  mmt.transaction_type_id,
  mmt.transaction_id transaction_id,
  mmt.transaction_date transaction_date,
  mtln.lot_number lot_number,
  -- Revision for version 1.7
  -- Have to use the Shipping Org's cost due to
  -- standard cost updates between the shipment
  -- and receipt transactions.
  mmt_ship.actual_cost transaction_cost,
  gl_from_org.currency_code currency_code,
  -- Revision for version 1.27
  muomv.uom_code,
  decode(mmt.transaction_type_id,
   95, nvl(mtln.primary_quantity, mmt.primary_quantity) * -1,
   nvl(mtln.primary_quantity, mmt.primary_quantity)
        ) primary_quantity,
  -- Calculate From Org COGS
  round(decode(mmt.transaction_type_id,
    95, nvl(mtln.primary_quantity, mmt.primary_quantity) * -1,
    nvl(mtln.primary_quantity, mmt.primary_quantity)
              ) * nvl(mmt_ship.actual_cost,0)
     ,5) COGS_amount,
  0 ar_invoice_id,
  0 ar_invoice_line_number,
  0 unit_price,
  0 quantity_invoiced,
  0 revenue_amount
  from mtl_system_items_vl msiv,
  -- Revision for version 1.27
  mtl_units_of_measure_vl muomv,
  mtl_material_transactions mmt,
  mtl_material_transactions mmt_ship,
  mtl_transaction_lot_numbers mtln,
  oe_order_headers_all iso,  
  oe_order_lines_all iso_line,  
  po_requisition_headers_all prh,   
  po_requisition_lines_all prl,
  mtl_parameters mp_from,   -- from org
  mtl_parameters mp_to,  -- to org
  -- Revision for version 1.15, comment out user information 
  -- fnd_user fu_iso,
  -- fnd_user fu_iso2,
  hz_cust_accounts_all hca,
  hz_cust_acct_sites_all hcs,
  hz_cust_site_uses_all hsu,
  hz_parties hz,
  -- From organization
  hr_organization_information hoi_from_org,
  hr_all_organization_units_vl haou_from_org, -- operating unit 
  gl_ledgers gl_from_org,    -- From GL
  -- To organization
  hr_organization_information hoi_to_org,
  hr_all_organization_units_vl haou_to_org, -- operating unit 
  gl_ledgers gl_to_org
  -- ======================================================== 
  -- Join the intransit requisition receipt to the parent
  -- material intransit shipment.  The mmt intransit shipment
  -- has the sales order id.
  -- ======================================================== 
  where mmt.transaction_source_type_id  = 7     -- Int Order Intr Rcpt
  -- Joins to find the Internal Order Shipment Transaction
  and mmt.transfer_transaction_id     = mmt_ship.transaction_id
  and mmt_ship.transaction_source_type_id = 8 -- Int Order Intr Ship
  -- ======================================================== 
  -- Only report intransit-related receipt transactions
  -- for when the title changes upon receipt as this
  -- represents the Debit to COGS for the Intransit Receipt.
  -- ======================================================== 
  and mmt.fob_point                   = 2 
  -- ========================================================
  -- ======================================================== 
  -- join the organization_id and item to the internal SO
  -- ======================================================== 
  and msiv.organization_id            = iso_line.ship_from_org_id 
  and msiv.inventory_item_id          = iso_line.inventory_item_id
  and mp_from.organization_id         = msiv.organization_id
  and mp_to.organization_id           = prl.destination_organization_id
  -- Revision for version 1.27
  and muomv.uom_code                  = msiv.primary_uom_code
  -- ======================================================== 
  -- use this condition to limit this sql for internal requisitions
  -- ======================================================== 
  and iso_line.order_source_id         = 10 -- internal requisitions
  and iso_line.line_category_code in ('ORDER')
  -- ======================================================== 
  -- use these joins for order line and header to matl transactions
  -- ======================================================== 
  -- Revision for version 1.15
  -- Join the parent ship mmt to ool using mmt.trx_source_line_id
  and mmt_ship.trx_source_line_id     = iso_line.line_id
  and iso.header_id                   = iso_line.header_id
  and mmt.transaction_id              = mtln.transaction_id (+)
  and 7=7    -- p_trx_date_from, p_trx_date_to
  -- ======================================================== 
  -- use these conditions to join to purchase reqs
  -- ======================================================== 
  and mmt.transaction_source_id       = prh.requisition_header_id
  and prh.type_lookup_code            = 'INTERNAL'
  and iso_line.source_document_line_id= prl.requisition_line_id
  and prl.requisition_header_id       = prh.requisition_header_id
  -- Revision for version 1.15, comment out user information 
  -- and fu_iso.user_id                  = prh.created_by
  -- and fu_iso2.user_id                 = prh.last_updated_by
  -- ========================================================
  -- added for customer ship-to-information; replaces use of ra_customers
  -- d.volz 6-Oct-08
  -- ========================================================
  and iso_line.sold_to_org_id         = hca.cust_account_id
  and iso_line.Ship_to_org_id         = hsu.site_use_id
  and hcs.cust_acct_site_id           = hsu.cust_acct_site_id
  and hca.cust_account_id             = hcs.cust_account_id
  and hca.party_id                    = hz.party_id
  -- ========================================================
  -- From organization information
  -- ========================================================
  and hoi_from_org.org_information_context = 'Accounting Information'
  and hoi_from_org.organization_id    = mp_from.organization_id     -- ship from org for sales and COGS
  and haou_from_org.organization_id   = to_number(hoi_from_org.org_information3) -- this gets the operating unit id
  and gl_from_org.ledger_id           = to_number(hoi_from_org.org_information1)
  and 8=8                             -- p_from_org_ledger
  -- ========================================================
  -- To organization information
  -- ========================================================
  and hoi_to_org.org_information_context = 'Accounting Information'
  and hoi_to_org.organization_id      = mp_to.organization_id     -- ship to org for sales and COGS
  and haou_to_org.organization_id     = to_number(hoi_to_org.org_information3) -- this gets the operating unit id
  and gl_to_org.ledger_id             = to_number(hoi_to_org.org_information1)
  and 9=9                             -- p_to_org_ledger
  -- Only report entries which cross operating units
  -- Doing this screens out transfers to the consignment organizations
  and haou_to_org.organization_id    <> haou_from_org.organization_id
  union all
  -- ======================================================== 
  -- Report 3.  Now get the Revenue for the Reports 1 and 2,
  -- for Intransit Shipments and Receipts, using standard Oracle
  -- processes for IR/ISO
  -- ========================================================
  select 'Rept3 IR-ISO Revenue for 1 and 2' rept_section,
  gl_from_org.ledger_id from_ledger_id,
  haou_from_org.organization_id from_operating_unit_id,
  gl_to_org.ledger_id to_ledger_id,
  haou_to_org.organization_id to_operating_unit_id,
  mp_from.organization_id ship_from_org_id,
  mp_to.organization_id ship_to_org_id,
  gl_from_org.currency_code from_curr_code,
  gl_to_org.currency_code to_curr_code,
  nvl(gl_from_org.short_name, gl_from_org.name) from_ledger,
  nvl(gl_to_org.short_name, gl_to_org.name) to_ledger,
  haou_from_org.name from_operating_unit,
  haou_to_org.name to_operating_unit,
  mp_from.organization_code ship_from_org,
  mp_to.organization_code ship_to_org,
  msiv.inventory_item_id,
  msiv.concatenated_segments item_number,
  msiv.description item_description,
  msiv.item_type,
  hz.party_name customer,
  hca.account_number customer_number,
  ooh.order_number so_order_number,
  ooh.header_id so_header_id,
  ool.line_number so_line_number,
  ool.line_id so_line_id,
  ool.line_type_id,
  0 pr_number,
  ool.price_list_id,
  -- These column selects needed in case the shipment was in a different month
  nvl((select mmt.transaction_type_id
   from mtl_material_transactions mmt
   where mmt.transaction_id = to_number(rctl.interface_line_attribute7)),0) transaction_type_id,
  to_number(rctl.interface_line_attribute7) transaction_id,
  (select mmt.transaction_date
   from mtl_material_transactions mmt
   where mmt.transaction_id = to_number(rctl.interface_line_attribute7)) transaction_date,
  (select max(mtln.lot_number)
   from mtl_transaction_lot_numbers mtln
   where mtln.transaction_id = to_number(rctl.interface_line_attribute7)) lot_number,
  0 transaction_cost,
  gl_from_org.currency_code,
  -- Revision for version 1.27
  muomv.uom_code,
  0 primary_quantity,
  0 COGS_amount,
  rct.customer_trx_id ar_invoice_id,
  rctl.line_number ar_invoice_line_number,
  decode(rct.invoice_currency_code,
   gl_from_org.currency_code, rctl.unit_selling_price,
   decode(rct.exchange_rate, null, 1, 0, 1, rct.exchange_rate) * rctl.unit_selling_price) unit_price,
  nvl(rctl.quantity_invoiced,0) * ucr.conversion_rate quantity_invoiced,  
  nvl(rctl.revenue_amount,0) revenue_amount
  from ra_cust_trx_line_gl_dist_all rctlgd,
  ra_customer_trx_lines_all rctl,
  ra_customer_trx_all rct,
  oe_order_lines_all ool,
  mtl_system_items_vl msiv,
  -- Revision for version 1.27
  mtl_units_of_measure_vl muomv,
  mtl_parameters mp_from, -- from org
  mtl_parameters mp_to, -- to org
  mtl_uom_conversions_view ucr,
  oe_order_headers_all ooh,
  hz_cust_accounts_all hca,
  hz_cust_acct_sites_all hcs,
  hz_cust_site_uses_all hsu,
  hz_parties hz,
  hr_organization_information hoi_from_org,
  hr_all_organization_units_vl haou_from_org, -- operating unit
  gl_ledgers gl_from_org,
  hr_organization_information hoi_to_org,
  hr_all_organization_units_vl haou_to_org, -- operating unit
  gl_ledgers gl_to_org
  -- ========================================================
  -- A/R invoice and Sales Order Joins
  -- ========================================================
   where rct.org_id                      = rctlgd.org_id
  and ool.org_id                      = ooh.org_id
  and rct.org_id                      = ool.org_id
  and 10=10                           -- p_trx_date_from, p_trx_date_to
  and rctl.line_type                  = 'LINE'
  and rctl.customer_trx_id            = rct.customer_trx_id
  and rct.complete_flag               = 'Y'
  and rctl.customer_trx_line_id       = rctlgd.customer_trx_line_id
  and rctl.interface_line_context     = 'INTERCOMPANY'
  and rctlgd.gl_date is not null
  and rctlgd.account_class            = 'REV'
  and rctlgd.account_set_flag         = 'N'
  and ool.line_id                     = decode(rctl.interface_line_context, 
        'ORDER ENTRY',to_number(nvl(rctl.interface_line_attribute6,0)),
        'INTERCOMPANY', decode(rctl.interface_line_attribute2,
           0,0,
           to_number(rctl.interface_line_attribute6)
                ), -99999
       )
  and ooh.order_number                = decode(rctl.interface_line_context, 
        'ORDER ENTRY',to_number(nvl(rctl.interface_line_attribute1,0) ),
        'INTERCOMPANY', to_number(rctl.interface_line_attribute1), -99999
       )
  and ool.line_category_code in ('RETURN', 'ORDER')
  and ool.line_id                     = nvl(ool.top_model_line_id, ool.line_id)
  and ooh.header_id                   = ool.header_id
  -- ========================================================
  -- Item Master to Sales Order Joins
  -- ========================================================
  and msiv.inventory_item_id          = ool.inventory_item_id
  and msiv.organization_id            = ool.ship_from_org_id
  and msiv.inventory_item_id          = ucr.inventory_item_id
  and msiv.organization_id            = ucr.organization_id
  and ucr.uom_code                    = rctl.uom_code
  -- Revision for version 1.27
  and muomv.uom_code                  = msiv.primary_uom_code
  -- ========================================================
  -- For customer ship-to-information; replaces use of ra_customers
  -- d.volz 6-Oct-08
  -- ========================================================
  and ool.sold_to_org_id              = hca.cust_account_id
  and ool.ship_to_org_id              = hsu.site_use_id
  and hcs.cust_acct_site_id           = hsu.cust_acct_site_id
  and hca.cust_account_id             = hcs.cust_account_id
  and hca.party_id                    = hz.party_id
  -- ========================================================
  -- From organization information
  -- ========================================================
  and hoi_from_org.org_information_context = 'Accounting Information'
  and hoi_from_org.organization_id    = mp_from.organization_id     -- ship from org for sales and COGS
  and haou_from_org.organization_id   = to_number(hoi_from_org.org_information3) -- this gets the operating unit id
  and gl_from_org.ledger_id           = to_number(hoi_from_org.org_information1)
  and 8=8                             -- p_from_org_ledger
  and mp_from.organization_id         = msiv.organization_id -- Ship From based on ool
  -- ========================================================
  -- To organization information
  -- ========================================================
  and mp_to.organization_id =
   (select prl.destination_organization_id
    from po_requisition_headers_all prh,
    po_requisition_lines_all prl
    where prh.type_lookup_code = 'INTERNAL'
    and ooh.source_document_id = prh.requisition_header_id
    and prl.requisition_header_id = prh.requisition_header_id
    and prl.requisition_line_id = ool.source_document_line_id)
  and hoi_to_org.org_information_context = 'Accounting Information'
  and hoi_to_org.organization_id      = mp_to.organization_id     -- ship to org for sales and COGS
  and haou_to_org.organization_id     = to_number(hoi_to_org.org_information3) -- gets the operating unit id
  and gl_to_org.ledger_id             = to_number(hoi_to_org.org_information1)
  and 9=9                             -- p_to_org_ledg