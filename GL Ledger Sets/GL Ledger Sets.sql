/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Ledger Sets
-- Description: Master data report showing GL ledger sets and included ledgers.
-- Excel Examle Output: https://www.enginatics.com/example/gl-ledger-sets/
-- Library Link: https://www.enginatics.com/reports/gl-ledger-sets/
-- Run Report: https://demo.enginatics.com/

select
glsv.name ledger_set,
glsv.short_name,
glsv.description,
glsv.chart_of_accounts_name chart_of_accounts,
glsv.period_set_name calendar,
glsv.user_period_type period_type,
(select gl.name from gl_ledgers gl where glsv.default_ledger_id=gl.ledger_id) default_ledger,
gl.name ledger,
xxen_util.meaning(gl.object_type_code,'LEDGERS',101) object_type_code,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_catgory,
gl.description ledger_description
from
gl_ledger_sets_v glsv,
gl_ledger_set_norm_assign_v glsnav,
gl_ledgers gl
where
1=1 and
glsv.ledger_id=glsnav.ledger_set_id and
glsnav.ledger_id=gl.ledger_id
order by
glsv.name,
decode(gl.ledger_category_code,'PRIMARY',1,'SECONDARY',2,'ALC',3,'NONE',4),
gl.name