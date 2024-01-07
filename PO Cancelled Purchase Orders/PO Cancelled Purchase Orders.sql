/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Cancelled Purchase Orders
-- Description: Application: Purchasing
Source: Cancelled Purchase Orders Report (XML)
Short Name: POXPOCAN_XML
DB package: PO_POXPOCAN_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/po-cancelled-purchase-orders/
-- Library Link: https://www.enginatics.com/reports/po-cancelled-purchase-orders/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.po_number,
x.release_number,
x.order_type,
x.vendor,
x.vendor_site,
x.order_date,
x.created_by,
x.order_amount,
x.currency,
x.buyer,
x.cancelled_date,
x.cancelled_by,
x.reason
 -- line
&lp_line_cols
from
(
select
 mgoat.organization_name operating_unit,
 poh.segment1 po_number,
 null release_number,
 flvv.description order_type,
 pov.vendor_name vendor,
 pvs.vendor_site_code vendor_site,
 trunc(poh.creation_date) order_date,
 nvl(papf3.full_name,fu.user_name || ' (' || fu.description || ')') created_by,
 poh.currency_code currency,
 sum(nvl(pll.quantity,0) * nvl(pll.price_override,0)) over (partition by poh.po_header_id) order_amount,
 papf2.full_name buyer,
 trunc(pah.action_date) cancelled_date,
 papf.full_name cancelled_by,
 pah.note reason,
 --
 &lp_line_po_cols
 --
 decode(psp.manual_po_num_type,'NUMERIC', null,poh.segment1) ord_sort_1,
 decode(psp.manual_po_num_type,'NUMERIC', to_number(poh.segment1), null) ord_sort_2
from
 po_headers_all poh,
 po_action_history pah,
 po_vendors pov,
 ap_supplier_sites_all pvs,
 fnd_user fu,
 per_all_people_f papf,
 per_all_people_f papf2,
 per_all_people_f papf3,
 po_system_parameters_all psp,
 mo_glob_org_access_tmp mgoat,
 fnd_lookup_values_vl flvv,
 --
 financials_system_params_all fspa,
 po_lines_all pol,
 po_line_locations_all pll,
 mtl_categories_kfv mc,
 mtl_system_items_vl msi
where
     1=1
 and 2=2
 and poh.cancel_flag = 'Y'
 and poh.org_id = psp.org_id
 and poh.org_id = fspa.org_id
 and poh.org_id = mgoat.organization_id
 and pov.vendor_id = poh.vendor_id
 and pvs.vendor_site_id = poh.vendor_site_id
 and (pah.object_revision_num,pah.sequence_num) =
  (select
    max(pah2.object_revision_num),
    max(pah2.sequence_num)
   from
    po_action_history pah2
   where
        4=4
    and pah2.object_type_code in ('PO','PA')
    and pah2.action_code in ('CANCEL','MASSCANCEL','RELEASE_MASSCANCEL')
    and poh.po_header_id = pah2.object_id
  )
 and pah.object_id = poh.po_header_id
 and pah.object_type_code in ('PO','PA')
 and pah.action_code in ( 'CANCEL','MASSCANCEL','RELEASE_MASSCANCEL')
 and papf.person_id(+) = pah.employee_id
 and papf2.person_id(+) = poh.agent_id
 and fu.user_id = poh.created_by
 and papf3.person_id(+) = fu.employee_id
 and flvv.lookup_type = 'PO TYPE'
 and flvv.view_application_id = 201
 and flvv.lookup_code = poh.type_lookup_code
 --
 and pol.po_header_id(+) = poh.po_header_id
 and pll.po_line_id(+) = pol.po_line_id
 and pll.po_release_id(+) is null
 and ( pll.shipment_type in ('STANDARD','PLANNED') or poh.type_lookup_code='BLANKET')
 and mc.category_id(+) = pol.category_id
 and msi.inventory_item_id(+) = pol.item_id
 and nvl(msi.organization_id,fspa.inventory_organization_id) = fspa.inventory_organization_id
 --
 and papf.employee_number (+) is not null
 and trunc(sysdate) between papf.effective_start_date (+)and papf.effective_end_date(+)
 and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id(+) , hr_general.get_business_group_id) = papf.business_group_id(+)
 and papf2.employee_number(+) is not null
 and trunc(sysdate) between papf2.effective_start_date (+) and papf2.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf2.business_group_id(+) , hr_general.get_business_group_id) = papf2.business_group_id(+)
 and papf3.employee_number(+) is not null
 and trunc(sysdate) between papf3.effective_start_date (+) and papf3.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf3.business_group_id(+) , hr_general.get_business_group_id) = papf3.business_group_id(+)
