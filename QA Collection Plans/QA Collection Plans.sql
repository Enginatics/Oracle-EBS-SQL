/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plans
-- Description: One row per Oracle Quality collection plan, with the plan type, effective dates, instructions, specification assignment type, electronic signature mode and the template plan it was copied from, together with the names of the plan's generated results view and import view and counts of the elements, element values, transactions, transaction triggers, action rules, actions, child plans and parent plans that hang off it.

Oracle Quality stores every collection result generically in qa_results, and each plan gets its own dynamically generated results view and import view that map that plan's elements onto the qa_results character columns. This report shows both view names next to a flag stating whether the view actually exists in the database, which is the quickest way to find a plan whose generated view was never built or has since been dropped, because such a plan cannot be queried or imported through it. The counts turn the report into a one page map of a Quality setup: which plans carry elements but collect nothing, which plans fire actions on data entry, and which plans are nested into a parent child structure.

Active is derived from the effective dates and is Yes while the plan is in effect today, a plan with no effective dates always being active. Specification Type states which specification the plan matches its results against at collection time, taken from the item, the supplier or the customer, or none at all. Enabled Elements counts only the elements that are enabled on the plan, so a difference against Elements identifies a plan carrying elements the operator never sees.

Filter with the optional Organization, Collection Plan, Plan Type and Collection Element parameters, Collection Element restricting the report to the plans that use that element, or set Active Plans Only or Template Plans Only to Yes. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code; Template Plans Only returns exactly those seeded plans.
-- Excel Examle Output: https://www.enginatics.com/example/qa-collection-plans/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plans/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.yes(case when sysdate>=nvl(qp.effective_from,sysdate) and sysdate<nvl(qp.effective_to,sysdate)+1 then 'Y' end) active,
(select qp2.name from qa_plans qp2 where qp.template_plan_id=qp2.plan_id) template_plan,
qp.instructions,
case qp.spec_assignment_type when 1 then 'Item Specification' when 2 then 'Supplier Specification' when 3 then 'Customer Specification' when 4 then 'No Specification' end specification_type,
xxen_util.meaning(qp.esig_mode,'QA_ERES_RESULT_TYPE',250) esignature_mode,
qp.view_name results_view,
xxen_util.yes(case when uv_results.view_name is not null then 'Y' end) results_view_exists,
qp.import_view_name import_view,
xxen_util.yes(case when uv_import.view_name is not null then 'Y' end) import_view_exists,
(select count(*) from qa_plan_chars qpc where qp.plan_id=qpc.plan_id) elements,
(select count(*) from qa_plan_chars qpc where qp.plan_id=qpc.plan_id and qpc.enabled_flag=1) enabled_elements,
(select count(*) from qa_plan_char_value_lookups qpcvl where qp.plan_id=qpcvl.plan_id) element_values,
(select count(*) from qa_plan_transactions qpt where qp.plan_id=qpt.plan_id) transactions,
(select count(*) from qa_plan_transactions qpt, qa_plan_collection_triggers qpct where qp.plan_id=qpt.plan_id and qpt.plan_transaction_id=qpct.plan_transaction_id) transaction_triggers,
(select count(*) from qa_plan_char_action_triggers qpcat where qp.plan_id=qpcat.plan_id) action_rules,
(select count(*) from qa_plan_char_action_triggers qpcat, qa_plan_char_actions qpca where qp.plan_id=qpcat.plan_id and qpcat.plan_char_action_trigger_id=qpca.plan_char_action_trigger_id) actions,
(select count(*) from qa_pc_plan_relationship qppr where qp.plan_id=qppr.parent_plan_id) child_plans,
(select count(*) from qa_pc_plan_relationship qppr where qp.plan_id=qppr.child_plan_id) parent_plans,
xxen_util.user_name(qp.created_by) created_by,
xxen_util.client_time(qp.creation_date) creation_date,
xxen_util.user_name(qp.last_updated_by) last_updated_by,
xxen_util.client_time(qp.last_update_date) last_update_date
from
qa_plans qp,
mtl_parameters mp,
user_views uv_results,
user_views uv_import
where
qp.organization_id=mp.organization_id(+) and
qp.view_name=uv_results.view_name(+) and
qp.import_view_name=uv_import.view_name(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
order by
mp.organization_code,
qp.name