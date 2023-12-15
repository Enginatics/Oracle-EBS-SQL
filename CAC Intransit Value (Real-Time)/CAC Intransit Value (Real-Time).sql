/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intransit Value (Real-Time)
-- Description: Report to show intransit values across all ledgers for current onhand balances and current costing method costs.  This is a "real-time" report, showing the quantities and values at the time you run this report.  (Used the cst_intransit_value_view to simplify the design.)

/* +=============================================================================+
-- |  Copyright 2009-20 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_intransit_value_report.sql
-- |
-- |  Parameters:
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set
-- | 
-- |  Description:
-- |  Report to show intransit values across all ledgers, for current onhand
-- |  balances and current costing method costs.  This is a "real-time" report,
-- |  showing the quantities and values at the time you run this report.
-- |  (Note:  Used the cst_intransit_value_view to simplify the design.)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Nov 2008 Douglas Volz   Initial Coding
-- |  1.1     10 Dec 2009 Douglas Volz   Modified for Celgene
-- |  1.2     04 Jan 2010 Douglas Volz   Added intransit value accounts
-- |  1.3     03 Mar 2010 Douglas Volz   Set the company account number based on
-- |                                     the item's cost of goods sold account
-- |  1.4     04 Mar 2010 Douglas Volz   Screen out invalid Intransit balances from
-- |                                     Dec 2009 transactions for Ledger CHE_EUR_PL.
-- |                                     These intransit balances were written-off
-- |                                     in the G/L in December 2009.  Was not able
-- |                                     to get these entries fixed in Oracle.
-- |  1.10    23 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |  1.11    23 Aug 2020 Douglas Volz   Modified to get intransit_owning_org_id directly
-- |                                     from mtl_supply; if you change the shipping 
-- |                                     network FOB Point and you can no longer get
-- |                                     the FOB Point from cst_intransit_value_view.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-intransit-value-real-time/
-- Library Link: https://www.enginatics.com/reports/cac-intransit-value-real-time/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Owning_Org,
 haou.name Organization_Name,
 mp2.organization_code From_Org,
 mp3.organization_code To_Org,
 ml.meaning FOB_Point,
 &segment_columns
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 fcl.meaning Item_Type,
 -- Revision for version 1.11
 misv.inventory_item_status_code_tl Item_Status,
 -- Revision for version 1.8
&category_columns
 -- End revision for version 1.8
 civv.shipment_num Shipment_Number,
 civv.receipt_num Receipt_Number,
-- civv.freight_carrier_code Freight_Carrier,
-- civv.waybill_airbill_num Waybill,
 trunc(civv.need_by_date) Need_by_Date,
-- civv.expected_delivery_date Expected_Delivery_Date,
 trunc(civv.shipped_date) Shipped_Date,
 case 
  when (sysdate - civv.shipped_date) < 31  then '30 days'
  when (sysdate - civv.shipped_date) < 61  then '60 days'
  when (sysdate - civv.shipped_date) < 91  then '90 days'
  when (sysdate - civv.shipped_date) < 121 then '120 days'
  when (sysdate - civv.shipped_date) < 151 then '150 days'
  when (sysdate - civv.shipped_date) < 181 then '180 days'
  else 'Over 180 days'
 end Aging_Date,
 trunc(civv.receipt_date) Arrival_Date,
 -- Revision for version 1.11
 muomv.uom_code UOM_Code,
 sum(civv.to_org_primary_quantity) Intransit_Quantity,
 gl.currency_code Currency_Code,
 sum(civv.to_org_primary_quantity * nvl(cic.item_cost,0)) Intransit_Value
from
 -- Revision for version 1.11
 -- Need to derive the FOB_Point from mtl_supply as
 -- the Shipping Network settings may have changed
 -- after the intransit transaction has happened
 -- cst_intransit_value_view    civv,
 (select sup.intransit_owning_org_id,
  nvl(sup.cost_group_id,
   decode(mp.primary_cost_method,
    1, null,
    2, mp.default_cost_group_id,
    5, mp.default_cost_group_id,
    6, mp.default_cost_group_id
          )
     ) cost_group_id,
  sup.from_organization_id,
  sup.to_organization_id,
  case
     when sup.intransit_owning_org_id = sup.to_organization_id then 1
     when sup.intransit_owning_org_id = sup.from_organization_id then 2
     else 2
  end fob_point,
  rsh.shipment_num,
  rsh.receipt_num,
  sup.item_id inventory_item_id,
  sup.item_revision,
  sup.to_org_primary_quantity,
  sup.to_org_primary_uom,
  sup.receipt_date,
  sup.need_by_date,
  sup.expected_delivery_date,
  rsh.shipped_date,
  sup.destination_type_code
  from rcv_shipment_headers rsh,
  rcv_shipment_lines rsl,
  mtl_supply sup,
  mtl_parameters mp
  where sup.supply_type_code in ('SHIPMENT', 'RECEIVING') 
  and rsh.shipment_header_id = sup.shipment_header_id
  and rsl.shipment_line_id = sup.shipment_line_id
  and mp.organization_id = sup.intransit_owning_org_id
 ) civv,
 mtl_interorg_parameters        mip,
 mtl_system_items_vl            msiv,
 -- Revision for version 1.11
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv, 
 -- End revision for version 1.11
 cst_item_costs                 cic,
 mfg_lookups                    ml,
 mfg_lookups                    ml2,
 fnd_common_lookups             fcl,
 mtl_parameters                 mp,   -- owning org
 mtl_parameters                 mp2,  -- from org
 mtl_parameters                 mp3,  -- to org
 gl_code_combinations           gcc,
 hr_organization_information    hoi,
 hr_all_organization_units_vl   haou, -- inv_organization_id
 hr_all_organization_units_vl   haou2,-- operating unit
 gl_ledgers gl
where cic.organization_id         = civv.intransit_owning_org_id
and cic.inventory_item_id       = civv.inventory_item_id
and cic.inventory_item_id       = msiv.inventory_item_id
and cic.organization_id         = msiv.organization_id
and cic.cost_type_id            = mp.primary_cost_method
-- Revision for version 1.11
and msiv.primary_uom_code           = muomv.uom_code
and misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.11
and mip.from_organization_id    = civv.from_organization_id
and mip.to_organization_id      = civv.to_organization_id
and gcc.code_combination_id     = mip.intransit_inv_account
and mp.organization_id          = civv.intransit_owning_org_id
and mp2.organization_id         = civv.from_organization_id
and mp3.organization_id         = civv.to_organization_id
-- ===================================================================
-- -- joins for the lookup codes
-- ===================================================================
and ml.lookup_type              = 'MTL_FOB_POINT'
and ml.lookup_code              = civv.fob_point 
and ml2.lookup_type             = 'MTL_PLANNING_MAKE_BUY'
and ml2.lookup_code             = msiv.planning_make_buy_code
and fcl.lookup_type (+)         = 'ITEM_TYPE'
and fcl.lookup_code (+)         = msiv.item_type
 -- =============================================================
 -- using the base tables to avoid the performance issues
 -- with org_organization_definitions and hr_operating_units
 -- =============================================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = mp.organization_id
and hoi.organization_id         = haou.organization_id   -- this gets the organization name
and haou2.organization_id       = hoi.org_information3   -- this gets the operating unit id
and hoi.org_information1        = gl.ledger_id           -- this gets the ledger id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                                                  -- p_ledger, p_operating_unit, p_org_code
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
group by
 nvl(gl.short_name, gl.name),
 haou2.name,
 mp.organization_code,
 haou.name,
 mp2.organization_code,
 mp3.organization_code,
 ml.meaning,
 &segment_columns2
 msiv.concatenated_segments,
 msiv.description,
 fcl.meaning,
 -- Revision for version 1.11
 misv.inventory_item_status_code_tl, -- Item_Status
 civv.shipment_num,
 civv.receipt_num,
-- civv.freight_carrier_code,
-- civv.waybill_airbill_num,
 trunc(civv.need_by_date),
-- civv.expected_delivery_date,
 trunc(civv.shipped_date),
 case 
  when (sysdate - civv.shipped_date) < 31  then '30 days'
  when (sysdate - civv.shipped_date) < 61  then '60 days'
  when (sysdate - civv.shipped_date) < 91  then '90 days'
  when (sysdate - civv.shipped_date) < 121 then '120 days'
  when (sysdate - civv.shipped_date) < 151 then '150 days'
  when (sysdate - civv.shipped_date) < 181 then '180 days'
  else 'Over 180 days'
 end,     
 trunc(civv.receipt_date),
 -- Revision for version 1.11
 muomv.uom_code,
 gl.currency_code,
 -- Needed for category column inline selects
 msiv.inventory_item_id,
 msiv.organization_id
-- order by ledger, owning org, operating unit, from org, to org, account segments and aging date 
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Owning_Org
 mp2.organization_code, -- From_Org
 mp3.organization_code, -- To_Org
 &segment_columns2
 msiv.concatenated_segments, -- Item_Number
 case 
  when (sysdate - civv.shipped_date) < 31  then '30 days'
  when (sysdate - civv.shipped_date) < 61  then '60 days'
  when (sysdate - civv.shipped_date) < 91  then '90 days'
  when (sysdate - civv.shipped_date) < 121 then '120 days'
  when (sysdate - civv.shipped_date) < 151 then '150 days'
  when (sysdate - civv.shipped_date) < 181 then '180 days'
  else 'Over 180 days'
 end -- Aging Date