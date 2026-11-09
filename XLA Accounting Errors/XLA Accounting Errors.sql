/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Accounting Errors
-- Description: Errors and warnings of the subledger accounting program (Create Accounting) for each ledger, application, accounting event and transaction, as the Create Accounting output lists them with Errors Only = Yes. Run as the daily check of failed events, so that scheduled Create Accounting runs can use Errors Only = Yes or Report = Summary instead of writing every accounted line to their output.
-- Request Id matches the Create Accounting request or one of its Accounting Program child requests. An accounting program run deletes the earlier errors of the events it processes, so the report shows the errors of each event's latest run.
-- Excel Example Output: https://www.enginatics.com/example/xla-accounting-errors/
-- Library Link: https://www.enginatics.com/reports/xla-accounting-errors/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
fav.application_name application,
xecv.name event_class,
xetv.name event_type,
xe.event_date,
xe.event_number,
xte.transaction_number,
nvl(xxen_util.meaning(xe.process_status_code,'XLA_EVENT_PROCESS_STATUS',602),xe.process_status_code) process_status,
xxen_util.meaning(xe.event_status_code,'XLA_EVENT_STATUS',602) event_status,
xxen_util.yes(xe.on_hold_flag) on_hold,
xae.message_number,
xae.encoded_msg message,
xae.ae_line_num journal_line,
xae.request_id,
xxen_util.user_name(xae.created_by) created_by,
xxen_util.client_time(xae.creation_date) creation_date,
xte.entity_code,
xae.event_id,
xae.entity_id,
xae.ae_header_id,
xae.accounting_batch_id
from
xla_accounting_errors xae,
fnd_application_vl fav,
xla_events xe,
xla_transaction_entities xte,
gl_ledgers gl,
xla_event_types_vl xetv,
xla_event_classes_vl xecv
where
1=1 and
xae.application_id=fav.application_id and
xae.event_id=xe.event_id(+) and
xae.application_id=xe.application_id(+) and
xae.entity_id=xte.entity_id(+) and
xae.application_id=xte.application_id(+) and
nvl(xae.ledger_id,xte.ledger_id)=gl.ledger_id(+) and
xte.application_id=xetv.application_id(+) and
xte.entity_code=xetv.entity_code(+) and
xe.event_type_code=xetv.event_type_code(+) and
xetv.application_id=xecv.application_id(+) and
xetv.entity_code=xecv.entity_code(+) and
xetv.event_class_code=xecv.event_class_code(+)
order by
gl.name,
fav.application_name,
xe.event_date,
xte.transaction_number,
xae.accounting_error_id
