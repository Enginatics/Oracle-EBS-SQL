create or replace package apps.xxen_util is

/***********************************************************************************************/
/*                                                                                             */
/*       Blitz Report utility package with reusable functions for Oracle EBS.                  */
/*       While the Blitz Report software is licensed as detailed on our webpage                */
/*       www.enginatics.com this utility package is free for use, regardless if                */
/*       you are a Blitz Report customer or not.                                               */
/*                                                                                             */
/*                          (c) 2010-2020 Enginatics GmbH                                      */
/*                                 www.enginatics.com                                          */
/*                                                                                             */
/*                             Copyright and legal notes:                                      */
/*                                                                                             */
/*       Permission is hereby granted, free of charge, to any person obtaining a copy          */
/*       of this software and associated documentation files (the "Software"), to deal         */
/*       in the Software without restriction, including without limitation the rights          */
/*       to use, copy, modify, merge, publish, distribute, sublicense, and/or sell             */
/*       copies of the Software, and to permit persons to whom the Software is                 */
/*       furnished to do so, subject to the following conditions                               */
/*                                                                                             */
/*       The above copyright notice and this permission notice shall be included in            */
/*       all copies or substantial portions of the Software.                                   */
/*                                                                                             */
/*       The software is provided 'As Is', without warranty of any kind, express or            */
/*       implied, including but not limited to the warranties of merchantability,              */
/*       fitness for a particular purpose and noninfringement. in no event shall the           */
/*       authors or copyright holders be liable for any claim, damages or other                */
/*       liability, whether in an action of contract, tort or otherwise, arising from,         */
/*       out of or in connection with the software or the use or other dealings in             */
/*       the software.                                                                         */
/*                                                                                             */
/***********************************************************************************************/

/***********************************************************************************************/
/*  EBS base language                                                                          */
/***********************************************************************************************/
function base_language return varchar2 deterministic;

