/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Open Purchase Orders
-- Description: Report to show open purchase orders and related information.  This report will convert any foreign currency purchases into the currency of the general ledger (defaulted from the inventory organization for this session).  Use the To and From Transaction Date parameters to create an average receipt cost and use the Comparison Cost Type parameter to show a comparison 
amounts from another cost type.

Parameters:
===========
Comparison Cost Type: enter the cost type for a comparison against the purchase order prices (optional).  Defaulted from your Costing Method.
Transaction Date From:  starting transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Transaction Date To:  ending transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Currency Conversion Date:  enter the currency conversion date to use for converting foreign currency purchases into the currency of the general ledger (mandatory).
Currency Conversion Type:  enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
Supplier Name:  specific vendor or supplier you wish to report (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2020 - 2023 Douglas Volz Consulting, Inc. 
-- | All rights reserved. 
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |        
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  open_po_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     09 Sep 2020 Douglas Volz   Initial Coding based on Purchase Price 
-- |                                     variance report, xxx_ppv_lot_rept.sql
-- |  1.1     10 Sep 2020 Douglas Volz   Added inspection flag.
-- |  1.2     01 Dec 2020 Douglas Volz   Added variance and charge accounts
-- |  1.3     20 Dec 2020 Douglas Volz   Added promise date, Need By Date, project,
-- |                                     Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name and difference columns.
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.4     03 Feb 2021 Douglas Volz   Merged OSP with stock purchase orders.
-- |  1.5     05 Feb 2021 Douglas Volz   Added PO averages and item cost information.
-- |  1.6     07 Jul 2022 Douglas Volz   Add multi-language item status.
-- |  1.7     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins. 
-- |  1.8     15 Dec 2023 Douglas Volz   Setting the comparison cost type as mandatory, to
-- |                                     prevent a multiple rows error for the comparison cost type.  
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-open-purchase-orders/
-- Library Link: https://www.enginatics.com/reports/cac-open-purchase-orders/
-- Run Report: https://demo.enginatics.com/

select  -- Revision for version 1.8
        -- nvl(gl.short_name, gl.name) Ledger,
        -- haou2.name Operating_Unit,
        pll.ledger Ledger,
        pll.operating_unit Operating_Unit,
        -- End revision for version 1.8
        mp.organization_code Org_Code,
        pov.vendor_name Supplier,
        hr.full_name Buyer,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.6
        misv.inventory_item_status_code Item_Status,
&category_columns
        pl1.displayed_field PO_Destination_Type,
        --we.wip_entity_name WIP_Job,
        cic.resource_code OSP_Resource,
        pl.vendor_product_num Supplier_Item,
        round(msiv.list_price_per_unit,5) Target_or_List_Price,
        -- Revision for version 1.8
        -- ph.segment1 PO_Number,
        pll.po_number PO_Number,
        -- End revision for version 1.8
        to_char(pl.line_num)  PO_Line,
        nvl(pl4.displayed_field,nvl(pl3.displayed_field, pl2.displayed_field))  PO_Line_Status,
        pp.segment1 Project_Number,
        pp.name Project_Name,
        pll.creation_date Creation_Date,
        -- Revision for version 1.2
        pll.promised_date Promise_Date,
        pll.need_by_date Need_by_Date,
        to_char(pr.release_num) PO_Release,
        pr.release_date Release_Date,
        (select  max(ms.expected_delivery_date)
         from    mtl_supply ms
         where   ms.supply_type_code in ('PO','RECEIVING','SHIPMENT')
         and     ms.item_id                = msiv.inventory_item_id
         and     ms.to_organization_id     = msiv.organization_id
         and     ms.destination_type_code in ('INVENTORY','SHOP FLOOR')
         and     ms.po_distribution_id     = pod.po_distribution_id
        ) Expected_Receipt_Date,
        -- Revision for version 1.1
        fcl.meaning Inspection_Required,
        muomv_po.uom_code PO_UOM,
        -- Revision for version 1.8
        -- nvl(ph.currency_code, gl.currency_code) PO_Currency_Code,
        nvl(pll.currency_code, pll.gl_currency_code) PO_Currency_Code,
        -- End revision for version 1.8
        nvl(pll.price_override, pl.unit_price) PO_Unit_Price,
        decode(pll.match_option, 
             'P', trunc(nvl(pod.rate_date, pll.creation_date)),
             'R', trunc(nvl(gdr_po.conversion_date, sysdate)),
             trunc(nvl(gdr_po.conversion_date, sysdate))) Currency_Rate_Date,
        round(decode(pll.match_option, 
             'P', nvl(pod.rate,1),
             'R', gdr_po.conversion_rate,
             gdr_po.conversion_rate),6) PO_Exchange_Rate,
        -- Revision for version 1.8
        -- gl.currency_code GL_Currency_Code,
        pll.currency_code GL_Currency_Code,
        -- End revision for version 1.8
        round(decode(pll.match_option, 
             'P', nvl(pod.rate,1),
             'R', gdr_po.conversion_rate,
             gdr_po.conversion_rate) * nvl(pll.price_override, pl.unit_price),6) Converted_PO_Unit_Price,
        ucr.conversion_rate PO_UOM_Conversion_Rate,
        round(decode(pll.match_option, 
             'P', nvl(pod.rate,1),
             'R', gdr_po.conversion_rate,
             gdr_po.conversion_rate) * nvl(pll.price_override, pl.unit_price) * ucr.conversion_rate,6) Converted_PO_at_Primary_UOM,
        -- Revision for version 1.4
        muomv_msi.uom_code UOM_Code,
        round(nvl(cic.unburdened_cost,0),5) Unburdened_Unit_Cost,
        -- Revision for version 1.20
        -- PO Price - Unburdened Cost = Unit_Cost_Difference
        round((decode(pll.match_option, 
             'P', nvl(pod.rate,1),
             'R', gdr_po.conversion_rate,
             gdr_po.conversion_rate) * 
             nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0),5) Unit_Cost_Difference,
        -- Revision for version 1.20
        -- (PO Price - Unburdened Cost) * nvl(pll.quantity,0) = Extended_Cost_Difference
        round(((decode(pll.match_option, 
             'P', nvl(pod.rate,1),
             'R', gdr_po.conversion_rate,
             gdr_po.conversion_rate) * 
             nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0)) * nvl(pll.quantity,0),2) Extended_Cost_Difference,
        -- Calculate the Percent Difference
        --   when difference = 0 then 0
        --   when item cost = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO Price - item cost / item cost
        case
        when round(decode(pll.match_option, 
                          'P', nvl(pod.rate,1),
                          'R', gdr_po.conversion_rate,
                          gdr_po.conversion_rate * 
                          nvl(pll.price_override, pl.unit_price)
                      ) - nvl(cic.unburdened_cost,0),5) = 0 then 0
        when round(nvl(cic.unburdened_cost,0),5) = 0 then 100
        when round(decode(pll.match_option, 
                          'P', nvl(pod.rate,1), 
                          'R', gdr_po.conversion_rate,
                          gdr_po.conversion_rate
                      ) * nvl(pll.price_override, pl.unit_price),5) = 0 then -100
        else round(((decode(pll.match_option, 
                          'P', nvl(pod.rate,1),
                          'R', gdr_po.conversion_rate,
                          gdr_po.conversion_rate) * 
                          nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0)) / nvl(cic.unburdened_cost,0) * 100,2)
        end Percent_Difference,
        -- End revision for version 1.20
        cct_curr.cost_type Current_Cost_Type,
        -- Revision for version 1.5
        round(cic.material_cost,5) Material_Cost,
        round(cic.material_overhead_cost,5) Material_Overhead_Cost,
        round(cic.resource_cost,5) Resource_Cost,
        round(cic.outside_processing_cost,5) Outside_Processing_Cost,
        round(cic.overhead_cost,5) Overhead_Cost,
        round(cic.item_cost,5) Current_Item_Cost,
        -- Revision for version 1.5
        (select round(cic.material_cost,5) - round(cic.tl_material_overhead,5)
         from   cst_item_costs cic,
                cst_cost_types cct,
                mtl_parameters mp             
         where  cic.inventory_item_id = msiv.inventory_item_id
         and    cic.organization_id   = msiv.organization_id
         and    cic.cost_type_id      = cct.cost_type_id
         and    mp.organization_id    = cic.organization_id
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    6=6                   -- p_org_code
         and    10=10                 -- p_cost_type
        ) Comparison_Material_Cost,
        receipts.receipt_qty Average_Receipt_Quantity,
        receipts.receipt_amount Average_Receipt_Amount,
        receipts.avg_receipt_cost Average_Receipt_Cost,
        -- End revision for version 1.5
        pll.quantity Quantity_Ordered,
        pll.quantity_received Quantity_Received,
        pll.quantity_billed Quantity_Invoiced,
        round(nvl(pod.rate,1) * pll.price_override * (pll.quantity * ucr.conversion_rate),2) Total_PO_Amount,
        -- Revision for version 1.1
        &segment_columns
        pl.creation_date PO_Line_Creation_Date
from    po_vendors pov,
        wip_entities we,
        -- Revision for version 1.8
        -- po_headers_all ph,
        po_lines_all pl,
        (select pha.currency_code currency_code,
                -- Revision for version 1.8
                gl.currency_code gl_currency_code,
                nvl(gl.short_name, gl.name) Ledger,
                haouv.name operating_unit,
                pha.segment1 PO_Number,
                pha.agent_id,
                pha.vendor_id,
                pha.closed_date ph_closed_date,
                pha.closed_code ph_closed_code,
                pll.*
                -- End revision for version 1.8
         from   po_line_locations_all pll,
                po_headers_all pha,
                org_organization_definitions ood,
                gl_ledgers gl,
                hr_all_organization_units_vl haouv
         where  gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
         and    haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
         and    1=1                         -- p_operating_unit, p_ledger
         and    pll.po_header_id            = pha.po_header_id
         and    pll.ship_to_organization_id = ood.organization_id
         and    ood.set_of_books_id         = gl.ledger_id
         and    ood.operating_unit          = haouv.organization_id
        ) pll,
        po_releases_all pr,
        po_distributions_all pod,
        mtl_system_items_vl msiv,
        -- Revision for version 1.5
        cst_cost_types cct_curr,
        mtl_uom_conversions_view ucr,
        -- Revision for version 1.4
        mtl_units_of_measure_vl muomv_msi,
        mtl_units_of_measure_vl muomv_po,
        pa_projects_all pp,
        -- End revision for version 1.4
        -- Revision for version 1.6
        mtl_item_status_vl misv,
        -- Revision for version 1.4
        (select crc.organization_id,
                msiv.inventory_item_id purchase_item_id,
                br.resource_code,
                br.resource_id,
                crc.cost_type_id,
                0 material_cost,
                0 material_overhead_cost,
                0 resource_cost,
                nvl(crc.resource_rate,0) outside_processing_cost,
                0 overhead_cost,
                nvl(crc.resource_rate,0) item_cost,
                nvl(crc.resource_rate,0) unburdened_cost
         from   cst_resource_costs crc,
                bom_resources br,
                mtl_system_items_vl msiv,
                mtl_parameters mp
         where  crc.cost_type_id      = mp.primary_cost_method
         and    crc.resource_id       = br.resource_id
         and    crc.organization_id   = mp.organization_id
         and    br.purchase_item_id   = msiv.inventory_item_id
         and    br.organization_id    = msiv.organization_id
         and    br.cost_element_id    = 4 -- OSP cost element
         and    mp.organization_id    = msiv.organization_id
         and    msiv.item_type        = 'OP'
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    6=6                -- p_org_code
         and    7=7                -- p_item_number
         union
         select cic.organization_id,
                cic.inventory_item_id purchase_item_id,
                null resource_code,
                -999 resource_id,
                cic.cost_type_id,
                cic.material_cost,
                cic.material_overhead_cost,
                cic.resource_cost,
                cic.outside_processing_cost,
                cic.overhead_cost,
                cic.item_cost,
                cic.unburdened_cost
         from   cst_item_costs cic,
                mtl_system_items_vl msiv,
                mtl_parameters mp
         where  cic.organization_id   = mp.organization_id
         and    cic.organization_id   = msiv.organization_id
         and    cic.inventory_item_id = msiv.inventory_item_id
         and    cic.cost_type_id      = mp.primary_cost_method
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    6=6                   -- p_org_code
         and    7=7                   -- p_item_number
        ) cic, -- item costs
        -- End revision for version 1.4
        -- Revision for version 1.5
        -- ===========================================================================
        -- Get the average PO receipt cost over a date range
        -- ===========================================================================
        (select mp.organization_id,
                mmt.inventory_item_id,
                sum(mmt.primary_quantity) receipt_qty,
                round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity),2)  receipt_amount,
                round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity) /
                          decode(sum(mmt.primary_quantity),
                               0,1,
                               sum(mmt.primary_quantity)),5) avg_receipt_cost
         from   mtl_material_transactions mmt,
                mtl_system_items_vl msiv,
                mtl_parameters mp
         where  mmt.inventory_item_id       = msiv.inventory_item_id
         and    mmt.organization_id         = msiv.organization_id
         and    11=11                       -- p_trx_date_from, p_trx_date_to
         and    mmt.transaction_source_type_id = 1 -- purchase orders
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    6=6                         -- p_org_code
         and    7=7                         -- p_item_number
         and    mmt.organization_id         = mp.organization_id
         and    nvl(mmt.transaction_cost,0) <> 0
         and    msiv.inventory_asset_flag   = 'Y'
         group by
                mp.organization_id,
                mmt.inventory_item_id
        ) receipts,
        -- ===========================================================================
        -- Get a set of currency rates to translate the PO Price into the G/L Currency
        -- ===========================================================================
        (select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date and gdct.user_conversion_type=:p_user_conversion_type and gdct.conversion_type=gdr.conversion_type) gdr_po,
        mtl_parameters mp, 
        hr_employees hr,
        fnd_common_lookups fcl,
        -- Revision for version 1.1
        fnd_common_lookups fcl2,
        po_lookup_codes pl1,  -- Destination_Type
        po_lookup_codes pl2,  -- Header
        po_lookup_codes pl3,  -- Line
        po_lookup_codes pl4,  -- Line location
        -- Revision for version 1.8
        -- hr_organization_information hoi,
        -- hr_all_organization_units haou, -- inv_organization_id
        -- hr_all_organization_units haou2, -- operating unit
        -- gl_ledgers gl,
        -- End revision for version 1.8
        gl_code_combinations gcc1,
        gl_code_combinations gcc2,
        gl_code_combinations gcc3
