/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Ledgers and Organizations
-- Description: GL Ledgers with Ledger Sets, Chart of Accounts, Operating Units, Inventory Organizations and related Legal Entities
-- Excel Examle Output: https://www.enginatics.com/example/gl-ledgers-and-organizations/
-- Library Link: https://www.enginatics.com/reports/gl-ledgers-and-organizations/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
(
select distinct
listagg(gl0.name,', ') within group (order by gl0.name) over (partition by glsna.ledger_id) ledger_set
from
gl_ledger_set_norm_assign glsna,
gl_ledgers gl0
where
gl.ledger_id=glsna.ledger_id and
nvl(glsna.status_code,'X')<>'D' and
glsna.ledger_set_id=gl0.ledger_id
) ledger_set,
gl.name ledger,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
gl.currency_code currency,
fifsv.id_flex_structure_name chart_of_accounts_name,
hou.name operating_unit,
ood.organization_code,
ood.organization_name organization,
ftv.territory_short_name country,
xep.name legal_entity,
gl.ledger_id,
fifsv.id_flex_structure_code chart_of_accounts_code,
gl.chart_of_accounts_id,
ood.operating_unit operating_unit_id,
ood.organization_id
from
gl_ledgers gl,
fnd_id_flex_structures_vl fifsv,
hr_operating_units hou,
hr_all_organization_units_vl haouv,
org_organization_definitions ood,
hr_all_organization_units haou,
hr_locations_all hla,
fnd_territories_vl ftv,
xle_entity_profiles xep
where
nvl(ood.disable_date,sysdate)>=sysdate and
nvl(hou.date_to,sysdate)>=sysdate and
1=1 and
gl.object_type_code='L' and
gl.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.application_id=101 and
fifsv.id_flex_code='GL#' and
gl.ledger_id=hou.set_of_books_id(+) and
hou.business_group_id=haouv.organization_id(+) and
hou.organization_id=ood.operating_unit(+) and
ood.organization_id=haou.organization_id(+) and
haou.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
ood.legal_entity=xep.legal_entity_id(+)
order by
chart_of_accounts_name,
ledger_set,
business_group,
ledger,
currency,
operating_unit,
country,
organization_code