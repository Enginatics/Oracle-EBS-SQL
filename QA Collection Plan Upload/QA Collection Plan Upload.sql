/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Upload
-- Description: Upload to create, update, or delete Quality Collection Plans and all child entities.

This upload manages:
- Collection Plan headers (name, type, dates, multirow flag)
- Plan Transactions (transaction assignments, mandatory/background flags)
- Collection Triggers (trigger conditions per transaction)
- Plan Elements (collection element assignments, prompts, flags)
- Element Values (value lookups per element)
- Action Triggers (trigger sequences and conditions per element)
- Actions (action assignments per trigger)
- Action Outputs (output variable mappings per action)

Upload Modes
============

Create
------
Opens an empty spreadsheet for entering new Collection Plans and child entities.

Create, Update
--------------
Downloads existing Collection Plans matching filters for review and update.
New rows can be added to create additional plans in the same upload.

Row Types
=========
The upload uses a hierarchical structure with 8 row types:
1. Plan Header
2. Transaction
3. Collection Trigger
4. Element
5. Element Value
6. Action Trigger
7. Action
8. Action Output

Each child row inherits its parent context from the plan_name column.
-- Excel Examle Output: https://www.enginatics.com/example/qa-collection-plan-upload/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
to_char(null) element_name,
to_number(null) prompt_sequence,
to_char(null) element_prompt,
to_char(null) element_enabled,
to_char(null) element_mandatory,
to_char(null) default_value,
to_char(null) displayed,
to_char(null) read_only,
to_char(null) ss_poplist,
to_char(null) information,
to_number(null) decimal_precision,
to_char(null) uom_code,
to_char(null) value_code,
to_char(null) value_description,
to_number(null) action_trigger_seq,
to_char(null) action_operator,
to_char(null) action_low_value,
to_char(null) action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
1 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp
where
qp.organization_id=mp.organization_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
qptv.transaction_description,
xxen_util.meaning(decode(qpt.mandatory_collection_flag,1,'Y','N'),'YES_NO',0) mandatory_collection,
xxen_util.meaning(decode(qpt.background_collection_flag,1,'Y','N'),'YES_NO',0) background_collection,
xxen_util.meaning(decode(qpt.enabled_flag,1,'Y','N'),'YES_NO',0) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
to_char(null) element_name,
to_number(null) prompt_sequence,
to_char(null) element_prompt,
to_char(null) element_enabled,
to_char(null) element_mandatory,
to_char(null) default_value,
to_char(null) displayed,
to_char(null) read_only,
to_char(null) ss_poplist,
to_char(null) information,
to_number(null) decimal_precision,
to_char(null) uom_code,
to_char(null) value_code,
to_char(null) value_description,
to_number(null) action_trigger_seq,
to_char(null) action_operator,
to_char(null) action_low_value,
to_char(null) action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
2 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_transactions qpt,
qa_plan_transactions_v qptv
where
qp.organization_id=mp.organization_id and
qp.plan_id=qpt.plan_id and
qpt.plan_transaction_id=qptv.plan_transaction_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
qptv.transaction_description,
xxen_util.meaning(decode(qpt.mandatory_collection_flag,1,'Y','N'),'YES_NO',0) mandatory_collection,
xxen_util.meaning(decode(qpt.background_collection_flag,1,'Y','N'),'YES_NO',0) background_collection,
xxen_util.meaning(decode(qpt.enabled_flag,1,'Y','N'),'YES_NO',0) transaction_enabled,
qctdv.collection_trigger_description collection_trigger,
xxen_util.meaning(qpct.operator,'QA_OPERATOR',700) trigger_operator,
qpct.low_value trigger_low_value,
qpct.high_value trigger_high_value,
to_char(null) element_name,
to_number(null) prompt_sequence,
to_char(null) element_prompt,
to_char(null) element_enabled,
to_char(null) element_mandatory,
to_char(null) default_value,
to_char(null) displayed,
to_char(null) read_only,
to_char(null) ss_poplist,
to_char(null) information,
to_number(null) decimal_precision,
to_char(null) uom_code,
to_char(null) value_code,
to_char(null) value_description,
to_number(null) action_trigger_seq,
to_char(null) action_operator,
to_char(null) action_low_value,
to_char(null) action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
3 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_transactions qpt,
qa_plan_transactions_v qptv,
qa_plan_collection_triggers qpct,
qa_txn_collection_triggers_v qctdv
where
qp.organization_id=mp.organization_id and
qp.plan_id=qpt.plan_id and
qpt.plan_transaction_id=qptv.plan_transaction_id and
qpt.plan_transaction_id=qpct.plan_transaction_id and
qpct.collection_trigger_id=qctdv.collection_trigger_id and
qpt.transaction_number=qctdv.transaction_number and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
qc.name element_name,
qpc.prompt_sequence,
qpc.prompt element_prompt,
xxen_util.meaning(decode(qpc.enabled_flag,1,'Y','N'),'YES_NO',0) element_enabled,
xxen_util.meaning(decode(qpc.mandatory_flag,1,'Y','N'),'YES_NO',0) element_mandatory,
qpc.default_value,
xxen_util.meaning(decode(qpc.displayed_flag,1,'Y','N'),'YES_NO',0) displayed,
xxen_util.meaning(decode(qpc.read_only_flag,1,'Y','N'),'YES_NO',0) read_only,
xxen_util.meaning(decode(qpc.ss_poplist_flag,1,'Y','N'),'YES_NO',0) ss_poplist,
xxen_util.meaning(decode(qpc.information_flag,1,'Y','N'),'YES_NO',0) information,
qpc.decimal_precision,
qpc.uom_code,
to_char(null) value_code,
to_char(null) value_description,
to_number(null) action_trigger_seq,
to_char(null) action_operator,
to_char(null) action_low_value,
to_char(null) action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
4 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc
where
qp.organization_id=mp.organization_id and
qpc.plan_id=qp.plan_id and
qpc.char_id=qc.char_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
qc.name element_name,
qpc.prompt_sequence,
qpc.prompt element_prompt,
xxen_util.meaning(decode(qpc.enabled_flag,1,'Y','N'),'YES_NO',0) element_enabled,
xxen_util.meaning(decode(qpc.mandatory_flag,1,'Y','N'),'YES_NO',0) element_mandatory,
qpc.default_value,
xxen_util.meaning(decode(qpc.displayed_flag,1,'Y','N'),'YES_NO',0) displayed,
xxen_util.meaning(decode(qpc.read_only_flag,1,'Y','N'),'YES_NO',0) read_only,
xxen_util.meaning(decode(qpc.ss_poplist_flag,1,'Y','N'),'YES_NO',0) ss_poplist,
xxen_util.meaning(decode(qpc.information_flag,1,'Y','N'),'YES_NO',0) information,
qpc.decimal_precision,
qpc.uom_code,
qpcvl.short_code value_code,
qpcvl.description value_description,
to_number(null) action_trigger_seq,
to_char(null) action_operator,
to_char(null) action_low_value,
to_char(null) action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
5 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_plan_char_value_lookups qpcvl
where
qp.organization_id=mp.organization_id and
qpc.plan_id=qp.plan_id and
qpc.char_id=qc.char_id and
qpcvl.plan_id=qpc.plan_id and
qpcvl.char_id=qpc.char_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
qc.name element_name,
qpc.prompt_sequence,
qpc.prompt element_prompt,
xxen_util.meaning(decode(qpc.enabled_flag,1,'Y','N'),'YES_NO',0) element_enabled,
xxen_util.meaning(decode(qpc.mandatory_flag,1,'Y','N'),'YES_NO',0) element_mandatory,
qpc.default_value,
xxen_util.meaning(decode(qpc.displayed_flag,1,'Y','N'),'YES_NO',0) displayed,
xxen_util.meaning(decode(qpc.read_only_flag,1,'Y','N'),'YES_NO',0) read_only,
xxen_util.meaning(decode(qpc.ss_poplist_flag,1,'Y','N'),'YES_NO',0) ss_poplist,
xxen_util.meaning(decode(qpc.information_flag,1,'Y','N'),'YES_NO',0) information,
qpc.decimal_precision,
qpc.uom_code,
to_char(null) value_code,
to_char(null) value_description,
qpcat.trigger_sequence action_trigger_seq,
xxen_util.meaning(qpcat.operator,'QA_OPERATOR',700) action_operator,
qpcat.low_value_other action_low_value,
qpcat.high_value_other action_high_value,
to_char(null) action_name,
to_char(null) action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
6 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_plan_char_action_triggers qpcat
where
qp.organization_id=mp.organization_id and
qpc.plan_id=qp.plan_id and
qpc.char_id=qc.char_id and
qpcat.plan_id=qpc.plan_id and
qpcat.char_id=qpc.char_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
qc.name element_name,
qpc.prompt_sequence,
qpc.prompt element_prompt,
xxen_util.meaning(decode(qpc.enabled_flag,1,'Y','N'),'YES_NO',0) element_enabled,
xxen_util.meaning(decode(qpc.mandatory_flag,1,'Y','N'),'YES_NO',0) element_mandatory,
qpc.default_value,
xxen_util.meaning(decode(qpc.displayed_flag,1,'Y','N'),'YES_NO',0) displayed,
xxen_util.meaning(decode(qpc.read_only_flag,1,'Y','N'),'YES_NO',0) read_only,
xxen_util.meaning(decode(qpc.ss_poplist_flag,1,'Y','N'),'YES_NO',0) ss_poplist,
xxen_util.meaning(decode(qpc.information_flag,1,'Y','N'),'YES_NO',0) information,
qpc.decimal_precision,
qpc.uom_code,
to_char(null) value_code,
to_char(null) value_description,
qpcat.trigger_sequence action_trigger_seq,
xxen_util.meaning(qpcat.operator,'QA_OPERATOR',700) action_operator,
qpcat.low_value_other action_low_value,
qpcat.high_value_other action_high_value,
qa.description action_name,
qpca.message action_message,
to_char(null) output_variable,
to_char(null) output_element,
null delete_record,
7 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_plan_char_action_triggers qpcat,
qa_plan_char_actions qpca,
qa_actions qa
where
qp.organization_id=mp.organization_id and
qpc.plan_id=qp.plan_id and
qpc.char_id=qc.char_id and
qpcat.plan_id=qpc.plan_id and
qpcat.char_id=qpc.char_id and
qpca.plan_char_action_trigger_id=qpcat.plan_char_action_trigger_id and
qpca.action_id=qa.action_id and
1=1
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
qp.effective_from,
qp.effective_to,
xxen_util.meaning(decode(qp.multirow_flag,1,'Y','N'),'YES_NO',0) multirow,
to_char(null) transaction_description,
to_char(null) mandatory_collection,
to_char(null) background_collection,
to_char(null) transaction_enabled,
to_char(null) collection_trigger,
to_char(null) trigger_operator,
to_char(null) trigger_low_value,
to_char(null) trigger_high_value,
qc.name element_name,
qpc.prompt_sequence,
qpc.prompt element_prompt,
xxen_util.meaning(decode(qpc.enabled_flag,1,'Y','N'),'YES_NO',0) element_enabled,
xxen_util.meaning(decode(qpc.mandatory_flag,1,'Y','N'),'YES_NO',0) element_mandatory,
qpc.default_value,
xxen_util.meaning(decode(qpc.displayed_flag,1,'Y','N'),'YES_NO',0) displayed,
xxen_util.meaning(decode(qpc.read_only_flag,1,'Y','N'),'YES_NO',0) read_only,
xxen_util.meaning(decode(qpc.ss_poplist_flag,1,'Y','N'),'YES_NO',0) ss_poplist,
xxen_util.meaning(decode(qpc.information_flag,1,'Y','N'),'YES_NO',0) information,
qpc.decimal_precision,
qpc.uom_code,
to_char(null) value_code,
to_char(null) value_description,
qpcat.trigger_sequence action_trigger_seq,
xxen_util.meaning(qpcat.operator,'QA_OPERATOR',700) action_operator,
qpcat.low_value_other action_low_value,
qpcat.high_value_other action_high_value,
qa.description action_name,
qpca.message action_message,
qpcao.token_name output_variable,
qc2.name output_element,
null delete_record,
8 row_type,
qp.plan_id
from
qa_plans qp,
mtl_parameters mp,
qa_plan_chars qpc,
qa_chars qc,
qa_plan_char_action_triggers qpcat,
qa_plan_char_actions qpca,
qa_actions qa,
qa_plan_char_action_outputs qpcao,
qa_chars qc2
where
qp.organization_id=mp.organization_id and
qpc.plan_id=qp.plan_id and
qpc.char_id=qc.char_id and
qpcat.plan_id=qpc.plan_id and
qpcat.char_id=qpc.char_id and
qpca.plan_char_action_trigger_id=qpcat.plan_char_action_trigger_id and
qpca.action_id=qa.action_id and
qpcao.plan_char_action_id=qpca.plan_char_action_id and
qpcao.char_id=qc2.char_id and
1=1