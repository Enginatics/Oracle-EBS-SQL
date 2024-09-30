/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Price vs. Costing Method Comparison
-- Description: Report to compare the open purchase order lines and unit prices with the costing method item cost in Oracle (Average, Standard, FIFO or LIFO).  Used by the buyers and cost accounting to check the accuracy of the recently created purchase orders and run using a range of purchase order line creation dates.  Foreign currency purchase orders convert to the inventory organization's currency by either using the original purchase order exchange rate, if the Invoice Match Option is "Purchase Order" or by using the latest exchange rate date if the Invoice Match Option is "Receipt".

Parameters:
===========
Creation Date From:  purchase order starting creation date (mandatory).
Creation Date To: purchase order ending creation date (mandatory).
Cost Type:  enter the cost type you wish to report (mandatory).  Defaults to your Costing Method.
Minimum Value Difference:  the absolute smallest difference you want to report (mandatory).
Minimum Cost Difference:  the absolute smallest difference you want to report (mandatory).
Currency Conversion Type:  enter the currency conversion type for translating PO unit prices, used if the Invoice Match Option is "Receipt", defaults to Corporate (mandatory).
Currency Conversion Date:  enter the currency conversion date for translating PO unit prices, used if the Invoice Match Option is "Receipt" (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006-2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.17    13 Jun 2017 Douglas Volz   Added OSP Resource Code
-- |  1.18    19 Aug 2019 Douglas Volz   Removed non-generic item categories
-- |  1.19    27 Jan 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |                                     Added project number to report.
-- |  1.20    19 Dec 2020 Douglas Volz   Add these columns: PO Need By Date, PO Promise Date,
-- |                                     PO Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name (description for category set 1).  
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.21    22 Dec 2020 Douglas Volz   Changed the item cost "union all" to just "union", 
-- |                                     which eliminated a full table scan on cst_item_costs.
-- |  1.22    02 Nov 2023 Douglas Volz   Add Cost Type as a parameter, remove tabs and
-- |                                     add org access controls.
-- |  1.23    18 Jul 2024 Douglas Volz   Fix for Percent Difference calculation.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-po-price-vs-costing-method-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-po-price-vs-costing-method-comparison/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        pv.vendor_name Supplier,
        emp.full_name Buyer,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.19
        -- msiv.inventory_item_status_code Item_Status,
        misv.inventory_item_status_code Item_Status,
        ml.meaning Make_Buy_Code,
        -- Revision for version 1.16 and 1.20
&category_columns
        -- End revision for version 1.16
        -- Revision for version 1.17
        cic.resource_code OSP_Resource,
        pl.vendor_product_num Supplier_Item,
        -- Revision for version 1.20
        round(msiv.list_price_per_unit,5) Target_or_List_Price,
        ph.segment1 PO_Number,
        to_char(pl.line_num) PO_Line,
        -- Revision for version 1.19
        pp.segment1 Project_Number,
        pp.name Project_Name,
        -- Revision for version 1.20
        pll.creation_date Creation_Date,
        pll.promised_date Promised_Date,
        pll.need_by_date Need_by_Date,
        to_char(pr.release_num) PO_Release,
        pr.release_date Release_Date,
        (select max(ms.expected_delivery_date)
         from   mtl_supply ms
         where  ms.supply_type_code in ('PO','RECEIVING','SHIPMENT')
         and    ms.item_id                      = msiv.inventory_item_id
         and    ms.to_organization_id           = msiv.organization_id
         and    ms.destination_type_code        in ('INVENTORY','SHOP FLOOR')
         and    ms.po_distribution_id           = pod.po_distribution_id
        ) Expected_Receipt_Date,
        -- End revision for version 1.20
        -- Revision for version 1.19
        -- pll.unit_meas_lookup_code PO_UOM,
        muomv_po.uom_code PO_UOM,
        pll.quantity PO_Quantity,
        pll.quantity_received PO_Quantity_Received,
        nvl(ph.currency_code, gl.currency_code) PO_Currency_Code,
        nvl(pll.price_override, pl.unit_price) PO_Unit_Price,
        -- Revision for version 1.20
        -- pod.rate_date Currency_Rate_Date,
        -- nvl(pod.rate,1) PO_Exchange_Rate,
        decode(pll.match_option, 
                'P', trunc(nvl(pod.rate_date, pll.creation_date)),
                'R', trunc(nvl(gdr1.conversion_date, sysdate)),
                trunc(nvl(gdr1.conversion_date, sysdate))) Currency_Rate_Date,
        decode(pll.match_option, 
                'P', nvl(pod.rate,1),
                'R', gdr1.conversion_rate,
                gdr1.conversion_rate) PO_Exchange_Rate,
        gl.currency_code GL_Currency_Code,
        decode(pll.match_option, 
                'P', nvl(pod.rate,1),
                'R', gdr1.conversion_rate,
                gdr1.conversion_rate) * nvl(pll.price_override, pl.unit_price) Converted_PO_Unit_Price,
        ucr.conversion_rate PO_UOM_Conversion_Rate,
        decode(pll.match_option, 
                'P', nvl(pod.rate,1),
                'R', gdr1.conversion_rate,
                gdr1.conversion_rate) * nvl(pll.price_override, pl.unit_price) * ucr.conversion_rate Converted_PO_at_Primary_UOM,
        -- End revision for version 1.20
        -- Revision for version 1.19
        -- msiv.primary_uom_code UOM_Code,
        muomv_msi.uom_code UOM_Code,
        -- Revision for version 1.21
        cic.cost_type Cost_Type,
        nvl(cic.unburdened_cost,0) Unburdened_Unit_Cost,
        -- Revision for version 1.20
        -- PO Price - Unburdened Cost = Unit Cost Difference
        round((decode(pll.match_option, 
                'P', nvl(pod.rate,1),
                'R', gdr1.conversion_rate,
                gdr1.conversion_rate) * 
                nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0),5) Unit_Cost_Difference,
        -- PO Price - Unburdened Cost X Quantity = Extended Cost Difference
        round((decode(pll.match_option, 
                'P', nvl(pod.rate,1),
                'R', gdr1.conversion_rate,
                gdr1.conversion_rate) * nvl(pll.price_override, pl.unit_price) -
                nvl(cic.unburdened_cost,0)) * nvl(pll.quantity,0),2) Extended_Cost_Difference,
        -- Revision for version 1.20
        -- round(((nvl(ph.rate,1) * nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0)) /
        --         decode(nvl(cic.unburdened_cost,0),0,1,nvl(cic.unburdened_cost,0)) * 100,1) Percent,
        -- Calculate the Percent Difference
        -- when PO price - item cost = 0 then 0
        -- when item cost = 0 then 100 * SIGN PO price
        -- when PO price  = 0 then -100 * SIGN item cost
        -- else (PO price - item cost) / item cost
        case
           when round(decode(pll.match_option, 
                        'P', nvl(pod.rate,1), 
                        'R', gdr1.conversion_rate,
                        gdr1.conversion_rate
                     ) * nvl(pll.price_override, pl.unit_price) - nvl(cic.unburdened_cost,0),5) = 0
                then 0
           when round(nvl(cic.unburdened_cost,0),5) = 0
                then 100 * SIGN(nvl(pll.price_override, pl.unit_price))
           when round(decode(pll.match_option, 
                        'P', nvl(pod.rate,1), 
                        'R', gdr1.conversion_rate,
                        gdr1.conversion_rate
                     ) * nvl(pll.price_override, pl.unit_price),5) = 0
                then -100 * SIGN(nvl(cic.unburdened_cost,0))
           -- Revision for version 1.23
           -- else round(decode(pll.match_option, 
           --      'P', nvl(pod.rate,1), 
           --      'R', gdr1.conversion_rate,
           --      gdr1.conversion_rate) * nvl(pll.price_override, pl.unit_price) - nvl(cic.unburdened_cost,0) /
           --      nvl(cic.unburdened_cost,0) * 100,2)
           else round((decode(pll.match_option, 
                                'P', nvl(pod.rate,1), 
                                'R', gdr1.conversion_rate,
                                gdr1.conversion_rate) * nvl(pll.price_override, pl.unit_price) - nvl(cic.unburdened_cost,0)) /
                                nvl(cic.unburdened_cost,0) * 100,2)
           -- End revision for version 1.23
        end Percent_Difference,
        -- End revision for version 1.20
        -- Revision for version 1.21
        cic.cost_type               Cost_Type,
        cic.material_cost           Material_Cost,
        cic.material_overhead_cost  Material_Overhead_Cost,
        cic.resource_cost           Resource_Cost,
        cic.outside_processing_cost Outside_Processing_Cost,
        cic.overhead_cost           Overhead_Cost,
        cic.item_cost               Item_Cost
from    po_headers_all              ph,
        po_lines_all                pl,
        po_line_locations_all       pll,
        po_distributions_all        pod,
        po_releases_all             pr,
        po_vendors                  pv,
        -- Revision for version 1.19
        pa_projects_all             pp,
        mtl_system_items_vl         msiv,
        mtl_uom_conversions_view    ucr,
        -- Revision for version 1.19
        mtl_units_of_measure_vl     muomv_po,
        mtl_units_of_measure_vl     muomv_msi,
        mtl_item_status_vl          misv,
        -- End revision for version 1.10
        mfg_lookups                 ml,
        fnd_common_lookups          fcl,
        (select cct.cost_type,
                msiv.inventory_item_id inventory_item_id,
                crc.organization_id organization_id,
                -- Revision for version 1.17
                br.resource_code,
                0 material_cost,
                0 material_overhead_cost,
                0 resource_cost,
                nvl(crc.resource_rate,0) outside_processing_cost,
                0 overhead_cost,
                nvl(crc.resource_rate,0) unburdened_cost,
                nvl(crc.resource_rate,0) item_cost
         from   cst_resource_costs  crc,
                cst_cost_types      cct,
                bom_resources       br,
                mtl_system_items_vl msiv,
                mtl_parameters      mp
         where  crc.cost_type_id      = cct.cost_type_id
         and    crc.resource_id       = br.resource_id
         and    crc.organization_id   = br.organization_id
         and    crc.organization_id   = mp.organization_id
         and    br.purchase_item_id   = msiv.inventory_item_id
         and    br.organization_id    = msiv.organization_id
         and    mp.organization_id    = msiv.organization_id
         and    msiv.item_type        = 'OP'
         -- Revision for version 1.22
         -- and    cct.cost_type_id      = mp.primary_cost_method
         and    2=2                   -- p_org_code
         and    3=3                   -- p_cost_type
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         -- End revision for version 1.22
         -- Revision for version 1.21
         -- union all
         union
         select cct.cost_type,
                cic.inventory_item_id inventory_item_id,
                cic.organization_id organization_id,
                -- Revision for version 1.17
                null resource_code,
                nvl(cic.material_cost,0) material_cost,
                nvl(cic.material_overhead_cost,0) material_overhead_cost,
                nvl(cic.resource_cost,0) resource_cost,
                nvl(cic.outside_processing_cost,0) outside_processing_cost,
                nvl(cic.overhead_cost,0) overhead_cost,
                nvl(cic.unburdened_cost,0) unburdened_cost,
                nvl(cic.item_cost,0) item_cost
         from   cst_item_costs      cic,
                cst_cost_types      cct,
                mtl_system_items_vl msiv,
                mtl_parameters      mp
         where  cic.organization_id   = msiv.organization_id
         and    mp.organization_id    = msiv.organization_id
         and    cic.inventory_item_id = msiv.inventory_item_id
         and    msiv.item_type        <> 'OP'
         and    cic.cost_type_id      = cct.cost_type_id
         -- Revision for version 1.22
         -- and    cct.cost_type_id      = mp.primary_cost_method
         and    2=2                   -- p_org_code
         and    3=3                   -- p_cost_type
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         -- End revision for version 1.22
        ) cic, -- costs per the Cost Method
        hr_employees                 emp,
        mtl_parameters               mp,
        hr_locations                 hl,
        hr_organization_information  hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers                   gl,
        -- Revision for version 1.20
        -- ===========================================================================
        -- Select current Currency Rates based on the currency conversion date
        -- ===========================================================================
        (select gdr1.from_currency,
                gdr1.to_currency,
                gdct1.user_conversion_type,
                gdr1.conversion_date,
                gdr1.conversion_rate
         from   gl_daily_rates gdr1,
                gl_daily_conversion_types gdct1
         where  exists (
                        select  'x'
                        from    mtl_parameters mp,
                                hr_organization_information hoi,
                                hr_all_organization_units_vl haou,
                                hr_all_organization_units_vl haou2,
                                gl_ledgers gl
                        -- =================================================
                        -- Get inventory ledger and operating unit information
                        -- =================================================
                        where   hoi.org_information_context   = 'Accounting Information'
                        and     hoi.organization_id           = mp.organization_id
                        and     hoi.organization_id           = haou.organization_id            -- this gets the organization name
                        and     haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
                        and     gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
                        and     gdr1.to_currency              = gl.currency_code
                        -- Do not report the master inventory organization
                        and     mp.organization_id           <> mp.master_organization_id
                       )
         and    gdr1.conversion_type           = gdct1.conversion_type
         and    4=4                            -- p_curr_conv_date1
         and    5=5                            -- p_curr_conv_type1
         union all
         select gl.currency_code,              -- from_currency
                gl.currency_code,              -- to_currency
                gdct1.user_conversion_type,    -- user_conversion_type
                :p_curr_conv_date1,            -- conversion_date                                             -- p_curr_conv_date1
                1                              -- conversion_rate
         from   gl_ledgers gl,
                gl_daily_conversion_types gdct1
         where  5=5                            -- p_curr_conv_type1
         group by
                gl.currency_code,
                gl.currency_code,
                gdct1.user_conversion_type,                                                                  -- p_curr_conv_date1
                :p_curr_conv_date1,           -- conversion_date                                             -- p_curr_conv_date1
                1
        ) gdr1 -- Current Currency Rates
        -- End for revision 1.20
where   ph.po_header_id                 = pl.po_header_id
and     pl.po_line_id                   = pll.po_line_id
and     pll.line_location_id            = pod.line_location_id
and     pr.po_release_id (+)            = pod.po_release_id
and     pll.closed_code                 =  'OPEN'
and     pv.vendor_id                    = ph.vendor_id
-- Revision for version 1.19
and     pp.project_id (+)               = pod.project_id
and     muomv_po.unit_of_measure        = pll.unit_meas_lookup_code
and     muomv_msi.uom_code              = msiv.primary_uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.19
and     msiv.inventory_item_id          = ucr.inventory_item_id
and     msiv.organization_id            = ucr.organization_id
and     ucr.unit_of_measure             = pl.unit_meas_lookup_code
and     pl.item_id                      = msiv.inventory_item_id
and     cic.inventory_item_id           = msiv.inventory_item_id
and     cic.organization_id             = msiv.organization_id
and     ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml.lookup_code                  = msiv.planning_make_buy_code
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     ph.agent_id                     = emp.employee_id
and     mp.organization_id              = msiv.organization_id
and     pll.ship_to_location_id         = hl.ship_to_location_id
and     msiv.organization_id            = pll.ship_to_organization_id
and     1=1 -- p_creation_date_from, p_creation_date_to, p_min_value_diff, p_min_cost_diff, p_operating_unit, p_ledger
and     2=2 -- p_org_code
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- Current FX rate
and     ph.currency_code                = gdr1.from_currency
and     gl.currency_code                = gdr1.to_currency
-- ===================================================================
-- Using the base tables instead of HR organization views
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.22
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
-- ===================================================================
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating_Unit
        mp.organization_code, -- Org_Code
        pv.vendor_name, -- Supplier
        msiv.concatenated_segments, -- Item_Number
        pl.vendor_product_num, -- Supplier_Item
        ph.segment1, -- PO_Number
        to_char(pl.line_num), -- PO_Line
        to_char(pr.release_num) -- PO_Rel