/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Interface Error Summary
-- Description: Use this report to view your transactions that are pending or have errors in the Oracle interface tables.  Across both Financial and Supply Chain Applications.  This includes interfaces that would prevent closing the inventory accounting period, as suggested by the report titles, Resolution Required and Resolution Recommended.  Similar to the Inventory Account Periods Close form (checking open receipts, pending shipments, failed inventory, WIP, etc.).

Notes:
1)  Supply Chain queries check for the period close timezone of the legal entity, just like the Inventory Account Periods Close form and the Blitz INV Period Close Pending Transactions report.  Period count queries sourced from procedure CST_AccountingPeriod_PUB.Get_PendingTcount (CSTPAPEB.pls 120.18.12020000.8)
2)  The Financial interfaces all show a priority of "Resolution Recommended", as having entries in these interface tables do not prevent you from closing your books.  However, just like Supply Chain, best practice would be to process all unprocessed and/or erred out entries in these interfaces, before closing the accounting period.

Specific Functional Areas and Interface Reports include:

Accounts Payables
   AP_Invoices_Interface
   AP_Invoice_Lines_Interface

Accounts Receivables
   RA_Interface_Lines_All
   RA_Interface_Errors_All

Cash Management
   CE_Header_Interface_Errors

Cost Management
   Uncosted Material - MTL_Material_Transactions
   Uncosted - WSM_Split_Merge_Transactions
   Pending WIP Costing - WIP_Cost_Txn_Interface Report

General Ledger
   GL_Interface

Inventory
   Unprocessed Material - MTL_Material_Transactions_Temp
   Unprocessed Locked Material - MTL_Material_Transactions_Temp
   Pending Material - MTL_Transactions_Interface

Oracle Landed Cost Management
   Pending Landed Cost Management (INL) Interface - CST_Lc_Adj_Interface Interface

Project
   PA_Transaction_Interface_All

Purchasing
   PO_Requisitions_Interface_All

Purchasing (showing Receiving as the reported Functional Area)
   Pending Expense Receiving - RCV_Transactions_Interface
   Pending Inventory and OSP Receiving - RCV_Transactions_Interface
   Pending Intransit Receiving - RCV_Transactions_Interface
   Pending RMA Receiving - RCV_Transactions_Interface

Shipping
   Shipping - WSH_Delivery_Details

Warehouse Management System (WSM)
   Pending WSM Interface Transactions - WSM_Split_Merge_Txn_Interface
   Pending WSM Lot Interface Transactions - WSM_Lot_Split_Merges_Interface

Work in Process (Manufacturing)
   Pending Shop Floor Move Transactions - WIP_Move_Txn_Interface

Parameters
==========
Functional Area:  Cash Management, Cost Management, General Ledger, Inventory, Payables, Work in Process (Manufacturing), Oracle Landed Cost Management, Projects, Purchasing, Receivables, Shipping, Warehouse Management System (WSM) (optional).
Period Name:  Enter the desired period(s) to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

Note:  To avoid excessive run times., one of the above parameters must be entered in order to run this report.

