/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Expense Account Rules Upload
-- Description: Creates, updates and deletes the expense account rules of the Purchasing setup page Expense Account Rules.
-- A rule overrides one segment of the expense account that the PO and requisition Account Generators build, with a fixed segment value for all items of a purchasing category.
-- There is one rule per operating unit, category and segment.
-- Excel Example Output: https://www.enginatics.com/example/po-expense-account-rules-upload/
-- Library Link: https://www.enginatics.com/reports/po-expense-account-rules-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
prea.account_rule_id,
haouv.name operating_unit,
xxen_util.meaning(prea.rule_type,'ACCOUNT_RULE_TYPE',201) account_rule_type,
mcv.category_concat_segs account_rule_value,
mcv.description category_description,
fifsv.segment_name,
prea.segment_value,
xxen_util.segment_description(prea.segment_value,prea.segment_num,fifsv.id_flex_num) segment_value_description,
null delete_rule,
to_number(null) upload_row
from
po_rule_expense_accounts_all prea,
hr_all_organization_units_vl haouv,
financials_system_params_all fspa,
gl_ledgers gl,
fnd_id_flex_segments_vl fifsv,
mtl_categories_v mcv
where
prea.org_id=haouv.organization_id and
prea.org_id=fspa.org_id and
fspa.set_of_books_id=gl.ledger_id and
fifsv.application_id=101 and
fifsv.id_flex_code='GL#' and
gl.chart_of_accounts_id=fifsv.id_flex_num and
prea.segment_num=fifsv.application_column_name and
prea.rule_value_id=mcv.category_id(+) and
prea.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
1=1
