/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: COPY OF: BOM Routings
-- Description: Bill of material routings
-- Excel Examle Output: https://www.enginatics.com/example/copy-of-bom-routings/
-- Library Link: https://www.enginatics.com/reports/copy-of-bom-routings/
-- Run Report: https://demo.enginatics.com/

select
haou.name org_name,
mp.organization_code,
decode(bor.routing_type,1,'Manufacturing',2,'Engineering',bor.routing_type) type,
decode(bor.cfm_routing_flag,1,'Flow',2,'Discrete Job',bor.cfm_routing_flag) cfm_routing,
wl.line_code,
msiv.concatenated_segments item,
msiv.description item_desc,
bor.alternate_routing_designator alternate,
bos.operation_seq_num sequence,
bso.operation_code code,
bos.operation_description description,
decode(bos.reference_flag,1,'Y') referenced,
bd.department_code department,
bd.description department_desc,
bos.operation_type,
bos.effectivity_date
from
hr_all_organization_units haou,
mtl_parameters mp,
bom_operational_routings bor,
mtl_system_items_vl msiv,
wip_lines wl,
bom_operation_sequences bos,
bom_standard_operations bso,
bom_departments bd
where
1=1 and
haou.organization_id=bor.organization_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msiv.inventory_item_id and
bor.organization_id=msiv.organization_id and
bor.line_id=wl.line_id(+) and
bor.organization_id=wl.organization_id(+) and
bor.routing_sequence_id=bos.routing_sequence_id(+) and
bos.department_id=bd.department_id and
bos.standard_operation_id=bso.standard_operation_id(+)
order by
haou.name,
mp.organization_code,
msiv.concatenated_segments,
bor.alternate_routing_designator nulls first,
bos.operation_seq_num