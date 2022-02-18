/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLE Establishment and Legal Entity Associations
-- Description: Master data report showing the legal entity associations to other business entities such as:
- Legal Entities
- Operating Units
- Inventory Organizations
- Inventory Locations
- Bill To Locations
- Ship To Locations
- Balancing Segment Values
-- Excel Examle Output: https://www.enginatics.com/example/xle-establishment-and-legal-entity-associations/
-- Library Link: https://www.enginatics.com/reports/xle-establishment-and-legal-entity-associations/
-- Run Report: https://demo.enginatics.com/

select
initcap(translate(xav.context,'_',' ')) context,
xep.name parent_legal_entity,
initcap(translate(xav.legal_construct,'_',' ')) construct_type,
xav.legal_construct_name construct_name,
initcap(translate(xav.entity_type,'_',' ')) entity_type,
xav.entity_name,
xav.effective_from,
xav.effective_to
from
xle_associations_v xav,
xle_entity_profiles xep
where
1=1 and
xav.legal_parent_id=xep.legal_entity_id(+)
order by
xep.name,
xav.legal_construct,
xav.legal_construct_name,
xav.entity_type,
xav.entity_name