union
select
 mgoat.organization_name operating_unit,
 poh.segment1 po_number,
 por.release_num release_number,
 flvv.description order_type,
 pov.vendor_name vendor,
 pvs.vendor_site_code vendor_site,
 trunc(por.creation_date) order_date,
 nvl(papf3.full_name,fu.user_name || ' (' || fu.description || ')') created_by,
 poh.currency_code currency,
 sum(decode (pol.order_type_lookup_code, 'RATE', pll.amount, 'FIXED PRICE', pll.amount, nvl(pll.quantity, 0) * nvl(pll.price_override, 0))) over (partition by por.po_release_id) order_amount,
 papf2.full_name buyer,
 trunc(pah.action_date) cancelled_date,
 papf.full_name cancelled_by,
 pah.note reason,
 --
 &lp_line_rel_cols
 --
 decode(psp.manual_po_num_type,'NUMERIC', null,poh.segment1) ord_sort_1,
 decode(psp.manual_po_num_type,'NUMERIC', to_number(poh.segment1), null) ord_sort_2
from
 po_releases_all por,
 po_headers_all poh,
 ap_supplier_sites_all pvs,
 po_vendors pov,
 po_action_history pah,
 fnd_user fu,
 per_all_people_f papf,
 per_all_people_f papf2,
 per_all_people_f papf3,
 po_system_parameters_all psp,
 mo_glob_org_access_tmp mgoat,
 fnd_lookup_values_vl flvv,
 --
 financials_system_params_all fspa,
 po_line_locations_all pll,
 po_lines_all pol,
 mtl_categories_kfv mc,
 mtl_system_items_vl msi
where
     1=1
 and 3=3
 and por.cancel_flag = 'Y'
 and por.org_id = psp.org_id
 and poh.org_id = fspa.org_id
 and por.org_id = mgoat.organization_id
 and poh.po_header_id = por.po_header_id
 and pov.vendor_id = poh.vendor_id
 and pvs.vendor_site_id = poh.vendor_site_id
 and (pah.object_revision_num,pah.sequence_num) =
  (select
    max(pah2.object_revision_num),
    max(pah2.sequence_num)
   from
    po_action_history pah2
   where
        4=4
    and pah2.object_type_code in ('RELEASE')
    and pah2.action_code in ('CANCEL','MASSCANCEL','RELEASE_MASSCANCEL')
    and por.po_release_id = pah2.object_id
  )
 and pah.object_id = por.po_release_id
 and pah.object_type_code in ('RELEASE')
 and pah.action_code in ( 'CANCEL','MASSCANCEL','RELEASE_MASSCANCEL')
 and papf.person_id(+) = pah.employee_id
 and papf2.person_id(+) = por.agent_id
 and fu.user_id = por.created_by
 and papf3.person_id(+) = fu.employee_id
 and pll.shipment_type in ('BLANKET','SCHEDULED')
 and flvv.lookup_type = 'DOCUMENT'
 and flvv.view_application_id = 201
 and flvv.lookup_code = 'RELEASE'
 --
 and pll.po_release_id = por.po_release_id
 and pol.po_line_id = pll.po_line_id
 and mc.category_id(+) = pol.category_id
 and msi.inventory_item_id(+) = pol.item_id
 and nvl(msi.organization_id,fspa.inventory_organization_id) = fspa.inventory_organization_id
 --
 and trunc(sysdate) between papf.effective_start_date (+)and papf.effective_end_date(+)
 and decode(hr_general.get_xbg_profile,'Y', papf.business_group_id(+) , hr_general.get_business_group_id) = papf.business_group_id(+)
 and trunc(sysdate) between papf2.effective_start_date (+) and papf2.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf2.business_group_id(+) , hr_general.get_business_group_id) = papf2.business_group_id(+)
 and papf3.employee_number(+) is not null
 and trunc(sysdate) between papf3.effective_start_date (+) and papf3.effective_end_date (+)
 and decode(hr_general.get_xbg_profile,'Y', papf3.business_group_id(+) , hr_general.get_business_group_id) = papf3.business_group_id(+)
) x
order by
x.operating_unit,
x.ord_sort_1,
x.ord_sort_2,
x.release_number
&lp_line_sort