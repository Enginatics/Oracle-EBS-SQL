/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Element Values
-- Description: Lists the allowed values behind every list-validated Oracle Quality collection element - the entries an operator can pick when entering quality results, and the collection element master values each plan was seeded from.
-- Oracle Quality holds these values in two independent places. A collection plan carries its own value list, and the collection element carries a master list. A plan is seeded from the master but is not tied to it afterwards: it can carry codes that were never in the master, override a master value's description, and leave master values out. The Value Level column says which is which. Plan means the value is offered on this collection plan, and is what quality results entry or a quality results upload must validate against. Element means the value is defined on the collection element master but was not carried into this plan, so it is not offered here.
-- On a Plan row, Element Master Description shows the master's own wording for the same short code, In Element Master flags whether the code exists in the master at all, and Description Overridden flags the rows where the plan's wording differs from the master's.
-- Result Column is the qaresults column this element's value is stored in, so a short code can be traced to the column that will hold it. Collection results are stored generically, so this mapping is what turns a stored value back into a business meaning.
-- Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type and Collection Element. Enabled Elements Only restricts to elements still enabled on the plan. Value Level isolates one of the two levels, and Short Code finds a particular value across plans.
-- Excel Example Output: https://www.enginatics.com/example/qa-collection-plan-element-values/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-element-values/
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
qpc.prompt_sequence,
qc.name element_name,
qpc.prompt element_prompt,
xxen_util.meaning(qc.char_type_code,'ELEMENT_TYPE',3) element_type,
xxen_util.meaning(qc.datatype,'QA_CHAR_DATATYPE',700) datatype,
xxen_util.meaning(qc.char_context_flag,'QA_CHAR_CONTEXT_FLAG',700) context_element,
'Plan' value_level,
qpcvl.short_code,
qpcvl.description value_description,
qcvl.description element_master_description,
xxen_util.yes(case when qcvl.short_code is not null then 'Y' end) in_element_master,
xxen_util.yes(case when qcvl.short_code is not null and nvl(qpcvl.description,chr(1))<>nvl(qcvl.description,chr(1)) then 'Y' end) description_overridden,
qpc.result_column_name result_column,
xxen_util.yes(case when qpc.enabled_flag=1 then 'Y' end) element_enabled,
xxen_util.yes(case when qpc.mandatory_flag=1 then 'Y' end) element_mandatory,
xxen_util.user_name(qpcvl.created_by) created_by,
xxen_util.client_time(qpcvl.creation_date) creation_date,
xxen_util.user_name(qpcvl.last_updated_by) last_updated_by,
xxen_util.client_time(qpcvl.last_update_date) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_plan_char_value_lookups qpcvl,
qa_char_value_lookups qcvl
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpc.plan_id and
qpc.char_id=qc.char_id and
qpc.plan_id=qpcvl.plan_id and
qpc.char_id=qpcvl.char_id and
qpcvl.char_id=qcvl.char_id(+) and
qpcvl.short_code=qcvl.short_code(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
union all
select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qpc.prompt_sequence,
qc.name element_name,
qpc.prompt element_prompt,
xxen_util.meaning(qc.char_type_code,'ELEMENT_TYPE',3) element_type,
xxen_util.meaning(qc.datatype,'QA_CHAR_DATATYPE',700) datatype,
xxen_util.meaning(qc.char_context_flag,'QA_CHAR_CONTEXT_FLAG',700) context_element,
'Element' value_level,
qcvl.short_code,
qcvl.description value_description,
to_char(null) element_master_description,
xxen_util.yes('Y') in_element_master,
to_char(null) description_overridden,
qpc.result_column_name result_column,
xxen_util.yes(case when qpc.enabled_flag=1 then 'Y' end) element_enabled,
xxen_util.yes(case when qpc.mandatory_flag=1 then 'Y' end) element_mandatory,
xxen_util.user_name(qcvl.created_by) created_by,
xxen_util.client_time(qcvl.creation_date) creation_date,
xxen_util.user_name(qcvl.last_updated_by) last_updated_by,
xxen_util.client_time(qcvl.last_update_date) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_char_value_lookups qcvl
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpc.plan_id and
qpc.char_id=qc.char_id and
qpc.char_id=qcvl.char_id and
not exists (select null from qa_plan_char_value_lookups qpcvl where qpc.plan_id=qpcvl.plan_id and qcvl.char_id=qpcvl.char_id and qcvl.short_code=qpcvl.short_code) and
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
x.short_code
