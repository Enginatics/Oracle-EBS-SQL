/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Document Categories
-- Description: Document categories used by document sequence assignments.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-document-categories/
-- Library Link: https://www.enginatics.com/reports/fnd-document-categories/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fdsc.code,
fdsc.name,
fdsc.description,
fdsc.table_name,
xxen_util.user_name(fdsc.created_by) created_by,
xxen_util.client_time(fdsc.creation_date) creation_date,
xxen_util.user_name(fdsc.last_updated_by) last_updated_by,
xxen_util.client_time(fdsc.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_doc_sequence_categories fdsc
where
1=1 and
fav.application_id=fdsc.application_id
order by
fdsc.application_id,
fdsc.code