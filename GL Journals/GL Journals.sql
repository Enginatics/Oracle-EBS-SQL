/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Journals
-- Description: GL batches and journals report, including amounts and attachments
-- Excel Examle Output: https://www.enginatics.com/example/gl-journals/
-- Library Link: https://www.enginatics.com/reports/gl-journals/
-- Run Report: https://demo.enginatics.com/

with gcck as (select &materialoze_hint gcck.* from gl_code_combinations_kfv gcck where 2=2)
select &leading_hint
--ledger
gl.name ledger,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
gl.currency_code ledger_currency,
-- period
gjh.period_name,
gjh.default_effective_date effective_date,
xxen_util.client_time(gjh.posted_date) posted_date,
--batch
gjb.name batch_name,
gjb.je_batch_id,
xxen_util.meaning(substr(gjb.status,1,1),'MJE_BATCH_STATUS',101) batch_status,
xxen_util.client_time(gjb.posted_date) batch_posted_date,
xxen_util.user_name(gjb.posted_by) batch_posted_by,
xxen_util.meaning(gjb.budgetary_control_status,'JE_BATCH_BC_STATUS',101) batch_funds_status,
xxen_util.meaning(gjb.approval_status_code,'JE_BATCH_APPROVAL_STATUS',101) approval_status,
(select ppf.full_name from per_people_f ppf where gjb.approver_employee_id=ppf.person_id and gjb.creation_date between ppf.effective_start_date and ppf.effective_end_date) batch_approver,
-- journal header
gjh.name journal_name,
gjh.je_header_id,
gjh.doc_sequence_value journal_document_number,
gjh.description journal_description,
gjh.external_reference,
(select gjsv.user_je_source_name from gl_je_sources_vl gjsv where gjh.je_source=gjsv.je_source_name) source_name,
(select gjcv.user_je_category_name from gl_je_categories_vl gjcv where gjh.je_category=gjcv.je_category_name) category_name,
xxen_util.meaning(gjh.status,'BATCH_STATUS',101) journal_status,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where gjh.encumbrance_type_id=get.encumbrance_type_id) encumbrance_type,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
xxen_util.meaning(gjb.average_journal_flag,'AB_JOURNAL_TYPE',101) journal_type,
gjh.originating_bal_seg_value clearing_company,
gjh.currency_code currency,
gjh.running_total_dr journal_entered_dr,
gjh.running_total_cr journal_entered_cr,
nvl(gjh.running_total_dr,0)-nvl(gjh.running_total_cr,0) journal_entered_amount,
gjh.running_total_accounted_dr journal_accounted_dr,
gjh.running_total_accounted_cr journal_accounted_cr,
nvl(gjh.running_total_accounted_dr,0)-nvl(gjh.running_total_accounted_cr,0) journal_accounted_amount,
gjh.currency_conversion_date conversion_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gjh.currency_conversion_type=gdct.conversion_type) conversion_type,
gjh.currency_conversion_rate conversion_rate,
gjh.accrual_rev_effective_date reversal_effective_date,
gjh.accrual_rev_period_name reversal_period,
xxen_util.meaning(decode(gjh.accrual_rev_change_sign_flag,'N','S','Y','C'),'REVERSAL_OPTION_CODE',101) reversal_method,
xxen_util.meaning(gjh.accrual_rev_status,'JE_REVERSAL_STATUS',101) reversal_status,
(select gjh2.name from gl_je_headers gjh2 where gjh.accrual_rev_je_header_id=gjh2.je_header_id) reversal_journal_name,
-- journal lines
gjl.je_line_num line_number,
gjl.description line_description,
xxen_util.meaning(gjl.status,'BATCH_STATUS',101) line_status,
gjl.effective_date line_effective_date,
gjl.entered_dr,
gjl.entered_cr,
nvl(gjl.entered_dr,0)-nvl(gjl.entered_cr,0) entered_amount,
gjl.accounted_dr,
gjl.accounted_cr,
nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) accounted_amount,
case when (select gsu.reconciliation_upg_flag from gl_system_usages gsu)='Y' then gjlr.jgzz_recon_ref else nvl(gjlr.jgzz_recon_ref,gjl.jgzz_recon_ref_11i) end line_reconcilation_reference,
case when (select gsu.reconciliation_upg_flag from gl_system_usages gsu)='Y' then gjlr.jgzz_recon_date else nvl(gjlr.jgzz_recon_date,gjl.jgzz_recon_date_11i) end line_reconcilation_date,
case
when gjl.tax_type_code='I'
then coalesce((select zrb.tax_rate_code from zx_rates_b zrb where gjl.tax_code_id=zrb.source_id),
              (select zrb.tax_rate_code from zx_rates_b zrb where gjl.tax_code_id=zrb.tax_rate_id))
