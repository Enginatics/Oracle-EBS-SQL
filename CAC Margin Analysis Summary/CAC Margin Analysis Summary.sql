/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Margin Analysis Summary
-- Description: Report for the margin from the customer invoices and shipments, based on the standard Oracle Margin table, cstmarginsummary. (If you want to show the COGS and Sales Accounts use report CAC Margin Analysis Account Summary.)
-- Note: in order to run this report, you first need to run the Margin Analysis Load Run request (to populate the standard Oracle Margin table).
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date (mandatory).
-- Transaction Date To: enter the ending transaction date (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Customer Name: enter the specific customer name you wish to report (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2006 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 18 APR 2006 Douglas Volz Initial Coding
-- -- | 1.1 15 MAY 2006 Douglas Volz Working version
-- -- | 1.2 17 MAY 2006 Douglas Volz Added order line and date information
-- -- | 1.3 14 Dec 2012 Douglas Volz Modified for Garlock, changed category set
-- -- | 1.4 19 Dec 2012 Douglas Volz Bug fix for category set name
-- -- | 1.5 29 Jan 2013 Douglas Volz Fixed date parameters to have same format
-- -- | as other reports; had to remove sales and COGS accounts as these are
-- -- | on different rows and would need to rewrite the code to include this.
-- -- | Also added a join for mic and mcs for categorysetid to avoid duplicate rows.
-- -- | And added a having clause to screen out zero rows.
-- -- | 1.6 25 Feb 2013 Douglas Volz Added apps.mtldefaultcategorysets mdcs table
-- -- | to make the script more generic
-- -- | 1.7 27 Feb 2017 Douglas Volz Modified for Item Category and customer
-- -- | information.
-- -- | 1.8 28 Feb 2017 Douglas Volz Removed sales rep information,
-- -- | was causing cross-joining.
-- -- | 1.9 22 May 2017 Douglas Volz Adding Inventory item category
-- -- | 1.10 23 May 2020 Douglas Volz Use multi-language table for UOM Code, item
-- -- | master, OE transaction types and hr organization names.
-- -- | 1.11 14 Jun 2024 Douglas Volz Remove tabs, reinstall parameters and org access controls.
-- -- | 1.12 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-margin-analysis-summary/
-- Library Link: https://www.enginatics.com/reports/cac-margin-analysis-summary/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
cms.customer_class_code,
hp.party_name customer,
hca.account_number customer_number,
cms.order_number,
cms.line_number order_line,
ottt.name order_type,
trunc(cms.gl_date) transaction_date,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
&category_columns
msiv.primary_uom_code uom_code,
round(sum(nvl(cms.invoiced_amount,0))/decode(sum(nvl(cms.invoice_line_quantity,0)),0,1,sum(nvl(cms.invoice_line_quantity,0))),5) unit_price,
round(sum(nvl(cms.cogs_amount,0))/decode(sum(nvl(cms.ship_quantity,0)),0,1,sum(nvl(cms.ship_quantity,0))),5) unit_cost,
sum(nvl(cms.invoice_line_quantity,0)) invoice_quantity,
sum(nvl(cms.ship_quantity,0)) ship_quantity,
sum(nvl(cms.invoiced_amount,0)) sales_amount,
sum(nvl(cms.cogs_amount,0)) cogs_amount,
sum(nvl(cms.invoiced_amount,0))-sum(nvl(cms.cogs_amount,0)) margin,
round((sum(nvl(cms.invoiced_amount,0))-sum(nvl(cms.cogs_amount,0)))/decode(sum(nvl(cms.invoiced_amount,0)),0,1,sum(nvl(cms.invoiced_amount,0)))*100,1) percent
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_margin_summary cms,
oe_transaction_types_tl ottt,
hz_cust_accounts hca,
hz_parties hp,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=cms.parent_organization_id and
haouv_ou.organization_id=cms.org_id and
cms.order_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
cms.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
cms.parent_organization_id=msiv.organization_id and
cms.parent_inventory_item_id=msiv.inventory_item_id
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
mp.organization_code,
cms.customer_class_code,
cms.sold_to_customer_name,
hp.party_name,
hca.account_number,
cms.order_number,
cms.line_number,
ottt.name,
trunc(cms.gl_date),
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.primary_uom_code,
msiv.inventory_item_id,
msiv.organization_id
order by
ledger,
operating_unit,
org_code,
customer,
cms.order_number,
cms.line_number
