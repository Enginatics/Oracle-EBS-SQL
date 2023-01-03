/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Application Context File
-- Description: Context XML files retrieved from the database
-- Excel Examle Output: https://www.enginatics.com/example/fnd-application-context-file/
-- Library Link: https://www.enginatics.com/reports/fnd-application-context-file/
-- Run Report: https://demo.enginatics.com/

select
focf.name,
focf.version,
focf.path,
focf.last_synchronized,
decode(focf.ctx_type,'D','Database','A','Application') type,
focf.edit_comments,
focf.text
from
fnd_oam_context_files focf
where
focf.status='S' and
focf.name not in ('TEMPLATE','METADATA')
order by
focf.ctx_type