-- |  Version Modified  Modified  by   Description
-- | ======== ========= =============== ================================================
-- |     1.0  1995      Initial Design  Originally based on sql from a project in 1995.
-- |     1.1  31-Jan-08 Douglas Volz    Added Operating Unit column to summary queries.
-- |     1.42 15-Jul-25 Douglas Volz    For Uncosted Transactions, checked for Process MFG
-- |                                    and added Ledger Security Controls for GL_Interface.
-- |     1.43 19-Jul-25 Douglas Volz    Changed LCM query to use the LCM short name 'INL' instead of 'CST'.
-- |     1.44 24-Aug-25 Douglas Volz    Changed Pending Material from Resolution Required to Recommended.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-interface-error-summary/
-- Library Link: https://www.enginatics.com/reports/cac-interface-error-summary/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Get the list of organizations, ledgers and operating units for Discrete and OPM organizations
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                to_number(hoi.org_information2) legal_entity_id,
                haou2.name operating_unit,
                haou2.organization_id operating_unit_id,
                mp.organization_code,
                mp.organization_id,
                mp.master_organization_id,
                mp.primary_cost_method,
                nvl(mp.process_enabled_flag, 'N') process_enabled_flag,
                nvl(mp.lcm_enabled_flag, 'N') lcm_enabled_flag,
                haou.date_to disable_date,
                gl.period_set_name,
                gl.accounted_period_type,
                gl.currency_code
         from   mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl
         -- Avoid disabled inventory organizations
         where  sysdate                        <  nvl(haou.date_to, sysdate +1)
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where  oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         and    1=1                             -- p_ledger
         and    2=2                             -- p_org_code
         and    3=3                             -- p_operating_unit
         -- Revision for Operating Unit and Ledger Controls and Parameters
         and    (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
         and    (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
         group by
                nvl(gl.short_name, gl.name),
                gl.ledger_id,
                to_number(hoi.org_information2),
                haou2.name, -- operating_unit
                haou2.organization_id, -- operating_unit_id
                mp.organization_code,
                mp.organization_id,
                mp.master_organization_id,
                mp.primary_cost_method,
                nvl(mp.process_enabled_flag, 'N'), -- process_enabled_flag
                nvl(mp.lcm_enabled_flag, 'N'), -- lcm_enabled_flag
                haou.date_to,
                gl.period_set_name,
                gl.accounted_period_type,
                gl.currency_code
        ), -- inv_organizations
gl_ou as
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                gl.period_set_name,
                gl.accounted_period_type,
                fspa.operating_unit,
                fspa.operating_unit_id,
                fspa.organization_code,
                fspa.organization_id,
                fspa.master_organization_id
         from   gl_ledgers gl,
                (select haou2.name operating_unit,
                        haou2.organization_id operating_unit_id,
                        fspa2.set_of_books_id,
                        mp.organization_id,
                        mp.organization_code,
                        mp.master_organization_id
                 from   hr_organization_information hoi,
                        hr_organization_information hoi2,
                        hr_all_organization_units_vl haou2,
                        financials_system_params_all fspa2,
                        mtl_parameters mp
                 where  haou2.organization_id           = fspa2.org_id 
                 and    haou2.organization_id           = hoi2.organization_id 
                 and    hoi.organization_id             = haou2.organization_id
                 and    hoi.org_information_context||'' = 'CLASS'
                 and    hoi.org_information1            = 'OPERATING_UNIT'
                 and    hoi.org_information2            = 'Y' 
                 and    hoi2.organization_id            = haou2.organization_id
                 and    hoi2.org_information_context    = 'Operating Unit Information'
                 and    haou2.organization_id           = hoi2.organization_id
                 and    fspa2.inventory_organization_id = mp.organization_id (+)
                 and    2=2                             -- p_organization_code
                 and    3=3                             -- p_operating_unit
                 -- Revision for Operating Unit Controls and Parameters
                 and    (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
                ) fspa
         where  gl.ledger_id                      = fspa.set_of_books_id
         -- Revision for Ledger Controls
         and    (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
         and    1=1                               -- p_ledger
        ) -- gl_ou

-----------------main query starts here--------------

-- +=============================================================================+
-- |               Accounts Payables Interface Error Reports                     |
-- +=============================================================================+

-- =======================================================
--  Payables Summary Interface Error Report
-- =======================================================
-- Get the invoices with an ORG_ID (operating unit)
select  fav.application_name Functional_Area,
        'AP_Invoices_Interface' Report_Interface,
        'Number of A/P Invoices' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Supplier
        pv.vendor_name Column_Info,
        aii.status status_code,
        null Reject_Code_or_Error_Message,
        'Rows in the AP_INVOICES_INTERFACE table' Interface_Description
from    ap_invoices_interface aii,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        po_vendors pv,
        fnd_lookups fl, -- Supplier
        mfg_lookups ml -- Priority
-- Consolidated billing does not have an aii.org_id
where   gl_ou.operating_unit_id          = nvl(aii.org_id, regexp_replace(aii.attribute_category, '[^0-9]+', ''))
-- Invoice_date and gl_date is not always populated
and     trunc(coalesce(aii.gl_date,aii.invoice_date,sysdate)) between gp.start_date and gp.end_date
and     fav.application_short_name       = 'SQLAP'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     gp.adjustment_period_flag        = 'N'
and     aii.vendor_id                    = pv.vendor_id (+)
and     fl.lookup_type                   = 'BUSINESS_ENTITY'
and     fl.lookup_code                   = 'AP_SUPPLIER'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
-- Only want unprocessed and erred out entries
and     nvl(aii.status, 'NULL')         <> ('PROCESSED')
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'AP_Invoices_Interface', -- Report_Type
        'Number of A/P Invoices', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        fl.meaning, -- Column_Type, Supplier
        pv.vendor_name, -- Column_Info
        aii.status,
        null, -- Reject_Code_or_Error_Message
        'Rows in the AP_INVOICES_INTERFACE table' -- Interface_Description
union all
-- =======================================================
--  Payables Summary Interface Rejections Report
-- =======================================================
select  fav.application_name Functional_Area,
        'AP_Interface_Rejections' Interface_Report,
        'Number of A/P Interface Rejections' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Supplier
        pv.vendor_name Column_Info,
        aii.status,
        air.reject_lookup_code Reject_Code_or_Error_Message,
        'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Issue' Interface_Description
from    ap_interface_rejections air,
        ap_invoices_interface aii,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_periods gp,
        gl_ou,
        po_vendors pv,
        fnd_lookups fl, -- Supplier
        mfg_lookups ml -- Priority
where   air.parent_table                 = 'AP_INVOICES_INTERFACE'
and     air.parent_id                    = aii.invoice_id
-- Consolidated billing does not have an aii.org_id
and     gl_ou.operating_unit_id          = nvl(aii.org_id, regexp_replace(aii.attribute_category, '[^0-9]+', ''))
-- Check for the gl date then the invoice date, else use sysdate
-- Invoice_date and gl_date is not always populated
and     trunc(coalesce(aii.gl_date,aii.invoice_date,sysdate)) between gp.start_date and gp.end_date
and     fav.application_short_name       = 'SQLAP'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     gp.adjustment_period_flag        = 'N'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     aii.vendor_id (+)                = pv.vendor_id
and     fl.lookup_type                   = 'BUSINESS_ENTITY'
and     fl.lookup_code                   = 'AP_SUPPLIER'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
-- Only want unprocessed and erred out entries
and     nvl(aii.status, 'NULL')         <> ('PROCESSED')
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'AP_Interface_Rejections', -- Interface_Report
        'Number of A/P Interface Rejections', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        fl.meaning, -- Column_Type, Supplier
        pv.vendor_name, -- Column_Info
        aii.status,
        air.reject_lookup_code, -- Reject_Code_or_Error_Message
        'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Issue' -- Interface_Description
union all
-- =======================================================
--  Payables Summary Interface Rejections Report
-- =======================================================
select  fav.application_name Functional_Area,
        'AP_Interface_Rejections' Interface_Report,
        'Number of A/P Interface Rejections' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Supplier
        pv.vendor_name Column_Info,
        aii.status,
        air.reject_lookup_code Reject_Code_or_Error_Message,
        'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Issue' Interface_Description
from    ap_interface_rejections air,
        ap_invoices_interface aii,
        ap_invoice_lines_interface aili,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_periods gp,
        gl_ou,
        po_vendors pv,
        fnd_lookups fl, -- Supplier
        mfg_lookups ml -- Priority
where   air.parent_table                 = 'AP_INVOICE_LINES_INTERFACE'
and     air.parent_id                    = aili.invoice_line_id
and     aii.invoice_id                   = aili.invoice_id
-- Consolidated billing does not have an aii.org_id
and     gl_ou.operating_unit_id          = nvl(aii.org_id, regexp_replace(aii.attribute_category, '[^0-9]+', ''))
and     aii.invoice_id                   = aili.invoice_id (+)
-- Check for the gl date then the invoice date, else use sysdate
-- Invoice date and gl_date is not always populated
and     trunc(coalesce(aii.gl_date,aii.invoice_date,sysdate)) between gp.start_date and gp.end_date
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     gp.adjustment_period_flag        = 'N'
and     aii.vendor_id (+)                = pv.vendor_id
and     fav.application_short_name       = 'SQLAP'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'BUSINESS_ENTITY'
and     fl.lookup_code                   = 'AP_SUPPLIER'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
-- Only want unprocessed and erred out entries
and     nvl(aii.status, 'NULL')         <> ('PROCESSED')
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'AP_Interface_Rejections', -- Interface_Report
        'Number of A/P Interface Rejections', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        fl.meaning, -- Column_Type, Supplier
        pv.vendor_name, -- Column_Info
        aii.status,
        air.reject_lookup_code, -- Reject_Code_or_Error_Message
        'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Issue' -- Interface_Description

-- +=============================================================================+
-- |            Accounts Receivables Interface Error Reports                     |
-- +=============================================================================+

union all
-- =======================================================
--  Receivables Summary Interface Errors Report
-- =======================================================
select  fav.application_name Functional_Area,
        'RA_Interface_Lines_All' Interface_Report,
        'Number of RA Invoice lines' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        fl1.meaning Column_Type, -- Ship Date
        to_char(trunc(ril.ship_date_actual), 'YYYY-MM-DD') Column_Info,
        fl2.meaning Status,
        rie.message_text Reject_Code_or_Error_Message,
        'Rows in the RA_INTERFACE_LINES_ALL table' Interface_Description
from    ra_interface_lines_all ril,
        ra_interface_errors_all rie,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        fnd_lookups fl1, -- Ship Date
        fnd_lookups fl2, -- Status
        mfg_lookups ml -- Priority
where   ril.org_id                       = gl_ou.operating_unit_id
-- Check for the rule date, then the gl date, then the transaction date
-- Invoice_date and gl_date not always populated
and     trunc(coalesce(ril.rule_start_date, ril.gl_date, ril.trx_date, sysdate)) between gp.start_date and gp.end_date
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     gp.adjustment_period_flag        = 'N'
and     ril.interface_line_id            = rie.interface_line_id (+)
and     fl1.lookup_type                  = 'MSC_PQ_CP_EXCP'
and     fl1.lookup_code                  = 'MSCX_CUST_SHIP_DATE'
and     fl2.lookup_type                  = 'DEBRIEF_CONCURRENT_STATUS'
and     fl2.lookup_code                  = decode(rie.message_text, null, 'UNPROCESSED', 'COMPLETED W/ERRORS') -- Unprocessed
and     fav.application_short_name       = 'AR'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'RA_Interface_Lines_All', -- Interface_Report
        'Number of RA Invoice lines', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        fl1.meaning, -- Column_Type, Ship Date
        to_char(trunc(ril.ship_date_actual), 'YYYY-MM-DD'), -- Column_Info
        fl2.meaning, -- Status
        rie.message_text, --  Reject_Code_or_Error_Message
        'Records in the RA_INTERFACE_LINES_ALL table' -- Interface_Description
union all
-- =======================================================
--  Receivables Summary Interface Errors Only Report
-- =======================================================
select  fav.application_name Functional_Area,
        'RA_Interface_Errors_All' Interface_Report,
        'Number of RA Invoice Errors' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        fl1.meaning Column_Type, -- Customer Name
        hz.party_name Column_Info,
        fl2.meaning Status,
        rie.message_text Reject_Code_or_Error_Message,
        'Errors in the RA_INTERFACE_ERRORS_ALL table' Interface_Description
from    ra_interface_lines_all ril,
        ra_interface_errors_all rie,
        hz_cust_accounts_all hca,
        hz_parties hz,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        fnd_lookups fl1, -- Customer Name
        fnd_lookups fl2, -- Status
        mfg_lookups ml -- Priority
where   ril.org_id                       = gl_ou.operating_unit_id
-- Check for the rule date, then the gl date, then the transaction date
-- Invoice_date and gl_date not always populated
and     trunc(coalesce(ril.rule_start_date, ril.gl_date, ril.trx_date, sysdate)) between gp.start_date and gp.end_date
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     gp.adjustment_period_flag        = 'N'
and     ril.interface_line_id            = rie.interface_line_id (+)
and     hca.cust_account_id              = ril.orig_system_bill_customer_id
and     hca.party_id                     = hz.party_id
and     hca.org_id                       = ril.org_id
and     fav.application_short_name       = 'AR'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl1.lookup_type                  = 'MSC_PQ_CP_EXCP'
and     fl1.lookup_code                  = 'CUSTOMER_NAME'
and     fl2.lookup_type                  = 'DEBRIEF_CONCURRENT_STATUS'
and     fl2.lookup_code                  = decode(rie.message_text, null, 'UNPROCESSED', 'COMPLETED W/ERRORS') -- Unprocessed
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'RA_Interface_Errors_All', -- Interface_Report
        'Number of RA Invoice Errors', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        fl1.meaning, --Column_Type, Customer Name
        hz.party_name, -- Column_Info
        fl2.meaning, -- Status
        rie.message_text, -- Reject_Code_or_Error_Message
        'Errors in the RA_INTERFACE_ERRORS_ALL table' -- Interface_Description

-- +=============================================================================+
-- |                 Cash Management Interface Error Reports                     |
-- +=============================================================================+

union all
-- =======================================================
--  Cash Management Summary Interface Error Report
-- =======================================================
select  fav.application_name Functional_Area,
        'CE_Header_Interface_Errors' Interface_Report,
        'Number of Cash Mgmt Interface Records by Bank' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        extract(year from chie.creation_date) Period_Year,
        null Period_Number, 
        to_char(chie.creation_date,'MON-YY'), -- Period_Name
        null Ledger,
        null Operating_Unit,
        null Operating_Unit_Id,
        null Org_Code,
        null Inv_Organization_Id,
        fl1.meaning Column_Type, -- Bank Name
        (select max(hp.party_name)
         from   ce_bank_accounts cba,
                hz_parties hp
         where  hp.party_id          = cba.bank_id
         and    cba.bank_account_num = chie.bank_account_num) Column_Info,
        fl2.meaning Status,
        chie.message_name Reject_Code_or_Error_Message,
        'Rows in the CE_HEADER_INTERFACE_ERRORS table' Interface_Description
from    ce_header_interface_errors chie,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl1, -- Bank Name
        fnd_lookups fl2, -- Status
        mfg_lookups ml -- Priority
where   fav.application_short_name       = 'CE'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl1.lookup_type                  = 'JA_CN_XML_TAGS'
and     fl1.lookup_code                  = 'BANK_NAME'
and     fl2.lookup_type                  = 'LOG_TYPE_CODE'
and     fl2.lookup_code                  = 'E'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     5=5                              -- p_functional_area
and     8=8                              -- p_period_year_for_cash_management
group by
        fav.application_name, -- Functional_Area
        'CE_Header_Interface_Errors', -- Interface_Report
        'Number of Cash Mgmt Interface Records by Bank', -- Report_Title
        ml.meaning, -- Priority
        extract(year from chie.creation_date), -- Period_Year
        null, -- Period_Number 
        to_char(chie.creation_date,'MON-YY'), -- Period_Name
        null, -- Ledger
        null, -- Operating_Unit
        null, -- Operating_Unit_Id
        null, -- Org_Code
        null, -- Inv_Organization_Id
        fl1.meaning, -- Column_Type, Bank Name
        chie.bank_account_num, -- Column_Info
        fl2.meaning, -- Status
        chie.message_name, -- Reject_Code_or_Error_Message
        'Rows in the CE_HEADER_INTERFACE_ERRORS table' -- Interface_Description

-- +=============================================================================+
-- |                       General Ledger Interface Reports                      |
-- +=============================================================================+

union all
-- =======================================================
--  General Ledger Summary Interface Report
-- =======================================================
-- With Ledger Ids
select  fav.application_name Functional_Area,
        'GL_Interface' Interface_Report,
        'Number of G/L Lines by Ledger' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        nvl(gl.short_name, gl.name) Ledger,
        null Operating_Unit,
        null Operating_Unit_Id,
        null Org_Code,
        null Inv_Organization_Id,
        fl.meaning Column_Type, -- Journal Source
        gi.user_je_source_name Column_Info,
        gi.status Status,
        null Reject_Code_or_Error_Message,
        'Rows in the GL_INTERFACE table' Interface_Description
from    gl_interface gi,
        gl_periods gp,
        gl_ledgers gl,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl, -- Journal Source
        mfg_lookups ml -- Priority
where   gl.ledger_id                     = case
                                              -- Payroll Journals
                                              when gi.ledger_id = -1 then gi.set_of_books_id
                                              -- Non-Payroll Journals
                                              when gi.ledger_id > -1 then gi.ledger_id
                                              else gi.ledger_id
                                           end
and     nvl(gi.accounting_date, gi.transaction_date) between gp.start_date and gp.end_date
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl.period_set_name
and     gp.period_type                   = gl.accounted_period_type
and     fav.application_short_name       = 'SQLGL'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'JGSLAJNLTP_RPT_SORT_PARAMS'
and     fl.lookup_code                   = 'JE_SOURCE_NAME'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
-- Revision for Ledger Security Controls
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     1=1                              -- p_ledger
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'GL_Interface', -- Interface_Report
        'Number of G/L Lines by Ledger', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num,
        gp.period_name,
        nvl(gl.short_name, gl.name),
        null, -- Operating_Unit
        null, -- Operating_Unit_Id
        null, -- Org_Code
        null, -- Inv_Organization_Id
        fl.meaning, -- Column_Type, Journal Source
        gi.user_je_source_name, -- Column_Info
        gi.status, -- Status
        null, -- Reject_Code_or_Error_Message
        'Rows in the GL_INTERFACE table' -- Interface_Description
union all
-- =======================================================
--  General Ledger Summary Interface Report
-- =======================================================
-- Missing Ledger Ids
select  fav.application_name Functional_Area,
        'GL_Interface' Interface_Report,
        'Number of G/L Lines With No Ledger Id' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        extract(year from nvl(gi.accounting_date, gi.transaction_date)) Period_Year,
        null Period_Number, 
        to_char(nvl(gi.accounting_date, gi.transaction_date),'MON-YY') Period_Name,
        null Ledger,
        null Operating_Unit,
        null Operating_Unit_Id,
        null Org_Code,
        null Inv_Organization_Id,
        fl.meaning Column_Type, -- Journal Source
        gi.user_je_source_name Column_Info,
        gi.status Status,
        'Missing Ledger Id' Reject_Code_or_Error_Message,
        'Rows in the GL_INTERFACE table' Interface_Description
from    gl_interface gi,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl, -- Journal Source
        mfg_lookups ml -- Priority
where   (gi.ledger_id = -1 and gi.set_of_books_id is null)
and     fav.application_short_name       = 'SQLGL'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'JGSLAJNLTP_RPT_SORT_PARAMS'
and     fl.lookup_code                   = 'JE_SOURCE_NAME'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     5=5                              -- p_functional_area
and     7=7                              -- p_period_year_for_gl
group by
        fav.application_name, -- Functional_Area
        'GL_Interface', -- Interface_Report
        'Number of G/L Lines With No Ledger Id', -- Report_Title
        ml.meaning, -- Priority
        extract(year from nvl(gi.accounting_date, gi.transaction_date)), -- Period_Year
        null, -- Period_Number
        to_char(nvl(gi.accounting_date, gi.transaction_date),'MON-YY'), -- Period_Name
        null, -- Ledger
        null, -- Operating_Unit
        null, -- Operating_Unit_Id
        null, -- Org_Code
        null, -- Inv_Organization_Id
        fl.meaning, -- Column_Type, Journal Source
        gi.user_je_source_name, -- Column_Info
        gi.status, -- Status
        'Missing Ledger Id', -- Reject_Code_or_Error_Message
        'Rows in the GL_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |                         Inventory Interface Reports                         |
-- +=============================================================================+

union all
-- =======================================================
--  Unprocessed Material Errors - MTL_Material_Transactions_Temp
-- =======================================================
select  fav.application_name Functional_Area,
        'MTL_Material_Transactions_Temp' Interface_Report,
        'Unprocessed Material Errors' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        mtt.transaction_type_name Column_Info,
        mmtt.process_flag Status,
        mmtt.error_code Reject_Code_or_Error_Message,
        'Rows have Errored in the Material Transactions Temp table' Interface_Description
from    mtl_material_transactions_temp mmtt,
        mtl_transaction_types mtt,
        org_acct_periods oap,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2  -- Transaction Type
where   mmtt.process_flag                = 'E'
and     mmtt.organization_id             = inv_orgs.organization_id
and     oap.acct_period_id               = mmtt.acct_period_id
and     trunc(mmtt.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,inv_orgs.legal_entity_id)
and     oap.organization_id              = inv_orgs.organization_id
and     oap.period_set_name              = inv_orgs.period_set_name
and     mtt.transaction_type_id          = mmtt.transaction_type_id (+)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = oap.period_set_name
and     gp.period_name                   = oap.period_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'MTL_Material_Transactions_Temp', -- Interface_Report
        'Unprocessed Material Errors', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        mtt.transaction_type_name, -- Column_Info,
        mmtt.process_flag, -- Status
        mmtt.error_code, -- Reject_Code_or_Error_Message
        'Rows have Errored in the Material Transactions Temp table' -- Interface_Description
union all
-- =======================================================
--  Unprocessed Locked Material - MTL_Material_Transactions_Temp
-- =======================================================
select  fav.application_name Functional_Area,
        'MTL_Material_Transactions_Temp' Interface_Report,
        'Unprocessed Material Transactions With Locked Records' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        mtt.transaction_type_name Column_Info,
        mmtt.process_flag Status,
        mmtt.error_code Reject_Code_or_Error_Message,
        'Rows have their records locked in the MTL_MATERIAL_TRANSACTIONS_TEMP table' Interface_Description
from    mtl_material_transactions_temp mmtt,
        mtl_transaction_types mtt,
        org_acct_periods oap,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2  -- Transaction Type
where   (nvl(mmtt.lock_flag,'N') = 'Y' or nvl(mmtt.lock_flag,'N') = '1')
and     mmtt.organization_id             = inv_orgs.organization_id
and     oap.acct_period_id               = mmtt.acct_period_id
and     trunc(mmtt.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,inv_orgs.legal_entity_id)
and     oap.organization_id              = inv_orgs.organization_id
and     oap.period_set_name              = inv_orgs.period_set_name
and     mtt.transaction_type_id          = mmtt.transaction_type_id (+)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = oap.period_set_name
and     gp.period_name                   = oap.period_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'MTL_Material_Transactions_Temp', -- Interface_Report
        'Unprocessed Material Transactions With Locked Records', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        mtt.transaction_type_name, -- Column_Info,
        mmtt.process_flag, -- Status
        mmtt.error_code, -- Reject_Code_or_Error_Message
        'Rows have their records locked in the MTL_MATERIAL_TRANSACTIONS_TEMP table' -- Interface_Description
union all
-- =======================================================
--  Pending Material - MTL_Transactions_Interface
-- =======================================================
select  fav.application_name Functional_Area,
        'MTL_Transactions_Interface' Interface_Report,
        'Pending Material Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        mtt.transaction_type_name Column_Info,
        decode(mti.process_flag,
                1, '1 - Ready',
                2, '2 - Not Ready',
                3, '3 - Error'
              ) Status,
        mti.error_code Reject_Code_or_Error_Message,
        'Rows in the Material Transaction Interface' Interface_Description
from    mtl_transactions_interface mti,
        mtl_transaction_types mtt,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2  -- Transaction Type
where   mti.transaction_type_id          = mtt.transaction_type_id (+)
and     mti.organization_id              = inv_orgs.organization_id
-- Check for the transaction date as the Period Name is not always populated
and     trunc(nvl(mti.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
-- Revision for version 1.44
and     ml1.lookup_code                  = 3 -- Resolution Recommended
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'MTL_Transactions_Interface Errors', -- Interface_Report
        'Pending Material Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        mtt.transaction_type_name, -- Column_Info,
        decode(mti.process_flag,
                1, '1 - Ready',
                2, '2 - Not Ready',
                3, '3 - Error'
              ), -- Status
        mti.error_code, -- Reject_Code_or_Error_Message
        'Rows in the Material Transaction Interface' -- Interface_Description
union all
-- =======================================================
--  Pending Locked Material - MTL_Transactions_Interface Errors
-- =======================================================
select  fav.application_name Functional_Area,
        'MTL_Transactions_Interface Errors' Interface_Report,
        'Pending Material Transactions With Locked Records' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        mtt.transaction_type_name Column_Info,
        -- mti.transaction_type_id Transaction_Type_Id,
        to_char(mti.process_flag) Status,
        -- mti.transaction_date Transaction_Date,
        mti.error_code Reject_Code_or_Error_Message,
        -- mti.error_explanation Error_Explanation,
        'Rows have their records locked' Interface_Description
from    mtl_transactions_interface mti,
        mtl_transaction_types mtt,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2  -- Transaction Type
where   mti.lock_flag                    = 1
and     mti.organization_id              = inv_orgs.organization_id
and     mti.transaction_type_id          = mtt.transaction_type_id
-- Check for the transaction date as the Period Name is not always populated
and     trunc(nvl(mti.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'MTL_Transactions_Interface Errors', -- Interface_Report
        'Pending Material Transactions With Locked Records', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        mtt.transaction_type_name, -- Column_Info
        -- mti.transaction_type_id, -- Transaction_Type_Id
        to_char(mti.process_flag), -- Status
        -- mti.transaction_date, -- Transaction_Date
        mti.error_code, -- Reject_Code_or_Error_Message
        -- mti.error_explanation, -- Error_Explanation
        'Rows have their records locked' -- Interface_Description

-- +=============================================================================+
-- |                         Inventory/WSM Cost Reports                          |
-- +=============================================================================+

union all
-- =======================================================
--  Uncosted Material - MTL_Material_Transactions
-- =======================================================
select  fav.application_name Functional_Area,
        'MTL_Material_Transactions' Interface_Report,
        'Uncosted Material Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        mtt.transaction_type_name Column_Info,
        mmt.costed_flag Status,
        mmt.error_code Reject_Code_or_Error_Message,
        'Rows have not been costed, check the Cost Processor'  Interface_Description
from    mtl_material_transactions mmt,
        mtl_transaction_types mtt,
        org_acct_periods oap,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2  -- Transaction Type
where   mmt.costed_flag                  = 'N'
and     mmt.transaction_type_id          = mtt.transaction_type_id
and     oap.acct_period_id               = mmt.acct_period_id
and     trunc(mmt.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,inv_orgs.legal_entity_id)
and     oap.organization_id              = inv_orgs.organization_id
and     oap.period_set_name              = inv_orgs.period_set_name
and     inv_orgs.organization_id         = nvl(mmt.transfer_organization_id, mmt.organization_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = oap.period_set_name
and     gp.period_name                   = oap.period_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'CST'
-- Only report installed applications, but CST is not installed, switch to INV
and     fpi.application_id               = 401 -- INV
and     fpi.status                      <> 'N' -- Inactive
-- Not applicable for Process Manufacturing
and     inv_orgs.process_enabled_flag    = 'N'
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'MTL_Material_Transactions', -- Interface_Report
        'Uncosted Material Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type -- Transaction Type
        mtt.transaction_type_name, -- Column_Info
        mmt.costed_flag, -- Status
        mmt.error_code, -- Reject_Code_or_Error_Message
        'Rows have not been costed, check the Cost Processor' -- Interface_Description
union all
-- =======================================================
--  Uncosted WSM (WIP Split Merge Transactions)
-- =======================================================
select  fav.application_name Functional_Area,
        'WSM_Split_Merge_Transactions' Interface_Report,
        'Uncosted WIP Split Merge Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        ml3.meaning Column_Info,
        ml4.meaning Status,
        wsmt.error_message Reject_Code_or_Error_Message,
        'Rows have not been costed, check the Cost Processor'  Interface_Description
from    wsm_split_merge_transactions wsmt,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3, -- WSM WIP Lot Transaction Type
        mfg_lookups ml4  -- Status
where   wsmt.costed                     <> 4
and     wsmt.organization_id             = inv_orgs.organization_id
-- Check for the transaction date
and     trunc(nvl(wsmt.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'WSM'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
-- Not applicable for Process Manufacturing
and     inv_orgs.process_enabled_flag    = 'N'
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'WSM_WIP_LOT_TXN_TYPE'
and     ml3.lookup_code                  = to_char(wsmt.transaction_type_id)
and     ml4.lookup_type                  = 'WIP_PROCESS_STATUS'
and     ml4.lookup_code                  = wsmt.status
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSM_Split_Merge_Transactions', -- Interface_Report
        'Uncosted WIP Split Merge Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        ml3.meaning, -- Column_Info
        ml4.meaning, -- Status
        wsmt.error_message, -- Reject_Code_or_Error_Message,
        'Rows have not been costed, check the Cost Processor' -- Interface_Description

-- +=============================================================================+
-- |                   Landed Cost Mgmt (INL) Cost Reports                       |
-- +=============================================================================+

union all
-- =======================================================
--  Pending Landed Cost Management (INL) Interface
-- =======================================================
select  fav.application_name Functional_Area,
        'CST_Lc_Adj_Interface' Interface_Report,
        'Pending LCM Interface' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Receiving Transaction Type
        flvv.meaning Column_Info,
        ml3.meaning Status, -- Process Status
        claie.error_message Reject_Code_or_Error_Message,
        'Rows in the CST_LC_ADJ_INTERFACE table' -- Interface_Description
from    cst_lc_adj_interface clai,
        cst_lc_adj_interface_errors claie,
        rcv_transactions rt,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookup_values_vl flvv, -- Receiving Transaction Type
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3  -- Process Status
where   clai.organization_id             = inv_orgs.organization_id
and     inv_orgs.lcm_enabled_flag        = 'Y'
and     clai.transaction_id (+)          = claie.transaction_id
and     rt.transaction_id                = clai.rcv_transaction_id
-- Check for the transaction date
and     trunc(clai.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
-- Revision for version 1.43
-- and     fav.application_short_name       = 'CST'
and     fav.application_short_name       = 'INL'
and     fpi.application_id               = fav.application_id
-- End revision for version 1.43
and     fpi.status                      <> 'N' -- Inactive
and     flvv.lookup_type                 = 'RCV TRANSACTION TYPE'
and     flvv.lookup_code                 = rt.transaction_type
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'LANDED_COST_ADJ_PROCESS_STATUS'
and     ml3.lookup_code                  = clai.process_status
and     4=4                              -- p_period_name, period_year
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'CST_Lc_Adj_Interface', -- Report_Type
        'Pending LCM Interface', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Receiving Transaction Type
        flvv.meaning, -- Column_Info
        ml3.meaning, -- Status, Process Status
        claie.error_message, -- Reject_Code_or_Error_Message
        'Rows in the CST_LC_ADJ_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |                        Manufacturing (WIP) Reports                          |
-- +=============================================================================+

union all
-- =======================================================
--  Pending Shop Floor Move Transactions
-- =======================================================
select  fav.application_name Functional_Area,
        'WIP_Move_Txn_Interface' Interface_Report,
        'Pending Shop Floor Move Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        ml3.meaning Column_Info,
        ml4.meaning Status,
        wtie.error_message Reject_Code_or_Error_Message,
        'Rows in the WIP_MOVE_TXN_INTERFACE table' -- Interface_Description
from    wip_move_txn_interface wmti,
        wip_txn_interface_errors wtie,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3, -- WIP Move Transaction Type
        mfg_lookups ml4  -- Status
where   wmti.organization_id             = inv_orgs.organization_id
and     wmti.transaction_id              = wtie.transaction_id (+)
-- Check for the transaction date
and     trunc(nvl(wmti.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'WIP'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 3 -- Resolution Recommended
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'WIP_MOVE_TRANSACTION_TYPE'
and     ml3.lookup_code                  = to_char(wmti.transaction_type)
and     ml4.lookup_type                  = 'WIP_PROCESS_STATUS'
and     ml4.lookup_code                  = to_char(wmti.process_status)
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WIP_Move_Txn_Interface', -- Report_Typ
        'Pending Shop Floor Move Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        ml3.meaning, -- Column_Info
        ml4.meaning, -- Status
        wtie.error_message, -- Reject_Code_or_Error_Message,
        'Rows in the WIP_MOVE_TXN_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |          Manufacturing (OSFM) Pending WSM Split Merge Transactions          |
-- +=============================================================================+

union all
-- =======================================================
-- Pending WSM Interface (WIP Split Merge) Transaction Reports
-- =======================================================
select  fav.application_name Functional_Area,
        'WSM_Split_Merge_Txn_Interface' Interface_Report,
        'Pending WIP WSM Split Merge Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        ml3.meaning Column_Info,
        ml4.meaning Status,
        wsmti.error_message Reject_Code_or_Error_Message,
        'Rows in the WSM_SPLIT_MERGE_TXN_INTERFACE table' Interface_Description
from    wsm_split_merge_txn_interface wsmti,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3, -- WSM WIP Lot Transaction Type
        mfg_lookups ml4  -- Status
where   wsmti.process_status            <> 4
and     wsmti.organization_id            = inv_orgs.organization_id
-- Check for the transaction date as the Period Name is not always populated
and     trunc(nvl(wsmti.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'WSM'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'WSM_WIP_LOT_TXN_TYPE'
and     ml3.lookup_code                  = to_char(wsmti.transaction_type_id)
and     ml4.lookup_type                  = 'WIP_PROCESS_STATUS'
and     ml4.lookup_code                  = wsmti.process_status
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSM_Split_Merge_Txn_Interface', -- Interface_Report
        'Pending WIP WSM Split Merge Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        ml3.meaning, -- Column_Info
        ml4.meaning, -- Process Status
        wsmti.error_message, -- Reject_Code_or_Error_Message
        'Rows in the WSM_SPLIT_MERGE_TXN_INTERFACE table' -- Interface_Description
union all
select  fav.application_name Functional_Area,
        'WSM_Lot_Split_Merges_Interface' Interface_Report,
        'Pending WIP WSM Lot Split Merge Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        ml3.meaning Column_Info,
        ml4.meaning Status,
        wlsmi.error_message Reject_Code_or_Error_Message,
        'Rows in the WSM_LOT_SPLIT_MERGES_INTERFACE table'  Interface_Description
from    wsm_lot_split_merges_interface wlsmi,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3, -- WSM WIP Lot Transaction Type
        mfg_lookups ml4  -- Status
where   wlsmi.process_status            <> 4
and     wlsmi.organization_id            = inv_orgs.organization_id
-- Check for the transaction date as the Period Name is not always populated
and     trunc(nvl(wlsmi.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'WSM'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'WSM_WIP_LOT_TXN_TYPE'
and     ml3.lookup_code                  = to_char(wlsmi.transaction_type_id)
and     ml4.lookup_type                  = 'WIP_PROCESS_STATUS'
and     ml4.lookup_code                  = wlsmi.process_status
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSM_Lot_Split_Merges_Interface', -- Interface_Report
        'Pending WIP WSM Lot Split Merge Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        ml3.meaning, -- Column_Info
        ml4.meaning, -- Process Status
        wlsmi.error_message, -- Reject_Code_or_Error_Message
        'Rows in the WSM_LOT_SPLIT_MERGES_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |                      Manufacturing Cost Reports                             |
-- +=============================================================================+

union all
-- =======================================================
-- Pending WIP Costing - WIP_COST_TXN_INTERFACE Report
-- =======================================================
select  fav.application_name Functional_Area,
        'WIP_Cost_Txn_Interface' Interface_Report,
        'Pending WIP Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        ml3.meaning Column_Info,
        ml4.meaning Status,
        fl.meaning Reject_Code_or_Error_Message,
        'Rows in the WIP_COST_TXN_INTERFACE table' Interface_Description
from    wip_cost_txn_interface wcti,
        org_acct_periods oap,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        mfg_lookups ml3, -- WIP Transaction Type
        mfg_lookups ml4, -- Process Status
        fnd_lookups fl   -- Reject_Code_or_Error_Message, Not Available
where   wcti.organization_id             = inv_orgs.organization_id
and     oap.acct_period_id               = wcti.acct_period_id
and     trunc(nvl(wcti.transaction_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(oap.period_start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(oap.schedule_close_date,inv_orgs.legal_entity_id)
and     oap.organization_id              = inv_orgs.organization_id
and     oap.period_set_name              = inv_orgs.period_set_name
and     gp.adjustment_period_flag        = 'N'
and     gp.period_name                   = oap.period_name
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = oap.period_set_name
and     gp.period_name                   = oap.period_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'CST'
-- Only report installed applications, but CST is not installed, switch to WIP
and     fpi.application_id               = 706 -- WIP
and     fpi.status                      <> 'N' -- Inactive
-- Not applicable for Process Manufacturing
and     inv_orgs.process_enabled_flag    = 'N'
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 2 -- Resolution Required
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     ml3.lookup_type                  = 'WIP_TRANSACTION_TYPE'
and     ml3.lookup_code                  = to_char(wcti.transaction_type)
and     ml4.lookup_code                  = wcti.process_status
and     ml4.lookup_type                  = 'WIP_PROCESS_STATUS'
and     fl.lookup_code                   = 'NOT AVAIL'
and     fl.lookup_type                   = 'JTF_OUTCOME_CODE'
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WIP_Cost_Txn_Interface', -- Interface_Report
        'Pending WIP Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        ml3.meaning, -- Column_Info
        ml4.meaning, -- Process Status
        fl.meaning,  -- Reject_Code_or_Error_Message
        'Rows in the WIP_COST_TXN_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |                             Project Reports                                 |
-- +=============================================================================+

union all
-- =======================================================
-- Pending Project Interface Transactions
-- =======================================================
select  fav.application_name Functional_Area,
        'PA_Transaction_Interface_All' Interface_Report,
        'Pending Project Transactions' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        flv.meaning Column_Type, -- Transaction Source
        pti.transaction_source Column_Info,
        pti.transaction_status_code Status_Code,
        pl.meaning Reject_Code_or_Error_Message,
        'Rows in the PA_Transaction_Interface_All table' Interface_Description
from    pa_transaction_interface_all pti,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        fnd_lookup_values_vl flv, -- Transaction Source
        mfg_lookups ml, -- Priority
        pa_lookups pl -- PA Reject Error Messages
where   gl_ou.operating_unit_id          = pti.org_id
-- pti.expenditure_item_date is a required column
and     trunc(pti.expenditure_item_date) between gp.start_date and gp.end_date
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     fav.application_short_name       = 'PA'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     flv.lookup_type                  = 'FC_VIEW_BY'
and     flv.lookup_code                  = 'TRX'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     pl.lookup_type (+)               = 'TRANSACTION REJECTION REASON'
and     pl.lookup_code (+)               = pti.transaction_rejection_code
-- Only want unprocessed and erred out entries
and     pti.transaction_status_code     <> 'P' -- 'P' for processed
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'PA_Transaction_Interface_All', -- Interface_Report
        'Pending Project Transactions', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        flv.meaning, -- Column_Type, Transaction Source
        pti.transaction_source, -- Column_Info
        pti.transaction_status_code, -- Status_Code
        pl.meaning, -- Reject_Code_or_Error_Message
        'Rows in the PA_Transaction_Interface_All table' -- Interface_Description

-- +=============================================================================+
-- |                  Purchasing and Requisition Reports                         |
-- +=============================================================================+

union all
-- =======================================================
-- Pending PO Requisitions
-- =======================================================
select  fav.application_name Functional_Area,
        'PO_Requisitions_Interface_All' Interface_Report,
        'Number of PO Requisitions' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        nvl(inv_orgs.organization_code, gl_ou.organization_code) Org_Code,
        nvl(inv_orgs.organization_id, gl_ou.organization_id) Inv_Organization_Id,
        'Interface Source' Column_Type,
        pri.interface_source_code Column_Info,
        pri.process_flag Status_Code,
        pie.error_message Reject_Code_or_Error_Message,
        'Rows in the PO_REQUISITIONS_INTERFACE_ALL table' Interface_Description
from    po_requisitions_interface_all pri,
        (select pie.interface_transaction_id,
                pie.table_name,
                pie.error_message
         from   po_interface_errors pie
         where  pie.table_name           = 'PO_REQUISITIONS_INTERFACE'
        ) pie,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        inv_organizations inv_orgs,
        mfg_lookups ml -- Priority
where   gl_ou.operating_unit_id          = pri.org_id
and     pie.interface_transaction_id (+) = pri.transaction_id
and     inv_orgs.organization_id         = pri.destination_organization_id
-- pti.need_by_date is an optional column
and     trunc(nvl(pri.need_by_date, pri.creation_date)) between gp.start_date and gp.end_date
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     fav.application_short_name       = 'PO'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 3 -- Resolution Recommended
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'PO_Requisitions_Interface_All', -- Interface_Report
        'Number of PO Requisitions', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        nvl(inv_orgs.organization_code, gl_ou.organization_code), -- Org_Code
        nvl(inv_orgs.organization_id, gl_ou.organization_id), -- Inv_Organization_Id
        'Interface Source', -- Column_Type
        pri.interface_source_code, -- Column_Info
        pri.process_flag, -- Status_Code
        pie.error_message, -- Reject_Code_or_Error_Message
        'Rows in the PO_REQUISITIONS_INTERFACE_ALL table' -- Interface_Description

-- +=============================================================================+
-- |                              Receiving Reports                              |
-- +=============================================================================+

union all
-- =======================================================
-- Pending Expense Receiving Report
-- =======================================================
-- Get the Expense Receipts with an inventory organization id
select  flvv.meaning Functional_Area,
        'RCV_Transactions_Interface' Interface_Report,
        'Pending Expense Receiving Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        rti.transaction_type Column_Info,
        rti.processing_status_code Status_Code,
        rti.transaction_status_code Reject_Code_or_Error_Message,
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' Interface_Description
from    rcv_transactions_interface rti,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        inv_organizations inv_orgs,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        fnd_lookup_values_vl flvv -- Receiving
where   rti.to_organization_id is not null
and     rti.to_organization_id           = inv_orgs.organization_id
-- rti.transaction_date is a required column
and     trunc(rti.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'PO'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
-- Check for Expense Destinations
and exists 
        (-- ==============================================
         -- Case I  - EXPENSE destination_type_code exists
         --         - in rcv_transactions  
         -- ==============================================
         select 'x' 
         from    rcv_transactions_interface rt2
         where   rt2.interface_transaction_id = rti.interface_transaction_id
         and     rt2.destination_type_code    = 'EXPENSE'
         union all
         -- ==============================================
         -- Case II  - PO Distribution ID exists but the
         --          - but destination_type_code is null
         --          - or RECEIVING in rcv_transactions
         -- ==============================================
         select  'x'
         from    po_distributions_all pod
         where   pod.po_distribution_id       = rti.po_distribution_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_distribution_id is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR') 
         union all
         -- ==============================================
         -- Case III - PO Header ID, PO Line ID exist, but
         --          - the Line Location Id may or may not
         --          - exist
         -- ==============================================
         select  'x'
         from    po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   pol.po_line_id               = rti.po_line_id
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_distribution_id is null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
         union all
         -- ==============================================
         -- Case IV  - PO Number and PO Line Number exist
         --          - but the PO Header ID does not
         -- ==============================================
         select  'x'
         from    po_headers_all poh,
                 po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   poh.segment1                 = rti.document_num      -- PO Number
         and     pol.line_num                 = rti.document_line_num -- PO Line Number
         and     poh.po_header_id             = pol.po_header_id
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_header_id is null
         and     rti.document_num is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
        )
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 3 -- Resolution Recommended
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     flvv.lookup_type                 = 'RCV DESTINATION TYPE'
and     flvv.lookup_code                 = 'RECEIVING'
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        flvv.meaning, -- Functional_Area
        'RCV_Transactions_Interface', -- Interface_Report
        'Pending Expense Receiving Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        rti.transaction_type, -- Column_Info
        rti.processing_status_code,
        rti.transaction_status_code, -- Reject_Code_or_Error_Message
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' -- Interface_Description
union all
-- =======================================================
-- Pending Expense Receiving Report
-- =======================================================
-- Get the Expense Receipts without an inventory organization id
select  flvv.meaning Functional_Area,
        'RCV_Transactions_Interface' Interface_Report,
        'Pending Expense Receiving Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        gl_ou.ledger Ledger,
        gl_ou.operating_unit Operating_Unit,
        gl_ou.operating_unit_id Operating_Unit_Id,
        gl_ou.organization_code Org_Code,
        gl_ou.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        rti.transaction_type Column_Info,
        rti.processing_status_code Status_Code,
        rti.transaction_status_code Reject_Code_or_Error_Message,
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' Interface_Description
from    rcv_transactions_interface rti,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        gl_ou,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        fnd_lookup_values_vl flvv -- Receiving
where   rti.to_organization_id is  null
and     rti.org_id                       = gl_ou.operating_unit_id
-- rti.transaction_date is a required column
and     trunc(rti.transaction_date) between gp.start_date and gp.end_date
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = gl_ou.period_set_name
and     gp.period_type                   = gl_ou.accounted_period_type
and     fav.application_short_name       = 'PO'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
-- Check for Expense Destinations
and exists 
        (-- ==============================================
         -- Case I  - EXPENSE destination_type_code exists
         --         - in rcv_transactions  
         -- ==============================================
         select 'x' 
         from    rcv_transactions_interface rt2
         where   rt2.interface_transaction_id = rti.interface_transaction_id
         and     rt2.destination_type_code    = 'EXPENSE'
         union all
         -- ==============================================
         -- Case II  - PO Distribution ID exists but the
         --          - but destination_type_code is null
         --          - or RECEIVING in rcv_transactions
         -- ==============================================
         select  'x'
         from    po_distributions_all pod
         where   pod.po_distribution_id       = rti.po_distribution_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_distribution_id is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR') 
         union all
         -- ==============================================
         -- Case III - PO Header ID, PO Line ID exist, but
         --          - the Line Location Id may or may not
         --          - exist
         -- ==============================================
         select  'x'
         from    po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   pol.po_line_id               = rti.po_line_id
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_distribution_id is null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
         union all
         -- ==============================================
         -- Case IV  - PO Number and PO Line Number exist
         --          - but the PO Header ID does not
         -- ==============================================
         select  'x'
         from    po_headers_all poh,
                 po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   poh.segment1                 = rti.document_num      -- PO Number
         and     pol.line_num                 = rti.document_line_num -- PO Line Number
         and     poh.po_header_id             = pol.po_header_id
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code    = 'EXPENSE'
         and     rti.po_header_id is null
         and     rti.document_num is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
        )
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 3 -- Resolution Recommended
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     flvv.lookup_type                 = 'RCV DESTINATION TYPE'
and     flvv.lookup_code                 = 'RECEIVING'
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        flvv.meaning, -- Functional_Area
        'RCV_Transactions_Interface', -- Interface_Report
        'Pending Expense Receiving Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        gl_ou.ledger,
        gl_ou.operating_unit,
        gl_ou.operating_unit_id,
        gl_ou.organization_code,
        gl_ou.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        rti.transaction_type, -- Column_Info
        rti.processing_status_code,
        rti.transaction_status_code, -- Reject_Code_or_Error_Message
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' -- Interface_Description
union all
-- =======================================================
-- Pending Inventory and OSP Receiving Reports
-- =======================================================
select  flvv.meaning Functional_Area,
        'RCV_Transactions_Interface' Interface_Report,
        'Pending Inventory and OSP Receiving Transactions' Report_Title,
        ml1.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        ml2.meaning Column_Type, -- Transaction Type
        rti.transaction_type Column_Info,
        rti.processing_status_code Status_Code,
        rti.transaction_status_code Reject_Code_or_Error_Message,
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' Interface_Description
from    rcv_transactions_interface rti,
        gl_periods gp,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        inv_organizations inv_orgs,
        mfg_lookups ml1, -- Priority
        mfg_lookups ml2, -- Transaction Type
        fnd_lookup_values_vl flvv -- Receiving
where   inv_orgs.organization_id         = rti.to_organization_id
-- rti.transaction_date is a required column
and     trunc(rti.transaction_date) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'PO'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
-- Check for Inventory or Shop Floor Destinations
and exists 
        (-- ==============================================
         -- Case I  - INVENTORY or SHOP FLOOR destination_
         --         - type_code existsin rcv_transactions  
         -- ==============================================
         select  'x' 
         from    rcv_transactions_interface rt2
         where   rt2.interface_transaction_id = rti.interface_transaction_id
         and     rt2.destination_type_code in ('INVENTORY','SHOP FLOOR')
         union all
         -- ==============================================
         -- Case II  - PO Distribution ID exists but the
         --          - but destination_type_code is null
         --          - or RECEIVING in rcv_transactions
         -- ==============================================
         select  'x'
         from    po_distributions_all pod
         where   pod.po_distribution_id       = rti.po_distribution_id
         and     pod.destination_type_code in ('INVENTORY','SHOP FLOOR')
         and     rti.po_distribution_id is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR') 
         union all
         -- ==============================================
         -- Case III - PO Header ID, PO Line ID exist, but
         --          - the Line Location Id may or may not
         --          - exist
         -- ==============================================
         select  'x'
         from    po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   pol.po_line_id               = rti.po_line_id -- PO Line ID
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code in ('INVENTORY','SHOP FLOOR')
         and     rti.po_distribution_id is null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
         UNION ALL
         -- ==============================================
         -- Case IV  - PO Number and PO Line Number exist
         --          - but the PO Header ID does not
         -- ==============================================
         select  'x'
         from    po_headers_all poh,
                 po_lines_all pol,
                 po_line_locations_all pll,
                 po_distributions_all pod
         where   poh.segment1                 = rti.document_num      -- PO Number
         and     pol.line_num                 = rti.document_line_num -- PO Line Number
         and     poh.po_header_id             = pol.po_header_id
         and     pll.po_line_id               = pol.po_line_id
         and     pod.po_line_id               = pll.po_line_id
         and     pod.destination_type_code in ('INVENTORY','SHOP FLOOR')
         and     rti.po_header_id is null
         and     rti.document_num is not null
         and     nvl(rti.destination_type_code,'NONE') not in ('EXPENSE', 'INVENTORY','SHOP FLOOR')
        )
and     ml1.lookup_type                  = 'CST_SRS_RESOLUTION_TYPES'
and     ml1.lookup_code                  = 3 -- Resolution Recommended
and     ml2.lookup_type                  = 'INV_SRS_REG_BREAK'
and     ml2.lookup_code                  = 3 -- Transaction Type
and     flvv.lookup_type                 = 'RCV DESTINATION TYPE'
and     flvv.lookup_code                 = 'RECEIVING'
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        flvv.meaning, -- Functional_Area
        'RCV_Transactions_Interface', -- Interface_Report
        'Pending Inventory and OSP Receiving Transactions', -- Report_Title
        ml1.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        ml2.meaning, -- Column_Type, Transaction Type
        rti.transaction_type, -- Column_Info
        rti.processing_status_code,
        rti.transaction_status_code, -- Reject_Code_or_Error_Message
        'Rows in the RCV_TRANSACTIONS_INTERFACE table' -- Interface_Description

-- +=============================================================================+
-- |                               Shipping Reports                              |
-- +=============================================================================+

union all
-- =======================================================
-- Unprocessed Shipping Report for Sales Orders
-- =======================================================
select  fav.application_name Functional_Area,
        'WSH_Delivery_Details' Interface_Report,
        'Unprocessed Sales Order Shipping Transactions' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Ship Date
        to_char(trunc(wts.actual_departure_date)) Column_Info,
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ) Status_code,
        wev.message Reject_Code_or_Error_Message,
        'Rows in the WSH_DELIVERY_DETAILS table' Interface_Description
from    wsh_delivery_details wdd,
        wsh_delivery_assignments wda,
        wsh_new_deliveries wnd,
        wsh_delivery_legs wdl,
        wsh_trip_stops wts,
        wsh_exceptions_v wev,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl, -- Ship Date
        mfg_lookups ml  -- Priority
where   wdd.source_code                  = 'OE'
and     wdd.released_status              = 'C'
and     wdd.inv_interfaced_flag in ('N' ,'P')
and     wda.delivery_detail_id           = wdd.delivery_detail_id
and     wnd.delivery_id                  = wda.delivery_id
and     wnd.status_code in ('CL','IT')
and     wdl.delivery_id                  = wnd.delivery_id
and     wts.pending_interface_flag in ('Y', 'P')
and     wdl.pick_up_stop_id              = wts.stop_id
and     wev.trip_stop_id (+)             = wts.stop_id 
and     inv_orgs.organization_id         = wnd.organization_id
and     trunc(nvl(wts.actual_departure_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'MSC_PQ_CP_EXCP'
and     fl.lookup_code                   = 'MSCX_CUST_SHIP_DATE'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 2 -- Resolution Required
and     4=4                              -- p_period_name, period_year
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSH_Delivery_Details', -- Interface_Report
        'Unprocessed Sales Order Shipping Transactions', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        fl.meaning, -- Column_Type, Ship Date
        to_char(trunc(wts.actual_departure_date)), -- Column_Info
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ), -- Status_code
        wev.message, -- Reject_Code_or_Error_Message
        'Rows in the WSH_DELIVERY_DETAILS table' -- Interface_Description
union all
-- =======================================================
-- Unprocessed Shipping Report for Expense Requisitions
-- =======================================================
select  fav.application_name Functional_Area,
        'WSH_Delivery_Details' Interface_Report,
        'Unprocessed Expense Requisition Shipping Transactions' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Ship Date
        to_char(trunc(wts.actual_departure_date)) Column_Info,
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ) Status_code,
        wev.message Reject_Code_or_Error_Message,
        'Rows in the WSH_DELIVERY_DETAILS table' Interface_Description
from    wsh_delivery_details wdd,
        wsh_delivery_assignments wda,
        wsh_new_deliveries wnd,
        wsh_delivery_legs wdl,
        wsh_trip_stops wts,
        wsh_exceptions_v wev,
        oe_order_lines_all ool,
        po_requisition_lines_all prl,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl, -- Ship Date
        mfg_lookups ml  -- Priority
where   wdd.source_code                  = 'OE'
and     wdd.released_status              = 'C'
and     wdd.inv_interfaced_flag in ('N' ,'P')
and     wda.delivery_detail_id           = wdd.delivery_detail_id
and     wnd.delivery_id                  = wda.delivery_id
and     wnd.status_code in ('CL','IT')
and     wdl.delivery_id                  = wnd.delivery_id
and     wts.pending_interface_flag in ('Y', 'P')
and     wdl.pick_up_stop_id              = wts.stop_id
-- For purchase requisitions
and     inv_orgs.organization_id         = prl.destination_organization_id
and     wdd.source_line_id               = ool.line_id
and     wdd.source_document_type_id      = 10
and     ool.source_document_line_id      = prl.requisition_line_id
and     prl.destination_organization_id <> prl.source_organization_id
and     prl.destination_type_code        = 'EXPENSE'
and     wts.stop_location_id             = wnd.initial_pickup_location_id
-- End changes for purchase requisitions
and     wev.trip_stop_id (+)             = wts.stop_id 
and     inv_orgs.organization_id         = wnd.organization_id
and     trunc(nvl(wts.actual_departure_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'MSC_PQ_CP_EXCP'
and     fl.lookup_code                   = 'MSCX_CUST_SHIP_DATE'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 2 -- Resolution Required
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSH_Delivery_Details', -- Interface_Report
        'Unprocessed Expense Requisition Shipping Transactions', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        fl.meaning, -- Column_Type, Ship Date
        to_char(trunc(wts.actual_departure_date)), -- Column_Info
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ), -- Status_code
        wev.message, -- Reject_Code_or_Error_Message
        'Rows in the WSH_DELIVERY_DETAILS table' -- Interface_Description
union all
-- =======================================================
-- Unprocessed Shipping Report for Inventory Requisitions
-- =======================================================
select  fav.application_name Functional_Area,
        'WSH_Delivery_Details' Interface_Report,
        'Unprocessed Inventory Requisition Shipping Transactions' Report_Title,
        ml.meaning Priority,
        count(*) Count,
        gp.period_year Period_Year,
        gp.period_num Period_Number, 
        gp.period_name Period_Name,
        inv_orgs.ledger Ledger,
        inv_orgs.operating_unit Operating_Unit,
        inv_orgs.operating_unit_id Operating_Unit_Id,
        inv_orgs.organization_code Org_Code,
        inv_orgs.organization_id Inv_Organization_Id,
        fl.meaning Column_Type, -- Ship Date
        to_char(trunc(wts.actual_departure_date)) Column_Info,
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ) Status_code,
        wev.message Reject_Code_or_Error_Message,
        'Rows in the WSH_DELIVERY_DETAILS table' Interface_Description
from    wsh_delivery_details wdd,
        wsh_delivery_assignments wda,
        wsh_new_deliveries wnd,
        wsh_delivery_legs wdl,
        wsh_trip_stops wts,
        wsh_exceptions_v wev,
        oe_order_lines_all ool,
        po_requisition_lines_all prl,
        mtl_interorg_parameters mip,
        gl_periods gp,
        inv_organizations inv_orgs,
        fnd_application_vl fav,
        fnd_product_installations fpi,
        fnd_lookups fl, -- Ship Date
        mfg_lookups ml -- Priority
where   wdd.source_code                  = 'OE'
and     wdd.released_status              = 'C'
and     wdd.inv_interfaced_flag in ('N' ,'P')
and     wda.delivery_detail_id           = wdd.delivery_detail_id
and     wnd.delivery_id                  = wda.delivery_id
and     wnd.status_code in ('CL','IT')
and     wdl.delivery_id                  = wnd.delivery_id
and     wts.pending_interface_flag in ('Y', 'P')
and     wdl.pick_up_stop_id              = wts.stop_id
-- For purchase requisitions
and     inv_orgs.organization_id         = prl.destination_organization_id
and     wdd.source_line_id               = ool.line_id
and     wdd.source_document_type_id      = 10
and     ool.source_document_line_id      = prl.requisition_line_id
and     prl.destination_organization_id <> prl.source_organization_id
and     prl.destination_organization_id  = mip.to_organization_id
and     prl.source_organization_id       = mip.from_organization_id
and     mip.intransit_type               = 1
and     prl.destination_type_code       <> 'EXPENSE'
and     wts.stop_location_id             = wnd.initial_pickup_location_id
-- End changes for purchase requisitions
and     wev.trip_stop_id (+)             = wts.stop_id 
and     inv_orgs.organization_id         = wnd.organization_id
and     trunc(nvl(wts.actual_departure_date,sysdate)) between inv_le_timezone_pub.get_server_day_time_for_le(gp.start_date,inv_orgs.legal_entity_id) and inv_le_timezone_pub.get_server_day_time_for_le(gp.end_date,inv_orgs.legal_entity_id)
and     gp.adjustment_period_flag        = 'N'
-- To avoid cross joining with secondary period information
and     gp.period_set_name               = inv_orgs.period_set_name
and     gp.period_type                   = inv_orgs.accounted_period_type
and     fav.application_short_name       = 'INV'
-- Only report installed applications
and     fav.application_id               = fpi.application_id
and     fpi.status                      <> 'N' -- Inactive
and     fl.lookup_type                   = 'MSC_PQ_CP_EXCP'
and     fl.lookup_code                   = 'MSCX_CUST_SHIP_DATE'
and     ml.lookup_type                   = 'CST_SRS_RESOLUTION_TYPES'
and     ml.lookup_code                   = 2 -- Resolution Required
and     4=4                              -- p_period_name
and     5=5                              -- p_functional_area
and     6=6                              -- p_period_year
group by
        fav.application_name, -- Functional_Area
        'WSH_Delivery_Details', -- Interface_Report
        'Unprocessed Inventory Requisition Shipping Transactions', -- Report_Title
        ml.meaning, -- Priority
        gp.period_year,
        gp.period_num, 
        gp.period_name,
        inv_orgs.ledger,
        inv_orgs.operating_unit,
        inv_orgs.operating_unit_id,
        inv_orgs.organization_code,
        inv_orgs.organization_id,
        fl.meaning, -- Column_Type, Ship Date
        to_char(trunc(wts.actual_departure_date)), -- Column_Info
        decode(wdd.inv_interfaced_flag,
                'Y', 'Y - Delivery has been interfaced to Inventory',
                'P', 'P - Delivery is pending interface to Inventory',
                'N', 'N - Delivery not interfaced to Inventory',
                'X', 'X - Delivery excluded from inventory interface'
               ), -- Status_code
        wev.message, -- Reject_Code_or_Error_Message
        'Rows in the WSH_DELIVERY_DETAILS table' -- Interface_Description
order by 1,2,3,4,6,7,8,9,10,11