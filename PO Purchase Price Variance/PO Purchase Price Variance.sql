/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchase Price Variance
-- Description: Imported Oracle standard Purchase Price Variance report
Source: Purchase Price Variance Report (XML)
Short Name: POXRCPPV_XML
DB package: PO_POXRCPPV_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/po-purchase-price-variance/
-- Library Link: https://www.enginatics.com/reports/po-purchase-price-variance/
-- Run Report: https://demo.enginatics.com/

select
        fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', MCA.STRUCTURE_ID, NULL, MCA.CATEGORY_ID, 'ALL', 'Y', 'VALUE') category
,       fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, MSI.ORGANIZATION_ID, MSI.INVENTORY_ITEM_ID, 'ALL', 'Y', 'VALUE') item
,        msi.description                           description
,        pov.vendor_name                           vendor
,        decode(poh.type_lookup_code,
                'BLANKET',
                poh.segment1||' - '||por.release_num,
                'PLANNED',
                poh.segment1||' - '||por.release_num,
                poh.segment1)                      po_number_release
,        poh.currency_code                         currency
,        papf.full_name                             buyer
,        pol.line_num                              line
,        rsh.shipment_num                          shipment
,        rct.transaction_date                      receipt_date
,        rsh.receipt_num                    receipt_number
,        round(mmt.primary_quantity,:p_qty_precision) quantity_received
,        rct.primary_unit_of_measure                       unit
,        round((nvl(mmt.transaction_cost,0)/nvl(mmt.currency_conversion_rate,1)),pol.extended_precision) unit_price
,        round(nvl(mmt.transaction_cost,0) , pol.extended_precision)       po_functional_price
,        round(nvl(mmt.actual_cost,0),pol.extended_precision)    std_unit_cost
,        round(decode(mta.accounting_line_type, 3, nvl(mcacd.actual_cost,0), 0) , pol.extended_precision) moh_absorbed_per_unit
,        mp.process_enabled_flag
,        mp.organization_code  
,        round(nvl(mmt.actual_cost,0),pol.extended_precision)    std_unit_cost_f
,        po_poxrcppv_xmlp_pkg.c_price_varianceformula( round ( nvl ( mmt.transaction_cost , 0 ) , pol.extended_precision ), 
                                     round ( nvl ( mmt.actual_cost , 0 ) , pol.extended_precision ), 
                                     round ( decode ( mta.accounting_line_type , 3 , nvl ( mcacd.actual_cost , 0 ) , 0 ) , pol.extended_precision ), 
                                     round ( mmt.primary_quantity , :p_qty_precision ), 
                                     pol.precision) c_price_variance
,pol.ledger
,pol.operating_unit
,        pol.po_header_id||' - '||pol.po_line_id group_by_lineid
,        rct.transaction_id rct_id
,        pol.item_id 
from     po_distributions_all           pod
,        po_line_locations_all          pll
,(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
gl.name ledger,
hou.name operating_unit,
fc.precision,
nvl(fc.extended_precision,fc.precision) extended_precision
from
po_lines_all pla,
hr_operating_units hou,
gl_ledgers gl,
fnd_currencies fc
where
2=2 and
pla.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code
) pol
,        po_headers_all                 poh
,        po_releases_all                por
,        mtl_material_transactions  mmt
,        mtl_transaction_accounts   mta
,        mtl_cst_actual_cost_details mcacd
,        mtl_parameters             mp
,        rcv_shipment_headers       rsh
,        rcv_transactions           rct 
,        ap_suppliers                 pov
,        mtl_system_items           msi
,        mtl_categories             mca
,        hr_locations_no_join       hrl
,       per_all_people_f             papf
where
3=3
and      mmt.rcv_transaction_id  = rct.transaction_id
and      mmt.organization_id  = rct.organization_id
and      mmt.transaction_id    = mta.transaction_id (+)
and      mta.accounting_line_type (+) = 3
and      mcacd.transaction_id (+) = mmt.transaction_id
and      mcacd.organization_id (+) = mmt.organization_id
and      mcacd.layer_id (+) = -1
and      mcacd.cost_element_id (+) = 2
and      mcacd.level_type (+) =  1
and      mcacd.transaction_action_id (+) = mmt.transaction_action_id
and      mp.organization_id = rct.organization_id
and      mp.process_enabled_flag = 'N' 
and      rct.shipment_header_id     = rsh.shipment_header_id
and      rct.po_line_id             = pol.po_line_id
and      rct.po_header_id           = poh.po_header_id 
and      rct.po_line_location_id    = pll.line_location_id
and      rct.po_distribution_id = pod.po_distribution_id
and      pod.line_location_id       = pll.line_location_id
and      pod.destination_type_code  = 'INVENTORY'
and      pll.po_release_id          = por.po_release_id(+)
and      pol.item_id                = msi.inventory_item_id(+)
and      pol.inventory_organization_id = msi.organization_id(+)
and      pol.category_id            = mca.category_id
and      rsh.vendor_id              = poh.vendor_id
and      poh.vendor_id              = pov.vendor_id
and      papf.person_id            = poh.agent_id
and (papf.employee_number is not null or papf.npw_number is not null) 
and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
and decode(hr_security.view_all ,'Y' , 'TRUE', 
hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id, papf.person_type_id,
papf.employee_number,papf.applicant_number )) = 'TRUE' 
and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id ,
hr_general.get_business_group_id) = papf.business_group_id 
and      pod.deliver_to_location_id = hrl.location_id(+) 
&p_vendor_name_where  
and  exists (select 1 from mtl_transaction_accounts mta1 where mta1.transaction_id = mmt.transaction_id
                           and mta1.accounting_line_type = 6)
