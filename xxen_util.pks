CREATE OR REPLACE package APPS.xxen_util authid definer is
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
/*  shows the lookup meaning for Y from the YES_NO value set                                   */
/***********************************************************************************************/
function yes(p_lookup_code in varchar2) return varchar2;

/***********************************************************************************************/
/*  escape regexp metacharacters with a backslash e.g. ( to \(                                 */
/***********************************************************************************************/
function regexp_escape(p_text in varchar2) return varchar2;

/***********************************************************************************************/
/*  escape json metacharacters, for example / with ~^                                          */
/***********************************************************************************************/
function json_escape(p_text in varchar2) return varchar2;

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
