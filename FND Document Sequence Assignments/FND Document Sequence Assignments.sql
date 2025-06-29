/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Document Sequence Assignments
-- Description: Document sequence asssignments to application tables, ledgers and categories, including sequence details such as database sequence name and last seqeunce number.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-document-sequence-assignments/
-- Library Link: https://www.enginatics.com/reports/fnd-document-sequence-assignments/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fdsc.table_name,
fdsc.name category,
gl.name ledger,
decode(fdsa.method_code,'A','Automatic','M','Manual',fdsa.method_code) method,
fdsa.start_date,
fdsa.end_date,
fds.name sequence_name,
fds.start_date sequence_start_date,
fds.end_date sequence_end_date,
decode(fds.type,'A','Automatic','M','Manual','G','Gapless') sequence_type,
xxen_util.yes(fds.message_flag) message,
fds.initial_value,
(select ds.last_number from dba_sequences ds where fds.db_sequence_name=ds.sequence_name and ds.sequence_owner='APPLSYS') last_number,
fds.db_sequence_name,
fds.table_name,
fds.audit_table_name,
xxen_util.user_name(fdsa.created_by) created_by,
xxen_util.client_time(fdsa.creation_date) creation_date,
xxen_util.user_name(fdsa.last_updated_by) last_updated_by,
xxen_util.client_time(fdsa.last_update_date) last_update_date,
xxen_util.user_name(fds.created_by) sequence_created_by,
xxen_util.client_time(fds.creation_date) sequence_creation_date,
xxen_util.user_name(fds.last_updated_by) sequence_last_updated_by,
xxen_util.client_time(fds.last_update_date) sequence_last_update_date,
fdsa.doc_sequence_assignment_id,
fdsa.doc_sequence_id,
fdsa.category_code
from
fnd_application_vl fav,
fnd_doc_sequence_assignments fdsa,
fnd_document_sequences fds,
gl_ledgers gl,
fnd_doc_sequence_categories fdsc
where
1=1 and
fav.application_id=fdsa.application_id and
fdsa.doc_sequence_id=fds.doc_sequence_id and
fdsa.set_of_books_id=gl.ledger_id(+) and
fdsa.application_id=fdsc.application_id(+) and
fdsa.category_code=fdsc.code(+)
order by
fdsa.application_id,
fdsa.set_of_books_id,
fdsa.category_code,
fdsa.method_code,
fdsa.start_date