/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Item Where Used GUI
-- Description: Description: Item Where Used GUI Report

Provides equivalent functionality to the the following standard reports:
- Item Where Used Report GUI

Application: Bills of Material
Source: Item Where Used Report GUI (XML)
Short Name: BOMRWUITG_XML
DB package: BOM_BOMRWUIT_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/bom-item-where-used-gui/
-- Library Link: https://www.enginatics.com/reports/bom-item-where-used-gui/
-- Run Report: https://demo.enginatics.com/

select
x.item,
x.item_description,
x.item_type,
:p_item_rev revision,
x.orgcode organization,
x.p_level bom_level,
x.op op_seq,
x.parent bom,
x.alternate alternate_bom,
x.description bom_description,
x.parent_item_type,
x.effective_date,
x.disable_date,
x.basis_type basis,
x.quantity,
x.uom,
x.eng_bill,
x.status revised_item_status,
x.notice revised_item_eco
from
(
select
 msi.concatenated_segments item,
 msi.description item_description,
 xxen_util.meaning(msi.item_type,'ITEM_TYPE',3) item_type,
 bv.display_plan_level p_level,
 bv.component_op_seq_num op,
 bv.parent,
 bv.parent_alternate_designator alternate,
 bv.parent_description description,
 xxen_util.meaning(f.item_type,'ITEM_TYPE',3) parent_item_type,
 msi.inventory_item_status_code item_status,
 bv.component_effective_date effective_date,
 bv.component_disable_date disable_date,
 bv.basis_type basis_type,
 bv.component_quantity quantity,
 bv.parent_uom uom,
 xxen_util.meaning(bv.parent_engineering_bill,'BOM_NO_YES',700) eng_bill,
 bv.change_notice notice,
 bv.implemented_flag implemented_flag,
 bv.lowest_item_id,
 bv.sort_code,
 bv.organization_id,
 bv.revised_item_sequence_id,
 bom_bomrwuit_xmlp_pkg.get_orgcode(bv.organization_id) orgcode,
 bom_bomrwuit_xmlp_pkg.get_status(bv.revised_item_sequence_id, bv.implemented_flag, bv.change_notice) status
from
 mtl_system_items_vl msi,
 mtl_item_flexfields f,
 bom_implosion_view bv
where
 bv.lowest_item_id = msi.inventory_item_id and
 msi.organization_id = bv.organization_id and
 bv.parent_item_id = f.item_id and
 bv.organization_id = f.organization_id and
 bv.parent is not null and
 bv.sequence_id = :p_sequence_id and
 bv.current_level != 0 and
 nvl(xxen_util.lookup_code(:p_top_assly_flg,'SYS_YES_NO',700), 2) = 2
 &lp_top_assemblies_only_qry
) x
where
1=1
order by
x.item,
x.orgcode,
x.lowest_item_id,
x.sort_code