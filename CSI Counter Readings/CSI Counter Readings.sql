/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Counter Readings
-- Description: Counter and meter readings, one row per reading, with the item instance or maintainable asset and the service contract the counter belongs to.
-- Reading Change is the net reading minus the net reading of the counter's previous enabled reading, so it shows the usage since the last reading, also across resets and adjustments. It is blank for the first reading of a counter.
-- Work Order is the maintenance work order on whose completion the reading was recorded. Contract Number lists the contract of a counter attached to a contract line, or the contracts whose usage lines cover the counter.
-- Excel Example Output: https://www.enginatics.com/example/csi-counter-readings/
-- Library Link: https://www.enginatics.com/reports/csi-counter-readings/
-- Run Report: https://demo.enginatics.com/

select
ccv.name counter,
ccv.description counter_description,
xxen_util.meaning(ccv.counter_type,'CSI_COUNTER_TYPE',542) counter_type,
ccv.uom_code uom,
xxen_util.meaning(to_char(ccv.reading_type),'CSI_COUNTER_READING_TYPE',542) reading_type,
cii.instance_number,
msiv.concatenated_segments item,
msiv.description item_description,
cii.serial_number,
mp.organization_code,
(select hp.party_name from hz_parties hp where cii.owner_party_id=hp.party_id) owner,
coalesce(okhab.contract_number,
(
select
listagg(y.contract_number,', ') within group (order by y.contract_number)
from
(select distinct oki.object1_id1, okhab2.contract_number from okc_k_items oki, okc_k_headers_all_b okhab2 where oki.jtot_object1_code='OKX_COUNTER' and oki.dnz_chr_id=okhab2.id) y
where
to_char(ccr.counter_id)=y.object1_id1
)) contract_number,
oklb.line_number contract_line,
ccr.value_timestamp reading_date,
ccr.counter_reading reading,
ccr.net_reading,
ccr.life_to_date_reading,
ccr.net_reading-
(
select
max(ccr2.net_reading) keep (dense_rank last order by ccr2.value_timestamp, ccr2.counter_value_id)
from
csi_counter_readings ccr2
where
ccr.counter_id=ccr2.counter_id and
ccr2.value_timestamp<=ccr.value_timestamp and
(ccr2.value_timestamp<ccr.value_timestamp or ccr2.counter_value_id<ccr.counter_value_id) and
nvl(ccr2.disabled_flag,'N')='N'
) reading_change,
xxen_util.meaning(ccr.reset_mode,'CSI_CTR_READING_RESET_TYPE',542) reset_mode,
ccr.reset_reason,
xxen_util.meaning(ccr.adjustment_type,'CSI_CTR_ADJUST_READING_TYPE',542) adjustment_type,
ccr.adjustment_reading,
xxen_util.yes(ccr.disabled_flag) disabled,
ccr.comments,
ctt.source_txn_type_name source,
coalesce(
(select we.wip_entity_name from wip_entities we where ct.transaction_type_id=92 and ct.source_header_ref_id=we.wip_entity_id),
(select we.wip_entity_name from eam_meter_readings emr, wip_entities we where ccr.counter_value_id=emr.meter_reading_id and emr.wip_entity_id=we.wip_entity_id)
) work_order,
xxen_util.user_name(ccr.created_by) created_by,
ccr.creation_date
from
(
select
ccr.*,
(select max(cca.source_object_id) keep (dense_rank last order by cca.start_date_active) from csi_counter_associations cca where ccr.counter_id=cca.counter_id and cca.source_object_code='CP') instance_id,
(select max(cca.source_object_id) keep (dense_rank last order by cca.start_date_active) from csi_counter_associations cca where ccr.counter_id=cca.counter_id and cca.source_object_code='CONTRACT_LINE') contract_line_id
from
csi_counter_readings ccr
) ccr,
csi_counters_vl ccv,
csi_item_instances cii,
mtl_system_items_vl msiv,
mtl_parameters mp,
okc_k_lines_b oklb,
okc_k_headers_all_b okhab,
csi_transactions ct,
csi_txn_types ctt
where
1=1 and
(cii.last_vld_organization_id is null or msiv.eam_item_type is null or cii.last_vld_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)) and
ccr.counter_id=ccv.counter_id and
ccr.instance_id=cii.instance_id(+) and
cii.inventory_item_id=msiv.inventory_item_id(+) and
cii.last_vld_organization_id=msiv.organization_id(+) and
cii.last_vld_organization_id=mp.organization_id(+) and
ccr.contract_line_id=oklb.id(+) and
oklb.dnz_chr_id=okhab.id(+) and
ccr.transaction_id=ct.transaction_id(+) and
ct.transaction_type_id=ctt.transaction_type_id(+)
order by
ccv.name,
cii.instance_number,
ccr.value_timestamp,
ccr.counter_value_id
