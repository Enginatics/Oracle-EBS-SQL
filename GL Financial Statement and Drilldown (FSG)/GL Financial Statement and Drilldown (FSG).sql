/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Financial Statement and Drilldown (FSG)
-- Description: The GL Financial Statement and Drilldown (FSG) Report empowers users to generate comprehensive reports on financial balances while providing detailed insights through drilldown capabilities. This tool allows users to link Excel cells directly to Oracle data via built-in functions, ensuring that data can be refreshed as needed to reflect the most up-to-date information.
Key features include:
1. Balance and Detail Reporting: Generate high-level balance reports and drill down into the details, including journal entries and subledger transactions.
2. Oracle Data Integration: Seamlessly link Excel cells to Oracle data, with the ability to refresh the data for real-time updates.
3. Drilldown Functionality: Access detailed information at various levels, including balances, journal entries, and subledger details.
4. Migration Tools: Converters are available to migrate reports from Oracle FSG, GL Wand, and Spreadsheet Server to this solution.

For a quick demonstration, refer to our YouTube video.
<a href="https://youtu.be/dsRWXT2bem8" rel="nofollow" target="_blank">https://youtu.be/dsRWXT2bem8</a>

Important: Please do not delete the "Financial Statement Generator" sheet or modify the Advanced Custom Properties in the Excel output, as these are essential for the proper functioning of the report.
-- Excel Examle Output: https://www.enginatics.com/example/gl-financial-statement-and-drilldown-fsg/
-- Library Link: https://www.enginatics.com/reports/gl-financial-statement-and-drilldown-fsg/
-- Run Report: https://demo.enginatics.com/

select
:period_name period_name,
:balance_type balance_type,
:average_balance_type average_balance_type,
:template_name,
:actual_flag actual_flag,
:ledger ledger_name,
:budget_name budget_name,
:currency_code currency_code,
:currency_type,
:conversion_type,
:amount_type,
:encumbrance_type encumbrance_type,
:account_type account_type,
:movement movement,
:translated_flag translated_flag,
:gl_segments gl_segments,
:fsg_report,
:fsg_converter,
:gl_segments_cb gl_segments_cb,
:get_balance_function get_balance_function,
:balance_drilldown_function balance_drilldown_function,
:expand_segment_function expand_segment_function,
:period_offset_function period_offset_function,
:hierarchy_name,
:custom_properties,
:default_hierarchy,
:gl_segment,
:gl_segment_value,
:next_segment_value,
:segment_hierarchy_values,
:discover_period_name,
:daily_rates,
:period_year,
:period_num,
:journal_source,
:journal_category,
:gl_segment1 gl_segment1,
:gl_segment2 gl_segment2,
:gl_segment3 gl_segment3,
:gl_segment4 gl_segment4,
:gl_segment5 gl_segment5,
:gl_segment6 gl_segment6,
:gl_segment7 gl_segment7,
:gl_segment8 gl_segment8,
:gl_segment9 gl_segment9,
:gl_segment10 gl_segment10,
:gl_segment11,
:gl_segment12,
:gl_segment13,
:gl_segment14,
:gl_segment15,
:gl_segment16,
:gl_segment17,
:gl_segment18,
:gl_segment19,
:gl_segment20,
:create_lov create_lov,
:responsibility_name responsibility_name,
:responsibility_key,
:balance_drilldown_new,
:gl_journal_drilldown,
:gl_subledger_details,
:gl_journal_drilldown_m,
:gl_subledger_details_m,
:gl_full_journal_drilldown,
:gl_journal_attachment_dd,
:drilldown_resp,
:batch_name,
:journal_name,
:document_number,
:posting_status,
:fund_status,
:created_by,
:effective_date
from
dual
where
1=1