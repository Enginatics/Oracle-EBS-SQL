/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item List Price vs. Item Cost
-- Description: Compare item master list price against any cost type (Cost Type 1) and also list the Standard Price (Market Price), Last PO Price, Converted Last PO Price and a secondary cost type (Cost Type 2).  All item costs and prices are in the primary UOM, using the To Currency Code.

-- | Program Name: xxx_item_target_cost_review_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type1             -- The first comparison cost type you wish to report
-- |  p_cost_type2             -- The second comparison cost type you wish to report
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed items
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    29 Sep 2020 Douglas Volz   Initial Coding based on Item Cost Summary Report
-- |  1.1    22 Oct 2020 Douglas Volz   Added the Master Target Price
-- |  1.2    26 Oct 2020 Douglas Volz   Changed as List Price is always in a common, global
-- |                                    currency, translate to this "to_currency" currency
-- |  1.3    28 Oct 2020 Douglas Volz   Fixes for the last PO, need to exclude Cancelled
-- |                                    PO Lines.  
-- |  1.4    30 Oct 2020 Douglas Volz   Add To Currency Code as a visible parameter and
-- |                                    show all item costs in that currency
-- |  1.5    04 Dec 2020 Douglas Volz   Outer join fix for PO joins to item master and
-- |                                    currency exchange rates.
-- |  1.6    06 Dec 2020 Douglas Volz   Added Target Price Percent Difference column.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-list-price-vs-item-cost/
-- Library Link: https://www.enginatics.com/reports/cac-item-list-price-vs-item-cost/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- ===================================================================
-- First get the items which are costing enabled 
-- ===================================================================
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
&category_columns
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 cic1.shrinkage_rate Shrinkage_Rate,
 gl.currency_code From_Currency_Code,
 gdr.to_currency To_Currency_Code,
 gdr.conversion_rate Conversion_Rate,
 -- Revision for version 1.3
 -- msiv.market_price Market_Price,
 -- Revision for version 1.2
 round(msiv.market_price * nvl(gdr.conversion_rate,1),5) Market_Price,
 -- Revision for version 1.3
 -- Revision for version 1.1
 -- msiv.list_price_per_unit Master_Target_PO_List_Price,
 -- msiv_mas.list_price_per_unit BU_Target_PO_List_Price,
 -- Revision for version 1.2
 round(msiv.list_price_per_unit * nvl(gdr.conversion_rate,1),5) Master_Target_or_List_Price,
 round(msiv_mas.list_price_per_unit * nvl(gdr.conversion_rate,1),5) BU_Target_or_List_Price,
 round(nvl(cic1.unburdened_cost,0) * nvl(gdr.conversion_rate,1),5) "&Cost_Type1 Unburdened Cost",
 round((nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0)) * nvl(gdr.conversion_rate,1),5) Target_Price_Difference,
 -- Revision for version 1.6
 case
   when round((nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0)),5) = 0 then 0
   when round((nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0)),5) = round(nvl(msiv.list_price_per_unit,0),5) then 100
   when round((nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0)),5) = round(nvl(cic1.unburdened_cost,0),5) then -100
   else round((nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0)) / nvl(cic1.unburdened_cost,0) * 100,1)
 end Percent_Difference,
 -- End revision for version 1.6
 po.Last_Purchase_Order,
 po.Last_PO_Line,
 po.Last_PO_Date,
 po.Last_PO_Currency_Code,
 po.Last_PO_Price,
 -- Revision for version 1.3
 -- Need to compare the PO currency to the To Currency
 -- po.Last_PO_Price * nvl(gdr.conversion_rate,1) Converted_Last_PO_Price,
 po.Last_PO_Price *  nvl(gdr_po.conversion_rate,1) Converted_Last_PO_Price,
 -- End revision for version 1.2
 -- End revision for version 1.3
 cct1.cost_type Cost_Type_1,
 round(nvl(cic1.material_cost,0) * nvl(gdr.conversion_rate,1),5) Material_Cost1,
 round(nvl(cic1.material_overhead_cost,0) * nvl(gdr.conversion_rate,1),5) Material_Overhead_Cost1,
 round(nvl(cic1.resource_cost,0) * nvl(gdr.conversion_rate,1),5) Resource_Cost1,
 round(nvl(cic1.outside_processing_cost,0) * nvl(gdr.conversion_rate,1),5) Outside_Processing_Cost1,
 round(nvl(cic1.overhead_cost,0) * nvl(gdr.conversion_rate,1),5) Overhead_Cost1,
        round(nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1),5) Item_Cost1,
 cic1.creation_date Cost_Creation_Date1,
 cic1.last_update_date Last_Cost_Update_Date1,
 cic2.cost_type Cost_Type_2,
 round(nvl(cic2.unburdened_cost,0) * nvl(gdr.conversion_rate,1),5) Unburdened_Cost2,
 round(nvl(cic2.material_cost,0) * nvl(gdr.conversion_rate,1),5) Material_Cost2,
 round(nvl(cic2.material_overhead_cost,0) * nvl(gdr.conversion_rate,1),5) Material_Overhead_Cost2,
 round(nvl(cic2.resource_cost,0) * nvl(gdr.conversion_rate,1),5) Resource_Cost2,
 round(nvl(cic2.outside_processing_cost,0) * nvl(gdr.conversion_rate,1),5) Outside_Processing_Cost2,
 round(nvl(cic2.overhead_cost,0) * nvl(gdr.conversion_rate,1),5) Overhead_Cost2,
        round(nvl(cic2.item_cost,0) * nvl(gdr.conversion_rate,1),5) Item_Cost2,
 cic2.creation_date Cost_Creation_Date2,
 cic2.last_update_date Last_Cost_Update_Date2
