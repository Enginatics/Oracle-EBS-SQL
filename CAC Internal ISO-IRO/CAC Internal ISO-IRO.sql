/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Internal ISO-IRO
-- Description: Report to display the open internal sales orders and requisition numbers, with aging dates and other useful information.

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_open_iro.sql
-- |
-- |  Parameters:
-- |  p_src_dest_type -- Determines if the specified Inventory Organization is the Source Org or Desintation Org or either (if left null)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to display the open internal sales orders and requisition numbers, 
-- |  with aging dates and other useful information.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     12 Nov 2009 Douglas Volz   Initial Coding for Client
-- |  1.1     01 Sep 2010 Douglas Volz   Added Ledger and Operating Unit info
-- |                                     Added condition to avoid old pre-conversion orgs
-- |  1.2     30 Mar 2011 Douglas Volz   Added condition to avoid disabled orgs,
-- |                                     added Ledger parameter
-- |  1.3     18 Nov 2012 Douglas Volz   Removed client-specific org conditions
-- |  1.4     16 Jan 2020 Douglas Volz   Added org code, operating unit parameters
-- |                                     category set parameters, item type and status.
-- |  1.5     09 Apr 2020 Douglas Volz   Replaced tables for multi-language capabilities:
-- |                                     mtl_system_items with mtl_system_items_vl
-- |                                     mtl_categories_b with mtl_categories_vl
-- |                                     hr_all_organization_units with hr_all_organization_units_vl
-- |  1.6     07 Jul 2022 Douglas Volz   Replace with multi-lang item status and UOM_Codes.
-- |  1.7     05 May 2024 Eric Clegg Added ability to choose Source Organization or Detination Organization (or either)
-- |                                     Removed the OU and Ledger securoty clauses as they dont make sense in this report
-- |                                     Removed restriction on Requisition Type so report has visibility of ISOs from internally sourced PO Requisition Lines
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-internal-iso-iro/
-- Library Link: https://www.enginatics.com/reports/cac-internal-iso-iro/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
(select haouv.name from hr_all_organization_units_vl haouv where ood.operating_unit=haouv.organization_id) operating_unit,
mp.organization_code ship_from_org,
mp2.organization_code ship_to_org,
msiv.concatenated_segments item,
msiv.description item_description,
muomv.uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
misv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
&category_columns
hp.party_name customer,
hca.account_number customer_number,
ooha.order_number sales_order_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') sales_order_line,
xxen_util.yes(oola.open_flag) open,
ooha.orig_sys_document_ref requisition_number,
xxen_util.meaning(prha.type_lookup_code,'REQUISITION TYPE',201) requisition_type,
ottt.name order_type,
oola.flow_status_code status,
hp.address1 address_line_1,
hp.address2 address_line_2,
hcsua.location location_number,
hl.city,
hl.state,
hl.county,
hl.country,
xxen_util.client_time(prla.need_by_date) need_by_date,
xxen_util.client_time(oola.request_date) request_date,
xxen_util.client_time(oola.promise_date) promise_date,
xxen_util.client_time(oola.schedule_ship_date) schedule_ship_date,
xxen_util.client_time(oola.schedule_arrival_date) schedule_arrival_date,
xxen_util.client_time(oola.actual_shipment_date) actual_shipment_date,
sysdate-ooha.request_date days_outstanding,
case
when sysdate-ooha.request_date<31  then '30 days'
when sysdate-ooha.request_date<61  then '31 to 60 days'
when sysdate-ooha.request_date<91  then '61 to 90 days'
when sysdate-ooha.request_date<121 then '91 to 120 days'
when sysdate-ooha.request_date<151 then '121 to 150 days'
when sysdate-ooha.request_date<181 then '151 to 180 days'
else 'Over 180 days'
end aging_date,
oola.order_quantity_uom order_uom,
oola.ordered_quantity,
gl.currency_code,
cic.item_cost unit_cost,
round(oola.ordered_quantity*cic.item_cost,2) cogs_amount,
xxen_util.user_name(oola.created_by) so_created_by,
xxen_util.client_time(oola.creation_date) so_creation_date,
xxen_util.user_name(oola.last_updated_by) so_last_updated_by,
xxen_util.client_time(oola.last_update_date) so_last_update_date,
xxen_util.user_name(prha.created_by) ir_created_by,
xxen_util.client_time(prha.creation_date) ir_creation_date,
xxen_util.user_name(prha.last_updated_by) ir_last_updated_by,
xxen_util.client_time(prha.last_update_date) ir_last_update_date
from
po_requisition_lines_all prla,
po_requisition_headers_all prha,
mtl_parameters mp2,
oe_order_lines_all oola,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
org_organization_definitions ood,
mtl_parameters mp,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_units_of_measure_vl muomv,
cst_item_costs cic,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl
where
1=1 and
(
prla.destination_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) or
oola.ship_from_org_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
) and
nvl(:p_src_dest_type,'Either')=nvl(:p_src_dest_type,'Either') and
prla.requisition_header_id=prha.requisition_header_id and
prla.destination_organization_id=mp2.organization_id and
prla.requisition_line_id=oola.source_document_line_id and
oola.line_category_code='ORDER' and
oola.order_source_id=10 and --internal requisitions
oola.header_id=ooha.header_id and
oola.line_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
oola.ship_from_org_id=ood.organization_id and
sysdate<nvl(ood.disable_date,sysdate+1) and --only active orgs
ood.set_of_books_id=gl.ledger_id and
oola.ship_from_org_id=mp.organization_id and
oola.inventory_item_id=msiv.inventory_item_id and
oola.ship_from_org_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.primary_uom_code=muomv.uom_code and
msiv.inventory_item_id=cic.inventory_item_id and
msiv.organization_id=cic.organization_id and
mp.primary_cost_method=cic.cost_type_id and
oola.sold_to_org_id=hca.cust_account_id and
hca.party_id=hp.party_id and
oola.ship_to_org_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hps.location_id=hl.location_id
order by
nvl(gl.short_name,gl.name),
operating_unit,
mp.organization_code,
mp2.organization_code,
msiv.concatenated_segments,
hp.party_name,
ooha.order_number,
oola.line_number