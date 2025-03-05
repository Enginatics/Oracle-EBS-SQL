/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC AP Accrual Reconciliation Summary by Match Type
-- Description: Use this report to summarize the A/P Accrual entries from the Accrual Reconcilation Report tables, by operating unit, accrual match type and inventory organization.  Use this report for summary reconciliation purposes, to justify the "at time of receipt" accrual balances for your inventory and expense A/P accrual accounts.

Parameters:
===========
Transaction Date From:  enter the accrual starting transaction date you wish to report.  Defaults to the earliest date found (mandatory).
Transaction Date To:  enter the accrual ending transaction date you wish to report.  Defaults to the latest date found (mandatory).
Operating Unit:  operating unit you wish to report (optional).
Ledger:  general ledger you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2011-2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Nov 2011 Douglas Volz   Initial Coding based on xxx_ap_accrual_summary_rept.sql
-- |                                     Retrofitted to R12 A/P Accrual tables
-- |  1.1     07 May 2019 Douglas Volz   Modified for upgrade client
-- |  1.2     06 Feb 2020 Douglas Volz   Added Ledger parameter.
-- |  1.3     09 Apr 2020 Douglas Volz   Commented out capr.inventory_transaction_id column
-- |                                     Was added by Oracle for consignment transactions in
-- |                                     Release 12.1.6.
-- |  1.4     15 Apr 2020 Douglas Volz   Undid modifications for upgrade client
-- |  1.5     17 Feb 2025 Douglas Volz   Formatted for Blitz Report.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-ap-accrual-reconciliation-summary-by-match-type/
-- Library Link: https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-summary-by-match-type/
-- Run Report: https://demo.enginatics.com/

with accrual_type as
 (select 'ACCRUAL TYPE' lookup_type,
                to_char(mtt.transaction_type_id) lookup_code,
                mtt.transaction_type_name accrual_match_type
         from   mtl_transaction_types mtt
         union all
         select 'ACCRUAL TYPE' lookup_type,
                flvv.lookup_code,
                flvv.meaning accrual_match_type
         from   fnd_lookup_values_vl flvv
         where  flvv.lookup_type    in ('ACCRUAL TYPE','RCV TRANSACTION TYPE')
        ) -- accrual_type

------------ SQL query starts here ----------------
-- ===========================================================================================
-- This first select finds those entries that join to a PO and PO line for Receiving
-- ===========================================================================================
select  gl.name Ledger,
        haou.name Operating_Unit,
        -- Revision for version 1.5
        at.accrual_match_type Match_Type,
        mp.organization_code Org_Code,
        gcc.concatenated_segments Accrual_Account,
        -- End revision for version 1.5
        &segment_columns
        gl.currency_code Currency_Code,
        -- Revision for version 1.1
        -- Not all upgraded summary rows have links to the xla tables
        -- Revision for version 1.4 ... keep this logic
        sum(decode(ah.je_category_name, 'Receiving', nvl(capr.amount,0), 0)) Receiving_Amount,
        sum(decode(ah.je_category_name, 'Purchase Invoices', nvl(capr.amount,0), 0)) Payables_Amount,
        sum(decode(ah.je_category_name, 'INVENTORY', nvl(capr.amount,0),
                                        'Inventory', nvl(capr.amount,0),
                                        'MTL', nvl(capr.amount,0),0)) Inventory_Amount,
        sum(decode(ah.je_category_name, 'INVENTORY', 0,
                                        'Inventory', 0,
                                        'MTL', 0,
                                        'Receiving', 0,
                                        'Purchase Invoices', 0,
                                        nvl(capr.amount,0))) Other_Amount,
        -- Revision for version 1.4
        -- Comment out this upgrade code
        -- sum(decode(capr.rcv_transaction_id, null, 0, nvl(capr.amount,0))) Receiving_Amount,
        -- sum(decode(capr.invoice_distribution_id, null, 0, nvl(capr.amount,0))) Payables_Amount,
        -- Revision for version 1.3
        -- sum(decode(capr.inventory_transaction_id, null, 0, nvl(capr.amount,0))) Inventory_Amount,
        -- sum(0) Inventory_Amount,
        -- sum(case 
        --        when (capr.rcv_transaction_id is null and 
        --              capr.invoice_distribution_id is null and 
        --              -- capr.inventory_transaction_id is null and
        --              capr.write_off_id is null
        --             ) then nvl(capr.amount,0)
        --        else 0
        --     end) Other_Amount,
        -- sum((nvl(capr.amount,0))) Total_Accounted_Amount,
        -- End for revision for version 1.4
        sum(decode(capr.write_off_id, null, nvl(capr.amount,0), 0)) Total_Accounted_Amount,
        sum(decode(capr.write_off_id, null, 0, nvl(capr.amount,0))) Write_Offs,
        sum((nvl(capr.amount,0))) Net_Accounted_Amount
        -- End revision for version 1.1
