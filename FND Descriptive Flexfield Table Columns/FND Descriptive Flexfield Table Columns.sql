/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Descriptive Flexfield Table Columns
-- Description: Shows all active descriptive flexfield table columns.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-descriptive-flexfield-table-columns/
-- Library Link: https://www.enginatics.com/reports/fnd-descriptive-flexfield-table-columns/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fdfv.descriptive_flexfield_name name,
fdfv.title,
fdfv.application_table_name table_name,
fdfv.application_id,
fdfv.descriptive_flexfield_name,
fc.column_name,
fc.description,
xxen_util.user_name(fc.created_by) created_by,
xxen_util.client_time(fc.creation_date) creation_date,
xxen_util.user_name(fc.last_updated_by) last_updated_by,
xxen_util.client_time(fc.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_descriptive_flexs_vl fdfv,
fnd_tables ft,
fnd_columns fc
where
fdfv.title='Enter Journals: Lines' and
1=1 and
fdfv.descriptive_flexfield_name not like '$SRS$.%' and
fav.application_id=fdfv.application_id and
fdfv.table_application_id=ft.application_id and
fdfv.application_table_name=ft.table_name and
ft.application_id=fc.application_id(+) and
ft.table_id=fc.table_id(+) and
fc.flexfield_usage_code(+)='D' and
fdfv.application_id=fc.flexfield_application_id(+) and 
fdfv.descriptive_flexfield_name=fc.flexfield_name(+)
order by
fav.application_name,
fdfv.title,
fc.column_name