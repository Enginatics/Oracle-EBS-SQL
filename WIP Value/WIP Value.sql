/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Value
-- Description: Application: Work in Process
Description: WIP Value Report

This report will display Period To Date (PTD) and Cumulative To Date (CTD) WIP costs/variances for the selected period. 

The raw data (without template) provides a breakdown of these values by WIP Cost Type, Class, Discrete Job/Repetitive Schedule, Assembly, Element/Variance GL Account, and Period in which the cost is incurred/relieved.

Templates are provided to detail or summarize the costs as followed:

Applicable Templates:
Pivot: WIP Value by Cost Type, Class - WIP Value Summary by Cost Type, Class with Drill Down to WIP Job Details
Pivot: WIP Value by Cost Type, Class, Element/Variance GL Account - WIP Value by Cost Type, Class, Element/Variance GL Account
Pivot: WIP Value by Element/Variance GL Account - WIP Value Account Summary by Element/Variance GL Account with Drill Down to WIP Job Details
Detail: WIP value detail by WIP Job/Repetitive Schedule - Detail: WIP value detail by WIP Job/Repetitive Schedule
Detail: WIP value detail by Element/Variance GL Account - WIP value detail breakdown at the  Element/Variance GL Account level

Provides equivalent functionality to the following standard Oracle Forms/Reports
- WIP Value Report

Source: WIP Value Report (XML)
Short Name: WIPUTVAL_XML
DB package: WIP_WIPUTVAL_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/wip-value/
-- Library Link: https://www.enginatics.com/reports/wip-value/
-- Run Report: https://demo.enginatics.com/

