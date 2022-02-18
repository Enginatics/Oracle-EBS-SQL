/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL FSG Row Orders
-- Description: Financial Statement Generator row order listing
-- Excel Examle Output: https://www.enginatics.com/example/gl-fsg-row-orders/
-- Library Link: https://www.enginatics.com/reports/gl-fsg-row-orders/
-- Run Report: https://demo.enginatics.com/

select
rro.name row_order,
rro.description,
xxen_util.meaning(decode(rro.security_flag,'Y','Y'),'YES_NO',0) security,
rro.column_name,
rro.column_number column_order,
xxen_util.meaning(rro.row_rank_type,'RANKING_TYPE',168) ranking,
rrssv.segment_sequence sequence,
rrssv.seg_name segment,
xxen_util.meaning(rrssv.seg_order_type,decode(rrssv.application_column_name,'LEDGER_SEGMENT','LEDGER_ORDERING_TYPE','ORDERING_TYPE'),168) order_by,
xxen_util.meaning(rrssv.seg_display_type,decode(rrssv.application_column_name,'LEDGER_SEGMENT','LEDGER_SEG_DISPLAY_TYPE','SEG_DISPLAY_TYPE'),168) display,
rrssv.segment_width width,
xxen_util.user_name(rrssv.created_by) created_by,
xxen_util.client_time(rrssv.creation_date) creation_date,
xxen_util.user_name(rrssv.last_updated_by) last_updated_by,
xxen_util.client_time(rrssv.last_update_date) last_update_date,
fifsv.id_flex_structure_name,
rro.structure_id,
rro.row_order_id
from
rg_row_orders rro,
fnd_id_flex_structures_vl fifsv,
rg_row_segment_sequences_v rrssv
where
1=1 and
rro.application_id=fifsv.application_id and
rro.id_flex_code=fifsv.id_flex_code and
rro.structure_id=fifsv.id_flex_num and
rro.row_order_id=rrssv.row_order_id and
rro.structure_id=rrssv.structure_id
order by
fifsv.id_flex_structure_name,
rro.name,
rrssv.segment_sequence