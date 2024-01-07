/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Customer Products Summary
-- Description: Imported Oracle standard Installed Base Customer Products Summary report
Source: CSI: Customer Products Summary Report (XML)
Short Name: CSICPREP_XML
DB package: CSI_CSICPREP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/csi-customer-products-summary/
-- Library Link: https://www.enginatics.com/reports/csi-customer-products-summary/
-- Run Report: https://demo.enginatics.com/

select
hca.account_number,
hp.party_name,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
cii.instance_number,
cii.serial_number,
cis.name status,
xxen_util.meaning(cii.instance_type_code,'CSI_INST_TYPE_CODE',542) instance_type,
cii.quantity,
cii.unit_of_measure,
cii.inventory_revision,
csv.name system,
ooha.order_number,
ooha.cust_po_number,
ftv.territory_short_name country,
hl.city,
hl.state,
hl.address1||nvl2(hl.address1,nvl2(hl.address2,', ',null),null)||hl.address2 install_address1,
hl.address3||nvl2(hl.address3,nvl2(hl.address4,', ',null),null)||hl.address4 install_address2,
hl.postal_code
from
csi_item_instances cii,
csi_instance_statuses cis,
mtl_system_items_vl msiv,
hz_cust_accounts hca,
hz_parties hp,
hz_party_sites hps,
hz_locations hl,
fnd_territories_vl ftv,
csi_systems_v csv,
oe_order_lines_all oola,
oe_order_headers_all ooha
where
1=1 and
cii.instance_status_id=cis.instance_status_id and
cii.inventory_item_id=msiv.inventory_item_id(+) and
cii.last_vld_organization_id=msiv.organization_id(+) and
cii.owner_party_account_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
cii.install_location_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftv.territory_code(+) and
cii.system_id=csv.system_id(+) and
cii.last_oe_order_line_id=oola.line_id(+) and
oola.header_id=ooha.header_id(+)
order by
hca.account_number,
msiv.concatenated_segments,
cii.instance_number