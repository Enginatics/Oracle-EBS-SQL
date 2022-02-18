/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Trial Balance Report Definitions
-- Description: Accounts Payable Trial Balance Report Definitions
-- Excel Examle Output: https://www.enginatics.com/example/ap-trial-balance-report-definitions/
-- Library Link: https://www.enginatics.com/reports/ap-trial-balance-report-definitions/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
xtdv.definition_code,
xtdv.name,
xtdv.description,
xtdjs.je_source_name journal_source,
xxen_util.meaning(xtdv.enabled_flag,'XLA_YES_NO',602) enabled,
xxen_util.meaning(xtdv.balance_side_code,'XLA_ACCT_NATURAL_SIDE',602) balance_side_code,
xxen_util.meaning(xtdv.defined_by_code,'XLA_TB_DEFINED_BY',602) defined_by_code,
xtdv.definition_status_code,
initcap(xtdv.definition_status_code) definition_status,
xxen_util.meaning(xtdv.owner_code,'XLA_OWNER_TYPE',602) owner,
xtdd.flexfield_segment_code,
xtdd.segment_value_from,
xtdd.segment_value_to,
gcck.concatenated_segments account,
fifsv.id_flex_structure_name chart_of_accounts,
(select distinct
        listagg(fifsv.form_left_prompt,'.') within group (order by fifsv.segment_num) over (partition by xtdv.definition_code,fifsv.id_flex_num) gl_account_segments
 from   fnd_id_flex_segments_vl fifsv
 where fifsv.application_id  = 101 and
       fifsv.id_flex_code    = 'GL#' and
       fifsv.id_flex_num     = gl.chart_of_accounts_id
) gl_segment_names,
(select distinct
        listagg(fifsv.application_column_name,'.') within group (order by fifsv.segment_num) over (partition by xtdv.definition_code,fifsv.id_flex_num) gl_account_segments
 from   fnd_id_flex_segments_vl fifsv
 where fifsv.application_id  = 101 and
       fifsv.id_flex_code    = 'GL#' and
       fifsv.id_flex_num     = gl.chart_of_accounts_id
) gl_segment_columns,
gl.chart_of_accounts_id,
xtdv.ledger_id
from
xla_tb_definitions_vl xtdv,
xla_tb_defn_je_sources xtdjs,
gl_ledgers gl,
xla_tb_defn_details xtdd,
fnd_id_flex_structures_vl fifsv,
gl_code_combinations_kfv gcck
where
xtdjs.definition_code     (+) = xtdv.definition_code and
xtdd.definition_code      (+) = xtdv.definition_code and
gl.ledger_id              (+) = xtdv.ledger_id and
fifsv.application_id      (+) = 101 and
fifsv.id_flex_code        (+) = 'GL#' and
fifsv.id_flex_num         (+) = gl.chart_of_accounts_id and
gcck.code_combination_id  (+) = xtdd.code_combination_id and
1=1
order by
gl.name,
xtdv.definition_code