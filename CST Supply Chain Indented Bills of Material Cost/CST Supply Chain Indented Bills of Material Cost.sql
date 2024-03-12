/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Supply Chain Indented Bills of Material Cost
-- Description: This report is based on the (static) Oracle Supply Chain Indented Bills of Material Cost Report and merely sums up the available information from the Cost Type.  It does not do a Cost Rollup and as a result, the "Extended Cost" column might not add up to the total item cost for the assembly especially  if changes have been made to the bills of material, routing or item costs, since the last cost rollup.  If this is the case, run a Supply Chain Cost Rollup in Pending or some other cost type (such as Current) for reporting purposes, to synchronize the cost information and then use this report, using the same cost type, to correctly report your item costs.

Imported from BI Publisher
Description: Supply Chain Indented Bills of Material Cost Report
Application: Bills of Material
Source: Supply Chain Indented Bills of Material Cost Report (XML)
Short Name: CSTRSCCRI_XML
DB package: BOM_CSTRSCCR_XMLP_PKG

-- |  Version   Modified on       Modified  by              Description
-- |  ======= ===========   ==============  =========================================
-- |  1.0            04-APR-2023    Eric Clegg               Initial Conversion
--|   1.1            24-DEC-2023   Eric Clegg               Added Multi-Select Item Parameter
-- Excel Examle Output: https://www.enginatics.com/example/cst-supply-chain-indented-bills-of-material-cost/
-- Library Link: https://www.enginatics.com/reports/cst-supply-chain-indented-bills-of-material-cost/
-- Run Report: https://demo.enginatics.com/

with
--
-- Q_ASSEMBLY
--
q_assembly as
(
select
 -- assembly display
 sob_assm.name ledger,
 ood_assm.organization_code organization_code,
 ood_assm.organization_name organization_name,
 msi_assm.concatenated_segments assembly,
 msi_assm.description assembly_description,
 xxen_util.meaning(msi_assm.item_type,'ITEM_TYPE',3) assembly_item_type,
 mc_assm.concatenated_segments assembly_category,
 msi_assm.primary_uom_code assembly_uom,
 fc_assm.currency_code assembly_currency_code,
 -- assembly hidden
 csbs.rollup_id assm_rollup_id,
 csbs.top_inventory_item_id assm_top_inventory_item_id,
 csbs.top_organization_id assm_top_organization_id,
 fc_assm.extended_precision assm_ext_precision
from
 cst_sc_bom_structures        csbs,
 mtl_system_items_vl          msi_assm,
 mtl_item_categories          mic_assm,
 mtl_categories_kfv           mc_assm,
 org_organization_definitions ood_assm,
 gl_sets_of_books             sob_assm,
 fnd_currencies               fc_assm,
 bom_parameters               bp
where
 csbs.rollup_id             = :p_rollup_id and
 csbs.sort_order            = 1 and
 msi_assm.inventory_item_id = csbs.top_inventory_item_id and
 msi_assm.organization_id   = csbs.top_organization_id and
 mic_assm.inventory_item_id = csbs.top_inventory_item_id and
 mic_assm.organization_id   = csbs.top_organization_id and
 mic_assm.category_set_id   = :p_category_set_id_out and
 mc_assm.category_id        = mic_assm.category_id and
 ood_assm.organization_id   = csbs.top_organization_id and
 sob_assm.set_of_books_id   = ood_assm.set_of_books_id and
 fc_assm.currency_code      = sob_assm.currency_code and
 bp.organization_id         = csbs.top_organization_id and
 msi_assm.inventory_item_status_code <> nvl(bp.bom_delete_status_code , 'NOT' || msi_assm.inventory_item_status_code)
),
--
-- Q_COMPONENTS
--
q_components as
(
select
 -- component assembly join columns
 abs(csbs.rollup_id) comp_rollup_id,
 csbs.top_inventory_item_id comp_top_inventory_item_id,
 csbs.top_organization_id comp_top_organization_id,
 -- component visible columns
 decode(:p_report_type_type, 1, lpad('.',csbs.bom_level-1,'.')||to_char(csbs.bom_level-1), null) component_level,
 bic.operation_seq_num operation_seq,
 msiv.concatenated_segments component,
 msiv.description component_description,
 xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) component_item_type,
 mp.organization_code component_organiziation,
 csbs.component_revision revision,
 xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy,
 xxen_util.meaning(csbs.include_in_cost_rollup,'SYS_YES_NO',700) include_in_rollup,
 xxen_util.meaning(nvl(cic.based_on_rollup_flag,2),'SYS_YES_NO',700) based_on_rollup,
 xxen_util.meaning(nvl(cic.inventory_asset_flag,2),'SYS_YES_NO',700) inventory_asset,
 xxen_util.meaning(csbs.phantom_flag,'SYS_YES_NO',700) phantom,
 xxen_util.meaning(nvl(bic.basis_type,1),'CST_BASIS',700) basis,
 bic.component_yield_factor yield,
 bic.planning_factor planning_percent,
 msiv.primary_uom_code component_uom,
 decode(:p_report_type_type, 1, csbs.component_quantity, null) component_quantity,
 cic.shrinkage_rate component_shrinkage_rate,
 csbs.extended_quantity component_extended_quantity,
 nvl( cic.item_cost,0) component_item_unit_cost,
