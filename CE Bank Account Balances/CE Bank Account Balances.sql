/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Account Balances
-- Description: Application: Cash Management
Description: Bank Accounts - Balances Report

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Bank Account Balances OAF Page
- Bank Account Balance Range Day Report
- Bank Account Balance Single Date Report
- Bank Account Balance Actual vs Projected Report

Single (As Of) Date Report
- Specify the required Date in the As Of Date parameter
- Specify Yes in the 'Bring Forward Prior Balances' if you want to roll the most recent prior balance entries forward if a balance does not exist on the specified As Of Date
- Specify No in the  'Bring Forward Prior Balances' if you only want to see the balances that have been entered on the specified As Of Date.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Range Day Report
- Specify the required date range in the Balance Date From/To Parameters
- When run in this mode the report shows the balances entered for every date within the date range.
- Balances are not rolled forward in this mode.
- Applicable Templates:
  Detail As of Date/Range Date Report  

Actual vs Projected Report
- The report includes actual and projected balances in both As Of Date and Date Range Modes
- Optionally specify the actual balance type to be compared to the projected balance in the  'Actual vs Projected Balance Type' parameter. When specified, the variance between the actual balance and projected balance will be displayed in the report.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Sources: 
Bank Account Balance Single Date Report (CEBABSGR)
Bank Account Balance Range Day Report (CEBABRGR)
Bank Account Balance Actual vs Projected Report (CEBABAPR)
DB package:  CE_CEXSTMRR_XMLP_PKG (required to initialize security)

-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-account-balances/
-- Library Link: https://www.enginatics.com/reports/ce-bank-account-balances/
-- Run Report: https://demo.enginatics.com/

