/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ASCP - Pegging
-- Description: Export the PWB Pegging Trees
-- Excel Examle Output: https://www.enginatics.com/example/ascp-pegging/
-- Library Link: https://www.enginatics.com/reports/ascp-pegging/
-- Run Report: https://demo.enginatics.com/

select mp.compile_designator,
       msi.planner_code,
       msi.buyer_name,
       msi.planning_exception_set,
       substr(mpo.organization_code, 5, 9) org,
       msi.item_name item,
       decode(ms.order_type,
              '1',
              'purchase order',
              '11',
              'intransit shipment',
              '12',
              'intransit receipt',
              '13',
              'suggested repetitive schedule',
              '14',
              'discrete job co-product/by-product',
              '15',
              'nonstandard job by-product',
              '16',
              'repetitive schedule by-product',
              '17',
              'planned order co-product/by-product',
              '18',
              'onhand',
              '2',
              'purchase requisition',
              '27',
              'flow schedule',
              '28',
              'flow schedule by-product',
              '29',
              'payback supply',
              '3',
              'discrete job',
              '30',
              'current repetitive schedule',
              '32',
              'returns',
              '4',
              'suggested aggregate repetitive schedule',
              '41',
              'user supply',
              '45',
              'demand class consumption',
              '46',
              'supply due to stealing',
              '47',
              'demand due to stealing',
              '48',
              'supply adjustment',
              '49',
              'po acknowledgment',
              '5',
              'planned order',
              '50',
              'atp aggregate supply',
              '51',
              'planned inbound shipment',
              '52',
              'requested inbound shipment',
              '53',
              'int req',
              '60',
              'order rescheduling adjustment',
              '7',
              'non-standard job',
              '70',
              'maintenance work order',
              '8',
              'po in receiving') supply_type,
       round(mfp.allocated_quantity, 1) peg_qty,
       mfp.demand_quantity dem_qty,
       mfp.demand_date dem_date,
       mfp.supply_quantity supp_qty,
       
       decode(md1.origination_type, '29', 'forecast', '30', 'sales order') peg_type,
       decode(mfp.demand_id, -1, 'excess', -2, 'safey stock') peg_other,
       mfp.organization_id org_id,
       decode(md2.origination_type, '29', 'peg_fcast', '30', 'peg_sales') peg_cmps, --to check
       trunc(ms.new_schedule_date) comp_sup_due,
       decode(md2.order_number,
              null,
              to_char(md2.demand_id),
              (substr(md2.order_number, 1, 14) ||
              substr(md2.order_number, 42, 5))) so_num,
       msi2.item_name || ' (' || msi2.inventory_item_id || ')' "assembly (id)",
       --msi2.description
       to_char(md2.request_ship_date, 'dd/mm/yyyy') rdate,
       trunc(md2.using_assembly_demand_date) ssdate,
       md1.creation_date,
       round((md2.dmd_satisfied_date - md2.using_assembly_demand_date), 1) late,
       md2.demand_priority priority,
       round(mfp2.demand_quantity, 1) so_qty,
       round(mfp2.allocated_quantity, 1) wip_qty,
       trunc(md1.old_demand_date) ulsd,
       trunc(md1.using_assembly_demand_date) comp_dem_due

  from apps.msc_supplies ms -- comp
      ,
       apps.msc_system_items msi -- comp
      ,
       apps.msc_full_pegging mfp -- comp
      ,
       apps.msc_plan_organizations mpo,
       apps.msc_plans mp,
       (select *
          from apps.msc_demands
         where sr_instance_id = 21
           and organization_id =207
           and plan_id = 63) md1 -- comp
      ,
       (select *
          from apps.msc_full_pegging
         where sr_instance_id = 21
           and organization_id =207
           and plan_id = 63) mfp2 -- fg
      ,
       (select *
          from apps.msc_demands
         where sr_instance_id = 21
           and organization_id =207
           and plan_id = 63) md2 -- fg
      ,
       (select *
          from apps.msc_system_items
         where sr_instance_id = 21
           and organization_id =207 --in (207, 606, 209, 229)
           and plan_id = 63) msi2 -- fg level
 where 1=1
   and ms.sr_instance_id = 21
   and ms.plan_id = 63
   and ms.plan_id = mp.plan_id
   and mpo.organization_code in ('TST:M1')
   -- 'TST:M2', 'TST:D1', 'TST:M3')
   and mpo.plan_id = ms.plan_id
   and mpo.sr_instance_id = ms.sr_instance_id
   and ms.organization_id = mpo.organization_id
   and msi.sr_instance_id = ms.sr_instance_id
   and msi.organization_id = ms.organization_id
   and msi.plan_id = ms.plan_id
   and msi.inventory_item_id = ms.inventory_item_id
   and mfp.sr_instance_id = ms.sr_instance_id
   and mfp.organization_id = ms.organization_id
   and mfp.plan_id = ms.plan_id
   and mfp.transaction_id = ms.transaction_id
   and md1.demand_id(+) = mfp.demand_id
   and mfp2.pegging_id(+) = mfp.prev_pegging_id
   and md2.demand_id(+) = mfp2.demand_id
   and msi2.inventory_item_id(+) = mfp2.inventory_item_id
   and msi.item_name in ('CM13139', 'AS92689') --comp and assy