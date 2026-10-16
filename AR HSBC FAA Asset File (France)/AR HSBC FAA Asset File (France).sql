/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR HSBC FAA Asset File (France)
-- Description: Extracts completed Receivables invoices and credit memos in the HSBC FACTORING FRANCE FAA file format, for invoice discounting. One 532 character record per document.
-- The report is implemented from the HSBC specification document "HFF - Invoice Discounting - Asset File IT Protocol.pdf" dated 09/09/2025, and its output has been validated against both the field table in that document and the sample file supplied with it. The 31 zones are, in order, each followed by a semicolon: File type FAA (3), Seller account number (5), File creation date YYYYMMDDHHMM (12), Debtor's Seller Identifier (15), Debtor ID number (9), Debtor Activity Code (5), Debtor Country Code (2), Debtor's corporate name (40), Debtor's trade name (40), Debtor Address 1 to 3 (30 each), Debtor Town (30), Debtor postal code (10), Debtor contact name (20), Debtor telephone (15), Debtor fax (15), Document type (1), Document number (20), Document's secondary number (1), Credited invoice number (20), Document issue date YYYYMMDD (8), Document due date YYYYMMDD (8), Document currency (3), Document amount including tax (15), Document amount excluding tax (15), Document VAT rate (4), Order reference (10), Other invoice reference (25), Invoice Status (30), Free field (30).
-- Document type is F for an invoice and A for a credit note. Amounts are always positive, are expressed in the smallest unit of the invoice currency with no decimal separator, and are zero filled to the left. The VAT rate is the highest rate on the document, expressed without a decimal point, so 20 per cent is 2000. The credited invoice number is populated on a credit memo with the invoice it is applied to, and is blank on an invoice.
-- Amount including tax is the document total, being the sum of all instalments. Amount excluding tax is that total less the tax lines. The due date is the earliest instalment due date. The debtor name, address, town and postal code come from the bill to site. Invoice Status is RGL, or LIT1 when the document has an amount in dispute. Semicolons, tabs and line breaks are removed from text zones so they cannot break a record.
-- Run with Output Format set to TSV and Exclude Column Headers set to Yes, and set the Server Output Directory runtime option to the directory the file should be written to. The file is written as FAA.
-- HSBC require a .txt extension, CR LF line endings and ANSI encoding. The report carries hsbcfaarename.sh as its Custom Postprocess to apply all three, so the script must be installed as $XXENTOP/bin/custom/hsbcfaarename.sh and be executable. It only acts on the file in the Server Output Directory, so the concurrent request output is unaffected and View Output continues to work.
-- The Seller account number is allocated by HSBC and differs by currency for the same seller, so a file must cover a single currency. Currency is therefore a required parameter, defaulted to the functional currency of the selected operating unit. Where invoices are raised in more than one currency, run the report once per currency with the matching Seller account number.
-- Excel Example Output: https://www.enginatics.com/example/ar-hsbc-faa-asset-file-france/
-- Library Link: https://www.enginatics.com/reports/ar-hsbc-faa-asset-file-france/
-- Run Report: https://demo.enginatics.com/