from    cst_item_costs cic1,
 cst_cost_types cct1,
 (select cic2.cost_type_id,
  cct2.cost_type,
  cic2.organization_id,
  mp.organization_code,
  cic2.inventory_item_id,
  cic2.unburdened_cost,
  cic2.material_cost,
  cic2.material_overhead_cost,
  cic2.resource_cost,
  cic2.outside_processing_cost,
  cic2.overhead_cost,
  cic2.item_cost,
  cic2.creation_date,
  cic2.last_update_date,
  -- Revision for version 1.2
  gl.currency_code
  from cst_item_costs cic2,  -- target item costs
  cst_cost_types cct2,  -- target cost type
  mtl_system_items_vl msiv,
  mtl_parameters mp,
  -- Revision for version 1.2
  hr_organization_information hoi,
  hr_all_organization_units_vl haou, -- inv_organization_id
  hr_all_organization_units_vl haou2, -- operating unit
  gl_ledgers gl
  -- End revision for version 1.2
  where    cct2.cost_type_id      = cic2.cost_type_id
  and    mp.organization_id     = cic2.organization_id
  and    msiv.inventory_item_id = cic2.inventory_item_id
  and    msiv.organization_id   = cic2.organization_id
  -- Revision for version 1.2
  and    hoi.org_information_context     = 'Accounting Information'
  and    hoi.organization_id             = mp.organization_id
  and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
  and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
  and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
  -- End revision for version 1.2
  -- Revision for version 1.2
  and    1=1                             -- p_operating_unit, p_ledger
  and    5=5                             -- p_cost_type2
  and    6=6                             -- p_item_number
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and    7=7                             -- p_org_code
 ) cic2,
 -- ===========================================================================
 -- Revision for version 1.2
 -- Tables to get currency exchange rate information for the inventory orgs
 -- Select Currency Rates based on the currency conversion date and type
 -- ===========================================================================
 (select gdr.from_currency,
  gdr.to_currency,
  gdct.user_conversion_type,
  gdr.conversion_date,
  gdr.conversion_rate
  from gl_daily_rates gdr,
         gl_daily_conversion_types gdct
  -- =================================================
  -- Check for the currencies needed for the To Orgs
  -- =================================================
  where exists  (
    select 'x'
    from mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and    gdr.to_currency               = gl.currency_code
    and    mp.organization_id           <> mp.master_organization_id
            )
  -- =================================================
  -- Check for the currencies needed for from inventory Orgs
  -- =================================================
  and exists  (
    select 'x'
    from    mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and hoi.organization_id           = mp.organization_id
    and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and gdr.from_currency             = gl.currency_code
    and mp.organization_id           <> mp.master_organization_id
   )
  and gdr.conversion_type       = gdct.conversion_type
  and    8=8                                           -- p_curr_conv_type
  and    9=9                                           -- p_curr_conv_date
  union all
  -- =================================================
  -- Get the currencies where the From and To is the 
  -- same.  Example, where the From currency = USD 
  -- and To currency = USD
  -- =================================================
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct.user_conversion_type,     -- conversion_type
  :p_curr_conv_date,             -- p_curr_conv_date
  1                              -- conversion_rate
  from gl_ledgers gl,
  gl_daily_conversion_types gdct
  where 8=8                             -- p_curr_conv_type
  -- Revision for version 1.33
  and gl.accounted_period_type  =    (select max(gl.accounted_period_type) 
      from mtl_parameters mp,
       hr_organization_information hoi,
       gl_ledgers gl
       where hoi.org_information_context   = 'Accounting Information'
       and hoi.organization_id           = mp.organization_id
       and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
       and mp.organization_id           <> mp.master_organization_id
      )
  group by
  gl.currency_code,
  gl.currency_code,
  gdct.user_conversion_type,
  :p_curr_conv_date,             -- p_curr_conv_date
  1
 ) gdr, -- Currency Exchange Rates to use for all inventory orgs
 -- ===========================================================================
 -- Revision for version 1.2
 -- Tables to get currency exchange rate information for the inventory orgs
 -- Select Currency Rates based on the currency conversion date and type
 -- ===========================================================================
 (select gdr.from_currency,
  gdr.to_currency,
  gdct.user_conversion_type,
  gdr.conversion_date,
  gdr.conversion_rate
  from gl_daily_rates gdr,
         gl_daily_conversion_types gdct
  -- =================================================
  -- Check for the currencies needed for the To Orgs
  -- =================================================
  where exists  (
    select 'x'
    from mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and    gdr.to_currency               = gl.currency_code
    and    mp.organization_id           <> mp.master_organization_id
            )
  -- =================================================
  -- Get all From Currencies as the PO may be in any currency
  -- =================================================
  and gdr.conversion_type       = gdct.conversion_type
  and    8=8                                           -- p_curr_conv_type
  and    9=9                                           -- p_curr_conv_date
  union all
  -- =================================================
  -- Get the currencies where the From and To is the 
  -- same.  Example, where the From currency = USD 
  -- and To currency = USD
  -- =================================================
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct.user_conversion_type,     -- conversion_type
  :p_curr_conv_date,             -- p_curr_conv_date
  1                              -- conversion_rate
  from gl_ledgers gl,
  gl_daily_conversion_types gdct
  where 8=8                             -- p_curr_conv_type
  -- Revision for version 1.33
  and gl.accounted_period_type  =    (select max(gl.accounted_period_type) 
      from mtl_parameters mp,
       hr_organization_information hoi,
       gl_ledgers gl
       where hoi.org_information_context   = 'Accounting Information'
       and hoi.organization_id           = mp.organization_id
       and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
       and mp.organization_id           <> mp.master_organization_id
      )
  group by
  gl.currency_code,
  gl.currency_code,
  gdct.user_conversion_type,
  :p_curr_conv_date,             -- p_curr_conv_date
  1
 ) gdr_po, -- Currency Exchange Rates to use for the purchase orders
 -- Now get the last PO Price information
 (
  select x.*,
  round(x.unit_price * mucv.conversion_rate, 6) last_po_price
  from
  (
   select distinct
   pla.item_id inventory_item_id,
   plla.ship_to_organization_id organization_id,
   max(pha.segment1) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_purchase_order,
   max(pla.line_num) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_line,
   max(plla.po_date) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_date,
   max(pha.currency_code) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_currency_code,
   max(nvl(plla.price_override,pla.unit_price)) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) unit_price,
   max(pla.unit_meas_lookup_code) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) unit_meas_lookup_code
   from po_headers_all pha,
   po_lines_all pla,
   (select coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date) po_date, plla.* from po_line_locations_all plla) plla,
   po_distributions_all pda
   where 11=11                        -- p_item_number, p_org_code
   and pla.item_id is not null
   and plla.ship_to_organization_id is not null
   and pha.authorization_status = 'APPROVED'
   -- Revision for version 1.3
   and pla.closed_code not in ('CANCELLED', 'INCOMPLETE', 'ON HOLD', 'REJECTED', 'RETURNED')
   and pha.po_header_id = pla.po_header_id
   and pla.po_line_id = plla.po_line_id
   and plla.line_location_id = pda.line_location_id
   and pda.destination_type_code = 'INVENTORY'
  ) x,
   mtl_uom_conversions_view mucv
  where x.unit_meas_lookup_code = mucv.unit_of_measure(+)
  and x.inventory_item_id = mucv.inventory_item_id(+)
  and x.organization_id = mucv.organization_id(+)
 ) po,
 -- End revision for version 1.2
 mtl_system_items_vl msiv,
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- Revision for version 1.1
 mtl_system_items_vl msiv_mas,
 mtl_parameters mp,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
 -- ===================================================================
 -- Item master, organization and item master to cost joins
 -- ===================================================================
