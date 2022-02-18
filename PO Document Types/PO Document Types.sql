/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Document Types
-- Description: PO document types setup
-- Excel Examle Output: https://www.enginatics.com/example/po-document-types/
-- Library Link: https://www.enginatics.com/reports/po-document-types/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
xxen_util.meaning(pdtav.document_type_code,'DOCUMENT TYPE',201)||' '||flv2.meaning type,
pdtav.type_name name,
xtv1.template_name document_types_layout,
xtv2.template_name contract_terms_layout,
decode(pdtav.can_preparer_approve_flag,'Y','Yes','N','No') can_preparer_approve,
initcap(pdtav.security_level_code) security_level,
pdtav.document_type_code,
pdtav.document_subtype,
decode(pdtav.document_type_code,
'RFQ',decode(pdtav.document_subtype,'STANDARD','DeleteDisabled','CATALOG','DeleteDisabled','BID','DeleteDisabled','DeleteEnabled'),
'QUOTATION',decode(pdtav.document_subtype,'STANDARD','DeleteDisabled','CATALOG','DeleteDisabled','BID','DeleteDisabled','DeleteEnabled'),
'DeleteDisabled'
) delete_switcher
from
hr_all_organization_units_vl haouv,
po_document_types_all_vl pdtav,
fnd_lookup_values flv2,
xdo_templates_vl xtv1,
xdo_templates_vl xtv2
where
1=1 and
haouv.organization_id=pdtav.org_id and
pdtav.document_subtype=flv2.lookup_code(+) and
flv2.lookup_type(+)=decode(pdtav.document_type_code,'REQUISITION','REQUISITION TYPE','RFQ','RFQ SUBTYPE','QUOTATION','QUOTATION SUBTYPE','DOCUMENT SUBTYPE') and
flv2.language(+)=userenv('lang') and
flv2.view_application_id(+)=201 and
flv2.security_group_id(+)=0 and
pdtav.document_template_code=xtv1.template_code(+) and
pdtav.contract_template_code=xtv2.template_code(+)
order by
haouv.name,
pdtav.document_type_code,
pdtav.type_name