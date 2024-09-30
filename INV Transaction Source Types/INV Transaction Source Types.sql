/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Transaction Source Types
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/inv-transaction-source-types/
-- Library Link: https://www.enginatics.com/reports/inv-transaction-source-types/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(decode(mtst.user_defined_flag,'Y','U','S'),'CUSTOMIZATION_LEVEL',0) source,
mtst.transaction_source_type_name source_type,
mtst.description,
xxen_util.meaning(decode(mtst.user_defined_flag,'Y',mtst.validated_flag),'YES_NO_SYS',700) validation_type,
mtst.descriptive_flex_context_code context,
mtst.disable_date inactive_on,
&dff_columns
xxen_util.user_name(mtst.created_by) created_by,
xxen_util.client_time(mtst.creation_date) creation_date,
xxen_util.user_name(mtst.last_updated_by) last_updated_by,
xxen_util.client_time(mtst.last_update_date) last_update_date,
mtst.transaction_source_type_id
from
mtl_txn_source_types mtst
where
1=1
order by
mtst.user_defined_flag,
mtst.transaction_source_type_name