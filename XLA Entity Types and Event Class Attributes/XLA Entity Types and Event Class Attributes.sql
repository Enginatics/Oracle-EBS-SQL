/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLA Entity Types and Event Class Attributes
-- Description: Subledger event types and their attributes, for example reporting view
-- Excel Examle Output: https://www.enginatics.com/example/xla-entity-types-and-event-class-attributes/
-- Library Link: https://www.enginatics.com/reports/xla-entity-types-and-event-class-attributes/
-- Run Report: https://demo.enginatics.com/

select
fav.application_short_name,
fav.application_name,
xetv.name entity_type,
xetv.description,
xetv.entity_code,
xeca.je_category_name,
xeca.event_class_code,
xeca.reporting_view_name,
xxen_util.yes(xeca.allow_actuals_flag) allow_actuals_flag,
xxen_util.yes(xeca.allow_budgets_flag) allow_budgets_flag,
xxen_util.yes(xeca.allow_encumbrance_flag) allow_encumbrance_flag
from
fnd_application_vl fav,
xla_entity_types_vl xetv,
xla_event_class_attrs xeca
where
1=1 and
fav.application_id=xetv.application_id and
xetv.entity_code=xeca.entity_code(+) and
xetv.application_id=xeca.application_id(+)
order by
fav.application_name,
xetv.entity_code,
xeca.event_class_code