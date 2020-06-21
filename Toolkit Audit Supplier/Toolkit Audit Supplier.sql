/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Toolkit - Audit Supplier
-- Description: Track master data changes, utilize standard Oracle Audit functionality and compare audit table date with the bank account details,

-- Excel Examle Output: https://www.enginatics.com/example/toolkit-audit-supplier/
-- Library Link: https://www.enginatics.com/reports/toolkit-audit-supplier/
-- Run Report: https://demo.enginatics.com/

SELECT 
a.vendor_name Supplier,
       a.vendor_site_code Site,
       a.bank_ac     Bank_acc,
       a.segment1    Supp_num,
       Mod_Bank,
       --A.VENDOR_NAME Initial_Value,
       a.bank_account_num Initial_Value,
       --NVL(LAG(A.VENDOR_NAME, 1) OVER(PARTITION BY A.VENDOR_ID ORDER BY A.AUDIT_TIMESTAMP DESC),a.sup_name) New_value,        
       NVL(LAG(A.bank_account_num, 1)
           OVER(PARTITION BY A.EXT_BANK_ACCOUNT_ID ORDER BY
                A.AUDIT_TIMESTAMP DESC),
           a.bank_ac) New_value,
       --a.vend_mod_by,
       a.bank_mod_by,
       a.AUDIT_TIMESTAMP bank_Mod_Date
--a.AUDIT_TIMESTAMP Vend_Mod_Date

  FROM (SELECT 'Bank AC' Mod_bank,
               --  sup_aud.AUDIT_TIMESTAMP,
               bank_audit.AUDIT_TIMESTAMP,
               -- sup_aud.VENDOR_ID,
               bank_audit.EXT_BANK_ACCOUNT_ID,
               asa.VENDOR_NAME,
               assa.VENDOR_site_code,
               bank_audit.bank_account_num,
               ieba.bank_account_num          bank_ac,
               --asa.vendor_name sup_name,
               asa.segment1,
               NVL((SELECT papf.full_name
                     FROM fnd_user fu, per_all_people_f papf
                   --    WHERE user_name = sup_aud.AUDIT_USER_NAME
                    WHERE user_name = bank_audit.AUDIT_USER_NAME
                      AND fu.employee_id = papf.person_id
                      AND TRUNC(SYSDATE) BETWEEN papf.
                    effective_start_date
                      AND papf.effective_end_date),
                   (SELECT DESCRIPTION FROM fnd_user fu1 WHERE fu1.user_name = bank_audit.AUDIT_USER_NAME)) bank_mod_by,
                     
               bank_audit.AUDIT_USER_NAME
        -- WHERE fu1.user_name = sup_aud.AUDIT_USER_NAME)) vend_mod_by,
        -- sup_aud.AUDIT_USER_NAME
          FROM --ap_suppliers_a          sup_aud,
                ap_suppliers             asa,
               ap_supplier_sites_all     assa,
               iby_external_payees_all   iepa,
               iby_pmt_instr_uses_all    ipiua,
               iby_ext_bank_accounts     ieba,
               iby_ext_bank_accounts_ac1 bank_audit      
         WHERE 1=1
           and bank_audit.BANK_ACCOUNT_NAME IS NOT NULL
           and asa.vendor_id = assa.vendor_id
           and asa.segment1 = 1008
           AND   (SELECT NAME FROM apps.hr_operating_units hou WHERE 2=2
                 AND hou.organization_id = assa.org_id) ='Vision Operations'
           and assa.vendor_site_id = iepa.supplier_site_id
           and iepa.ext_payee_id = ipiua.ext_pmt_party_id
           and ieba.ext_bank_account_id = ipiua.instrument_id
           and ieba.ext_bank_account_id = bank_audit.ext_bank_account_id) A
           --   AND sup_aud.vendor_id = asa.vendor_id) A