/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Batch Lot Genealogy
-- Description: Oracle Process Manufacturing (OPM) batch lot genealogy as a multi-level tree, as shown in the Source and Where Used tabs of the Oracle Genealogy form.
-- Source walks from a lot through its producing batch to the ingredient lots, to any depth. Where Used walks from a lot through the consuming batches to the product lots. Each tree starts with its start lot at level 0.
-- Each row is a lot or batch with its level, lot status, grade, dates and the WIP issue or completion that created the link. Ended genealogy links are excluded.
-- Source, Supplier and Supplier Site show each lot's origination as in the form: the document and trading partner of the lot's first transaction. Supplier Site is shown for purchase order receipts only.
-- Without an Item or Lot Number, only lots with no other lot above them in the chosen direction start a tree, so each chain is listed once instead of under every lot within it. Enter an Item or Lot Number to see the tree of any lot.
-- Excel Example Output: https://www.enginatics.com/example/opm-batch-lot-genealogy/
-- Library Link: https://www.enginatics.com/reports/opm-batch-lot-genealogy/
-- Run Report: https://demo.enginatics.com/

select
mp_s.organization_code start_organization,
msiv_s.concatenated_segments start_item,
mln_s.lot_number starting_lot_number,
z.hierarchy_level,
lpad(' ',2*z.hierarchy_level)||coalesce(z.lot_number,z.batch,z.serial_number) hierarchy,
xxen_util.meaning(z.object_type,'INV_GENEALOGY_OBJECT_TYPE',700) object_type,
mp.organization_code,
(select msiv.concatenated_segments from mtl_system_items_vl msiv where z.inventory_item_id=msiv.inventory_item_id and z.organization_id=msiv.organization_id) item,
(select msiv.description from mtl_system_items_vl msiv where z.inventory_item_id=msiv.inventory_item_id and z.organization_id=msiv.organization_id) item_description,
z.lot_number lot,
z.batch,
mms.status_code lot_status,
z.grade_code lot_grade,
z.origination_date,
z.expiration_date,
case when mmt_o.transaction_source_type_id=13 then mmt_o.transaction_source_name else (select inv_object_genealogy.getsource(mmt_o.organization_id,mmt_o.transaction_source_type_id,mmt_o.transaction_source_id) from dual) end source,
(select inv_object_genealogy.gettradingpartner(mmt_o.organization_id,mmt_o.transaction_source_type_id,mmt_o.transaction_source_id,mmt_o.trx_source_line_id,mmt_o.transfer_organization_id) from dual) supplier,
(select assa.vendor_site_code from po_headers_all pha, ap_supplier_sites_all assa where mmt_o.transaction_source_type_id=1 and mmt_o.transaction_source_id=pha.po_header_id and pha.vendor_site_id=assa.vendor_site_id) supplier_site,
xxen_util.meaning(z.genealogy_type,'INV_GENEALOGY_TYPE',700) genealogy_type,
mtt.transaction_type_name transaction_type,
mmt.transaction_date,
mmt.transaction_quantity,
mmt.transaction_uom
from
(
select
x.*,
coalesce(mln.inventory_item_id,we.primary_item_id,msn.inventory_item_id) inventory_item_id,
coalesce(mln.organization_id,we.organization_id,msn.current_organization_id) organization_id,
mln.lot_number,
mln.status_id,
mln.grade_code,
mln.origination_date,
mln.expiration_date,
(select min(mtln.transaction_id) from mtl_transaction_lot_numbers mtln, mtl_material_transactions mmt_f where mln.lot_number=mtln.lot_number and mln.inventory_item_id=mtln.inventory_item_id and mln.organization_id=mtln.organization_id and mtln.transaction_id=mmt_f.transaction_id and mmt_f.transaction_action_id not in (24,30)) origination_txn_id,
nvl(gbh.batch_no,we.wip_entity_name) batch,
msn.serial_number
from
(
select /*+ cardinality(rowgen 2) */
case when rowgen.column_value=1 then w.start_object_id else w.object_id end object_id,
case when rowgen.column_value=1 then 1 else w.object_type end object_type,
case when rowgen.column_value=1 then 0 else w.hierarchy_level end hierarchy_level,
case when rowgen.column_value=2 then w.genealogy_type end genealogy_type,
case when rowgen.column_value=2 then w.origin_txn_id end origin_txn_id,
w.start_object_id,
case when rowgen.column_value=1 then w.row_num-0.5 else w.row_num end row_num
from
(
select
v.*,
row_number() over (partition by v.start_object_id order by v.row_num) start_rn
from
(
select /*+ connect_by_filtering */
connect_by_root y.tree_parent_id start_object_id,
level hierarchy_level,
y.object_id,
y.object_type,
y.genealogy_type,
y.origin_txn_id,
rownum row_num
from
(
select
&genealogy_direction,
mog.genealogy_type,
mog.origin_txn_id
from
mtl_object_genealogy mog
where
(mog.end_date_active is null or mog.end_date_active>sysdate)
) y
connect by nocycle
prior y.object_id=y.tree_parent_id
start with
y.tree_parent_id in
(
select
mln_s.gen_object_id
from
mtl_lot_numbers mln_s,
mtl_parameters mp_s,
(
select distinct
nt.object_id
from
(
select
g.object_id
from
(select &genealogy_direction from mtl_object_genealogy mog where mog.end_date_active is null or mog.end_date_active>sysdate) g
where
g.tree_parent_type=1 and
g.object_type=1 and
g.tree_parent_id<>g.object_id and
not exists (select null from (select &genealogy_direction from mtl_object_genealogy mog where mog.end_date_active is null or mog.end_date_active>sysdate) g2 where g.tree_parent_id=g2.object_id and g.object_id=g2.tree_parent_id) &start_filter
union all
select
g.object_id
from
(select &genealogy_direction from mtl_object_genealogy mog where mog.end_date_active is null or mog.end_date_active>sysdate) g,
(
select
connect_by_root h.tree_parent_id anchor_lot_id,
h.object_id
from
(select &genealogy_direction from mtl_object_genealogy mog where mog.end_date_active is null or mog.end_date_active>sysdate) h
connect by nocycle
prior h.object_id=h.tree_parent_id and
h.object_type<>1
start with
h.tree_parent_type=1 and
h.object_type<>1 &start_filter
) j
where
g.tree_parent_id=j.object_id and
g.object_type=1 and
j.anchor_lot_id<>g.object_id &start_filter
) nt
) nt
where
1=1 and
mln_s.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mln_s.organization_id=mp_s.organization_id and
mln_s.gen_object_id=nt.object_id(+) and
nt.object_id is null
)
) v
) w,
table(xxen_util.rowgen(2)) rowgen
where
(rowgen.column_value=2 or w.start_rn=1)
) x,
mtl_lot_numbers mln,
wip_entities we,
gme_batch_header gbh,
mtl_serial_numbers msn
where
x.object_id=mln.gen_object_id(+) and
x.object_id=we.gen_object_id(+) and
we.wip_entity_id=gbh.batch_id(+) and
x.object_id=msn.gen_object_id(+)
) z,
mtl_lot_numbers mln_s,
mtl_system_items_vl msiv_s,
mtl_parameters mp_s,
mtl_parameters mp,
mtl_material_statuses_vl mms,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_material_transactions mmt_o
where
z.start_object_id=mln_s.gen_object_id and
mln_s.inventory_item_id=msiv_s.inventory_item_id and
mln_s.organization_id=msiv_s.organization_id and
mln_s.organization_id=mp_s.organization_id and
z.organization_id=mp.organization_id(+) and
z.status_id=mms.status_id(+) and
z.origin_txn_id=mmt.transaction_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
z.origination_txn_id=mmt_o.transaction_id(+)
order by
mp_s.organization_code,
msiv_s.concatenated_segments,
mln_s.lot_number,
z.row_num
