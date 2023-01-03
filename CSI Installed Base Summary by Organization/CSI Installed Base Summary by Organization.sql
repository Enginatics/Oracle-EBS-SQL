/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CSI Installed Base Summary by Organization
-- Description: Count of installed base products by hierarchy type (parent / child), instance usage and related organizations, such as sold from and owner operating unit, last validation and master inventory organization
-- Excel Examle Output: https://www.enginatics.com/example/csi-installed-base-summary-by-organization/
-- Library Link: https://www.enginatics.com/reports/csi-installed-base-summary-by-organization/
-- Run Report: https://demo.enginatics.com/

select
count (*) count,
x.type,
xxen_util.meaning(x.instance_usage_code,'CSI_INSTANCE_USAGE_CODE',542) parent_instance_usage,
&status_column
x.sold_from_operating_unit,
x.owner_operating_unit,
x.inventory_org,
x.last_validation_org,
x.inventory_master_org
from (
select
nvl2(cir.object_id,'Child','Parent') type,
nvl(cii0.instance_usage_code,cii.instance_usage_code) instance_usage_code,
cis.name status,
haouv.name sold_from_operating_unit,
(
select
haouv2.name
from
hz_cust_accounts hca,
hz_cust_acct_sites_all hcasa,
hz_cust_site_uses_all hcsua,
hr_all_organization_units_vl haouv2
where
cii.owner_party_id=hca.party_id and
hca.cust_account_id=hcasa.cust_account_id and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id and
hcsua.site_use_code='BILL_TO' and
hcsua.org_id=haouv2.organization_id and
rownum=1
) owner_operating_unit,
haouv3.name inventory_org,
haouv4.name last_validation_org,
haouv5.name inventory_master_org
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
hr_all_organization_units_vl haouv,
fnd_user fu,
hr_all_organization_units_vl haouv3,
hr_all_organization_units_vl haouv4,
hr_all_organization_units_vl haouv5,
csi_instance_statuses cis
where
cii.owner_party_id=hp.party_id(+) and
cii.instance_id=cioa.instance_id(+) and
cioa.operating_unit_id=haouv.organization_id(+) and
cii.created_by=fu.user_id and
cii.inv_organization_id=haouv3.organization_id(+) and
cii.last_vld_organization_id=haouv4.organization_id(+) and
cii.inv_master_organization_id=haouv5.organization_id and
cii.instance_id=cir.root_subject_id(+) and
cir.object_id=cii0.instance_id(+) and
cii.instance_status_id=cis.instance_status_id(+)
) x
group by
x.type,
xxen_util.meaning(x.instance_usage_code,'CSI_INSTANCE_USAGE_CODE',542),
&status_column
x.sold_from_operating_unit,
x.owner_operating_unit,
x.inventory_org,
x.last_validation_org,
x.inventory_master_org
order by
count (*) desc