with ce_bank_acct_bal_qry1 as
( select
   nvl(cbab.bank_account_id,cpb.bank_account_id) bank_account_id,
   nvl(cbab.balance_date,cpb.balance_date) balance_date,
   -- actual_balance_date
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.balance_date
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.ledger_balance is not null
        then cbab.balance_date
        else (select cbab.balance_date
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.ledger_balance is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end actual_balance_date,   
   --cbab.ledger_balance,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.ledger_balance
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.ledger_balance is not null
        then cbab.ledger_balance
        else (select cbab2.ledger_balance
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.ledger_balance is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end ledger_balance,
   --cbab.available_balance,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.available_balance
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.available_balance is not null
        then cbab.available_balance
        else (select cbab2.available_balance
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.available_balance is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end available_balance,
   --cbab.value_dated_balance,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.value_dated_balance
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.value_dated_balance is not null
        then cbab.value_dated_balance
        else (select cbab2.value_dated_balance
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.value_dated_balance is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end value_dated_balance,
   --cbab.one_day_float,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.one_day_float
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.one_day_float is not null
        then cbab.one_day_float
        else (select cbab2.one_day_float
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.one_day_float is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end one_day_float,
   --cbab.two_day_float,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.two_day_float
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.two_day_float is not null
        then cbab.two_day_float
        else (select cbab2.two_day_float
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.two_day_float is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end two_day_float,
   --cbab.average_close_ledger_mtd,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.average_close_ledger_mtd
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.average_close_ledger_mtd is not null
        then cbab.average_close_ledger_mtd
        else (select cbab2.average_close_ledger_mtd
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.average_close_ledger_mtd is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end average_close_ledger_mtd,
   --cbab.average_close_available_mtd,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.average_close_available_mtd
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.average_close_available_mtd is not null
        then cbab.average_close_available_mtd
        else (select cbab2.average_close_available_mtd
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.average_close_available_mtd is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end average_close_available_mtd,
   --cbab.average_close_ledger_ytd,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.average_close_ledger_ytd
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.average_close_ledger_ytd is not null
        then cbab.average_close_ledger_ytd
        else (select cbab2.average_close_ledger_ytd
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.average_close_ledger_ytd is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end average_close_ledger_ytd,
   --cbab.average_close_available_ytd
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cbab.average_close_available_ytd
   else case when trunc(cbab.balance_date) = :p_as_of_date
              and cbab.average_close_available_ytd is not null
        then cbab.average_close_available_ytd
        else (select cbab2.average_close_available_ytd
              from   ce_bank_acct_balances  cbab2
              where  (cbab2.bank_account_id,cbab2.balance_date) =
                     (select   cbab3.bank_account_id,max(cbab3.balance_date)
                      from     ce_bank_acct_balances  cbab3
                      where    cbab3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cbab3.balance_date < :p_as_of_date and
                               cbab3.average_close_available_ytd is not null
                      group by cbab3.bank_account_id
                     )
             )
        end
   end average_close_available_ytd,
   --cpb.projected_balance,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) != 'YY'
   then cpb.projected_balance
   else case when trunc(cpb.balance_date) = :p_as_of_date
              and cpb.projected_balance is not null
        then cpb.projected_balance
        else (select cpb2.projected_balance
              from   ce_projected_balances  cpb2
              where  (cpb2.bank_account_id,cpb2.balance_date) =
                     (select   cpb3.bank_account_id,max(cpb3.balance_date)
                      from     ce_projected_balances  cpb3
                      where    cpb3.bank_account_id = nvl(cbab.bank_account_id,cpb.bank_account_id)  and
                               cpb3.balance_date < :p_as_of_date and
                               cpb3.projected_balance is not null
                      group by cpb3.bank_account_id
                     )
             )
        end
   end projected_balance,
   --
   -- balance bf flags
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.ledger_balance is not null)
   then 'Ledger '
   else null
   end ledger_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.available_balance is not null)
   then 'Available '
   else null
   end available_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.value_dated_balance is not null)
   then 'ValueDated '
   else null
   end value_dated_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.one_day_float is not null)
   then 'OneDayFloat '
   else null
   end one_day_float_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.two_day_float is not null)
   then 'TwoDayFloat '
   else null
   end two_day_float_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.average_close_ledger_mtd is not null)
   then 'AvgCloseLdgMTD '
   else null
   end avg_close_ledger_mtd_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.average_close_available_mtd is not null)
   then 'AvgCloseAvailMTD '
   else null
   end avg_close_available_mtd_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.average_close_ledger_ytd is not null)
   then 'AvgCloseLdgYTD '
   else null
   end avg_close_ledger_ytd_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cbab.balance_date) = :p_as_of_date and cbab.average_close_available_ytd is not null)
   then 'AvgCloseAvailYTD '
   else null
   end avg_close_available_ytd_bf,
   case when nvl2(:p_as_of_date,'Y','N') || substr(nvl(:p_bf_flag,'N'),1,1) = 'YY'
         and not (trunc(cpb.balance_date) = :p_as_of_date and cpb.projected_balance is not null)
   then 'Projected '
   else null
   end projected_bf
  from
   ce_bank_acct_balances  cbab
   full join
   ce_projected_balances  cpb
  on
   cpb.bank_account_id  = cbab.bank_account_id and
   cpb.balance_date     = cbab.balance_date
),
ce_bank_acct_bal_qry2 as
( select
   xep.name                            legal_entity,
   cbacv.masked_account_num            masked_account_num,
   cbacv.bank_account_name             bank_account_name,
   cbacv.currency_code                 bank_account_currency,
   hpb.party_name                      bank_name,
   hpbb.party_name                     branch_name,
   cl.meaning                          balance_type,
   cbabq1.balance_date                 balance_date,
   cbabq1.ledger_balance               ledger_balance,
   cbabq1.available_balance            available_balance,
   cbabq1.value_dated_balance          value_dated_balance,
   cbabq1.one_day_float                one_day_float,
   cbabq1.two_day_float                two_day_float,
   cbabq1.projected_balance            projected_balance,
   cbabq1.average_close_ledger_mtd     average_closing_ledger_mtd,
   cbabq1.average_close_available_mtd  average_closing_available_mtd,
   cbabq1.average_close_ledger_ytd     average_closing_ledger_ytd,
   cbabq1.average_close_available_ytd  average_closing_available_ytd,
   cbacv.min_target_balance            min_target_balance,
   cbacv.max_target_balance            max_target_balance,
   cbabq1.ledger_bf                    ledger_bf,
   cbabq1.available_bf                 available_bf,
   cbabq1.value_dated_bf               value_dated_bf,
   cbabq1.one_day_float_bf             one_day_float_bf,
   cbabq1.two_day_float_bf             two_day_float_bf,
   cbabq1.projected_bf                 projected_bf,
   cbabq1.avg_close_ledger_mtd_bf      avg_close_ledger_mtd_bf,
   cbabq1.avg_close_available_mtd_bf   avg_close_available_mtd_bf,
   cbabq1.avg_close_ledger_ytd_bf      avg_close_ledger_ytd_bf,
   cbabq1.avg_close_available_ytd_bf   avg_close_available_ytd_bf,
   'BA'                                type_code,
   cbacv.bank_account_id               bank_account_id,
   gcc.code_combination_id             asset_ccid,
   gcc.chart_of_accounts_id            coaid,
   cbabq1.actual_balance_date          actual_balance_date
  from
   ce_bank_acct_bal_qry1     cbabq1,
   ce_bank_accts_calc_v      cbacv,
   ce_bank_accts_gt_v        cbagv,
   gl_code_combinations      gcc,
   hz_parties                hpb,
   hz_parties                hpbb,
   xle_entity_profiles       xep,
   ce_lookups                cl
  where
   cbacv.bank_account_id     = cbabq1.bank_account_id and
   cbagv.bank_account_id     = cbabq1.bank_account_id and
   cbagv.asset_code_combination_id = gcc.code_combination_id (+)  and
   hpb.party_id              = cbacv.bank_id and
   hpbb.party_id             = cbacv.bank_branch_id and
   xep.legal_entity_id       = cbacv.account_owner_org_id and
   cl.lookup_type            = 'BALANCE_SERCH_TYPE' and
   cl.lookup_code            = 'BA' and
   2=2
  union all
  select
   xep.name                          legal_entity,
   cbacv.masked_account_num          masked_account_num,
   cc.name                           bank_account_name,
   cbacv.currency_code               bank_account_currency,
   hpb.party_name                    bank_name,
   cl.meaning                        balance_type,
   hpbb.party_name                   branch_name,
   cbab.balance_date                 balance_date,
   to_number(null)                   ledger_balance,
   to_number(null)                   available_balance,
   ce_bal_util.get_pool_balance
     ( cc.cashpool_id
     , cbab.balance_date
     )                               value_dated_balance,
   to_number(null)                   one_day_float,
   to_number(null)                   two_day_float,
   to_number(null)                   projected_balance,
   to_number(null)                   average_closing_ledger_mtd,
   to_number(null)                   average_closing_available_mtd,
   to_number(null)                   average_closing_ledger_ytd,
   to_number(null)                   average_closing_available_ytd,
   to_number(null)                   min_target_balance,
   to_number(null)                   max_target_balance,
   null                              ledger_bf,
   null                              available_bf,
   null                              value_dated_bf,
   null                              one_day_float_bf,
   null                              two_day_float_bf,
   null                              projected_bf,
   null                              avg_close_ledger_mtd_bf,
   null                              avg_close_available_mtd_bf,
   null                              avg_close_ledger_ytd_bf,
   null                              avg_close_available_ytd_bf,
   'CP'                              type_code,
   cbacv.bank_account_id             bank_account_id,
   gcc.code_combination_id           asset_ccid,
   gcc.chart_of_accounts_id          coaid,
   to_date(null)                     actual_balance_date
  from
   ce_bank_accts_calc_v   cbacv,
   ce_cashpools           cc,
   ( select distinct
       ccsa.cashpool_id,
       cbab.balance_date
     from
       ce_cashpool_sub_accts ccsa,
       ce_bank_acct_balances cbab
     where
       cbab.bank_account_id = ccsa.account_id and
       3=3
   )                      cbab,
   ce_bank_accts_gt_v     cbagv,
   gl_code_combinations   gcc,
   hz_parties             hpb,
   hz_parties             hpbb,
   xle_entity_profiles    xep,
   ce_lookups             cl
  where
   cc.conc_account_id        = cbacv.bank_account_id and
   cbab.cashpool_id          = cc.cashpool_id and
   cbagv.bank_account_id     = cbacv.bank_account_id and
   cbagv.asset_code_combination_id = gcc.code_combination_id (+)  and
   hpb.party_id              = cbacv.bank_id and
   hpbb.party_id             = cbacv.bank_branch_id and
   xep.legal_entity_id       = cbacv.account_owner_org_id and
   cl.lookup_type            = 'BALANCE_SERCH_TYPE' and
   cl.lookup_code            = 'CP'
)
--
-- Main Query Starts Here
--
select
 cbab.legal_entity,
 cbab.masked_account_num bank_account_num,
 cbab.bank_account_name,
 cbab.bank_account_currency,
 cbab.bank_name,
 cbab.branch_name,
 cbab.balance_type,
 case when nvl2(:p_as_of_date,'Y','N') = 'Y'
 then to_date(:p_as_of_date)
 else cbab.balance_date
 end balance_date,
 cbab.ledger_balance,
 cbab.available_balance,
 cbab.value_dated_balance,
 cbab.one_day_float,
 cbab.two_day_float,
 cbab.average_closing_ledger_mtd,
 cbab.average_closing_available_mtd,
 cbab.average_closing_ledger_ytd,
 cbab.average_closing_available_ytd,
 cbab.projected_balance,
 --
 case :p_proj_variance_type
 when 'C'   then cbab.available_balance - cbab.projected_balance -- available balance
 when 'CAM' then cbab.average_closing_available_mtd - cbab.projected_balance -- Avg Closing Avail MTD
 when 'CAY' then cbab.average_closing_available_ytd - cbab.projected_balance -- Avg Closing Avail YTD
 when 'CLM' then cbab.average_closing_ledger_mtd - cbab.projected_balance -- Avg Closing Ledger MTD
 when 'CLY' then cbab.average_closing_ledger_ytd - cbab.projected_balance -- Avg Closing Ledger YTD
 when 'I'   then cbab.value_dated_balance - cbab.projected_balance -- Value Dated Balance
 when 'L'   then cbab.ledger_balance - cbab.projected_balance -- Ledger Balance
 when 'O'   then cbab.one_day_float - cbab.projected_balance -- One Day Float
 when 'T'   then cbab.two_day_float - cbab.projected_balance -- Two Day Float
 else to_number(null)
 end act_vs_proj_variance,
 xxen_util.meaning(:p_proj_variance_type,'BANK_ACC_BAL_TYPE',260) variance_type,
 --
 cbab.min_target_balance,
 cbab.max_target_balance,
 case when nvl2(:p_as_of_date,'Y','N') = 'Y'
 then
   nvl2(cbab.ledger_balance               , cbab.ledger_bf                 , null) ||
   nvl2(cbab.available_balance            , cbab.available_bf              , null) ||
   nvl2(cbab.value_dated_balance          , cbab.value_dated_bf            , null) ||
   nvl2(cbab.one_day_float                , cbab.one_day_float_bf          , null) ||
   nvl2(cbab.two_day_float                , cbab.two_day_float_bf          , null) ||
   nvl2(cbab.projected_balance            , cbab.projected_bf              , null) ||
   nvl2(cbab.average_closing_ledger_mtd   , cbab.avg_close_ledger_mtd_bf   , null) ||
   nvl2(cbab.average_closing_available_mtd, cbab.avg_close_available_mtd_bf, null) ||
   nvl2(cbab.average_closing_ledger_ytd   , cbab.avg_close_ledger_ytd_bf   , null) ||
   nvl2(cbab.average_closing_available_ytd, cbab.avg_close_available_ytd_bf, null)
 end as_of_date_balances_bf_flag,
 -- Statement Details
 csh.statement_number,
 csh.statement_date,
 csh.control_begin_balance statement_opening_balance,
 csh.control_end_balance statement_closing_balance,
 -- Reporting Currency
 :p_rep_currency reporting_currency,
 case
 when :p_rep_currency is null
 then null
 when :p_rep_currency is not null
       and ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then 'No Exchange Rate'
 else to_char(ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type))
 end exchange_rate,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.ledger_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_ledger_balance,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.available_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_available_balance,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.value_dated_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_value_dated_balance,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.one_day_float * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_one_day_float,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.two_day_float * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_two_day_float,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.average_closing_ledger_mtd * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_avg_close_ledger_mtd,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.average_closing_available_mtd * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_avg_close_avail_mtd,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.average_closing_ledger_ytd * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_avg_close_ledger_ytd,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.average_closing_available_ytd * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_avg_close_avail_ytd,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.projected_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_projected_balance,
 --
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) != -1
 then
   case :p_proj_variance_type
   when 'C'   then (cbab.available_balance - cbab.projected_balance) -- available balance
   when 'CAM' then (cbab.average_closing_available_mtd - cbab.projected_balance) -- Avg Closing Avail MTD
   when 'CAY' then (cbab.average_closing_available_ytd - cbab.projected_balance) -- Avg Closing Avail YTD
   when 'CLM' then (cbab.average_closing_ledger_mtd - cbab.projected_balance) -- Avg Closing Ledger MTD
   when 'CLY' then (cbab.average_closing_ledger_ytd - cbab.projected_balance) -- Avg Closing Ledger YTD
   when 'I'   then (cbab.value_dated_balance - cbab.projected_balance) -- Value Dated Balance
   when 'L'   then (cbab.ledger_balance - cbab.projected_balance) -- Ledger Balance
   when 'O'   then (cbab.one_day_float - cbab.projected_balance) -- One Day Float
   when 'T'   then (cbab.two_day_float - cbab.projected_balance) -- Two Day Float
   else to_number(null)
   end * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_act_vs_proj_variance,
 --
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.min_target_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_min_target_balance,
 case when ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) = -1
 then to_number(null)
 else cbab.max_target_balance * ce_bankacct_ba_report_util.get_rate(cbab.bank_account_currency,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type)
 end rep_curr_max_target_balance,
 -- GL Cash Account Details
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'GL_BALANCING', 'Y', 'VALUE'),null) gl_company_code,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null) gl_company_desc,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'GL_ACCOUNT', 'Y', 'VALUE'),null) gl_account_code,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null) gl_account_desc,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'FA_COST_CTR', 'Y', 'VALUE'),null) gl_cost_center_code,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),null) gl_cost_center_desc,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'ALL', 'Y', 'VALUE'),null) gl_cash_account,
 nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, NULL, cbab.asset_ccid, 'ALL', 'Y', 'DESCRIPTION'),null) gl_cash_account_desc,
 -- pivot labels
 cbab.bank_name || ' - ' || cbab.masked_account_num || ' - ' || cbab.bank_account_name || ' (' ||  cbab.bank_account_currency || ')' bank_account_pivot_label
from
 ce_bank_acct_bal_qry2 cbab,
 ce_statement_headers csh
where
 1=1 and
 decode(cbab.type_code,'BA',cbab.bank_account_id,null) = csh.bank_account_id (+) and
 decode(cbab.type_code,'BA',cbab.actual_balance_date,null) = csh.statement_date (+) 
order by
 cbab.bank_name,
 cbab.masked_account_num,
 cbab.balance_date