-- decode(csbs.extend_cost_flag,
--   2,0,(decode(:p_material_dtl_flag,
--               1,0,decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_material,0),0) +
--                   decode(decode(:p_phantom_mat,1,0,1) * decode(csbs.bom_level,1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_material,0))
--              ) +
--        decode(:p_material_overhead_dtl_flag,
--               1,0,decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_material_overhead,0),0) +
--                   decode(decode(:p_phantom_mat,1,0,1) * decode(csbs.bom_level,1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_material_overhead,0))
--              ) +
--        decode(decode(nvl(bp.use_phantom_routings,2),1,1,0) * decode(csbs.phantom_flag,1,1,0),
--               1,0,decode(:p_routing_dtl_flag,
--                          1,0,decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_resource,0) + nvl(cic.pl_outside_processing,0) + nvl(cic.pl_overhead,0),0) +
--                              decode(decode(nvl(bp.use_phantom_routings,2),1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_resource,0) + nvl(cic.tl_outside_processing,0) + nvl(cic.tl_overhead,0))
--                         )
--              )
--       )
-- ) * csbs.extended_quantity component_extended_cost,
 nvl( cic.item_cost,0) * csbs.extended_quantity component_extended_cost,
 decode(csbs.extend_cost_flag,
   2,0,((decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_material,0),0) +
         decode(decode(:p_phantom_mat,1,0,1) * decode(csbs.bom_level,1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_material,0))
        ) +
        (decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_material_overhead,0),0) +
         decode(decode(:p_phantom_mat,1,0,1) * decode(csbs.bom_level,1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_material_overhead,0))
        ) +
        decode(decode(nvl(bp.use_phantom_routings,2),1,1,0) * decode(csbs.phantom_flag,1,1,0),
               1,0,(decode(csbs.bom_level,:p_report_level_out,nvl(cic.pl_resource,0) + nvl(cic.pl_outside_processing,0) + nvl(cic.pl_overhead,0),0) +
                    decode(decode(nvl(bp.use_phantom_routings,2),1,0,1) * decode(csbs.phantom_flag,1,1,0),1,0,nvl(cic.tl_resource,0) + nvl(cic.tl_outside_processing,0) + nvl(cic.tl_overhead,0))
                   )
              )
       )
 ) * csbs.extended_quantity component_contributing_cost,
 fc.currency_code component_currency_code,
 -- component hidden columns
 csbs.sort_order comp_sort_order,
 cic.cost_type_id comp_cost_type,
 csbs.assembly_item_id,
 fc.extended_precision comp_ext_precision,
 bom_common_xmlp_pkg.get_precision(fc.extended_precision) comp_precision
from
 cst_sc_bom_structures       csbs,
 bom_parameters              bp,
 bom_inventory_components    bic,
 mtl_system_items_vl         msiv,
 hr_organization_information hoi,
 gl_sets_of_books            sob,
 fnd_currencies              fc,
 cst_item_costs              cic,
 mtl_parameters              mp
