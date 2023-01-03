/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Invoice Price Variance
-- Description: Imported Oracle standard Invoice Price Variance report
Application: Purchasing
Source: Invoice Price Variance Report
Short Name: POXRCIPV
-- Excel Examle Output: https://www.enginatics.com/example/po-invoice-price-variance/
-- Library Link: https://www.enginatics.com/reports/po-invoice-price-variance/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
gp.period_name,
pla.operating_unit,
mp.organization_code,
aipvv.invoice_num,
aipvv.invoice_date,
decode(
decode(aipvv.quantity_invoiced,0,0,null,0,nvl(aipvv.quantity_invoiced,1)/abs(nvl(aipvv.quantity_invoiced,1))),
0,:cp_adjustment,
1,:cp_entry,
-1,:cp_reversal
) entry_type,
mck.concatenated_segments category,
msiv.concatenated_segments item,
msiv.description item_description,
gcck1.concatenated_segments variance_account,
gcck.concatenated_segments charge_account,
round((aipvv.quantity_invoiced /(decode(plla.match_option,'R', po_uom_s.po_uom_convert_p(pla.unit_meas_lookup_code,rct.unit_of_measure,pla.item_id),1))),20) quantity_invoiced,
nvl(aipvv.invoice_rate,1) invoice_rate,
aipvv.invoice_amount,
aipvv.invoice_price ,
nvl(pda.rate,nvl(pha.rate,1)) po_rate,
plla.price_override po_price,
rct.unit_of_measure receipt_unit,
pov.vendor_name vendor,
case when pha.type_lookup_code in ('BLANKET','PLANNED') then pha.segment1||' - '||pra.release_num else pha.segment1 end po_number_release,
pha.currency_code currency,
aipvv.invoice_currency,
pla.line_num,
pla.unit_meas_lookup_code unit,
lot.location_code location,
round(
decode(nvl(aipvv.quantity_invoiced,0),0,
decode(aipvv.price_var,null,decode(aipvv.invoice_rate,null,aipvv.invoice_amount,aipvv.invoice_base_amount),aipvv.price_var * nvl(aipvv.invoice_rate, 1)),
aipvv.invoice_price * nvl(aipvv.invoice_rate,1)
) * decode(plla.match_option,'R',po_uom_s.po_uom_convert_p(pla.unit_meas_lookup_code,rct.unit_of_measure,pla.item_id),1),nvl(fc.extended_precision,fc.precision)) invoice_base_price,
round(plla.price_override * decode(plla.match_option,'R',decode(rct.transaction_id,null,nvl(pha.rate,1),nvl(rct.currency_conversion_rate,1)),nvl(pha.rate,1)),nvl(fc.extended_precision,fc.precision)) po_base_price,
decode(
aipvv.invoice_rate,
null, aipvv.price_var,
aipvv.base_price_var
) base_inv_price_var,
aipvv.exch_rate_var ex_rate_vari,
pla.item_id
from
gl_ledgers gl,
fnd_currencies fc,
gl_periods gp,
mtl_parameters mp,
gl_code_combinations_kfv gcck1,
gl_code_combinations_kfv gcck,
po_distributions_all pda,
po_line_locations_all plla,
(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
hou.name operating_unit,
hou.set_of_books_id
from
po_lines_all pla,
hr_operating_units hou
where
2=2 and
pla.org_id=hou.organization_id
) pla,
po_releases_all pra,
po_headers_all pha,
ap_suppliers pov,
ap_invoice_price_var_v aipvv,
mtl_system_items_vl msiv,
mtl_categories_kfv mck,
hr_locations_all_tl lot,
rcv_transactions rct
where
1=1 and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gl.currency_code=fc.currency_code and
gl.ledger_id=pla.set_of_books_id and
pla.inventory_organization_id=mp.organization_id and
pla.inventory_organization_id=msiv.organization_id and
aipvv.po_distribution_id=pda.po_distribution_id and
pda.line_location_id=plla.line_location_id and
plla.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=pov.vendor_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
pla.category_id=mck.category_id and
gcck.code_combination_id=pda.code_combination_id and
gcck1.code_combination_id=pda.variance_account_id and
lot.location_id(+)=plla.ship_to_location_id and
plla.ship_to_location_id is not null and
lot.language(+)=userenv('lang') and
pda.destination_type_code in('INVENTORY','SHOP FLOOR') and
aipvv.accounting_date between gp.start_date and gp.end_date and
aipvv.rcv_transaction_id=rct.transaction_id(+) and
pha.type_lookup_code in('STANDARD','BLANKET','PLANNED') and
plla.shipment_type in('STANDARD','BLANKET','SCHEDULED')
order by
mck.concatenated_segments,
aipvv.invoice_currency,
msiv.concatenated_segments,
pov.vendor_name,
po_number_release,
pla.line_num,
aipvv.invoice_date,
po_rate