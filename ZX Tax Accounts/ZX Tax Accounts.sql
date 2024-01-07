/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ZX Tax Accounts
-- Description: E-Business Tax account configuration for all ledgers and operating units, setup on either tax, jurisdiction or rate level
-- Excel Examle Output: https://www.enginatics.com/example/zx-tax-accounts/
-- Library Link: https://www.enginatics.com/reports/zx-tax-accounts/
-- Run Report: https://demo.enginatics.com/

select
decode(za.tax_account_entity_code,'TAXES','Tax','JURISDICTION','Jurisdiction','RATES','Rate') setup_level,
ftv.territory_short_name country,
coalesce(zjv.tax_regime_code,zrv.tax_regime_code,zrgv.tax_regime_code) tax_regime_code,
zrgv.tax_regime_name,
coalesce(zjv.tax,zrv.tax,ztv.tax) tax,
ztv.tax_full_name tax_name,
zrv.tax_status_code,
(select zsv.tax_status_name from zx_status_vl zsv where zrv.tax_regime_code=zsv.tax_regime_code and zrv.tax=zsv.tax and zrv.tax_status_code=zsv.tax_status_code and zrv.content_owner_id=zsv.content_owner_id) tax_status_name, 
zrv.tax_rate_code,
(select zfpomv.party_name from zx_first_party_orgs_moac_v zfpomv where zrv.content_owner_id=zfpomv.party_tax_profile_id) configuration_owner,
coalesce(zjv.tax_jurisdiction_code,zrv.tax_jurisdiction_code) tax_jurisdiction_code,
coalesce(zjv.tax_jurisdiction_name,zjv2.tax_jurisdiction_name) tax_jurisdiction_name,
zjv.precedence_level,
(select hp.party_name from zx_party_tax_profile zptp, hz_parties hp where zjv.coll_tax_authority_id=zptp.party_tax_profile_id and zptp.party_id=hp.party_id) collecting_tax_authority,
(select hp.party_name from zx_party_tax_profile zptp, hz_parties hp where zjv.rep_tax_authority_id=zptp.party_tax_profile_id and zptp.party_id=hp.party_id) reporting_tax_authority,
xxen_util.meaning(zrv.rate_type_code,'ZX_RATE_TYPE',0) rate_type,
zrv.percentage_rate,
xxen_util.meaning(decode(zrv.active_flag,'Y','Y'),'YES_NO',0) active,
zrv.effective_from,
zrv.tax_class,
zrv.recovery_type_code,
fifsv.id_flex_structure_name chart_of_accounts,
gl.name ledger,
hou.name operating_unit,
xxen_util.concatenated_segments(za.non_rec_account_ccid) tax_expense,
xxen_util.segments_description(za.non_rec_account_ccid) tax_expense_desc,
xxen_util.concatenated_segments(za.tax_account_ccid) tax_recoverable_liability,
xxen_util.segments_description(za.tax_account_ccid) tax_recoverable_liability_desc,
xxen_util.concatenated_segments(za.interim_tax_ccid) interim_tax,
xxen_util.segments_description(za.interim_tax_ccid) interim_tax_desc,
xxen_util.concatenated_segments(za.finchrg_non_rec_tax_ccid) finance_charge_tax_liability,
xxen_util.segments_description(za.finchrg_non_rec_tax_ccid) finance_charge_tax_liability_d,
xxen_util.concatenated_segments(za.edisc_non_rec_tax_ccid) earned_discounts_non_rec,
xxen_util.segments_description(za.edisc_non_rec_tax_ccid) earned_discounts_non_rec_desc,
xxen_util.concatenated_segments(za.unedisc_non_rec_tax_ccid) unearned_discounts_non_rec,
xxen_util.segments_description(za.unedisc_non_rec_tax_ccid) unearned_discounts_non_rec_dsc,
xxen_util.concatenated_segments(za.adj_non_rec_tax_ccid) adjustment_non_rec,
xxen_util.segments_description(za.adj_non_rec_tax_ccid) adjustment_non_rec_desc,
xxen_util.concatenated_segments(za.edisc_ccid) earned_discounts,
xxen_util.segments_description(za.edisc_ccid) earned_discounts_desc,
xxen_util.concatenated_segments(za.unedisc_ccid) unearned_discounts,
xxen_util.segments_description(za.unedisc_ccid) unearned_discounts_desc,
xxen_util.concatenated_segments(za.adj_ccid) adjustment,
xxen_util.segments_description(za.adj_ccid) adjustment_desc,
xxen_util.concatenated_segments(za.finchrg_ccid) finance_charges,
xxen_util.segments_description(za.finchrg_ccid) finance_charges_desc,
xxen_util.user_name(za.created_by) created_by,
xxen_util.client_time(za.creation_date) creation_date,
xxen_util.user_name(za.last_updated_by) last_updated_by,
xxen_util.client_time(za.last_update_date) last_update_date,
za.tax_account_id,
za.tax_account_entity_id
from
zx_accounts za,
hr_operating_units hou,
gl_ledgers gl,
fnd_id_flex_structures_vl fifsv,
zx_taxes_vl ztv,
zx_rates_vl zrv,
zx_jurisdictions_vl zjv,
zx_jurisdictions_vl zjv2,
zx_regimes_vl zrgv,
fnd_territories_vl ftv
where
1=1 and
za.internal_organization_id=hou.organization_id and
za.ledger_id=gl.ledger_id and
gl.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.application_id=101 and
fifsv.id_flex_code='GL#' and
decode(za.tax_account_entity_code,'JURISDICTION',za.tax_account_entity_id)=zjv.tax_jurisdiction_id(+) and
decode(za.tax_account_entity_code,'RATES',za.tax_account_entity_id)=zrv.tax_rate_id(+) and
coalesce(zrv.tax_regime_code,ztv.tax_regime_code)=zrgv.tax_regime_code(+) and
zrgv.country_code=ftv.territory_code(+) and
zrv.tax_regime_code=zjv2.tax_regime_code(+) and
zrv.tax=zjv2.tax(+) and
zrv.tax_jurisdiction_code=zjv2.tax_jurisdiction_code(+) and
(
za.tax_account_entity_code='TAXES' and za.tax_account_entity_id=ztv.tax_id or
za.tax_account_entity_code='JURISDICTION' and zjv.tax_regime_code=ztv.tax_regime_code and zjv.tax=ztv.tax and ztv.content_owner_id=-99 or
za.tax_account_entity_code='RATES' and zrv.tax_regime_code=ztv.tax_regime_code and zrv.tax=ztv.tax and zrv.content_owner_id=ztv.content_owner_id
)
order by
decode(za.tax_account_entity_code,'TAXES',1,'JURISDICTION',2,'RATES',3),
ftv.territory_short_name,
tax_regime_code,
tax,
zrv.tax_status_code, 
zrv.tax_rate_code