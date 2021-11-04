/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE General Ledger Cash Account Usage
-- Description: Application: Cash Management
Description: Cash Account Usage

This report details the General Ledger Cash Accounts assigned to Bank Accounts, and their usage.

The following templates are available:
Pivot: Bank Accounts, Assigned Cash Accounts - Pivot by Bank Account, Cash Account showing cash account usage within each bank account.
Pivot: Cash Account, Assigned Bank Accounts - Pivot by Cash Account, Bank Account, showing cash account usage within each bank account. 

-- Excel Examle Output: https://www.enginatics.com/example/ce-general-ledger-cash-account-usage/
-- Library Link: https://www.enginatics.com/reports/ce-general-ledger-cash-account-usage/
-- Run Report: https://demo.enginatics.com/

select
 x.cash_account,
 x.cash_account_desc,
 x.cash_account_assignment,
 x.bank_account_name,
 x.bank_account_num,
 x.bank_account_currency,
 x.bank_name,
 x.branch_name,
 x.owning_legal_entity,
 x.primary_ledger,
   --
 x.usage_org_type,
 x.usage_organization,
 x.ap_usage,
 x.ar_usage,
 x.treasury_usage,
 x.payoll_usage,
 case count(distinct x.bank_account_id) over (partition by x.cash_account_ccid)
 when 1 then null else 'Y' end multiple_bank_account_usage,
 case count(distinct x.cash_account_ccid) over (partition by x.bank_account_id)
 when 1 then null else 'Y' end multiple_cash_account_usage,
 listagg(x.cash_account_assignment,', ') within group (order by x.cash_account_assignment) over (partition by x.cash_account_ccid, x.bank_account_id) cash_bank_account_all_usages,
 --
 x.cash_account || ' (' || x.cash_account_desc || ')' cash_account_pivot_label,
 x.bank_name || ' - ' || x.bank_account_num || ' - ' || x.bank_account_name || ' (' ||  x.bank_account_currency || ')' bank_account_pivot_label
