/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Tables and Columns
-- Description: Registered FND tables, columns, primary keys and their flexfields
-- Excel Examle Output: https://www.enginatics.com/example/fnd-tables-and-columns/
-- Library Link: https://www.enginatics.com/reports/fnd-tables-and-columns/
-- Run Report: https://demo.enginatics.com/

select
fav.application_short_name,
fav.application_name,
ft.table_name,
fc.column_name,
fc.description column_description,
xxen_util.meaning(fc.column_type,'COLUMN_TYPE',0)||case when fc.column_type in ('C','U','V') then ' ('||fc.width||')' end column_type,
xxen_util.meaning(fc.null_allowed_flag,'YES_NO',0) null_allowed,
fpk.primary_key_name,
fpkc.primary_key_sequence,
fc.flexfield_name,
fdfv.title flexfield_title,
fc.column_type column_type_code,
xxen_util.user_name(fc.created_by) created_by,
xxen_util.client_time(fc.creation_date) creation_date,
xxen_util.user_name(fc.last_updated_by) last_updated_by,
xxen_util.client_time(fc.last_update_date) last_update_date
from
fnd_application_vl fav,
fnd_tables ft,
fnd_columns fc,
fnd_primary_key_columns fpkc,
fnd_primary_keys fpk,
fnd_descriptive_flexs_vl fdfv
where
1=1 and
fav.application_id=ft.application_id and
ft.application_id=fc.application_id and
ft.table_id=fc.table_id and
fc.application_id=fpkc.application_id(+) and
fc.table_id=fpkc.table_id(+) and
fc.column_id=fpkc.column_id(+) and
fc.flexfield_application_id=fdfv.application_id(+) and
fc.flexfield_name=fdfv.descriptive_flexfield_name(+) and
fpkc.application_id=fpk.application_id(+) and
fpkc.table_id=fpk.table_id(+) and
fpkc.primary_key_id=fpk.primary_key_id(+)
order by
ft.table_name,
fc.column_sequence,
fpkc.primary_key_sequence