when gjl.tax_type_code in ('O','T')
then (select zrb.tax_rate_code from zx_rates_b zrb where gjl.tax_code_id=zrb.tax_rate_id)
end line_tax_rate_code,
-- accounts
gcck.concatenated_segments,
&segment_columns
&dff_cols
-- attachment details
fad1.count batch_attachment_count,
fad2.count journal_attachment_count,
&attachment_columns
-- audit columns
xxen_util.user_name(gjb.created_by) batch_created_by,
xxen_util.client_time(gjb.creation_date) batch_creation_date,
xxen_util.user_name(gjb.last_updated_by) batch_last_updated_by,
xxen_util.client_time(gjb.last_update_date) batch_last_update_date,
xxen_util.user_name(gjh.created_by) journal_created_by,
xxen_util.client_time(gjh.creation_date) journal_creation_date,
xxen_util.user_name(gjh.last_updated_by) journal_last_updated_by,
xxen_util.client_time(gjh.last_update_date) journal_last_update_date,
xxen_util.user_name(gjl.created_by) line_created_by,
xxen_util.client_time(gjl.creation_date) line_creation_date,
xxen_util.user_name(gjl.last_updated_by) line_last_updated_by,
xxen_util.client_time(gjl.last_update_date) line_last_update_date,
-- period labels
gp.start_date period_start,
gp.end_date period_end,
to_char(gp.period_year) || '-' || ltrim(to_char(gp.period_num,'00')) period_year_num
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
gl_je_lines_recon gjlr,
gcck,
(select distinct fad.pk1_value,&fad_document_id count(*) over (partition by fad.pk1_value) count from fnd_attached_documents fad where  '&show_attachments'='Y'  and fad.entity_name='GL_JE_BATCHES') fad1,
(select distinct fad.pk1_value,fad.pk2_value,&fad_document_id count(*) over (partition by fad.pk1_value,fad.pk2_value) count from fnd_attached_documents fad where '&show_attachments'='Y' and fad.entity_name='GL_JE_HEADERS') fad2,
fnd_documents fd1,
fnd_documents fd2,
fnd_documents_tl fdt1,
fnd_documents_tl fdt2,
fnd_document_datatypes fdd1,
fnd_document_datatypes fdd2,
fnd_document_categories_vl fdcv1,
fnd_document_categories_vl fdcv2,
fnd_lobs fl1,
fnd_lobs fl2,
fnd_documents_short_text fdst1,
fnd_documents_short_text fdst2,
fnd_documents_long_text fdlt1,
fnd_documents_long_text fdlt2
where
1=1 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gjh.period_name=gjl.period_name(+) and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id(+) and
&gl_flex_value_security
gjl.je_header_id=gjlr.je_header_id(+) and
gjl.je_line_num=gjlr.je_line_num(+) and
gjl.code_combination_id=gcck.code_combination_id(+) and
to_char(gjb.je_batch_id)=fad1.pk1_value(+) and
to_char(gjh.je_batch_id)=fad2.pk1_value(+) and
to_char(gjh.je_header_id)=fad2.pk2_value(+) and
fad1.document_id=fd1.document_id(+) and
fad2.document_id=fd2.document_id(+) and
fd1.document_id=fdt1.document_id(+) and
fd2.document_id=fdt2.document_id(+) and
fdt1.language(+)=userenv('lang') and
fdt2.language(+)=userenv('lang') and
fd1.datatype_id=fdd1.datatype_id(+) and
fd2.datatype_id=fdd2.datatype_id(+) and
fdd1.language(+)=userenv('lang') and
fdd2.language(+)=userenv('lang') and
fd1.category_id=fdcv1.category_id(+) and
fd2.category_id=fdcv2.category_id(+) and
fd1.media_id=fl1.file_id(+) and
fd2.media_id=fl2.file_id(+) and
decode(fd1.datatype_id,1,fd1.media_id)=fdst1.media_id(+) and
decode(fd2.datatype_id,1,fd2.media_id)=fdst2.media_id(+) and
decode(fd1.datatype_id,2,fd1.media_id)=fdlt1.media_id(+) and
decode(fd2.datatype_id,2,fd2.media_id)=fdlt2.media_id(+)
order by
gp.period_year desc,
gp.period_num desc,
gjh.default_effective_date,
gjb.name,
gjh.name,
gjl.je_line_num,
fad1.seq_num,
fad2.seq_num