from    cst_ap_po_reconciliation capr,
        gl_code_combinations_kfv gcc,
        hr_organization_information hoi,
        hr_all_organization_units haou, -- operating unit
        -- Revision for version 1.1
        -- Not all upgraded summary rows have links to the xla tables
        -- Revision for version 1.4 ... keep this logic
        xla_ae_headers ah,
        xla_ae_lines al,
        -- End revision for version 1.1
        gl_ledgers gl,
        -- Revision for version 1.5
        po_distributions_all pod,
        mtl_parameters mp,
        accrual_type at
-- Revision for version 1.1
-- Not all upgraded summary rows have links to the xla tables
-- Revision for version 1.4 ... keep this logic
where   capr.ae_header_id           = ah.ae_header_id (+)
and     capr.ae_line_num            = al.ae_line_num  (+)
and     capr.ae_header_id           = al.ae_header_id (+)
and     al.application_id in (200, 707)   -- 200 is Payables, 707 is Cost Management
-- End revision for version 1.1
and     capr.accrual_account_id     = gcc.code_combination_id (+)
and     al.code_combination_id      = gcc.code_combination_id
-- Revision for version 1.1
-- Revision for version 1.4 ... keep this logic
and     ah.ledger_id                = gl.ledger_id
and     gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
-- Revision for version 1.1
-- ===================================================================
-- using the base tables to avoid the performance issues with the
-- views org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context = 'Operating Unit Information'
and     hoi.organization_id         = haou.organization_id
and     capr.operating_unit_id      = haou.organization_id
-- Revision for version 1.5
and     pod.po_distribution_id      = capr.po_distribution_id
and     mp.organization_id (+)      = pod.destination_organization_id
and     at.lookup_code (+)          = capr.transaction_type_code
and     1=1                         -- p_operating_unit, p_ledger
and     2=2                         -- p_trx_from, p_trx_date_to
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
-- End revision for version 1.5
group by
        gl.name,
        haou.name,
        -- Revision for version 1.5
        at.accrual_match_type, -- Match Type
        mp.organization_code,
        gcc.concatenated_segments, -- Accrual Account
        -- End revision for version 1.5
        &segment_columns_grp
        gl.currency_code