union
select
         fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', MCA.STRUCTURE_ID, NULL, MCA.CATEGORY_ID, 'ALL', 'Y', 'VALUE') category
,        fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, MSI.ORGANIZATION_ID, MSI.INVENTORY_ITEM_ID, 'ALL', 'Y', 'VALUE') item
,        msi.description                           description
,        pov.vendor_name                           vendor
,        decode(poh.type_lookup_code,
                'BLANKET',
                poh.segment1||' - '||por.release_num,
                'PLANNED',
                poh.segment1||' - '||por.release_num,
                poh.segment1)                      po_number_release
,        poh.currency_code                         currency
,        papf.full_name                             buyer
,        pol.line_num                              line
,        rsh.shipment_num                          shipment
,        rct.transaction_date                      receipt_date
,        rsh.receipt_num                    receipt_number
,        round(decode(rct.transaction_type,
                     'RETURN TO RECEIVING', rct.primary_quantity * -1,
                rct.primary_quantity), :p_qty_precision) quantity_received
,        rct.primary_unit_of_measure                       unit
,       rct.po_unit_price  * (rct.source_doc_quantity / rct.primary_quantity ) +
         ((nvl(pod.nonrecoverable_tax,0)/ decode (pod.quantity_ordered,0,1,pod.quantity_ordered) )*(rct.source_doc_quantity/rct.primary_quantity))unit_price
,       round(nvl(rct.currency_conversion_rate,1)  * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) +
          (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/decode (pod.quantity_ordered,0,1, pod.quantity_ordered)   )
          *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision) po_functional_price
,        round ( &p_select_wip, pol.extended_precision ) std_unit_cost
,        0 moh_absorbed_per_unit
,        mp.process_enabled_flag
,        mp.organization_code
,      round ( &p_select_wip, pol.extended_precision ) std_unit_cost_f
,     po_poxrcppv_xmlp_pkg.c_price_varianceformula(round(nvl(rct.currency_conversion_rate,1)  * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) + 
                                               (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/decode (pod.quantity_ordered,0,1,pod.quantity_ordered))
                                               *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision),
                                     round ( &p_select_wip, pol.extended_precision ),
                                     0, 
                                    round(decode(rct.transaction_type,'RETURN TO RECEIVING', rct.primary_quantity * -1,rct.primary_quantity), :p_qty_precision), 
                                   pol.precision) c_price_variance
