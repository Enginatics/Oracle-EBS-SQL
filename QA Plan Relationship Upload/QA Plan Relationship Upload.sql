/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Plan Relationship Upload
-- Description: Upload to create, update and delete parent-child relationships between Quality collection plans, with their element relationships and the criteria for collecting child results.
-- Each row names a parent and a child plan. The row's element relationship (parent element, child element and relationship type) and criterion (criteria element, operator and values) are added to the plan relationship when they do not exist yet and updated otherwise. Delete Record deletes the whole plan relationship.
-- The download lists the element relationships and the criteria of a plan relationship side by side, one of each per row.
-- Entry modes:
-- - Immediate: child results are entered right after the parent result
-- - Delayed: child results are entered later
-- - Automatic: child results are created when the parent result meets the criteria
-- - History: a child result is created when the parent result changes
-- Excel Example Output: https://www.enginatics.com/example/qa-plan-relationship-upload/
-- Library Link: https://www.enginatics.com/reports/qa-plan-relationship-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qpp.name parent_plan,
qpc.name child_plan,
qpc.description child_plan_description,
xxen_util.meaning(qppr.data_entry_mode,'QA_PC_DATA_ENTRY_MODE',250) entry_mode,
xxen_util.meaning(qppr.layout_mode,'QA_PC_LAYOUT_MODE',250) layout_mode,
qppr.auto_row_count,
xxen_util.meaning(decode(qppr.default_parent_spec,1,'Y','N'),'YES_NO',0) default_parent_spec,
qc_p.name parent_element,
qc_c.name child_element,
xxen_util.meaning(qper.element_relationship_type,'QA_PC_ELEMENT_RELATIONSHIP',250) element_rel_type,
xxen_util.meaning(decode(qper.link_flag,1,'Y','N'),'YES_NO',0) link_flag,
qc_cr.name criteria_element,
xxen_util.meaning(qpcc.operator,'QA_PC_OPERATOR',700) criteria_operator,
qpcc.low_value criteria_from_value,
qpcc.high_value criteria_to_value,
null delete_record,
qppr.plan_relationship_id,
qper.element_relationship_id,
qpcc.criteria_id,
to_number(null) upload_row
from
mtl_parameters mp,
qa_plans qpp,
qa_pc_plan_relationship qppr,
qa_plans qpc,
(
select
nvl(x.plan_relationship_id,y.plan_relationship_id) plan_relationship_id,
x.element_relationship_id,
y.criteria_id
from
(select qper.plan_relationship_id, qper.element_relationship_id, row_number() over (partition by qper.plan_relationship_id order by qper.element_relationship_id) rn from qa_pc_element_relationship qper) x
full join
(select qpcc.plan_relationship_id, qpcc.criteria_id, row_number() over (partition by qpcc.plan_relationship_id order by qpcc.criteria_id) rn from qa_pc_criteria qpcc) y
on
x.plan_relationship_id=y.plan_relationship_id and
x.rn=y.rn
) z, --element relationships and criteria side by side, not every combination of the two
qa_pc_element_relationship qper,
qa_chars qc_p,
qa_chars qc_c,
qa_pc_criteria qpcc,
qa_chars qc_cr
where
1=1 and
qpp.organization_id=mp.organization_id and
qppr.parent_plan_id=qpp.plan_id and
qpc.plan_id=qppr.child_plan_id and
qppr.plan_relationship_id=z.plan_relationship_id(+) and
z.element_relationship_id=qper.element_relationship_id(+) and
qper.parent_char_id=qc_p.char_id(+) and
qper.child_char_id=qc_c.char_id(+) and
z.criteria_id=qpcc.criteria_id(+) and
qpcc.char_id=qc_cr.char_id(+)