/***********************************************************************************************/
/*  returns the fnd message for a language, defaulting to US if it doesn't exist               */
/***********************************************************************************************/
function fnd_message(p_message_name in varchar2, p_application_short_name in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  lookup code to meaning translation                                                         */
/***********************************************************************************************/
function meaning(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_code_if_null in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  lookup code to description translation                                                     */
/***********************************************************************************************/
function description(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2) return varchar2;

/***********************************************************************************************/
/*  lookup meaning to code translation                                                         */
/***********************************************************************************************/
function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2) return varchar2;

/***********************************************************************************************/
/*  escape regexp metacharacters with a backslash e.g. ( to \(                                 */
/***********************************************************************************************/
function regexp_escape(p_text in varchar2) return varchar;

/***********************************************************************************************/
/*  used in LOVs to compare column values with parameter values they depend on                 */
/***********************************************************************************************/
function contains(p_parameter_value in varchar2, p_column_value in varchar2) return varchar2;

/***********************************************************************************************/
/*  translate a fnd profile option value into the user visible profile option value            */
/***********************************************************************************************/
function display_profile_option_value(
p_application_id in number,
p_profile_option_id in number,
p_profile_option_value in varchar2
) return varchar2;

/***********************************************************************************************/
/*  translate a descriptive flexfield value into the user visible value                        */
/***********************************************************************************************/
function display_flexfield_value(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_column_name in varchar2,
p_rowid in rowid,
p_business_group_id in number default null,
p_organization_id in number default null,
p_org_information_id in number default null
) return varchar2;

/***********************************************************************************************/
/*  concatenated segments for a given gl code combination                                      */
/***********************************************************************************************/
function concatenated_segments(p_code_combination_id in number) return varchar2 result_cache;

/***********************************************************************************************/
/*  gl account segments description for a given gl code combination                            */
/***********************************************************************************************/
function segments_description(p_code_combination_id in number) return varchar2;

/***********************************************************************************************/
/*  single gl account segment description for a given segment value                            */
/***********************************************************************************************/
function segment_description(
p_segment_value in varchar2,
p_column_name in varchar2,
p_chart_of_accounts_id in number,
p_application_id in number default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2;

/***********************************************************************************************/
/*  reverse the element order of a delimited text e.g. a path /gordon/supervisor/project to    */
/*  /project/supervisor/gordon. this is useful e.g. for connect by sqls to show                */
/*  sys connect by path in reverse order without changing the starting point of the query      */
/***********************************************************************************************/
function reverse(p_text in varchar2, p_delimiter in varchar2) return varchar;

/***********************************************************************************************/
/*  convert clob to blob                                                                       */
/***********************************************************************************************/
function clob_to_blob(p_clob in clob) return blob;

/***********************************************************************************************/
/*  convert blob to clob                                                                       */
/*  useful for example to extract text content from xml files stored in the db such as the     */
/*  dataquery sql statement from xml publisher data templates                                  */
/***********************************************************************************************/
function blob_to_clob(p_blob in blob) return clob;

/***********************************************************************************************/
/*  convert long datatype to clob                                                              */
/***********************************************************************************************/
function long_to_clob(p_table_name in varchar2, p_column_name in varchar2, p_row_id in rowid) return clob;

/***********************************************************************************************/
/*  convert blob to base64                                                                     */
/***********************************************************************************************/
function blob_to_base64(p_blob in blob) return clob;

/***********************************************************************************************/
/*  lengthb for clobs see oracle note 790886.1                                                 */
/***********************************************************************************************/
function clob_lengthb(p_clob in clob) return number;

/***********************************************************************************************/
/*  substrb for clobs up to 32767 characters, see oracle note 1571041.1                        */
/***********************************************************************************************/
function clob_substrb(p_clob in clob, p_byte_length in pls_integer, p_char_position in pls_integer) return clob;

/***********************************************************************************************/
/*  generate x number of rows for use in sql e.g. for regexp: table(xxen_util.rowgen(n)) rowgen*/
/***********************************************************************************************/
function rowgen(p_rows in number) return fnd_table_of_number deterministic;

/***********************************************************************************************/
/*  parse and return sql column names for use in sql e.g.                                      */
/*  select x.* from table(xxen_util.sql_columns('select * from hz_parties')) x                 */
/***********************************************************************************************/
/*
create type xxen_sql_desc_rec as object (
column_id number,
column_name varchar2(4000),
data_type varchar2(106),
data_length number,
data_precision number,
nullable varchar2 (1)
);
create type xxen_sql_desc_tbl is table of xxen_sql_desc_rec;
*/
function sql_columns(p_sql in clob) return xxen_sql_desc_tbl;

/***********************************************************************************************/
/*  remove whitespace from sql queries. mode values:                                           */
/*  'blank_lines': removes blank lines only                                                    */
/*  'leading_and_trailing': removes blank lines and leading and trailing space from each line  */
/*  'all': removes blank lines, leading and trailing and other unnecessary filling space       */
/***********************************************************************************************/
function remove_whitespace(p_clob in clob, p_mode in varchar2 default 'all') return clob;

/***********************************************************************************************/
/*  useful to avoid ora-01476: divisor is equal to zero                                        */
/***********************************************************************************************/
function zero_to_null(p_number in number) return number;

/***********************************************************************************************/
/*  returns time in format 67d 14h 45.3s for a given number of seconds                         */
/***********************************************************************************************/
function time(p_seconds in number) return varchar2 deterministic;

/***********************************************************************************************/
/*  returns the apps module type e.g. concurrent                                               */
/*  from a db session's module name e.g. e:per:cp:pay/pyuslv                                   */
/***********************************************************************************************/
function module_type(p_module in varchar2, p_action in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  returns the display application module name e.g. payroll worker process                    */
/*  from a db session's module name e.g. e:per:cp:pay/pyuslv                                   */
/***********************************************************************************************/
function module_name(p_module in varchar2, p_program in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  translates an apps session action e.g. sysadmin/system_administrator                       */
/*  to the responsibility e.g. system administrator                                            */
/***********************************************************************************************/
function responsibility(p_module in varchar2, p_action in varchar2) return varchar2;

/***********************************************************************************************/
/*  translates an apps session client_id e.g. sysadmin to a user_name including description    */
/*  e.g. sysadmin: system administrator                                                        */
/***********************************************************************************************/
function user_name(p_user_name in varchar2) return varchar2;

/***********************************************************************************************/
/*  returns user_name including description for a user_id                                      */
/***********************************************************************************************/
function user_name(p_user_id in pls_integer) return varchar2;

/***********************************************************************************************/
/*  returns user_id for a user_name                                                            */
/***********************************************************************************************/
function user_id(p_user_name in varchar2) return pls_integer result_cache;

/***********************************************************************************************/
/*  returns user_name for a client_id, even for indirect business events through conc requests */
/***********************************************************************************************/
function user_name(p_module in varchar2, p_action in varchar2, p_client_id in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  validates if a clob is a correctly formatted xml                                           */
/***********************************************************************************************/
function is_xml(p_clob in clob) return varchar2;

/***********************************************************************************************/
/*  ap invoice status                                                                          */
/***********************************************************************************************/
function ap_invoice_status(
p_invoice_id in number,
p_invoice_amount in number,
p_payment_status_flag in varchar2,
p_invoice_type_lookup_code in varchar2,
p_validation_request_id in number
) return varchar2;

function ap_invoice_status(p_invoice_id in number) return varchar2;

/***********************************************************************************************/
/*  converts server date to fnd user's client date in local timezone                           */
/***********************************************************************************************/
function client_time(p_date in date) return date deterministic;

/***********************************************************************************************/
/*  converts fnd user's client date to a date in server timezone                               */
/***********************************************************************************************/
function server_time(p_date in date) return date deterministic;

/***********************************************************************************************/
/*  application short name to application name                                                 */
/***********************************************************************************************/
function application_name(p_application_short_name in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  helper function required for correct report short name mapping                             */
/***********************************************************************************************/
function application_short_name_trans(p_application_short_name in varchar2) return varchar2 deterministic;

/***********************************************************************************************/
/*  application name to application short name                                                 */
/***********************************************************************************************/
function application_short_name(p_application_name in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer eul worksheet execution count                                                   */
/***********************************************************************************************/
function dis_eul_usage_count(p_eul varchar2) return number;

/***********************************************************************************************/
/*  discoverer default end user layer (with most frequent executions in eul5_qpp_stats)        */
/***********************************************************************************************/
function dis_default_eul return varchar2;

/***********************************************************************************************/
/*  discoverer user_id to discoverer username                                                  */
/***********************************************************************************************/
function dis_user(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer username to application user name or responsibility                             */
/***********************************************************************************************/
function dis_user_name(p_username in varchar2) return varchar2;

/***********************************************************************************************/
/*  discoverer user_id to application user name or responsibility                              */
/***********************************************************************************************/
function dis_user_name(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer username to user type                                                           */
/***********************************************************************************************/
function dis_user_type(p_username in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer user_id to user type                                                            */
/***********************************************************************************************/
function dis_user_type(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object                                                    */
/***********************************************************************************************/
function dis_folder_sql(p_object_id in number, p_eul in varchar2 default 'eul_us') return clob;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object, simplified, e.g. columns replaced by asterisk *   */
/***********************************************************************************************/
function dis_folder_sql2(p_object_id in number, p_eul in varchar2 default 'eul_us') return clob;

/***********************************************************************************************/
/*  discoverer worksheet SQL text from logging table ams_discoverer_sql                        */
/***********************************************************************************************/
function dis_worksheet_sql(p_workbook_owner_name in varchar2, p_workbook_name in varchar2, p_worksheet_name in varchar2) return clob;

/***********************************************************************************************/
/*  translates discoverer eul5_expressions.exp_formula1 to display formula text                */
/***********************************************************************************************/
function dis_formula(p_formula in varchar2, p_eul in varchar2 default 'eul_us') return varchar2;

/***********************************************************************************************/
/*  checks if discoverer EUL contains any data in ams_discoverer_sql to be imported            */
/***********************************************************************************************/
function dis_worksheet_exists(p_eul_name varchar2) return varchar2;

/***********************************************************************************************/
/*  default mrp planning compile designator for a org_id                                       */
/***********************************************************************************************/
function compile_designator(p_org_id in pls_integer) return varchar2;

/***********************************************************************************************/
/*  returns the next working day from bom_calendar_dates for a given start date and offset     */
/***********************************************************************************************/
function calendar_date_offset(p_date in date, p_calendar_code in varchar2, p_offset_days in number default 0, p_calendar_exception_set_id in number default -1) return date;

/***********************************************************************************************/
/*  returns sequence.nextval for use in merge statements to avid wasting sequence values       */
/***********************************************************************************************/
function sequence_nextval(p_sequence_name in varchar2) return number;

/***********************************************************************************************/
/*  translates oracle language codes to BCP47 codes e.g. for use in ECC queries                */
/***********************************************************************************************/
function bcp47_language(p_language_code in varchar2) return varchar result_cache;

end xxen_util;
/

create or replace package body apps.xxen_util is

/***********************************************************************************************/
/*                                                                                             */
/*       Blitz Report utility package with reusable functions for Oracle EBS.                  */
/*       While the Blitz Report software is licensed as detailed on our webpage                */
/*       www.enginatics.com this utility package is free for use, regardless if                */
/*       you are a Blitz Report customer or not.                                               */
/*                                                                                             */
/*                          (c) 2010-2020 Enginatics GmbH                                      */
/*                                 www.enginatics.com                                          */
/*                                                                                             */
/*                             Copyright and legal notes:                                      */
/*                                                                                             */
/*       Permission is hereby granted, free of charge, to any person obtaining a copy          */
/*       of this software and associated documentation files (the "Software"), to deal         */
/*       in the Software without restriction, including without limitation the rights          */
/*       to use, copy, modify, merge, publish, distribute, sublicense, and/or sell             */
/*       copies of the Software, and to permit persons to whom the Software is                 */
/*       furnished to do so, subject to the following conditions                               */
/*                                                                                             */
/*       The above copyright notice and this permission notice shall be included in            */
/*       all copies or substantial portions of the Software.                                   */
/*                                                                                             */
/*       The software is provided 'As Is', without warranty of any kind, express or            */
/*       implied, including but not limited to the warranties of merchantability,              */
/*       fitness for a particular purpose and noninfringement. in no event shall the           */
/*       authors or copyright holders be liable for any claim, damages or other                */
/*       liability, whether in an action of contract, tort or otherwise, arising from,         */
/*       out of or in connection with the software or the use or other dealings in             */
/*       the software.                                                                         */
/*                                                                                             */
/***********************************************************************************************/
g_current_org_id number(15);


function base_language return varchar2 deterministic is
begin
  for c in (select fl.language_code from fnd_languages fl where fl.installed_flag='B') loop
    return c.language_code;
  end loop;
end base_language;


function fnd_message(p_message_name in varchar2, p_application_short_name in varchar2 default null) return varchar2 is
function fnd_message_(p_message_name in varchar2, p_userenv_lang in varchar2, p_application_short_name in varchar2) return varchar2 result_cache is
l_message varchar2(4000);
begin
  for c in (
  select distinct
  min(fnm.message_text) keep (dense_rank first order by decode(fnm.language_code,xxen_util.base_language,2,1)) over () message_text
  from
  fnd_application fa,
  fnd_new_messages fnm
  where
  fa.application_short_name=p_application_short_name and
  fa.application_id=fnm.application_id and
  fnm.message_name=p_message_name and
  fnm.language_code in (xxen_util.base_language,p_userenv_lang)
  ) loop
    l_message:=c.message_text;
  end loop;
  return nvl(l_message,p_message_name);
end fnd_message_;
begin
  return fnd_message_(p_message_name, userenv('lang'), coalesce(p_application_short_name,xxen_api.application_short_name));
end fnd_message;


function meaning(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_code_if_null in varchar2 default null) return varchar2 is
function meaning(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_userenv_lang in varchar2, p_code_if_null in varchar2) return varchar2 result_cache is
l_meaning varchar2(80);
begin
  for c in (
  select
  flv.meaning
  from
  fnd_lookup_values flv
  where
  flv.lookup_code=p_lookup_code and
  flv.lookup_type=p_lookup_type and
  flv.view_application_id=p_application_id and
  flv.language=p_userenv_lang and
  flv.security_group_id=0
  ) loop
    l_meaning:=c.meaning;
  end loop;
  return nvl(l_meaning,case when p_code_if_null='Y' then p_lookup_code end);
end meaning;
begin
  return meaning(p_lookup_code, p_lookup_type, p_application_id, userenv('lang'), p_code_if_null);
end meaning;


function description(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2) return varchar2 is
function description(p_lookup_code in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_userenv_lang in varchar2) return varchar2 result_cache is
l_description varchar2(240);
begin
  for c in (
  select distinct
  min(flv.description) keep (dense_rank first order by decode(flv.source_lang,xxen_util.base_language,2,1)) over () description
  from
  fnd_lookup_values flv
  where
  flv.lookup_code=p_lookup_code and
  flv.lookup_type=p_lookup_type and
  flv.view_application_id=p_application_id and
  flv.language in (xxen_util.base_language,p_userenv_lang) and
  flv.source_lang in (xxen_util.base_language,p_userenv_lang) and
  flv.security_group_id=0
  ) loop
    l_description:=c.description;
  end loop;
  return l_description;
end description;
begin
  return description(p_lookup_code, p_lookup_type, p_application_id, userenv('lang'));
end description;


function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2) return varchar2 is
function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_userenv_lang in varchar2) return varchar2 result_cache is
l_lookup_code varchar2(80);
begin
  for c in (
  select
  flv.lookup_code
  from
  fnd_lookup_values flv
  where
  flv.meaning=p_meaning and
  flv.lookup_type=p_lookup_type and
  flv.view_application_id=p_application_id and
  flv.language=p_userenv_lang and
  flv.security_group_id=0
  ) loop
    l_lookup_code:=c.lookup_code;
  end loop;
  return l_lookup_code;
end lookup_code;

begin
  return lookup_code(p_meaning, p_lookup_type, p_application_id, userenv('lang'));
end lookup_code;


function regexp_escape(p_text in varchar2) return varchar is
begin
return
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(p_text,
'\','\\'),
'^','\^'),
'.','\.'),
'$','\$'),
'|','\|'),
'(','\('),
')','\)'),
'[','\['),
']','\]'),
'*','\*'),
'+','\+'),
'?','\?'),
'{','\{'),
'}','\}');
end regexp_escape;


function contains(p_parameter_value in varchar2, p_column_value in varchar2) return varchar2 is
begin
  return case when regexp_like(case when p_parameter_value like '<multiple_values>%' then substr(p_parameter_value,18) else p_parameter_value end,'(^|;)\s*'||regexp_escape(p_column_value)||'\s*(;|$)') then 'Y' end;
end contains;