where
 csbs.rollup_id = decode(:p_report_type_type, 1, :p_rollup_id, -1*:p_rollup_id) and
 csbs.bom_level <= :p_report_level_out and
 bp.organization_id (+) = csbs.component_organization_id and
 bic.component_sequence_id(+) = csbs.component_sequence_id and
 msiv.inventory_item_id = csbs.component_item_id and
 msiv.organization_id = csbs.component_organization_id and
 hoi.organization_id = csbs.component_organization_id and
 hoi.org_information_context = 'Accounting Information' and
 sob.set_of_books_id = to_number(hoi.org_information1) and
 fc.currency_code = sob.currency_code and
 cic.inventory_item_id (+) = csbs.component_item_id and
 cic.organization_id (+) = csbs.component_organization_id and
 (   cic.cost_type_id = :p_cost_type_id
  or ( cic.cost_type_id = :p_default_cost_type_id and
       not exists
       (select 'x'
        from   cst_item_costs cic1
        where  cic1.inventory_item_id = csbs.component_item_id
        and    cic1.organization_id = csbs.component_organization_id
        and    cic1.cost_type_id = :p_cost_type_id
       )
     )
  or ( cic.cost_type_id = mp.primary_cost_method and
       not exists
       (select 'x'
        from   cst_item_costs cic2
        where  cic2.inventory_item_id = csbs.component_item_id
        and    cic2.organization_id = csbs.component_organization_id
        and    cic2.cost_type_id in (:p_cost_type_id, :p_default_cost_type_id)
       )
     )
  or ( nvl(cic.cost_type_id, -1) = -1 and
       not exists
       (select 'x'
        from   cst_item_costs cic3
        where  cic3.inventory_item_id = csbs.component_item_id
        and    cic3.organization_id = csbs.component_organization_id
        and    cic3.cost_type_id in (:p_cost_type_id, :p_default_cost_type_id, mp.primary_cost_method)
       )
     )
 ) and
 mp.organization_id = csbs.component_organization_id
),
--
-- Q_COSTS
--
q_costs as
(
select
 -- costs join columns
 abs(csbs.rollup_id) res_rollup_id,
 csbs.top_inventory_item_id res_top_inventory_item_id,
 csbs.top_organization_id res_top_organization_id,
 csbs.sort_order res_sort_order,
 cicd.cost_type_id res_cost_type,
 -- costs visible columns
 xxen_util.meaning(cicd.level_type,'CST_LEVEL',700) level_type,
 cicd.operation_seq_num resource_operation_seq,
 decode(cicd.basis_resource_id,null,cce.cost_element, ' ' || cce.cost_element) cost_element,
 br.resource_code sub_element,
 nvl(bd.department_code,decode(cicd.source_organization_id,cicd.organization_id,null,mp2.organization_code)) department,
 decode(cicd.cost_element_id, 3, xxen_util.meaning(nvl(br.allow_costs_flag,1),'SYS_YES_NO',700), 4, xxen_util.meaning(nvl(br.allow_costs_flag,1),'SYS_YES_NO',700), to_char(null)) costed,
 xxen_util.meaning(cicd.basis_type,'CST_BASIS_SHORT',700) resource_basis,
 br.unit_of_measure resource_uom,
 nvl(cicd.usage_rate_or_amount,0) rate_or_amount,
 decode(cicd.cost_element_id,2,csbs.extended_quantity,5,csbs.extended_quantity,1) * cicd.basis_factor * cicd.net_yield_or_shrinkage_factor basis_factor,
 decode(cicd.cost_element_id,2,1,5,1,csbs.extended_quantity ) * cicd.usage_rate_or_amount extended_rate_or_amount,
 decode(cicd.cost_element_id,3,cicd.resource_rate,4,cicd.resource_rate,to_number(null)) resource_unit_cost,
 decode(decode(csbs.phantom_flag,1,1,0) * decode(csbs.assembly_organization_id,csbs.component_organization_id,1,0),
        1, decode(cicd.level_type,
                  2,1,
                    decode(cicd.cost_element_id,
                           3,0,
                           4,0,
                           5,0,
                             decode(:p_phantom_mat,1,1,0)
                          )
                 ) *
           decode(csbs.extend_cost_flag,
                  2,0,
                    csbs.extended_quantity * decode(cicd.item_cost,cicd.yielded_cost,0,cicd.item_cost)
                 ),
           decode(csbs.extend_cost_flag,2,0,csbs.extended_quantity * cicd.item_cost)
      ) extended_cost,
 -- costs hidden columns
 cicd.level_type level_type_code,
 cicd.cost_element_id,
 cicd.resource_id,
 cicd.basis_resource_id
from
 cst_sc_bom_structures    csbs,
 bom_parameters           bp,
 bom_inventory_components bic,
 mtl_system_items_vl      msiv,
 cst_item_cost_details    cicd,
 cst_cost_elements        cce,
 bom_resources            br,
 bom_departments          bd,
 mtl_parameters           mp2
where
 csbs.rollup_id = decode(:p_report_type_type,1,:p_rollup_id,-1*:p_rollup_id) and
 csbs.bom_level <= :p_report_level_out and
 bp.organization_id (+) = csbs.component_organization_id and
 bic.component_sequence_id(+) = csbs.component_sequence_id and
 msiv.inventory_item_id = csbs.component_item_id and
 msiv.organization_id = csbs.component_organization_id and
 cicd.inventory_item_id = csbs.component_item_id and
 cicd.organization_id = csbs.component_organization_id and
 (   (csbs.bom_level < :p_report_level_out and cicd.level_type <> 2)
  or (cicd.item_cost=cicd.yielded_cost and nvl(cicd.source_organization_id,cicd.organization_id) = cicd.organization_id)
  or (csbs.bom_level = :p_report_level_out)
  or (cicd.vendor_id is not null)
  or exists
     (select 'x'
      from   cst_item_costs cia3
      where  cia3.inventory_item_id = csbs.component_item_id
      and    cia3.organization_id = csbs.component_organization_id
      and    cia3.cost_type_id = cicd.cost_type_id
      and    cia3.based_on_rollup_flag = 2
     )
 ) and
 (   (:p_material_dtl_flag = 1)
  or (:p_material_dtl_flag = 2 and cicd.cost_element_id <> 1)
 ) and
 (   (:p_material_overhead_dtl_flag = 1)
  or (:p_material_overhead_dtl_flag = 2 and cicd.cost_element_id <> 2)
 ) and
 (   (:p_routing_dtl_flag = 1)
  or (:p_routing_dtl_flag = 2 and cicd.cost_element_id not in (3,4,5))
 ) and
 cce.cost_element_id (+) = cicd.cost_element_id and
 bd.department_id (+) = cicd.department_id and
 br.resource_id (+) = cicd.resource_id and
 mp2.organization_id (+) = cicd.source_organization_id
),
--
-- Q_SUMMARY
--
q_summary as
(
select
 -- summary join columns
 csbs.rollup_id s_rollup_id,                    -- = :assm_rollup_id
 csbs.top_inventory_item_id s_item_id,          -- = :assm_top_inventory_item_id
 csbs.top_organization_id s_organization_id,    -- = :assm_top_organization_id
 -- summary visible columns
 cce.cost_element summary_cost_element,
 nvl(decode(cce.cost_element_id,
            1, frozen.material_cost,
            2, frozen.material_overhead_cost,
            3, frozen.resource_cost,
            4, frozen.outside_processing_cost,
            5, frozen.overhead_cost),
     0) summary_standard_cost,
 nvl(decode(cce.cost_element_id,
            1, cic.material_cost,
            2, cic.material_overhead_cost,
            3, cic.resource_cost,
            4, cic.outside_processing_cost,
            5, cic.overhead_cost
           ),
     0) summary_report_value,
 bom_cstrsccr_xmlp_pkg.cf_s_differenceformula
   ( nvl(decode(cce.cost_element_id,
               1, frozen.material_cost,
               2, frozen.material_overhead_cost,
               3, frozen.resource_cost,
               4, frozen.outside_processing_cost,
               5, frozen.overhead_cost
              ),
       0)
  , nvl(decode(cce.cost_element_id,
               1, cic.material_cost,
               2, cic.material_overhead_cost,
               3, cic.resource_cost,
               4, cic.outside_processing_cost,
               5, cic.overhead_cost
              ),
        0)
  ) summary_difference,
 bom_cstrsccr_xmlp_pkg.cf_s_percentformula
  ( nvl(decode(cce.cost_element_id,
               1, frozen.material_cost,
               2, frozen.material_overhead_cost,
               3, frozen.resource_cost,
               4, frozen.outside_processing_cost,
               5, frozen.overhead_cost
              ),
        0)
  , nvl(decode(cce.cost_element_id,
               1, cic.material_cost,
               2, cic.material_overhead_cost,
               3, cic.resource_cost,
               4, cic.outside_processing_cost,
               5, cic.overhead_cost
              ),
        0)
  , bom_cstrsccr_xmlp_pkg.cf_s_differenceformula
      ( nvl(decode(cce.cost_element_id,
                   1, frozen.material_cost,
                   2, frozen.material_overhead_cost,
                   3, frozen.resource_cost,
                   4, frozen.outside_processing_cost,
                   5,frozen.overhead_cost
                  ),
            0)
      , nvl(decode(cce.cost_element_id,
                   1, cic.material_cost,
                   2, cic.material_overhead_cost,
                   3, cic.resource_cost,
                   4, cic.outside_processing_cost,
                   5, cic.overhead_cost
                  ),
            0)
      )
  ) summary_difference_percent,
 -- summary hidden columns
 cce.cost_element_id,
 nvl(cic.item_cost,0) - nvl(frozen.item_cost,0) s_diff_total
from
 cst_sc_bom_structures csbs,
 cst_item_costs        cic,
 cst_item_costs        frozen,
 cst_cost_elements     cce
where
 csbs.rollup_id = :p_rollup_id and
 csbs.assembly_item_id = -1 and
 csbs.sort_order = 1 and
 cic.cost_type_id (+) = :p_cost_type_id and
 cic.inventory_item_id (+) = csbs.component_item_id and
 cic.organization_id (+) = csbs.component_organization_id and
 frozen.cost_type_id (+) = 1 and
 frozen.inventory_item_id (+) = csbs.component_item_id and
 frozen.organization_id (+) = csbs.component_organization_id
),
--
-- Q_SOURCING_RULES
--
q_sourcing_rules as
(
select distinct
 -- sourcing rules join columns
 cssr.rollup_id              s_r_rollup_id,
 csbs.top_inventory_item_id  s_r_top_item_id,
 csbs.top_organization_id    s_r_top_organization_id,
 -- sourcing rules visible columns
 msiv.concatenated_segments  source_item,
 mp.organization_code        source_receipt_organization,
 msiv.description            source_item_description,
 xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) source_item_type,
 nvl(cic.item_cost,0)        source_total_item_unit_cost,
 fc.currency_code            source_currency_code,
 -- sourcing rules hidden columns
 cssr.inventory_item_id      s_r_item_id,
 cssr.organization_id        s_r_org_id,
 fc.extended_precision       s_r_ext_precision,
 bom_common_xmlp_pkg.get_precision(fc.extended_precision) s_r_precision,
 dense_rank() over (order by cssr.rollup_id,csbs.top_inventory_item_id,cssr.inventory_item_id,cssr.organization_id) s_r_seq