,pol.ledger
,pol.operating_unit
,        pol.po_header_id||' - '||pol.po_line_id group_by_lineid
,        rct.transaction_id rct_id
,        pol.item_id
from     po_distributions_all           pod
,        po_line_locations_all          pll
,(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
gl.name ledger,
hou.name operating_unit,
fc.precision,
nvl(fc.extended_precision,fc.precision) extended_precision
from
po_lines_all pla,
hr_operating_units hou,
gl_ledgers gl,
fnd_currencies fc
where
2=2 and
pla.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code
) pol
,        po_headers_all                 poh
,        po_releases_all                por
,        rcv_transactions           rct 
,        rcv_shipment_headers       rsh
,        ap_suppliers                 pov
,        mtl_system_items           msi
,        mtl_categories             mca
,        hr_locations_no_join       hrl
,        per_all_people_f           papf
,        mtl_parameters             mp
&p_from_wip
where
3=3
and      rct.shipment_header_id     = rsh.shipment_header_id
and      rct.po_line_id             = pol.po_line_id
and      rct.po_header_id           = poh.po_header_id
and      rct.po_line_location_id    = pll.line_location_id
and      pod.line_location_id       = pll.line_location_id
and     pod.po_distribution_id   = rct.po_distribution_id
and      pod.destination_type_code  = 'SHOP FLOOR'
and      pll.po_release_id          = por.po_release_id(+)
and      pol.item_id                = msi.inventory_item_id(+)
and      pol.inventory_organization_id = msi.organization_id(+)
and      pol.category_id            = mca.category_id
and      rsh.vendor_id              = poh.vendor_id
and      poh.vendor_id              = pov.vendor_id
and      papf.person_id            = poh.agent_id
and (papf.employee_number is not null or papf.npw_number is not null) 
and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
and decode(hr_security.view_all ,'Y' , 'TRUE', 
hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id, papf.person_type_id,
papf.employee_number,papf.applicant_number )) = 'TRUE' 
and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id ,
hr_general.get_business_group_id) = papf.business_group_id
and      pod.deliver_to_location_id = hrl.location_id(+) 
&p_vendor_name_where
&p_where_wip
and mp.organization_id = rct.organization_id
and mp.process_enabled_flag='N'
union all
select
         fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', MCA.STRUCTURE_ID, NULL, MCA.CATEGORY_ID, 'ALL', 'Y', 'VALUE') category
,        fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, MSI.ORGANIZATION_ID, MSI.INVENTORY_ITEM_ID, 'ALL', 'Y', 'VALUE') item
,        msi.description                           description
,        pov.vendor_name                           vendor
,        decode(poh.type_lookup_code,
                'BLANKET',
                poh.segment1||' - '||por.release_num,
                'PLANNED',
                poh.segment1||' - '||por.release_num,
                poh.segment1)                      po_number_release
,        poh.currency_code                         currency
,        papf.full_name                             buyer
,        pol.line_num                              line
,        rsh.shipment_num                          shipment
,        rct.transaction_date                      receipt_date
,        rsh.receipt_num                    receipt_number
,       round(decode(rct.transaction_type , 'RETURN TO RECEIVING'  , rct.primary_quantity * -1 ,
           'RETURN TO  VENDOR',rct.primary_quantity * -1, rct.primary_quantity) , :p_qty_precision) quantity_received
,        rct.primary_unit_of_measure                       unit
,        rct.po_unit_price  * (rct.source_doc_quantity / rct.primary_quantity ) + 
       ((nvl(pod.nonrecoverable_tax,0)/decode (pod.quantity_ordered,0,1, pod.quantity_ordered) )*(rct.source_doc_quantity/rct.primary_quantity))         unit_price
,        round(nvl(rct.currency_conversion_rate,1) * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) + 
          (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/decode (pod.quantity_ordered,0,1, pod.quantity_ordered) )
          *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision)               po_functional_price
,       0  std_unit_cost 
,        0 moh_absorbed_per_unit
,        mp.process_enabled_flag 
,        mp.organization_code
,    po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pol.item_id, 
                                 decode(mp.process_enabled_flag, 'Y', rct.organization_id, pol.inventory_organization_id), 
                                  rct.transaction_date, 
                                  mp.process_enabled_flag, 0 , pol.extended_precision) std_unit_cost_f
