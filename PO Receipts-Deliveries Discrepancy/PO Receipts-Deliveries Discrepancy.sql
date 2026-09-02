/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Receipts/Deliveries Discrepancy
-- Description: PO Receipts/Deliveries Discrepancy highlights, at purchase order line and release level, differences between the quantities and amounts received into receiving (transaction type RECEIVE) and delivered to their final destination (DELIVER), including the impact of any CORRECT transactions applied to either side.

Quantity Received and Quantity Delivered show the original transaction quantities, Quantity Corrected Receipt and Quantity Corrected Delivery the net correction impact, and Total Quantity Received and Total Quantity Delivered the corrected totals. Quantity Variance and Cost Variance compare the corrected totals, with amounts valued at the purchase price of each receiving transaction.

Return to Vendor and Return to Receiving quantities (net of their corrections) are shown for reference but are not netted into the variance columns.

Provide a Last Receipt Date range (required): the report shows purchase order lines that had a receipt within that range, and for each it nets ALL of the line's receiving transactions to date, so the variance reflects the current outstanding received-vs-delivered position, not just activity in the window. Narrow the range (and/or add a PO, Supplier or Item filter) to keep large organizations fast.

By default the report shows discrepancy rows only (quantity or cost variance different from zero). Set parameter Discrepancies Only to No to list all purchase order receiving activity for the selected lines.
-- Excel Examle Output: https://www.enginatics.com/example/po-receipts-deliveries-discrepancy/
-- Library Link: https://www.enginatics.com/reports/po-receipts-deliveries-discrepancy/
-- Run Report: https://demo.enginatics.com/

select
z.operating_unit,
z.organization_code,
z.po_number,
z.release_num,
z.line_num,
z.supplier,
z.supplier_site,
z.item,
z.item_description,
z.item_type,
z.uom,
z.currency,
z.unit_price,
(select sum(plla.quantity-nvl(plla.quantity_cancelled,0)) from po_line_locations_all plla where plla.po_line_id=z.po_line_id and nvl(plla.po_release_id,-99)=z.po_release_id and plla.ship_to_organization_id=z.organization_id) quantity_requested,
z.last_receipt_date,
z.last_receipt_number,
z.quantity_received,
z.quantity_corrected_receipt,
z.quantity_delivered,
z.quantity_corrected_delivery,
z.total_quantity_received,
z.total_quantity_delivered,
z.amount_received,
z.amount_delivered,
z.quantity_variance,
z.cost_variance,
z.quantity_returned_to_vendor,
z.quantity_returned_to_receiving
from
(
select x.*
from
(
select /*+ leading(rl rt) use_nl(rt) index(rt rcv_transactions_n5) */
hou.name operating_unit,
mp.organization_code,
pha.segment1 po_number,
pra.release_num,
pla.line_num,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
msiv.concatenated_segments item,
nvl(msiv.description,pla.item_description) item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
pla.unit_meas_lookup_code uom,
pha.currency_code currency,
pla.unit_price,
pla.po_line_id,
nvl(pra.po_release_id,-99) po_release_id,
mp.organization_id,
max(case when rt.transaction_type='RECEIVE' then rt.transaction_date end) last_receipt_date,
max(case when rt.transaction_type='RECEIVE' then rsh.receipt_num end) keep (dense_rank last order by case when rt.transaction_type='RECEIVE' then rt.transaction_date end nulls first) last_receipt_number,
sum(case when rt.transaction_type='RECEIVE' then rt.source_doc_quantity end) quantity_received,
sum(case when rt.transaction_type='CORRECT' and rt_par.transaction_type='RECEIVE' then rt.source_doc_quantity end) quantity_corrected_receipt,
sum(case when rt.transaction_type='DELIVER' then rt.source_doc_quantity end) quantity_delivered,
sum(case when rt.transaction_type='CORRECT' and rt_par.transaction_type='DELIVER' then rt.source_doc_quantity end) quantity_corrected_delivery,
sum(case when rt.transaction_type='RECEIVE' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RECEIVE' then rt.source_doc_quantity end) total_quantity_received,
sum(case when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_par.transaction_type='DELIVER' then rt.source_doc_quantity end) total_quantity_delivered,
round(sum(case when rt.transaction_type='RECEIVE' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RECEIVE' then rt.source_doc_quantity*rt.po_unit_price end),2) amount_received,
round(sum(case when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_par.transaction_type='DELIVER' then rt.source_doc_quantity*rt.po_unit_price end),2) amount_delivered,
nvl(sum(case
when rt.transaction_type='RECEIVE' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RECEIVE' then rt.source_doc_quantity
when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_par.transaction_type='DELIVER' then -rt.source_doc_quantity
end),0) quantity_variance,
nvl(round(sum(case
when rt.transaction_type='RECEIVE' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RECEIVE' then rt.source_doc_quantity*rt.po_unit_price
when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_par.transaction_type='DELIVER' then -rt.source_doc_quantity*rt.po_unit_price
end),2),0) cost_variance,
sum(case when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RETURN TO VENDOR' then rt.source_doc_quantity end) quantity_returned_to_vendor,
sum(case when rt.transaction_type='RETURN TO RECEIVING' or rt.transaction_type='CORRECT' and rt_par.transaction_type='RETURN TO RECEIVING' then rt.source_doc_quantity end) quantity_returned_to_receiving
from
(select distinct rt2.po_line_id, rt2.organization_id from rcv_transactions rt2 where rt2.transaction_type='RECEIVE' and 3=3) rl,
rcv_transactions rt,
rcv_transactions rt_par,
rcv_shipment_headers rsh,
po_headers_all pha,
po_releases_all pra,
po_lines_all pla,
ap_suppliers aps,
ap_supplier_sites_all assa,
mtl_system_items_vl msiv,
mtl_parameters mp,
hr_operating_units hou
where
1=1 and
rt.transaction_type in ('RECEIVE','DELIVER','CORRECT','RETURN TO VENDOR','RETURN TO RECEIVING') and
rt.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
rt.po_line_id=rl.po_line_id and
rt.organization_id=rl.organization_id and
rt.parent_transaction_id=rt_par.transaction_id(+) and
(rt.transaction_type<>'CORRECT' or rt_par.transaction_type in ('RECEIVE','DELIVER','RETURN TO VENDOR','RETURN TO RECEIVING')) and
rt.shipment_header_id=rsh.shipment_header_id and
rt.po_header_id=pha.po_header_id and
rt.po_release_id=pra.po_release_id(+) and
rt.po_line_id=pla.po_line_id and
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
rt.organization_id=msiv.organization_id(+) and
rt.organization_id=mp.organization_id and
pha.org_id=hou.organization_id and
pha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
group by
hou.name,
mp.organization_code,
pha.segment1,
pra.release_num,
pla.line_num,
aps.vendor_name,
assa.vendor_site_code,
msiv.concatenated_segments,
nvl(msiv.description,pla.item_description),
msiv.item_type,
pla.unit_meas_lookup_code,
pha.currency_code,
pla.unit_price,
pla.po_line_id,
nvl(pra.po_release_id,-99),
mp.organization_id
) x
where
2=2
) z
order by
z.operating_unit,
z.organization_code,
z.po_number,
z.release_num,
z.line_num