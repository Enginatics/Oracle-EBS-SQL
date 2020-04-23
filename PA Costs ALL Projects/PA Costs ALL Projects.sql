/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Costs ALL Projects
-- Description: Collect all project costs
-- Excel Examle Output: https://www.enginatics.com/example/pa-costs-all-projects/
-- Library Link: https://www.enginatics.com/reports/pa-costs-all-projects/
-- Run Report: https://demo.enginatics.com/

SELECT pcera.amount total_revenue ,pdra.project_id , pdri.task_id ,pdra.gl_date,pdra.org_id

   FROM  pa.pa_draft_revenues_all  pdra

    , pa.pa_draft_revenue_items  pdri

    , pa.pa_cust_event_rdl_all pcera

    , pa.pa_events pe

    , xla.xla_ae_headers xah

    , xla.xla_ae_lines xal 

    , gl.gl_import_references gir

    , gl.gl_je_headers gjh 

    , pa.pa_implementations_all pia

       , gl.gl_periods gp

   WHERE  pdra.project_id =  pdri.project_id

   AND pdra.draft_revenue_num = pdri.draft_revenue_num

   AND pdri.project_id = pcera.project_id

   AND pdri.draft_revenue_num = pcera.draft_revenue_num

   AND pcera.draft_revenue_item_line_num = pdri.line_num

   AND pcera.event_num = pe.event_num

   AND pdra.transfer_status_code = 'A'

   AND pe.project_id = pcera.project_id

   AND pcera.task_id = pe.task_id

   AND xah.event_id = pdra.event_id

   AND xal.ae_header_id = xah.ae_header_id

   AND xal.ae_line_num = 1

   AND xal.gl_sl_link_id = gir.gl_sl_link_id

   AND gjh.je_header_id = gir.je_header_id

   AND gjh.status = 'P'

   AND pdri.task_id = pdri.task_id

         --   AND ((SYSDATE-100000) between gp.start_date AND gp.end_date)

   AND (gjh.posted_date between gp.start_date AND gp.end_date)

   AND gp.period_set_name=pia.period_set_name

   AND pia.org_id  =pdra.org_id