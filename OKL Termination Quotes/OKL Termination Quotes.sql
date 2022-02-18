/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKL Termination Quotes
-- Description: Information on lease termination quotes
-- Excel Examle Output: https://www.enginatics.com/example/okl-termination-quotes/
-- Library Link: https://www.enginatics.com/reports/okl-termination-quotes/
-- Run Report: https://demo.enginatics.com/

select
otqab.quote_number,
xxen_util.meaning(otqab.qst_code,'OKL_QUOTE_STATUS',0) qst_code,
xxen_util.user_name(otqlab.created_by) created_by,
xxen_util.client_time(otqlab.creation_date) creation_date,
xxen_util.user_name(otqlab.last_updated_by) last_updated_by,
xxen_util.client_time(otqlab.last_update_date) last_update_date,
xxen_util.meaning(otqab.qtp_code,'OKL_QUOTE_TYPE',0) quote_type,
xxen_util.meaning(otqab.qrs_code,'OKL_QUOTE_REASON',0) reason,
xxen_util.client_time(otqab.date_effective_from) effective_from,
xxen_util.client_time(otqab.date_effective_to) effective_to,
otqlab.due_date termination_date,
hca.account_number,
hp.party_name customer_name,
okhab.contract_number,
okhab.orig_system_reference1 known_as,
initcap(decode(okhab.sts_code,'REVERSED',okhab.sts_code,oklb1.sts_code)) contract_status,
oklb1.start_date,
oklb1.end_date,
oklb1.date_terminated,
oklb1.name asset_number,
cii.serial_number,
oklb1.item_description model,
xxen_util.meaning(otqlab.qlt_code,'OKL_QUOTE_LINE_TYPE',0) quote_line_type,
otqlab.amount,
otqlab2.asset_value net_investment,
otqlab2.unbilled_receivables unbilled_receivables,
otqlab2.residual_value residual_value,
okl1.residual_value orig_residual_value,
nvl(hl.address1,cii.location_type_code) address1,
hl.postal_code,
hl.city,
ftt.territory_short_name country,
okhab.cust_po_number,
(
select
decode(orb.object1_id1,'A','Annual','S','Semi-Annual','Q','Quarterly','M','Monthly',orb.object1_id1)
from
okc_rule_groups_b orgb,
okc_rules_b orb
where
otqlab.kle_id=orgb.cle_id and
orgb.rgd_code='LALEVL' and
orgb.id=orb.rgp_id and
orb.rule_information7 is null and --exclude stub periods
orb.rule_information_category='LASLL' and
orb.jtot_object1_code='OKL_TUOM' and
rownum=1
) frequency,
(
select
count(*)
from
okl_streams os,
okl_strm_elements ose
where
otqlab.kle_id=os.kle_id and
os.id=ose.stm_id and
os.purpose_code is null and
os.active_yn='Y' and
ose.date_billed is null and
ose.stream_element_date>=nvl(otqab.date_due,otqab.date_effective_from) and
os.sgn_code='MANL' and
os.sty_id in (251601487757888615031160220891184821165,251601487757897077511897523295407764397,251601487757895868586077908666233058221,254867594288170505831142352918415864749) --('rent','evergreen rent','service and maintenance','service and maintenance evergreen')
) total_periods,
(
select
ose.amount
from
okl_streams os,
okl_strm_elements ose
where
otqlab.kle_id=os.kle_id and
os.id=ose.stm_id and
os.purpose_code is null and
os.active_yn='Y' and
ose.date_billed is null and
ose.stream_element_date>=nvl(otqab.date_due,otqab.date_effective_from) and
os.sgn_code='MANL' and
os.sty_id in (251601487757888615031160220891184821165,251601487757897077511897523295407764397,251601487757895868586077908666233058221,254867594288170505831142352918415864749) and --('rent','evergreen rent','service and maintenance','service and maintenance evergreen')
rownum=1
) rent_per_period,
(
select
min(ose.stream_element_date)
from
okl_streams os,
okl_strm_elements ose
where
otqlab.kle_id=os.kle_id and
os.id=ose.stm_id and
os.purpose_code is null and
os.active_yn='Y' and
ose.date_billed is null and
os.sgn_code='MANL' and
os.sty_id in (251601487757888615031160220891184821165,251601487757897077511897523295407764397,251601487757895868586077908666233058221,254867594288170505831142352918415864749) --('rent','evergreen rent','service and maintenance','service and maintenance evergreen')
) next_billing_date,
otqt.comments,
decode(otqab.partial_yn,'N','Partial','Full') termination_type,
op.name product,
ia.investor_name,
ia.contract_number investor_agreement,
initcap(ia.sts_code) agreement_status,
initcap(ia.invoice_number) invoice_number,
rol.contract_number new_contract,
rol.contract_status new_contract_status,
rol.start_date new_start_date,
rol.end_date new_end_date,
rol.siebel_order,
otqab.date_accepted,
otqab.yield,
wf.wf_key,
wf.wf_process,
wf.wf_activity,
wf.wf_date,
wf.wf_status,
trim(chr(10) from trim(wf.error_message)) error_message,
trim(chr(10) from trim(replace(wf.error_stack,chr(0)))) error_stack,
trim(chr(10) from trim(replace(wf.api_error,chr(0)))) api_error,
haouv.name operating_unit,
oki3.object1_id1 instance_id,
substr(okhab.contract_number,1,instr(okhab.contract_number,'_')-1) deal_number
from
hr_all_organization_units_vl haouv,
okl_trx_quotes_all_b otqab,
okl_trx_quotes_tl otqt,
okl_txl_qte_lines_all_b otqlab,
okc_k_headers_all_b okhab,
okc_k_lines_v oklb1,
okc_k_lines_b oklb2,
okc_k_lines_b oklb3,
okl_k_lines okl1,
okc_k_items oki3,
csi_item_instances cii,
hz_cust_accounts hca,
hz_parties hp,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt,
okl_k_headers okh,
okl_products op,
(select x.* from (select min(otqlab.id) over (partition by otqlab.qte_id, otqlab.kle_id, otqlab.qlt_code) min_id, otqlab.* from okl_txl_qte_lines_all_b otqlab where otqlab.qlt_code='AMCFIA') x where x.id=x.min_id) otqlab2,
(--investor agreement
select
hp.party_name investor_name,
okhab.contract_number,
okhab.sts_code,
(select max(rcta.trx_number) from ra_customer_trx_all rcta where okhab.contract_number=rcta.interface_header_attribute1 and okhab.authoring_org_id=rcta.org_id and rcta.interface_header_context='OKL_INVESTOR') invoice_number,
opc.*
from
(
select
x.*
from
(
select
max(decode(opc.status_code,'INACTIVE',1,'EXPIRED',2,'NEW',3,'ACTIVE',4,0)) over (partition by opc.kle_id) max_status,
max(opc.id) over (partition by opc.kle_id) max_id,
decode(opc.status_code,'INACTIVE',1,'EXPIRED',2,'NEW',3,'ACTIVE',4,0) status,
opc.*
from
okl_pool_contents opc
) x
where
x.id=x.max_id and
x.status=x.max_status
) opc,
okl_pools op,
okc_k_headers_all_b okhab,
okc_k_party_roles_b okprb,
hz_parties hp
where
not exists (select null from okl_pool_transactions opt where opc.transaction_number_in=opt.transaction_number and opt.transaction_type='REMOVE' and opt.transaction_reason='BUY_BACK') and
opc.sty_code='RENT' and
opc.status_code in ('ACTIVE','NEW') and
opc.pol_id=op.id and
op.khr_id=okhab.id and
okhab.scs_code='INVESTOR' and
op.khr_id=okprb.dnz_chr_id and
okprb.rle_code='INVESTOR' and
okprb.jtot_object1_code='OKX_PARTY' and
okprb.object1_id1=hp.party_id
) ia,
(--rollover contract
select
okhab.contract_number,
initcap(okhab.sts_code) contract_status,
okhab.start_date,
okhab.end_date,
okht.short_description siebel_order,
okl.qte_id
from
(select x.* from (select min(okl.id) over (partition by okl.qte_id) min_id, okl.* from okl_k_lines okl) x where x.id=x.min_id) okl,
okc_k_lines_b oklb,
okc_k_headers_all_b okhab,
okc_k_headers_tl okht
where
okl.id=oklb.id and
oklb.dnz_chr_id=okhab.id and
oklb.dnz_chr_id=okht.id and
okht.language=userenv('lang')
) rol,
(--workflow status
select
wiav.number_value,
wiav.item_key wf_key,
wat0.display_name wf_process,
wa.display_name wf_activity,
wias.begin_date wf_date,
initcap(wias.activity_status) wf_status,
wias.error_message,
wias.error_stack,
wna.text_value api_error
from
wf_item_attribute_values wiav,
wf_item_activity_statuses wias,
wf_process_activities wpa,
wf_activities_tl wat0,
wf_activities_vl wa,
(select x.* from (select max(wi.item_key) over (partition by wi.parent_item_type,wi.parent_item_key) max_item_key, wi.* from wf_items wi where wi.end_date is null and wi.item_type='OKLAMERR') x where x.item_key=x.max_item_key) wi2,
(select wias.* from wf_item_activity_statuses wias where wias.activity_status='NOTIFIED') wias2,
(select wna.* from wf_notification_attributes wna where wna.name='API_ERROR_STACK') wna
where
wiav.item_type='OKLAMPPT' and
wiav.name='QUOTE_ID' and
wiav.item_type=wias.item_type and
wiav.item_key=wias.item_key and
wias.activity_status in ('ACTIVE','ERROR','DEFERRED','NOTIFIED','NORMAL') and
wias.process_activity=wpa.instance_id and
wpa.process_name<>'ROOT' and
wpa.activity_item_type=wa.item_type and
wpa.activity_name=wa.name and
wias.begin_date between wa.begin_date and nvl(wa.end_date,wias.begin_date) and
wa.type in ('NOTICE','FUNCTION') and
wpa.process_item_type=wat0.item_type and
wpa.process_name=wat0.name and
wpa.process_version=wat0.version and
wat0.language=userenv('lang') and
wiav.item_type=wi2.parent_item_type(+) and
wiav.item_key=wi2.parent_item_key(+) and
wi2.item_type=wias2.item_type(+) and
wi2.item_key=wias2.item_key(+) and
wias2.notification_id=wna.notification_id(+)
) wf
where
1=1 and
haouv.organization_id=otqab.org_id and
otqab.id=otqt.id and
otqt.language=userenv('lang') and
otqab.id=otqlab.qte_id and
otqlab.kle_id=oklb1.id and
okhab.id=oklb1.chr_id and
oklb1.id=oklb2.cle_id and
oklb2.id=oklb3.cle_id and
oklb1.lse_id=33 and
oklb2.lse_id=43 and
oklb3.lse_id=45 and
otqlab.kle_id=okl1.id and
oklb3.id=oki3.cle_id and
oki3.jtot_object1_code='OKX_IB_ITEM' and
oki3.object1_id1=cii.instance_id and
oki3.object1_id1=to_char(cii.instance_id) and
okhab.cust_acct_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang') and
otqlab.qlt_code in ('AMBCOC','AMCQDR','AMBPOC') and --contract obligation, discount, purchase amount
decode(cii.install_location_type_code,'HZ_PARTY_SITES',cii.install_location_id)=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
oklb1.chr_id=okh.id and
okh.pdt_id=op.id and
otqlab.qte_id=otqlab2.qte_id(+) and
otqlab.kle_id=otqlab2.kle_id(+) and
otqlab.kle_id=ia.kle_id(+) and
otqlab.qte_id=rol.qte_id(+) and
otqab.id=wf.number_value(+)
order by
quote_number desc,
creation_date desc,
address1,
serial_number