from
( select
   --
   gcck.concatenated_segments    cash_account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_desc', 'SQLGL', 'GL#', gcck.chart_of_accounts_id, NULL, gcck.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') cash_account_desc,
   'Bank Account Cash Account'   cash_account_assignment,
   cba.bank_account_name         bank_account_name,
   cba.bank_account_num          bank_account_num,
   cba.currency_code             bank_account_currency,
   hpb.party_name                bank_name,
   hpbb.party_name               branch_name,
   xep.name                      owning_legal_entity,
   gl.name                       primary_ledger,
   --
   null                          usage_org_type,
   null                          usage_organization,
   cba.ap_use_allowed_flag       ap_usage,
   cba.ar_use_allowed_flag       ar_usage,
   cba.xtr_use_allowed_flag      treasury_usage,
   cba.pay_use_allowed_flag      payoll_usage,
   --
   cba.bank_account_id           bank_account_id,
   gcck.code_combination_id      cash_account_ccid,
   gcck.chart_of_accounts_id     chart_of_accounts_id
  from
   ce_bank_accounts                cba,
   xle_entity_profiles             xep,
   gl_ledgers                      gl,
   hz_parties                      hpb,
   hz_parties                      hpbb,
   gl_code_combinations_kfv        gcck
  where
   cba.account_classification      = 'INTERNAL' and
   nvl(cba.netting_acct_flag,'N')  = 'N' and
   xep.legal_entity_id             = cba.account_owner_org_id and
   gl.ledger_id                    = ce_bat_utils.get_ledger_id(cba.account_owner_org_id) and
   hpb.party_id                    = cba.bank_id and
   hpbb.party_id                   = cba.bank_branch_id and
   gcck.code_combination_id        = cba.asset_code_combination_id and
   cba.bank_account_id            in
     (select
       cbaua.bank_account_id
      from
       ce_bank_acct_uses_all cbaua,
       ce_security_profiles_v cspv
      where
       ((cbaua.org_id = cspv.organization_id and cspv.organization_type in ('OPERATING_UNIT','BUSINESS_GROUP')) or
        (cbaua.legal_entity_id = cspv.organization_id and cspv.organization_type = 'LEGAL_ENTITY')
       ) and
       trunc(nvl(cbaua.end_date,sysdate)) >= trunc(sysdate)
     )
  union
  select
   gcck2.concatenated_segments   cash_account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_desc', 'SQLGL', 'GL#', gcck2.chart_of_accounts_id, NULL, gcck2.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') cash_account_desc,
   col.cname                     cash_account_assignment,
   cba.bank_account_name         bank_account_name,
   cba.bank_account_num          bank_account_num,
   cba.currency_code             bank_account_currency,
   hpb.party_name                bank_name,
   hpbb.party_name               branch_name,
   xep.name                      owning_legal_entity,
   gl.name                       primary_ledger,
   --
   case when cbaua.legal_entity_id is null
   then --ce_bank_and_account_validation.get_org_type(cbaua.org_id)
        case when pay_use_enable_flag = 'Y'
        then xxen_util.meaning('HR_BG','ORG_CLASS',3)
        end ||
        case when pay_use_enable_flag = 'Y' and (ap_use_enable_flag = 'Y' or ar_use_enable_flag = 'Y')
        then ', '
        end ||
        case when ap_use_enable_flag = 'Y' or ar_use_enable_flag = 'Y'
        then xxen_util.meaning('OPERATING_UNIT','ORG_CLASS',3)
        end
   else xxen_util.meaning('LEGAL_ENTITY','ORGANIZATION_TYPE',260)
   end                           usage_org_type,
   case when cbaua.legal_entity_id is null
   then fnd_access_control_util.get_org_name(cbaua.org_id)
   else xep2.name
   end                           usage_organization,
   cbaua.ap_use_enable_flag      ap_usage,
   cbaua.ar_use_enable_flag      ar_usage,
   cbaua.xtr_use_enable_flag     treasury_usage,
   cbaua.pay_use_enable_flag     payoll_usage,
   --
   cba.bank_account_id           bank_account_id,
   gcck2.code_combination_id     cash_account_ccid,
   gcck2.chart_of_accounts_id    chart_of_accounts_id
  from
   ce_bank_accounts                cba,
   xle_entity_profiles             xep,
   gl_ledgers                      gl,
   hz_parties                      hpb,
   hz_parties                      hpbb,
   gl_code_combinations_kfv        gcck,
   --
   ce_bank_acct_uses_all           cbaua,
   ce_security_profiles_v          cspv,
   xle_entity_profiles             xep2,
   ce_gl_accounts_ccid             cgac,
   gl_code_combinations_kfv        gcck2,
   (select 1 as cnum, 'Bank Account Usage Cash Account' cname from dual union all
    select 2 as cnum, 'Payables' cname from dual union all
    select 3 as cnum, 'Receivables' cname from dual union all
    select 4 as cnum, 'Payroll' cname from dual union all
    select 5 as cnum, 'Treasury' cname from dual
   ) col
  where
   cba.account_classification      = 'INTERNAL' and
   nvl(cba.netting_acct_flag,'N')  = 'N' and
   xep.legal_entity_id             = cba.account_owner_org_id and
   gl.ledger_id                    = ce_bat_utils.get_ledger_id(cba.account_owner_org_id) and
   hpb.party_id                    = cba.bank_id and
   hpbb.party_id                   = cba.bank_branch_id and
   gcck.code_combination_id    (+) = cba.asset_code_combination_id and
   --
   cbaua.bank_account_id           = cba.bank_account_id and
   nvl(cbaua.end_date,sysdate)    >= trunc(sysdate) and
   xep2.legal_entity_id        (+) = cbaua.legal_entity_id and
   cgac.bank_acct_use_id           = cbaua.bank_acct_use_id and
   --
   gcck2.code_combination_id       = case col.cnum
                                     when 1 then cgac.asset_code_combination_id
                                     when 2 then nvl(cgac.ap_asset_ccid,decode(cbaua.ap_use_enable_flag,'Y',cgac.asset_code_combination_id))
                                     when 3 then nvl(cgac.ar_asset_ccid,decode(cbaua.ar_use_enable_flag,'Y',cgac.asset_code_combination_id))
                                     when 4 then decode(cbaua.pay_use_enable_flag,'Y',cgac.asset_code_combination_id)
                                     when 5 then nvl(cgac.xtr_asset_ccid,decode(cbaua.xtr_use_enable_flag,'Y',cgac.asset_code_combination_id))
                                     end and
   --
   ((col.cnum = 1 and cbaua.xtr_use_enable_flag = 'Y' and cgac.asset_code_combination_id != cgac.xtr_asset_ccid) or
    (col.cnum = 1 and cbaua.ap_use_enable_flag = 'Y' and cgac.asset_code_combination_id != cgac.ap_asset_ccid) or
    (col.cnum = 1 and cbaua.ar_use_enable_flag = 'Y' and cgac.asset_code_combination_id != cgac.ar_asset_ccid) or
    (col.cnum = 1 and nvl(cbaua.ar_use_enable_flag,'N') != 'Y' and nvl(cbaua.ap_use_enable_flag,'N') != 'Y' and nvl(cbaua.pay_use_enable_flag,'N') != 'Y' and nvl(cbaua.xtr_use_enable_flag,'N') != 'Y') or
    (col.cnum = 2 and cbaua.ap_use_enable_flag = 'Y') or
    (col.cnum = 3 and cbaua.ar_use_enable_flag = 'Y') or
    (col.cnum = 4 and cbaua.pay_use_enable_flag = 'Y') or
    (col.cnum = 5 and cbaua.xtr_use_enable_flag = 'Y')
   ) and
   --
   ((cspv.organization_id = cbaua.org_id and cspv.organization_type in ('OPERATING_UNIT','BUSINESS_GROUP')) or
    (cspv.organization_id = cbaua.legal_entity_id and cspv.organization_type = 'LEGAL_ENTITY')
   )
) x
where
  1=1
order by
 x.cash_account,
 x.owning_legal_entity,
 x.bank_name,
 x.bank_account_name,
 x.usage_org_type nulls first,
 x.usage_organization nulls first,
 x.cash_account_assignment