/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Plan Relationship Upload
-- Description: Upload to create, update, or delete Quality Collection Plan parent-child relationships using the standard Oracle API qa_ss_parent_child_pkg.

This upload manages:
- Parent-Child Plan Relationships (QA_PC_PLAN_RELATIONSHIP)
- Element Relationships between parent and child plans (QA_PC_ELEMENT_RELATIONSHIP)
- Criteria for automatic child record creation (QA_PC_CRITERIA)

Entry Modes:
- Immediate: Child data entered immediately after parent record
- Delayed: Child records entered manually later
- Automatic: Child records auto-created when parent matches criteria
- History: Child records auto-created when changes made to parent
-- Excel Examle Output: https://www.enginatics.com/example/qa-plan-relationship-upload/
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
qpcc.criteria_id
from
mtl_parameters mp,
qa_plans qpp,
qa_pc_plan_relationship qppr,
qa_plans qpc,
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
qper.plan_relationship_id(+)=qppr.plan_relationship_id and
qc_p.char_id(+)=qper.parent_char_id and
qc_c.char_id(+)=qper.child_char_id and
qpcc.plan_relationship_id(+)=qppr.plan_relationship_id and
qc_cr.char_id(+)=qpcc.char_id