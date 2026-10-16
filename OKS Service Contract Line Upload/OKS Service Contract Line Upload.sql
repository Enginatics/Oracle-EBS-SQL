/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKS Service Contract Line Upload
-- Description: This upload maintains the lines of existing Oracle Service Contracts through the standard Service Contracts public APIs: it updates header and line level values, adds new service and usage lines, and adds covered product or counter sublines.
-- Each row is one contract line or subline. Rows identified by the Line Number column update that line; sublines use the parent.child format, for example 1.2 for the second covered product of service line 1. Rows without a Line Number create a new line: leave Parent Line Number empty and enter Line Type, Item and the line dates for a top line, or enter a Parent Line Number, the Covered Product and the covered dates for a subline. A subline can reference a top line created by an earlier row of the same file. Header level values repeat on every row of a contract and are applied once.
-- Usage lines need a Usage Type, and a Usage Period for all types except Negotiated per Period. Actual per Period and Actual by Quantity lines are invoiced in arrears, which the upload sets automatically, and their sublines need a Default Quantity and a Base Reading.
-- Prices are written as entered. Changing the negotiated amount or unit price does not reprice the line through the price list and does not regenerate an existing billing schedule, and lines cannot be removed by this upload.
-- Updates are validated by the Service Contracts APIs, so changes not allowed for the current contract or line status are rejected with the corresponding API message.
-- Excel Example Output: https://www.enginatics.com/example/oks-service-contract-line-upload/
-- Library Link: https://www.enginatics.com/reports/oks-service-contract-line-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
haouv.name operating_unit,
okhab.contract_number,
okhab.contract_number_modifier contract_modifier,
osv.meaning contract_status,
okhab.currency_code,
coalesce(hca_h.account_number,
(select hca2.account_number from hz_cust_acct_sites_all hcasa2, hz_cust_accounts hca2 where hcsua_hb.cust_acct_site_id=hcasa2.cust_acct_site_id and hcasa2.cust_account_id=hca2.cust_account_id),
(select hca2.account_number from hz_cust_acct_sites_all hcasa2, hz_cust_accounts hca2 where hcsua_hs.cust_acct_site_id=hcasa2.cust_acct_site_id and hcasa2.cust_account_id=hca2.cust_account_id)
) header_bill_to_account,
hcsua_hb.location header_bill_to_location,
hcsua_hs.location header_ship_to_location,
okht.comments header_comments,
obpv.profile_number billing_profile,
(
select
xxen_util.meaning(okpr.rle_code,'OKC_ROLE',0)
from
okc_k_party_roles_b okpr
where
okpr.id=(select min(okpr2.id) from okc_k_party_roles_b okpr2 where okpr2.chr_id=okhab.id and okpr2.cle_id is null and okpr2.rle_code not in ('CUSTOMER','VENDOR'))
) additional_party_role,
(
select
hp.party_name||' - '||hp.party_number
from
okc_k_party_roles_b okpr,
hz_parties hp
where
okpr.id=(select min(okpr2.id) from okc_k_party_roles_b okpr2 where okpr2.chr_id=okhab.id and okpr2.cle_id is null and okpr2.rle_code not in ('CUSTOMER','VENDOR')) and
to_number(okpr.object1_id1)=hp.party_id
) additional_party,
xxen_util.display_flexfield_context(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category) hdr_attribute_category,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE1',okhab.rowid,okhab.attribute1) hdr_attribute1,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE2',okhab.rowid,okhab.attribute2) hdr_attribute2,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE3',okhab.rowid,okhab.attribute3) hdr_attribute3,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE4',okhab.rowid,okhab.attribute4) hdr_attribute4,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE5',okhab.rowid,okhab.attribute5) hdr_attribute5,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE6',okhab.rowid,okhab.attribute6) hdr_attribute6,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE7',okhab.rowid,okhab.attribute7) hdr_attribute7,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE8',okhab.rowid,okhab.attribute8) hdr_attribute8,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE9',okhab.rowid,okhab.attribute9) hdr_attribute9,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE10',okhab.rowid,okhab.attribute10) hdr_attribute10,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE11',okhab.rowid,okhab.attribute11) hdr_attribute11,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE12',okhab.rowid,okhab.attribute12) hdr_attribute12,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE13',okhab.rowid,okhab.attribute13) hdr_attribute13,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE14',okhab.rowid,okhab.attribute14) hdr_attribute14,
xxen_util.display_flexfield_value(510,'OKC_HEADERS_DESC_FLEX',okhab.attribute_category,'ATTRIBUTE15',okhab.rowid,okhab.attribute15) hdr_attribute15,
nvl2(oklb.cle_id,oklb_p.line_number||'.',null)||oklb.line_number line_number,
oklb_p.line_number parent_line_number,
(select olsv.name from okc_line_styles_v olsv where olsv.id=decode(nvl(oklb_p.lse_id,oklb.lse_id),12,12,1)) line_type,
(
select
case
when oki.jtot_object1_code in ('OKX_SERVICE','OKX_USAGE') then (select msiv.concatenated_segments from mtl_system_items_vl msiv where to_number(oki.object1_id1)=msiv.inventory_item_id and to_number(oki.object1_id2)=msiv.organization_id)
end
from
okc_k_items oki
where
oklb.id=oki.cle_id and
rownum=1
) item,
(select olv.item_description from okc_k_lines_v olv where oklb.id=olv.id) line_description,
case when oklb.cle_id is null then oklb.start_date end line_start_date,
case when oklb.cle_id is null then oklb.end_date end line_end_date,
osv_l.meaning line_status,
coalesce(hca_l.account_number,
(select hca2.account_number from hz_cust_acct_sites_all hcasa2, hz_cust_accounts hca2 where hcsua_lb.cust_acct_site_id=hcasa2.cust_acct_site_id and hcasa2.cust_account_id=hca2.cust_account_id),
(select hca2.account_number from hz_cust_acct_sites_all hcasa2, hz_cust_accounts hca2 where hcsua_ls.cust_acct_site_id=hcasa2.cust_acct_site_id and hcasa2.cust_account_id=hca2.cust_account_id)
) line_bill_to_account,
hcsua_lb.location line_bill_to_location,
hcsua_ls.location line_ship_to_location,
(select olv.comments from okc_k_lines_v olv where oklb.id=olv.id) line_comments,
xxen_util.meaning(oksl.usage_type,'OKS_USAGE_TYPES',0) usage_type,
oklb.price_unit unit_price,
oklb.price_negotiated negotiated_amount,
oksl.minimum_quantity,
(select muomv.unit_of_measure_tl from mtl_units_of_measure_vl muomv where oksl.usage_period=muomv.uom_code) usage_period,
(
select
case
when oki.jtot_object1_code='OKX_CUSTPROD' then (select cii.instance_number from csi_item_instances cii where to_number(oki.object1_id1)=cii.instance_id)
when oki.jtot_object1_code='OKX_COUNTER' then (select ccv.name from csi_counters_vl ccv where to_number(oki.object1_id1)=ccv.counter_id)
end
from
okc_k_items oki
where
oklb.id=oki.cle_id and
rownum=1
) covered_product,
case when oklb.cle_id is not null then oklb.start_date end covered_start_date,
case when oklb.cle_id is not null then oklb.end_date end covered_end_date,
oki_q.number_of_items quantity,
(select muom.unit_of_measure from mtl_units_of_measure_vl muom where oki_q.uom_code=muom.uom_code) uom,
oksl.fixed_quantity,
oksl.default_quantity,
oksl.base_reading,
xxen_util.display_flexfield_context(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE1',oklb.rowid,oklb.attribute1) line_attribute1,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE2',oklb.rowid,oklb.attribute2) line_attribute2,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE3',oklb.rowid,oklb.attribute3) line_attribute3,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE4',oklb.rowid,oklb.attribute4) line_attribute4,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE5',oklb.rowid,oklb.attribute5) line_attribute5,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE6',oklb.rowid,oklb.attribute6) line_attribute6,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE7',oklb.rowid,oklb.attribute7) line_attribute7,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE8',oklb.rowid,oklb.attribute8) line_attribute8,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE9',oklb.rowid,oklb.attribute9) line_attribute9,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE10',oklb.rowid,oklb.attribute10) line_attribute10,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE11',oklb.rowid,oklb.attribute11) line_attribute11,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE12',oklb.rowid,oklb.attribute12) line_attribute12,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE13',oklb.rowid,oklb.attribute13) line_attribute13,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE14',oklb.rowid,oklb.attribute14) line_attribute14,
xxen_util.display_flexfield_value(510,'OKC_LINES_DESC_FLEX',oklb.attribute_category,'ATTRIBUTE15',oklb.rowid,oklb.attribute15) line_attribute15,
to_char(okhab.id) chr_id,
to_char(oklb.id) cle_id,
null upload_row
from
okc_k_headers_all_b okhab,
okc_k_headers_tl okht,
oks_k_headers_b okhb,
oks_billing_profiles_v obpv,
hr_all_organization_units_vl haouv,
okc_statuses_v osv,
hz_cust_accounts hca_h,
hz_cust_site_uses_all hcsua_hb,
hz_cust_site_uses_all hcsua_hs,
okc_k_lines_b oklb,
okc_k_lines_b oklb_p,
oks_k_lines_b oksl,
okc_k_items oki_q,
okc_statuses_v osv_l,
hz_cust_accounts hca_l,
hz_cust_site_uses_all hcsua_lb,
hz_cust_site_uses_all hcsua_ls
where
1=1 and
okhab.scs_code='SERVICE' and
okhab.authoring_org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
okhab.id=okht.id and
okht.language=userenv('lang') and
okhab.id=okhb.chr_id(+) and
okhb.billing_profile_id=obpv.id(+) and
okhab.authoring_org_id=haouv.organization_id and
okhab.sts_code=osv.code and
okhab.cust_acct_id=hca_h.cust_account_id(+) and
okhab.bill_to_site_use_id=hcsua_hb.site_use_id(+) and
okhab.ship_to_site_use_id=hcsua_hs.site_use_id(+) and
okhab.id=oklb.dnz_chr_id and
oklb.lse_id in (1,7,8,9,10,11,12,13,14,35) and
oklb.cle_id=oklb_p.id(+) and
oklb.id=oksl.cle_id(+) and
oklb.id=oki_q.cle_id(+) and
oklb.sts_code=osv_l.code and
oklb.cust_acct_id=hca_l.cust_account_id(+) and
oklb.bill_to_site_use_id=hcsua_lb.site_use_id(+) and
oklb.ship_to_site_use_id=hcsua_ls.site_use_id(+)