-- ========================================================
-- Organization, resource, item, costs and PO joins
-- ========================================================
where   msiv.inventory_item_id          = pl.item_id
and     msiv.organization_id            = pll.ship_to_organization_id
and     ucr.inventory_item_id           = msiv.inventory_item_id
and     ucr.organization_id             = msiv.organization_id
and     ucr.unit_of_measure             = pl.unit_meas_lookup_code
-- Revision for version 1.6
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- Revision for version 1.4
and     msiv.primary_uom_code           = muomv_msi.uom_code
and     ucr.uom_code                    = muomv_po.uom_code
and     mp.organization_id              = msiv.organization_id
-- Revision for version 1.5
and     cct_curr.cost_type_id           = mp.primary_cost_method
and     nvl(cic.resource_id,-999)       = nvl(pod.bom_resource_id,-999)
and     we.wip_entity_id (+)            = pod.wip_entity_id
-- Revision for version 1.8
-- and     ph.po_header_id                 = pl.po_header_id
and     pll.po_header_id                = pl.po_header_id
-- End revision for version 1.8
and     pl.po_line_id                   = pll.po_line_id
and     pll.po_release_id               = pr.po_release_id (+)
and     pod.line_location_id            = pll.line_location_id
and     pod.destination_type_code in ('SHOP FLOOR', 'INVENTORY')
and     pp.project_id (+)               = pod.project_id
-- Revision for version 1.8
-- and     pov.vendor_id                   = ph.vendor_id
-- and     ph.agent_id                     = hr.employee_id
-- and     ph.closed_date is null
and     pov.vendor_id                   = pll.vendor_id
and     hr.employee_id                  = pll.agent_id
and     pll.ph_closed_date is null
-- End revision for version 1.8
and     pl.closed_date is null
and     pll.closed_date is null
and     cic.organization_id             = msiv.organization_id (+)
and     cic.purchase_item_id            = msiv.inventory_item_id (+)
-- ========================================================
-- Lookup values to see more detail
-- ========================================================
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- Revision for version 1.1
and     fcl2.lookup_type (+)            = 'YES_NO'
and     fcl2.lookup_code (+)            = pll.inspection_required_flag
and     pl1.lookup_type                 = 'DESTINATION TYPE'
and     pl1.lookup_code                 = pod.destination_type_code
and     pl2.lookup_type (+)             = 'DOCUMENT STATE'
-- Revision for version 1.8
-- and     pl2.lookup_code (+)             = ph.closed_code
and     pl2.lookup_code (+)             = pll.ph_closed_code
-- End revision for version 1.8
and     pl3.lookup_type (+)             = 'DOCUMENT STATE'
and     pl3.lookup_code (+)             = pl.closed_code
and     pl4.lookup_type (+)             = 'DOCUMENT STATE'
and     pl4.lookup_code (+)             = pll.closed_code
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
and     gdr_po.from_currency(+)         = pll.currency_code
and     gdr_po.to_currency(+)           = pll.gl_currency_code
and     receipts.organization_id (+)    = cic.organization_id
and     receipts.inventory_item_id (+)  = cic.purchase_item_id
and     7=7                             -- p_item_number
and     8=8                             -- p_vendor_name
-- ========================================================
-- Accounting information
-- ========================================================
and     gcc1.code_combination_id (+)    = pod.code_combination_id
and     gcc2.code_combination_id (+)    = pod.variance_account_id
and     gcc3.code_combination_id (+)    = pod.accrual_account_id