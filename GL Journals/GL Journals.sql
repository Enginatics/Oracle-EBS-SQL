/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Journals
-- Description: GL batches and journals report, including amounts and attachments
-- Excel Examle Output: https://www.enginatics.com/example/gl-journals/
-- Library Link: https://www.enginatics.com/reports/gl-journals/
-- Run Report: https://demo.enginatics.com/

select
gjh.period_name,
gjh.default_effective_date effective_date,
gjh.posted_date,
gl.name ledger,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
xxen_util.meaning(gjb.status,'MJE_BATCH_STATUS',101) batch_status,
(select gjsv.user_je_source_name from gl_je_sources_vl gjsv where gjh.je_source=gjsv.je_source_name) source_name,
(select gjcv.user_je_category_name from gl_je_categories_vl gjcv where gjh.je_category=gjcv.je_category_name) category_name,
gjb.name batch_name,
gjh.name journal_name,
gjh.description journal_description,
gjh.doc_sequence_value document_number,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
gjh.running_total_dr entered_dr,
gjh.running_total_cr entered_cr,
nvl(gjh.running_total_dr,0)-nvl(gjh.running_total_cr,0) entered_amount,
gjh.currency_code currency,
gjh.running_total_accounted_dr accounted_dr,
gjh.running_total_accounted_cr accounted_cr,
nvl(gjh.running_total_accounted_dr,0)-nvl(gjh.running_total_accounted_cr,0) accounted_amount,
gl.currency_code ledger_currency,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
gjh.currency_conversion_date conversion_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gjh.currency_conversion_type=gdct.conversion_type) conversion_type,
gjh.currency_conversion_rate conversion_rate,
gjh.external_reference,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
fad1.count batch_attachment_count,
fad2.count journal_attachment_count,
&attachment_columns
xxen_util.meaning(gjh.status,'BATCH_STATUS',101) journal_status,
(select ppf.full_name from per_people_f ppf where gjb.approver_employee_id=ppf.person_id and gjb.creation_date between ppf.effective_start_date and ppf.effective_end_date) batch_approver,
xxen_util.user_name(gjb.created_by) batch_created_by,
xxen_util.client_time(gjb.creation_date) batch_creation_date,
xxen_util.user_name(gjb.last_updated_by) batch_last_updated_by,
xxen_util.client_time(gjb.last_update_date) batch_last_update_date,
xxen_util.user_name(gjh.created_by) journal_created_by,
xxen_util.client_time(gjh.creation_date) journal_creation_date,
xxen_util.user_name(gjh.last_updated_by) journal_last_updated_by,
xxen_util.client_time(gjh.last_update_date) journal_last_update_date
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
(select distinct fad.pk1_value,&fad_document_id count(*) over (partition by fad.pk1_value) count from fnd_attached_documents fad where fad.entity_name='GL_JE_BATCHES') fad1,
(select distinct fad.pk2_value,&fad_document_id count(*) over (partition by fad.pk2_value) count from fnd_attached_documents fad where fad.entity_name='GL_JE_HEADERS') fad2,
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
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
to_char(gjb.je_batch_id)=fad1.pk1_value(+) and
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
gl.name,
fad1.seq_num,
fad2.seq_num