/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ECC Admin - Data Load Tracking
-- Description: Enterprise Command Center data load run history, including status, the load SQL and possible error messages in case of failures.
For description of the load process, see ECC Concurrent Programs https://www.enginatics.com/reports/ecc-concurrent-programs/
-- Excel Examle Output: https://www.enginatics.com/example/ecc-admin-data-load-tracking/
-- Library Link: https://www.enginatics.com/reports/ecc-admin-data-load-tracking/
-- Run Report: https://demo.enginatics.com/

select
ear.audit_request_id run_id,
xxen_util.meaning(ear.param_run_load_type,'ECC_LOAD_TYPE_LKUP',0) load_type,
ear.status run_status,
(select eat.application_name from ecc.ecc_application_tl eat where ear.param_application_id=eat.application_id and eat.language='en') application,
nvl((select edb.dataset_key from ecc.ecc_dataset_b edb where ear.param_dataset_id=edb.dataset_id),'All') data_set_key_parameter,
ear.param_languages language_parameter,
ear.start_time,
ear.end_time,
xxen_util.time((nvl(ear.end_time,sysdate)-ear.start_time)*86400) time,
(nvl(ear.end_time,sysdate)-ear.start_time)*86400 seconds,
ear.status_message run_status_message,
xxen_util.meaning(decode(ear.sql_trace_flag,'Y','Y'),'YES_NO',0) sql_trace,
ead.audit_dataset_id audit_data_set_id,
edb.dataset_key data_set_key,
edt.display_name data_set,
ead.status ds_status,
xxen_util.time(ead.seconds) ds_time,
ead.seconds ds_seconds,
case when ead.status_message like '% Check the log at %' then substr(ead.status_message,1,instr(ead.status_message,' Check the log at ')) else ead.status_message end ds_status_message,
case when ead.status_message like '% Check the log at %' then '=HYPERLINK("'||substr(ead.status_message,instr(ead.status_message,' Check the log at ')+18)||'","'||substr(ead.status_message,instr(ead.status_message,' Check the log at ')+18)||'")' end log_file_url,
ealr.audit_load_rule_id data_load_rule_id,
ealr.status rule_status,
xxen_util.time(ealr.seconds) rule_time,
ealr.seconds rule_seconds,
ealr.procedure_sql_time,
ealr.status_message rule_status_message,
eald.audit_load_detail_id audit_rule_details_id,
eald.sql_query,
eald.operation,
eald.status detail_status,
eald.status_message detail_status_message,
xxen_util.time(eald.seconds) detail_time,
eald.seconds detail_seconds,
eald.total_sql_time,
eald.rows_processed,
eald.rows_failed,
eald.rows_succeed
from
ecc.ecc_audit_request ear,
(select ead.*, (nvl(ead.end_time,sysdate)-ead.start_time)*86400 seconds from ecc.ecc_audit_dataset ead) ead,
ecc.ecc_dataset_b edb,
ecc.ecc_dataset_tl edt,
(select ealr.*, (nvl(ealr.end_time,sysdate)-ealr.start_time)*86400 seconds from ecc.ecc_audit_load_rule ealr where '&enable_ealr'='Y') ealr,
(select eald.*, (nvl(eald.end_time,sysdate)-eald.start_time)*86400 seconds from ecc.ecc_audit_load_details eald where '&enable_eald'='Y') eald
where
1=1 and
ear.audit_request_id=ead.audit_request_id(+) and
ead.dataset_id=edb.dataset_id(+) and
edb.dataset_id=edt.dataset_id(+) and
edt.language(+)=xxen_util.bcp47_language(userenv('lang')) and
ead.audit_dataset_id=ealr.audit_dataset_id(+) and
ealr.audit_load_rule_id=eald.audit_load_rule_id(+)
order by
ear.audit_request_id desc,
ead.audit_dataset_id desc,
ealr.audit_load_rule_id desc,
eald.audit_load_detail_id desc,
eald.audit_load_detail_id desc