/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Plan Transactions
-- Description: Every collection transaction an Oracle Quality collection plan is attached to, with the trigger conditions that decide whether collection actually fires, the Mandatory Collection, Background Collection and Enabled flags, and each trigger's field, database field, datatype, operator and low and high values. Attachments that collect unconditionally are listed too, with a blank Collection Trigger.

Attaching a collection plan to a transaction is what makes Oracle Quality collect anything at all: until a plan is attached to a transaction such as Receiving Transactions or Completion Transactions it is only a definition, and nothing is ever collected against it. Trigger conditions narrow that further, so the attachment on its own does not tell you when collection happens - a plan attached to Completion Transactions with a trigger of Item equals a single assembly collects for that assembly and no other. Mandatory Collection means the transaction cannot be saved without quality results, and Background Collection means results are collected without prompting the operator.

A plan can be attached to the same transaction more than once, each attachment carrying its own trigger conditions. Transaction Attachments counts how many attachments the plan has for that transaction, so one attachment with several triggers can be told apart from several separate attachments. Trigger Field is the form prompt the trigger tests and Trigger Database Field is the column behind it, both taken from the transaction's own trigger list in qa_txn_collection_triggers, so a condition can be traced from the prompt an implementer sees to the column a data load has to supply.

Leave the parameters blank for the full picture, or narrow with Organization, Collection Plan, Plan Type, Transaction and Collection Trigger. Mandatory Collection Only and Enabled Transactions Only restrict to attachments carrying those flags. Leaving Organization blank returns every collection plan the responsibility has inventory organization access to, plus the seeded template plans, which are not owned by an inventory organization and therefore show a blank Organization Code.
-- Excel Examle Output: https://www.enginatics.com/example/qa-collection-plan-transactions/
-- Library Link: https://www.enginatics.com/reports/qa-collection-plan-transactions/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
qp.name plan_name,
qp.description plan_description,
xxen_util.meaning(qp.plan_type_code,'COLLECTION_PLAN_TYPE',3) plan_type,
xxen_util.meaning(to_char(qpt.transaction_number),'QA_TXN_NAME',700) transaction_name,
xxen_util.description(to_char(qpt.transaction_number),'QA_TXN_NAME',700) transaction_description,
xxen_util.yes(case when qpt.mandatory_collection_flag=1 then 'Y' end) mandatory_collection,
xxen_util.yes(case when qpt.background_collection_flag=1 then 'Y' end) background_collection,
xxen_util.yes(case when qpt.enabled_flag=1 then 'Y' end) enabled,
(select count(*) from qa_plan_transactions qpt2 where qpt.plan_id=qpt2.plan_id and qpt.transaction_number=qpt2.transaction_number) transaction_attachments,
qc.name collection_trigger,
(select qtct.form_description from qa_txn_collection_triggers qtct where qpt.transaction_number=qtct.transaction_number and qpct.collection_trigger_id=qtct.collection_trigger_id) trigger_field,
(select qtct.database_field from qa_txn_collection_triggers qtct where qpt.transaction_number=qtct.transaction_number and qpct.collection_trigger_id=qtct.collection_trigger_id) trigger_database_field,
xxen_util.meaning(qc.datatype,'QA_CHAR_DATATYPE',700) trigger_datatype,
xxen_util.meaning(qpct.operator,'QA_OPERATOR',700) trigger_operator,
qpct.low_value trigger_low_value,
qpct.high_value trigger_high_value,
xxen_util.user_name(nvl(qpct.created_by,qpt.created_by)) created_by,
xxen_util.client_time(nvl(qpct.creation_date,qpt.creation_date)) creation_date,
xxen_util.user_name(nvl(qpct.last_updated_by,qpt.last_updated_by)) last_updated_by,
xxen_util.client_time(nvl(qpct.last_update_date,qpt.last_update_date)) last_update_date
from
qa_plans qp,
mtl_parameters mp,
qa_plan_transactions qpt,
qa_plan_collection_triggers qpct,
qa_chars qc
where
qp.organization_id=mp.organization_id(+) and
qp.plan_id=qpt.plan_id and
qpt.plan_transaction_id=qpct.plan_transaction_id(+) and
qpct.collection_trigger_id=qc.char_id(+) and
(qp.organization_id=0 or qp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
1=1
order by
mp.organization_code,
qp.name,
transaction_name,
qpt.plan_transaction_id,
qc.name