where mp.organization_id              = msiv.organization_id
and msiv.inventory_item_id          = cic1.inventory_item_id
and msiv.organization_id            = cic1.organization_id
-- Revision for version 1.1
and msiv_mas.inventory_item_id      = msiv.inventory_item_id
and msiv_mas.organization_id        = msiv.organization_id
-- End revision for version 1.1
-- Revision for version 1.2
and po.inventory_item_id (+)        = msiv.inventory_item_id
and po.organization_id (+)          = msiv.organization_id
-- End for revision for version 1.2
and cic1.inventory_item_id (+)      = cic2.inventory_item_id
and cic1.organization_id (+)        = cic2.organization_id
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
and cic1.cost_type_id               = cct1.cost_type_id
and 1=1                          -- p_operating_unit, p_ledger
and 4=4                          -- p_cost_type1
and 6=6                          -- p_item_number
and 7=7                          -- p_org_code
-- ===================================================================
-- Joins for currency translation rate
-- ===================================================================
-- Revision for version 1.2
-- Translate for inventory for the To Currency
-- and    gdr.to_currency                 = cic2.currency_code
and gdr.to_currency                 = :p_currency_code
and gdr.from_currency   (+)         = gl.currency_code -- based on the inventory organization
-- Revision for version 1.3
-- Translate for the purhase orders for the To Currency
and gdr_po.to_currency (+)          = :p_currency_code
and gdr_po.from_currency (+)        = po.Last_PO_Currency_Code -- based on the purchase order
-- End revision for version 1.3
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
and mp.organization_id             <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = to_char(cic1.inventory_asset_flag)
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = cic1.based_on_rollup_flag
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
union all
-- ===================================================================
-- Now get the items which are not costing enabled 
-- ===================================================================
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
&category_columns
 fl1.meaning Allow_Costs,
 fl2.meaning Inventory_Asset,
 'N/A' Based_on_Rollup,
 null Shrinkage_Rate,
 gl.currency_code Currency_Code,
 gdr.to_currency To_Currency_Code,
 gdr.conversion_rate Conversion_Rate,
 -- Revision for version 1.3
 -- msiv.market_price Market_Price,
 -- Revision for version 1.2
 round(msiv.market_price * nvl(gdr.conversion_rate,1),5) Market_Price,
 -- Revision for version 1.3
 -- Revision for version 1.1
 -- msiv.list_price_per_unit Master_Target_PO_List_Price,
 -- msiv.list_price_per_unit BU_Target_PO_List_Price,
 -- Revision for version 1.2
 round(msiv.list_price_per_unit * nvl(gdr.conversion_rate,1),5) Master_Target_List_Price,
 round(msiv_mas.list_price_per_unit * nvl(gdr.conversion_rate,1),5) BU_Target_List_Price,
 null "&Cost_Type1 Unburdened Cost",
 round((nvl(msiv.list_price_per_unit,0) - 0 ),5) Target_Price_Difference,
 -- Revision for version 1.6
 case
   when round((nvl(msiv.list_price_per_unit,0) - 0),5) = 0 then 0
   when round((nvl(msiv.list_price_per_unit,0) - 0),5) = round(nvl(msiv.list_price_per_unit,0),5) then 100
   else 0
 end Percent_Difference,
 -- End revision for version 1.6
 po.Last_Purchase_Order,
 po.Last_PO_Line,
 po.Last_PO_Date,
 po.Last_PO_Currency_Code,
 po.Last_PO_Price,
 -- Revision for version 1.3
 -- Need to compare the PO currency to the To Currency
 -- po.Last_PO_Price * nvl(gdr.conversion_rate,1) Converted_Last_PO_Price_USD,
 po.Last_PO_Price * decode(po.Last_PO_Currency_Code,
    gdr.to_currency, 1,
    nvl(gdr.conversion_rate,1)) Converted_Last_PO_Price_USD,
 -- End revision for version 1.3
 -- End revision for version 1.2
 null Cost_Type_1,
 null Unburdened_Cost1,
 null Material_Cost1,
 null Material_Overhead_Cost1,
 null Resource_Cost1,
 null Outside_Processing_Cost1,
 null Overhead_Cost1,
 null Item_Cost1,
 null Cost_Creation_Date1,
 null Last_Cost_Update_Date1,
 null Cost_Type_2,
 null Material_Cost2,
 null Material_Overhead_Cost2,
 null Resource_Cost2,
 null Outside_Processing_Cost2,
 null Overhead_Cost2,
 null Item_Cost2,
 null Cost_Creation_Date2,
 null Last_Cost_Update_Date2
