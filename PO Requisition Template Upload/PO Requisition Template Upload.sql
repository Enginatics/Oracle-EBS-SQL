/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Requisition Template Upload
-- Description: PO Requisition Template Upload
================================

The purpose of the PO Requisition Template Upload is to allow for: 
- the creation of new Requisition Templates (Create Mode).
- the update of existing Requisition Templates (Update Mode). Update includes the update to existing template and template lines, the creation of new template lines against an existing template, and the deletion of template lines from an existing template.

As far as feasible, the upload provides the user with the same functionality available in the ‘Requisition Template’ Form. (Purchasing:  + Setup – Purchasing – Requisition Templates)

Upload Mode
============

The upload mode determines the actions the user is allowed to perform in the upload.

Create - the user may upload new Requisition Templates only.

Update - the user may update existing Requisition Templates only. This includes adding new and deleting existing template lines from the template.

Create and Update - the user can create new Requisition Templates and update existing Requisition Templates.


Parameters
==========

Upload Mode	(Required=Yes Default=Create) - See above.

The following optional parameters are only applicable in the 'Create and Update' and 'Update' modes, and can be used to restrict the template data downloaded for update:

- Operating Unit - the operating unit(s) the templates belong to.
- Template Type - the template type (Purchase Requisition, Internal Requisition).
- Template Name - the template name(s) to be downloaded.
- Template Name Contains - the user can restrict the download of existing templates where the Template Name contains the specified text (case insensitive).

-- Excel Examle Output: https://www.enginatics.com/example/po-requisition-template-upload/
-- Library Link: https://www.enginatics.com/reports/po-requisition-template-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
null action_,
null status_,
null message_,
null request_id_,
rowidtochar(prha.rowid) header_row_id,
rowidtochar(prla.line_row_id) line_row_id,
to_char(null) delete_this_line,
to_char(null) pre_delete_template_lines,
:p_upload_mode upload_mode,
to_char(null) publish_template_to_icx,
-- header
haouv.name operating_unit,
prha.express_name template_name,
prha.description template_description,
podt.type_name type,
prha.inactive_date inactive_date,
xxen_util.meaning(prha.reserve_po_number,'RESERVE PO NUM',201) reserve_po_number,
-- lines
prla.sequence_num line_number,
plt.line_type,
nvl2(prla.item_id,msiv.concatenated_segments,null) item,
prla.item_revision,
mck.concatenated_segments category,
prla.item_description line_description,
muomv.unit_of_measure_tl uom,
prla.suggested_quantity,
prla.unit_price,
prla.amount,
xxen_util.meaning(prla.source_type_code,'REQUISITION SOURCE TYPE',201) source_type,
po_inq_sv.get_person_name(prla.suggested_buyer_id) buyer,
asu.vendor_name supplier,
assa.vendor_site_code supplier_site,
decode(asco.last_name,null,null, asco.last_name||', '|| asco.first_name) supplier_contact,
prla.suggested_vendor_product_code supplier_item,
ood.organization_code source_organization,
prla.source_subinventory,
decode(prla.negotiated_by_preparer_flag,'Y',xxen_util.meaning(prla.rfq_required_flag,'YES_NO',0),null) negotiated,
decode(prla.rfq_required_flag,'Y',xxen_util.meaning(prla.rfq_required_flag,'YES_NO',0),null) rfq_required,
--
xxen_util.user_name(prha.last_updated_by) template_last_updated_by,
prha.last_update_date template_last_updated_on,
xxen_util.user_name(prla.last_updated_by) line_last_updated_by,
prla.last_update_date line_last_updated_on,
xxen_util.user_name(prha.created_by) template_created_by,
prha.creation_date template_created_on,
xxen_util.user_name(prla.created_by) line_created_by,
prla.creation_date line_created_on
--
from
po_reqexpress_headers_all prha,
(select
  fspa.inventory_organization_id,
  prla.rowid line_row_id,
  prla.*
 from
  po_reqexpress_lines_all prla,
  financials_system_params_all fspa
 where
  prla.org_id = fspa.org_id
) prla,
hr_all_organization_units_vl haouv,
po_line_types plt,
po_document_types_all_tl podt,
mtl_system_items_vl msiv,
mtl_categories_kfv mck,
mtl_units_of_measure_vl muomv,
org_organization_definitions ood,
ap_suppliers asu,
ap_supplier_sites_all assa,
ap_supplier_contacts asco
where
1=1 and
nvl(:p_publish_template_to_icx,'N')=nvl(:p_publish_template_to_icx,'N') and
nvl(:p_pre_delete_template_lines,'N')=nvl(:p_pre_delete_template_lines,'N') and
prha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
prha.org_id = haouv.organization_id and
prha.type_lookup_code = podt.document_subtype and
prha.org_id = podt.org_id and
podt.document_type_code = 'REQUISITION' and
podt.language = userenv ('LANG') and
prha.express_name = prla.express_name (+) and
prha.org_id = prla.org_id (+) and
prla.line_type_id = plt.line_type_id (+) and
prla.item_id = msiv.inventory_item_id (+) and
prla.inventory_organization_id = msiv.organization_id (+) and
prla.category_id = mck.category_id (+) and
prla.unit_meas_lookup_code = muomv.unit_of_measure (+) and
prla.source_organization_id = ood.organization_id (+) and
prla.suggested_vendor_id = asu.vendor_id (+) and
prla.suggested_vendor_site_id = assa.vendor_site_id (+) and
prla.suggested_vendor_contact_id = asco.vendor_contact_id (+) and
prla.suggested_vendor_site_id = asco.vendor_site_id (+) and
not exists -- exclude templates copied from a Blanket PO
(select 
  null
 from 
  po_reqexpress_lines_all prla2
 where
  prla2.org_id = prha.org_id and
  prla2.express_name = prha.express_name and
  prla2.po_line_id is not null
) 
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
operating_unit,
template_name,
line_number