union all
-- ===========================================================================================
-- This second select finds those entries that do not join to a PO and PO line (AP NO MATCH)
-- ===========================================================================================
select  gl.name Ledger,
        haou.name Operating_Unit,
        -- Revision for version 1.5
        at.accrual_match_type Match_Type,
        mp.organization_code,
        gcc.concatenated_segments Accrual_Account,
        -- End revision for version 1.5
        &segment_columns
        gl.currency_code Currency_Code,
        -- Revision for version 1.1
        -- Not all upgraded summary rows have links to the xla tables
        -- Revision for version 1.4 ... keep this logic
        sum(decode(ah.je_category_name, 'Receiving', nvl(cmr.amount,0), 0)) Receiving_Amount,
        sum(decode(ah.je_category_name, 'Purchase Invoices', nvl(cmr.amount,0), 0)) Payables_Amount,
        sum(decode(ah.je_category_name, 'INVENTORY', nvl(cmr.amount,0),
                                        'Inventory', nvl(cmr.amount,0),
                                        'MTL', nvl(cmr.amount,0),0)) Inventory_Amount,
        sum(decode(ah.je_category_name, 'INVENTORY', 0,
                                        'Inventory', 0,
                                        'MTL', 0,
                                        'Receiving', 0,
                                        'Purchase Invoices', 0,
                                        nvl(cmr.amount,0))) Other_Amount,
        sum((nvl(cmr.amount,0))) Total_Accounted_Amount,
        sum(decode(cmr.write_off_select_flag, null, 0, 'N', 0, nvl(cmr.amount,0))) Write_Offs,
        sum(decode(cmr.write_off_select_flag, null, nvl(cmr.amount,0), 'N', nvl(cmr.amount,0), 0)) Net_Accounted_Amount
        -- sum(0) "Receiving Amount",
        -- sum(decode(cmr.invoice_distribution_id, null, 0, nvl(cmr.amount,0))) "Payables Amount",
        -- sum(decode(cmr.inventory_transaction_id, null, 0, nvl(cmr.amount,0))) "Inventory Amount",
        -- sum(case 
        --        when ( cmr.invoice_distribution_id is null and 
        --         cmr.inventory_transaction_id is null and
        --         cmr.write_off_select_flag is null) then nvl(cmr.amount,0)
        --  else 0
        -- end) "Other Amount",
        -- sum(decode(cmr.write_off_select_flag, null, nvl(cmr.amount,0), 0)) "Total Accounted Amount",
        -- sum(decode(cmr.write_off_select_flag, null, 0, nvl(cmr.amount,0))) "Write-Offs",
        -- sum((nvl(cmr.amount,0))) "Net Accounted Amount"
        -- End revision for version 1.1
from    cst_misc_reconciliation cmr,
        gl_code_combinations_kfv gcc,
        hr_organization_information hoi,
        hr_all_organization_units haou, -- operating unit
        -- Revision for version 1.1
        -- Not all upgraded summary rows have links to the xla tables
        -- Revision for version 1.4 ... keep this logic
        xla_ae_headers ah,
        xla_ae_lines al,
        gl_ledgers gl,
        -- Revision for version 1.5
        mtl_parameters mp,
        accrual_type at
where   cmr.ae_header_id            = ah.ae_header_id
and     cmr.ae_line_num             = al.ae_line_num
and     cmr.ae_header_id            = al.ae_header_id
and     al.application_id in (200, 707)   -- 200 is Payables, 707 is Cost Management
and     cmr.accrual_account_id      = gcc.code_combination_id (+)
and     al.code_combination_id      = gcc.code_combination_id
-- ===================================================================
-- using the base tables to avoid the performance issues with the
-- views org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context = 'Operating Unit Information'
and     hoi.organization_id         = haou.organization_id
and     cmr.operating_unit_id       = haou.organization_id
-- Revision for version 1.4 ... keep this logic
and     ah.ledger_id                = gl.ledger_id
and     gl.ledger_id                = to_number(hoi.org_information3) -- this joins OU to GL
-- Revision for version 1.5
and     mp.organization_id (+)      = cmr.inventory_organization_id
and     at.lookup_code (+)          = cmr.transaction_type_code
and     1=1                         -- p_operating_unit, p_ledger
and     3=3                         -- p_trx_from, p_trx_date_to
-- End revision for version 1.5
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
group by
        gl.name,
        haou.name,
        -- Revision for version 1.5
        at.accrual_match_type, -- Match Type
        mp.organization_code,
        gcc.concatenated_segments, -- Accrual Account
        -- End revision for version 1.5
        &segment_columns_grp
        gl.currency_code
-- Order by Ledger, Operating Unit, Match Type, Org Code, Accounts
order by 1,2,3,4,5