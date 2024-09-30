/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Transaction Types
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/inv-transaction-types/
-- Library Link: https://www.enginatics.com/reports/inv-transaction-types/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(decode(mtt.user_defined_flag,'Y','U','S'),'CUSTOMIZATION_LEVEL',0) source,
mtt.transaction_type_name,
mtt.description,
mtst.transaction_source_type_name source_type,
xxen_util.meaning(mtt.transaction_action_id,'MTL_TRANSACTION_ACTION',700) action,
xxen_util.meaning(decode(mtt.type_class,1,1),'SYS_YES_NO',700) project,
xxen_util.meaning(decode(mtt.shortage_msg_online_flag,1,1),'SYS_YES_NO',700) shortage_msg_online,
xxen_util.meaning(decode(mtt.shortage_msg_background_flag,1,1),'SYS_YES_NO',700) shortage_msg_notification,
xxen_util.meaning(decode(mtt.status_control_flag,1,1),'SYS_YES_NO',700) status_control,
xxen_util.meaning(decode(mtt.location_required_flag,'Y','Y'),'YES_NO',0) location_required,
&dff_columns
xxen_util.user_name(mtt.created_by) created_by,
xxen_util.client_time(mtt.creation_date) creation_date,
xxen_util.user_name(mtt.last_updated_by) last_updated_by,
xxen_util.client_time(mtt.last_update_date) last_update_date,
mtt.transaction_source_type_id,
mtt.transaction_action_id,
mtt.transaction_type_id
from
mtl_transaction_types mtt,
mtl_txn_source_types mtst
where
1=1 and
mtt.transaction_source_type_id=mtst.transaction_source_type_id
order by
mtt.user_defined_flag,
mtt.transaction_source_type_id,
mtt.transaction_action_id,
mtt.transaction_type_name