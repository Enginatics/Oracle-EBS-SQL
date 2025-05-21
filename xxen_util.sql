create or replace package apps.xxen_util is

/***********************************************************************************************/
/*                                                                                             */
/*       Blitz Report utility package with reusable functions for Oracle EBS.                  */
/*       While the Blitz Report software is licensed as detailed on our webpage                */
/*       www.enginatics.com this utility package is free for use, regardless if                */
/*       you are a Blitz Report customer or not.                                               */
/*                                                                                             */
/*                          (c) 2010-2021 Enginatics GmbH                                      */
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
/* ISO language code for the current nls language                                              */
/***********************************************************************************************/
function nls_language_iso_code return varchar2;

/***********************************************************************************************/
/*  trunc(sysdate), which can be used in SQLs that require result caching                      */
/***********************************************************************************************/
function trunc_sysdate return date;

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
function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_meaning_if_null in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  escape regexp metacharacters with a backslash e.g. ( to \(                                 */
/***********************************************************************************************/
function regexp_escape(p_text in varchar2) return varchar2;

/***********************************************************************************************/
/*  used in LOVs to compare column values with parameter values they depend on                 */
/***********************************************************************************************/
function contains(p_parameter_value in varchar2, p_column_value in varchar2) return varchar2;

/***********************************************************************************************/
/*  used to translate GL segments, such as PROJECT to Project to avoid diplicate SQL columns   */
/***********************************************************************************************/
function init_cap(p_text in varchar2) return varchar2;

/***********************************************************************************************/
/*  translate a fnd profile option value into the user visible profile option value            */
/***********************************************************************************************/
function display_profile_option_value(
p_application_id in number,
p_profile_option_id in number,
p_profile_option_value in varchar2
) return varchar2;

/***********************************************************************************************/
/*  translate a descriptive flexfield context code into the user visible context name          */
/***********************************************************************************************/
function display_flexfield_context(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2
) return varchar2;

/***********************************************************************************************/
/*  translate a descriptive flexfield value into the user visible value                        */
/***********************************************************************************************/
function display_flexfield_value(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_column_name in varchar2,
p_rowid in rowid default null,
p_value in varchar2 default chr(0),
p_business_group_id in number default null,
p_organization_id in number default null,
p_org_information_id in number default null,
p_concatenate_description in varchar2 default null
) return varchar2;

/***********************************************************************************************/
/*  pipelined lov function for descriptive flexfield attributes                                */
/***********************************************************************************************/
function dff_attribute_lov(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_name in varchar2,
p_column_name in varchar2,
p_lov_delimter in varchar2 default '~',
p_attribute1 in varchar2 default null,
p_attribute2 in varchar2 default null,
p_attribute3 in varchar2 default null,
p_attribute4 in varchar2 default null,
p_attribute5 in varchar2 default null,
p_attribute6 in varchar2 default null,
p_attribute7 in varchar2 default null,
p_attribute8 in varchar2 default null,
p_attribute9 in varchar2 default null,
p_attribute10 in varchar2 default null,
p_attribute11 in varchar2 default null,
p_attribute12 in varchar2 default null,
p_attribute13 in varchar2 default null,
p_attribute14 in varchar2 default null,
p_attribute15 in varchar2 default null,
p_attribute16 in varchar2 default null,
p_attribute17 in varchar2 default null,
p_attribute18 in varchar2 default null,
p_attribute19 in varchar2 default null,
p_attribute20 in varchar2 default null,
p_attribute21 in varchar2 default null,
p_attribute22 in varchar2 default null,
p_attribute23 in varchar2 default null,
p_attribute24 in varchar2 default null,
p_attribute25 in varchar2 default null,
p_attribute26 in varchar2 default null,
p_attribute27 in varchar2 default null,
p_attribute28 in varchar2 default null,
p_attribute29 in varchar2 default null,
p_attribute30 in varchar2 default null
) return fnd_table_of_varchar2_4000 pipelined;

/***********************************************************************************************/
/*  concatenated segments for a given gl code combination                                      */
/***********************************************************************************************/
function concatenated_segments(p_code_combination_id in number) return varchar2 result_cache;

/***********************************************************************************************/
/*  single gl account or other key flexfield segment description for a given segment value     */
/***********************************************************************************************/
function segment_description(
p_segment_value in varchar2,
p_column_name in varchar2,
p_id_flex_num in pls_integer,
p_parent_segment_value in varchar2 default null,
p_application_id in pls_integer default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2;

/***********************************************************************************************/
/*  Concatenated key flexfield segment value description for a given id, for example           */
/*  gl code combination. Provide the chart of accounts id for better performance               */
/***********************************************************************************************/
function segments_description(
p_id in number,
p_id_flex_num in pls_integer,
p_application_id in pls_integer default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2;

/***********************************************************************************************/
/*  overloeaded (slower) segment value description function, without chart of accounts id      */
/***********************************************************************************************/
function segments_description(p_code_combination_id in number) return varchar2;

/***********************************************************************************************/
/*  reverse the element order of a delimited text e.g. a path /gordon/supervisor/project to    */
/*  /project/supervisor/gordon. this is useful e.g. for connect by sqls to show                */
/*  sys connect by path in reverse order without changing the starting point of the query      */
/***********************************************************************************************/
function reverse(p_text in varchar2, p_delimiter in varchar2) return varchar2;

/***********************************************************************************************/
/*  convert clob to blob                                                                       */
/***********************************************************************************************/
function clob_to_blob(p_clob in clob, p_charset_id in number default null) return blob;

/***********************************************************************************************/
/*  convert blob to clob                                                                       */
/*  useful for example to extract text content from xml files stored in the db such as the     */
/*  dataquery sql statement from xml publisher data templates                                  */
/***********************************************************************************************/
function blob_to_clob(p_blob in blob, p_charset_id in number default null) return clob;

/***********************************************************************************************/
/*  convert long datatype to clob                                                              */
/***********************************************************************************************/
function long_to_clob(p_table_name in varchar2, p_column_name in varchar2, p_row_id in rowid) return clob;

/***********************************************************************************************/
/*  convert blob to base64                                                                     */
/***********************************************************************************************/
function blob_to_base64(p_blob in blob) return clob;

/***********************************************************************************************/
/*  convert base64 to blob                                                                     */
/***********************************************************************************************/
function base64_to_blob(p_clob in clob) return blob;

/***********************************************************************************************/
/*  lengthb for clobs see oracle note 790886.1                                                 */
/***********************************************************************************************/
function clob_lengthb(p_clob in clob) return number;

/***********************************************************************************************/
/*  substrb for clobs up to 32767 characters, see oracle note 1571041.1                        */
/***********************************************************************************************/
function clob_substrb(p_clob in clob, p_byte_length in pls_integer, p_char_position in pls_integer default 1) return clob;

/***********************************************************************************************/
/*  replaces first occurrence of substring in a string                                         */
/***********************************************************************************************/
function replace_first_occurrence(p_source in clob, p_search in clob, p_replacement in clob) return clob;

/***********************************************************************************************/
/*  replaces all occurrences of clob in a clob                                                 */
/***********************************************************************************************/
function clob_replace(p_source in clob, p_search in clob, p_replacement in clob) return clob;

/***********************************************************************************************/
/*  instring for long multiple values as regexp_substr on clobs is too slow, especially on 19c */
/***********************************************************************************************/
function instring(p_text in clob, p_separator in varchar2, p_occurrence in pls_integer) return varchar2;

/***********************************************************************************************/
/*  generate x number of rows for use in sql e.g. for regexp: table(xxen_util.rowgen(n)) rowgen*/
/***********************************************************************************************/
function rowgen(p_rows in number) return fnd_table_of_number deterministic;

/***********************************************************************************************/
/*  classification of data_type ids in varchar2, number, date, clob                            */
/***********************************************************************************************/
function data_type_class(p_data_type in pls_integer) return varchar2;

/***********************************************************************************************/
/*  parse and return sql column names for use in sql e.g.                                      */
/*  select x.* from table(xxen_util.sql_columns('select * from hz_parties')) x                 */
/***********************************************************************************************/
function sql_columns(p_sql in clob, p_skip_binding in varchar2 default null) return xxen_sql_desc_tab;

/***********************************************************************************************/
/*  removes empty lines from sql queries                                                       */
/***********************************************************************************************/
function remove_empty_lines(p_clob in clob) return clob;

/***********************************************************************************************/
/*  Converts html formatted text to plain text                                                 */
/***********************************************************************************************/
function html_to_text(p_html in clob, p_remove_empty_lines in varchar2 default null) return clob;

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
function module_type(p_module in varchar2, p_action in varchar2 default null) return varchar2 result_cache;

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
/*  translates an fnd user_name e.g. CLAUDIA to a user_name including description              */
/*  e.g. CLAUDIA (Claudia Renner)                                                              */
/***********************************************************************************************/
function user_name(p_user_name in varchar2) return varchar2;

/***********************************************************************************************/
/*  returns user_name including description for an fnd user_id                                 */
/***********************************************************************************************/
function user_name(p_user_id in pls_integer, p_show_description in varchar2 default null) return varchar2;

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
/*  ap invoice status (fast)                                                                   */
/***********************************************************************************************/
function ap_invoice_status(
p_invoice_id in number,
p_invoice_amount in number,
p_payment_status_flag in varchar2,
p_invoice_type_lookup_code in varchar2,
p_validation_request_id in number
) return varchar2;

/***********************************************************************************************/
/*  ap invoice status (slow)                                                                   */
/***********************************************************************************************/
function ap_invoice_status(p_invoice_id in number) return varchar2;

/***********************************************************************************************/
/*  wsh delivery details next step from the shipping transactions form (fast)                  */
/***********************************************************************************************/
function wsh_next_step(
p_container_flag in wsh_delivery_details.container_flag%type,
p_released_status in wsh_delivery_details.released_status%type,
p_source_code in wsh_delivery_details.source_code%type,
p_inv_interfaced_flag in wsh_delivery_details.inv_interfaced_flag%type,
p_oe_interfaced_flag in wsh_delivery_details.oe_interfaced_flag%type,
p_client_id in number,
p_replenishment_status in varchar2,
p_move_order_line_id in wsh_delivery_details.move_order_line_id%type
) return varchar2;

/***********************************************************************************************/
/*  wsh delivery details next step from the shipping transactions form (slow)                  */
/***********************************************************************************************/
function wsh_next_step(p_delivery_detail_id in number) return varchar2;

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
/*  discoverer business areas for a given folder object_id                                     */
/***********************************************************************************************/
function dis_business_area(p_obj_id in number, p_eul in varchar2) return varchar2;

/***********************************************************************************************/
/*  discoverer display folder type                                                             */
/***********************************************************************************************/
function dis_folder_type(p_obj_type in varchar2) return varchar2 deterministic;

/***********************************************************************************************/
/*  discoverer display item type                                                               */
/***********************************************************************************************/
function dis_item_type(p_exp_type in varchar2) return varchar2 deterministic;

/***********************************************************************************************/
/*  discoverer default end user layer (with most frequent executions in eul5_qpp_stats)        */
/***********************************************************************************************/
function dis_default_eul return varchar2;

/***********************************************************************************************/
/*  discoverer user_id to discoverer username                                                  */
/***********************************************************************************************/
function dis_user(p_user_id in number, p_eul in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer username to application user name or responsibility                             */
/***********************************************************************************************/
function dis_user_name(p_username in varchar2, p_show_description in varchar2 default null, p_eul in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  discoverer user_id to application user name or responsibility                              */
/***********************************************************************************************/
function dis_user_name(p_user_id in number, p_eul in varchar2, p_show_description in varchar2 default null) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer username to user type                                                           */
/***********************************************************************************************/
function dis_user_type(p_username in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer user_id to user type                                                            */
/***********************************************************************************************/
function dis_user_type(p_user_id in number, p_eul in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object                                                    */
/***********************************************************************************************/
function dis_folder_sql(p_object_id in number, p_eul in varchar2) return clob;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object                                                    */
/***********************************************************************************************/
function dis_folder_sql2(p_object_id in number, p_eul in varchar2) return clob;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object, simplified, e.g. columns replaced by asterisk *   */
/***********************************************************************************************/
function dis_folder_sql3(p_object_id in number, p_eul in varchar2) return clob;

/***********************************************************************************************/
/*  discoverer SQL text for a custom object and column to create Blitz Report LOVs             */
/***********************************************************************************************/
function dis_lov_query(p_exp_id in pls_integer, p_eul in varchar2) return clob;

/***********************************************************************************************/
/*  discoverer worksheet SQL text from logging table ams_discoverer_sql                        */
/***********************************************************************************************/
function dis_worksheet_sql(p_workbook_owner_name in varchar2, p_workbook_name in varchar2, p_worksheet_name in varchar2) return clob;

/***********************************************************************************************/
/*  checks if discoverer EUL contains any data in ams_discoverer_sql to be imported            */
/***********************************************************************************************/
function dis_worksheet_exists(p_eul in varchar2) return varchar2;

/***********************************************************************************************/
/*  checks if discoverer EUL contains any data in eul5_qpp_stats to be imported as folders     */
/***********************************************************************************************/
function dis_folder_exists(p_eul in varchar2) return varchar2;

/***********************************************************************************************/
/*  returns a string of discoverer items ids used by a stat history (eul5_qpp_stats) record    */
/***********************************************************************************************/
function dis_qs_exp_ids(p_qs_id in number, p_eul in varchar2, p_type in varchar2 default null) return clob;

/***********************************************************************************************/
/*  returns a discoverer folder's object type                                                  */
/***********************************************************************************************/
function dis_obj_type(p_obj_id in varchar2, p_eul in varchar2) return varchar2 result_cache;

/***********************************************************************************************/
/*  returns a discoverer folder's object id                                                    */
/***********************************************************************************************/
function dis_obj_id(p_object_key in varchar2, p_eul in varchar2) return number result_cache;

/***********************************************************************************************/
/*  returns a discoverer item's expression id                                                  */
/***********************************************************************************************/
function dis_exp_id(p_object_key in varchar2, p_item_name in varchar2, p_eul in varchar2) return pls_integer result_cache;

/***********************************************************************************************/
/*  returns a discoverer item's expression data type                                           */
/***********************************************************************************************/
function dis_exp_data_type(p_object_key in varchar2, p_item_name in varchar2, p_eul in varchar2) return varchar2 result_cache;

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

/***********************************************************************************************/
/*  returns location information such as country or city for a given ip address, see           */
/*  https://www.enginatics.com/blog/find-an-ip-address-and-geolocation-of-ebs-clients-logins/  */
/***********************************************************************************************/
function geolocation(p_service_url in varchar2, p_ip_address in varchar2, p_path in varchar2, p_wallet_path in varchar2 default null) return varchar2 result_cache;

/***********************************************************************************************/
/*  returns parameter value for the currently running blitz report to be used in beforereport  */
/*  plsql code, for example: xxen_util.parameter_value('Operating Unit')                       */
/***********************************************************************************************/
function parameter_value(p_parameter_name in varchar2 default null, p_parameter_bind in varchar2 default null) return varchar2;

/***********************************************************************************************/
/*  return the original order line id in case of line splitting for DIFOT data.                */
/*  it is required as a workaround for an optimizer bug not executing the connect by correctly */
/***********************************************************************************************/
function orig_order_line_id(p_split_from_line_id in number) return number;

/***********************************************************************************************/
/*  replaces the default leger name for the current login user                                 */
/***********************************************************************************************/
function default_ledger return varchar2;

/***********************************************************************************************/
/*  replaces the default operating unit name for the current login user                        */
/***********************************************************************************************/
function default_operating_unit return varchar2;

/***********************************************************************************************/
/*  returns the previous parameter value used by the current user and login responsibility     */
/***********************************************************************************************/
function previous_parameter_value(p_parameter_id in pls_integer) return varchar2;

/***********************************************************************************************/
/*  returns sql text for descriptive flexfield columns                                         */
/***********************************************************************************************/
function dff_columns(
p_table_name in varchar2,
p_table_alias in varchar2 default null,
p_descr_flex_context_code in varchar2 default null,
p_column_name_prefix in varchar2 default null,
p_prefix in varchar2 default null,
p_hide_column_name in varchar2 default null,
p_row_id in varchar2 default null
) return clob;

/***********************************************************************************************/
/*  returns sql text for item category columns                                                 */
/***********************************************************************************************/
function item_category_columns(p_category_set_name in varchar2, p_table_alias in varchar2 default 'msiv', p_item_id_column in varchar2 default 'inventory_item_id', p_org_id_column in varchar2 default 'organization_id') return clob;

/***********************************************************************************************/
/*  Wait for request completion, for example for upload                                        */
/***********************************************************************************************/
function wait_for_request(p_conc_request_id in number, x_status out varchar2, x_message out varchar2) return varchar2;

/***********************************************************************************************/
/*  returns the functional currency code for a ledger                                          */
/***********************************************************************************************/
function functional_currency_code(p_ledger_name in varchar2) return varchar2;

/***********************************************************************************************/
/*  returns the latest open period for a ledger                                                */
/***********************************************************************************************/
function latest_open_period(p_ledger_name in varchar2) return varchar2;

/***********************************************************************************************/
/*  returns the segment name for a ledger and segment value from property                      */
/***********************************************************************************************/
function segment_name(p_ledger_name in varchar2, p_segment_prop_value in varchar2, p_segment_num in number) return varchar2;

/***********************************************************************************************/
/*  returns the ledger id for a ledger                                                         */
/***********************************************************************************************/
function ledger_id(p_ledger_name in varchar2) return number result_cache;

/***********************************************************************************************/
/*  returns the chart of accounts id for a ledger                                              */
/***********************************************************************************************/
function coa_id(p_ledger_name in varchar2) return number result_cache;

/***********************************************************************************************/
/*  returns 'Y' if flex value security needs to be applied                                     */
/***********************************************************************************************/
function has_flex_value_security return varchar2;

/***********************************************************************************************/
/*  Escapes characters that may break XML structure                                            */
/***********************************************************************************************/
function xml_escape(p_text in varchar2) return varchar2;

/***********************************************************************************************/
/* Translates escaped characters back to get an original string                                */
/***********************************************************************************************/
function xml_unescape(p_text in varchar2) return varchar2;

/***********************************************************************************************/
/* Get the XML attribute value                                                                 */
/***********************************************************************************************/
function xml_attribute_value(p_vchr in varchar2) return varchar2;

/***********************************************************************************************/
/* Remove the order by clause from the end of a SQL                                            */
/***********************************************************************************************/
function remove_order_by(p_text in clob) return clob;

/***********************************************************************************************/
/* Identify if the current database is running Oracle EBS                                      */
/***********************************************************************************************/
function is_ebs_database return boolean;

/***********************************************************************************************/
/* Concurrent request log- or out file url, p_file_type: 'O' for out, 'L' for log              */
/***********************************************************************************************/
function concurrent_request_file_url(p_file_type in varchar2, p_request_id in number) return varchar2;

/***********************************************************************************************/
/* Excel column name for a given column number, for example 3 -> C                             */
/***********************************************************************************************/
function colname(p_col in pls_integer) return varchar2;

/***********************************************************************************************/
/* Column position for a given Excel column number, for example C -> 3                         */
/***********************************************************************************************/
function colnum(p_column_name in varchar2) return pls_integer;

/***********************************************************************************************/
/* Converts an Oracle date to the equivalent numeric value in Excel date format                */
/***********************************************************************************************/
function date_to_excel_date(p_date in date) return varchar2 deterministic;

/***********************************************************************************************/
/* Converts a numeric Exel date to the equivalent Oracle date                                  */
/***********************************************************************************************/
function excel_date_to_date(p_excel_date in varchar2) return date deterministic;

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
/*                          (c) 2010-2021 Enginatics GmbH                                      */
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

type g_dff_bind_rec_type is record (flex varchar2(100), bind varchar2(100), column_name varchar2(30), data_type varchar2(1));
type g_dff_bind_tbl_type is table of g_dff_bind_rec_type index by pls_integer;


function base_language return varchar2 deterministic is
begin
  for c in (select fl.language_code from fnd_languages fl where fl.installed_flag='B') loop
    return c.language_code;
  end loop;
end base_language;


function nls_language_iso_code return varchar2 is
begin
  for c in (
  select
  lower(fl.iso_language)||'-'||upper(fl.iso_territory) nls_language_iso_code
  from
  v$parameter vp,
  fnd_languages fl
  where
  vp.name='nls_language' and
  upper(vp.value)=fl.nls_language
  ) loop
    return c.nls_language_iso_code;
  end loop;
end nls_language_iso_code;


function trunc_sysdate return date is
begin
  return trunc(sysdate);
end trunc_sysdate;


function fnd_message(p_message_name in varchar2, p_application_short_name in varchar2 default null) return varchar2 is
function fnd_message_(p_message_name in varchar2, p_userenv_lang in varchar2, p_application_short_name in varchar2) return varchar2 result_cache is
l_message varchar2(4000);
begin
  for c in (
  select distinct
  min(fnm.message_text) keep (dense_rank first order by decode(fnm.language_code,base_language,2,1)) over () message_text
  from
  fnd_application fa,
  fnd_new_messages fnm
  where
  fa.application_short_name=p_application_short_name and
  fa.application_id=fnm.application_id and
  fnm.message_name=p_message_name and
  fnm.language_code in (base_language,p_userenv_lang)
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
  min(flv.description) keep (dense_rank first order by decode(flv.source_lang,base_language,2,1)) over () description
  from
  fnd_lookup_values flv
  where
  flv.lookup_code=p_lookup_code and
  flv.lookup_type=p_lookup_type and
  flv.view_application_id=p_application_id and
  flv.language in (base_language,p_userenv_lang) and
  flv.source_lang in (base_language,p_userenv_lang) and
  flv.security_group_id=0
  ) loop
    l_description:=c.description;
  end loop;
  return l_description;
end description;
begin
  return description(p_lookup_code, p_lookup_type, p_application_id, userenv('lang'));
end description;


function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_meaning_if_null in varchar2 default null) return varchar2 is
function lookup_code(p_meaning in varchar2, p_lookup_type in varchar2, p_application_id in varchar2, p_userenv_lang in varchar2, p_meaning_if_null in varchar2) return varchar2 result_cache is
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
  return nvl(l_lookup_code,case when p_meaning_if_null='Y' then p_meaning end);
end lookup_code;

begin
  return lookup_code(p_meaning, p_lookup_type, p_application_id, userenv('lang'), p_meaning_if_null);
end lookup_code;


function regexp_escape(p_text in varchar2) return varchar2 is
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
replace(
replace(p_text,
chr(0)),
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
l_value varchar2(1);
begin
  if p_parameter_value like '%\%%' escape '\' then
    for c in (select regexp_substr(case when p_parameter_value like '<multiple_values>%' then substr(p_parameter_value,18) else p_parameter_value end,'[^;]+',1,level) value from dual connect by level<=regexp_count(p_parameter_value,'[^;]+')) loop
      if p_column_value like c.value then
        l_value:='Y';
      end if;
    end loop;
  else
    l_value:=case when regexp_like(case when p_parameter_value like '<multiple_values>%' then substr(p_parameter_value,18) else p_parameter_value end,'(^|;)\s*'||regexp_escape(p_column_value)||'\s*(;|$)') then 'Y' end;
  end if;
  return l_value;
end contains;


function init_cap(p_text in varchar2) return varchar2 is
begin
  return case when upper(p_text)=p_text and length(p_text)>3 and p_text=regexp_replace(upper(p_text),'[^[:alpha:]_#$0-9]') then initcap(p_text) else p_text end;
end init_cap;


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
exception
  when others then
    return p_profile_option_value;
end display_profile_option_value;


procedure dff_lov_sql(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_flex_value_set_id in number,
p_enabled_only in varchar2 default null,
p_business_group_id in number default null,
p_organization_id in number default null,
p_org_information_id in number default null,
x_sql_text out varchar2,
x_dff_bind_tbl out g_dff_bind_tbl_type
) is
l_sql_text varchar2(32767);
l_additional_where_clause varchar2(32767);
begin
  for c in (
  select /*+ result_cache*/
  ffvs.flex_value_set_name,
  ffvs.validation_type,
  ffvt.value_column_name,
  ffvt.meaning_column_name,
  ffvt.id_column_name,
  ffvt.application_table_name,
  ffvt.additional_where_clause,
  ffvs.parent_flex_value_set_id
  from
  fnd_flex_value_sets ffvs,
  fnd_flex_validation_tables ffvt
  where
  ffvs.flex_value_set_id = p_flex_value_set_id and
  decode(ffvs.validation_type,'F',ffvs.flex_value_set_id)=ffvt.flex_value_set_id(+)
  ) loop
    if c.validation_type in ('D','I','X','Y') then
      l_sql_text:='select ffvv.flex_value id,ffvv.flex_value_meaning value,ffvv.description description from fnd_flex_values_vl ffvv where ffvv.flex_value_set_id= :p_flex_value_set_id';
      if c.validation_type in ('D','Y') and c.parent_flex_value_set_id is not null then
        l_sql_text := l_sql_text || ' and ffvv.parent_flex_value_low = (select ffvv2.flex_value from fnd_flex_values_vl ffvv2 where ffvv2.flex_value_set_id = :p_parent_flex_value_set_id and ffvv2.flex_value_meaning = :p_parent_flex_value_low)';
      end if ;
      if p_enabled_only = 'Y' then
        l_sql_text := l_sql_text || ' and ffvv.enabled_flag = ''Y'' and trunc(sysdate) between nvl(ffvv.start_date_active,trunc(sysdate)) and nvl(ffvv.end_date_active,trunc(sysdate))';
      end if;
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
        l_additional_where_clause := regexp_replace(l_additional_where_clause,':\$PROFILES\$\.(PER_BUSINESS_GROUP_ID|USER_ID|ORG_ID|RESP_APPL_ID|RESP_ID|PER_SECURITY_PROFILE_ID)(:null)?','fnd_global.\1',1,0,'i');
        l_additional_where_clause := regexp_replace(l_additional_where_clause,':\$PROFILES\$\.(\w+)(:null)?','fnd_profile.value(''\1'')',1,0,'i');
      end if;
      if lower(l_additional_where_clause) not like 'where%' and lower(l_additional_where_clause) not like 'order by%' then
        l_additional_where_clause:='where '||l_additional_where_clause;
      end if;
      l_sql_text:='select '||nvl(c.id_column_name,c.value_column_name)|| ' id, '||c.value_column_name||' value, '||case when c.meaning_column_name is not null then c.meaning_column_name else 'null' end||' description from '||c.application_table_name||' '||l_additional_where_clause;
    end if;

    if upper(l_sql_text) like '%:$FLEX$.%' then
      --fill dynamic FLEX bind table
      select
      y.flex,
      y.bind,
      z.application_column_name,
      z.id_column_type
      bulk collect into x_dff_bind_tbl
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
      fdfcu.application_column_name,
      nvl(nvl2(ffvt.id_column_name,ffvt.id_column_type,ffvs.format_type),'C') id_column_type
      from
      fnd_descr_flex_column_usages fdfcu,
      fnd_flex_value_sets ffvs,
      fnd_flex_validation_tables ffvt
      where
      fdfcu.application_id=p_application_id and
      fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
      fdfcu.descriptive_flex_context_code in ('Global Data Elements',p_context_code) and
      fdfcu.enabled_flag = 'Y' and
      fdfcu.flex_value_set_id=ffvs.flex_value_set_id(+) and
      fdfcu.flex_value_set_id=ffvt.flex_value_set_id(+)
      ) z
      where
      y.bind=z.flex_value_set_name or y.bind=z.end_user_column_name
      order by
      length(y.bind) desc,
      y.bind;

      --replace :$FLEX$. with bind string
      for i in x_dff_bind_tbl.first..x_dff_bind_tbl.last loop
        l_sql_text:=replace(l_sql_text,x_dff_bind_tbl(i).flex,':'||substrb(x_dff_bind_tbl(i).bind,1,30));
      end loop;
    end if;
  end loop;
  x_sql_text:=l_sql_text;
exception
  when others then
    x_sql_text:=null;
end dff_lov_sql;

function display_flexfield_context(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2
) return varchar2 is
l_context_name fnd_descr_flex_contexts_vl.descriptive_flex_context_name%type;
begin
 for c in (
 select  /*+ result_cache*/
 fdfcv.descriptive_flex_context_name
 from
 fnd_descriptive_flexs_vl     fdfv,
 fnd_descr_flex_contexts_vl   fdfcv
 where
 fdfv.application_id = fdfcv.application_id and
 fdfv.descriptive_flexfield_name = fdfcv.descriptive_flexfield_name and
 fdfv.application_id = p_application_id and
 fdfv.descriptive_flexfield_name = p_descriptive_flexfield_name and
 fdfcv.descriptive_flex_context_code = p_context_code
 ) loop
   return(c.descriptive_flex_context_name);
 end loop;
 return(p_context_code);
end display_flexfield_context;

function display_flexfield_value(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_column_name in varchar2,
p_rowid in rowid default null,
p_value in varchar2 default chr(0),
p_business_group_id in number default null,
p_organization_id in number default null,
p_org_information_id in number default null,
p_concatenate_description in varchar2 default null
) return varchar2 is
l_table_name varchar2(30);
l_flexfield_value varchar2(4000);
l_sql_text varchar2(32767);
l_cursor pls_integer;
l_row_count pls_integer;
l_bind_value varchar2(4000);
l_display_value varchar2(4000);
l_flex g_dff_bind_tbl_type;
l_prev_bind_name varchar2(100):='-99';
l_prev_bind_value varchar2(4000);
function application_table_name(p_application_id in varchar2, p_descriptive_flexfield_name in varchar2) return varchar2 result_cache is
begin
  for c in (
  select
  fdf.application_table_name
  from
  fnd_descriptive_flexs fdf
  where
  fdf.application_id=p_application_id and
  fdf.descriptive_flexfield_name=p_descriptive_flexfield_name
  ) loop
    return c.application_table_name;
  end loop;
end application_table_name;
begin
  if p_application_id is null
  or p_descriptive_flexfield_name is null
  or p_column_name is null then
    return p_value;
  end if;

  l_table_name:=application_table_name(p_application_id, p_descriptive_flexfield_name);
  if p_value=fnd_api.g_miss_char then
    execute immediate 'select x.'||p_column_name||' from '||l_table_name||' x where x.rowid=:p_rowid' into l_flexfield_value using p_rowid;
  else
    l_flexfield_value:=p_value;
  end if;
  if l_flexfield_value is not null then
    l_display_value:=l_flexfield_value;
    for c in (
    select /*+ result_cache*/
    fdfcu.flex_value_set_id,
    ffvs.parent_flex_value_set_id,
    (
    select
    fdfcu2.application_column_name
    from
    fnd_descr_flex_column_usages fdfcu2
    where
    fdfcu.application_id=fdfcu2.application_id and
    fdfcu.descriptive_flexfield_name=fdfcu2.descriptive_flexfield_name and
    fdfcu.descriptive_flex_context_code=fdfcu2.descriptive_flex_context_code and
    ffvs.parent_flex_value_set_id=fdfcu2.flex_value_set_id and
    fdfcu2.enabled_flag='Y'
    ) parent_column_name,
    ffvs.validation_type,
    ffvs.format_type,
    nvl2(ffvt.id_column_name,ffvt.id_column_type,ffvs.format_type) id_column_type
    from
    fnd_descr_flex_column_usages fdfcu,
    fnd_flex_value_sets ffvs,
    fnd_flex_validation_tables ffvt
    where
    fdfcu.application_id=p_application_id and
    fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
    fdfcu.application_id=p_application_id and
    fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
    fdfcu.descriptive_flex_context_code in ('Global Data Elements',p_context_code) and
    fdfcu.application_column_name=p_column_name and
    fdfcu.flex_value_set_id=ffvs.flex_value_set_id and
    fdfcu.flex_value_set_id=ffvt.flex_value_set_id (+)
    ) loop
      dff_lov_sql(
      p_application_id=>p_application_id,
      p_descriptive_flexfield_name=>p_descriptive_flexfield_name,
      p_context_code=>p_context_code,
      p_flex_value_set_id=>c.flex_value_set_id,
      p_business_group_id=>p_business_group_id,
      p_organization_id=>p_organization_id,
      p_org_information_id=>p_org_information_id,
      x_sql_text=>l_sql_text,
      x_dff_bind_tbl=>l_flex
      );
      if l_sql_text is not null then
        l_sql_text:='select '||
        case when c.validation_type = 'F' and c.format_type = 'X' then 'fnd_date.date_to_displaydate(x.value)' when c.validation_type = 'F' and c.format_type = 'Y' then 'fnd_date.date_to_displayDT(x.value)' else 'x.value' end||
        case when p_concatenate_description='Y' then '||nvl2(x.description,'': ''||x.description,null)' end||' display_value from ('||l_sql_text||') x where x.id='||
        case
        when c.id_column_type = 'D' then 'fnd_date.displaydate_to_date(:p_flexfield_value)'
        when c.id_column_type in ('X','Y') then 'fnd_date.canonical_to_date(:p_flexfield_value)'
        else ':p_flexfield_value'
        end;

       --parse
        l_cursor:=dbms_sql.open_cursor;
        dbms_sql.parse(l_cursor, l_sql_text, dbms_sql.native);

        --bind
        dbms_sql.bind_variable(l_cursor,':p_flexfield_value',l_flexfield_value);

        if l_sql_text like '%:p_flex_value_set_id%' then
          dbms_sql.bind_variable(l_cursor,':p_flex_value_set_id',c.flex_value_set_id);
        end if;
        if l_sql_text like '%:p_parent_flex_value_set_id%' then
          dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_set_id',c.parent_flex_value_set_id);
        end if;
        if l_sql_text like '%:p_parent_flex_value_low%' then
          execute immediate 'select x.'||c.parent_column_name||' from '||l_table_name||' x where x.rowid=:p_rowid' into l_bind_value using p_rowid;
          dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_low',l_bind_value);
        end if;
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
            if p_rowid is not null then
              execute immediate 'select x.'||l_flex(i).column_name||' from '||l_table_name||' x where x.rowid=:p_rowid' into l_bind_value using p_rowid;
            end if;
            if l_flex(i).bind<>l_prev_bind_name or l_bind_value is not null then
              dbms_sql.bind_variable(l_cursor,':'||substrb(l_flex(i).bind,1,30),l_bind_value);
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
      else
        if c.id_column_type = 'D' then
          l_display_value:=fnd_date.displaydate_to_date(l_display_value);
        elsif c.id_column_type in ('X','Y') then
          l_display_value:=fnd_date.canonical_to_date(l_display_value);
        end if;
      end if; --l_sql_text is not null then
    end loop;
  end if; --l_flexfield_value is not null
  return l_display_value;
exception
  when others then
    if dbms_sql.is_open(l_cursor) then
      dbms_sql.close_cursor(l_cursor);
    end if;
    return l_display_value;
end display_flexfield_value;


function dff_attribute_value_to_id(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_code in varchar2,
p_column_name in varchar2,
p_attribute1 in varchar2 default null,
p_attribute2 in varchar2 default null,
p_attribute3 in varchar2 default null,
p_attribute4 in varchar2 default null,
p_attribute5 in varchar2 default null,
p_attribute6 in varchar2 default null,
p_attribute7 in varchar2 default null,
p_attribute8 in varchar2 default null,
p_attribute9 in varchar2 default null,
p_attribute10 in varchar2 default null,
p_attribute11 in varchar2 default null,
p_attribute12 in varchar2 default null,
p_attribute13 in varchar2 default null,
p_attribute14 in varchar2 default null,
p_attribute15 in varchar2 default null,
p_attribute16 in varchar2 default null,
p_attribute17 in varchar2 default null,
p_attribute18 in varchar2 default null,
p_attribute19 in varchar2 default null,
p_attribute20 in varchar2 default null,
p_attribute21 in varchar2 default null,
p_attribute22 in varchar2 default null,
p_attribute23 in varchar2 default null,
p_attribute24 in varchar2 default null,
p_attribute25 in varchar2 default null,
p_attribute26 in varchar2 default null,
p_attribute27 in varchar2 default null,
p_attribute28 in varchar2 default null,
p_attribute29 in varchar2 default null,
p_attribute30 in varchar2 default null,
p_recursion_path in varchar2 default null
) return varchar2 is
l_sql_text                 varchar2(32767);
l_cursor                   pls_integer;
l_row_count                pls_integer;
l_bind_value               varchar2(4000);
l_display_value            varchar2(4000);
l_id_value                 varchar2(4000);
l_flex g_dff_bind_tbl_type;
l_prev_bind_name varchar2(100):='-99';
l_prev_bind_value varchar2(4000);

function get_bind_attribute_val(p_get_column_name in varchar2) return varchar2 is
l_recursion_path varchar2(4000);
l_attribute_id_value varchar2(4000);
begin
  if instr(p_recursion_path,':'||p_get_column_name||':',1,1)>0 then
    -- recursive loop -- we've already called this api for column name in this recursive check
    return null;
  end if;
  l_recursion_path:=nvl(l_recursion_path,':')||p_column_name||':';
  l_attribute_id_value:=
  dff_attribute_value_to_id(
  p_application_id,
  p_descriptive_flexfield_name,
  p_context_code,
  p_get_column_name,
  p_attribute1,
  p_attribute2,
  p_attribute3,
  p_attribute4,
  p_attribute5,
  p_attribute6,
  p_attribute7,
  p_attribute8,
  p_attribute9,
  p_attribute10,
  p_attribute11,
  p_attribute12,
  p_attribute13,
  p_attribute14,
  p_attribute15,
  p_attribute16,
  p_attribute17,
  p_attribute18,
  p_attribute19,
  p_attribute20,
  p_attribute21,
  p_attribute22,
  p_attribute23,
  p_attribute24,
  p_attribute25,
  p_attribute26,
  p_attribute27,
  p_attribute28,
  p_attribute29,
  p_attribute30,
  l_recursion_path
  );
  return l_attribute_id_value;
end get_bind_attribute_val;

begin
  l_display_value:=
  case p_column_name
  when 'ATTRIBUTE1' then p_attribute1
  when 'ATTRIBUTE2' then p_attribute2
  when 'ATTRIBUTE3' then p_attribute3
  when 'ATTRIBUTE4' then p_attribute4
  when 'ATTRIBUTE5' then p_attribute5
  when 'ATTRIBUTE6' then p_attribute6
  when 'ATTRIBUTE7' then p_attribute7
  when 'ATTRIBUTE8' then p_attribute8
  when 'ATTRIBUTE9' then p_attribute9
  when 'ATTRIBUTE10' then p_attribute10
  when 'ATTRIBUTE11' then p_attribute11
  when 'ATTRIBUTE12' then p_attribute12
  when 'ATTRIBUTE13' then p_attribute13
  when 'ATTRIBUTE14' then p_attribute14
  when 'ATTRIBUTE15' then p_attribute15
  when 'ATTRIBUTE16' then p_attribute16
  when 'ATTRIBUTE17' then p_attribute17
  when 'ATTRIBUTE18' then p_attribute18
  when 'ATTRIBUTE19' then p_attribute19
  when 'ATTRIBUTE20' then p_attribute20
  when 'ATTRIBUTE21' then p_attribute21
  when 'ATTRIBUTE22' then p_attribute22
  when 'ATTRIBUTE23' then p_attribute23
  when 'ATTRIBUTE24' then p_attribute24
  when 'ATTRIBUTE25' then p_attribute25
  when 'ATTRIBUTE26' then p_attribute26
  when 'ATTRIBUTE27' then p_attribute27
  when 'ATTRIBUTE28' then p_attribute28
  when 'ATTRIBUTE29' then p_attribute29
  when 'ATTRIBUTE30' then p_attribute30
  else null
  end;
  l_id_value:=l_display_value;

  if p_application_id is null
  or p_descriptive_flexfield_name is null
  or p_column_name is null then
    return l_id_value;
  end if;

  if l_display_value is not null then
    for c in (
    select /*+ result_cache*/
    fdfcu.flex_value_set_id,
    ffvs.parent_flex_value_set_id,
    (
    select
    fdfcu2.application_column_name
    from
    fnd_descr_flex_column_usages fdfcu2
    where
    fdfcu.application_id=fdfcu2.application_id and
    fdfcu.descriptive_flexfield_name=fdfcu2.descriptive_flexfield_name and
    fdfcu.descriptive_flex_context_code=fdfcu2.descriptive_flex_context_code and
    ffvs.parent_flex_value_set_id=fdfcu2.flex_value_set_id and
    fdfcu2.enabled_flag='Y'
    ) parent_column_name,
    ffvs.validation_type,
    ffvs.format_type,
    nvl2(ffvt.id_column_name,ffvt.id_column_type,ffvs.format_type) id_column_type
    from
    fnd_descr_flex_column_usages fdfcu,
    fnd_flex_value_sets ffvs,
    fnd_flex_validation_tables ffvt
    where
    fdfcu.application_id=p_application_id and
    fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
    fdfcu.descriptive_flex_context_code in ('Global Data Elements',p_context_code) and
    fdfcu.application_column_name=p_column_name and
    fdfcu.enabled_flag='Y' and
    fdfcu.flex_value_set_id=ffvs.flex_value_set_id and
    fdfcu.flex_value_set_id=ffvt.flex_value_set_id (+)
    ) loop
      dff_lov_sql(
      p_application_id=>p_application_id,
      p_descriptive_flexfield_name=>p_descriptive_flexfield_name,
      p_context_code=>p_context_code,
      p_flex_value_set_id=>c.flex_value_set_id,
      x_sql_text=>l_sql_text,
      x_dff_bind_tbl=>l_flex
      );
      if l_sql_text is not null then
        l_sql_text := 'select x.id from (' || l_sql_text || ') x where ' ||
        'x.value=' ||
        case
        when c.format_type = 'D' then 'fnd_date.displaydate_to_date(:p_flexfield_value)'
        when c.format_type = 'X' then 'fnd_date.displaydate_to_date(:p_flexfield_value)'
        when c.format_type = 'Y' then 'fnd_date.displayDT_to_date(:p_flexfield_value)'
        else ':p_flexfield_value'
        end;

        --parse
        l_cursor:=dbms_sql.open_cursor;
        dbms_sql.parse(l_cursor, l_sql_text, dbms_sql.native);

        --bind
        dbms_sql.bind_variable(l_cursor,':p_flexfield_value',l_display_value);

        if l_sql_text like '%:p_flex_value_set_id%' then
          dbms_sql.bind_variable(l_cursor,':p_flex_value_set_id',c.flex_value_set_id);
        end if;
        if l_sql_text like '%:p_parent_flex_value_set_id%' then
          dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_set_id',c.parent_flex_value_set_id);
        end if;
        if l_sql_text like '%:p_parent_flex_value_low%' then
          l_bind_value := get_bind_attribute_val(c.parent_column_name);
          dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_low',l_bind_value);
        end if;
        if l_flex.first is not null then
          for i in l_flex.first..l_flex.last loop
            l_bind_value := get_bind_attribute_val(l_flex(i).column_name);
            if l_flex(i).bind<>l_prev_bind_name or l_bind_value is not null then
              dbms_sql.bind_variable(l_cursor,':'||substrb(l_flex(i).bind,1,30),l_bind_value);
              l_prev_bind_name:=l_flex(i).bind;
              l_prev_bind_value:=l_bind_value;
            end if;
          end loop;
        end if;

        --define_column
        dbms_sql.define_column(l_cursor, 1, l_id_value, 4000);

        --execute and fetch
        l_row_count:=dbms_sql.execute(l_cursor);
        if dbms_sql.fetch_rows(l_cursor)>0 then
          dbms_sql.column_value(l_cursor, 1, l_id_value);
          if c.format_type in ('X','Y') then
            l_id_value := fnd_date.date_to_canonical(l_id_value);
          end if;
        end if;
        dbms_sql.close_cursor(l_cursor);
      end if; -- l_sql_text is not null
    end loop;
  end if; -- l_display_value is not null
  return l_id_value;
exception
  when others then
    if dbms_sql.is_open(l_cursor) then
      dbms_sql.close_cursor(l_cursor);
    end if;
    return l_id_value;
end dff_attribute_value_to_id;


function dff_attribute_lov(
p_application_id in number,
p_descriptive_flexfield_name in varchar2,
p_context_name in varchar2,
p_column_name in varchar2,
p_lov_delimter in varchar2,
p_attribute1 in varchar2,
p_attribute2 in varchar2,
p_attribute3 in varchar2,
p_attribute4 in varchar2,
p_attribute5 in varchar2,
p_attribute6 in varchar2,
p_attribute7 in varchar2,
p_attribute8 in varchar2,
p_attribute9 in varchar2,
p_attribute10 in varchar2,
p_attribute11 in varchar2,
p_attribute12 in varchar2,
p_attribute13 in varchar2,
p_attribute14 in varchar2,
p_attribute15 in varchar2,
p_attribute16 in varchar2,
p_attribute17 in varchar2,
p_attribute18 in varchar2,
p_attribute19 in varchar2,
p_attribute20 in varchar2,
p_attribute21 in varchar2,
p_attribute22 in varchar2,
p_attribute23 in varchar2,
p_attribute24 in varchar2,
p_attribute25 in varchar2,
p_attribute26 in varchar2,
p_attribute27 in varchar2,
p_attribute28 in varchar2,
p_attribute29 in varchar2,
p_attribute30 in varchar2
) return fnd_table_of_varchar2_4000 pipelined is
l_sql_text                 varchar2(32767);
l_cursor                   pls_integer;
l_row_count                pls_integer;
l_bind_value               varchar2(4000);
l_entered_value            varchar2(4000);
l_value                    varchar2(4000);
l_description              varchar2(4000);

l_flex g_dff_bind_tbl_type;
l_prev_bind_name varchar2(100):='-99';
l_prev_bind_value varchar2(4000);
l_context_code fnd_descr_flex_contexts_vl.descriptive_flex_context_code%type;

function get_bind_attribute_val(p_context_code in varchar2, p_get_column_name in varchar2) return varchar2 is
l_attribute_id_value varchar2(4000);
begin
  l_attribute_id_value:=
  dff_attribute_value_to_id(
  p_application_id,
  p_descriptive_flexfield_name,
  p_context_code,
  p_get_column_name,
  p_attribute1,
  p_attribute2,
  p_attribute3,
  p_attribute4,
  p_attribute5,
  p_attribute6,
  p_attribute7,
  p_attribute8,
  p_attribute9,
  p_attribute10,
  p_attribute11,
  p_attribute12,
  p_attribute13,
  p_attribute14,
  p_attribute15,
  p_attribute16,
  p_attribute17,
  p_attribute18,
  p_attribute19,
  p_attribute20,
  p_attribute21,
  p_attribute22,
  p_attribute23,
  p_attribute24,
  p_attribute25,
  p_attribute26,
  p_attribute27,
  p_attribute28,
  p_attribute29,
  p_attribute30
  );
  return l_attribute_id_value;
end get_bind_attribute_val;

begin
  if p_application_id is null
  or p_descriptive_flexfield_name is null
  or p_column_name is null
  then
    return;
  end if;

  l_entered_value:=
  case p_column_name
  when 'ATTRIBUTE1' then p_attribute1
  when 'ATTRIBUTE2' then p_attribute2
  when 'ATTRIBUTE3' then p_attribute3
  when 'ATTRIBUTE4' then p_attribute4
  when 'ATTRIBUTE5' then p_attribute5
  when 'ATTRIBUTE6' then p_attribute6
  when 'ATTRIBUTE7' then p_attribute7
  when 'ATTRIBUTE8' then p_attribute8
  when 'ATTRIBUTE9' then p_attribute9
  when 'ATTRIBUTE10' then p_attribute10
  when 'ATTRIBUTE11' then p_attribute11
  when 'ATTRIBUTE12' then p_attribute12
  when 'ATTRIBUTE13' then p_attribute13
  when 'ATTRIBUTE14' then p_attribute14
  when 'ATTRIBUTE15' then p_attribute15
  when 'ATTRIBUTE16' then p_attribute16
  when 'ATTRIBUTE17' then p_attribute17
  when 'ATTRIBUTE18' then p_attribute18
  when 'ATTRIBUTE19' then p_attribute19
  when 'ATTRIBUTE20' then p_attribute20
  when 'ATTRIBUTE21' then p_attribute21
  when 'ATTRIBUTE22' then p_attribute22
  when 'ATTRIBUTE23' then p_attribute23
  when 'ATTRIBUTE24' then p_attribute24
  when 'ATTRIBUTE25' then p_attribute25
  when 'ATTRIBUTE26' then p_attribute26
  when 'ATTRIBUTE27' then p_attribute27
  when 'ATTRIBUTE28' then p_attribute28
  when 'ATTRIBUTE29' then p_attribute29
  when 'ATTRIBUTE30' then p_attribute30
  else null
  end;

  -- get the descriptive flex context code. The upload will pass in the context name
  for c in (
  select  /*+ result_cache*/
  fdfcv.descriptive_flex_context_code
  from
  fnd_descriptive_flexs_vl     fdfv,
  fnd_descr_flex_contexts_vl   fdfcv
  where
  fdfv.application_id = fdfcv.application_id and
  fdfv.descriptive_flexfield_name = fdfcv.descriptive_flexfield_name and
  fdfv.application_id = p_application_id and
  fdfv.descriptive_flexfield_name = p_descriptive_flexfield_name and
  fdfcv.descriptive_flex_context_name = p_context_name
  ) loop
    l_context_code := c.descriptive_flex_context_code;
  end loop;
  l_context_code := nvl(l_context_code,p_context_name);

  for c in (
  select /*+ result_cache*/
  fdfcu.flex_value_set_id,
  ffvs.parent_flex_value_set_id,
  (
  select
  fdfcu2.application_column_name
  from
  fnd_descr_flex_column_usages fdfcu2
  where
  fdfcu.application_id=fdfcu2.application_id and
  fdfcu.descriptive_flexfield_name=fdfcu2.descriptive_flexfield_name and
  fdfcu.descriptive_flex_context_code=fdfcu2.descriptive_flex_context_code and
  ffvs.parent_flex_value_set_id=fdfcu2.flex_value_set_id and
  fdfcu2.enabled_flag='Y'
  ) parent_column_name,
  ffvs.validation_type,
  ffvs.format_type,
  nvl2(ffvt.id_column_name,ffvt.id_column_type,ffvs.format_type) id_column_type
  from
  fnd_descr_flex_column_usages fdfcu,
  fnd_flex_value_sets ffvs,
  fnd_flex_validation_tables ffvt
  where
  fdfcu.application_id=p_application_id and
  fdfcu.descriptive_flexfield_name=p_descriptive_flexfield_name and
  fdfcu.descriptive_flex_context_code in ('Global Data Elements',l_context_code) and
  fdfcu.application_column_name=p_column_name and
  fdfcu.enabled_flag='Y' and
  fdfcu.flex_value_set_id=ffvs.flex_value_set_id (+) and
  fdfcu.flex_value_set_id=ffvt.flex_value_set_id (+)
  ) loop
    dff_lov_sql(
    p_application_id=>p_application_id,
    p_descriptive_flexfield_name=>p_descriptive_flexfield_name,
    p_context_code=>l_context_code,
    p_flex_value_set_id=>c.flex_value_set_id,
    p_enabled_only=>'Y',
    x_sql_text=>l_sql_text,
    x_dff_bind_tbl=>l_flex
    );
    if l_sql_text is null then
      if l_entered_value is not null then
        pipe row(substrb(l_entered_value||p_lov_delimter,1,4000));
      end if;
    else
      l_sql_text := 'select x.value, x.description from ('||l_sql_text||') x';
      if l_entered_value is null then
        l_sql_text:=l_sql_text||' where replace(x.value,chr(0),null) is not null';
      else
        l_sql_text:=l_sql_text||' where (x.value like :pv1||''%'' or x.value like :pv2||''%'' or x.value like :pv3||''%'' or x.value like :pv4||''%'')';
      end if;
      l_sql_text:=l_sql_text||' order by x.value';

      -- parse
      l_cursor:=dbms_sql.open_cursor;
      dbms_sql.parse(l_cursor, l_sql_text, dbms_sql.native);

      --bind
      if l_sql_text like '%:p_flex_value_set_id%' then
        dbms_sql.bind_variable(l_cursor,':p_flex_value_set_id',c.flex_value_set_id);
      end if;
      if l_sql_text like '%:p_parent_flex_value_set_id%' then
        dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_set_id',c.parent_flex_value_set_id);
      end if;
      if l_sql_text like '%:p_parent_flex_value_low%' then
        l_bind_value := get_bind_attribute_val(l_context_code,c.parent_column_name);
        dbms_sql.bind_variable(l_cursor,':p_parent_flex_value_low',l_bind_value);
      end if;
      if l_flex.first is not null then
        for i in l_flex.first..l_flex.last loop
          l_bind_value := get_bind_attribute_val(l_context_code,l_flex(i).column_name);
          if l_flex(i).bind<>l_prev_bind_name or l_bind_value is not null then
            dbms_sql.bind_variable(l_cursor,':'||substrb(l_flex(i).bind,1,30),l_bind_value);
            l_prev_bind_name:=l_flex(i).bind;
            l_prev_bind_value:=l_bind_value;
          end if;
        end loop;
      end if;
      if l_entered_value is not null then
        dbms_sql.bind_variable(l_cursor,':pv1',upper(substr(l_entered_value,1,2)));
        dbms_sql.bind_variable(l_cursor,':pv2',lower(substr(l_entered_value,1,2)));
        dbms_sql.bind_variable(l_cursor,':pv3',initcap(substr(l_entered_value,1,2)));
        dbms_sql.bind_variable(l_cursor,':pv4',lower(substr(l_entered_value,1,1))|| upper(substr(l_entered_value,2,1)));
      end if;
      --define_column
      dbms_sql.define_column(l_cursor, 1, l_value, 4000);
      dbms_sql.define_column(l_cursor, 2, l_description, 4000);

      --execute and fetch
      l_row_count:=dbms_sql.execute(l_cursor);
      loop
       if dbms_sql.fetch_rows(l_cursor)>0
       then
         dbms_sql.column_value(l_cursor, 1, l_value);
         dbms_sql.column_value(l_cursor, 2, l_description);
         if c.format_type = 'X'
         then l_value := fnd_date.date_to_displaydate(l_value);
         elsif c.format_type = 'Y'
         then l_value := fnd_date.date_to_displayDT(l_value);
         end if;
         pipe row(substrb(l_value || p_lov_delimter || l_description,1,4000));
       else
         exit;
       end if;
      end loop;
      dbms_sql.close_cursor(l_cursor);
    end if;  -- l_sql_text is not null
  end loop;
  return;
exception
  when others then
    if dbms_sql.is_open(l_cursor) then
      dbms_sql.close_cursor(l_cursor);
    end if;
    return;
end dff_attribute_lov;


function concatenated_segments(p_code_combination_id in number) return varchar2 result_cache is
l_concatenated_segments varchar2(800);
begin
  for c in (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id=p_code_combination_id) loop
    l_concatenated_segments:=c.concatenated_segments;
  end loop;
  return l_concatenated_segments;
end concatenated_segments;


function segment_description(
p_segment_value in varchar2,
p_column_name in varchar2,
p_id_flex_num in pls_integer,
p_parent_segment_value in varchar2 default null,
p_application_id in pls_integer default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2 is

function segment_description(
p_column_name in varchar2,
p_id_flex_num in pls_integer,
p_application_id in pls_integer,
p_id_flex_code in varchar2,
p_segment_value in varchar2,
p_parent_segment_value in varchar2,
p_userenv_lang in varchar2
) return varchar2 result_cache is
l_segment_description fnd_flex_values_tl.description%type;
begin
  if p_parent_segment_value is null then
    for c in (
    select
    ffvt.description
    from
    fnd_id_flex_segments fifs,
    fnd_flex_values ffv,
    fnd_flex_values_tl ffvt
    where
    fifs.application_column_name=p_column_name and
    fifs.id_flex_num=p_id_flex_num and
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
  else
    for c in (
    select
    ffvt.description
    from
    fnd_id_flex_segments fifs,
    fnd_flex_values ffv,
    fnd_flex_values_tl ffvt
    where
    fifs.application_column_name=p_column_name and
    fifs.id_flex_num=p_id_flex_num and
    fifs.application_id=p_application_id and
    fifs.id_flex_code=p_id_flex_code and
    fifs.flex_value_set_id=ffv.flex_value_set_id and
    p_parent_segment_value between ffv.parent_flex_value_low and nvl(ffv.parent_flex_value_high,ffv.parent_flex_value_low) and
    ffv.flex_value=p_segment_value and
    ffv.flex_value_id=ffvt.flex_value_id and
    ffvt.language=p_userenv_lang
    ) loop
      l_segment_description:=c.description;
    end loop;
  end if;
  return l_segment_description;
end segment_description;

begin
  return segment_description(p_column_name,p_id_flex_num,p_application_id,p_id_flex_code,p_segment_value,p_parent_segment_value,userenv('lang'));
end segment_description;


function segments_description(
p_id in number,
p_id_flex_num in pls_integer,
p_application_id in pls_integer default 101,
p_id_flex_code in varchar2 default 'GL#'
) return varchar2 is
type cur_type is ref cursor;
c_cur cur_type;
l_segments_description varchar2(4000);

function seqments_query(p_id_flex_num in pls_integer, p_application_id in pls_integer, p_id_flex_code in varchar2, p_userenv_lang in varchar2, p_delimiter in varchar2 default chr(10), p_show_segment_name in varchar2 default 'Y') return varchar2 result_cache is
l_sql_text varchar2(4000);
begin
  for c in (
  select
  decode(fifs.segment_num,min(fifs.segment_num) over (),'select ')||
  decode(p_show_segment_name,'Y',''''||fifst.form_left_prompt||': ''||')||'xxen_util.segment_description(x.'||fifs.application_column_name||', '''||fifs.application_column_name||''', '||fifs.id_flex_num||
  (
  select
  ', x.'||fifs0.application_column_name
  from
  fnd_id_flex_segments fifs0
  where
  fifs.application_id=fifs.application_id and
  fifs.id_flex_code=fifs0.id_flex_code and
  fifs.id_flex_num=fifs0.id_flex_num and
  fifs.enabled_flag=fifs0.enabled_flag and
  fifs0.flex_value_set_id=(select ffvs.parent_flex_value_set_id from fnd_flex_value_sets ffvs where fifs.flex_value_set_id=ffvs.flex_value_set_id)
  )||')'||decode(fifs.segment_num,max(fifs.segment_num) over (),' segments_description from '||fif.application_table_name||' x where x.'||fif.unique_id_column_name||'=:p_id','||'''||p_delimiter||'''||') sql_text
  from
  fnd_id_flexs fif,
  fnd_id_flex_segments fifs,
  fnd_id_flex_segments_tl fifst
  where
  fif.application_id=fifs.application_id and
  fif.id_flex_code=fifs.id_flex_code and
  fifs.application_id=p_application_id and
  fifs.id_flex_code=p_id_flex_code and
  fifs.id_flex_num=p_id_flex_num and
  fifs.enabled_flag='Y' and
  fifs.application_id=fifst.application_id and
  fifs.id_flex_code=fifst.id_flex_code and
  fifs.id_flex_num=fifst.id_flex_num and
  fifs.application_column_name=fifst.application_column_name and
  fifst.language=p_userenv_lang
  order by
  fifs.segment_num
  ) loop
    l_sql_text:=l_sql_text||c.sql_text;
  end loop;
  return l_sql_text;
end seqments_query;

begin
  open c_cur for seqments_query(p_id_flex_num, p_application_id, p_id_flex_code, userenv('lang')) using p_id;
  loop
    fetch c_cur into l_segments_description;
    exit when c_cur%notfound;
  end loop;
  close c_cur;
  return l_segments_description;
end segments_description;


function segments_description(p_code_combination_id in number) return varchar2 is
l_id_flex_num fnd_id_flex_structures.id_flex_num%type;
begin
  for c in (select gcc.chart_of_accounts_id from gl_code_combinations gcc where gcc.code_combination_id=p_code_combination_id) loop
    l_id_flex_num:=c.chart_of_accounts_id;
  end loop;
  return case when l_id_flex_num is not null then segments_description(p_code_combination_id,l_id_flex_num) end;
end segments_description;


function reverse(p_text in varchar2, p_delimiter in varchar2) return varchar2 is
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


function clob_to_blob(p_clob in clob, p_charset_id in number default null) return blob is
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
      dbms_lob.createtemporary(l_blob,true,dbms_lob.call);
      dbms_lob.converttoblob(
      dest_lob=>l_blob,
      src_clob=>p_clob,
      amount=>l_amount,
      dest_offset=>l_dest_offset,
      src_offset=>l_src_offset,
      blob_csid=>nvl(p_charset_id,nls_charset_id('al32utf8')),
      lang_context=>l_lang_context,
      warning=>l_warning
      );
      return l_blob;
    end if;
  end if;
end clob_to_blob;


function blob_to_clob(p_blob in blob,p_charset_id in number default null) return clob is
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
      dbms_lob.createtemporary(l_clob,true,dbms_lob.call);
      dbms_lob.converttoclob(
      dest_lob=>l_clob,
      src_blob=>p_blob,
      amount=>l_amount,
      dest_offset=>l_dest_offset,
      src_offset=>l_src_offset,
      blob_csid=>nvl(p_charset_id,nls_charset_id('utf8')),
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


function add_newlines(p_clob in clob, p_line_length in pls_integer) return clob is
l_clob clob;
l_offset pls_integer:=1;
l_total_length pls_integer:=length(p_clob);
begin
  dbms_lob.createtemporary(l_clob,true,dbms_lob.call);
  while l_offset<=l_total_length loop
    dbms_lob.append(l_clob,replace(replace(substr(p_clob,l_offset,p_line_length),chr(10)),chr(13))||chr(10));
    l_offset:=l_offset+p_line_length;
  end loop;
  return l_clob;
end add_newlines;


function blob_to_base64(p_blob in blob) return clob is
l_platform_name v$database.platform_name%type;
l_file_size pls_integer:=dbms_lob.getlength(p_blob);
l_len pls_integer:=19200;
l_blob64 blob;
begin
  for c in (select platform_name from v$database) loop
    l_platform_name:=c.platform_name;
  end loop;
  dbms_lob.createtemporary(l_blob64,true,dbms_lob.call);
  for i in 0..trunc((l_file_size-1)/l_len) loop
    dbms_lob.append(l_blob64,utl_encode.base64_encode(dbms_lob.substr(p_blob,l_len,i*l_len+1)));
  end loop;
  if l_platform_name like '%Windows%' then --64decode utility from Windows MKS toolkit doesn't support long lines
    return blob_to_clob(l_blob64);
  else
    --By deafult utl_encode.base64_encode adds newlines after each 64 characters. It gives a performance overhead while writing the base64 output on the filesystem using sqlplus.
    --So removing newlines after each 64 characters and adding them after each 32767 characters which is sqlplus linesize limit.
    --Providing 33726 as a second parameter as it will become 32767 after all the newlines are removed
    return add_newlines(blob_to_clob(l_blob64),33726);
  end if;
end blob_to_base64;


function base64_to_blob(p_clob in clob) return blob is
l_file_size pls_integer;
l_clob clob;
l_len pls_integer:=19200;
l_blob64 blob;
begin
  l_clob:=replace(p_clob,chr(10));-- blob_to_base64 adds a new line after 32767 however to decode to blob we would need data without any newline.
  l_file_size:=dbms_lob.getlength(l_clob);
  dbms_lob.createtemporary(l_blob64,true,dbms_lob.call);
  for i in 0..trunc((l_file_size-1)/l_len) loop
    dbms_lob.append(l_blob64,utl_encode.base64_decode(utl_raw.cast_to_raw(dbms_lob.substr(l_clob,l_len,i*l_len+1))));
  end loop;
  return l_blob64;
end base64_to_blob;


function clob_lengthb(p_clob in clob) return number is
begin
  return dbms_lob.getlength(clob_to_blob(p_clob));
end clob_lengthb;


function clob_substrb(p_clob in clob, p_byte_length in pls_integer, p_char_position in pls_integer default 1) return clob is
begin
  return substrb(dbms_lob.substr(p_clob,p_byte_length,p_char_position),1,p_byte_length);
end clob_substrb;


function replace_first_occurrence(p_source in clob, p_search in clob, p_replacement in clob) return clob is
l_offset_before_template number;
l_offset_with_template number;
l_result clob;
begin
  if dbms_lob.getlength(p_search)>0 then
    l_offset_before_template:=dbms_lob.instr(p_source,p_search);
    l_offset_with_template:=l_offset_before_template+dbms_lob.getlength(p_search);
    l_result:= substr(p_source,1,l_offset_before_template-1)
    || p_replacement
    || substr(p_source,l_offset_with_template,dbms_lob.getlength(p_source)-l_offset_with_template+1);
    return l_result;
  else
    return p_source;
  end if;
  return p_source;
end replace_first_occurrence;


function clob_replace(p_source in clob, p_search in clob, p_replacement in clob) return clob is
l_result clob;
begin
  l_result:=p_source;
  if dbms_lob.getlength(p_search)>0 then
    loop
      if dbms_lob.instr(l_result,p_search)=0 then
        exit;
      end if;
      l_result:=replace_first_occurrence(l_result,p_search,p_replacement);
    end loop;
  else
    return p_source;
  end if;
  return l_result;
end clob_replace;


function instring(p_text in clob, p_separator in varchar2, p_occurrence in pls_integer) return varchar2 is
l_start pls_integer:=case when p_occurrence=1 then 1 else instr(p_text,p_separator,1,p_occurrence-1)+length(p_separator) end;
l_end pls_integer:=instr(p_text,p_separator,1,p_occurrence);
begin
  return trim(case when l_end>0 then substr(p_text,l_start,l_end-l_start) when p_occurrence=1 or instr(p_text,p_separator,1,p_occurrence-1)>0 then substr(p_text,l_start) end);
end instring;


function rowgen(p_rows in number) return fnd_table_of_number is
l_number_tbl fnd_table_of_number:=fnd_table_of_number();
begin
  for i in 1..nvl(p_rows,0) loop
    l_number_tbl.extend();
    l_number_tbl(i):=i;
  end loop;
  return l_number_tbl;
end rowgen;


function data_type(p_data_type in pls_integer) return varchar2 is
begin
  return case p_data_type
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
  else to_char(p_data_type) end;
end data_type;


function data_type_class(p_data_type in pls_integer) return varchar2 is
begin
  return case
  when p_data_type in (12, 178, 179, 180, 181, 231) then 'date'
  when p_data_type in (2, 100, 101) then 'number'
  when p_data_type in (8, 24, 112) then 'clob'
  when p_data_type=11 then 'rowid'
  else 'varchar2'
  end;
end data_type_class;


function sql_columns(p_sql in clob, p_skip_binding in varchar2 default null) return xxen_sql_desc_tab is
l_cursor pls_integer:=dbms_sql.open_cursor;
l_desc_tab dbms_sql.desc_tab3;
l_col_count pls_integer;
l_sql_desc_tab xxen_sql_desc_tab:=xxen_sql_desc_tab();
begin
  dbms_sql.parse(l_cursor, p_sql, dbms_sql.native);
  if p_skip_binding is null then
    for c in (select xrrbv.parameter_type, xrrbv.bind from xxen_report_run_bind_values xrrbv where xrrbv.parameter_type like 'Date%' or xrrbv.parameter_type='Number') loop
      begin
        if c.parameter_type='Number' then
          dbms_sql.bind_variable(l_cursor,c.bind,0);
        else
          dbms_sql.bind_variable(l_cursor,c.bind,sysdate);
        end if;
      exception
        when others then
          if sqlcode=-1006 then --bind variable does not exist
            null;
          else
            raise;
          end if;
      end;
    end loop;
  end if;
  dbms_sql.describe_columns3(l_cursor, l_col_count, l_desc_tab);
  dbms_sql.close_cursor(l_cursor);
  for c in 1..l_col_count loop
    l_sql_desc_tab.extend();
    l_sql_desc_tab(c):=xxen_sql_desc_rec(null,null,null,null,null,null,null);
    l_sql_desc_tab(c).column_id:=c;
    l_sql_desc_tab(c).column_name:=substrb(l_desc_tab(c).col_name,1,251);
    l_sql_desc_tab(c).data_type:=data_type(l_desc_tab(c).col_type);
    l_sql_desc_tab(c).data_type_class:=data_type_class(l_desc_tab(c).col_type);
    l_sql_desc_tab(c).data_length:=l_desc_tab(c).col_max_len;
    l_sql_desc_tab(c).data_precision:=case when l_desc_tab(c).col_precision>0 then l_desc_tab(c).col_precision end;
    l_sql_desc_tab(c).nullable:=case when l_desc_tab(c).col_null_ok then 'Y' else 'N' end;
  end loop;
  return l_sql_desc_tab;
exception
  when others then
    if dbms_sql.is_open(l_cursor) then
      dbms_sql.close_cursor(l_cursor);
    end if;
    l_sql_desc_tab.extend();
    l_sql_desc_tab(1):=xxen_sql_desc_rec(null,null,null,null,null,null,null);
    l_sql_desc_tab(1).column_name:='---- error ----';
    l_sql_desc_tab(1).data_type:=substrb(dbms_utility.format_error_stack,1,106);
    return l_sql_desc_tab;
end sql_columns;


function remove_empty_lines(p_clob in clob) return clob is
l_clob clob;
l_line_number pls_integer:=0;
l_offset pls_integer:=1;
l_line varchar2(32767);
l_line_length pls_integer;
l_total_length pls_integer:=length(p_clob);
begin
  dbms_lob.createtemporary(l_clob,true,dbms_lob.call);
  while l_offset<=l_total_length loop
    l_line_number:=l_line_number+1;
    l_line_length:=instr(p_clob,chr(10),l_offset)-l_offset;
    if l_line_length<0 then
      l_line_length:=l_total_length+1-l_offset;
    end if;
    l_line:=substr(p_clob,l_offset,l_line_length);
    if regexp_replace(l_line,'\s*') is not null then
      dbms_lob.append(l_clob,case when length(l_clob)>0 then chr(10) end||l_line);
    end if;
    l_offset:=l_offset+l_line_length+1;
  end loop;
  return l_clob;
end remove_empty_lines;


function html_to_text(p_html in clob, p_remove_empty_lines in varchar2 default null) return clob is
l_clob clob;
begin
  l_clob:=utl_i18n.unescape_reference( --Decode HTML-Entities
  regexp_replace(
  regexp_replace(
  regexp_replace(p_html,
  '<br\s*/?>',chr(10),1,0,'i'), --Replace line breaks
  '<p[^>]*>(.*?)</p>',chr(10)||'\1'||chr(10),1,0,'i'), --Remove paragraphs
  '<[^>]*>') --Remove all other HTML-Tags
  );
  if p_remove_empty_lines='Y' then
    return regexp_replace(l_clob,'(^\s*'||chr(10)||')|('||chr(10)||'\s*$)',null,1,0,'m'); --Remove all empty lines
  else
    return regexp_replace(l_clob,'(^\s*'||chr(10)||')|('||chr(10)||'\s*$)'); --Remove empty lines only from the start and end
  end if;
end html_to_text;


function zero_to_null(p_number in number) return number is
begin
  return case when p_number=0 then null else p_number end;
end;


function time(p_seconds in number) return varchar2 is
l_seconds number:=abs(p_seconds);
begin
  return case when p_seconds<0 then '-' end||case when l_seconds is not null then
  case when l_seconds>=86400 then trunc(l_seconds/86400)||'d ' end||
  case when l_seconds>=3600 then trunc(mod(l_seconds,86400)/3600)||'h ' end||
  case when l_seconds>=60 then trunc(mod(l_seconds,3600)/60)||'m ' end||
  trunc(mod(l_seconds,60))||'s'
  end;
end time;


function module_type(p_module in varchar2, p_action in varchar2 default null) return varchar2 result_cache is
l_module_type varchar2(260);
begin
  l_module_type:=
  case
  when regexp_like(p_module,'^e:\w+:cp:\w+/\w+$') then 'Concurrent Request'
  when regexp_like(p_module,'^e:\w*:(cp|gsm|GSM):\w+$') then 'Concurrent Manager'
  when regexp_like(p_module,'^e:\w+:frm:\w+$') then 'Form'
  when regexp_like(p_module,'^e:\w+:fwk:') then 'Oracle Application Framework'
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

function user_name(p_user_name in varchar2, p_sysdate in date, p_show_description in varchar2) return varchar2 result_cache is
l_user_name varchar2(342):=p_user_name;
begin
  if p_show_description='Y' then
    for c in (
    select
    ' ('||x.description||')' description
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
    where
    x.description is not null
    ) loop
      l_user_name:=l_user_name||c.description;
    end loop;
  end if;
  return l_user_name;
end user_name;

begin
  return user_name(p_user_name, trunc(sysdate), nvl(fnd_profile.value('XXEN_REPORT_SHOW_USER_DESCRIPTION'),'Y'));
end user_name;


function user_name(p_user_id in pls_integer, p_show_description in varchar2 default null) return varchar2 is

function user_name(p_user_id in pls_integer, p_sysdate in date, p_show_description in varchar2) return varchar2 result_cache is
l_user_name varchar2(342);
begin
  for c in (select fu.user_name from fnd_user fu where fu.user_id=p_user_id) loop
    l_user_name:=case when p_show_description='N' then c.user_name else xxen_util.user_name(c.user_name) end;
  end loop;
  return l_user_name;
end user_name;

begin
  return user_name(p_user_id, trunc(sysdate), nvl(p_show_description,fnd_profile.value('XXEN_REPORT_SHOW_USER_DESCRIPTION')));
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
    user_name(fcr.requested_by) user_name
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
  return meaning(translate(l_approval_status,'_',' '),
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
    l_status:=ap_invoice_status(p_invoice_id,c.invoice_amount,c.payment_status_flag,c.invoice_type_lookup_code,c.validation_request_id);
  end loop;
  return l_status;
end ap_invoice_status;


function wsh_next_step(
p_container_flag in wsh_delivery_details.container_flag%type,
p_released_status in wsh_delivery_details.released_status%type,
p_source_code in wsh_delivery_details.source_code%type,
p_inv_interfaced_flag in wsh_delivery_details.inv_interfaced_flag%type,
p_oe_interfaced_flag in wsh_delivery_details.oe_interfaced_flag%type,
p_client_id in number,
p_replenishment_status in varchar2,
p_move_order_line_id in wsh_delivery_details.move_order_line_id%type
) return varchar2 is
l_next_step fnd_lookup_values.meaning%type;
l_next_step_code varchar2(2);
begin
  if fnd_release.major_version=11 then
    l_next_step_code:=case
    when p_container_flag in ('Y','C') then 'NA'
    when p_released_status='C' then case when p_source_code='OE' and p_inv_interfaced_flag in ('X','Y') and (p_oe_interfaced_flag='Y' or p_oe_interfaced_flag='X') or p_source_code<>'OE' and p_oe_interfaced_flag in ('X','Y') then 'NA' else 'IT' end
    when p_released_status in ('B','R') then case when p_replenishment_status='R' then 'RC' else 'PR' end
    when p_released_status='S' then case when p_move_order_line_id is null then 'RX' else 'PC' end
    when p_released_status in ('X','Y') then 'SC'
    when p_released_status='D' then 'NA'
    when p_released_status='N' then 'PO'
    end;
  else
    execute immediate '
    begin
    :l_next_step_code:=case
    when :p_container_flag in (''Y'',''C'') then ''NA''
    when :p_released_status=''C'' then case when :p_source_code=''OE'' and :p_inv_interfaced_flag in (''X'',''Y'') and (:p_oe_interfaced_flag=''Y'' or :p_oe_interfaced_flag=''X'' and (wms_deploy.wms_deployment_mode=''D'' or wms_deploy.wms_deployment_mode=''L'' and :p_client_id is not null)) or :p_source_code<>''OE'' and :p_oe_interfaced_flag in (''X'',''Y'') then ''NA'' else ''IT'' end
    when :p_released_status in (''B'',''R'') then case when :p_replenishment_status=''R'' then ''RC'' else ''PR'' end
    when :p_released_status=''S'' then case when :p_move_order_line_id is null then ''RX'' else ''PC'' end
    when :p_released_status in (''X'',''Y'') then ''SC''
    when :p_released_status=''D'' then ''NA''
    when :p_released_status=''N'' then ''PO''
    end;
    end;
    ' using out l_next_step_code, p_container_flag, p_released_status, p_source_code, p_inv_interfaced_flag, p_oe_interfaced_flag, p_client_id, p_replenishment_status, p_move_order_line_id;
  end if;
  l_next_step:=meaning(l_next_step_code,'NEXT_STEP',665);
  return nvl(l_next_step,
  case l_next_step_code
  when 'IT' then 'Run Interfaces'
  when 'NA' then 'Not Applicable'
  when 'PC' then 'Transact Move Order'
  when 'PO' then 'Progress Order to Awaiting Shipping'
  when 'PR' then 'Pick Release'
  when 'RC' then 'Replenishment Complete'
  when 'RX' then 'Receive Crossdocked Supply'
  when 'SC' then 'Ship Confirm/Close Trip Stop'
  end
  );
end wsh_next_step;


function wsh_next_step(p_delivery_detail_id in number) return varchar2 is
type cur_type is ref cursor;
c_cur cur_type;
c_container_flag wsh_delivery_details.container_flag%type;
c_released_status wsh_delivery_details.released_status%type;
c_source_code wsh_delivery_details.source_code%type;
c_inv_interfaced_flag wsh_delivery_details.inv_interfaced_flag%type;
c_oe_interfaced_flag wsh_delivery_details.oe_interfaced_flag%type;
c_client_id number;
c_replenishment_status varchar2(1);
c_move_order_line_id wsh_delivery_details.move_order_line_id%type;
begin
  open c_cur for '
  select
  wdd.container_flag,
  wdd.released_status,
  wdd.source_code,
  wdd.inv_interfaced_flag,
  wdd.oe_interfaced_flag,
  '||case when fnd_release.major_version=11 then 'null' else 'wdd.client_id' end||',
  '||case when fnd_release.major_version=11 then 'null' else 'wdd.replenishment_status' end||',
  wdd.move_order_line_id
  from
  wsh_delivery_details wdd
  where
  wdd.delivery_detail_id=:p_delivery_detail_id
  ' using p_delivery_detail_id;
  loop
    fetch c_cur into
    c_container_flag,
    c_released_status,
    c_source_code,
    c_inv_interfaced_flag,
    c_oe_interfaced_flag,
    c_client_id,
    c_replenishment_status,
    c_move_order_line_id;
    exit when c_cur%notfound;
  end loop;
  close c_cur;

  return wsh_next_step(
  c_container_flag,
  c_released_status,
  c_source_code,
  c_inv_interfaced_flag,
  c_oe_interfaced_flag,
  c_client_id,
  c_replenishment_status,
  c_move_order_line_id
  );
end wsh_next_step;


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
  return nvl(l_application_name,meaning(upper(p_application_short_name),'XXEN_REPORT_APPLICATIONS',0));
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
  return case when p_application_name='Blitz Report' then 'Blitz' else nvl(application_short_name_trans(l_application_short_name),lookup_code(p_application_name,'XXEN_REPORT_APPLICATIONS',0)) end;
end application_short_name;


function dis_eul_usage_count(p_eul in varchar2) return number is
function dis_eul_usage_count_(p_eul in varchar2, p_lov_access_history_days in pls_integer) return number result_cache is
l_count number;
begin
  execute immediate '
  select
  count(*) count
  from
  v$database vd,
  '||p_eul||'.eul5_qpp_stats eqs
  where
  eqs.qs_created_date>=case when vd.created>sysdate-500 then vd.created else sysdate end-nvl(:p_lov_access_history_days,90)
  ' into l_count using p_lov_access_history_days;
  return l_count;
end dis_eul_usage_count_;
begin
  return dis_eul_usage_count_(p_eul, fnd_profile.value('XXEN_REPORT_DISCOVERER_IMPORT_LOV_ACCESS_HISTORY_DAYS'));
end dis_eul_usage_count;


function dis_business_area(p_obj_id in number, p_eul in varchar2) return varchar2 is
l_business_area varchar2(4000);
begin
  execute immediate '
  select distinct
  listagg(eb.ba_name,'', '') within group (order by eb.ba_name) over (partition by ebol.bol_obj_id) business_area
  from
  '||p_eul||'.eul5_ba_obj_links ebol,
  '||p_eul||'.eul5_bas eb
  where
  ebol.bol_obj_id=:p_obj_id and
  ebol.bol_ba_id=eb.ba_id
  ' into l_business_area using p_obj_id;
  return l_business_area;
end dis_business_area;


function dis_folder_type(p_obj_type in varchar2) return varchar2 deterministic is
begin
  return case p_obj_type when 'SOBJ' then 'Standard' when 'COBJ' then 'Complex view' when 'CUO' then 'Custom SQL' else p_obj_type end;
end dis_folder_type;


function dis_item_type(p_exp_type in varchar2) return varchar2 deterministic is
begin
  return case p_exp_type when 'FIL' then 'Condition' when 'CI' then 'Calculated Item' when 'CO' then 'Item' when 'JP' then 'Join Predicate' else p_exp_type end;
end dis_item_type;


function dis_default_eul return varchar2 is
l_default_eul varchar2(30):=fnd_profile.value('XXEN_REPORT_DISCOVERER_DEFAULT_EUL');
begin
  if l_default_eul is null then
    for c in (
    select distinct
    max(lower(ao.owner)) keep (dense_rank last order by dis_eul_usage_count(ao.owner),ao.created) over () default_eul
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


function dis_user(p_user_id in number, p_eul in varchar2) return varchar2 result_cache is
l_username varchar2(64);
begin
  execute immediate 'select eeu.eu_username from '||p_eul||'.eul5_eul_users eeu where eeu.eu_id=:p_user_id' into l_username using p_user_id;
  return l_username;
exception
  when no_data_found then
    return null;
end dis_user;


function dis_user_name(p_username in varchar2, p_show_description in varchar2 default null, p_eul in varchar2 default null) return varchar2 is

function dis_user_name_(p_username in varchar2, p_userenv_lang in varchar2, p_show_description in varchar2, p_eul in varchar2) return varchar2 result_cache is
l_user_name varchar2(342);
l_use_fnd_user boolean:=true;
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
    for d in (select null from xxen_discoverer_fnd_user xdfu where xdfu.eul=p_eul and rownum=1) loop --when running on Enginatics environments, use xxen_discoverer_fnd_user instead of fnd_user for workbook owner matching
      for c in (select xdfu.user_name from xxen_discoverer_fnd_user xdfu where xdfu.eul=p_eul and xdfu.user_id=to_number(substr(p_username,2))) loop
        l_user_name:=c.user_name;
      end loop;
      l_use_fnd_user:=false;
    end loop;
    if l_use_fnd_user then
      l_user_name:=user_name(to_number(substr(p_username,2)),p_show_description);
    end if;
  end if;
  return nvl(l_user_name,p_username);
end dis_user_name_;

begin
  return dis_user_name_(p_username, userenv('lang'), p_show_description, p_eul);
end dis_user_name;


function dis_user_name(p_user_id in number, p_eul in varchar2, p_show_description in varchar2 default null) return varchar2 result_cache is
begin
  return dis_user_name(dis_user(p_user_id, p_eul), p_show_description, p_eul);
end dis_user_name;


function dis_user_type(p_username in varchar2) return varchar2 result_cache is
begin
  return case
  when p_username like '#%#%' then 'Responsibility'
  when p_username like '#%' then 'User'
  else 'Database'
  end;
end dis_user_type;


function dis_user_type(p_user_id in number, p_eul in varchar2) return varchar2 result_cache is
begin
  return dis_user_type(dis_user(p_user_id, p_eul));
end dis_user_type;


function dis_folder_sql(p_object_id in number, p_eul in varchar2) return clob is
l_sql_chunk varchar2(32767);
l_text clob;
type cur_type is ref cursor;
l_cur cur_type;
begin
  open l_cur for 'select to_clob(eo.obj_object_sql1)||to_clob(eo.obj_object_sql2)||to_clob(eo.obj_object_sql3) sql_text from '||p_eul||'.eul5_objs eo where eo.obj_id=:p_object_id and eo.obj_object_sql1 is not null' using p_object_id;
  loop
    fetch l_cur into l_text;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  if l_text is null then
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
      l_text:=l_text||l_sql_chunk;
    end loop;
    close l_cur;
  end if;
  return replace(l_text,chr(13)||chr(10),chr(10));
end dis_folder_sql;


function dis_folder_sql2(p_object_id in number, p_eul in varchar2) return clob is
l_text clob:=dis_folder_sql(p_object_id, p_eul);
begin
  l_text:=regexp_replace(l_text,'^\( SELECT .+? FROM ');
  l_text:=regexp_replace(remove_empty_lines(regexp_replace(trim(substr(l_text,1,length(l_text)-1)),'(\W)CUO'||p_object_id||'($|\W)','\1o'||p_object_id||'\2')),'(^|\W)apps\.','\1',1,0,'i');
  l_text:=regexp_replace(l_text,'^\((( )*\w)','('||chr(10)||'\1');
  return l_text;
end dis_folder_sql2;


function dis_folder_sql3(p_object_id in number, p_eul in varchar2) return clob is
begin
  return 'select * from '||dis_folder_sql2(p_object_id, p_eul);
end dis_folder_sql3;


function dis_lov_query(p_exp_id in pls_integer, p_eul in varchar2) return clob is
type cur_type is ref cursor;
l_cur cur_type;
l_text clob;
c_object_id pls_integer;
c_obj_type varchar2(10);
c_sobj_ext_table varchar2(128);
c_new_alias varchar2(100);
c_column_name varchar2(4000);
l_query_length pls_integer;
begin
  if p_exp_id is not null then
    open l_cur for '
    select
    x.it_obj_id,
    x.obj_type,
    x.sobj_ext_table,
    x.alias||case when xxen_xdo.is_reserved_word(x.alias)=''Y'' then ''x'' end new_alias,
    x.column_name
    from
    (
    select
    ee.it_obj_id,
    eo.obj_type,
    lower(eo.owner||nvl2(eo.owner,''.'',null)||eo.sobj_ext_table||nvl2(eo.obj_ext_db_link,''@''||eo.obj_ext_db_link,null)) sobj_ext_table,
    lower(replace(regexp_replace(nvl(eo.sobj_ext_table,xxen_report.space_to_underscore(eo.obj_name)),''([^_]{1})[^_]*'',''\1''),''_'')) alias,
    case when ee.exp_type=''CO'' then ''o''||ee.it_obj_id||''.''||xxen_xdo.column_name(
    case when ee.it_ext_column like ''%#1'' and ee.it_ext_column=upper(ee.it_ext_column) then substr(ee.it_ext_column,1,length(ee.it_ext_column)-2) else ee.it_ext_column end
    ) else
    xxen_api.dis_formula_sql(ee.exp_id,:p_eul,''Y'')
    end column_name
    from
    '||p_eul||'.eul5_expressions ee,
    (select xxen_xdo.owner(eo.obj_ext_owner,eo.sobj_ext_table) owner, eo.* from '||p_eul||'.eul5_objs eo) eo
    where
    ee.exp_id=:p_exp_id and
    ee.it_obj_id=eo.obj_id
    ) x
    ' using p_eul, p_exp_id;
    loop
      fetch l_cur into c_object_id, c_obj_type, c_sobj_ext_table, c_new_alias, c_column_name;
      exit when l_cur%notfound;
    end loop;
    close l_cur;
    if c_obj_type='SOBJ' then --Standard (view or table)
      l_text:=c_sobj_ext_table||' o'||c_object_id;
    else --Custom SQL or Complex view
      l_text:=dis_folder_sql2(c_object_id, p_eul);
      l_query_length:=length(l_text);
      l_text:=remove_empty_lines(xxen_report.clear_text(
      p_text=>l_text,
      p_remove_comments=>case when l_query_length>32767 then 'all' else 'line' end,
      p_replace_strings=>false,
      p_remove_whitespace=>case when l_query_length>32767 then true else false end,
      p_lowercase=>true
      ));
    end if;
    l_text:='select distinct'||chr(10)||c_column_name||' value,'||chr(10)||'null description'||chr(10)||'from'||chr(10)||l_text||chr(10)||'order by'||chr(10)||'value';
  end if;
  return replace(l_text,'o'||c_object_id,c_new_alias);
end dis_lov_query;


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


function dis_worksheet_exists(p_eul in varchar2) return varchar2 is
l_result varchar2(1);
type cur_type is ref cursor;
c_cur cur_type;
begin
  open c_cur for '
  select
  ''Y''
  from
  ams_discoverer_sql ads,
  '||p_eul||'.eul5_documents ed
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


function dis_folder_exists(p_eul varchar2) return varchar2 is
l_result varchar2(1);
type cur_type is ref cursor;
c_cur cur_type;
begin
  open c_cur for '
  select
  ''Y''
  from
  '||p_eul||'.eul5_qpp_stats eqs
  where
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
end dis_folder_exists;


function dis_qs_exp_ids(p_qs_id in number, p_eul in varchar2, p_type in varchar2 default null) return clob is
itmid clob;
startpt binary_integer:=1;
bmp long raw;
pos binary_integer:=0;
hexstring varchar2(10);
hexid binary_integer:=0;
decnibble1 number;
decnibble2 binary_integer;
decnibble3 binary_integer;
decnibble4 binary_integer;
decnibble5 binary_integer;
decnibble6 binary_integer;
decnibble7 binary_integer;
decnibble8 binary_integer;
decnibble9 binary_integer;
decnibble10 binary_integer;
hexchar varchar2(1);
expid number;
nibblezero boolean;
type it_type is table of varchar2(1);
itype it_type:=it_type('D','M','J','F');  --dimensions, measures, joins, filters
-- occasionally, due to a bug, the first 5 bytes of the string are not always populated with id of
-- the item so rather than go all the way down the string looking a every 5 bytes until it reaches
-- the end (a slow process) i count the number of empy stings i have found so far and when it
-- reaches the the value held in 'noemptyblocks'  it moves on to the next string
noemptyblks binary_integer:=10;
begin
  for i in 1..4 loop --loop through dimensions, measures, joins, filters
    if p_type is null or p_type='items' and i in (1,2) or p_type='joins' and i=3 or p_type='filters' and i=4 then
      hexid:=0;

      if i=1 then
        execute immediate 'select eqs.qs_dbmp0||eqs.qs_dbmp1||eqs.qs_dbmp2||eqs.qs_dbmp3||eqs.qs_dbmp4||eqs.qs_dbmp5||eqs.qs_dbmp6||eqs.qs_dbmp7 from '||p_eul||'.eul5_qpp_stats eqs where eqs.qs_id=:p_qs_id' into bmp using p_qs_id;
      elsif i=2 then
        execute immediate 'select eqs.qs_mbmp0||eqs.qs_mbmp1||eqs.qs_mbmp2||eqs.qs_mbmp3||eqs.qs_mbmp4||eqs.qs_mbmp5||eqs.qs_mbmp6||eqs.qs_mbmp7 from '||p_eul||'.eul5_qpp_stats eqs where eqs.qs_id=:p_qs_id' into bmp using p_qs_id;
      elsif i=3 then
        execute immediate 'select eqs.qs_jbmp0||eqs.qs_jbmp1||eqs.qs_jbmp2||eqs.qs_jbmp3||eqs.qs_jbmp4||eqs.qs_jbmp5||eqs.qs_jbmp6||eqs.qs_jbmp7 from '||p_eul||'.eul5_qpp_stats eqs where eqs.qs_id=:p_qs_id' into bmp using p_qs_id;
      else
        execute immediate 'select eqs.qs_fbmp0||eqs.qs_fbmp1||eqs.qs_fbmp2||eqs.qs_fbmp3||eqs.qs_fbmp4||eqs.qs_fbmp5||eqs.qs_fbmp6||eqs.qs_fbmp7 from '||p_eul||'.eul5_qpp_stats eqs where eqs.qs_id=:p_qs_id' into bmp using p_qs_id;
      end if;

      -- this bit takes a five byte chunk in the string.
      -- it then loops until it reaches the end of the string or it find no more values
      while hexid<>noemptyblks loop
        pos:=pos+10;
        if pos=4090 then
          hexid:=noemptyblks;
          startpt:=1;
          pos:=0;
        else
          hexstring:=nvl(substr(rawtohex(bmp),startpt,10),'0000000000');
          if hexstring='0000000000' then
            hexid:=hexid+1;
            decnibble1:=0;
            decnibble2:=0;
            decnibble3:=0;
            decnibble4:=0;
            decnibble5:=0;
            decnibble6:=0;
            decnibble7:=0;
            decnibble8:=0;
            decnibble9:=0;
            decnibble10:=0;
            nibblezero:=true;
            if hexid=noemptyblks then
              startpt:=1;
              pos:=0;
            end if;
          else -- converts hex nibble into decimal value.
            nibblezero:=false;
            hexchar:=substr(rawtohex(bmp),startpt,1);
            if hexchar='0' then decnibble1:=0;
            elsif hexchar='A' then decnibble1:=10;
            elsif hexchar='B' then decnibble1:=11;
            elsif hexchar='C' then decnibble1:=12;
            elsif hexchar='D' then decnibble1:=13;
            elsif hexchar='E' then decnibble1:=14;
            elsif hexchar='F' then decnibble1:=15;
            else decnibble1:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+1,1);
            if hexchar='0' then decnibble2:=0;
            elsif hexchar='A' then decnibble2:=10;
            elsif hexchar='B' then decnibble2:=11;
            elsif hexchar='C' then decnibble2:=12;
            elsif hexchar='D' then decnibble2:=13;
            elsif hexchar='E' then decnibble2:=14;
            elsif hexchar='F' then decnibble2:=15;
            else decnibble2:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+2,1);
            if hexchar='0' then decnibble3:=0;
            elsif hexchar='A' then decnibble3:=10;
            elsif hexchar='B' then decnibble3:=11;
            elsif hexchar='C' then decnibble3:=12;
            elsif hexchar='D' then decnibble3:=13;
            elsif hexchar='E' then decnibble3:=14;
            elsif hexchar='F' then decnibble3:=15;
            else decnibble3:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+3,1);
            if hexchar='0' then decnibble4:=0;
            elsif  hexchar='A' then decnibble4:=10;
            elsif hexchar='B' then decnibble4:=11;
            elsif hexchar='C' then decnibble4:=12;
            elsif hexchar='D' then decnibble4:=13;
            elsif hexchar='E' then decnibble4:=14;
            elsif hexchar='F' then decnibble4:=15;
            else decnibble4:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+4,1);
            if hexchar='0' then decnibble5:=0;
            elsif hexchar='A' then decnibble5:=10;
            elsif hexchar='B' then decnibble5:=11;
            elsif hexchar='C' then decnibble5:=12;
            elsif hexchar='D' then decnibble5:=13;
            elsif hexchar='E' then decnibble5:=14;
            elsif hexchar='F' then decnibble5:=15;
            else decnibble5:=to_number(hexchar );
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+5,1);
            if hexchar='0' then decnibble6:=0;
            elsif hexchar='A' then decnibble6:=10;
            elsif hexchar='B' then decnibble6:=11;
            elsif hexchar='C' then decnibble6:=12;
            elsif hexchar='D' then decnibble6:=13;
            elsif hexchar='E' then decnibble6:=14;
            elsif hexchar='F' then decnibble6:=15;
            else decnibble6:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+6,1);
            if hexchar='0' then decnibble7:=0;
            elsif hexchar='A' then decnibble7:=10;
            elsif hexchar='B' then decnibble7:=11;
            elsif hexchar='C' then decnibble7:=12;
            elsif hexchar='D' then decnibble7:=13;
            elsif hexchar='E' then decnibble7:=14;
            elsif hexchar='F' then decnibble7:=15;
            else decnibble7:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+7,1);
            if hexchar='0' then decnibble8:=0;
            elsif hexchar='A' then decnibble8:=10;
            elsif hexchar='B' then decnibble8:=11;
            elsif hexchar='C' then decnibble8:=12;
            elsif hexchar='D' then decnibble8:=13;
            elsif hexchar='E' then decnibble8:=14;
            elsif hexchar='F' then decnibble8:=15;
            else decnibble8:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+8,1);
            if hexchar='0' then decnibble9:=0;
            elsif hexchar='A' then decnibble9:=10;
            elsif hexchar='B' then decnibble9:=11;
            elsif hexchar='C' then decnibble9:=12;
            elsif hexchar='D' then decnibble9:=13;
            elsif hexchar='E' then decnibble9:=14;
            elsif hexchar='F' then decnibble9:=15;
            else decnibble9:=to_number(hexchar);
            end if;
            hexchar:=substr(rawtohex(bmp),startpt+9,1);
            if hexchar='0' then decnibble10:=0;
            elsif hexchar='A' then decnibble10:=10;
            elsif hexchar='B' then decnibble10:=11;
            elsif hexchar='C' then decnibble10:=12;
            elsif hexchar='D' then decnibble10:=13;
            elsif hexchar='E' then decnibble10:=14;
            elsif hexchar='F' then decnibble10:=15;
            else decnibble10:=to_number(hexchar);
            end if;

            -- off set the nibble by one byte, then calculate the item id
            if nibblezero=false then
              decnibble1:=decnibble1*2;
              if decnibble2>7 then
                decnibble1:=decnibble1+1;
                decnibble2:=decnibble2-8;
              end if;
              decnibble1:=decnibble1*268435456;
              decnibble2:=decnibble2*2;
              if decnibble3>7 then
                decnibble2:=decnibble2+1;
                decnibble3:=decnibble3-8;
              end if;
              decnibble2:=decnibble2*16777216;
              decnibble3:=decnibble3*2;
              if decnibble4>7 then
                decnibble3:=decnibble3+1;
                decnibble4:=decnibble4-8;
              end if;
              decnibble3:=decnibble3*1048576;
              decnibble4:=decnibble4*2;
              if decnibble5>7 then
                decnibble4:=decnibble4+1;
                decnibble5:=decnibble5-8;
              end if;
              decnibble4:=decnibble4*65536;
              decnibble5:=decnibble5*2;
              if decnibble6>7 then
                decnibble5:=decnibble5+1;
                decnibble6:=decnibble6-8;
              end if;
              decnibble5:=decnibble5*4096;
              decnibble6:=decnibble6*2;
              if decnibble7>7 then
                decnibble6:=decnibble6+1;
                decnibble7:=decnibble7-8;
              end if;
              decnibble6:=decnibble6*256;
              decnibble7:=decnibble7*2;
              if decnibble8>7 then
                decnibble7:=decnibble7+1;
                decnibble8:=decnibble8-8;
              end if;
              decnibble7:=decnibble7*16;
              decnibble8:=decnibble8*2;
              if decnibble9>7 then
                decnibble8:=decnibble8+1;
                decnibble9:=decnibble9-8;
              end if;
              if decnibble9>0 then
                decnibble9:=(decnibble9-2)*8;
              end if;
              decnibble10:=decnibble9+(decnibble10/2);
              expid:=decnibble1+decnibble2+decnibble3+decnibble4+decnibble5+decnibble6+decnibble7+decnibble8;
            end if;
          end if;
        end if;
        startpt:=pos+1;
        if nibblezero=false then
          itmid:=itmid||case when p_type is null then itype(i) end||expid||',';
        end if;
      end loop;
    end if;
  end loop;
  return itmid;
end dis_qs_exp_ids;


function dis_obj_type(p_obj_id in varchar2, p_eul in varchar2) return varchar2 result_cache is
type cur_type is ref cursor;
l_cur cur_type;
c_obj_type varchar2(10);
begin
  open l_cur for 'select eo.obj_type from '||p_eul||'.eul5_objs eo where eo.obj_id=:p_obj_id' using p_obj_id;
  loop
    fetch l_cur into c_obj_type;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  return c_obj_type;
end dis_obj_type;


function dis_obj_id(p_object_key in varchar2, p_eul in varchar2) return number result_cache is
type cur_type is ref cursor;
l_cur cur_type;
c_obj_id number;
begin
  open l_cur for 'select eo.obj_id from '||p_eul||'.eul5_objs eo where eo.obj_developer_key=:p_object_key' using p_object_key;
  loop
    fetch l_cur into c_obj_id;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  return c_obj_id;
end dis_obj_id;


function dis_exp_id(p_object_key in varchar2, p_item_name in varchar2, p_eul in varchar2) return pls_integer result_cache is
type cur_type is ref cursor;
l_cur cur_type;
c_exp_id pls_integer;
begin
  open l_cur for 'select ee.exp_id from '||p_eul||'.eul5_objs eo, '||p_eul||'.eul5_expressions ee where eo.obj_developer_key=:p_object_key and eo.obj_id=ee.it_obj_id and ee.exp_name=:p_item_name' using p_object_key, p_item_name;
  loop
    fetch l_cur into c_exp_id;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  return c_exp_id;
end dis_exp_id;


function dis_exp_data_type(p_object_key in varchar2, p_item_name in varchar2, p_eul in varchar2) return varchar2 result_cache is
type cur_type is ref cursor;
l_cur cur_type;
c_data_type varchar2(6);
begin
  open l_cur for 'select decode(ee.exp_data_type,2,''Number'',4,''Date'',''Char'') data_type from '||p_eul||'.eul5_objs eo, '||p_eul||'.eul5_expressions ee where eo.obj_developer_key=:p_object_key and eo.obj_id=ee.it_obj_id and ee.exp_name=:p_item_name' using p_object_key, p_item_name;
  loop
    fetch l_cur into c_data_type;
    exit when l_cur%notfound;
  end loop;
  close l_cur;
  return c_data_type;
end dis_exp_data_type;


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


function geolocation(p_service_url in varchar2, p_ip_address in varchar2, p_path in varchar2, p_wallet_path in varchar2 default null) return varchar2 result_cache is
l_text varchar2(32767);
l_value varchar2(100);
function http_response(p_url in varchar2, p_wallet_path in varchar2) return varchar2 result_cache is
l_http_request utl_http.req;
l_http_response utl_http.resp;
l_text0 varchar2(32767);
begin
  utl_http.set_body_charset('UTF-8');
  if p_wallet_path is not null then --If using HTTPS, open the wallet with the trusted root certificate.
    utl_http.set_wallet('file:'||p_wallet_path); --Setting a path for a wallet containing geolocation API site root certificate
  end if;
  l_http_request:=utl_http.begin_request(p_url); --Make a HTTP request and get the response
  l_http_response:=utl_http.get_response(l_http_request);
  loop --Loop through the response and get the geolocation information
    utl_http.read_text(l_http_response,l_text0,32766);
    l_text:=l_text0;
  end loop;
exception --The above request ends in an exception once it finishes reading all the information
  when utl_http.end_of_body then --So when it occurs, just return the obtained information
    utl_http.end_response(l_http_response);
    return l_text;
end http_response;
begin
  if p_ip_address is not null then
    l_text:=http_response(p_service_url||p_ip_address, p_wallet_path);
    if l_text like '<%' then
      execute immediate 'select x.value from xmltable('''||substr(p_path,1,instr(p_path,'/',-1)-1)||''' passing xmltype(:l_text) columns value varchar2(100) path '''||substr(p_path,instr(p_path,'/',-1)+1)||''') x where rownum=1'
      into l_value using l_text;
    elsif l_text like '{%' then
      execute immediate 'select x.* from json_table(:l_text,''$'' columns ('||p_path||' varchar2(4000))) x where rownum=1'
      into l_value using l_text;
    end if;
  end if;
  return l_value;
end geolocation;


function parameter_value(p_parameter_name in varchar2 default null, p_parameter_bind in varchar2 default null) return varchar2 is
l_value varchar2(32767);
begin
  for c in (
  select
  dbms_lob.substr(clob_substrb(xrrpv.value,4000,1)) value
  from
  xxen_report_runs xrr,
  xxen_report_run_param_values xrrpv,
  xxen_report_parameters xrp,
  xxen_report_parameters_tl xrpt
  where
  xrr.request_id=fnd_global.conc_request_id and
  xrr.run_id=xrrpv.run_id and
  xrrpv.parameter_id=xrp.parameter_id and
  xrrpv.parameter_id=xrpt.parameter_id and
  xrpt.language='US' and
  (xrpt.parameter_name=p_parameter_name or xxen_api.bindvar_name(xrp.parameter_id)=':'||p_parameter_bind)
  order by
  value
  ) loop
    l_value:=case when l_value not like '<multiple_values>%' then '<multiple_values>' end||l_value||case when l_value is not null then ';' end||c.value;
  end loop;
  return l_value;
end parameter_value;


function orig_order_line_id(p_split_from_line_id in number) return number is
l_orig_line_id number;
begin
  for c in (
  select
  decode(connect_by_isleaf,1,oola2.line_id) orig_line_id
  from
  oe_order_lines_all oola2
  where
  decode(connect_by_isleaf,1,oola2.line_id) is not null
  connect by prior oola2.split_from_line_id=oola2.line_id
  start with p_split_from_line_id=oola2.line_id
  ) loop
    l_orig_line_id:=c.orig_line_id;
  end loop;
  return l_orig_line_id;
end orig_order_line_id;


function default_ledger return varchar2 is
l_result varchar2(30);
type cur_type is ref cursor;
c_cur cur_type;
begin
  open c_cur for '
  select
  z.name
  from
  (
  select
  y.*,
  count(*) over () count
  from
  (
  select
  x.*,
  min(x.priority) over () min_priority
  from
  (
  select
  gl.name,
  decode(gl.ledger_category_code,''PRIMARY'',1,''SECONDARY'',2,''ALC'',3,''NONE'',4) priority
  from
  '||case when fnd_release.major_version=11 then 'xxen_gl_ledgers_v gl
  where
  (xxen_util.default_operating_unit is null or gl.set_of_books_id=(select hou.set_of_books_id from hr_operating_units hou where hou.name=xxen_util.default_operating_unit)) and
  gl.ledger_id in (select nvl(glsnav.set_of_books_id,gasna.set_of_books_id) from xxen_gl_access_set_norm_ass_v gasna, (select null ledger_set_id, null set_of_books_id from dual) glsnav where gasna.access_set_id=fnd_profile.value(''GL_ACCESS_SET_ID'') and gasna.ledger_id=glsnav.ledger_set_id(+))'
  else 'gl_ledgers gl
  where
  (xxen_util.default_operating_unit is null or gl.ledger_id=(select hou.set_of_books_id from hr_operating_units hou where hou.name=xxen_util.default_operating_unit)) and
  gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value(''GL_ACCESS_SET_ID'') and gasna.ledger_id=glsnav.ledger_set_id(+))'
  end||'
  ) x
  ) y
  where
  y.priority=y.min_priority
  ) z
  where
  z.count=1';
  loop
    fetch c_cur into l_result;
    exit when c_cur%notfound;
  end loop;
  close c_cur;
  return l_result;
end default_ledger;


function default_operating_unit return varchar2 is
begin
  for c in (
  select
  x.name
  from
  (
  select
  count(*) over () count,
  hou.name
  from
  hr_operating_units hou
  where
  sysdate between hou.date_from and nvl(hou.date_to,sysdate) and
  hou.organization_id in (
  select mgoat.organization_id from mo_glob_org_access_tmp mgoat where mgoat.organization_id=nvl(fnd_profile.value('DEFAULT_ORG_ID'),mgoat.organization_id) union
  select fnd_global.org_id from dual where fnd_release.major_version=11
  )
  ) x
  where
  x.count=1
  ) loop
    return c.name;
  end loop;
  return null;
end default_operating_unit;


function previous_parameter_value(p_parameter_id in pls_integer) return varchar2 is
begin
  for c in (
  select
  dbms_lob.substr(xxen_util.clob_substrb(xrrpv.value,4000,1)) value
  from
  (
  select
  max(xrr.run_id) run_id
  from
  xxen_report_parameters xrp,
  xxen_report_runs xrr
  where
  xrp.parameter_id=p_parameter_id and
  xrp.report_id=xrr.report_id and
  xrr.responsibility_application_id=fnd_global.resp_appl_id and
  xrr.responsibility_id=fnd_global.resp_id and
  xrr.created_by=fnd_global.user_id and
  xrr.creation_date>sysdate-60
  ) xrr,
  xxen_report_run_param_values xrrpv
  where
  xrr.run_id=xrrpv.run_id and
  xrrpv.parameter_id=p_parameter_id
  ) loop
    return c.value;
  end loop;
  return null;
end previous_parameter_value;


function dff_columns(
p_table_name in varchar2,
p_table_alias in varchar2 default null,
p_descr_flex_context_code in varchar2 default null,
p_column_name_prefix in varchar2 default null,
p_prefix in varchar2 default null,
p_hide_column_name in varchar2 default null,
p_row_id in varchar2 default null
) return clob is
l_value_text varchar2(32767);
l_text clob;
begin
  for c in (
  select
  rownum,
  u.*
  from
  (
  select
  z.context_column_,
  case when z.is_case='Y' and z.sort_order=min(z.sort_order) over (partition by z.name_text) then 'case ' end||
  z.value_text||
  case when z.is_case='Y' and z.sort_order=max(z.sort_order) over (partition by z.name_text) then 'end ' end value_text,
  case when z.sort_order=max(z.sort_order) over (partition by z.name_text) then name_text end name_text
  from
  (
  select distinct
  nvl(p_prefix,case when p_hide_column_name='Y' then y.context_column else '(select fdfcv.descriptive_flex_context_name from fnd_descr_flex_contexts_vl fdfcv where '||y.context_column||'=fdfcv.descriptive_flex_context_code and fdfcv.application_id='||y.application_id||' and fdfcv.descriptive_flexfield_name='''||y.descriptive_flexfield_name||''')' end||' ')||case when nvl(p_hide_column_name,'N')='N' then '"'||substrb(p_column_name_prefix||'DFF Context',1,xxen_report.max_column_length)||'"' end||','||chr(10) context_column_,
  nvl2(y.descriptive_flex_context_code,
  'when '||y.context_column||case
  when count(distinct y.descriptive_flex_context_code) over (partition by y.form_left_prompt__,y.value_text)>1 then ' in ('||listagg(''''||y.descriptive_flex_context_code||'''',',') within group (order by y.descriptive_flex_context_code) over (partition by y.form_left_prompt__,y.value_text)||')'
  else '='''||y.descriptive_flex_context_code||''''
  end||' then ',
  nvl2(y.is_case,'else ',null))
  ||y.value_text||' ' value_text,
  y.form_left_prompt__ name_text,
  min(y.sort_order) over (partition by y.form_left_prompt__,y.value_text) sort_order,
  y.is_case
  from
  (
  select
  decode(x.has_lov,'Y','xxen_util.display_flexfield_value('||x.application_id||','''||x.descriptive_flexfield_name||''',nvl('||x.table_alias||x.context_column_name||',''Global Data Elements''),'''||x.application_column_name||''','||x.table_alias||nvl(p_row_id,'rowid')||',')
  ||x.table_alias||lower(x.application_column_name)||
  decode(x.has_lov,'Y',')') value_text,
  x.table_alias,
  row_number() over (order by
  case when x.descriptive_flex_context_count>1 then 1 else 2 end,
  case when x.descriptive_flex_context_count>1 then x.min_column_seq_num end,
  case when x.descriptive_flex_context_count>1 then x.form_left_prompt__ end,
  case when x.descriptive_flex_context_count>1 then x.descriptive_flex_context_code end,
  x.descriptive_flex_context_code nulls first,
  x.column_seq_num) sort_order,
  x.application_id,
  x.descriptive_flexfield_name,
  x.table_alias||x.context_column_name context_column,
  x.descriptive_flex_context_code,
  x.has_lov,
  x.application_column_name,
  x.form_left_prompt__,
  x.is_case
  from
  (
  select
  nvl(p_table_alias,replace(regexp_replace(p_table_name,'([^_]{1})[^_]*','\1'),'_'))||'.' table_alias,
  fdfcuv.application_id,
  fdfcuv.descriptive_flexfield_name,
  lower(fdf.context_column_name) context_column_name,
  case when fdfcuv.descriptive_flex_context_code<>'Global Data Elements' then replace(fdfc.descriptive_flex_context_code,'''','''''') end descriptive_flex_context_code,
  count(distinct fdfc.descriptive_flex_context_code) over (partition by fdfcuv.form_left_prompt__) descriptive_flex_context_count,
  min(fdfcuv.column_seq_num) over (partition by fdfcuv.form_left_prompt__) min_column_seq_num,
  case when ffvs.validation_type in ('D','I','X','Y','F') then 'Y' end has_lov,
  fdfcuv.column_seq_num,
  fdfcuv.application_column_name,
  fdfcuv.form_left_prompt__,
  case when count(*) over (partition by fdfcuv.form_left_prompt__)>1 or fdfcuv.descriptive_flex_context_code<>'Global Data Elements' then 'Y' end is_case
  from
  fnd_descriptive_flexs fdf,
  fnd_descr_flex_contexts fdfc,
  (
  select
  xxen_xdo.column_name(
  case
  when fdfcuv.row_count=1 then fdfcuv.form_left_prompt_
  else substrb(fdfcuv.form_left_prompt_,1,xxen_report.max_column_length-length(fdfcuv.row_count))||fdfcuv.row_number
  end) form_left_prompt__,
  fdfcuv.*
  from
  (
  select
  row_number() over (partition by fdfcuv.application_id,fdfcuv.descriptive_flexfield_name,fdfcuv.descriptive_flex_context_code,fdfcuv.form_left_prompt_ order by fdfcuv.column_seq_num) row_number,
      count(*) over (partition by fdfcuv.application_id,fdfcuv.descriptive_flexfield_name,fdfcuv.descriptive_flex_context_code,fdfcuv.form_left_prompt_) row_count,
  fdfcuv.*
  from
  (
  select
  substrb(xxen_util.init_cap(replace(p_column_name_prefix||fdfcuv.form_left_prompt,'"')),1,xxen_report.max_column_length) form_left_prompt_,
  fdfcuv.*
  from
  fnd_descr_flex_col_usage_vl fdfcuv
  where
  fdfcuv.application_column_name like 'ATTRIBUTE%' and
  fdfcuv.enabled_flag='Y' and
  fdfcuv.display_flag='Y'
  ) fdfcuv
  ) fdfcuv
  ) fdfcuv,
  fnd_flex_value_sets ffvs
  where
  fdf.application_table_name=upper(p_table_name) and
  (nvl(p_descr_flex_context_code,'All')='All' or fdfc.descriptive_flex_context_code=p_descr_flex_context_code) and
  fdf.application_id=fdfc.application_id and
  fdf.descriptive_flexfield_name=fdfc.descriptive_flexfield_name and
  fdfc.enabled_flag='Y' and
  fdfc.application_id=fdfcuv.application_id and
  fdfc.descriptive_flexfield_name=fdfcuv.descriptive_flexfield_name and
  fdfc.descriptive_flex_context_code=fdfcuv.descriptive_flex_context_code and
  fdfcuv.flex_value_set_id=ffvs.flex_value_set_id(+)
  ) x
  ) y
  order by sort_order
  ) z
  order by
  z.sort_order
  ) u
  where
  p_prefix is null or u.name_text is not null
  ) loop
    if c.rownum=1 then
      l_text:=c.context_column_;
    end if;
    l_value_text:=l_value_text||nvl(p_prefix,c.value_text);
    if c.name_text is not null then
      l_text:=rtrim(l_text||l_value_text||case when nvl(p_hide_column_name,'N')='N' then c.name_text end)||','||chr(10);
      l_value_text:=null;
    end if;
  end loop;
  return l_text;
end dff_columns;


function item_category_columns(p_category_set_name in varchar2, p_table_alias in varchar2 default 'msiv', p_item_id_column in varchar2 default 'inventory_item_id', p_org_id_column in varchar2 default 'organization_id') return clob is
l_text clob;
begin
  for c in (
  select x.* from (
  select
  '(select min(mcb.'||lower(fifsv.application_column_name)||') keep (dense_rank first order by mic.category_id) from mtl_item_categories mic, mtl_categories_b mcb where mic.category_set_id='||mcsv.category_set_id||' and '||p_table_alias||'.'||p_org_id_column||'=mic.organization_id and '||p_table_alias||'.'||p_item_id_column||'=mic.inventory_item_id and mic.category_id=mcb.category_id) "'||substrb(fifsv.form_left_prompt_,1,xxen_report.max_column_length)||'",' sql_text
  from
  mtl_category_sets_vl mcsv,
  (select xxen_util.init_cap(fifsv.form_left_prompt) form_left_prompt_, fifsv.* from fnd_id_flex_segments_vl fifsv) fifsv
  where
  mcsv.category_set_name=p_category_set_name and
  mcsv.structure_id=fifsv.id_flex_num and
  fifsv.application_id=401 and
  fifsv.id_flex_code='MCAT' and
  fifsv.enabled_flag='Y'
  order by
  fifsv.id_flex_num,
  fifsv.segment_num
  ) x
  union all
  select
  '(select min(mct.description) keep (dense_rank first order by mic.category_id) from mtl_item_categories mic, mtl_categories_tl mct where mic.category_set_id='||mcsv.category_set_id||' and '||p_table_alias||'.'||p_org_id_column||'=mic.organization_id and '||p_table_alias||'.'||p_item_id_column||'=mic.inventory_item_id and mic.category_id=mct.category_id and mct.language=userenv(''lang'')) "'||substrb(mcsv.category_set_name||' '||xxen_report.parameter_translation('Description'),1,xxen_report.max_column_length)||'",' sql_text
  from
  mtl_category_sets_vl mcsv
  where
  mcsv.category_set_name=p_category_set_name
  ) loop
    l_text:=l_text||case when l_text is not null then chr(10) end||c.sql_text;
  end loop;
  return l_text;
end item_category_columns;


function wait_for_request(p_conc_request_id in number, x_status out varchar2, x_message out varchar2) return varchar2 is
  l_phase varchar2(50);
  l_dev_status varchar2(50);
  l_dev_phase varchar2(50);
  l_req_return_status boolean;
begin
  l_req_return_status:=fnd_concurrent.wait_for_request(
  request_id=>p_conc_request_id,
  interval =>0.5,
  phase=>l_phase,
  status=>x_status,
  dev_phase=>l_dev_phase,
  dev_status=>l_dev_status,
  message=>x_message
  );
  if l_dev_phase='COMPLETE' and l_dev_status in ('NORMAL','WARNING') then
    return 'Success';
  else
    return 'Error';
  end if;
end wait_for_request;


function functional_currency_code(p_ledger_name in varchar2) return varchar2 is
l_functional_currency_code varchar2(15);
begin
  if fnd_release.major_version=11 then
    return null;
  else
    execute immediate 'select gl.currency_code from gl_ledgers gl where gl.name=:p_ledger_name' into l_functional_currency_code using p_ledger_name;
    return l_functional_currency_code;
  end if;
end functional_currency_code;


function latest_open_period(p_ledger_name in varchar2) return varchar2 is
l_latest_open_period varchar2(15);
begin
  if fnd_release.major_version=11 then
    return null;
  else
    execute immediate '
    select
    max(gps.period_name) keep (dense_rank last order by gps.effective_period_num) period_name
    from
    gl_period_statuses gps
    where
    gps.ledger_id=(select gl.ledger_id from gl_ledgers gl where gl.name=:p_ledger_name) and
    gps.application_id=101 and
    gps.closing_status in (''P'',''C'',''O'')' into l_latest_open_period using p_ledger_name;
    return l_latest_open_period;
  end if;
end latest_open_period;


function segment_name(p_ledger_name in varchar2, p_segment_prop_value in varchar2, p_segment_num in number) return varchar2 is
l_segment_name varchar2(30);
begin
  if fnd_release.major_version=11 then
    return null;
  else
    execute immediate '
    select * from (
    select
    fifsv.form_left_prompt||'' (''||fifsv.segment_num||'')'' segment_name
    from
    fnd_id_flex_segments_vl fifsv
    where
    fifsv.application_id=101 and
    fifsv.id_flex_code=''GL#'' and
    fifsv.form_left_prompt||'' (''||fifsv.segment_num||'')''=:p_segment_prop_value and
    fifsv.id_flex_num in (select gl.chart_of_accounts_id from gl_ledgers gl where gl.name=:p_ledger_name and gl.ledger_category_code=''PRIMARY'' and gl.object_type_code=''L'' and gl.complete_flag=''Y'')
    union
    select
    fifsv.form_left_prompt||'' (''||fifsv.segment_num||'')'' segment_name
    from
    fnd_id_flex_segments_vl fifsv
    where
    fifsv.application_id=101 and
    fifsv.id_flex_code=''GL#'' and
    fifsv.segment_num=:p_segment_num and
    fifsv.id_flex_num in (select gl.chart_of_accounts_id from gl_ledgers gl where gl.name=:p_ledger_name and gl.ledger_category_code=''PRIMARY'' and gl.object_type_code=''L'' and gl.complete_flag=''Y'')
    )
    where
    rownum=1' into l_segment_name using p_segment_prop_value, p_ledger_name, p_segment_num, p_ledger_name;

    return l_segment_name;
  end if;
end segment_name;


function ledger_id(p_ledger_name in varchar2) return number result_cache is
l_ledger_id number;
begin
  if fnd_release.major_version=11 then
    return null;
  else
    execute immediate 'select gl.ledger_id from gl_ledgers gl where gl.name=:p_ledger_name' into l_ledger_id using p_ledger_name;
    return l_ledger_id;
  end if;
end ledger_id;


function coa_id(p_ledger_name in varchar2) return number result_cache is
l_coa_id number;
begin
  if fnd_release.major_version=11 then
    return null;
  else
    execute immediate 'select gl.chart_of_accounts_id from gl_ledgers gl where gl.name=:p_ledger_name' into l_coa_id using p_ledger_name;
    return l_coa_id;
  end if;
end coa_id;


function has_flex_value_security return varchar2 is
function has_flex_value_security_(p_application_id in pls_integer, p_responsibility_id in pls_integer) return varchar2 result_cache is
begin
  for c in (select 'Y' from fnd_flex_value_rule_usages ffvru where ffvru.application_id=p_application_id and ffvru.responsibility_id=p_responsibility_id and rownum=1) loop
    return 'Y';
  end loop;
  return null;
end has_flex_value_security_;
begin
  if fnd_profile.value('XXEN_REPORT_DISABLE_GL_FLEX_VALUE_SECURITY')='Y' then
    return null;
  else
    return has_flex_value_security_(fnd_global.resp_appl_id,fnd_global.resp_id);
  end if;
end has_flex_value_security;


function xml_escape(p_text in varchar2) return varchar2 is
begin
  return substrb(translate(
  replace(
  replace(
  replace(
  replace(
  case when p_text like '="%"' then substr(p_text,3,length(p_text)-3) else p_text end,
  '&','&amp;'),
  '<','&lt;'),
  '>','&gt;'),
  '"','&quot;'),
  chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
  chr(08)||chr(9)||chr(10)||chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||
  chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
  chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31),' '),1,4000);
end xml_escape;


function xml_unescape(p_text in varchar2) return varchar2 is
begin
  return
  replace(
  replace(
  replace(
  replace(
  p_text,
  '&amp;','&'),
  '&lt;','<'),
  '&gt;','>'),
  '&quot;','"');
end xml_unescape;


function xml_attribute_value(p_vchr in varchar2) return varchar2 is
begin
  return translate(
  replace(
  replace(
  replace(
  case when p_vchr like '="%"' then substr(p_vchr,3,length(p_vchr)-3) else p_vchr end,
  '&','&amp;'),
  '<','&lt;'),
  '>','&gt;'),
  chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
  chr(08)||chr(11)||chr(12)||chr(14)||chr(15)||
  chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
  chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31),' ');
end xml_attribute_value;


function remove_order_by(p_text in clob) return clob is
l_remove_text clob:=regexp_substr(p_text,'(^|\s+)order\s+by\s+.+$',1,1,'in');
begin
  if not regexp_like(l_remove_text,'\s+(from|where|select)\s+','i') and regexp_count(l_remove_text,'\(')=regexp_count(l_remove_text,'\)') then
    return to_clob(dbms_lob.substr(p_text,length(p_text)-length(l_remove_text)));
  else
    return p_text;
  end if;
end remove_order_by;


function is_ebs_database return boolean is
begin
  for c in (select null from all_users au where au.username='APPLSYS') loop
    return true;
  end loop;
  return false;
end is_ebs_database;


function concurrent_request_file_url(p_file_type in varchar2, p_request_id in number) return varchar2 is
begin
  return fnd_webfile.get_url(
  file_type=>case when p_file_type='O' then fnd_webfile.request_out else fnd_webfile.request_log end,
  id=>p_request_id,
  gwyuid=>fnd_profile.value('GWYUID'),
  two_task=>fnd_profile.value('TWO_TASK'),
  expire_time=>500
  );
end concurrent_request_file_url;


function colname(p_col in pls_integer) return varchar2 is
begin
  return case
  when p_col<=26 then chr(64+p_col)
  when p_col<=702 then chr(64+trunc((p_col-1)/26))||chr(65+mod(p_col-1,26))
  else chr(64+trunc((p_col-27)/676))||chr(65+mod(trunc((p_col-1)/26)-1,26))||chr(65+mod(p_col-1,26))
  end;
end colname;


function colnum(p_column_name in varchar2) return pls_integer is
begin
  return case
  when length(p_column_name)=1 then ascii(p_column_name)-64
  when length(p_column_name)=2 then (ascii(p_column_name)-64)*26+ascii(substr(p_column_name,2))-64
  when length(p_column_name)=3 then (ascii(p_column_name)-64)*676+(ascii(substr(p_column_name,2))-64)*26+ascii(substr(p_column_name,3))-64
  end;
end colnum;


function date_to_excel_date(p_date in date) return varchar2 deterministic is
begin
  return to_char(round(p_date-to_date('01.01.1900','DD.MM.YYYY')+2,12),'TM9','nls_numeric_characters=.,');
end date_to_excel_date;


function excel_date_to_date(p_excel_date in varchar2) return date deterministic is
begin
  return to_date('01.01.1900','DD.MM.YYYY')+fnd_number.canonical_to_number(p_excel_date)-2;
end excel_date_to_date;


end xxen_util;
/

