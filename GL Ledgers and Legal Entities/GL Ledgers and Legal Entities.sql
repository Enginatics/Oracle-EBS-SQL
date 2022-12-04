/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Ledgers and Legal Entities
-- Description: Master data report showing ledger set, ledger name, ledger category, currency, legal entity, and  balancing segment across all ledgers and legal entities.
-- Excel Examle Output: https://www.enginatics.com/example/gl-ledgers-and-legal-entities/
-- Library Link: https://www.enginatics.com/reports/gl-ledgers-and-legal-entities/
-- Run Report: https://demo.enginatics.com/

select
(
select distinct
listagg(gl0.name,', ') within group (order by gl0.name) over (partition by glsnav.ledger_id) ledger_set
from
gl_ledger_set_norm_assign_v glsnav,
gl_ledgers gl0
where
gl.ledger_id=glsnav.ledger_id and
glsnav.ledger_set_id=gl0.ledger_id
) ledger_set,
gl.name ledger,
xxen_util.meaning(gl.ledger_category_code,'GL_ASF_LEDGER_CATEGORY',101) ledger_category,
gl.currency_code currency,
xfi.name legal_entity,
xfi.legal_entity_identifier,
(
select distinct
listagg(gleb.flex_segment_value,', ') within group (order by gleb.flex_segment_value) over (partition by gleb.legal_entity_id) segment_value
from
gl_legal_entities_bsvs gleb
where
xfi.legal_entity_id=gleb.legal_entity_id
) balancing_segment_value,
(
select distinct
listagg(decode(ffvs.flex_value_set_id,null,gl_ledgers_pkg.get_bsv_desc('LE',gleb.flex_value_set_id,gleb.flex_segment_value),ffvs.description),', ') within group (order by gleb.flex_segment_value) over (partition by gleb.legal_entity_id) description
from
gl_legal_entities_bsvs gleb,
fnd_flex_values_vl ffvs
where
xfi.legal_entity_id=gleb.legal_entity_id and
gleb.flex_value_set_id=ffvs.flex_value_set_id(+) and
gleb.flex_segment_value=ffvs.flex_value(+)
) bsv_description,
xfi.registration_number,
ftv.territory_short_name country,
ftv.territory_short_name||nvl2(xfi.legislative_cat_code,' - '||xxen_util.meaning(xfi.legislative_cat_code,'LEGISLATIVE_CATEGORY',222),null) juristdiction,
xfi.address_line_1,
xfi.address_line_2,
xfi.address_line_3,
xfi.town_or_city city,
xfi.postal_code,
(select fifsv.id_flex_structure_name from fnd_id_flex_structures_vl fifsv where gl.chart_of_accounts_id=fifsv.id_flex_num and fifsv.application_id=101 and fifsv.id_flex_code='GL#') chart_of_accounts_name,
gl.ledger_id,
gl.chart_of_accounts_id,
xfi.legal_entity_id
from
gl_ledgers gl,
gl_ledger_config_details glcd,
xle_firstparty_information_v xfi,
fnd_territories_vl ftv
where
1=1 and
gl.object_type_code='L' and
gl.configuration_id=glcd.configuration_id(+) and
glcd.object_type_code(+)='LEGAL_ENTITY' and
glcd.setup_step_code(+)='NONE' and
glcd.object_id=xfi.legal_entity_id(+) and
xfi.country=ftv.territory_code(+)
order by
chart_of_accounts_name,
ledger_set,
ledger,
legal_entity,
currency,
country