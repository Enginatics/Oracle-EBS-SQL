/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ZX Lines Summary
-- Description: Tax lines summary to understand the different applications, entity codes and events that generate tax lines
-- Excel Examle Output: https://www.enginatics.com/example/zx-lines-summary/
-- Library Link: https://www.enginatics.com/reports/zx-lines-summary/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
zl.entity_code,
zl.event_class_code,
zl.event_type_code,
zl.trx_level_type,
count(*) count,
xxen_util.meaning(zl.event_class_code,'ZX_LINE_CLASS',0) event_class_code_desc,
zl.application_id
from
fnd_application_vl fav,
zx_lines zl
where
fav.application_id=zl.application_id
group by
fav.application_name,
zl.entity_code,
zl.event_class_code,
zl.event_type_code,
zl.trx_level_type,
zl.application_id
order by
fav.application_name,
zl.entity_code,
count(*) desc