/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Cancelled Orders
-- Description: Imported from BI Publisher
Description: Cancelled Orders Report
Application: Order Management
Source: Cancelled Orders Report (XML)
Short Name: OEXOEOCS_XML
DB package: ONT_OEXOEOCS_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ont-cancelled-orders/
-- Library Link: https://www.enginatics.com/reports/ont-cancelled-orders/
-- Run Report: https://demo.enginatics.com/

select
 x.customer_name,
 x.customer_number,
 x.order_number,
 x.order_date,
 x.created_by,
 x.salesperson,
 x.order_currency,
 x.currency report_currency,
 x.line_number,
 x.category,
 x.item,
 &category_columns
 x.cancelled_qty,
 x.uom,
 x.amount,
 x.secondary_cancelled_quantity,
 x.secondary_uom,
 x.cancelled_date,
 x.cancelled_by,
 x.cancelled_reason,
 x.cancelled_comments,
 x.line_salesperson,
 x.conversion_type,
 x.conversion_rate,
 x.line_num,
 x.shipment_num,
 x.option_num
from
(
select distinct
 l.line_id,
 decode(upper(:p_order_by), 'SALESREP', sr.name, null) dummy_salesrep,
 decode(upper(:p_order_by), 'ORDER_DATE', h.ordered_date, null) dummy_order_date,
 decode(upper(:p_order_by), 'ORDER_NUMBER', h.order_number, null) dummy_order_number,
 org.name customer_name,
 org.customer_number customer_number,
 h.order_number order_number,
 trunc(h.ordered_date) order_date,
 xxen_util.user_name(h.created_by) created_by,
 sr.name salesperson,
 h.transactional_curr_code order_currency,
 ont_oexoeocs_xmlp_pkg.c_currency_codeformula(h.transactional_curr_code) currency,
 decode(l.item_type_code,'SERVICE',l.line_number ||'.'|| l.shipment_number||'.'|| l.option_number ||'.'||l.component_number || decode(l.service_number,null,null,'.'||l.service_number), 'INCLUDED',l.line_number ||'.'|| l.shipment_number||'.'|| l.option_number ||'.'||l.component_number ||decode(l.service_number,null,null,'.'||l.service_number), l.line_number || '.' || l.shipment_number || decode(l.option_number,null,null,'.'||l.option_number)) line_number,
 l.line_number line_num,
 l.shipment_number shipment_num,
 l.option_number option_num,
 l.line_category_code category,
 ont_oexoeocs_xmlp_pkg.Item_dspFormula (l.item_identifier_type , l.inventory_item_id, l.ordered_item_id,l.ordered_item,si.organization_id,si.inventory_item_id) item,
 l.item_identifier_type item_identifier_type,
 l.cancelled_quantity cancelled_qty,
 l.order_quantity_uom uom,
 ont_oexoeocs_xmlp_pkg.c_amountformula(( nvl ( l.cancelled_quantity , 0 ) * nvl ( l.unit_selling_price , 0 ) ), ont_oexoeocs_xmlp_pkg.c_gl_conv_rateformula(h.transactional_curr_code, h.ordered_date, h.conversion_type_code, h.conversion_rate), ont_oexoeocs_xmlp_pkg.c_precisionformula(h.transactional_curr_code)) amount,
 l.cancelled_quantity2 secondary_cancelled_quantity,
 l.ordered_quantity_uom2 secondary_uom,
 sr2.name line_salesperson,
 h.conversion_type_code conversion_type,
 ont_oexoeocs_xmlp_pkg.c_gl_conv_rateformula(h.transactional_curr_code, h.ordered_date, h.conversion_type_code, h.conversion_rate) conversion_rate,
 oolh.hist_creation_date cancelled_date,
 xxen_util.user_name(oolh.hist_created_by) cancelled_by,
 nvl(xxen_util.meaning(ore.reason_code,'CANCEL_CODE',660),ore.reason_code) cancelled_reason,
 ore.comments cancelled_comments,
 l.line_id order_line_id,
 si.organization_id,
 si.inventory_item_id
from
 oe_order_lines_all l,
 oe_order_headers_all h,
 mtl_system_items_vl si,
 ra_salesreps_all sr,
 ra_salesreps_all sr2,
 oe_sold_to_orgs_v org,
 (select distinct
  oolh.header_id,
  oolh.line_id,
  last_value(oolh.hist_creation_date) over (partition by oolh.line_id order by oolh.hist_creation_date) hist_creation_date,
  last_value(oolh.hist_created_by) over (partition by oolh.line_id order by oolh.hist_creation_date) hist_created_by,
  last_value(oolh.reason_id) over (partition by oolh.line_id order by oolh.hist_creation_date) reason_id
  from
  oe_order_lines_history oolh
  where
     nvl(oolh.audit_flag(+), 'Y') = 'Y'
  and oolh.hist_type_code(+) = 'CANCELLATION'
  ) oolh,
 oe_reasons ore
where
     nvl(:p_item_seg,'?') = nvl(:p_item_seg,'?')
 and l.header_id = h.header_id
 and l.cancelled_quantity > 0
 and h.salesrep_id=sr.salesrep_id(+)
 and l.salesrep_id=sr2.salesrep_id(+)
 and si.organization_id+0 = oe_sys_parameters.value('MASTER_ORGANIZATION_ID',mo_global.get_current_org_id())
 and l.inventory_item_id=si.inventory_item_id
 and nvl(h.org_id,0) = nvl(:p_organization_id1,0)
 and nvl(sr.org_id,0) = nvl(:p_organization_id1,0)
 and nvl(sr2.org_id,0) = nvl(:p_organization_id1,0)
 and org.organization_id = l.sold_to_org_id
 and oolh.header_id(+) = l.header_id
 and oolh.line_id(+) = l.line_id
 and ore.reason_id(+) = oolh.reason_id
 &lp_order_num &lp_salesrep &lp_customer_name &lp_order_date &lp_item &lp_order_category &lp_line_category
) x
order by
 x.dummy_salesrep asc,
 x.dummy_order_date asc,
 x.dummy_order_number asc,
 x.customer_name asc,
 x.order_number asc,
 x.salesperson asc,
 x.order_date asc,
 x.order_currency asc,
 x.conversion_type asc,
 x.currency asc,
 x.line_num,
 x.shipment_num,
 x.option_num