select
'FAA'||';'||
lpad(nvl(substr(regexp_replace(:seller_account_number,'[^0-9]'),1,5),'0'),5,'0')||';'||
to_char(greatest(xxen_util.client_time(sysdate),max(y.document_date) over ()),'YYYYMMDDHH24MI')||';'||
rpad(nvl(substr(y.debtor_identifier,1,15),' '),15)||';'||
lpad(nvl(substr(regexp_replace(y.debtor_id_number,'[^0-9]'),1,9),'0'),9,'0')||';'||
lpad(nvl(substr(regexp_replace(y.debtor_activity_code,'[^0-9]'),1,5),'0'),5,'0')||';'||
rpad(nvl(substr(y.country,1,2),' '),2)||';'||
rpad(nvl(substr(y.debtor_name,1,40),' '),40)||';'||
rpad(nvl(substr(y.trade_name,1,40),' '),40)||';'||
rpad(nvl(substr(y.address1,1,30),' '),30)||';'||
rpad(nvl(substr(y.address2,1,30),' '),30)||';'||
rpad(nvl(substr(y.address3,1,30),' '),30)||';'||
rpad(nvl(substr(y.town,1,30),' '),30)||';'||
rpad(nvl(substr(y.postal_code,1,10),' '),10)||';'||
rpad(nvl(substr(y.contact_name,1,20),' '),20)||';'||
rpad(nvl(substr(y.telephone,1,15),' '),15)||';'||
rpad(nvl(substr(y.fax,1,15),' '),15)||';'||
y.document_type||';'||
rpad(nvl(substr(y.document_number,1,20),' '),20)||';'||
'D'||';'||
rpad(nvl(substr(y.credited_invoice_number,1,20),' '),20)||';'||
nvl(to_char(y.document_date,'YYYYMMDD'),'00000000')||';'||
nvl(to_char(y.due_date,'YYYYMMDD'),'00000000')||';'||
rpad(nvl(substr(y.currency,1,3),' '),3)||';'||
lpad(to_char(round(abs(nvl(y.amount_including_tax,0))*power(10,nvl(y.currency_precision,2))),'FM999999999999999'),15,'0')||';'||
lpad(to_char(round(abs(nvl(y.amount_excluding_tax,0))*power(10,nvl(y.currency_precision,2))),'FM999999999999999'),15,'0')||';'||
lpad(to_char(round(nvl(y.vat_rate,0)*100),'FM9999'),4,'0')||';'||
rpad(nvl(substr(y.order_reference,1,10),' '),10)||';'||
rpad(nvl(substr(y.other_reference,1,25),' '),25)||';'||
rpad(nvl(substr(y.invoice_status,1,30),' '),30)||';'||
rpad(nvl(substr(y.free_field,1,30),' '),30)||';' faa_record
from
(
select
translate(hca.account_number,chr(9)||chr(10)||chr(13)||';','    ') debtor_identifier,
hp.jgzz_fiscal_code debtor_id_number,
hp.sic_code debtor_activity_code,
hl.country,
translate(hp.party_name,chr(9)||chr(10)||chr(13)||';','    ') debtor_name,
translate(hp.known_as,chr(9)||chr(10)||chr(13)||';','    ') trade_name,
translate(hl.address1,chr(9)||chr(10)||chr(13)||';','    ') address1,
translate(hl.address2,chr(9)||chr(10)||chr(13)||';','    ') address2,
translate(hl.address3,chr(9)||chr(10)||chr(13)||';','    ') address3,
translate(hl.city,chr(9)||chr(10)||chr(13)||';','    ') town,
translate(hl.postal_code,chr(9)||chr(10)||chr(13)||';','    ') postal_code,
to_char(null) contact_name,
to_char(null) telephone,
to_char(null) fax,
decode(x.class,'CM','A','F') document_type,
translate(x.trx_number,chr(9)||chr(10)||chr(13)||';','    ') document_number,
translate(ci.credited_invoice_number,chr(9)||chr(10)||chr(13)||';','    ') credited_invoice_number,
x.trx_date document_date,
x.due_date,
x.invoice_currency_code currency,
fc.precision currency_precision,
x.amount_including_tax,
x.amount_including_tax-x.tax_amount amount_excluding_tax,
(select max(zxl.tax_rate) from zx_lines zxl where x.customer_trx_id=zxl.trx_id and zxl.application_id=222 and zxl.entity_code='TRANSACTIONS') vat_rate,
translate(x.purchase_order,chr(9)||chr(10)||chr(13)||';','    ') order_reference,
to_char(null) other_reference,
x.invoice_status,
to_char(null) free_field
from
(
select
rcta.customer_trx_id,
rcta.trx_number,
rcta.trx_date,
rcta.invoice_currency_code,
rcta.bill_to_customer_id,
rcta.bill_to_site_use_id,
rcta.purchase_order,
apsa.class,
sum(apsa.amount_due_original) amount_including_tax,
min(apsa.due_date) due_date,
case when sum(nvl(apsa.amount_in_dispute,0))<>0 then 'LIT1' else 'RGL' end invoice_status,
nvl((select sum(rctla.extended_amount) from ra_customer_trx_lines_all rctla where rcta.customer_trx_id=rctla.customer_trx_id and rctla.line_type='TAX'),0) tax_amount
from
ra_customer_trx_all rcta,
ar_payment_schedules_all apsa,
hr_operating_units hou
where
1=1 and
rcta.org_id=hou.organization_id and
rcta.complete_flag='Y' and
rcta.customer_trx_id=apsa.customer_trx_id and
apsa.class in ('INV','CM')
group by
rcta.customer_trx_id,
rcta.trx_number,
rcta.trx_date,
rcta.invoice_currency_code,
rcta.bill_to_customer_id,
rcta.bill_to_site_use_id,
rcta.purchase_order,
apsa.class
) x,
(
select
araa.customer_trx_id,
max(rcta_inv.trx_number) keep (dense_rank first order by abs(araa.amount_applied) desc, rcta_inv.trx_number) credited_invoice_number
from
ar_receivable_applications_all araa,
ra_customer_trx_all rcta_inv
where
araa.application_type='CM' and
araa.status='APP' and
araa.display='Y' and
araa.applied_customer_trx_id=rcta_inv.customer_trx_id
group by
araa.customer_trx_id
) ci,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_currencies fc
where
x.customer_trx_id=ci.customer_trx_id(+) and
x.bill_to_customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
x.bill_to_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
x.invoice_currency_code=fc.currency_code(+)
) y
order by
y.debtor_identifier,
y.document_number
