/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Organization Hierarchy
-- Description: Master data report showing hierarchical list of human resource organization structures including subordinate orgs.
-- Excel Examle Output: https://www.enginatics.com/example/per-organization-hierarchy/
-- Library Link: https://www.enginatics.com/reports/per-organization-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
pbg.name business_group,
pos.name hierarchy_name,
x.top_level_org,
x.level_,
x.org_path,
x.child_org,
(select 'OU' from hr_organization_information hoi where x.child_org_id=hoi.organization_id and hoi.org_information1='OPERATING_UNIT' and hoi.org_information_context='CLASS' and hoi.org_information2='Y') ou,
(select 'INV' from hr_organization_information hoi where x.child_org_id=hoi.organization_id and hoi.org_information1='INV' and hoi.org_information_context='CLASS' and hoi.org_information2='Y') inv,
(
select distinct
listagg(xxen_util.meaning(hoi.org_information1,'ORG_CLASS',3),', ') within group (order by xxen_util.meaning(hoi.org_information1,'ORG_CLASS',3)) over (partition by hoi.organization_id) classification
from
hr_organization_information hoi
where
x.child_org_id=hoi.organization_id and
hoi.org_information_context='CLASS' and
hoi.org_information2='Y'
) classification,
posv.version_number hierarchy_version,
posv.date_from,
posv.date_to,
x.child_org_id,
pos.business_group_id,
posv.org_structure_version_id
from
per_organization_structures pos,
per_org_structure_versions posv,
(
select
pose.org_structure_version_id,
connect_by_root haouv1.name top_level_org,
lpad(' ',2*level)||level level_,
lpad(' ',4*(level-1))||haouv2.name org_path,
haouv2.name child_org,
pose.organization_id_child child_org_id
from
hr_all_organization_units_vl haouv1,
per_org_structure_elements pose,
hr_all_organization_units_vl haouv2
where
pose.organization_id_parent=haouv1.organization_id and
pose.organization_id_child=haouv2.organization_id
start with (pose.organization_id_parent, pose.org_structure_version_id) in
(select pose0.organization_id_parent, pose0.org_structure_version_id from per_org_structure_elements pose0 where not exists (select null from per_org_structure_elements pose2 where pose0.organization_id_parent=pose2.organization_id_child and pose0.org_structure_version_id=pose2.org_structure_version_id))
connect by nocycle
prior pose.organization_id_child=pose.organization_id_parent and
prior pose.org_structure_version_id=pose.org_structure_version_id
order siblings by pose.org_structure_version_id, haouv2.name
) x,
per_business_groups pbg
where
1=1 and
pos.organization_structure_id=posv.organization_structure_id and
sysdate between posv.date_from and nvl(posv.date_to,sysdate) and
posv.org_structure_version_id=x.org_structure_version_id and
pos.business_group_id=pbg.business_group_id(+)