,    po_poxrcppv_xmlp_pkg.c_price_varianceformula( round(nvl(rct.currency_conversion_rate,1)  * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) + 
                                              (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/decode (pod.quantity_ordered,0,1,pod.quantity_ordered))
                                              *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision), 
                                   po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pol.item_id, 
                                        decode(mp.process_enabled_flag, 'Y', rct.organization_id, pol.inventory_organization_id),
                                        rct.transaction_date, mp.process_enabled_flag, 0, pol.extended_precision), 
                                   0, 
                                   round(decode(rct.transaction_type,'RETURN TO RECEIVING', rct.primary_quantity * -1,rct.primary_quantity), :p_qty_precision), 
                                   pol.precision) c_price_variance
,pol.ledger
,pol.operating_unit
,        pol.po_header_id||' - '||pol.po_line_id group_by_lineid
,        rct.transaction_id rct_id
,        pol.item_id 
from     po_distributions_all           pod
,        po_line_locations_all          pll
,(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
gl.name ledger,
hou.name operating_unit,
fc.precision,
nvl(fc.extended_precision,fc.precision) extended_precision
from
po_lines_all pla,
hr_operating_units hou,
gl_ledgers gl,
fnd_currencies fc
where
2=2 and
pla.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code
) pol
,        po_headers_all                 poh
,        po_releases_all                por
,        rcv_shipment_headers       rsh
,        rcv_transactions           rct 
,        ap_suppliers                 pov
,        mtl_system_items           msi
,        mtl_categories             mca
,        hr_locations_no_join       hrl
,        per_all_people_f            papf
,        mtl_parameters            mp
where 
3=3
and      rct.shipment_header_id     = rsh.shipment_header_id
and      rct.po_line_id             = pol.po_line_id
and      rct.po_header_id           = poh.po_header_id 
and      rct.po_line_location_id    = pll.line_location_id
and      rct.po_distribution_id = pod.po_distribution_id
and      pod.line_location_id       = pll.line_location_id
and      (nvl(pll.lcm_flag,'N')    = 'N'
          or 
          ( nvl(pll.lcm_flag,'N')    = 'Y' and rct.lcm_shipment_line_id is null )
         )
and      pod.destination_type_code  in ('INVENTORY','SHOP FLOOR')
and      rct.destination_type_code <> 'RECEIVING' 
and      pll.po_release_id          = por.po_release_id(+)
and      pol.item_id                = msi.inventory_item_id(+)
and      pol.inventory_organization_id = msi.organization_id(+)
and      pol.category_id            = mca.category_id
and      rsh.vendor_id              = poh.vendor_id
and      poh.vendor_id              = pov.vendor_id
and      papf.person_id            = poh.agent_id
and (papf.employee_number is not null or papf.npw_number is not null) 
and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
and decode(hr_security.view_all ,'Y' , 'TRUE', 
hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id, papf.person_type_id,
papf.employee_number,papf.applicant_number )) = 'TRUE' 
and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id ,
hr_general.get_business_group_id) = papf.business_group_id 
and      pod.deliver_to_location_id = hrl.location_id(+) 
&p_vendor_name_where  
and       rct.organization_id = mp.organization_id
and      mp.process_enabled_flag = 'Y'
union all
/* lcm-opm integration added below query  bug 8642337, pmarada */
select  distinct
          fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', MCA.STRUCTURE_ID, NULL, MCA.CATEGORY_ID, 'ALL', 'Y', 'VALUE') category
 ,        fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, MSI.ORGANIZATION_ID, MSI.INVENTORY_ITEM_ID, 'ALL', 'Y', 'VALUE') item    
 ,        msi.description                          description     
 ,        pov.vendor_name                          vendor     
 ,        decode(poh.type_lookup_code,     
                 'BLANKET',     
                 poh.segment1||' - '||por.release_num,     
                 'PLANNED',     
                 poh.segment1||' - '||por.release_num,     
                 poh.segment1)                     po_number_release     
 ,        poh.currency_code                        currency     
 ,        papf.full_name                           buyer     
 ,        pol.line_num                             line       
 ,        rsh.shipment_num                         shipment     
 ,        glat.transaction_date                    receipt_date     
 ,        rsh.receipt_num                          receipt_number     
 ,        round(glat.primary_quantity,:p_qty_precision)     quantity_received     
 ,        glat.primary_uom_code                    unit     
 ,        rct.po_unit_price  * (rct.source_doc_quantity / rct.primary_quantity) + 
             ((nvl(pod.nonrecoverable_tax,0)/pod.quantity_ordered)*(rct.source_doc_quantity/rct.primary_quantity)) unit_price
