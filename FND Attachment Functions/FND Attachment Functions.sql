/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Attachment Functions
-- Description: FND attachment functions, their category assignments, forms blocks and block entities
-- Excel Examle Output: https://www.enginatics.com/example/fnd-attachment-functions/
-- Library Link: https://www.enginatics.com/reports/fnd-attachment-functions/
-- Run Report: https://demo.enginatics.com/

select
decode(faf.function_type,'F','Function','O','Form','R','Report') type,
faf.function_name name,
decode(faf.function_type,'F',fffv.user_function_name,'O',ffv.user_form_name,'R',fcpv.user_concurrent_program_name) user_name,
faf.session_context_field,
xxen_util.meaning(faf.enabled_flag,'YES_NO',0) enabled,
&category_columns
&block_columns
&entity_columns
xxen_util.user_name(faf.created_by) function_created_by,
xxen_util.client_time(faf.creation_date) function_creation_date,
xxen_util.user_name(faf.last_updated_by) function_last_updated_by,
xxen_util.client_time(faf.last_update_date) function_last_update_date
from
fnd_attachment_functions faf,
fnd_form_functions_vl fffv,
fnd_form_vl ffv,
fnd_concurrent_programs_vl fcpv,
(select fdcu.* from fnd_doc_category_usages fdcu where '&enable_fdcu'='Y') fdcu,
fnd_document_categories_vl fdcv,
(select fab.* from fnd_attachment_blocks fab where '&enable_fab'='Y') fab,
(select fabev.* from fnd_attachment_blk_entities_vl fabev where '&enable_fabev'='Y') fabev
where
1=1 and
decode(faf.function_type,'F',faf.function_name)=fffv.function_name(+) and
decode(faf.function_type,'O',faf.function_name)=ffv.form_name(+) and
decode(faf.function_type,'O',faf.application_id)=ffv.application_id(+) and
decode(faf.function_type,'R',faf.function_name)=fcpv.concurrent_program_name (+) and
decode(faf.function_type,'R',faf.application_id)=fcpv.application_id(+) and
faf.attachment_function_id=fdcu.attachment_function_id(+) and
fdcu.category_id=fdcv.category_id(+) and
faf.attachment_function_id=fab.attachment_function_id(+) and
fab.attachment_blk_id=fabev.attachment_blk_id(+)
order by
faf.function_name,
fdcv.user_name