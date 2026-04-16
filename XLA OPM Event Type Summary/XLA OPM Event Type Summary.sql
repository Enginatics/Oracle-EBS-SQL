/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA OPM Event Type Summary
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/xla-opm-event-type-summary/
-- Library Link: https://www.enginatics.com/reports/xla-opm-event-type-summary/
-- Run Report: https://demo.enginatics.com/

select
xte.entity_code,
xah.event_type_code,
gxeh.entity_code,
gxeh.txn_source,
gxeh.event_class_code,
gxeh.event_type_code,
gxeh.transaction_source_type_id,
mtst.transaction_source_type_name,
gxeh.transaction_type_id,
mtt.transaction_type_name,
xte.source_id_int_1,
xte.source_id_int_2,
xte.source_id_int_3,
xte.source_id_char_1,
gl.name ledger,
cct.cost_type
from
xla_ae_headers xah,
xla.xla_transaction_entities xte,
gmf_xla_extract_headers gxeh,
gl_ledgers gl,
cst_cost_types cct,
mtl_txn_source_types mtst,
mtl_transaction_types mtt
where
xah.entity_id=xte.entity_id and
xah.application_id=xte.application_id and
xte.application_id=555 and
xah.event_id=gxeh.event_id and
xte.source_id_int_2=gl.ledger_id and
xte.source_id_int_3=cct.cost_type_id and
gxeh.transaction_source_type_id=mtst.transaction_source_type_id(+) and
gxeh.transaction_type_id=mtt.transaction_type_id(+)