,        round(nvl(rct.currency_conversion_rate,1) * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) + 
          (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/pod.quantity_ordered)
          *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision)               po_functional_price
,        0 std_unit_cost 
,        0 moh_absorbed_per_unit
,        mp.process_enabled_flag
,        mp.organization_code
,       po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pol.item_id, 
                                 decode(mp.process_enabled_flag, 'Y', rct.organization_id, pol.inventory_organization_id), 
                                  rct.transaction_date, 
                                  mp.process_enabled_flag, 0 , pol.extended_precision) std_unit_cost_f
,    po_poxrcppv_xmlp_pkg.c_price_varianceformula( round(nvl(rct.currency_conversion_rate,1)  * nvl(rct.po_unit_price* (rct.source_doc_quantity / rct.primary_quantity),0) + 
                                              (( (nvl(pod.nonrecoverable_tax,0) * nvl(rct.currency_conversion_rate,1))/decode (pod.quantity_ordered,0,1,pod.quantity_ordered))
                                              *(rct.source_doc_quantity/rct.primary_quantity)), pol.extended_precision), 
                                   po_poxrcppv_xmlp_pkg.std_unit_cost_fformula(pol.item_id, 
                                        decode(mp.process_enabled_flag, 'Y', rct.organization_id, pol.inventory_organization_id),
                                        rct.transaction_date, mp.process_enabled_flag, 0, pol.extended_precision), 
                                   0, 
                                   round(decode(rct.transaction_type,'RETURN TO RECEIVING', rct.primary_quantity * -1,rct.primary_quantity), :p_qty_precision), 
                                   pol.precision) c_price_variance
,pol.ledger
,pol.operating_unit
,        pol.po_header_id||' - '||pol.po_line_id group_by_lineid
,        rct.transaction_id rct_id
,        pol.item_id
 from    
          po_distributions_all           pod
 ,        po_line_locations_all          pll     
,(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
gl.name ledger,
hou.name operating_unit,
fc.precision,
nvl(fc.extended_precision,fc.precision) extended_precision
from
po_lines_all pla,
hr_operating_units hou,
gl_ledgers gl,
fnd_currencies fc
where
2=2 and
pla.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code
) pol     
 ,        po_headers_all                 poh     
 ,        po_releases_all                por     
 ,        gmf_lc_adj_transactions    glat
 ,        mtl_parameters             mp     
 ,        rcv_shipment_headers       rsh     
 ,        rcv_transactions           rct      
 ,        ap_suppliers                 pov     
 ,        mtl_system_items           msi     
 ,        mtl_categories             mca     
 ,        per_all_people_f             papf     
 where
3=3  and
4=4
 and      glat.rcv_transaction_id  = rct.transaction_id     
 and      glat.event_type          in (16,17)
 and      mp.organization_id       = glat.organization_id     
 and      mp.process_enabled_flag  = 'Y'
 and      rct.shipment_header_id    = rsh.shipment_header_id     
 and      rct.po_line_id            = pol.po_line_id     
 and      rct.po_header_id          = poh.po_header_id      
 and      rct.po_line_location_id   = pll.line_location_id     
 and      nvl(pll.lcm_flag,'N')    = 'Y' 
 and      rct.po_distribution_id   = pod.po_distribution_id
 and      pll.po_release_id        = por.po_release_id(+)     
 and      pod.destination_type_code in ('INVENTORY')
 and      rct.destination_type_code <> 'RECEIVING' 
 and      pol.item_id              = msi.inventory_item_id(+)     
 and      pol.inventory_organization_id = msi.organization_id(+)     
 and      pol.category_id          = mca.category_id           
 and rsh.vendor_id            = pov.vendor_id
 and      papf.person_id           = poh.agent_id
 and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date     
 and decode(hr_security.view_all ,'Y' , 'TRUE',      
 hr_security.show_record('PER_ALL_PEOPLE_F',papf.person_id, papf.person_type_id,     
 papf.employee_number,papf.applicant_number )) = 'TRUE'      
 and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id ,     
 hr_general.get_business_group_id) = papf.business_group_id     
 &p_vendor_name_where