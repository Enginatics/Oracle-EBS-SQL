/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AUDIT-SUPPLIER-NO-SITE
-- Excel Examle Output: https://www.enginatics.com/example/audit-supplier-no-site
-- Library Link: https://www.enginatics.com/reports/audit-supplier-no-site
-- Run Report: https://demo.enginatics.com/


SELECT 
       a.sup_name Supplier_Name,
       a.segment1 Supplier_number,
       Modified_Field_name,
       A.VENDOR_NAME Initial_Value,
       NVL ( LAG (A.VENDOR_NAME, 1) OVER (PARTITION BY A.VENDOR_ID ORDER BY A.AUDIT_TIMESTAMP DESC),A.sup_name) New_value,
       a.Modified_by,
       a.AUDIT_TIMESTAMP Modified_Date       
  FROM (SELECT 'Vendor Name' Modified_Field_name,
               asaa.AUDIT_TIMESTAMP,
               asaa.VENDOR_ID,
               asaa.VENDOR_NAME,
               asa.vendor_name sup_name,
               asa.segment1,            
               NVL (
                  (SELECT papf.full_name
                     FROM fnd_user fu, per_all_people_f papf
                    WHERE user_name = asaa.AUDIT_USER_NAME
                          AND fu.employee_id = papf.person_id
                          AND TRUNC (SYSDATE) BETWEEN papf.
                                                       effective_start_date
                                                  AND papf.effective_end_date),
                  (SELECT DESCRIPTION
                     FROM fnd_user fu1
                    WHERE fu1.user_name = asaa.AUDIT_USER_NAME))
                  Modified_by,
               asaa.AUDIT_USER_NAME
          FROM ap_suppliers_a asaa, ap_suppliers asa
         WHERE 
1=1 and
asaa.VENDOR_NAME IS NOT NULL
               AND asaa.vendor_id = asa.vendor_id) A