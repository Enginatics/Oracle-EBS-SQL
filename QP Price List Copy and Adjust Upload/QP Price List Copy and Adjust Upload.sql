/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Price List Copy and Adjust Upload
-- Description: Copies price lists and adjusts their prices, one row per price list, as the Copy Price List and Adjust Price List windows of Advanced Pricing do.
-- Upload Mode Create, Update downloads the selected price lists; Create gives an empty sheet to paste rows into.
-- Enter a New Price List to copy the row's price list with its qualifiers and the lines active today. Adjust By and Adjust Value then change the prices of the new list, or of the row's own list when no New Price List is entered.
-- Standard and agreement price lists can be copied, and the copy keeps the type of its source. A copied agreement price list gets no qualifiers and is not attached to an agreement. Prices can be adjusted on standard price lists only, as in the Adjust Price Lists window.
-- Change Effective To to end-date the row's price list, for example the day before the new list starts. Only a price list without an end date can be end-dated: an existing end date cannot be changed or removed, and a blank Effective To leaves the price list unchanged.
-- Item From, Item To and Category limit both the copy and the adjustment; Adjust Item Status and Adjust Creation Date limit the adjustment only. With any of these filters only lines priced by item number are copied or adjusted; lines priced by item category or all items are left out.
-- The copy and the adjustment are saved as soon as they run. A row that fails afterwards keeps the new price list and its message says so: adjust the new list in a separate row instead of uploading the row again.
-- Excel Example Output: https://www.enginatics.com/example/qp-price-list-copy-and-adjust-upload/
-- Library Link: https://www.enginatics.com/reports/qp-price-list-copy-and-adjust-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
qslhv.name price_list,
qslhv.currency_code currency,
qslhv.description,
qslhv.start_date_active effective_from,
qslhv.end_date_active effective_to,
to_char(null) item_from,
to_char(null) item_to,
to_char(null) category_set,
to_char(null) category,
to_char(null) include_discounts,
to_char(null) retain_effective_dates,
to_char(null) new_price_list,
to_char(null) new_description,
to_date(null) new_effective_from,
to_date(null) new_effective_to,
xxen_util.yes(decode(hou.organization_id,null,'Y')) new_global,
hou.name new_operating_unit,
to_char(null) adjust_item_status,
to_date(null) adjust_creation_date,
xxen_util.meaning('%','ARITHMETIC_OPERATOR',661) adjust_by,
to_number(null) adjust_value,
null upload_row
from
qp_secu_list_headers_vl qslhv,
(select hou.organization_id, hou.name from hr_operating_units hou where hou.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU')) hou
where
:p_upload_mode like '%'||xxen_upload.action_update and
1=1 and
qslhv.list_type_code in ('PRL','AGR') and
nvl(qslhv.pte_code,'ORDFUL')<>'LOGSTX' and
nvl(qslhv.list_source_code,'X')<>'BSO' and
qslhv.view_flag='Y' and
nvl(fnd_profile.value('QP_PRICING_TRANSACTION_ENTITY'),'QP')=nvl(qslhv.pte_code,'QP') and
qslhv.orig_org_id=hou.organization_id(+)
