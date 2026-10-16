/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Relationships
-- Description: Every Oracle Quality parent child collection plan relationship, at one row per parent element to child element mapping. Each row names both plans with their descriptions and plan types, the relationship type, the data entry mode and layout mode that govern how the child rows are presented, the automatic row count and default parent specification flag, and the element relationship operator that says what the parent value does to the child value, together with the plan level prompt of each mapped element. A relationship that has no element mapping yet is still listed, as a single row.
-- Oracle Quality lets one collection plan drive another: when results are entered against the parent, a child plan is created and selected element values are copied, summed, averaged or otherwise derived into it. That behaviour is held in three tables which no single Oracle window exposes together - qapcplanrelationship for the pairing and its data entry behaviour, qapcelementrelationship for the element by element mapping, and qapccriteria for the conditions under which the child is created at all. This report is the one place the whole chain is visible, which is what makes it the reference when documenting a Quality setup, auditing which plans feed which, or specifying an interface that has to reproduce the derived values a parent plan writes into its children.
-- Criteria are a gate on the relationship rather than an attribute of one element mapping, so they are aggregated onto every row of that relationship: Criteria Count gives the number of conditions and Criteria renders them as readable expressions. Because aggregated text cannot be filtered, the Criteria Element parameter restricts to the relationships that are gated by a given collection element.
-- Filter with the optional Organization, Parent Plan, Child Plan and Collection Element parameters, or narrow on the relationship behaviour itself with Element Relationship and Data Entry Mode. Organization and Collection Element match either side of the relationship, so a single value returns everything that touches that organization or that element as parent or as child. Leaving Organization blank returns every relationship whose parent plan the responsibility has inventory organization access to, plus the relationships between seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.
-- Inventory organization security is applied to the parent plan only. A relationship whose parent plan the responsibility can see is listed in full, including the name, description and plan type of a child plan in an organization the responsibility has no access to, because a relationship spans two plans and suppressing the child would leave the row meaningless.
-- Excel Example Output: https://www.enginatics.com/example/qa-collection-plan-relationships/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-relationships/
-- Run Report: https://demo.enginatics.com/

select
mp_p.organization_code parent_organization_code,
qp_p.name parent_plan,
qp_p.description parent_plan_description,
xxen_util.meaning(qp_p.plan_type_code,'COLLECTION_PLAN_TYPE',3) parent_plan_type,
mp_c.organization_code child_organization_code,
qp_c.name child_plan,
qp_c.description child_plan_description,
xxen_util.meaning(qp_c.plan_type_code,'COLLECTION_PLAN_TYPE',3) child_plan_type,
xxen_util.meaning(qppr.plan_relationship_type,'QA_PC_PLAN_RELATIONSHIP',250) relationship_type,
xxen_util.meaning(qppr.data_entry_mode,'QA_PC_DATA_ENTRY_MODE',250) data_entry_mode,
xxen_util.meaning(qppr.layout_mode,'QA_PC_LAYOUT_MODE',250) layout_mode,
qppr.auto_row_count,
xxen_util.yes(case when qppr.default_parent_spec=1 then 'Y' end) default_parent_spec,
qc_p.name parent_element,
(select qpc_p.prompt from qa_plan_chars qpc_p where qppr.parent_plan_id=qpc_p.plan_id and qper.parent_char_id=qpc_p.char_id) parent_element_prompt,
xxen_util.meaning(qper.element_relationship_type,'QA_PC_ELEMENT_RELATIONSHIP',250) element_relationship,
qc_c.name child_element,
(select qpc_c.prompt from qa_plan_chars qpc_c where qppr.child_plan_id=qpc_c.plan_id and qper.child_char_id=qpc_c.char_id) child_element_prompt,
xxen_util.yes(case when qper.link_flag=1 then 'Y' end) linked,
(select count(*) from qa_pc_criteria qpcr where qppr.plan_relationship_id=qpcr.plan_relationship_id) criteria_count,
(select listagg(qc_cr.name||' '||xxen_util.meaning(qpcr.operator,'QA_PC_OPERATOR',700)||nvl2(qpcr.low_value,' '||qpcr.low_value,null)||nvl2(qpcr.high_value,' and '||qpcr.high_value,null),', ') within group (order by qc_cr.name) from qa_pc_criteria qpcr, qa_chars qc_cr where qppr.plan_relationship_id=qpcr.plan_relationship_id and qpcr.char_id=qc_cr.char_id(+)) criteria,
xxen_util.user_name(nvl(qper.created_by,qppr.created_by)) created_by,
xxen_util.client_time(nvl(qper.creation_date,qppr.creation_date)) creation_date,
xxen_util.user_name(nvl(qper.last_updated_by,qppr.last_updated_by)) last_updated_by,
xxen_util.client_time(nvl(qper.last_update_date,qppr.last_update_date)) last_update_date
from
qa_pc_plan_relationship qppr,
qa_plans qp_p,
mtl_parameters mp_p,
qa_plans qp_c,
mtl_parameters mp_c,
qa_pc_element_relationship qper,
qa_chars qc_p,
qa_chars qc_c
where
qppr.parent_plan_id=qp_p.plan_id and
qp_p.organization_id=mp_p.organization_id(+) and
qppr.child_plan_id=qp_c.plan_id and
qp_c.organization_id=mp_c.organization_id(+) and
qppr.plan_relationship_id=qper.plan_relationship_id(+) and
qper.parent_char_id=qc_p.char_id(+) and
qper.child_char_id=qc_c.char_id(+) and
(qp_p.organization_id=0 or qp_p.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
order by
mp_p.organization_code,
qp_p.name,
qp_c.name,
qc_p.name,
qc_c.name
