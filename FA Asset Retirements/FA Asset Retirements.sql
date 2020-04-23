/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Retirements
-- Description: Asset retirement transactions, based on Oracle standard report FAS440_XML.

-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-retirements
-- Library Link: https://www.enginatics.com/reports/fa-asset-retirements
-- Run Report: https://demo.enginatics.com/


select
gl.name ledger,
gl.currency_code,
fb.book_type_code,
fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
(select flv.meaning from fa_lookups_vl flv where fah.asset_type=flv.lookup_code and flv.lookup_type='ASSET TYPE') asset_type,
decode(fah.asset_type,'CIP',fcb.cip_cost_acct,fcb.asset_cost_acct) account,
fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_center','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
fav.asset_number,
fav.description asset_desciption,
fb.date_placed_in_service,
fr.date_retired,
(select flv.meaning from fa_lookups_vl flv where flv.lookup_type='FAXOLTRX' and fth.transaction_type_code=flv.lookup_code) transaction_type,
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'COST',1,'CIP COST',1,0)) cost_retired,
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'NBV RETIRED',-1,0)) nbv_retired,
sum(decode(fa.debit_credit_flag,'DR',1,'CR',-1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'PROCEEDS CLR',1,'PROCEEDS',1,0)) proceeds_of_sale,
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'REMOVALCOST',-1,0)) removal_cost,
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'REVAL RSV RET',1,0)) reval_rsv_ret,
fa_fas440_xmlp_pkg.gain_lossformula(
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'NBV RETIRED',-1,0)),
sum(decode(fa.debit_credit_flag,'DR',1,'CR',-1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'PROCEEDS CLR',1,'PROCEEDS',1,0)),
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'REMOVALCOST',-1,0)),
sum(decode(fa.debit_credit_flag,'DR',-1,'CR',1,0)*fa.adjustment_amount*decode(fa.adjustment_type,'REVAL RSV RET',1,0))
) gain_loss,
fth.transaction_header_id transaction_number,
decode (fth.transaction_type_code,'REINSTATEMENT','*','PARTIAL RETIREMENT','P',to_char(null)) code
from
gl_ledgers gl,
fa_book_controls fbc,
fa_books fb,
fa_transaction_headers fth,
fa_retirements fr,
fa_additions_vl fav,
fa_adjustments fa,
fa_distribution_history fdh,
gl_code_combinations gcc,
fa_asset_history fah,
fa_category_books fcb
where
1=1 and
gl.ledger_id=fbc.set_of_books_id and
fth.book_type_code=fbc.book_type_code and
fth.transaction_key='R' and
fth.transaction_header_id=decode(fth.transaction_type_code,'REINSTATEMENT',fr.transaction_header_id_out,fr.transaction_header_id_in) and
fth.book_type_code=fr.book_type_code and
fth.asset_id=fr.asset_id and
fth.asset_id=fav.asset_id and
fth.book_type_code=fb.book_type_code and
fth.asset_id=fb.asset_id and
fth.transaction_header_id=fb.transaction_header_id_out and
fth.book_type_code=fa.book_type_code and
fth.asset_id=fa.asset_id and
fth.transaction_header_id=fa.transaction_header_id and
fth.asset_id=fah.asset_id and
fa.adjustment_type not in (select 'PROCEEDS' from fa_adjustments fa1 where fa.book_type_code=fa1.book_type_code and fa.asset_id=fa1.asset_id and fa.transaction_header_id=fa1.transaction_header_id and fa1.adjustment_type='PROCEEDS CLR') and
fah.date_effective<=fth.date_effective and
(fah.date_ineffective>fth.date_effective or fah.date_ineffective is null) and
fth.book_type_code=fcb.book_type_code and
fah.category_id=fcb.category_id and
fa.distribution_id=fdh.distribution_id and
fdh.code_combination_id=gcc.code_combination_id
group by
gl.name,
gl.currency_code,
fb.book_type_code,
fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_center','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE'),
fth.transaction_type_code,
fth.asset_id,
fcb.asset_cost_acct,
fcb.cip_cost_acct,
fav.asset_number,
fav.description,
fb.date_placed_in_service,
fr.date_retired,
fth.transaction_header_id,
fah.asset_type,
fr.gain_loss_amount
order by
1,2,3,4,8, 9, 5, 7, 10, 6, 11, 12, 13, 14, 15, 16, 17