with wip_detail_q as
( select
   wdq.job_type,
   wdq.class_type_code,
   wdq.class_type,
   wdq.class_code,
   wdq.wip_entity,
   wdq.period,
   wdq.period_close_date,
   wdq.scheduled_start_date,
   wdq.assembly,
   wdq.element,
   wdq.gl_account,
   -- PTD
   case when wdq.acct_period_id = :p_acct_period_id then round(:p_exchange_rate * wdq.costs_incurred,:p_precision) end ptd_costs_incurred,
   case when wdq.acct_period_id = :p_acct_period_id then round(:p_exchange_rate * wdq.costs_relieved,:p_precision) end ptd_costs_relieved,
   case when wdq.acct_period_id = :p_acct_period_id then round(:p_exchange_rate * wdq.elemental_variances_relieved,:p_precision) end ptd_elemental_var_relieved,
   case when wdq.acct_period_id = :p_acct_period_id then round(:p_exchange_rate * wdq.single_variances_relieved,:p_precision) end ptd_single_var_relieved,
   case when wdq.acct_period_id = :p_acct_period_id then
     round(:p_exchange_rate * nvl(wdq.costs_incurred,0),:p_precision) -
     round(:p_exchange_rate * nvl(wdq.costs_relieved,0),:p_precision) -
     round(:p_exchange_rate * nvl(wdq.elemental_variances_relieved,0),:p_precision)
   end ptd_net_activity,
   -- CTD
   round(:p_exchange_rate * wdq.costs_incurred,:p_precision) ctd_costs_incurred,
   round(:p_exchange_rate * wdq.costs_relieved,:p_precision) ctd_costs_relieved,
   round(:p_exchange_rate * wdq.elemental_variances_relieved,:p_precision) ctd_elemental_var_relieved,
   round(:p_exchange_rate * wdq.single_variances_relieved,:p_precision) ctd_single_var_relieved,
   round(:p_exchange_rate * nvl(wdq.costs_incurred,0),:p_precision) -
   round(:p_exchange_rate * nvl(wdq.costs_relieved,0),:p_precision) -
   round(:p_exchange_rate * nvl(wdq.elemental_variances_relieved,0),:p_precision) ctd_net_activity,
   --
   wdq.organization_id,
   wdq.wip_entity_id,
   wdq.repetitive_schedule_id,
   wdq.acct_period_id,
   wdq.element_code
  from
   (
     select /*+ LEADING(WDJ WPB OAP WE) USE_NL(WDJ WPB OAP WE ML2) */ -- Discrete Jobs
      'Discrete'                  job_type,
      wpb.class_type              class_type_code,
      ml.meaning                  class_type,
      wdj.class_code              class_code,
      we.wip_entity_name          wip_entity,
      oap.period_name             period,
      oap.schedule_close_date     period_close_date,
      wdj.scheduled_start_date    scheduled_start_date,
      wdj.primary_item_id         item_id,
      msik.concatenated_segments  assembly,
      --
      ml2.meaning                 element,
      nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE'),null)
                                  gl_account,
      --
      decode( ml2.lookup_code,
              1  , nvl(wpb.pl_material_in,0),
              2  , nvl(wpb.pl_material_overhead_in,0),
              3  , nvl(wpb.tl_resource_in,0) + nvl(wpb.pl_resource_in,0),
              4  , nvl(wpb.tl_outside_processing_in,0) + nvl(wpb.pl_outside_processing_in,0),
              5  , nvl(wpb.tl_overhead_in,0) + nvl(wpb.pl_overhead_in,0),
              12 , nvl(wpb.tl_scrap_in,0),
                   0)             costs_incurred,
      decode(ml2.lookup_code,
             1  , nvl(wpb.tl_material_out,0) + nvl(wpb.pl_material_out,0),
             2  , nvl(wpb.pl_material_overhead_out,0)+nvl(wpb.tl_material_overhead_out,0),
             3  , nvl(wpb.tl_resource_out,0) + nvl(wpb.pl_resource_out,0),
             4  , nvl(wpb.tl_outside_processing_out,0) + nvl(wpb.pl_outside_processing_out, 0),
             5  , nvl(wpb.tl_overhead_out,0) + nvl(wpb.pl_overhead_out,0),
             12 , nvl(wpb.tl_scrap_out,0),
                  0)              costs_relieved,
      decode(ml2.lookup_code,
             1  , nvl(wpb.tl_material_var,0) + nvl(wpb.pl_material_var,0),
             2  , nvl(wpb.pl_material_overhead_var,0) + nvl(wpb.tl_material_overhead_var,0),
             3  , nvl(wpb.tl_resource_var,0) + nvl(wpb.pl_resource_var,0),
             4  , nvl(wpb.tl_outside_processing_var,0) + nvl(wpb.pl_outside_processing_var, 0),
             5  , nvl(wpb.tl_overhead_var,0) + nvl(wpb.pl_overhead_var,0),
             12 , nvl(wpb.tl_scrap_var,0),
                  0)              elemental_variances_relieved,
      decode(ml2.lookup_code,
             6  , nvl(wpb.tl_material_var,0) +
                  nvl(wpb.pl_material_var,0) +
                  nvl(wpb.pl_material_overhead_var,0) +
                  nvl(wpb.pl_resource_var,0) +
                  nvl(wpb.pl_overhead_var,0) +
                  nvl(wpb.pl_outside_processing_var,0) +
                  nvl(wpb.tl_material_overhead_var,0),
             7  , nvl(wpb.tl_resource_var,0),
             8  , nvl(wpb.tl_outside_processing_var,0),
             9  , nvl(wpb.tl_overhead_var,0),
             13 , nvl(wpb.tl_scrap_var,0),
                  0)             single_variances_relieved,
      --
      wpb.organization_id,
      wpb.wip_entity_id,
      wpb.repetitive_schedule_id,
      wpb.acct_period_id,
      ml2.lookup_code element_code
     from
      wip_discrete_jobs    wdj,
      wip_period_balances  wpb,
      org_acct_periods     oap,
      mfg_lookups          ml,
      wip_entities         we,
      mtl_system_items_b_kfv msik,
      mfg_lookups          ml2,
      gl_code_combinations gcc
     where
      wpb.wip_entity_id          = wdj.wip_entity_id and
      wpb.organization_id        = wdj.organization_id and
      oap.organization_id        = wpb.organization_id and
      oap.acct_period_id         = wpb.acct_period_id and
      ml.lookup_type             = 'WIP_CLASS_TYPE' and
      ml.lookup_code             = wpb.class_type and
      we.wip_entity_id           = wdj.wip_entity_id and
      we.organization_id         = wdj.organization_id and
      msik.inventory_item_id (+) = wdj.primary_item_id and
      msik.organization_id (+)   = wdj.organization_id and
      ml2.lookup_type            = 'WIP_ELEMENT_VAR_TYPE' and
      ml2.lookup_code           in (1,2,3,4,5,6,7,8,9,12,13) and
      gcc.code_combination_id    = decode(ml2.lookup_code,
                                    1 , wdj.material_account,
                                    2 , wdj.material_overhead_account,
                                    3 , wdj.resource_account,
                                    4 , wdj.outside_processing_account,
                                    5 , wdj.overhead_account,
                                    6 , wdj.material_variance_account,
                                    7 , wdj.resource_variance_account,
                                    8 , wdj.outside_proc_variance_account,
                                    9 , wdj.overhead_variance_account,
                                    12, wdj.est_scrap_account,
                                    13, wdj.est_scrap_var_account,
                                        0) and
      wdj.organization_id        = :p_organization_id and
      wdj.date_released         is not null and
      trunc(wdj.date_released)  <= :p_period_close_date and
      wpb.organization_id        = :p_organization_id and
      wpb.acct_period_id        <= :p_acct_period_id and
      2=2
     union
     select /*+ LEADING(WRS) */ -- Repetitive Schedules
      'Repetitive'               job_type,
      wpb.class_type              class_type_code,
      ml.meaning                  class_type,
      wri.class_code              class_code,
      wl.line_code                wip_entity,
      oap.period_name             period,
      oap.schedule_close_date     period_close_date,
      wrs.first_unit_start_date   scheduled_start_date,
      wri.primary_item_id         item_id,
      msik.concatenated_segments  assembly,
      --
      ml2.meaning                 element,
      nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE'),null)
                                  gl_account,
      --
      decode( ml2.lookup_code,
              1  , nvl(wpb.pl_material_in,0),
              2  , nvl(wpb.pl_material_overhead_in,0),
              3  , nvl(wpb.tl_resource_in,0) + nvl(wpb.pl_resource_in,0),
              4  , nvl(wpb.tl_outside_processing_in,0) + nvl(wpb.pl_outside_processing_in,0),
              5  , nvl(wpb.tl_overhead_in,0) + nvl(wpb.pl_overhead_in,0),
                   0)             costs_incurred,
      decode(ml2.lookup_code,
             1  , nvl(wpb.tl_material_out,0) + nvl(wpb.pl_material_out,0),
             2  , nvl(wpb.pl_material_overhead_out,0) + nvl(wpb.tl_material_overhead_out,0),
             3  , nvl(wpb.tl_resource_out,0) + nvl(wpb.pl_resource_out,0),
             4  , nvl(wpb.tl_outside_processing_out,0) + nvl(wpb.pl_outside_processing_out, 0),
             5  , nvl(wpb.tl_overhead_out,0) + nvl(wpb.pl_overhead_out,0),
                  0)              costs_relieved,
      decode(ml2.lookup_code,
             1  , nvl(wpb.tl_material_var,0) + nvl(wpb.pl_material_var,0),
             2  , nvl(wpb.pl_material_overhead_var,0) + nvl(wpb.tl_material_overhead_var,0),
             3  , nvl(wpb.tl_resource_var,0) + nvl(wpb.pl_resource_var,0),
             4  , nvl(wpb.tl_outside_processing_var,0) + nvl(wpb.pl_outside_processing_var, 0),
             5  , nvl(wpb.tl_overhead_var,0) + nvl(wpb.pl_overhead_var,0),
                  0)              elemental_variances_relieved,
      decode(ml2.lookup_code,
             6  , nvl(wpb.tl_material_var,0) +
                  nvl(wpb.pl_material_var,0) +
                  nvl(wpb.pl_material_overhead_var,0) +
                  nvl(wpb.pl_resource_var,0) +
                  nvl(wpb.pl_overhead_var,0) +
                  nvl(wpb.pl_outside_processing_var,0) +
                  nvl(wpb.tl_material_overhead_var,0),
             7  , nvl(wpb.tl_resource_var,0),
             8  , nvl(wpb.tl_outside_processing_var,0),
             9  , nvl(wpb.tl_overhead_var,0),
                  0)             single_variances_relieved,
      --
      wpb.organization_id,
      wpb.wip_entity_id,
      wpb.repetitive_schedule_id,
      wpb.acct_period_id,
      ml2.lookup_code element_code
     from
      wip_repetitive_schedules wrs,
      wip_period_balances      wpb,
      org_acct_periods         oap,
      mfg_lookups              ml,
      wip_entities             we,
      wip_lines                wl,
      wip_repetitive_items     wri,
      mtl_system_items_b_kfv     msik,
      mfg_lookups              ml2,
      gl_code_combinations     gcc
     where
      wpb.wip_entity_id          = wrs.wip_entity_id and
      wpb.organization_id        = wrs.organization_id and
      wpb.repetitive_schedule_id = wrs.repetitive_schedule_id and
      oap.organization_id        = wpb.organization_id and
      oap.acct_period_id         = wpb.acct_period_id and
      ml.lookup_type             = 'WIP_CLASS_TYPE' and
      ml.lookup_code             = wpb.class_type and
      we.wip_entity_id           = wrs.wip_entity_id and
      we.organization_id         = wrs.organization_id and
      wl.line_id                 = wrs.line_id and
      wl.organization_id         = wrs.organization_id and
      wri.wip_entity_id          = wrs.wip_entity_id and
      wri.line_id                = wrs.line_id and
      wri.organization_id        = wrs.organization_id and
      msik.inventory_item_id     = wri.primary_item_id and
      msik.organization_id       = wri.organization_id and
      ml2.lookup_type            = 'WIP_ELEMENT_VAR_TYPE' and
      ml2.lookup_code           in (1,2,3,4,5,6,7,8,9) and
      gcc.code_combination_id    = decode(ml2.lookup_code,
                                    1 , wrs.material_account,
                                    2 , wrs.material_overhead_account,
                                    3 , wrs.resource_account,
                                    4 , wrs.outside_processing_account,
                                    5 , wrs.overhead_account,
                                    6 , wrs.material_variance_account,
                                    7 , wrs.resource_variance_account,
                                    8 , wrs.outside_proc_variance_account,
                                    9 , wrs.overhead_variance_account,
                                        0) and
      wrs.organization_id        = :p_organization_id and
      wrs.date_released         is not null and
      trunc(wrs.date_released)  <= :p_period_close_date and
      ( wrs.date_closed         is null or
        wrs.date_closed         >= :p_period_start_date
      ) and
      wpb.organization_id        = :p_organization_id and
      wpb.acct_period_id        <= :p_acct_period_id and
      3=3
   ) wdq
)
--
-- Main Query Starts Here
--
select
 :p_organization_code organization,
 wdq.job_type,
 wdq.class_type,
 wdq.class_code class,
 wdq.wip_entity "Job/Line",
 wdq.period,
 wdq.period_close_date,
 wdq.scheduled_start_date start_date,
 wdq.assembly,
 wdq.element "Element/Variance",
 wdq.gl_account,
 :p_currency_code currency,
 :p_exchange_rate exchange_rate,
 -- PTD
 wdq.ptd_costs_incurred,
 wdq.ptd_costs_relieved,
 wdq.ptd_elemental_var_relieved ptd_variances_relieved,
 wdq.ptd_single_var_relieved ptd_single_level_var_relieved,
 wdq.ptd_net_activity,
 -- CTD
 wdq.ctd_costs_incurred,
 wdq.ctd_costs_relieved,
 wdq.ctd_elemental_var_relieved ctd_variances_relieved,
 wdq.ctd_single_var_relieved ctd_single_level_var_relieved,
 wdq.ctd_net_activity,
 --
 wdq.class_type_code,
 wdq.class_type_code || ' ' || wdq.class_type class_type_pivot_label,
 wdq.element_code,
 lpad(wdq.element_code,2) || ' ' || wdq.element || ' - ' || wdq.gl_account "Element/Variance Pivot Label"
from
 wip_detail_q wdq
where
 1=1
order by
 wdq.job_type,
 wdq.class_type_code,
 wdq.class_code,
 wdq.wip_entity,
 wdq.period_close_date,
 wdq.scheduled_start_date