/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Vendor Service Performance Analysis
-- Description: Imported from BI Publisher
Application: Purchasing
Source: Vendor Service Performance Analysis Report (XML)
Short Name: POXSERPR_XML
DB package: PO_POXSERPR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/po-vendor-service-performance-analysis/
-- Library Link: https://www.enginatics.com/reports/po-vendor-service-performance-analysis/
-- Run Report: https://demo.enginatics.com/

select
gsb.name company,
hou.name operating_unit,
pov.vendor_name,
pov.segment1 vendor_number,
msiv.concatenated_segments item,
pol.item_description,
case when pha.type_lookup_code in ('BLANKET','PLANNED') then pha.segment1||'-'||por.release_num else pha.segment1 end po_number,
pll.shipment_num,
nvl(pll.promised_date,pll.need_by_date) promised_date,
nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0) early_receipt_date,
nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0) cutoff_date,
hla.location_code ship_to_location,
round(pll.quantity-nvl(pll.quantity_cancelled,0),:p_qty_precision) quantity_ordered,
round(nvl(pll.quantity_received,0),:p_qty_precision) quantity_received,
round(pll.quantity_rejected,:p_qty_precision) quantity_rejected,
round(pll.quantity-nvl(pll.quantity_cancelled,0)-nvl(pll.quantity_received,0),:p_qty_precision) quantity_open,
case when nvl(pll.quantity_received,0)<pll.quantity-nvl(pll.quantity_cancelled,0)
     and nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0)<trunc(sysdate)
     then round(pll.quantity-nvl(pll.quantity_cancelled,0)-nvl(pll.quantity_received,0),:p_qty_precision)
end quantity_past_due,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date)),1,1,0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) quantity_early,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))-trunc(rct.transaction_date)),-1,1,0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) quantity_late,
(
select round(sum(
       case when trunc(rct.transaction_date) between trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))
                                                 and trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))
            then nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)
       end),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) quantity_on_time,
(
select round(sum(decode(pll.ship_to_location_id,rct.location_id,0,1)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) quantity_wrong_location,
round(pll.quantity_rejected*100/nullif(pll.quantity-nvl(pll.quantity_cancelled,0),0),:p_qty_precision) pct_quantity_rejected,
case when nvl(pll.quantity_received,0)<pll.quantity-nvl(pll.quantity_cancelled,0)
     and nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0)<trunc(sysdate)
     then round((pll.quantity-nvl(pll.quantity_cancelled,0)-nvl(pll.quantity_received,0))*100/nullif(pll.quantity-nvl(pll.quantity_cancelled,0),0),:p_qty_precision)
end pct_quantity_past_due,
(
select round(sum(
       case when trunc(rct.transaction_date) between trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))
                                                 and trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))
            then nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)
       end)*100/nullif(nvl(pll.quantity_received,0),0),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) pct_quantity_on_time,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))-trunc(rct.transaction_date)),-1,1,0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity))*100/nullif(nvl(pll.quantity_received,0),0),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) pct_quantity_late,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date)),1,1,0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity))*100/nullif(nvl(pll.quantity_received,0),0),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) pct_quantity_early,
(
select round(sum(decode(pll.ship_to_location_id,rct.location_id,0,1)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity))*100/nullif(nvl(pll.quantity_received,0),0),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) pct_quantity_wrong_location,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date)),1,
       trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date),0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) days_early,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))-trunc(rct.transaction_date)),-1,
       trunc(rct.transaction_date)-trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0)),0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) days_late,
(
select round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date)),1,
       trunc(nvl(pll.promised_date,pll.need_by_date)-nvl(pll.days_early_receipt_allowed,0))-trunc(rct.transaction_date),0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)+
round(sum(decode(sign(trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0))-trunc(rct.transaction_date)),-1,
       trunc(rct.transaction_date)-trunc(nvl(pll.promised_date,pll.need_by_date)+nvl(pll.days_late_receipt_allowed,0)),0)*
       nvl(rsl.quantity_received,0)*decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)),:p_qty_precision)
from rcv_transactions rct, rcv_shipment_lines rsl
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rct.shipment_line_id=rsl.shipment_line_id
) days_total_late_or_early,
(
select rct.primary_unit_of_measure
from rcv_transactions rct
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rownum=1
) primary_uom,
(
select decode(rct.primary_unit_of_measure,rct.unit_of_measure,1,rct.primary_quantity/rct.quantity)
from rcv_transactions rct
where rct.po_line_location_id=pll.line_location_id and rct.transaction_type='RECEIVE' and rownum=1
) conversion_rate,
papf.full_name buyer,
decode(pll.shipment_type,'STANDARD',pha.creation_date,por.creation_date) creation_date,
pll.unit_meas_lookup_code uom,
gsb.currency_code,
fspa.inventory_organization_id organization_id,
mck.concatenated_segments category,
pll.line_location_id,
pll.po_line_id,
pha.po_header_id
from
gl_sets_of_books gsb,
financials_system_params_all fspa,
hr_operating_units hou,
ap_suppliers pov,
po_headers_all pha,
po_releases_all por,
po_lines_all pol,
po_line_locations_all pll,
mtl_system_items_vl msiv,
mtl_categories_b_kfv mck,
per_all_people_f papf,
hr_locations_all hla
where
1=1 and
gsb.set_of_books_id=fspa.set_of_books_id and
fspa.org_id=hou.organization_id and
pha.org_id=hou.organization_id and
pha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
pha.vendor_id=pov.vendor_id and
pha.po_header_id=pol.po_header_id and
pol.po_line_id=pll.po_line_id and
pll.po_release_id=por.po_release_id(+) and
pol.item_id=msiv.inventory_item_id(+) and
fspa.inventory_organization_id=msiv.organization_id(+) and
pol.category_id=mck.category_id(+) and
pha.agent_id=papf.person_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
decode(hr_security.view_all,'Y','TRUE',hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id,papf.person_type_id,papf.employee_number,papf.applicant_number,papf.npw_number))='TRUE' and
decode(hr_general.get_xbg_profile,'Y',papf.business_group_id,hr_general.get_business_group_id)=papf.business_group_id and
pll.ship_to_location_id=hla.location_id(+) and
nvl(pll.cancel_flag,'N')='N' and
pll.shipment_type in ('STANDARD','BLANKET','SCHEDULED') and
pha.type_lookup_code in ('STANDARD','BLANKET','PLANNED') and
pol.order_type_lookup_code in ('QUANTITY','AMOUNT') and
(pll.promised_date is not null or pll.need_by_date is not null) and
exists (select null from rcv_transactions rct where rct.transaction_type='RECEIVE' and rct.po_header_id=pha.po_header_id and rct.po_line_id=pol.po_line_id and rct.po_line_location_id=pll.line_location_id)
order by
pov.vendor_name,
pov.segment1,
msiv.concatenated_segments,
pol.item_description,
po_number,
pll.shipment_num