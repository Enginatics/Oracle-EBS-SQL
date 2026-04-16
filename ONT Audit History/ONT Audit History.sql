/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Audit History
-- Description: Order Management audit history report showing changes to order headers, lines, sales credits, and price adjustments with old/new values, change reasons, and the user who made the change.
Based on Oracle standard report OEXAUDHR_XML (Audit History Report).
-- Excel Examle Output: https://www.enginatics.com/example/ont-audit-history/
-- Library Link: https://www.enginatics.com/reports/ont-audit-history/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
oaadv.order_number,
case
when oaadv.entity_id in (2,7,8) then
(
select
case
when oola.service_number is not null then
case
when oola.option_number is not null then
case when oola.component_number is not null then oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number
else oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'..'||oola.service_number
end
else
case when oola.component_number is not null then oola.line_number||'.'||oola.shipment_number||'..'||oola.component_number||'.'||oola.service_number
else oola.line_number||'.'||oola.shipment_number||'...'||oola.service_number
end
end
when oola.option_number is not null then
case when oola.component_number is not null then oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number
else oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number
end
when oola.component_number is not null then oola.line_number||'.'||oola.shipment_number||'..'||oola.component_number
when oola.line_number is not null or oola.shipment_number is not null then oola.line_number||'.'||oola.shipment_number
end
from
oe_order_lines_all oola
where
oola.line_id=case oaadv.entity_id
when 2 then oaadv.entity_number
when 7 then (select osc.line_id from oe_sales_credits osc where osc.sales_credit_id=oaadv.entity_number and rownum=1)
when 8 then (select opa.line_id from oe_price_adjustments opa where opa.price_adjustment_id=oaadv.entity_number and rownum=1)
end
and rownum=1
)
end line_number,
oaadv.entity_display_name entity,
oaadv.attribute_display_name attribute,
oaadv.old_display_value old_value,
oaadv.new_display_value new_value,
oaadv.reason,
oaadv.hist_comments comments,
oaadv.user_name,
oaadv.responsibility_name responsibility,
oaadv.hist_creation_date history_date,
oaadv.entity_id,
oaadv.entity_number
from
hr_all_organization_units_vl haouv,
oe_audit_attr_desc_v oaadv
where
1=1 and
oaadv.org_id=haouv.organization_id and
oaadv.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
order by
oaadv.hist_creation_date desc,
oaadv.entity_id