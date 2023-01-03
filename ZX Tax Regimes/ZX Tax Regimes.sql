/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ZX Tax Regimes
-- Description: E-Business Tax tax regime and party subscription setup
-- Excel Examle Output: https://www.enginatics.com/example/zx-tax-regimes/
-- Library Link: https://www.enginatics.com/reports/zx-tax-regimes/
-- Run Report: https://demo.enginatics.com/

select
ftv.territory_short_name country,
zrv.tax_regime_code,
zrv.tax_regime_name,
xxen_util.meaning(decode(zrv.allow_recoverability_flag,'Y','Y'),'YES_NO',0) allow_tax_recovery,
xxen_util.meaning(decode(zrv.tax_inclusive_override_flag,'Y','Y'),'YES_NO',0) allow_tax_inclusive_override,
xxen_util.meaning(decode(zrv.allow_exemptions_flag,'Y','Y'),'YES_NO',0) allow_tax_exemptions,
xxen_util.meaning(decode(zrv.allow_exceptions_flag,'Y','Y'),'YES_NO',0) allow_tax_exceptions,
zrv.tax_currency_code tax_currency,
zrv.minimum_accountable_unit,
xxen_util.meaning(zrv.rounding_rule_code,'ZX_ROUNDING_RULE',0) rounding_rule,
zrv.tax_precision,
xxen_util.meaning(zrv.def_inclusive_tax_flag,'ZX_INCLUSIVE_TAX',0) allow_tax_inclusion,
xxen_util.meaning(decode(zrv.has_other_jurisdictions_flag,'Y','Y'),'YES_NO',0) allow_multiple_jurisdictions,
xxen_util.meaning(decode(zrv.allow_rounding_override_flag,'Y','Y'),'YES_NO',0) allow_tax_rounding_override,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where zrv.exchange_rate_type=gdct.conversion_type) exchange_rate_type,
xxen_util.meaning(zrv.def_rec_settlement_option_code,'ZX_REC-SETTLEMENT_OPTION',0) default_recovery_settlement,
(select hp.party_name from zx_party_tax_profile zptp, hz_parties hp where zrv.coll_tax_authority_id=zptp.party_tax_profile_id and zptp.party_id=hp.party_id) collecting_tax_authority,
(select hp.party_name from zx_party_tax_profile zptp, hz_parties hp where zrv.rep_tax_authority_id=zptp.party_tax_profile_id and zptp.party_id=hp.party_id) reporting_tax_authority,
xxen_util.meaning(decode(zrv.regn_num_same_as_le_flag,'Y','Y'),'YES_NO',0) use_legal_registration_number,
xxen_util.meaning(decode(zrv.cross_regime_compounding_flag,'Y','Y'),'YES_NO',0) allow_cross_regime_compounding,
&subscription_columns
xxen_util.user_name(zrv.created_by) regime_created_by,
xxen_util.client_time(zrv.creation_date) regime_creation_date,
xxen_util.user_name(zrv.last_updated_by) regime_last_updated_by,
xxen_util.client_time(zrv.last_update_date) regime_last_update_date,
zrv.tax_regime_id
from
zx_regimes_vl zrv,
fnd_territories_vl ftv,
(select zru.* from zx_regimes_usages zru where '&show_subscriptions'='Y') zru,
zx_first_party_orgs_all_v zfpoa,
(select zso.* from zx_subscription_options zso where sysdate between zso.effective_from and nvl(zso.effective_to,sysdate) and zso.enabled_flag='Y') zso
where
1=1 and
sysdate between nvl(zrv.effective_from,sysdate) and nvl(zrv.effective_to,sysdate) and
zrv.country_code=ftv.territory_code(+) and
zrv.tax_regime_id=zru.tax_regime_id(+) and
zru.first_pty_org_id=zfpoa.party_tax_profile_id(+) and
zru.regime_usage_id=zso.regime_usage_id(+)
order by
ftv.territory_short_name,
zrv.tax_regime_code
&subscription_order_by