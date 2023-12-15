/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Sales Journal By Customer
-- Description: Imported from BI Publisher
Description: Sales Journal By Customer
Application: Receivables
Source: Sales Journal By Customer (XML)
Short Name: RAXGLA_XML
DB package: AR_RAXGLA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-sales-journal-by-customer/
-- Library Link: https://www.enginatics.com/reports/ar-sales-journal-by-customer/
-- Run Report: https://demo.enginatics.com/

select
 gsob.name ledger,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') company_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') company_segment_desc,
 trx.invoice_currency_code invoice_currency,
 trx.trx_number invoice_number,
 arpt_sql_func_util.get_trx_type_details(trx.cust_trx_type_id,'TYPE', trx.org_id) invoice_class,
 arpt_sql_func_util.get_trx_type_details(trx.cust_trx_type_id,'NAME',trx.org_id) invoice_type,
 party.party_name customer_name,
 c.account_number customer_number,
 haouv.name operating_unit,
 trunc(trx.trx_date) invoice_date,
 case when :p_report_by_line = 'Y'
 then decode(gl_dist.account_class,'REC','All','FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,'All',to_char(link_line.line_number)),to_char(nvl(link_line.line_number, lines.line_number)))
 else null
 end line_number,
 --
 trunc(gl_dist.gl_date) gl_date,
 xxen_util.meaning(gl_dist.account_class,'AUTOGL_TYPE',222) account_class,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'ALL', 'Y', 'VALUE') gl_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, NULL, gl_dist.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') gl_account_desc,
 --
 sum(nvl(decode(gl_dist.account_class, 'REC', decode(sign(gl_dist.amount), 1, gl_dist.amount, 0 ), decode(sign(gl_dist.amount), 1, 0, -1 * gl_dist.amount ) ), 0 ) ) invoice_currency_debit,
 sum(nvl(decode(gl_dist.account_class, 'REC', decode(sign(gl_dist.amount), 1, 0, -1 * gl_dist.amount ), decode(sign(gl_dist.amount), 1, gl_dist.amount, 0 ) ) ,0 ) ) invoice_currency_credit,
 --
 case when :p_report_by_line = 'Y'
 then decode(gl_dist.account_class,'REC',-10,'FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,-10,link_line.line_number),nvl(link_line.line_number, lines.line_number))
 else decode(gl_dist.account_class,'REC',-10,'FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,-10,10),10)
 end line_number_sort
from
 gl_sets_of_books gsob,
 hr_all_organization_units_vl haouv,
 hz_cust_accounts_all c,
 hz_parties party,
 ra_customer_trx_all trx,
 ra_customer_trx_lines_all lines,
 ra_customer_trx_lines_all link_line,
 ar_xla_ctlgd_lines_v gl_dist
where
 :p_reporting_level = :p_reporting_level and
 :p_reporting_entity_id = :p_reporting_entity_id and
 1=1 and
 trx.complete_flag = 'Y' and
 gl_dist.account_set_flag = 'N' and
 link_line.customer_trx_line_id(+) = lines.link_to_cust_trx_line_id and
 gl_dist.customer_trx_line_id = lines.customer_trx_line_id(+) and
 gl_dist.customer_trx_id = trx.customer_trx_id and
 c.cust_account_id = trx.bill_to_customer_id and
 c.party_id = party.party_id and
 gl_dist.set_of_books_id = gsob.set_of_books_id and
 nvl(gl_dist.gl_posted_date, TO_DATE('01/01/0001', 'MM/DD/YYYY')) = decode(:p_posting_status, 'POSTED', gl_dist.gl_posted_date, 'UNPOSTED', TO_DATE('01/01/0001','MM/DD/YYYY'), nvl(gl_dist.gl_posted_date, TO_DATE('01/01/0001', 'MM/DD/YYYY'))) and
 trx.org_id=haouv.organization_id
group by
 gsob.name,
 haouv.name,
 gsob.chart_of_accounts_id,
 trx.invoice_currency_code,
 trx.trx_number,
 party.party_name,
 c.account_number,
 arpt_sql_func_util.get_trx_type_details(trx.cust_trx_type_id,'NAME',trx.org_id),
 arpt_sql_func_util.get_trx_type_details(trx.cust_trx_type_id,'TYPE',trx.org_id),
 trunc(trx.trx_date),
 trunc(gl_dist.gl_date),
 gl_dist.account_class,
 gl_dist.code_combination_id,
 case when :p_report_by_line = 'Y'
 then decode(gl_dist.account_class,'REC','All','FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,'All',to_char(link_line.line_number)),to_char(nvl(link_line.line_number, lines.line_number)))
 else null
 end,
 case when :p_report_by_line = 'Y'
 then decode(gl_dist.account_class,'REC',-10,'FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,-10,link_line.line_number),nvl(link_line.line_number, lines.line_number))
 else decode(gl_dist.account_class,'REC',-10,'FREIGHT' ,decode(lines.link_to_cust_trx_line_id,null,-10,10),10)
 end
order by
 invoice_currency,
 company_segment,
 customer_name,
 invoice_number,
 line_number_sort