function display_profile_option_value(
p_application_id in number,
p_profile_option_id in number,
p_profile_option_value in varchar2
) return varchar2 is
l_display_option_value varchar2(4000);
begin
  for c in (
  select /*+ result_cache*/
  'select x.visible_option_value from ('||w.sql_text___||') x where x.profile_option_value=:profile_option_value' sql_text____,
  w.*
  from
  (
  select
  nvl2(v.visible_value_column_alias,
  regexp_replace(v.sql_text__,'\s'||xxen_util.regexp_escape(v.visible_value_column_alias)||'(\s|,)',' visible_option_value\1',1,1),
  regexp_replace(v.sql_text__,'(\s|,)'||xxen_util.regexp_escape(v.visible_value_column)||'(\s|,)','\1'||v.visible_value_column||' visible_option_value'||'\2',1,1)
  ) sql_text___,
  v.*
  from
  (
  select
  nvl2(u.value_column_alias,
  regexp_replace(u.sql_text_,'\s'||xxen_util.regexp_escape(u.value_column_alias)||'(\s|,)',' profile_option_value\1',1,1),
  regexp_replace(u.sql_text_,'(\s|,)'||xxen_util.regexp_escape(u.value_column)||'(\s|,)','\1'||u.value_column||' profile_option_value'||'\2',1,1)
  ) sql_text__,
  u.*
  from
  (
  select
  case when z.profile_option_name like '______\_TIMEZONE_ID' escape '\' then 'upgrade_tz_id' else nvl(regexp_substr(z.value_column,'(.+)\s+\w+',1,1,'n',1),z.value_column) end value_column_0,
  case when z.profile_option_name like '______\_TIMEZONE_ID' escape '\' then '''(GMT ''||rtrim(tz_offset(timezone_code),chr(0))||'') ''||name' else nvl(regexp_substr(z.visible_value_column,'(.+)\s+\w+',1,1,'n',1),z.visible_value_column) end visible_value_column_0,
  case when z.profile_option_name like '______\_TIMEZONE_ID' escape '\' then null else regexp_substr(z.value_column,'\w+\s+(.+)',1,1,'n',1) end value_column_alias,
  case when z.profile_option_name like '______\_TIMEZONE_ID' escape '\' then null else regexp_substr(z.visible_value_column,'\w+\s+(.+)',1,1,'n',1) end visible_value_column_alias,
  z.*
  from
  (
  select
  case when y.profile_option_name like '______\_TIMEZONE_ID' escape '\' then 'upgrade_tz_id' else regexp_substr(
  case
  when y.into_clause1 like '%profile_option%_value%' then y.column1
  when y.into_clause2 like '%profile_option%_value%' then y.column2
  when y.into_clause3 like '%profile_option%_value%' then y.column3
  when y.into_clause4 like '%profile_option%_value%' then y.column4
  end,'^\s*(.+?)\s*$',1,1,null,1) end value_column,
  case when y.profile_option_name like '______\_TIMEZONE_ID' escape '\' then '''(GMT ''||rtrim(tz_offset(timezone_code),chr(0))||'') ''||name' else regexp_substr(
  case
  when y.into_clause1 like '%visible_option_value%' then y.column1
  when y.into_clause2 like '%visible_option_value%' then y.column2
  when y.into_clause3 like '%visible_option_value%' then y.column3
  end,'^\s*(.+?)\s*$',1,1,null,1) end visible_value_column,
  y.*
  from
  (
  select
  regexp_count(x.column_clause,'[^,]*\(.*?\)[^,]*|[^,]+') column_clause_count,
  regexp_count(x.into_clause,'[^,]+') into_clause_count,
  lower(regexp_substr(x.into_clause,'[^,]+',1,1)) into_clause1,
  lower(regexp_substr(x.into_clause,'[^,]+',1,2)) into_clause2,
  lower(regexp_substr(x.into_clause,'[^,]+',1,3)) into_clause3,
  lower(regexp_substr(x.into_clause,'[^,]+',1,4)) into_clause4,
  regexp_substr(x.column_clause,'[^,]*\(.*?\)[^,]*|[^,]+',1,1) column1,
  regexp_substr(x.column_clause,'[^,]*\(.*?\)[^,]*|[^,]+',1,2) column2,
  regexp_substr(x.column_clause,'[^,]*\(.*?\)[^,]*|[^,]+',1,3) column3,
  regexp_substr(x.column_clause,'[^,]*\(.*?\)[^,]*|[^,]+',1,4) column4,
  x.*
  from
  (
  select
  regexp_substr(fpo.sql_text,'select\s+(distinct\s+)?(.+)\s+into\s+',1,1,'in',2) column_clause,
  regexp_substr(fpo.sql_text,'into\s{1}(.+?)\s+from\s+',1,1,'in',1) into_clause,
  regexp_replace(fpo.sql_text,'\s+into\s+.+?\s+from\s+',' from ',1,1,'in') sql_text_,
  fpo.*
  from
  (
  select
  replace(regexp_replace(replace(trim(trim('"' from regexp_substr(regexp_replace(fpo.sql_validation,'\\"[^\]*\\"'),'"[^"]+"'))),'\''',''''),'\s*\|\|\s*','||'),':$PROFILES$.','fnd_global.') sql_text,
  fpo.sql_validation,
  fpo.profile_option_name
  from
  fnd_profile_options fpo
  where
  fpo.application_id=p_application_id and
  fpo.profile_option_id=p_profile_option_id and
  fpo.sql_validation is not null
  ) fpo
  ) x
  ) y
  ) z
  ) u
  where
  u.value_column_0<>u.visible_value_column_0
  ) v
  ) w
  ) loop
    execute immediate c.sql_text____ into l_display_option_value using p_profile_option_value;
  end loop;
  return nvl(l_display_option_value,p_profile_option_value);
exception when others then
  return p_profile_option_value;
end display_profile_option_value;


function display_flexfield_value(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_column_name in varchar2,
p_rowid in rowid,
p_business_group_id in number default null,
p_organization_id in number default null,
p_org_information_id in number default null
) return varchar2 is
l_table_name varchar2(30);
l_flexfield_value varchar2(4000);
l_sql_text varchar2(32767);
l_additional_where_clause varchar2(32767);
l_cursor pls_integer;
l_row_count pls_integer;
l_bind_value varchar2(4000);
l_display_value varchar2(4000);
type tp_flex_rec is record (flex varchar2(100), bind varchar2(100), column_name varchar2(30));
type tp_flex is table of tp_flex_rec index by pls_integer;
l_flex tp_flex;
l_prev_bind_name varchar2(100):='-99';
l_prev_bind_value varchar2(4000);
begin
  if p_application_id is not null and p_descriptive_flexfield_name is not null then
    for c in (
    select /*+ result_cache*/
    fdf.*
    from
    fnd_descriptive_flexs fdf
    where
    fdf.application_id=p_application_id and
    fdf.descriptive_flexfield_name=p_descriptive_flexfield_name
    ) loop
      l_table_name:=c.application_table_name;
    end loop;
    execute immediate 'select x.'||p_column_name||' from '||l_table_name||' x where x.rowid=:p_rowid' into l_flexfield_value using p_rowid;
    l_display_value:=l_flexfield_value;
    if l_flexfield_value is not null then
      for c in (
      select /*+ result_cache*/
      fdfcu.flex_value_set_id,
      ffvs.flex_value_set_name,
      ffvs.validation_type,
      ffvt.value_column_name,
      ffvt.meaning_column_name,
      ffvt.id_column_name,
      ffvt.application_table_name,
      ffvt.additional_where_clause
      from
      fnd_descr_flex_column_usages fdfcu,
      fnd_flex_value_sets ffvs,
      (select ffvt.* from fnd_flex_validation_tables ffvt where ffvt.id_column_name is not null or ffvt.meaning_column_name is not null) ffvt
      where
      fdfcu.application_id=p_application_id and
      fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
      fdfcu.application_id=p_application_id and
      fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
      fdfcu.descriptive_flex_context_code=nvl(p_context_code,'Global Data Elements') and
      fdfcu.application_column_name=p_column_name and
      fdfcu.flex_value_set_id=ffvs.flex_value_set_id and
      decode(ffvs.validation_type,'F',ffvs.flex_value_set_id)=ffvt.flex_value_set_id(+)
      ) loop
        if c.validation_type in ('D','I','X','Y') then
          l_sql_text:='select ffvv.flex_value_meaning||nvl2(ffvv.description,'': ''||ffvv.description,null) display_value from fnd_flex_values_vl ffvv where ffvv.flex_value=:p_flexfield_value';
        elsif c.validation_type='F' and c.application_table_name is not null then
          if c.flex_value_set_name='PER_BUDGET_MEASUREMENT_TYPE' then
            l_additional_where_clause:='where lookup_type=''BUDGET_MEASUREMENT_TYPE''';
          else
            l_additional_where_clause:=trim(c.additional_where_clause);
          end if;
          if p_business_group_id is not null then
            l_additional_where_clause:=regexp_replace(l_additional_where_clause,':\$PROFILES\$\.per_business_group_id(:null)*',':p_business_group_id',1,0,'i');
          end if;
          if p_organization_id is not null then
            l_additional_where_clause:=regexp_replace(l_additional_where_clause,':\$PROFILES\$\.per_organization_id(:null)*',':p_organization_id',1,0,'i');
          end if;
          if p_org_information_id is not null then
            l_additional_where_clause:=regexp_replace(l_additional_where_clause,':\$PROFILES\$\.per_org_information_id(:null)*',':p_org_information_id',1,0,'i');
          end if;
          if upper(l_additional_where_clause) like '%:$PROFILES$.%' then
            l_additional_where_clause:=regexp_replace(l_additional_where_clause,'([A-Za-z0-9_.'']+\s*(\(\+\))*|[A-Za-z0-9_.]*\s*\([^(]+\))\s*(=|<>|(!|\^)=)\s*:\$PROFILES\$\.\w+(:null)*','1=1',1,0,'i'); -- xyz | func(xyz) = $PROFILES
            if upper(l_additional_where_clause) like '%:$PROFILES$.%' then
              l_additional_where_clause:=regexp_replace(l_additional_where_clause,':\$PROFILES\$\.\w+(:null)*\s*(=|<>|(!|\^)=)\s*([A-Za-z0-9_.'']+\s*(\(\+\))*|[A-Za-z0-9_.]*\([^)]+\))','1=1',1,0,'i'); -- $PROFILES = xyz | func(xyz)
              if upper(l_additional_where_clause) like '%:$PROFILES$.%' then
                l_additional_where_clause:=regexp_replace(l_additional_where_clause,'([A-Za-z0-9_.'']+\s*(\(\+\))*|[A-Za-z0-9_.]*\s*\([^(]+\))\s*(=|<>|(!|\^)=)\s*[A-Za-z0-9_.]*\s*\([^(]*:\$PROFILES\$\.\w+(:null)*[^)]*\)','1=1',1,0,'i'); -- xyz | func(xyz) = func($PROFILES)
                if upper(l_additional_where_clause) like '%:$PROFILES$.%' then
                  l_additional_where_clause:=regexp_replace(l_additional_where_clause,':\$PROFILES\$\.\w+(:null)*','null',1,0,'i'); --replace remaining with null
                end if;
              end if;
            end if;
          end if;
          if lower(l_additional_where_clause) not like 'where%' and lower(l_additional_where_clause) not like 'order by%' then
            l_additional_where_clause:='where '||l_additional_where_clause;
          end if;
          l_sql_text:='select x.value||nvl2(x.meaning,'': ''||x.meaning,null) display_value from (select '||c.value_column_name||' value, '||case when c.meaning_column_name is not null then c.meaning_column_name else 'null' end||' meaning, '||nvl(c.id_column_name,c.value_column_name)||' bind from '||c.application_table_name||' '||l_additional_where_clause||') x where x.bind=:p_flexfield_value';
          if upper(l_additional_where_clause) like '%:$FLEX$.%' then
            --fill dynamic FLEX bind table
            select
            y.flex,
            y.bind,
            z.application_column_name
            bulk collect into l_flex
            from
            (
            select
            decode(instr(x.flex,':',9,1),0,substr(x.flex,9),substr(x.flex,9,instr(x.flex,':',9,1)-9)) bind,
            x.*
            from
            (
            select distinct
            dbms_lob.substr(regexp_substr(l_sql_text,':\$FLEX\$\.\w+(:null)*',1,level,'i')) flex
            from dual connect by level<=regexp_count(l_sql_text,':\$FLEX\$\.\w+(:null)*',1,'i')
            ) x
            ) y,
            (
            select
            fdfcu.end_user_column_name,
            ffvs.flex_value_set_name,
            fdfcu.application_column_name
            from
            fnd_descr_flex_column_usages fdfcu,
            fnd_flex_value_sets ffvs
            where
            fdfcu.application_id=p_application_id and
            fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
            fdfcu.descriptive_flex_context_code=nvl(p_context_code,'Global Data Elements') and
            fdfcu.flex_value_set_id=ffvs.flex_value_set_id(+)
            ) z
            where
            y.bind=z.flex_value_set_name or y.bind=z.end_user_column_name
            order by
            length(y.bind) desc,
            y.bind;

            --replace :$FLEX$. with bind string
            for i in l_flex.first..l_flex.last loop
              l_sql_text:=replace(l_sql_text,l_flex(i).flex,':'||substr(l_flex(i).bind,1,30));
            end loop;
          end if;
        end if;
        if l_sql_text is not null then
          --parse
          l_cursor:=dbms_sql.open_cursor;
          dbms_sql.parse(l_cursor, l_sql_text, dbms_sql.native);

          --bind
          dbms_sql.bind_variable(l_cursor,':p_flexfield_value',l_flexfield_value);
          if l_sql_text like '%:p_business_group_id%' then
            dbms_sql.bind_variable(l_cursor,':p_business_group_id',p_business_group_id);
          end if;
          if l_sql_text like '%:p_organization_id%' then
            dbms_sql.bind_variable(l_cursor,':p_organization_id',p_organization_id);
          end if;
          if l_sql_text like '%:p_org_information_id%' then
            dbms_sql.bind_variable(l_cursor,':p_org_information_id',p_organization_id);
          end if;
          if l_flex.first is not null then
            for i in l_flex.first..l_flex.last loop
              execute immediate 'select x.'||l_flex(i).column_name||' from '||l_table_name||' x where x.rowid=:p_rowid' into l_bind_value using p_rowid;
              if l_flex(i).bind<>l_prev_bind_name or l_bind_value is not null then
                dbms_sql.bind_variable(l_cursor,':'||substr(l_flex(i).bind,1,30),l_bind_value);
                l_prev_bind_name:=l_flex(i).bind;
                l_prev_bind_value:=l_bind_value;
              end if;
            end loop;
          end if;

          --define_column
          dbms_sql.define_column(l_cursor, 1, l_display_value, 4000);

          --execute and fetch
          l_row_count:=dbms_sql.execute(l_cursor);
          if dbms_sql.fetch_rows(l_cursor)>0 then
            dbms_sql.column_value(l_cursor, 1, l_display_value);
          end if;
          dbms_sql.close_cursor(l_cursor);
        end if;
      end loop;
    end if;
  end if;
  return l_display_value;
exception when others then
  if dbms_sql.is_open(l_cursor) then
    dbms_sql.close_cursor(l_cursor);
  end if;
  return l_display_value;
end display_flexfield_value;


function concatenated_segments(p_code_combination_id in number) return varchar2 result_cache is
l_concatenated_segments varchar2(800);
begin
  for c in (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id=p_code_combination_id) loop
    l_concatenated_segments:=c.concatenated_segments;
  end loop;
  return l_concatenated_segments;
end concatenated_segments;


function segments_description(p_code_combination_id in number) return varchar2 is

function segments_description(p_code_combination_id in number, p_userenv_lang in varchar2) return varchar2 result_cache is
l_segments_description varchar2(4000);
begin
  for c in (
  select
  ffvt.description,
  x.*
  from
  (
  select
  fifs.segment_num,
  fifst.form_left_prompt,
  decode(fifs.application_column_name,
  'SEGMENT1',gcck.segment1,
  'SEGMENT2',gcck.segment2,
  'SEGMENT3',gcck.segment3,
  'SEGMENT4',gcck.segment4,
  'SEGMENT5',gcck.segment5,
  'SEGMENT6',gcck.segment6,
  'SEGMENT7',gcck.segment7,
  'SEGMENT8',gcck.segment8,
  'SEGMENT9',gcck.segment9,
  'SEGMENT10',gcck.segment10,
  'SEGMENT11',gcck.segment11,
  'SEGMENT12',gcck.segment12,
  'SEGMENT13',gcck.segment13,
  'SEGMENT14',gcck.segment14,
  'SEGMENT15',gcck.segment15,
  'SEGMENT16',gcck.segment16,
  'SEGMENT17',gcck.segment17,
  'SEGMENT18',gcck.segment18,
  'SEGMENT19',gcck.segment19,
  'SEGMENT20',gcck.segment20,
  'SEGMENT21',gcck.segment21,
  'SEGMENT22',gcck.segment22,
  'SEGMENT23',gcck.segment23,
  'SEGMENT24',gcck.segment24,
  'SEGMENT25',gcck.segment25,
  'SEGMENT26',gcck.segment26,
  'SEGMENT27',gcck.segment27,
  'SEGMENT28',gcck.segment28,
  'SEGMENT29',gcck.segment29,
  'SEGMENT30',gcck.segment30
  ) segment_value,
  fifs.flex_value_set_id
  from
  gl_code_combinations_kfv gcck,
  fnd_id_flex_segments fifs,
  fnd_id_flex_segments_tl fifst
  where
  gcck.code_combination_id=p_code_combination_id and
  gcck.chart_of_accounts_id=fifs.id_flex_num and
  fifs.application_id=101 and
  fifs.id_flex_code='GL#' and
  fifs.application_id=fifst.application_id and
  fifs.id_flex_code=fifst.id_flex_code and
  fifs.id_flex_num=fifst.id_flex_num and
  fifs.application_column_name=fifst.application_column_name and
  fifst.language=p_userenv_lang
  ) x,
  fnd_flex_values ffv,
  fnd_flex_values_tl ffvt
  where
  x.flex_value_set_id=ffv.flex_value_set_id and
  ffv.parent_flex_value_low is null and
  x.segment_value=ffv.flex_value and
  ffv.flex_value_id=ffvt.flex_value_id and
  ffvt.language=p_userenv_lang
  order by
  x.segment_num
  ) loop
    l_segments_description:=l_segments_description||c.form_left_prompt||': '||c.description||chr(10);
  end loop;
  return l_segments_description;
end segments_description;

begin
  return trim(segments_description(p_code_combination_id, userenv('lang')));
end segments_description;


function segment_description(
p_segment_value in varchar2,
p_column_name in varchar2,
p_chart_of_accounts_id in number,
p_application_id in number default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2 is

function segment_description(
p_segment_value in varchar2,
p_column_name in varchar2,
p_chart_of_accounts_id in number,
p_application_id in number,
p_id_flex_code in varchar2,
p_userenv_lang in varchar2
) return varchar2 result_cache is
l_segment_description varchar2(4000);
begin
  for c in (
  select
  ffvt.description
  from
  fnd_id_flex_segments fifs,
  fnd_flex_values ffv,
  fnd_flex_values_tl ffvt
  where
  fifs.application_column_name=p_column_name and
  fifs.id_flex_num=p_chart_of_accounts_id and
  fifs.application_id=p_application_id and
  fifs.id_flex_code=p_id_flex_code and
  fifs.flex_value_set_id=ffv.flex_value_set_id and
  ffv.parent_flex_value_low is null and
  ffv.flex_value=p_segment_value and
  ffv.flex_value_id=ffvt.flex_value_id and
  ffvt.language=p_userenv_lang
  ) loop
    l_segment_description:=c.description;
  end loop;
  return l_segment_description;
end segment_description;

begin
  return
  segment_description(
  p_segment_value,
  p_column_name,
  p_chart_of_accounts_id,
  p_application_id,
  p_id_flex_code,
  userenv('lang')
  );
end segment_description;


function reverse(p_text in varchar2, p_delimiter in varchar2) return varchar is
l_text varchar2(32767);
l_length_delim pls_integer:=length(p_delimiter);
l_length pls_integer:=length(p_text)+1;
l_end pls_integer:=l_length;
l_start pls_integer;
begin
  if p_text is null or p_delimiter is null then
    return p_text;
  else
    loop
      l_start:=instr(p_text,p_delimiter,l_end-l_length-1);
      exit when l_start=0;
      l_text:=l_text||p_delimiter||substr(p_text,l_start+l_length_delim,l_end-l_start-l_length_delim);
      l_end:=l_start;
    end loop;
    return l_text;
  end if;
end reverse;


function clob_to_blob(p_clob in clob) return blob is
l_blob blob;
l_amount number;
l_dest_offset number:=1;
l_src_offset number:=1;
l_lang_context number:=dbms_lob.default_lang_ctx;
l_warning number;
begin
  if p_clob is null then
    return null;
  else
    l_amount:=dbms_lob.getlength(p_clob);
    if l_amount=0 then
      return null;
    else
      dbms_lob.createtemporary(l_blob,true);
      dbms_lob.converttoblob(
      dest_lob=>l_blob,
      src_clob=>p_clob,
      amount=>l_amount,
      dest_offset=>l_dest_offset,
      src_offset=>l_src_offset,
      blob_csid=>dbms_lob.default_csid,
      lang_context=>l_lang_context,
      warning=>l_warning
      );
      return l_blob;
    end if;
  end if;
end clob_to_blob;


function blob_to_clob(p_blob in blob) return clob is
l_clob clob;
l_amount number;
l_dest_offset number:=1;
l_src_offset number:=1;
l_lang_context number:=dbms_lob.default_lang_ctx;
l_warning number;
begin
  if p_blob is null then
    return null;
  else
    if dbms_lob.substr(p_blob,3,1)='EFBBBF' then
      l_src_offset:=4;
      l_amount:=dbms_lob.getlength(p_blob)-3;
    else
      l_amount:=dbms_lob.getlength(p_blob);
    end if;
    if l_amount=0 then
      return null;
    else
      dbms_lob.createtemporary(l_clob,true);
      dbms_lob.converttoclob(
      dest_lob=>l_clob,
      src_blob=>p_blob,
      amount=>l_amount,
      dest_offset=>l_dest_offset,
      src_offset=>l_src_offset,
      blob_csid=>nls_charset_id('utf8'),
      lang_context=>l_lang_context,
      warning=>l_warning
      );
      return l_clob;
    end if;
  end if;
end blob_to_clob;


function long_to_clob(p_table_name in varchar2, p_column_name in varchar2, p_row_id in rowid) return clob is
l_cursor integer default dbms_sql.open_cursor;
l_row_count pls_integer;
l_offset pls_integer:=0;
l_value_length pls_integer;
l_value varchar2(32767);
l_clob clob;
begin
  dbms_sql.parse(l_cursor,'select '||p_column_name||' from '||p_table_name||' where rowid=:p_row_id',dbms_sql.native);
  dbms_sql.bind_variable(l_cursor,':p_row_id',p_row_id);
  dbms_sql.define_column_long(l_cursor,1);
  l_row_count:=dbms_sql.execute(l_cursor);
  if dbms_sql.fetch_rows(l_cursor)>0 then
    loop
      dbms_sql.column_value_long(l_cursor, 1, 32767, l_offset, l_value, l_value_length);
      l_clob:=l_clob||l_value;
      l_offset:=l_offset+32767;
      exit when l_value_length<32767;
    end loop;
  end if;
  dbms_sql.close_cursor(l_cursor);
  return l_clob;
end long_to_clob;


function blob_to_base64(p_blob in blob) return clob is
l_file_size pls_integer:=dbms_lob.getlength(p_blob);
l_len pls_integer:=19200;
l_blob64 blob;
begin
  dbms_lob.createtemporary(l_blob64, true);
  for i in 0..trunc((l_file_size-1)/l_len) loop
    dbms_lob.append(l_blob64,utl_encode.base64_encode(dbms_lob.substr(p_blob,l_len,i*l_len+1)));
  end loop;
  return blob_to_clob(l_blob64);
end blob_to_base64;


function clob_lengthb(p_clob in clob) return number is
begin
  return dbms_lob.getlength(clob_to_blob(p_clob));
end clob_lengthb;


function clob_substrb(p_clob in clob, p_byte_length in pls_integer, p_char_position in pls_integer) return clob is
begin
  return substrb(dbms_lob.substr(p_clob,p_byte_length,p_char_position),1,p_byte_length);
end clob_substrb;


function rowgen(p_rows in number) return fnd_table_of_number is
l_number_tbl fnd_table_of_number:=fnd_table_of_number();
begin
  for i in 1..nvl(p_rows,0) loop
    l_number_tbl.extend();
    l_number_tbl(i):=i;
  end loop;
  return l_number_tbl;
end rowgen;


function sql_columns(p_sql in clob) return xxen_sql_desc_tbl is
l_cursor pls_integer:=dbms_sql.open_cursor;
l_desc_tab dbms_sql.desc_tab3;
l_col_count pls_integer;
l_sql_desc_tbl xxen_sql_desc_tbl:=xxen_sql_desc_tbl();
begin
  dbms_sql.parse(l_cursor, p_sql, dbms_sql.native);
  dbms_sql.describe_columns3(l_cursor, l_col_count, l_desc_tab);
  dbms_sql.close_cursor(l_cursor);
  for c in 1..l_col_count loop
    l_sql_desc_tbl.extend();
    l_sql_desc_tbl(c):=xxen_sql_desc_rec(null,null,null,null,null,null);
    l_sql_desc_tbl(c).column_id:=c;
    l_sql_desc_tbl(c).column_name:=substrb(l_desc_tab(c).col_name,1,251);
    l_sql_desc_tbl(c).data_type:=case l_desc_tab(c).col_type
    when 1 then 'VARCHAR2'
    when 2 then 'NUMBER'
    when 8 then 'LONG'
    when 11 then 'ROWID'
    when 12 then 'DATE'
    when 23 then 'RAW'
    when 24 then 'LONG'
    when 96 then 'CHAR'
    when 100 then 'BINARY_FLOAT'
    when 101 then 'BINARY_DOUBLE'
    when 102 then 'CURSOR'
    when 106 then 'MLSLABEL'
    when 109 then 'USER_DEFINED'
    when 111 then 'REF'
    when 112 then 'CLOB'
    when 113 then 'BLOB'
    when 114 then 'BFILE'
    when 180 then 'TIMESTAMP'
    when 181 then 'TIMESTAMP'
    when 182 then 'INTERVAL_YEAR_TO_MONTH'
    when 183 then 'INTERVAL_DAY_TO_SECOND'
    when 208 then 'UROWID'
    when 231 then 'TIMESTAMP_WITH_LOCAL_TZ'
    else to_char(l_desc_tab(c).col_type) end;
    l_sql_desc_tbl(c).data_length:=l_desc_tab(c).col_max_len;
    l_sql_desc_tbl(c).data_precision:=case when l_desc_tab(c).col_precision>0 then l_desc_tab(c).col_precision end;
    l_sql_desc_tbl(c).nullable:=case when l_desc_tab(c).col_null_ok then 'Y' else 'N' end;
  end loop;
  return l_sql_desc_tbl;
exception when others then
  if dbms_sql.is_open(l_cursor) then
    dbms_sql.close_cursor(l_cursor);
  end if;
  l_sql_desc_tbl.extend();
  l_sql_desc_tbl(1):=xxen_sql_desc_rec(null,null,null,null,null,null);
  l_sql_desc_tbl(1).column_name:='---- error ----';
  l_sql_desc_tbl(1).data_type:=substr(dbms_utility.format_error_stack,1,106);
  return l_sql_desc_tbl;
end sql_columns;


function remove_whitespace(p_clob in clob, p_mode in varchar2 default 'all') return clob is
l_clob clob;
l_line_number pls_integer:=0;
l_offset pls_integer:=1;
l_line varchar2(32767);
l_line_length pls_integer;
l_total_length pls_integer:=length(p_clob);
begin
  if p_mode in ('blank_lines','leading_and_trailing','all') then
    dbms_lob.createtemporary(l_clob, true);
    while l_offset<=l_total_length loop
      l_line_number:=l_line_number+1;
      l_line_length:=instr(p_clob,chr(10),l_offset)-l_offset;
      if l_line_length<0 then
        l_line_length:=l_total_length+1-l_offset;
      end if;

      l_line:=substr(p_clob,l_offset,l_line_length);
      if p_mode in ('leading_and_trailing','all') then
        l_line:=regexp_substr(l_line,'\s*(.+)\s*',1,1,null,1);
      end if;
      if p_mode='all' then
        l_line:=replace(
        replace(
        replace(
        replace(
        replace(
        regexp_replace(
        l_line,
        '\s+',' '),
        ', ',','),
        ' = ','='),
        ' <> ','<>'),
        ' )',' )'),
        '( ','(');
      end if;

      if regexp_replace(l_line,'\s*') is not null then
        dbms_lob.append(l_clob,l_line||chr(10));
      end if;
      l_offset:=l_offset+l_line_length+1;
    end loop;
    return l_clob;
  else
    return p_clob;
  end if;
end remove_whitespace;


function zero_to_null(p_number in number) return number is
begin
  return case when p_number=0 then null else p_number end;
end;


function time(p_seconds in number) return varchar2 is
begin
  return case when p_seconds is not null then
  case when p_seconds>=86400 then trunc(p_seconds/86400)||'d ' end||
  case when p_seconds>=3600 then trunc(mod(p_seconds,86400)/3600)||'h ' end||
  case when p_seconds>=60 then trunc(mod(p_seconds,3600)/60)||'m ' end||
  trunc(mod(p_seconds,60))||'s'
  end;
end time;


function module_type(p_module in varchar2, p_action in varchar2) return varchar2 result_cache is
l_module_type varchar2(260);
begin
  l_module_type:=
  case
  when regexp_like(p_module,'^e:\w+:cp:\w+/\w+$') then 'Concurrent Request'
  when regexp_like(p_module,'^e:\w*:(cp|gsm|GSM):\w+$') then 'Concurrent Manager'
  when regexp_like(p_module,'^e:\w+:frm:\w+$') then 'Form'
  when regexp_like(p_module,'^e:\w+:fwk:\w+$') then 'OAF'
  when regexp_like(p_module,'^e:\w+:wf:\w+$') then 'Workflow'
  when regexp_like(p_module,'^e:\w*:bes:.+$') then 'Business Event'
  when p_module like 'XXEN_REPORT - %' then 'Blitz Report'
  when p_module like 'Disco%' or p_module like 'dis%adm%' or p_module like 'dis%usr%' or p_module like 'dis%ws%' then 'Discoverer'
  when nvl(p_action,'x') not like '%_/_%' and p_action<>'/' then p_action
  end;
  if l_module_type is null then
    for c in (
      select null from fnd_concurrent_programs fcp where fcp.concurrent_program_name=p_module and rownum=1
    ) loop
      l_module_type:='Concurrent Request';
    end loop;
  end if;
  return l_module_type;
end module_type;


function module_name(p_module in varchar2, p_program in varchar2 default null) return varchar2 is

function module_name(p_module in varchar2, p_userenv_lang in varchar2, p_program in varchar2 default null) return varchar2 result_cache is
l_apps_module varchar2(260);
l_module sys.v_$session.module%type;
begin
  for c in (
  select
  case
  when x.concurrent_program_name is not null then (
  select
  fcpt.user_concurrent_program_name
  from
  fnd_application fa,
  fnd_concurrent_programs fcp,
  fnd_concurrent_programs_tl fcpt
  where
  x.conc_application_short_name=fa.application_short_name and
  x.concurrent_program_name=fcp.concurrent_program_name and
  fa.application_id=fcp.application_id and
  fcp.application_id=fcpt.application_id and
  fcp.concurrent_program_id=fcpt.concurrent_program_id and
  fcpt.language=p_userenv_lang
  )
  when x.concurrent_queue_name is not null then (
  select
  fcqt.user_concurrent_queue_name
  from
  fnd_application fa,
  fnd_concurrent_queues_tl fcqt
  where
  x.queue_application_short_name=fa.application_short_name and
  decode(x.concurrent_queue_name,'30','FNDICM',x.concurrent_queue_name)=fcqt.concurrent_queue_name and
  fa.application_id=fcqt.application_id and
  fcqt.language=p_userenv_lang
  )
  when x.form_name is not null then nvl((
  select
  fft.user_form_name
  from
  fnd_form ff,
  fnd_form_tl fft
  where
  x.form_name=ff.form_name and
  ff.form_id=fft.form_id and
  fft.language=p_userenv_lang and
  rownum=1
  ),x.form_name)
  when x.wf_item_type is not null then (select witt.display_name from wf_item_types_tl witt where x.wf_item_type=witt.name and witt.language=p_userenv_lang)
  when x.wf_event_name is not null then coalesce(
  (select we.name from wf_events we where x.wf_event_name=we.name),
  (select we.name from wf_events we where we.name like x.wf_event_name||'%' and rownum=1),
  x.wf_event_name
  )
  else
  coalesce(x.blitz_report,x.discoverer_user)
  end apps_module
  from
  (
  select
  case when regexp_like(p_module,'^e:\w+:cp:\w+/\w+$') then upper(regexp_substr(p_module,'^e:\w+:cp:(\w+)/\w+$',1,1,null,1)) end conc_application_short_name,
  case when regexp_like(p_module,'^e:\w+:cp:\w+/\w+$') then regexp_substr(p_module,'^e:\w+:cp:\w+/(\w+)$',1,1,null,1) end concurrent_program_name,
  case when regexp_like(p_module,'^e:\w*:(cp|gsm|GSM):\w+$') then nvl(upper(regexp_substr(p_module,'^e:(\w*):cp:\w+$',1,1,null,1)),'FND') end queue_application_short_name,
  case when regexp_like(p_module,'^e:\w*:(cp|gsm|GSM):\w+$') then regexp_substr(p_module,'^e:\w*:(cp|gsm|GSM):(\w+)$',1,1,null,2) end concurrent_queue_name,
  case when regexp_like(p_module,'^e:\w+:frm:\w+$') then regexp_substr(p_module,'^e:\w+:frm:(\w+$)',1,1,null,1) end form_name,
  case when regexp_like(p_module,'^e:\w+:wf:\w+$') then regexp_substr(p_module,'^e:\w+:wf:(\w+)$',1,1,null,1) end wf_item_type,
  case when regexp_like(p_module,'^e:\w*:bes:.+$') then regexp_substr(p_module,'^e:\w*:bes:(.+)$',1,1,null,1) end wf_event_name,
  case when p_module like 'XXEN_REPORT - %' then substr(p_module,15) end blitz_report,
  case when p_module like 'Disco%, %' then regexp_substr(p_module,'Disco\d+, ([^:]+)',1,1,null,1) end discoverer_user
  from
  dual
  ) x
  ) loop
    l_apps_module:=c.apps_module;
  end loop;
  if l_apps_module is null then
    l_module:=regexp_replace(p_module,'(.*)@(.*)(\(.*\))','\1');
    for c in (
    select
    fcpt.user_concurrent_program_name
    from
    fnd_concurrent_programs fcp,
    fnd_concurrent_programs_tl fcpt
    where
    fcp.concurrent_program_name=l_module and
    fcp.application_id=fcpt.application_id and
    fcp.concurrent_program_id=fcpt.concurrent_program_id and
    fcpt.language=p_userenv_lang and
    rownum=1
    ) loop
      l_apps_module:=c.user_concurrent_program_name;
    end loop;
  end if;
  if l_apps_module is null then
    for c in (
    select
    fcqt.user_concurrent_queue_name
    from
    fnd_concurrent_queues_tl fcqt
    where
    decode(l_module,'30','FNDICM',l_module)=fcqt.concurrent_queue_name and
    fcqt.language=p_userenv_lang and
    rownum=1
    ) loop
      l_apps_module:=c.user_concurrent_queue_name;
    end loop;
  end if;
  return coalesce(l_apps_module,l_module,regexp_replace(substr(p_program,instr(p_program,'(')),'\d','n'));
end module_name;

begin
  return module_name(p_module, userenv('lang'), p_program);
end module_name;


function responsibility(p_module in varchar2, p_action in varchar2) return varchar2 is

function responsibility(p_action in varchar2, p_userenv_lang in varchar2) return varchar2 result_cache is
l_responsibility fnd_responsibility_tl.responsibility_name%type;
l_action sys.v_$session.action%type:=substr(p_action,instr(p_action,'|')+1);
l_application_short_name sys.v_$session.action%type:=substr(l_action,1,instr(l_action,'/')-1);
l_responsibility_key sys.v_$session.action%type:=substr(l_action,instr(l_action,'/')+1);
begin
  if p_action like '%_/_%' then
    for c in (
    select
    frt.responsibility_name
    from
    fnd_application fa,
    fnd_responsibility fr,
    fnd_responsibility_tl frt
    where
    fr.responsibility_key=l_responsibility_key and
    fa.application_short_name=l_application_short_name and
    fa.application_id=fr.application_id and
    fr.application_id=frt.application_id and
    fr.responsibility_id=frt.responsibility_id and
    frt.language=p_userenv_lang
    ) loop
      l_responsibility:=c.responsibility_name;
    end loop;
    if l_responsibility is null then --older EBS versions were cutting the session action tagging in fnd_global.tag_db_session at 32char
      for c in (
      select
      frt.responsibility_name
      from
      fnd_application fa,
      fnd_responsibility fr,
      fnd_responsibility_tl frt
      where
      fr.responsibility_key like l_responsibility_key||'%' and
      fa.application_short_name=l_application_short_name and
      fa.application_id=fr.application_id and
      fr.application_id=frt.application_id and
      fr.responsibility_id=frt.responsibility_id and
      frt.language=p_userenv_lang
      ) loop
        l_responsibility:=c.responsibility_name;
      end loop;
    end if;
  end if;
  return l_responsibility;
end responsibility;

begin
  return case when p_module like 'Disco%, %:%' then substr(p_module,instr(p_module,':')+1) else responsibility(p_action, userenv('lang')) end;
end responsibility;


function user_name(p_user_name in varchar2) return varchar2 is

function user_name(p_user_name in varchar2, p_sysdate in date) return varchar2 result_cache is
l_user_name varchar2(342);
begin
  for c in (
  select
  x.user_name||nvl2(x.description,' ('||x.description||')',null) user_name
  from
  (
  select
  fu.user_name,
  coalesce(
  trim(papf.first_name||' '||papf.last_name),
  fu.description,
  fu.email_address,
  papf.email_address
  ) description
  from
  fnd_user fu,
  (select papf.* from per_all_people_f papf where p_sysdate between papf.effective_start_date and papf.effective_end_date) papf
  where
  fu.user_name=p_user_name and
  fu.employee_id=papf.person_id(+)
  ) x
  ) loop
    l_user_name:=c.user_name;
  end loop;
  return l_user_name;
end user_name;

begin
  return user_name(p_user_name, trunc(sysdate));
end user_name;


function user_name(p_user_id in pls_integer) return varchar2 is

function user_name(p_user_id in pls_integer, p_sysdate in date) return varchar2 result_cache is
l_user_name varchar2(342);
begin
  for c in (
  select
  x.user_name||nvl2(x.description,' ('||x.description||')',null) user_name
  from
  (
  select
  fu.user_name,
  coalesce(
  trim(papf.first_name||' '||papf.last_name),
  fu.description,
  fu.email_address,
  papf.email_address
  ) description
  from
  fnd_user fu,
  (select papf.* from per_all_people_f papf where p_sysdate between papf.effective_start_date and papf.effective_end_date) papf
  where
  fu.user_id=p_user_id and
  fu.employee_id=papf.person_id(+)
  ) x
  ) loop
    l_user_name:=c.user_name;
  end loop;
  return l_user_name;
end user_name;

begin
  return user_name(p_user_id, trunc(sysdate));
end user_name;


function user_id(p_user_name in varchar2) return pls_integer result_cache is
l_user_id pls_integer;
begin
  for c in (select fu.user_id from fnd_user fu where fu.user_name=p_user_name) loop
    l_user_id:=c.user_id;
  end loop;
  return l_user_id;
end user_id;


function user_name(p_module in varchar2, p_action in varchar2, p_client_id in varchar2) return varchar2 result_cache is
l_user_name varchar2(342);
begin
  l_user_name:=user_name(p_client_id);
  if
  l_user_name is null and
  trim(translate(p_client_id,' 0123456789',' ')) is null and
  (p_action='Concurrent Request' or regexp_like(p_module,'^e:\w*:bes:.+$'))
  then
    for c in (
    select
    xxen_util.user_name(fcr.requested_by) user_name
    from
    fnd_concurrent_requests fcr
    where
    fcr.request_id=p_client_id
    ) loop
      l_user_name:=c.user_name;
    end loop;
  end if;
  return l_user_name;
end user_name;


function is_xml(p_clob in clob) return varchar2 is
l_dummy xmltype;
begin
   l_dummy:=xmltype(p_clob);
   return 'Y';
exception
  when others then
    return dbms_utility.format_error_stack||dbms_utility.format_error_backtrace;
end is_xml;

function ap_invoice_status(
p_invoice_id in number,
p_invoice_amount in number,
p_payment_status_flag in varchar2,
p_invoice_type_lookup_code in varchar2,
p_validation_request_id in number
) return varchar2 is
l_approval_status varchar2(30):=ap_invoices_utility_pkg.get_approval_status(p_invoice_id,p_invoice_amount,p_payment_status_flag,p_invoice_type_lookup_code);
begin
  --from APXINWKB -> inv_sum_folder_item_overflow.approval_status_display
  if l_approval_status in ('APPROVED','UNPAID') then
    for c in (select null from ap_payment_schedules_all apsa where apsa.invoice_id=p_invoice_id and apsa.checkrun_id is not null and rownum=1) loop
      l_approval_status:='SELECTED_FOR_PAYMENT';
    end loop;
  end if;
  if p_validation_request_id is not null then
    l_approval_status:='SELECTED_FOR_VALIDATION';
    for c in (
    select
    null
    from
    fnd_concurrent_requests fcr,
    fnd_concurrent_programs fcp
    where
    fcr.request_id=p_validation_request_id and
    fcr.concurrent_program_id=fcp.concurrent_program_id and
    fcp.application_id=200 and
    fcp.concurrent_program_name='APXIAWRE'
    ) loop
      l_approval_status:='SELECTED_FOR_APPROVAL';
    end loop;
  end if;
  return xxen_util.meaning(translate(l_approval_status,'_',' '),
  case when l_approval_status in ('AVAILABLE','FULL','UNAPPROVED','UNPAID','PERMANENT') then 'PREPAY STATUS' else 'NLS TRANSLATION' end,200);
end ap_invoice_status;


function ap_invoice_status(p_invoice_id in number) return varchar2 is
l_status varchar2(100);
begin
  for c in (
  select
  aia.invoice_amount,
  aia.payment_status_flag,
  aia.invoice_type_lookup_code,
  aia.validation_request_id
  from
  ap_invoices_all aia
  where
  aia.invoice_id=p_invoice_id
  ) loop
    l_status:=xxen_util.ap_invoice_status(p_invoice_id,c.invoice_amount,c.payment_status_flag,c.invoice_type_lookup_code,c.validation_request_id);
  end loop;
  return l_status;
end ap_invoice_status;


function convert_time(p_date in date, p_server_to_client in boolean) return date is
l_client_timezone_code varchar2(50);
l_server_timezone_code varchar2(50);

function client_timezone_code(p_client_timezone_id in number) return varchar2 result_cache is
l_timezone_code varchar2(50);
begin
  for c in (select ftb.timezone_code from fnd_timezones_b ftb where ftb.upgrade_tz_id=p_client_timezone_id) loop
    l_timezone_code:=c.timezone_code;
  end loop;
  return l_timezone_code;
end client_timezone_code;

function server_timezone_code(p_server_timezone_id in number) return varchar2 result_cache is
l_timezone_code varchar2(50);
begin
  for c in (select ftb.timezone_code from fnd_timezones_b ftb where ftb.upgrade_tz_id=p_server_timezone_id) loop
    l_timezone_code:=c.timezone_code;
  end loop;
  return l_timezone_code;
end server_timezone_code;

function enable_timezone_conversion return boolean result_cache is
begin
  if fnd_profile.value('ENABLE_TIMEZONE_CONVERSIONS')='Y' then
    return true;
  else
    return false;
  end if;
end enable_timezone_conversion;

begin
  l_client_timezone_code:=client_timezone_code(fnd_profile.value('CLIENT_TIMEZONE_ID'));
  l_server_timezone_code:=server_timezone_code(fnd_profile.value('SERVER_TIMEZONE_ID'));
  if l_client_timezone_code<>l_server_timezone_code and enable_timezone_conversion then
    if p_server_to_client then
      return fnd_timezones_pvt.adjust_datetime(p_date, l_server_timezone_code, l_client_timezone_code);
    else
      return fnd_timezones_pvt.adjust_datetime(p_date, l_client_timezone_code, l_server_timezone_code);
    end if;
  else
    return p_date;
  end if;
end convert_time;


function client_time(p_date in date) return date is
begin
  return convert_time(p_date, true);
end client_time;


function server_time(p_date in date) return date is
begin
  return convert_time(p_date, false);
end server_time;


function application_name(p_application_short_name in varchar2) return varchar2 result_cache is
l_application_name varchar2(240);
begin
  for c in (select fav.application_name from fnd_application_vl fav where fav.application_short_name=decode(p_application_short_name,'AP','SQLAP','GL','SQLGL','FA','OFA',p_application_short_name)) loop
    l_application_name:=c.application_name;
  end loop;
  return nvl(l_application_name,xxen_util.meaning(upper(p_application_short_name),'XXEN_REPORT_APPLICATIONS',0));
end application_name;


function application_short_name_trans(p_application_short_name in varchar2) return varchar2 is
begin
  return case p_application_short_name when 'DUMMY' then null when 'SQLAP' then 'AP' when 'SQLGL' then 'GL' when 'OFA' then 'FA' else p_application_short_name end;
end application_short_name_trans;


function application_short_name(p_application_name in varchar2) return varchar2 result_cache is
l_application_short_name varchar2(50);
begin
  for c in (select fav.application_short_name from fnd_application_vl fav where fav.application_name=p_application_name) loop
    l_application_short_name:=c.application_short_name;
  end loop;
  return case when p_application_name='Blitz Report' then 'Blitz' else nvl(application_short_name_trans(l_application_short_name),xxen_util.lookup_code(p_application_name,'XXEN_REPORT_APPLICATIONS',0)) end;
end application_short_name;


function dis_eul_usage_count(p_eul in varchar2) return number is
l_count number;
begin
  execute immediate '
  select
  count(*) count
  from
  v$database vd,
  '||p_eul||'.eul5_qpp_stats eqs
  where
  eqs.qs_created_date>=case when vd.created>sysdate-500 then vd.created else sysdate end-nvl(fnd_profile.value(''XXEN_REPORT_DISCOVERER_IMPORT_LOV_ACCESS_HISTORY_DAYS''),90)
  ' into l_count;
  return l_count;
end dis_eul_usage_count;


function dis_default_eul return varchar2 is
l_default_eul varchar2(30):=fnd_profile.value('XXEN_REPORT_DISCOVERER_DEFAULT_EUL');
begin
  if l_default_eul is null then
    for c in (
    select distinct
    max(lower(ao.owner)) keep (dense_rank last order by xxen_util.dis_eul_usage_count(ao.owner),ao.created) over () default_eul
    from
    all_objects ao
    where
    ao.object_type='TABLE' and
    ao.object_name='EUL5_QPP_STATS'
    ) loop
      l_default_eul:=c.default_eul;
    end loop;
  end if;
  return l_default_eul;
end dis_default_eul;


function dis_user(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache is
l_username varchar2(64);
begin
  execute immediate 'select eeu.eu_username from '||p_eul||'.eul5_eul_users eeu where eeu.eu_id=:p_user_id' into l_username using p_user_id;
  return l_username;
exception
  when no_data_found then
    return null;
end dis_user;


function dis_user_name(p_username in varchar2) return varchar2 is

function dis_user_name_(p_username in varchar2, p_userenv_lang in varchar2) return varchar2 result_cache is
l_user_name varchar2(342):=p_username;
begin
  if p_username like '#%#%' then
    for c in (
    select
    frt.responsibility_name
    from
    fnd_responsibility_tl frt
    where
    frt.application_id=substr(p_username,instr(p_username,'#',1,2)+1) and
    frt.responsibility_id=substr(p_username,2,instr(p_username,'#',1,2)-2) and
    frt.language=p_userenv_lang
    ) loop
      l_user_name:=c.responsibility_name;
    end loop;
  elsif p_username like '#%' then
    l_user_name:=user_name(to_number(substr(p_username,2)));
  end if;
  return l_user_name;
end dis_user_name_;

begin
  return dis_user_name_(p_username, userenv('lang'));
end dis_user_name;


function dis_user_name(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache is
begin
  return dis_user_name(dis_user(p_user_id, p_eul));
end dis_user_name;


function dis_user_type(p_username in varchar2) return varchar2 result_cache is
begin
  return case
  when p_username like '#%#%' then 'Responsibility'
  when p_username like '#%' then 'User'
  else 'Database'
  end;
end dis_user_type;


function dis_user_type(p_user_id in number, p_eul in varchar2 default 'eul_us') return varchar2 result_cache is
begin
  return dis_user_type(dis_user(p_user_id, p_eul));
end dis_user_type;


function dis_folder_sql(p_object_id in number, p_eul in varchar2 default 'eul_us') return clob is
l_sql_chunk varchar2(32767);
l_sql_text clob;
type cur_type is ref cursor;
l_cur cur_type;
begin
  open l_cur for 'select to_clob(eo.obj_object_sql1)||to_clob(eo.obj_object_sql2)||to_clob(eo.obj_object_sql3) sql_text from '||p_eul||'.eul5_objs eo where eo.obj_id=:p_object_id and eo.obj_object_sql1 is not null' using p_object_id;
  loop
    fetch l_cur into l_sql_text;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  if l_sql_text is null then
    open l_cur for '
    select
    es.seg_chunk1||es.seg_chunk2||es.seg_chunk3||es.seg_chunk4 sql_text
    from
    '||p_eul||'.eul5_segments es
    where
    es.seg_obj_id=:p_object_id and
    es.seg_seg_type=1 and
    es.seg_chunk1 is not null
    order by
    es.seg_sequence
    ' using p_object_id;
    loop
      fetch l_cur into l_sql_chunk;
      exit when l_cur%notfound;
      l_sql_text:=l_sql_text||l_sql_chunk;
    end loop;
    close l_cur;
  end if;
  return replace(l_sql_text,chr(13)||chr(10),chr(10));
end dis_folder_sql;


function dis_folder_sql2(p_object_id in number, p_eul in varchar2 default 'eul_us') return clob is
l_sql_text clob:=dis_folder_sql(p_object_id, p_eul);
begin
  l_sql_text:=regexp_replace(l_sql_text,'^\( SELECT .+? FROM ','SELECT * FROM ',1,1);
  l_sql_text:=trim(substr(l_sql_text,1,length(l_sql_text)-1));
  if l_sql_text like 'SELECT * FROM (%) CUO'||p_object_id then
    l_sql_text:=regexp_substr(l_sql_text,'^SELECT \* FROM \((.+)\) CUO'||p_object_id||'$',1,1,'n',1);
  end if;
  return l_sql_text;
end dis_folder_sql2;


function dis_worksheet_sql(p_workbook_owner_name in varchar2, p_workbook_name in varchar2, p_worksheet_name in varchar2) return clob is
l_sql_text clob;
begin
  for c in (
  select
  ads.sql_string
  from
  ams_discoverer_sql ads
  where
  ads.workbook_owner_name=p_workbook_owner_name and
  ads.workbook_name=p_workbook_name and
  ads.worksheet_name=p_worksheet_name
  order by
  ads.sequence_order
  ) loop
    l_sql_text:=l_sql_text||c.sql_string;
  end loop;
  return replace(l_sql_text,chr(13)||chr(10),chr(10));
end dis_worksheet_sql;


function dis_formula(p_formula in varchar2, p_eul in varchar2 default 'eul_us') return varchar2 is
l_formula varchar2(4000):=p_formula;
type cur_type is ref cursor;
l_cur cur_type;
l_param varchar2(100);
l_text varchar2(250);
begin
  if p_formula like '%[%]%' then
    open l_cur for '
    select
    z.param,
    z.text
    from
    (
    select
    y.*,
    case
    when y.param1=1 then (select ef.fun_ext_name from '||p_eul||'.eul5_functions ef where y.param2=ef.fun_id)
    when y.param1 in (6,7) then (select ee.exp_name from '||p_eul||'.eul5_expressions ee where y.param2=ee.exp_id)
    when y.param1=5 and y.param2=1 then ''''''''||replace(substr(y.param3,2,length(y.param3)-2),''""'',''"'')||''''''''
    when y.param1=5 and y.param2=2 then trim(''"'' from y.param3)
    when y.param1=5 and y.param2=4 then ''to_date(''''''||to_char(to_date(substr(y.param3,2,instr(y.param3,''"'',2)-2),''YYYYMMDDHH24MISS''),''DD-MON-RRRR'')||'''''',''''DD-MON-RRRR'''')''
    end text
    from
    (
    select
    substr(x.param,1,instr(x.param,'','')-1) param1,
    regexp_substr(x.param,''[^,]+'',1,2) param2,
    substr(x.param,instr(x.param,'','',1,2)+1) param3,
    x.*
    from
    (
    select
    regexp_substr(:p_formula,''\[(.+?)\]'',1,level,null,1) param
    from dual connect by level<=regexp_count(:p_formula,''\[.+?\]'')
    ) x
    ) y
    ) z
    where
    z.text is not null
    ' using p_formula, p_formula;
    loop
      fetch l_cur into l_param,l_text;
      exit when l_cur%notfound;
      l_formula:=replace(l_formula,'['||l_param||']',l_text);
    end loop;
    close l_cur;
  end if;
  return l_formula;
end dis_formula;


function dis_worksheet_exists(p_eul_name varchar2) return varchar2 is
l_result varchar2(1);
type cur_type is ref cursor;
c_cur cur_type;
begin
  open c_cur for '
  select
  ''Y''
  from
  ams_discoverer_sql ads,
  '||p_eul_name||'.eul5_documents ed
  where
  ads.workbook_name=ed.doc_name and
  rownum=1';
  loop
    fetch c_cur into l_result;
    exit when c_cur%notfound;
  end loop;
  close c_cur;
  return l_result;
exception
  when others then
    close c_cur;
    return null;
end dis_worksheet_exists;


function compile_designator(p_org_id in pls_integer) return varchar2 is

function compile_designator(p_org_id in pls_integer, p_mrp_default_plan in varchar2, p_sysdate in date) return varchar2 result_cache is
l_plan varchar2(10);
begin
  for c in (
  select distinct
  min(mpsv.compile_designator) keep (dense_rank first order by decode(mpsv.compile_designator,p_mrp_default_plan,1,2)) over (partition by mpsv.planned_organization) compile_designator
  from
  mrp_plans_sc_v mpsv
  where
  mpsv.data_completion_date is not null and
  mpsv.planned_organization=p_org_id and
  nvl(mpsv.plan_type,mpsv.curr_plan_type)=1 and
  nvl(mpsv.disable_date,p_sysdate)>=p_sysdate
  ) loop
    l_plan:=c.compile_designator;
  end loop;
  return l_plan;
end compile_designator;
begin
  return compile_designator(p_org_id,fnd_profile.value('MRP_DEFAULT_PLAN'),trunc(sysdate));
end compile_designator;


function calendar_date_offset(p_date in date, p_calendar_code in varchar2, p_offset_days in number default 0, p_calendar_exception_set_id in number default -1) return date is
l_date date;
begin
  if p_offset_days>=0 then
    for c in (
    select
    bcd1.calendar_date
    from
    bom_calendar_dates bcd0,
    bom_calendar_dates bcd1
    where
    bcd0.calendar_date=trunc(p_date) and
    nvl(bcd0.seq_num,bcd0.next_seq_num)+ceil(p_offset_days)=bcd1.seq_num and
    bcd0.calendar_code=p_calendar_code and
    bcd1.calendar_code=p_calendar_code and
    bcd0.exception_set_id=p_calendar_exception_set_id and
    bcd1.exception_set_id=p_calendar_exception_set_id
    ) loop
      l_date:=c.calendar_date;
    end loop;
  elsif p_offset_days<0 then
    for c in (
    select
    bcd1.calendar_date
    from
    bom_calendar_dates bcd0,
    bom_calendar_dates bcd1
    where
    bcd0.calendar_date=trunc(p_date) and
    nvl(bcd0.seq_num,bcd0.prior_seq_num)+floor(p_offset_days)=bcd1.seq_num and
    bcd0.calendar_code=p_calendar_code and
    bcd1.calendar_code=p_calendar_code and
    bcd0.exception_set_id=p_calendar_exception_set_id and
    bcd1.exception_set_id=p_calendar_exception_set_id
    ) loop
      l_date:=c.calendar_date;
    end loop;
  end if;
  return l_date;
end calendar_date_offset;


function sequence_nextval(p_sequence_name in varchar2) return number is
l_value number;
begin
  execute immediate 'begin :l_value:='||p_sequence_name||'.nextval; end;' using out l_value;
  return l_value;
end sequence_nextval;


function bcp47_language(p_language_code in varchar2) return varchar result_cache is
begin
  if    p_language_code='ESM' then return 'es-MX';
  elsif p_language_code='FRC' then return 'fr-CA';
  elsif p_language_code='GB' then return 'en-GB';
  elsif p_language_code='PTB' then return 'pt-BR';
  elsif p_language_code='ZHS' then return 'zh-Hans';
  elsif p_language_code='ZHT' then return 'zh-Hant';
  end if;
  for c in (select lower(fl.iso_language) bcp47_language from fnd_languages fl where fl.language_code=p_language_code) loop
    return c.bcp47_language;
  end loop;
end bcp47_language;


end xxen_util;
/

