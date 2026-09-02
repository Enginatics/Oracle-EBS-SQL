/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Actions
-- Description: Lists every action rule defined against an Oracle Quality collection plan - the trigger condition that fires the rule, the action it runs, the element it assigns, the alert it raises and the collection elements bound into its message - as a union of the rules attached to the collection plan itself and the rules defined on the collection element master, discriminated by an Action Level column. Trigger conditions that carry no action are listed too.

Oracle Quality evaluates these rules while quality results are entered. A rule is a trigger condition on one collection element - the element is entered, equals a value, falls outside its specification limits - paired with one or more actions. The rules are stored in two independent places. A collection plan carries its own rules in qa_plan_char_action_triggers and qa_plan_char_actions, and a collection element carries master rules in qa_char_action_triggers and qa_char_actions. The two are not linked: an element master rule is never copied into a plan, it simply applies to every plan that uses the element. The Action Level column says which is which. Plan means the rule is defined on this collection plan. Element means the rule is defined on the collection element master and therefore applies to every plan carrying that element, this one included.

Online Action separates the actions the results entry engine evaluates inline, as values are entered, from the actions it defers to background processing. The inline ones - display a message to the operator, reject the input, assign a value to a collection element - are the class of action that can change or refuse the data a results load submits. The deferred ones - alerts, workflow, holds - do not alter the collected values inline.

Assign Type and Assigned Element are populated only where the action assigns a value to another collection element; the formula or SQL statement itself is in Action Message. Output Variable and Output Element are a matched pair listing the tokens bound into that message and the collection element each token reads, so a formula referencing several elements can be resolved from the row. A trigger bound may be a literal or a statistical limit, and both are rendered. Status Code is the status string the action assigns to the quality result; Oracle Quality stores it as free text with no lookup behind it, so it is shown exactly as it was configured and is not translated.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Collection Element and Action. Online Actions Only restricts to the actions evaluated inline during results entry, Enabled Elements Only to elements still enabled on the plan, and Action Level isolates plan level or element level rules. Element level rules are shown against the collection plans that use the element, so a rule on an element that no collection plan uses is not listed. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.
-- Excel Examle Output: https://www.enginatics.com/example/qa-collection-plan-actions/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-actions/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
'Plan' action_level,
qpc.prompt_sequence,
qc.name element_name,
qpc.prompt element_prompt,
qpcat.trigger_sequence action_trigger_sequence,
xxen_util.meaning(qpcat.operator,'QA_OPERATOR',700) trigger_operator,
nvl(qpcat.low_value_other,xxen_util.meaning(qpcat.low_value_lookup,'QA_ACTION_TRIGGER_VALUE',700)) trigger_low_value,
nvl(qpcat.high_value_other,xxen_util.meaning(qpcat.high_value_lookup,'QA_ACTION_TRIGGER_VALUE',700)) trigger_high_value,
qa.description action_name,
xxen_util.yes(case when qa.online_flag=1 then 'Y' end) online_action,
case when qpca.assigned_char_id is not null then decode(qpca.assign_type,'F','Formula','S','SQL Statement') end assign_type,
qc_assigned.name assigned_element,
aas.name alert_action_set,
aa.name alert_action,
qpca.status_code,
qpca.message action_message,
(select listagg(qpcao.token_name,', ') within group (order by qpcao.token_name) from qa_plan_char_action_outputs qpcao where qpca.plan_char_action_id=qpcao.plan_char_action_id) output_variable,
(
select listagg(qc_output.name,', ') within group (order by qpcao.token_name)
from
qa_plan_char_action_outputs qpcao,
qa_chars qc_output
where
qpca.plan_char_action_id=qpcao.plan_char_action_id and
qpcao.char_id=qc_output.char_id
) output_element,
xxen_util.yes(case when qpc.enabled_flag=1 then 'Y' end) element_enabled,
xxen_util.yes(case when qa.enabled_flag=1 then 'Y' end) action_enabled,
xxen_util.user_name(nvl(qpca.created_by,qpcat.created_by)) created_by,
xxen_util.client_time(nvl(qpca.creation_date,qpcat.creation_date)) creation_date,
xxen_util.user_name(nvl(qpca.last_updated_by,qpcat.last_updated_by)) last_updated_by,
xxen_util.client_time(nvl(qpca.last_update_date,qpcat.last_update_date)) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_char_action_triggers qpcat,
qa_chars qc,
qa_plan_chars qpc,
qa_plan_char_actions qpca,
qa_actions qa,
qa_chars qc_assigned,
alr_action_sets aas,
alr_actions aa
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpcat.plan_id and
qpcat.char_id=qc.char_id and
qpcat.plan_id=qpc.plan_id(+) and
qpcat.char_id=qpc.char_id(+) and
qpcat.plan_char_action_trigger_id=qpca.plan_char_action_trigger_id(+) and
qpca.action_id=qa.action_id(+) and
qpca.assigned_char_id=qc_assigned.char_id(+) and
qpca.alr_action_set_id=aas.action_set_id(+) and
qpca.alr_action_id=aa.action_id(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
union all
select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
'Element' action_level,
qpc.prompt_sequence,
qc.name element_name,
qpc.prompt element_prompt,
qcat.trigger_sequence action_trigger_sequence,
xxen_util.meaning(qcat.operator,'QA_OPERATOR',700) trigger_operator,
nvl(qcat.low_value_other,xxen_util.meaning(qcat.low_value_lookup,'QA_ACTION_TRIGGER_VALUE',700)) trigger_low_value,
nvl(qcat.high_value_other,xxen_util.meaning(qcat.high_value_lookup,'QA_ACTION_TRIGGER_VALUE',700)) trigger_high_value,
qa.description action_name,
xxen_util.yes(case when qa.online_flag=1 then 'Y' end) online_action,
to_char(null) assign_type,
to_char(null) assigned_element,
aas.name alert_action_set,
aa.name alert_action,
qca.status_code,
qca.message action_message,
(select listagg(qcao.token_name,', ') within group (order by qcao.token_name) from qa_char_action_outputs qcao where qca.char_action_id=qcao.char_action_id) output_variable,
(
select listagg(qc_output.name,', ') within group (order by qcao.token_name)
from
qa_char_action_outputs qcao,
qa_chars qc_output
where
qca.char_action_id=qcao.char_action_id and
qcao.char_id=qc_output.char_id
) output_element,
xxen_util.yes(case when qpc.enabled_flag=1 then 'Y' end) element_enabled,
xxen_util.yes(case when qa.enabled_flag=1 then 'Y' end) action_enabled,
xxen_util.user_name(nvl(qca.created_by,qcat.created_by)) created_by,
xxen_util.client_time(nvl(qca.creation_date,qcat.creation_date)) creation_date,
xxen_util.user_name(nvl(qca.last_updated_by,qcat.last_updated_by)) last_updated_by,
xxen_util.client_time(nvl(qca.last_update_date,qcat.last_update_date)) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_char_action_triggers qcat,
qa_char_actions qca,
qa_actions qa,
alr_action_sets aas,
alr_actions aa
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpc.plan_id and
qpc.char_id=qc.char_id and
qc.char_id=qcat.char_id and
qcat.char_action_trigger_id=qca.char_action_trigger_id(+) and
qca.action_id=qa.action_id(+) and
qca.alr_action_set_id=aas.action_set_id(+) and
qca.alr_action_id=aa.action_id(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
3=3
) x
where
2=2
order by
x.organization_code,
x.plan_name,
x.prompt_sequence,
x.element_name,
x.action_trigger_sequence,
x.action_name