from
 cst_sc_sourcing_rules       cssr,
 mtl_system_items_vl         msiv,
 hr_organization_information hoi,
 mtl_parameters              mp,
 cst_item_costs              cic,
 gl_ledgers                  sob,
 fnd_currencies              fc,
 cst_sc_bom_structures       csbs
where
 cssr.rollup_id = :p_rollup_id and
 csbs.rollup_id = cssr.rollup_id and
 csbs.component_item_id = cssr.inventory_item_id and
 csbs.component_organization_id = cssr.organization_id and
 cssr.assignment_set_id = :p_assignment_set_id  and 
 msiv.inventory_item_id = cssr.inventory_item_id and
 msiv.organization_id   = cssr.organization_id   and
 hoi.organization_id    = cssr.organization_id   and
 hoi.org_information_context = 'Accounting Information' and
 cic.inventory_item_id  = cssr.inventory_item_id and
 cic.organization_id    = cssr.organization_id   and
 cic.cost_type_id       = :p_cost_type_id and
 sob.ledger_id = hoi.org_information1 and
 fc.currency_code = sob.currency_code and
 mp.organization_id = cssr.organization_id
),
--
-- Q_SOURCING_RULE_SOURCES
--
q_sourcing_rule_sources as
(
select
 -- source join columns
 cssr.rollup_id s_s_rollup_id,
 cssr.inventory_item_id s_s_item_id,
 cssr.organization_id s_s_org_id,
 -- source visible columns
 xxen_util.meaning(cssr.source_type,'MRP_SOURCE_TYPE',700) source_type,
 decode(cssr.source_type,3,pv.vendor_name,ood.organization_code ) source_organization_or_vendor,
 pvs.vendor_site_code source_vendor_site,
 cssr.ship_method source_ship_method,
 cssr.allocation_percent source_allocation_percent,
 bom_cstrsccr_xmlp_pkg.cf_s_s_src_totalformula
   ( cssr.allocation_percent
   , sum( decode(cssr.source_type,
                 3, decode(nvl(cicd.source_organization_id,-1),-1,nvl(cicd.item_cost,0),0),
                 2, decode(cicd.source_organization_id,cicd.organization_id,nvl(cicd.item_cost,0),0),
                    nvl(cicd.item_cost,0)
                )
        )
   ) source_item_unit_cost,
 sum( decode(cssr.source_type,
             3, decode(nvl(cicd.source_organization_id,-1),-1,nvl(cicd.item_cost,0),0),
             2, decode(cicd.source_organization_id,cicd.organization_id,nvl(cicd.item_cost,0),0),
                nvl(cicd.item_cost,0)
            )
    ) source_effective_cost,
 -- source hidden columns
 cssr.item_cost s_s_source_item_cost
from
 cst_sc_sourcing_rules        cssr,
 cst_organization_definitions ood,
 po_vendors                   pv,
 po_vendor_sites_all          pvs,
 mfg_lookups                  lu,
 cst_item_cost_details        cicd
where
 cssr.rollup_id = :p_rollup_id
 and ood.organization_id (+) = cssr.source_organization_id
 and pv.vendor_id (+) = cssr.vendor_id
 and pvs.vendor_site_id (+) = cssr.vendor_site_id
 and lu.lookup_type (+) = 'MRP_SOURCE_TYPE'
 and lu.lookup_code (+) = cssr.source_type
 and cicd.inventory_item_id (+) = cssr.inventory_item_id
 and cicd.organization_id (+) = cssr.organization_id
 and cicd.cost_type_id (+) = :p_cost_type_id
 and cicd.rollup_source_type (+) = 3
 and nvl(cicd.source_organization_id (+),-1) = nvl(cssr.source_organization_id, -1)
 and nvl(cicd.vendor_id (+),-1) = nvl( cssr.vendor_id, -1 )
 and nvl(cicd.vendor_site_id (+),-1) = nvl(cssr.vendor_site_id,-1 )
 and nvl(cicd.ship_method (+),'-1') = nvl(cssr.ship_method,'-1')
group by
 cssr.rollup_id,
 cssr.inventory_item_id,
 cssr.organization_id,
 lu.meaning,
 cssr.source_type,
 ood.organization_code,
 pv.vendor_name,
 pvs.vendor_site_code,
 cssr.ship_method,
 cssr.item_cost,
 cssr.allocation_percent
),
--
-- Q Dummy. Not used. just here to support multi-select item parameter
--
q_dummy as
(
select
 msiv.organization_id,
 msiv.inventory_item_id
from
 mtl_system_items_vl msiv
where
 1=1 and
 'X'='Y'
)
--
-- Main Query Starts Here
--
select
x.record_type,
-- assembly
x.ledger,
x.organization_code,
x.organization_name,
x.assembly,
x.assembly_description,
x.assembly_item_type,
x.assembly_category,
x.assembly_uom,
x.assembly_currency_code,
-- component
x.component_level,
x.operation_seq,
x.component,
x.component_description,
x.component_item_type,
x.component_organiziation,
x.revision,
x.make_buy,
x.include_in_rollup,
x.based_on_rollup,
x.inventory_asset,
x.phantom,
x.basis,
x.yield,
x.planning_percent,
x.component_uom,
x.component_quantity,
x.component_shrinkage_rate,
x.component_extended_quantity,
x.component_item_unit_cost,
x.component_extended_cost,
x.component_contributing_cost,
x.component_currency_code,
-- costs
x.cost_type,
x.level_type,
x.resource_operation_seq,
x.cost_element,
x.sub_element,
x.department,
x.costed,
x.resource_basis,
x.resource_uom,
x.rate_or_amount,
x.basis_factor,
x.extended_rate_or_amount,
x.resource_unit_cost,
x.extended_cost,
-- summary costs
x.summary_standard_cost,
x.summary_report_value,
x.summary_difference,
x.summary_difference_percent,
-- sourcing rules
x.source_item,
x.source_item_description,
x.source_item_type,
x.source_receipt_organization,
x.source_currency_code,
x.source_type,
x.source_organization_or_vendor,
x.source_vendor_site,
x.source_ship_method,
x.source_allocation_percent,
x.source_item_unit_cost,
x.source_effective_cost,
x.source_cost_percent,
x.source_total_item_unit_cost,
x.source_user_defined_costs,
x.source_user_defined_costs_pct,
dense_rank() over (
partition by
x.record_type,
x.organization_code,
x.assembly
order by
x.assm_rollup_id,
x.assembly,
decode(x.record_type,'Indented Bill',1,'Summary Costs',2,3),
x.record_type,
x.comp_sort_order_1,
x.comp_sort_order_2,
x.component,
x.component_organiziation
) comp_sort_seq,
row_number() over (
order by
x.assm_rollup_id,
x.assembly,
decode(x.record_type,'Indented Bill',1,'Summary Costs',2,3),
x.record_type,
x.comp_sort_order_1,
x.comp_sort_order_2,
x.component,
x.component_organiziation,
x.costs_sort_order_1,
x.resource_operation_seq,
x.costs_sort_order_2,
x.costs_sort_order_3,
x.costs_sort_order_4,
x.sub_element,
x.department,
x.source_item,
x.source_receipt_organization,
x.source_allocation_percent
) sort_seq
from
(
--
-- Query 1 - Indented Bills
select
'Indented Bill' record_type,
-- assembly
assm.ledger,
assm.organization_code,
assm.organization_name,
assm.assembly,
assm.assembly_description,
assm.assembly_item_type,
assm.assembly_category,
assm.assembly_uom,
assm.assembly_currency_code,
-- component
comp.component_level,
comp.operation_seq,
comp.component,
comp.component_description,
comp.component_item_type,
comp.component_organiziation,
comp.revision,
comp.make_buy,
comp.include_in_rollup,
comp.based_on_rollup,
comp.inventory_asset,
comp.phantom,
comp.basis,
comp.yield,
comp.planning_percent,
comp.component_uom,
comp.component_quantity,
comp.component_shrinkage_rate,
comp.component_extended_quantity,
comp.component_item_unit_cost,
comp.component_extended_cost,
comp.component_contributing_cost,
comp.component_currency_code,
-- costs
:p_cost_type_name cost_type,
costs.level_type,
costs.resource_operation_seq,
costs.cost_element,
costs.sub_element,
costs.department,
costs.costed,
costs.resource_basis,
costs.resource_uom,
costs.rate_or_amount,
costs.basis_factor,
costs.extended_rate_or_amount,
costs.resource_unit_cost,
nvl(costs.extended_cost,0) extended_cost,
-- summary costs
to_number(null) summary_standard_cost,
to_number(null) summary_report_value,
to_number(null) summary_difference,
to_number(null) summary_difference_percent,
-- sourcing rules
null            source_item,
null            source_item_description,
null            source_item_type,
null            source_receipt_organization,
null            source_currency_code,
null            source_type,
null            source_organization_or_vendor,
null            source_vendor_site,
null            source_ship_method,
to_number(null) source_allocation_percent,
to_number(null) source_item_unit_cost,
to_number(null) source_effective_cost,
to_number(null) source_cost_percent,
to_number(null) source_total_item_unit_cost,
to_number(null) source_user_defined_costs,
to_number(null) source_user_defined_costs_pct,
-- sort columns
assm.assm_rollup_id,
decode(:p_report_type_type,1,nvl(comp.comp_sort_order,0),0) comp_sort_order_1,
decode(comp.assembly_item_id,-1,1,2) comp_sort_order_2,
costs.level_type_code costs_sort_order_1,
decode(costs.cost_element_id,1,costs.cost_element_id,2,costs.cost_element_id,null) costs_sort_order_2,
decode(costs.cost_element_id,3,costs.resource_id,4,costs.resource_id,5,costs.basis_resource_id,null ) costs_sort_order_3,
costs.cost_element_id costs_sort_order_4
from
q_assembly     assm,
q_components   comp,
q_costs        costs
where
comp.comp_rollup_id             (+) = assm.assm_rollup_id and
comp.comp_top_inventory_item_id (+) = assm.assm_top_inventory_item_id and
comp.comp_top_organization_id   (+) = assm.assm_top_organization_id and
costs.res_rollup_id             (+) = comp.comp_rollup_id and
costs.res_top_inventory_item_id (+) = comp.comp_top_inventory_item_id and
costs.res_top_organization_id   (+) = comp.comp_top_organization_id and
costs.res_sort_order            (+) = comp.comp_sort_order and
costs.res_cost_type             (+) = comp.comp_cost_type
union all
--
-- Query 2 - Summary Costs
select
'Summary Costs' record_type,
-- assembly
assm.ledger,
assm.organization_code,
assm.organization_name,
assm.assembly,
assm.assembly_description,
assm.assembly_item_type,
assm.assembly_category,
assm.assembly_uom,
assm.assembly_currency_code,
-- component
null            component_level,
to_number(null) operation_seq,
null            component,
null            component_description,
null            component_item_type,
null            component_organiziation,
null            revision,
null            make_buy,
null            include_in_rollup,
null            based_on_rollup,
null            inventory_asset,
null            phantom,
null            basis,
to_number(null) yield,
to_number(null) planning_percent,
null            component_uom,
to_number(null) component_quantity,
to_number(null) component_shrinkage_rate,
to_number(null) component_extended_quantity,
to_number(null) component_item_unit_cost,
to_number(null) component_extended_cost,
to_number(null) component_contributing_cost,
null            component_currency_code,
-- costs
:p_cost_type_name cost_type,
null            level_type,
to_number(null) resource_operation_seq,
summ.summary_cost_element,
null            sub_element,
null            department,
null            costed,
null            resource_basis,
null            resource_uom,
to_number(null) rate_or_amount,
to_number(null) basis_factor,
to_number(null) extended_rate_or_amount,
to_number(null) resource_unit_cost,
to_number(null) extended_cost,
-- summary costs
summ.summary_standard_cost,
summ.summary_report_value,
summ.summary_difference,
summ.summary_difference_percent,
-- sourcing rules
null            source_item,
null            source_item_description,
null            source_item_type,
null            source_receipt_organization,
null            source_currency_code,
null            source_type,
null            source_organization_or_vendor,
null            source_vendor_site,
null            source_ship_method,
to_number(null) source_allocation_percent,
to_number(null) source_item_unit_cost,
to_number(null) source_effective_cost,
to_number(null) source_cost_percent,
to_number(null) source_total_item_unit_cost,
to_number(null) source_user_defined_costs,
to_number(null) source_user_defined_costs_pct,
-- sort columns
assm.assm_rollup_id,
to_number(null) comp_sort_order_1,
to_number(null) comp_sort_order_2,
to_number(null) costs_sort_order_1,
to_number(null) costs_sort_order_2,
to_number(null) costs_sort_order_3,
summ.cost_element_id costs_sort_order_4
from
q_assembly     assm,
q_summary      summ
where
summ.s_rollup_id                (+) = assm.assm_rollup_id and
summ.s_item_id                  (+) = assm.assm_top_inventory_item_id and
summ.s_organization_id          (+) = assm.assm_top_organization_id
union all
--
-- Query 3 - Sourcing Rules
select
'Sourcing Rules' record_type,
-- assembly
assm.ledger,
assm.organization_code,
assm.organization_name,
assm.assembly,
assm.assembly_description,
assm.assembly_item_type,
assm.assembly_category,
assm.assembly_uom,
assm.assembly_currency_code,
-- component
null            component_level,
to_number(null) operation_seq,
null            component,
null            component_description,
null            component_item_type,
null            component_organiziation,
null            revision,
null            make_buy,
null            include_in_rollup,
null            based_on_rollup,
null            inventory_asset,
null            phantom,
null            basis,
to_number(null) yield,
to_number(null) planning_percent,
null            component_uom,
to_number(null) component_quantity,
to_number(null) component_shrinkage_rate,
to_number(null) component_extended_quantity,
to_number(null) component_item_unit_cost,
to_number(null) component_extended_cost,
to_number(null) component_contributing_cost,
null            component_currency_code,
-- costs
:p_cost_type_name cost_type,
null            level_type,
to_number(null) resource_operation_seq,
null            cost_element,
null            sub_element,
null            department,
null            costed,
null            resource_basis,
null            resource_uom,
to_number(null) rate_or_amount,
to_number(null) basis_factor,
to_number(null) extended_rate_or_amount,
to_number(null) resource_unit_cost,
to_number(null) extended_cost,
-- summary costs
to_number(null) summary_standard_cost,
to_number(null) summary_report_value,
to_number(null) summary_difference,
to_number(null) summary_difference_percent,
-- sourcing rules
srcrul.source_item,
srcrul.source_item_description,
srcrul.source_item_type,
srcrul.source_receipt_organization,
srcrul.source_currency_code,
srcsrc.source_type,
srcsrc.source_organization_or_vendor,
srcsrc.source_vendor_site,
srcsrc.source_ship_method,
srcsrc.source_allocation_percent,
srcsrc.source_item_unit_cost,
srcsrc.source_effective_cost,
bom_cstrsccr_xmlp_pkg.cf_s_s_percent_costformula
 ( srcrul.source_total_item_unit_cost
 , srcsrc.source_effective_cost
 ) source_cost_percent,
srcrul.source_total_item_unit_cost,
srcrul.source_total_item_unit_cost -
sum(srcsrc.source_effective_cost) over (partition by srcrul.s_r_seq) source_user_defined_costs,
case when nvl(srcrul.source_total_item_unit_cost,0) != 0
then round((srcrul.source_total_item_unit_cost - sum(srcsrc.source_effective_cost) over (partition by srcrul.s_r_seq))/srcrul.source_total_item_unit_cost * 100,5)
else null
end source_user_defined_costs_pct,
-- sort columns
assm.assm_rollup_id,
to_number(null) comp_sort_order_1,
to_number(null) comp_sort_order_2,
to_number(null) costs_sort_order_1,
to_number(null) costs_sort_order_2,
to_number(null) costs_sort_order_3,
to_number(null) costs_sort_order_4
from
q_assembly               assm,
q_sourcing_rules         srcrul,
q_sourcing_rule_sources  srcsrc
where
srcrul.s_r_rollup_id            = assm.assm_rollup_id and
srcrul.s_r_top_item_id          = assm.assm_top_inventory_item_id and
srcrul.s_r_top_organization_id  = assm.assm_top_organization_id and
srcsrc.s_s_rollup_id        (+) = srcrul.s_r_rollup_id and
srcsrc.s_s_item_id          (+) = srcrul.s_r_item_id and
srcsrc.s_s_org_id           (+) = srcrul.s_r_org_id
) x
order by
row_number() over (
order by
x.assm_rollup_id,
x.assembly,
decode(x.record_type,'Indented Bill',1,'Summary Costs',2,3),
x.record_type,
x.comp_sort_order_1,
x.comp_sort_order_2,
x.component,
x.component_organiziation,
x.costs_sort_order_1,
x.resource_operation_seq,
x.costs_sort_order_2,
x.costs_sort_order_3,
x.costs_sort_order_4,
x.sub_element,
x.department,
x.source_item,
x.source_receipt_organization,
x.source_allocation_percent
)