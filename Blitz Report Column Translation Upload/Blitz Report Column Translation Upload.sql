/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Column Translation Upload
-- Description: Upload to maintain the Blitz Report column translations and number formats, which control how a report column heading is displayed in each language and how its values are formatted in Excel.
-- Translations are matched to reports by column name at run time, so one row here applies to every report producing a column of that name.
-- The Language parameter is required, because a single language already covers around twenty thousand column names.
-- Run modes:
-- - Create, Update: downloads the existing translations of the chosen language for editing. Set Delete to Yes to remove a translation.
-- - Create with 'Missing Translations Only' = Yes: downloads only the column names that have no translation yet in the chosen language, ready to be filled in.
-- - Create with 'Create Empty File' = Yes: opens an empty file to enter new column names.
-- The Number Format is an Excel format mask held once per column name, not per language. It repeats on every language row of the same column and is only written when it differs from the stored value, so editing it on any one row is enough.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-column-translation-upload/
-- Library Link: https://www.enginatics.com/reports/blitz-report-column-translation-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xrc.column_name,
xrc.number_format,
flv.description language,
xrct.translation,
xxen_util.user_name(xrct.created_by) created_by,
xxen_util.client_time(xrct.creation_date) creation_date,
xxen_util.user_name(xrct.last_updated_by) last_updated_by,
xxen_util.client_time(xrct.last_update_date) last_update_date,
null delete_,
null upload_row
from
fnd_languages_vl flv,
xxen_report_columns xrc,
(select xrct.* from xxen_report_columns_tl xrct where :p_upload_mode<>xxen_upload.action_create) xrct
where
1=1 and
flv.language_code=:language_code and
nvl(:p_create_empty_file,'x')<>'Y' and
xrc.column_id=xrct.column_id(+) and
flv.language_code=xrct.language(+)
