/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Templates
-- Description: Inventory item templates and their item attribute values
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-templates/
-- Library Link: https://www.enginatics.com/reports/inv-item-templates/
-- Run Report: https://demo.enginatics.com/

select
mitv.template_name,
mitv.description,
ood.organization_code,
ood.organization_name,
xxen_util.meaning(mia.attribute_group_id_gui,'ITEM_CHOICES_GUI',700) attribute_group,
mia.user_attribute_name_gui attribute_name,
xxen_util.meaning(mia.control_level,'ITEM_CONTROL_LEVEL_GUI',700) controlled_at,
decode(mia.validation_code,4,xxen_util.meaning(mita.attribute_value,'YES_NO',0),
decode(mia.attribute_name_,
'MATERIAL_BILLABLE_FLAG',xxen_util.meaning(mita.attribute_value,'MTL_SERVICE_BILLABLE_FLAG',170),
'ACCOUNTING_RULE_ID',(select rr.name from ra_rules rr where mita.attribute_value=rr.rule_id),
'ALLOWED_UNITS_LOOKUP_CODE',xxen_util.meaning(mita.attribute_value,'MTL_CONVERSION_TYPE',700),
'ATO_FORECAST_CONTROL',xxen_util.meaning(mita.attribute_value,'MRP_ATO_FORECAST_CONTROL',700),
'ATP_FLAG',xxen_util.meaning(mita.attribute_value,'ATP_FLAG',3),
'ATP_COMPONENTS_FLAG',xxen_util.meaning(mita.attribute_value,'ATP_FLAG',3),
'ATP_RULE_ID',(select mar.rule_name from mtl_atp_rules mar where mita.attribute_value=mar.rule_id),
'AUTO_REDUCE_MPS',xxen_util.meaning(mita.attribute_value,'MRP_AUTO_REDUCE_MPS',700),
'BOM_ITEM_TYPE',xxen_util.meaning(mita.attribute_value,'BOM_ITEM_TYPE',700),
'EFFECTIVITY_CONTROL',xxen_util.meaning(mita.attribute_value,'MTL_EFFECTIVITY_CONTROL',700),
'BUYER_ID',(select ppx.full_name from per_people_x ppx where ppx.current_employee_flag='Y' and mita.attribute_value=ppx.person_id),
'DEFAULT_SHIPPING_ORG',(select mp.organization_code from mtl_parameters mp where mita.attribute_value=mp.organization_id),
'DEMAND_TIME_FENCE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_TIME_FENCE',700),
'END_ASSEMBLY_PEGGING_FLAG',xxen_util.meaning(mita.attribute_value,'ASSEMBLY_PEGGING_CODE',0),
'ENFORCE_SHIP_TO_LOCATION_CODE',xxen_util.meaning(mita.attribute_value,'RECEIVING CONTROL LEVEL',201),
'HAZARD_CLASS_ID',(select phcv.hazard_class from po_hazard_classes_vl phcv where mita.attribute_value=phcv.hazard_class_id),
'INVENTORY_ITEM_STATUS_CODE',(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where mita.attribute_value=misv.inventory_item_status_code),
'INVENTORY_PLANNING_CODE',xxen_util.meaning(mita.attribute_value,'MTL_MATERIAL_PLANNING',700),
'INVOICING_RULE_ID',(select rr.name from ra_rules rr where mita.attribute_value=rr.rule_id),
'ITEM_TYPE',xxen_util.meaning(mita.attribute_value,'ITEM_TYPE',3),
'PRIMARY_UOM_CODE',(select mpuv.unit_of_measure_tl from mtl_primary_uoms_vv mpuv where mita.attribute_value=mpuv.uom_code),
'VOLUME_UOM_CODE',(select muov.unit_of_measure_tl from mtl_units_of_measure_vl muov where mita.attribute_value=muov.uom_code),
'DIMENSION_UOM_CODE',(select muov.unit_of_measure_tl from mtl_units_of_measure_vl muov where mita.attribute_value=muov.uom_code),
'CONTAINER_TYPE_CODE',xxen_util.meaning(mita.attribute_value,'CONTAINER_TYPE',3),
'LOCATION_CONTROL_CODE',xxen_util.meaning(mita.attribute_value,'MTL_LOCATION_CONTROL',700),
'LOT_CONTROL_CODE',xxen_util.meaning(mita.attribute_value,'MTL_LOT_CONTROL',700),
'MRP_PLANNING_CODE',xxen_util.meaning(mita.attribute_value,'MRP_PLANNING_CODE',700),
'MRP_SAFETY_STOCK_CODE',xxen_util.meaning(mita.attribute_value,'MTL_SAFETY_STOCK_TYPE',700),
'OUTSIDE_OPERATION_UOM_TYPE',xxen_util.meaning(mita.attribute_value,'OUTSIDE OPERATION UOM TYPE',201),
'PAYMENT_TERMS_ID',(select rtv.name from ra_terms_vl rtv where mita.attribute_value=rtv.term_id),
'PICKING_RULE_ID',(select mpr.picking_rule_name from mtl_picking_rules mpr where mita.attribute_value=mpr.picking_rule_id),
'PLANNING_TIME_FENCE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_TIME_FENCE',700),
'RELEASE_TIME_FENCE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_RELEASE_TIME_FENCE',700),
'PLANNING_MAKE_BUY_CODE',xxen_util.meaning(mita.attribute_value,'MTL_PLANNING_MAKE_BUY',700),
'RECEIVING_ROUTING_ID',xxen_util.meaning(mita.attribute_value,'RCV_ROUTING_HEADERS',0),
'RESERVABLE_TYPE',xxen_util.meaning(mita.attribute_value,'MTL_RESERVATION_CONTROL',700),
'RESTRICT_LOCATORS_CODE',xxen_util.meaning(mita.attribute_value,'MTL_LOCATOR_RESTRICTIONS',700),
'RESTRICT_SUBINVENTORIES_CODE',xxen_util.meaning(mita.attribute_value,'MTL_SUBINVENTORY_RESTRICTIONS',700),
'RETURN_INSPECTION_REQUIREMENT',xxen_util.meaning(mita.attribute_value,'MTL_RETURN_INSPECTION',700),
'REVISION_QTY_CONTROL_CODE',xxen_util.meaning(mita.attribute_value,'MTL_ENG_QUANTITY',700),
'ROUNDING_CONTROL_TYPE',xxen_util.meaning(mita.attribute_value,'MTL_ROUNDING',700),
'SERIAL_NUMBER_CONTROL_CODE',xxen_util.meaning(mita.attribute_value,'MTL_SERIAL_NUMBER',700),
'SHELF_LIFE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_SHELF_LIFE',700),
'SOURCE_ORGANIZATION_ID',(select mp.organization_code from mtl_parameters mp where mita.attribute_value=mp.organization_id),
'SOURCE_TYPE',xxen_util.meaning(mita.attribute_value,'MTL_SOURCE_TYPES',700),
'UN_NUMBER_ID',(select punv.un_number from po_un_numbers_vl punv where mita.attribute_value=punv.un_number_id),
'WIP_SUPPLY_TYPE',xxen_util.meaning(mita.attribute_value,'WIP_SUPPLY',700),
'OVERCOMPLETION_TOLERANCE_TYPE',xxen_util.meaning(mita.attribute_value,'WIP_TOLERANCE_TYPE',700),
'EQUIPMENT_TYPE',xxen_util.meaning(mita.attribute_value,'SYS_YES_NO',700),
'SERVICE_DURATION_PERIOD_CODE',(select muov.unit_of_measure_tl from mtl_units_of_measure_vl muov where mita.attribute_value=muov.uom_code),
'COVERAGE_SCHEDULE_ID',(select octv.name from oks_coverage_templts_v octv where mita.attribute_value=octv.id),
'ASSET_CREATION_CODE',xxen_util.meaning(mita.attribute_value,'CSE_ASSET_CREATION_CODE',0),
'WEB_STATUS',xxen_util.meaning(mita.attribute_value,'IBE_ITEM_STATUS',0),
'RECOVERED_PART_DISP_CODE',xxen_util.meaning(mita.attribute_value,'CSP_RECOVERED_PART_DISP_CODE',0),
'EAM_ITEM_TYPE',xxen_util.meaning(mita.attribute_value,'MTL_EAM_ITEM_TYPE',700),
'EAM_ACTIVITY_TYPE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_EAM_ACTIVITY_TYPE',700),
'EAM_ACTIVITY_CAUSE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_EAM_ACTIVITY_CAUSE',700),
'EAM_ACT_SHUTDOWN_STATUS',xxen_util.meaning(mita.attribute_value,'BOM_EAM_SHUTDOWN_TYPE',700),
'DEFAULT_SO_SOURCE_TYPE',xxen_util.meaning(mita.attribute_value,'SOURCE_TYPE',600),
'SERV_REQ_ENABLED_CODE',xxen_util.meaning(mita.attribute_value,'CS_SR_SERV_REQ_ENABLED_TYPE',170),
'EAM_ACTIVITY_SOURCE_CODE',xxen_util.meaning(mita.attribute_value,'MTL_EAM_ACTIVITY_SOURCE',700),
'IB_ITEM_INSTANCE_CLASS',xxen_util.meaning(mita.attribute_value,'CSI_ITEM_CLASS',542),
'CONFIG_MODEL_TYPE',xxen_util.meaning(mita.attribute_value,'CZ_CONFIG_MODEL_TYPE',708),
'SUBSTITUTION_WINDOW_CODE',xxen_util.meaning(mita.attribute_value,'MTL_TIME_FENCE',700),
'CONTINOUS_TRANSFER',xxen_util.meaning(mita.attribute_value,'MTL_MSI_MRP_INT_ORG',700),
'CONVERGENCE',xxen_util.meaning(mita.attribute_value,'MTL_MSI_MRP_CONV_SUPP',700),
'DIVERGENCE',xxen_util.meaning(mita.attribute_value,'MTL_MSI_MRP_DIV_SUPP',700),
'VMI_FORECAST_TYPE',xxen_util.meaning(mita.attribute_value,'MTL_MSI_GP_FORECAST_TYPE',700),
'SO_AUTHORIZATION_FLAG',xxen_util.meaning(mita.attribute_value,'MTL_MSI_GP_RELEASE_AUTH',700),
'TRACKING_QUANTITY_IND',xxen_util.meaning(mita.attribute_value,'INV_TRACKING_UOM_TYPE',0),
'ONT_PRICING_QTY_SOURCE',xxen_util.meaning(mita.attribute_value,'INV_PRICING_UOM_TYPE',0),
'SECONDARY_DEFAULT_IND',xxen_util.meaning(mita.attribute_value,'INV_DEFAULTING_UOM_TYPE',0),
'CONFIG_ORGS',xxen_util.meaning(mita.attribute_value,'INV_CONFIG_ORGS_TYPE',0),
'CONFIG_MATCH',xxen_util.meaning(mita.attribute_value,'INV_CONFIG_MATCH_TYPE',0),
'PARENT_CHILD_GENERATION_FLAG',xxen_util.meaning(mita.attribute_value,'INV_PARENT_CHILD_GENERATION',0),
'CHARGE_PERIODICITY',(select muc.unit_of_measure from mtl_uom_conversions muc where muc.uom_class=fnd_profile.value('ONT_UOM_CLASS_CHARGE_PERIODICITY') and mita.attribute_value=muc.uom_code),
'SUBCONTRACTING_COMPONENT',xxen_util.meaning(mita.attribute_value,'INV_SUBCONT_COMPONENT',700),
'OUTSOURCED_ASSEMBLY',xxen_util.meaning(mita.attribute_value,'SYS_YES_NO',700),
'REPAIR_PROGRAM',xxen_util.meaning(mita.attribute_value,'INV_REPAIR_PROGRAMS',700),
'PLANNED_INV_POINT_FLAG',xxen_util.meaning(decode(mita.attribute_value,'Y','Y'),'YES_NO',0),
mita.attribute_value)
) value,
xxen_util.meaning(decode(mita.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
xxen_util.user_name(mitv.created_by) created_by,
xxen_util.client_time(mitv.creation_date) creation_date,
xxen_util.user_name(mitv.last_updated_by) last_updated_by,
xxen_util.client_time(mitv.last_update_date) last_update_date,
mia.attribute_name_ sys_attribute_name,
mita.attribute_value sys_value,
mitv.template_id
from
mtl_item_templates_vl mitv,
org_organization_definitions ood,
mtl_item_templ_attributes mita,
(select substr(mia.attribute_name,18) attribute_name_, mia.* from mtl_item_attributes mia) mia
where
1=1 and
(
mitv.context_organization_id is null or
mitv.context_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
) and
mitv.context_organization_id=ood.organization_id(+) and
mitv.template_id=mita.template_id and
mita.attribute_name=mia.attribute_name and
mia.user_attribute_name_gui is not null
order by
ood.organization_code,
mitv.template_name,
mia.attribute_group_id,
mia.sequence_gui