/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Sample Upload (Interface Table)
-- Description: Sample upload to be used as a template by copying (Tools>Copy Report) to create new uploads using Interface Table.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-sample-upload-interface-table/
-- Library Link: https://www.enginatics.com/reports/blitz-report-sample-upload-interface-table/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
xus.rowid row_id_,
xus.id,
xus.name,
xus.date_of_birth,
xus.created_by,
xus.creation_date,
to_number(null) last_updated_by,
to_date(null) last_update_date
from
xxen_upload_sample xus
where
1=1