from -- ===========================================================================
 -- Revision for version 1.2
 -- Tables to get currency exchange rate information for the inventory orgs
 -- Select Currency Rates based on the currency conversion date and type
 -- ===========================================================================
 (select gdr.from_currency,
  gdr.to_currency,
  gdct.user_conversion_type,
  gdr.conversion_date,
  gdr.conversion_rate
  from gl_daily_rates gdr,
         gl_daily_conversion_types gdct
  -- =================================================
  -- Check for the currencies needed for the To Orgs
  -- =================================================
  where exists  (
    select 'x'
    from mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and    gdr.to_currency               = gl.currency_code
    and    mp.organization_id           <> mp.master_organization_id
            )
  -- =================================================
  -- Check for the currencies needed for from inventory Orgs
  -- =================================================
  and exists  (
    select 'x'
    from    mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and hoi.organization_id           = mp.organization_id
    and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and gdr.from_currency             = gl.currency_code
    and mp.organization_id           <> mp.master_organization_id
   )
  and gdr.conversion_type       = gdct.conversion_type
  and    8=8                                           -- p_curr_conv_type
  and    9=9                                           -- p_curr_conv_date
  union all
  -- =================================================
  -- Get the currencies where the From and To is the 
  -- same.  Example, where the From currency = USD 
  -- and To currency = USD
  -- =================================================
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct.user_conversion_type,     -- conversion_type
  :p_curr_conv_date,             -- p_curr_conv_date
  1                              -- conversion_rate
  from gl_ledgers gl,
  gl_daily_conversion_types gdct
  where 8=8                             -- p_curr_conv_type
  -- Revision for version 1.33
  and gl.accounted_period_type  =    (select max(gl.accounted_period_type) 
      from mtl_parameters mp,
       hr_organization_information hoi,
       gl_ledgers gl
       where hoi.org_information_context   = 'Accounting Information'
       and hoi.organization_id           = mp.organization_id
       and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
       and mp.organization_id           <> mp.master_organization_id
      )
  group by
  gl.currency_code,
  gl.currency_code,
  gdct.user_conversion_type,
  :p_curr_conv_date,             -- p_curr_conv_date
  1
 ) gdr, -- Currency Exchange Rates to use for all inventory orgs
 -- ===========================================================================
 -- Revision for version 1.2
 -- Tables to get currency exchange rate information for the inventory orgs
 -- Select Currency Rates based on the currency conversion date and type
 -- ===========================================================================
 (select gdr.from_currency,
  gdr.to_currency,
  gdct.user_conversion_type,
  gdr.conversion_date,
  gdr.conversion_rate
  from gl_daily_rates gdr,
         gl_daily_conversion_types gdct
  -- =================================================
  -- Check for the currencies needed for the To Orgs
  -- =================================================
  where exists  (
    select 'x'
    from mtl_parameters mp,
    hr_organization_information hoi,
    gl_ledgers gl
    where hoi.org_information_context   = 'Accounting Information'
    and    hoi.organization_id           = mp.organization_id
    and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
    and    gdr.to_currency               = gl.currency_code
    and    mp.organization_id           <> mp.master_organization_id
            )
  -- =================================================
  -- Get all From Currencies as the PO may be in any currency
  -- =================================================
  and gdr.conversion_type       = gdct.conversion_type
  and    8=8                                           -- p_curr_conv_type
  and    9=9                                           -- p_curr_conv_date
  union all
  -- =================================================
  -- Get the currencies where the From and To is the 
  -- same.  Example, where the From currency = USD 
  -- and To currency = USD
  -- =================================================
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct.user_conversion_type,     -- conversion_type
  :p_curr_conv_date,             -- p_curr_conv_date
  1                              -- conversion_rate
  from gl_ledgers gl,
  gl_daily_conversion_types gdct
  where 8=8                             -- p_curr_conv_type
  -- Revision for version 1.33
  and gl.accounted_period_type  =    (select max(gl.accounted_period_type) 
      from mtl_parameters mp,
       hr_organization_information hoi,
       gl_ledgers gl
       where hoi.org_information_context   = 'Accounting Information'
       and hoi.organization_id           = mp.organization_id
       and gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
       and mp.organization_id           <> mp.master_organization_id
      )
  group by
  gl.currency_code,
  gl.currency_code,
  gdct.user_conversion_type,
  :p_curr_conv_date,             -- p_curr_conv_date
  1
 ) gdr_po, -- Currency Exchange Rates to use for the purchase orders
 -- Now get the last PO Price information
 (
  select x.*,
  round(x.unit_price * mucv.conversion_rate, 6) last_po_price
  from
  (
   select distinct
   pla.item_id inventory_item_id,
   plla.ship_to_organization_id organization_id,
   max(pha.segment1) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_purchase_order,
   max(pla.line_num) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_line,
   max(plla.po_date) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_date,
   max(pha.currency_code) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) last_po_currency_code,
   max(nvl(plla.price_override,pla.unit_price)) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) unit_price,
   max(pla.unit_meas_lookup_code) keep (dense_rank last order by plla.po_date,pda.po_distribution_id) over (partition by plla.ship_to_organization_id, pla.item_id) unit_meas_lookup_code
   from po_headers_all pha,
   po_lines_all pla,
   (select coalesce(plla.promised_date,plla.need_by_date,plla.last_update_date) po_date, plla.* from po_line_locations_all plla) plla,
   po_distributions_all pda
   where 11=11                        -- p_item_number, p_org_code
   and pla.item_id is not null
   and plla.ship_to_organization_id is not null
   and pha.authorization_status = 'APPROVED'
   -- Revision for version 1.3
   and pla.closed_code not in ('CANCELLED', 'INCOMPLETE', 'ON HOLD', 'REJECTED', 'RETURNED')
   and pha.po_header_id = pla.po_header_id
   and pla.po_line_id = plla.po_line_id
   and plla.line_location_id = pda.line_location_id
   and pda.destination_type_code = 'INVENTORY'
  ) x,
   mtl_uom_conversions_view mucv
  where x.unit_meas_lookup_code = mucv.unit_of_measure(+)
  and x.inventory_item_id = mucv.inventory_item_id(+)
  and x.organization_id = mucv.organization_id(+)
 ) po,
 -- End revision for version 1.2
 mtl_system_items_vl msiv,
 -- Revision for version 1.1
 mtl_system_items_vl msiv_mas,
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 mtl_parameters mp,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 fnd_lookups fl1, -- inventory_asset_flag, YES_NO
 fnd_lookups fl2, -- allow costs, YES_NO
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
 -- ===================================================================
 -- Item master, organization and item master to cost joins
 -- ===================================================================
