/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Depreciation by period
-- Description: Detail report with asset ID, depreciation run date, depreciation amount per period and depreciation YTD.
-- Excel Examle Output: https://www.enginatics.com/example/fa-depreciation-by-period/
-- Library Link: https://www.enginatics.com/reports/fa-depreciation-by-period/
-- Run Report: https://demo.enginatics.com/

SELECT fa.asset_number,
       fa.asset_id,
       fdd.period_counter,
       fdp.period_name,
       fdp.fiscal_year,
       fdp.period_num,
       fdd.book_type_code,
       fdd.distribution_id,
       fdd.deprn_run_date,
       fdd.deprn_amount,
       fdd.ytd_deprn,
       fdd.deprn_reserve,
       fdd.cost,
       fdd.deprn_adjustment_amount,
       fdd.event_id,
       fdd.deprn_run_id
  FROM fa_additions       fa,
       fa_deprn_periods   fdp,
       fa.fa_deprn_detail fdd
 WHERE 1=1
   AND fa.asset_id = fdd.asset_id
   AND fdp.period_counter = fdd.period_counter
   AND fdp.book_type_code = fdd.book_type_code
  -- AND fa.asset_id = 432178
 --  AND fdp.period_name = '04-14'