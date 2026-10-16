/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Data Access Sets
-- Description: Master data report showing ledger security.
-- Listing of all GL data access sets and the ledgers or ledger sets that each access set can access.
-- Show Responsibilities adds one row per responsibility using the access set through the GL: Data Access Set profile set at responsibility or application level. Responsibilities inheriting the site level value are not listed.
-- Summary Accounts Allowed shows Yes when the responsibility's menu grants the Summary Accounts form and the access set gives full read and write access to the whole ledger. Otherwise the form's Ledger list does not offer the ledger (FRM-41830 List of Values contains no entries).
-- Excel Example Output: https://www.enginatics.com/example/gl-data-access-sets/
-- Library Link: https://www.enginatics.com/reports/gl-data-access-sets/
-- Run Report: https://demo.enginatics.com/

select
gasv.name access_set,
gasv.description,
gasv.chart_of_accounts_name chart_of_accounts,
gasv.period_set_name calendar,
gasv.user_period_type period_type,
decode(gasv.security_segment_code,'F','Full Ledger','B','Balancing Segment Value','M','Management Segment Value') access_set_type,
gasv.default_ledger_name default_ledger,
gasna.indent||gl.name ledger_name,
decode(gl.ledger_category_code,'NONE',xxen_util.meaning('S','LEDGERS',101),xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101)) ledger_category,
xxen_util.meaning(gasna.all_segment_value_flag,'YES_NO',0) all_values,
gasna.segment_value specific_value,
decode(gasna.access_privilege_code,'B','Read and Write','R','Read Only') privilege,
&responsibility_columns
xxen_util.user_name(gasna.created_by) created_by,
xxen_util.client_time(gasna.creation_date) creation_date,
xxen_util.user_name(gasna.last_updated_by) last_updated_by,
xxen_util.client_time(gasna.last_update_date) last_update_date,
gasv.access_set_id
from
gl_access_sets_v gasv,
(
select gasna.ledger_id ledger_id_, null indent, gasna.* from gl_access_set_norm_assign gasna union
select glsnav.ledger_id ledger_id_, '  ' indent, gasna.* from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.ledger_id=glsnav.ledger_set_id
) gasna,
gl_ledgers gl
&responsibility_table
where
1=1 and
&responsibility_join
gasv.access_set_id=gasna.access_set_id(+) and
gasna.ledger_id_=gl.ledger_id(+) and
nvl(gasna.status_code,'x') not in ('D','I')
order by
gasv.name,
gasna.ledger_id,
gl.object_type_code desc,
gl.name
&responsibility_order
