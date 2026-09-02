/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Elements
-- Description: Every collection element assigned to an Oracle Quality collection plan, with the element's prompt and sequence on the plan, its element type, datatype, display length, decimal precision and unit of measure, the plan level and element level default values, and the Mandatory, Enabled, Displayed, Read Only, Information and Poplist flags. Collection plans that have no elements are listed too.

Oracle Quality stores every collection result generically in qa_results, whose character1 to character100 columns carry no meaning of their own: the element to column mapping is held per plan in qa_plan_chars.result_column_name, and each plan gets its own dynamically generated results view. This report exposes that mapping as the Result Column, shown verbatim next to the element's native Hardcoded Column so that a divergence between the two is visible at a glance. It also shows the Context Element classification, which separates a quality characteristic the operator enters from predefined reference information captured automatically from the transaction, and all three validation sources an element can use: a validation table with its additional where clause, a SQL validation string, and the number of plan level values the element offers. Use it to document or audit a Quality setup, and as the specification when building an interface or an upload that writes collection results.

Filter with the optional Organization, Collection Plan, Plan Type, Collection Element and Element Type parameters, or set Enabled Elements Only to Yes to hide elements that are disabled on the plan. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.
-- Excel Examle Output: https://www.enginatics.com/example/qa-collection-plan-elements/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-elements/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
qpc.prompt_sequence,
qc.name element_name,
qpc.prompt element_prompt,
xxen_util.meaning(qc.char_type_code,'ELEMENT_TYPE',3) element_type,
xxen_util.meaning(qc.datatype,'QA_CHAR_DATATYPE',700) datatype,
qc.display_length,
nvl(qpc.decimal_precision,qc.decimal_precision) decimal_precision,
(select mumv.unit_of_measure from mtl_units_of_measure_vl mumv where nvl(qpc.uom_code,qc.uom_code)=mumv.uom_code) unit_of_measure,
xxen_util.yes(case when qpc.mandatory_flag=1 then 'Y' end) mandatory,
xxen_util.yes(case when qpc.enabled_flag=1 then 'Y' end) enabled,
xxen_util.yes(case when qpc.displayed_flag=1 then 'Y' end) displayed,
xxen_util.yes(case when qpc.read_only_flag=1 then 'Y' end) read_only,
xxen_util.yes(case when qpc.information_flag=1 then 'Y' end) information,
xxen_util.yes(case when qpc.ss_poplist_flag=1 then 'Y' end) poplist,
qpc.default_value,
qc.default_value element_default_value,
qpc.result_column_name result_column,
xxen_util.meaning(qc.char_context_flag,'QA_CHAR_CONTEXT_FLAG',700) context_element,
qc.hardcoded_column,
xxen_util.yes(case when qpc.values_exist_flag=1 then 'Y' end) values_exist,
(select count(*) from qa_plan_char_value_lookups qpcvl where qpc.plan_id=qpcvl.plan_id and qpc.char_id=qpcvl.char_id) value_count,
qc.fk_table_name validation_table,
qc.fk_add_where validation_where_clause,
qc.sql_validation_string,
qc.data_entry_hint,
qc.target_value,
qc.upper_spec_limit,
qc.lower_spec_limit,
xxen_util.user_name(qpc.created_by) created_by,
xxen_util.client_time(qpc.creation_date) creation_date,
xxen_util.user_name(qpc.last_updated_by) last_updated_by,
xxen_util.client_time(qpc.last_update_date) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpc.plan_id(+) and
qpc.char_id=qc.char_id(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
order by
mp.organization_code,
qp.name,
qpc.prompt_sequence,
qc.name