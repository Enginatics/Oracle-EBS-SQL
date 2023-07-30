/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Routings
-- Description: Master data report showing bill of material routings with item codes and sequences.
-- Excel Examle Output: https://www.enginatics.com/example/bom-routings/
-- Library Link: https://www.enginatics.com/reports/bom-routings/
-- Run Report: https://demo.enginatics.com/

select
haouv.name org_name,
mp.organization_code,
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) type,
decode(bor.cfm_routing_flag,1,'Flow',2,'Discrete Job',bor.cfm_routing_flag) cfm_routing,
wl.line_code,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
bor.alternate_routing_designator alternate,
bos.operation_seq_num operation_sequence,
bso.operation_code,
bos.operation_description,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code,
bd.description department_description,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
bom_operational_routings bor,
mtl_system_items_vl msiv,
wip_lines wl,
bom_operation_sequences bos,
bom_standard_operations bso,
bom_departments bd
where
1=1 and
haouv.organization_id=bor.organization_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msiv.inventory_item_id and
bor.organization_id=msiv.organization_id and
bor.line_id=wl.line_id(+) and
bor.organization_id=wl.organization_id(+) and
bor.routing_sequence_id=bos.routing_sequence_id(+) and
bos.department_id=bd.department_id and
bos.standard_operation_id=bso.standard_operation_id(+)
order by
haouv.name,
mp.organization_code,
msiv.concatenated_segments,
bor.alternate_routing_designator nulls first,
bos.operation_seq_num