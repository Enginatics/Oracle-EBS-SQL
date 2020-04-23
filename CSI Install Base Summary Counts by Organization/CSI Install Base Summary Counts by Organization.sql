/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Install Base Summary Counts by Organization
-- Excel Examle Output: https://www.enginatics.com/example/csi-install-base-summary-counts-by-organization/
-- Library Link: https://www.enginatics.com/reports/csi-install-base-summary-counts-by-organization/
-- Run Report: https://demo.enginatics.com/

select
count (*) count,
x.type,
xxen_util.meaning(x.instance_usage_code,'CSI_INSTANCE_USAGE_CODE',542) parent_instance_usage,
x.sold_from_operating_unit,
x.owner_operating_unit,
x.inventory_org,
x.last_validation_org,
x.inventory_master_org
from (
select
nvl2(cir.object_id,'Child','Parent') type,
nvl(cii0.instance_usage_code,cii.instance_usage_code) instance_usage_code,
haou.name sold_from_operating_unit,
(
select
haou2.name
from
hz_cust_accounts hca,
hz_cust_acct_sites_all hcasa,
hz_cust_site_uses_all hcsua,
hr_all_organization_units haou2
where
cii.owner_party_id=hca.party_id and
hca.cust_account_id=hcasa.cust_account_id and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id and
hcsua.site_use_code='BILL_TO' and
hcsua.org_id=haou2.organization_id and
rownum=1
) owner_operating_unit,
haou3.name inventory_org,
haou4.name last_validation_org,
haou5.name inventory_master_org
from
csi_item_instances cii,
(
select
cir.object_id,
connect_by_root cir.subject_id root_subject_id,
connect_by_isleaf
from
(select cir.* from csi_ii_relationships cir where sysdate between cir.active_start_date and nvl(cir.active_end_date,sysdate) and cir.relationship_type_code='COMPONENT-OF') cir
where
connect_by_isleaf=1
connect by prior cir.object_id=cir.subject_id
) cir,
csi_item_instances cii0,
hz_parties hp,
(select cioa.* from csi_i_org_assignments cioa where cioa.relationship_type_code='SOLD_FROM' and sysdate between nvl(cioa.active_start_date,sysdate) and nvl(cioa.active_end_date,sysdate)) cioa,
hr_all_organization_units haou,
fnd_user fu,
hr_all_organization_units haou3,
hr_all_organization_units haou4,
hr_all_organization_units haou5
where
cii.owner_party_id=hp.party_id(+) and
cii.instance_id=cioa.instance_id(+) and
cioa.operating_unit_id=haou.organization_id(+) and
cii.created_by=fu.user_id and
cii.inv_organization_id=haou3.organization_id(+) and
cii.last_vld_organization_id=haou4.organization_id(+) and
cii.inv_master_organization_id=haou5.organization_id and
cii.instance_id=cir.root_subject_id(+) and
cir.object_id=cii0.instance_id(+)
) x
group by
x.type,
xxen_util.meaning(x.instance_usage_code,'CSI_INSTANCE_USAGE_CODE',542),
x.sold_from_operating_unit,
x.owner_operating_unit,
x.inventory_org,
x.last_validation_org,
x.inventory_master_org
order by
count (*) desc