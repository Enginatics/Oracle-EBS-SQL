/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Modifier Copy Upload
-- Description: Copies modifier lists, one row per modifier list, as the Copy Modifier List window of Advanced Pricing (Modifiers > Copy) does.
-- Upload Mode Create, Update downloads the selected modifier lists; Create gives an empty sheet to paste rows into.
-- Enter a New Modifier Number and New Modifier Name to copy the row's modifier list with its qualifiers and the lines active today. The copy keeps the type and version of its source.
-- A list number can exist in several versions. List Version then selects the modifier list, and a row without it is rejected.
-- Change List Effective To to end-date the row's modifier list, for example the day before the new list starts. Only a modifier list without an end date can be end-dated: an existing end date cannot be changed or removed, and a blank List Effective To leaves the modifier list unchanged.
-- The copy is saved as soon as it runs. A row that fails afterwards keeps the new modifier list and its message says so: end-date the source in a separate row instead of uploading the row again.
-- Excel Example Output: https://www.enginatics.com/example/qp-modifier-copy-upload/
-- Library Link: https://www.enginatics.com/reports/qp-modifier-copy-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.currency_code list_currency,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
to_char(null) retain_effective_dates,
to_char(null) new_modifier_number,
to_char(null) new_modifier_name,
to_date(null) new_effective_from,
to_date(null) new_effective_to,
xxen_util.yes(decode(hou.organization_id,null,'Y')) new_global_list,
hou.name new_operating_unit,
null upload_row
from
qp_secu_list_headers_vl qslhv,
(select hou.organization_id, hou.name from hr_operating_units hou where hou.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU')) hou
where
:p_upload_mode like '%'||xxen_upload.action_update and
1=1 and
qslhv.list_type_code in ('DLT','DEL','CHARGES','PRO','SLT') and
nvl(qslhv.pte_code,'ORDFUL')<>'LOGSTX' and
nvl(qslhv.list_source_code,'X')<>'BSO' and
qslhv.view_flag='Y' and
nvl(fnd_profile.value('QP_PRICING_TRANSACTION_ENTITY'),'QP')=nvl(qslhv.pte_code,'QP') and
qslhv.orig_org_id=hou.organization_id(+)
