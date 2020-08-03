/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Lobs
-- Description: Generic file manager lob data, such as attachments, help files, imported and exported Blitz Report files etc.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-lobs/
-- Library Link: https://www.enginatics.com/reports/fnd-lobs/
-- Run Report: https://demo.enginatics.com/

select
fl.file_id,
fl.file_name,
fl.file_content_type,
&file_data
fl.upload_date,
fl.expiration_date,
fl.program_name,
fl.program_tag,
fl.language,
fl.oracle_charset,
fl.file_format
from
fnd_lobs fl
where
1=1
order by
fl.upload_date desc nulls last,
fl.file_id desc