where mp.organization_id              = msiv.organization_id
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- Revision for version 1.1
and msiv_mas.inventory_item_id      = msiv.inventory_item_id
and msiv_mas.organization_id        = msiv.organization_id
-- End revision for version 1.1
-- Revision for version 1.2
and po.inventory_item_id (+)        = msiv.inventory_item_id
and po.organization_id (+)          = msiv.organization_id
-- End for revision for version 1.2
and 1=1                          -- p_operating_unit, p_ledger
and 6=6                          -- p_item_number
and 7=7                          -- p_org_code
and 10=10                        -- Include or exclude uncosted items
-- ===================================================================
-- Find items where the item has no cost information
-- ===================================================================
and msiv.costing_enabled_flag       = 'N'
-- ===================================================================
-- Joins for currency translation rate
-- ===================================================================
-- Revision for version 1.2
-- Translate for inventory for the To Currency
-- and    gdr.to_currency                 = cic2.currency_code
and gdr.to_currency                 = :p_currency_code
and gdr.from_currency (+)           = gl.currency_code -- based on the inventory organization
-- Revision for version 1.3
-- Translate for the purhase orders for the To Currency
and gdr_po.to_currency (+)          = :p_currency_code
and gdr_po.from_currency (+)        = po.Last_PO_Currency_Code -- based on the purchase order
-- End revision for version 1.3
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
and mp.organization_id             <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code        