/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Customer Products Summary
-- Description: Imported Oracle standard Installed Base Customer Products Summary report
-- Source: CSI: Customer Products Summary Report (XML)
-- Short Name: CSICPREPXML
-- DB package: CSICSICPREPXMLPPKG
-- Owner Party is the owner of the instance, also for internal instances without an owner account. Parent Instance is the instance this one is an active component of.
-- Contract Number lists the service contracts with a covered product line in status Active for the instance. Contract Coverage restricts the report to instances with or without such coverage.
-- Show Parties adds one row per party and account role of the instance (owner, sold to, bill to, ship to, technical contact), repeating the instance columns on each row.
-- Excel Example Output: https://www.enginatics.com/example/csi-customer-products-summary/
-- Library Link: https://www.enginatics.com/reports/csi-customer-products-summary/
-- Run Report: https://demo.enginatics.com/

select
hca.account_number,
hp.party_name,
(select hp2.party_name from hz_parties hp2 where cii.owner_party_id=hp2.party_id) owner_party,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
cii.instance_number,
cii.serial_number,
cii.lot_number,
cis.name status,
xxen_util.meaning(cii.instance_type_code,'CSI_INST_TYPE_CODE',542) instance_type,
cii.quantity,
cii.unit_of_measure,
cii.inventory_revision,
csv.name system,
(select cii2.instance_number from csi_ii_relationships ciir, csi_item_instances cii2 where cii.instance_id=ciir.subject_id and ciir.relationship_type_code='COMPONENT-OF' and nvl(ciir.active_end_date,sysdate+1)>sysdate and ciir.object_id=cii2.instance_id) parent_instance,
cii.install_date,
cii.active_start_date,
cii.active_end_date,
ooha.order_number,
ooha.cust_po_number,
(
select
listagg(y.contract_number,', ') within group (order by y.contract_number)
from
(
select distinct
oki.object1_id1,
okhab.contract_number
from
okc_k_items oki,
okc_k_lines_b oklb,
okc_statuses_b osb,
okc_k_headers_all_b okhab
where
oki.jtot_object1_code='OKX_CUSTPROD' and
oki.cle_id=oklb.id and
oklb.sts_code=osb.code and
osb.ste_code='ACTIVE' and
oklb.dnz_chr_id=okhab.id
) y
where
to_char(cii.instance_id)=y.object1_id1
) contract_number,
xxen_util.meaning(cii.location_type_code,'CSI_INST_LOCATION_SOURCE_CODE',542) location_type,
case cii.location_type_code
when 'HZ_PARTY_SITES' then (select hl2.address1||nvl2(hl2.city,', '||hl2.city,null) from hz_party_sites hps2, hz_locations hl2 where cii.location_id=hps2.party_site_id and hps2.location_id=hl2.location_id)
when 'HZ_LOCATIONS' then (select hl2.address1||nvl2(hl2.city,', '||hl2.city,null) from hz_locations hl2 where cii.location_id=hl2.location_id)
when 'INTERNAL_SITE' then (select hla.location_code from hr_locations_all hla where cii.location_id=hla.location_id)
when 'INVENTORY' then (select mp.organization_code from mtl_parameters mp where cii.inv_organization_id=mp.organization_id)||nvl2(cii.inv_subinventory_name,' '||cii.inv_subinventory_name,null)
when 'WIP' then (select we.wip_entity_name from wip_entities we where cii.wip_job_id=we.wip_entity_id)
when 'PROJECT' then (select ppa.segment1 from pa_projects_all ppa where cii.pa_project_id=ppa.project_id)
end current_location,
ftv.territory_short_name country,
hl.city,
hl.state,
hl.address1||nvl2(hl.address1,nvl2(hl.address2,', ',null),null)||hl.address2 install_address1,
hl.address3||nvl2(hl.address3,nvl2(hl.address4,', ',null),null)||hl.address4 install_address2,
hl.postal_code
&party_columns
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
&party_from
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
&party_where
order by
hca.account_number,
msiv.concatenated_segments,
cii.instance_number
&party_order
