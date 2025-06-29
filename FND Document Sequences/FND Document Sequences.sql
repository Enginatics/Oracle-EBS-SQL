/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Document Sequences
-- Description: Document sequence details including database sequence name and last seqeunce number.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-document-sequences/
-- Library Link: https://www.enginatics.com/reports/fnd-document-sequences/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fds.name,
fds.start_date,
fds.end_date,
decode(fds.type,'A','Automatic','M','Manual','G','Gapless') type,
xxen_util.yes(fds.message_flag) message,
fds.initial_value,
(select ds.last_number from dba_sequences ds where fds.db_sequence_name=ds.sequence_name and ds.sequence_owner='APPLSYS') last_number,
fds.db_sequence_name,
fds.table_name,
fds.audit_table_name,
xxen_util.user_name(fds.created_by) created_by,
xxen_util.client_time(fds.creation_date) creation_date,
xxen_util.user_name(fds.last_updated_by) last_updated_by,
xxen_util.client_time(fds.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_document_sequences fds
where
1=1 and
fav.application_id=fds.application_id
order by
fds.application_id,
fds.table_name,
fds.name