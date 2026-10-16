/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Suppliers Revenue by Period
-- Description: AP invoice amount per supplier and invoice currency, with one column per GL period from Period From to Period To.
-- An invoice is counted in the period of its invoice GL date. Periods are taken from the ledger's accounting calendar, excluding adjustment periods, and each column is named after the month the period falls in.
-- Excel Example Output: https://www.enginatics.com/example/ap-suppliers-revenue-by-period/
-- Library Link: https://www.enginatics.com/reports/ap-suppliers-revenue-by-period/
-- Run Report: https://demo.enginatics.com/

select
&lp_columns
x.supplier_name,
x.supplier_number,
x.type,
&period_columns
sum(x.invoice_amount) total,
x.currency
from
(
select
gl.name ledger,
hou.name operating_unit,
aps.vendor_name supplier_name,
aps.segment1 supplier_number,
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) type,
(select trunc(gp.start_date+8,'mm') from gl_periods gp where gl.period_set_name=gp.period_set_name and gl.accounted_period_type=gp.period_type and gp.adjustment_period_flag='N' and aia.gl_date>=gp.start_date and aia.gl_date<gp.end_date+1) period_month,
aia.invoice_amount,
aia.invoice_currency_code currency
from
gl_ledgers gl,
hr_operating_units hou,
ap_invoices_all aia,
ap_suppliers aps
where
1=1 and
gl.ledger_id=hou.set_of_books_id and
hou.organization_id=aia.org_id and
aia.vendor_id=aps.vendor_id
) x
group by
&lp_columns
x.supplier_name,
x.supplier_number,
x.type,
x.currency
order by
&lp_columns
x.supplier_name,
x.currency
