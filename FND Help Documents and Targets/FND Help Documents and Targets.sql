/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Help Documents and Targets
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-help-documents-and-targets/
-- Library Link: https://www.enginatics.com/reports/fnd-help-documents-and-targets/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
fhd.application application_short_name,
fhd.file_name,
fhd.title,
fhd.language,
&target_name
fhd.custom_level,
fl.file_name full_file_name,
fl.program_tag,
&file_data
fl.file_content_type,
fl.upload_date,
fhd.file_id
from
fnd_application_vl fav,
fnd_help_documents fhd,
fnd_lobs fl,
(select fht.* from fnd_help_targets fht where '&show_targets'='Y') fht
where
1=1 and
xxen_util.application_short_name_trans(fav.application_short_name)=fhd.application and
fhd.file_id=fl.file_id(+) and
fhd.file_id=fht.file_id(+)
order by
application_name,
fhd.file_name,
fht.target_name