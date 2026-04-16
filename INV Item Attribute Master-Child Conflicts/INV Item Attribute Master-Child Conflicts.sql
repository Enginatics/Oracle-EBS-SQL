/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Attribute Master/Child Conflicts
-- Description: Identifies existing Item Attribute Master/Child attribute value conflicts for Item Attributes controlled at the Master Organization Level.

These errors show as a "Master - Child Conflict in one of these Attributes: ... [MASTER_CHILD_nn]" error during Item Upload

Item Attributes with Master/Child conflicts are identified in the report by having a value in the report displayed as M:[master Org Value] C:[Child Org Value]

Item Attributes with no Master/Child conflicts will have a null value in the report. 

-- Excel Examle Output: https://www.enginatics.com/example/inv-item-attribute-master-child-conflicts/
-- Library Link: https://www.enginatics.com/reports/inv-item-attribute-master-child-conflicts/
-- Run Report: https://demo.enginatics.com/

with item_attrib_ctl_lvls as
(
select /*+ materialize */
-- 1A
inv_attribute_control_pvt.get_attribute_control('ACCOUNTING_RULE_ID') accounting_rule_id,
inv_attribute_control_pvt.get_attribute_control('BUYER_ID') buyer_id,
inv_attribute_control_pvt.get_attribute_control('CUSTOMER_ORDER_FLAG') customer_order_flag,
inv_attribute_control_pvt.get_attribute_control('INTERNAL_ORDER_FLAG') internal_order_flag,
inv_attribute_control_pvt.get_attribute_control('INVENTORY_ITEM_FLAG') inventory_item_flag,
inv_attribute_control_pvt.get_attribute_control('INVOICING_RULE_ID') invoicing_rule_id,
inv_attribute_control_pvt.get_attribute_control('PURCHASING_ITEM_FLAG') purchasing_item_flag,
inv_attribute_control_pvt.get_attribute_control('SHIPPABLE_ITEM_FLAG') shippable_item_flag,
-- 1B
inv_attribute_control_pvt.get_attribute_control('BOM_ENABLED_FLAG') bom_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('BUILD_IN_WIP_FLAG') build_in_wip_flag,
inv_attribute_control_pvt.get_attribute_control('CHECK_SHORTAGES_FLAG') check_shortages_flag,
1 item_catalog_group_id,
inv_attribute_control_pvt.get_attribute_control('REVISION_QTY_CONTROL_CODE') revision_qty_control_code,
inv_attribute_control_pvt.get_attribute_control('STOCK_ENABLED_FLAG') stock_enabled_flag,
-- 1C
inv_attribute_control_pvt.get_attribute_control('CUSTOMER_ORDER_ENABLED_FLAG') customer_order_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('INTERNAL_ORDER_ENABLED_FLAG') internal_order_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('MTL_TRANSACTIONS_ENABLED_FLAG') mtl_transactions_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('PURCHASING_ENABLED_FLAG') purchasing_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('SO_TRANSACTIONS_FLAG') so_transactions_flag,
-- 1D
inv_attribute_control_pvt.get_attribute_control('ALLOW_ITEM_DESC_UPDATE_FLAG') allow_item_desc_update_flag,
inv_attribute_control_pvt.get_attribute_control('CATALOG_STATUS_FLAG') catalog_status_flag,
inv_attribute_control_pvt.get_attribute_control('COLLATERAL_FLAG') collateral_flag,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_SHIPPING_ORG') default_shipping_org,
inv_attribute_control_pvt.get_attribute_control('INSPECTION_REQUIRED_FLAG') inspection_required_flag,
inv_attribute_control_pvt.get_attribute_control('MARKET_PRICE') market_price,
inv_attribute_control_pvt.get_attribute_control('PURCHASING_TAX_CODE') purchasing_tax_code,
inv_attribute_control_pvt.get_attribute_control('QTY_RCV_EXCEPTION_CODE') qty_rcv_exception_code,
inv_attribute_control_pvt.get_attribute_control('RECEIPT_REQUIRED_FLAG') receipt_required_flag,
inv_attribute_control_pvt.get_attribute_control('RETURNABLE_FLAG') returnable_flag,
inv_attribute_control_pvt.get_attribute_control('TAXABLE_FLAG') taxable_flag,
-- 1E
inv_attribute_control_pvt.get_attribute_control('ASSET_CATEGORY_ID') asset_category_id,
inv_attribute_control_pvt.get_attribute_control('ENFORCE_SHIP_TO_LOCATION_CODE') enforce_ship_to_location_code,
inv_attribute_control_pvt.get_attribute_control('HAZARD_CLASS_ID') hazard_class_id,
inv_attribute_control_pvt.get_attribute_control('LIST_PRICE_PER_UNIT') list_price_per_unit,
inv_attribute_control_pvt.get_attribute_control('PRICE_TOLERANCE_PERCENT') price_tolerance_percent,
inv_attribute_control_pvt.get_attribute_control('QTY_RCV_TOLERANCE') qty_rcv_tolerance,
inv_attribute_control_pvt.get_attribute_control('RFQ_REQUIRED_FLAG') rfq_required_flag,
inv_attribute_control_pvt.get_attribute_control('ROUNDING_FACTOR') rounding_factor,
inv_attribute_control_pvt.get_attribute_control('UN_NUMBER_ID') un_number_id,
inv_attribute_control_pvt.get_attribute_control('UNIT_OF_ISSUE') unit_of_issue,
-- 1F
inv_attribute_control_pvt.get_attribute_control('ALLOW_EXPRESS_DELIVERY_FLAG') allow_express_delivery_flag,
inv_attribute_control_pvt.get_attribute_control('ALLOW_SUBSTITUTE_RECEIPTS_FLAG') allow_substitute_receipts_flag,
inv_attribute_control_pvt.get_attribute_control('ALLOW_UNORDERED_RECEIPTS_FLAG') allow_unordered_receipts_flag,
inv_attribute_control_pvt.get_attribute_control('DAYS_EARLY_RECEIPT_ALLOWED') days_early_receipt_allowed,
inv_attribute_control_pvt.get_attribute_control('DAYS_LATE_RECEIPT_ALLOWED') days_late_receipt_allowed,
-- 1G
inv_attribute_control_pvt.get_attribute_control('AUTO_LOT_ALPHA_PREFIX') auto_lot_alpha_prefix,
inv_attribute_control_pvt.get_attribute_control('DESCRIPTION') description,
inv_attribute_control_pvt.get_attribute_control('INVOICE_CLOSE_TOLERANCE') invoice_close_tolerance,
inv_attribute_control_pvt.get_attribute_control('LONG_DESCRIPTION') long_description,
inv_attribute_control_pvt.get_attribute_control('RECEIPT_DAYS_EXCEPTION_CODE') receipt_days_exception_code,
inv_attribute_control_pvt.get_attribute_control('RECEIVE_CLOSE_TOLERANCE') receive_close_tolerance,
inv_attribute_control_pvt.get_attribute_control('RECEIVING_ROUTING_ID') receiving_routing_id,
-- 1HA
inv_attribute_control_pvt.get_attribute_control('OVER_SHIPMENT_TOLERANCE') over_shipment_tolerance,
inv_attribute_control_pvt.get_attribute_control('OVERCOMPLETION_TOLERANCE_TYPE') overcompletion_tolerance_type,
inv_attribute_control_pvt.get_attribute_control('OVERCOMPLETION_TOLERANCE_VALUE') overcompletion_tolerance_value,
inv_attribute_control_pvt.get_attribute_control('UNDER_SHIPMENT_TOLERANCE') under_shipment_tolerance,
-- 1HB
inv_attribute_control_pvt.get_attribute_control('DEFECT_TRACKING_ON_FLAG') defect_tracking_on_flag,
inv_attribute_control_pvt.get_attribute_control('EQUIPMENT_TYPE') equipment_type,
inv_attribute_control_pvt.get_attribute_control('OVER_RETURN_TOLERANCE') over_return_tolerance,
inv_attribute_control_pvt.get_attribute_control('RECOVERED_PART_DISP_CODE') recovered_part_disp_code,
inv_attribute_control_pvt.get_attribute_control('UNDER_RETURN_TOLERANCE') under_return_tolerance,
-- 1HC
inv_attribute_control_pvt.get_attribute_control('COUPON_EXEMPT_FLAG') coupon_exempt_flag,
inv_attribute_control_pvt.get_attribute_control('DOWNLOADABLE_FLAG') downloadable_flag,
inv_attribute_control_pvt.get_attribute_control('ELECTRONIC_FLAG') electronic_flag,
inv_attribute_control_pvt.get_attribute_control('EVENT_FLAG') event_flag,
inv_attribute_control_pvt.get_attribute_control('VOL_DISCOUNT_EXEMPT_FLAG') vol_discount_exempt_flag,
-- 1HD
inv_attribute_control_pvt.get_attribute_control('ASSET_CREATION_CODE') asset_creation_code,
inv_attribute_control_pvt.get_attribute_control('BACK_ORDERABLE_FLAG') back_orderable_flag,
inv_attribute_control_pvt.get_attribute_control('COMMS_ACTIVATION_REQD_FLAG') comms_activation_reqd_flag,
inv_attribute_control_pvt.get_attribute_control('COMMS_NL_TRACKABLE_FLAG') comms_nl_trackable_flag,
inv_attribute_control_pvt.get_attribute_control('IB_ITEM_TRACKING_LEVEL') ib_item_tracking_level,
inv_attribute_control_pvt.get_attribute_control('ORDERABLE_ON_WEB_FLAG') orderable_on_web_flag,
-- 1IA
inv_attribute_control_pvt.get_attribute_control('BULK_PICKED_FLAG') bulk_picked_flag,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_LOT_STATUS_ID') default_lot_status_id,
inv_attribute_control_pvt.get_attribute_control('DIMENSION_UOM_CODE') dimension_uom_code,
inv_attribute_control_pvt.get_attribute_control('LOT_STATUS_ENABLED') lot_status_enabled,
inv_attribute_control_pvt.get_attribute_control('UNIT_HEIGHT') unit_height,
inv_attribute_control_pvt.get_attribute_control('UNIT_LENGTH') unit_length,
inv_attribute_control_pvt.get_attribute_control('UNIT_WIDTH') unit_width,
-- 1IB
inv_attribute_control_pvt.get_attribute_control('DEFAULT_MATERIAL_STATUS_ID') default_material_status_id,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_SERIAL_STATUS_ID') default_serial_status_id,
inv_attribute_control_pvt.get_attribute_control('LOT_MERGE_ENABLED') lot_merge_enabled,
inv_attribute_control_pvt.get_attribute_control('LOT_SPLIT_ENABLED') lot_split_enabled,
inv_attribute_control_pvt.get_attribute_control('MCC_CLASSIFICATION_TYPE') mcc_classification_type,
inv_attribute_control_pvt.get_attribute_control('SERIAL_STATUS_ENABLED') serial_status_enabled,
-- 1IC
inv_attribute_control_pvt.get_attribute_control('FINANCING_ALLOWED_FLAG') financing_allowed_flag,
inv_attribute_control_pvt.get_attribute_control('INVENTORY_CARRY_PENALTY') inventory_carry_penalty,
inv_attribute_control_pvt.get_attribute_control('OPERATION_SLACK_PENALTY') operation_slack_penalty,
-- 1IJ
inv_attribute_control_pvt.get_attribute_control('CONTRACT_ITEM_TYPE_CODE') contract_item_type_code,
inv_attribute_control_pvt.get_attribute_control('DUAL_UOM_DEVIATION_HIGH') dual_uom_deviation_high,
inv_attribute_control_pvt.get_attribute_control('DUAL_UOM_DEVIATION_LOW') dual_uom_deviation_low,
inv_attribute_control_pvt.get_attribute_control('EAM_ACT_NOTIFICATION_FLAG') eam_act_notification_flag,
inv_attribute_control_pvt.get_attribute_control('EAM_ACT_SHUTDOWN_STATUS') eam_act_shutdown_status,
inv_attribute_control_pvt.get_attribute_control('EAM_ACTIVITY_CAUSE_CODE') eam_activity_cause_code,
inv_attribute_control_pvt.get_attribute_control('EAM_ACTIVITY_TYPE_CODE') eam_activity_type_code,
inv_attribute_control_pvt.get_attribute_control('EAM_ITEM_TYPE') eam_item_type,
inv_attribute_control_pvt.get_attribute_control('SECONDARY_UOM_CODE') secondary_uom_code,
-- 1IK
inv_attribute_control_pvt.get_attribute_control('CREATE_SUPPLY_FLAG') create_supply_flag,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_SO_SOURCE_TYPE') default_so_source_type,
inv_attribute_control_pvt.get_attribute_control('LOT_TRANSLATE_ENABLED') lot_translate_enabled,
inv_attribute_control_pvt.get_attribute_control('PLANNED_INV_POINT_FLAG') planned_inv_point_flag,
inv_attribute_control_pvt.get_attribute_control('SERV_BILLING_ENABLED_FLAG') serv_billing_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('SERV_REQ_ENABLED_CODE') serv_req_enabled_code,
inv_attribute_control_pvt.get_attribute_control('SUBSTITUTION_WINDOW_CODE') substitution_window_code,
inv_attribute_control_pvt.get_attribute_control('SUBSTITUTION_WINDOW_DAYS') substitution_window_days,

-- 4A
inv_attribute_control_pvt.get_attribute_control('AUTO_SERIAL_ALPHA_PREFIX') auto_serial_alpha_prefix,
inv_attribute_control_pvt.get_attribute_control('LOT_CONTROL_CODE') lot_control_code,
inv_attribute_control_pvt.get_attribute_control('SERIAL_NUMBER_CONTROL_CODE') serial_number_control_code,
inv_attribute_control_pvt.get_attribute_control('SHELF_LIFE_CODE') shelf_life_code,
inv_attribute_control_pvt.get_attribute_control('SHELF_LIFE_DAYS') shelf_life_days,
inv_attribute_control_pvt.get_attribute_control('START_AUTO_LOT_NUMBER') start_auto_lot_number,
inv_attribute_control_pvt.get_attribute_control('START_AUTO_SERIAL_NUMBER') start_auto_serial_number,
-- 4B
inv_attribute_control_pvt.get_attribute_control('ENCUMBRANCE_ACCOUNT') encumbrance_account,
inv_attribute_control_pvt.get_attribute_control('EXPENSE_ACCOUNT') expense_account,
inv_attribute_control_pvt.get_attribute_control('RESTRICT_SUBINVENTORIES_CODE') restrict_subinventories_code,
inv_attribute_control_pvt.get_attribute_control('SOURCE_ORGANIZATION_ID') source_organization_id,
inv_attribute_control_pvt.get_attribute_control('SOURCE_SUBINVENTORY') source_subinventory,
inv_attribute_control_pvt.get_attribute_control('SOURCE_TYPE') source_type,
inv_attribute_control_pvt.get_attribute_control('UNIT_WEIGHT') unit_weight,
inv_attribute_control_pvt.get_attribute_control('WEIGHT_UOM_CODE') weight_uom_code,
-- 4C
inv_attribute_control_pvt.get_attribute_control('ACCEPTABLE_EARLY_DAYS') acceptable_early_days,
inv_attribute_control_pvt.get_attribute_control('LOCATION_CONTROL_CODE') location_control_code,
inv_attribute_control_pvt.get_attribute_control('PLANNING_TIME_FENCE_CODE') planning_time_fence_code,
inv_attribute_control_pvt.get_attribute_control('RESTRICT_LOCATORS_CODE') restrict_locators_code,
inv_attribute_control_pvt.get_attribute_control('SHRINKAGE_RATE') shrinkage_rate,
inv_attribute_control_pvt.get_attribute_control('UNIT_VOLUME') unit_volume,
inv_attribute_control_pvt.get_attribute_control('VOLUME_UOM_CODE') volume_uom_code,
-- 4D
inv_attribute_control_pvt.get_attribute_control('ACCEPTABLE_RATE_DECREASE') acceptable_rate_decrease,
inv_attribute_control_pvt.get_attribute_control('ACCEPTABLE_RATE_INCREASE') acceptable_rate_increase,
inv_attribute_control_pvt.get_attribute_control('CUM_MANUFACTURING_LEAD_TIME') cum_manufacturing_lead_time,
inv_attribute_control_pvt.get_attribute_control('DEMAND_TIME_FENCE_CODE') demand_time_fence_code,
inv_attribute_control_pvt.get_attribute_control('LEAD_TIME_LOT_SIZE') lead_time_lot_size,
inv_attribute_control_pvt.get_attribute_control('MRP_CALCULATE_ATP_FLAG') mrp_calculate_atp_flag,
inv_attribute_control_pvt.get_attribute_control('OVERRUN_PERCENTAGE') overrun_percentage,
inv_attribute_control_pvt.get_attribute_control('STD_LOT_SIZE') std_lot_size,
-- 4E
inv_attribute_control_pvt.get_attribute_control('BOM_ITEM_TYPE') bom_item_type,
inv_attribute_control_pvt.get_attribute_control('CUMULATIVE_TOTAL_LEAD_TIME') cumulative_total_lead_time,
inv_attribute_control_pvt.get_attribute_control('DEMAND_TIME_FENCE_DAYS') demand_time_fence_days,
inv_attribute_control_pvt.get_attribute_control('END_ASSEMBLY_PEGGING_FLAG') end_assembly_pegging_flag,
inv_attribute_control_pvt.get_attribute_control('PLANNING_EXCEPTION_SET') planning_exception_set,
inv_attribute_control_pvt.get_attribute_control('PLANNING_TIME_FENCE_DAYS') planning_time_fence_days,
inv_attribute_control_pvt.get_attribute_control('REPETITIVE_PLANNING_FLAG') repetitive_planning_flag,
-- 4F
inv_attribute_control_pvt.get_attribute_control('ATP_COMPONENTS_FLAG') atp_components_flag,
inv_attribute_control_pvt.get_attribute_control('ATP_FLAG') atp_flag,
inv_attribute_control_pvt.get_attribute_control('BASE_ITEM_ID') base_item_id,
inv_attribute_control_pvt.get_attribute_control('FIXED_LEAD_TIME') fixed_lead_time,
inv_attribute_control_pvt.get_attribute_control('PICK_COMPONENTS_FLAG') pick_components_flag,
inv_attribute_control_pvt.get_attribute_control('REPLENISH_TO_ORDER_FLAG') replenish_to_order_flag,
inv_attribute_control_pvt.get_attribute_control('VARIABLE_LEAD_TIME') variable_lead_time,
inv_attribute_control_pvt.get_attribute_control('WIP_SUPPLY_LOCATOR_ID') wip_supply_locator_id,
-- 4G
inv_attribute_control_pvt.get_attribute_control('ALLOWED_UNITS_LOOKUP_CODE') allowed_units_lookup_code,
inv_attribute_control_pvt.get_attribute_control('COST_OF_SALES_ACCOUNT') cost_of_sales_account,
inv_attribute_control_pvt.get_attribute_control('PRIMARY_UOM_CODE') primary_uom_code,
inv_attribute_control_pvt.get_attribute_control('SALES_ACCOUNT') sales_account,
inv_attribute_control_pvt.get_attribute_control('WIP_SUPPLY_SUBINVENTORY') wip_supply_subinventory,
inv_attribute_control_pvt.get_attribute_control('WIP_SUPPLY_TYPE') wip_supply_type,
-- 4H
inv_attribute_control_pvt.get_attribute_control('CARRYING_COST') carrying_cost,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_INCLUDE_IN_ROLLUP_FLAG') default_include_in_rollup_flag,
inv_attribute_control_pvt.get_attribute_control('FIXED_LOT_MULTIPLIER') fixed_lot_multiplier,
inv_attribute_control_pvt.get_attribute_control('INVENTORY_ITEM_STATUS_CODE') inventory_item_status_code,
inv_attribute_control_pvt.get_attribute_control('INVENTORY_PLANNING_CODE') inventory_planning_code,
inv_attribute_control_pvt.get_attribute_control('PLANNER_CODE') planner_code,
inv_attribute_control_pvt.get_attribute_control('PLANNING_MAKE_BUY_CODE') planning_make_buy_code,
inv_attribute_control_pvt.get_attribute_control('ROUNDING_CONTROL_TYPE') rounding_control_type,
-- 4I
inv_attribute_control_pvt.get_attribute_control('FULL_LEAD_TIME') full_lead_time,
inv_attribute_control_pvt.get_attribute_control('MIN_MINMAX_QUANTITY') min_minmax_quantity,
inv_attribute_control_pvt.get_attribute_control('MRP_SAFETY_STOCK_CODE') mrp_safety_stock_code,
inv_attribute_control_pvt.get_attribute_control('MRP_SAFETY_STOCK_PERCENT') mrp_safety_stock_percent,
inv_attribute_control_pvt.get_attribute_control('ORDER_COST') order_cost,
inv_attribute_control_pvt.get_attribute_control('POSTPROCESSING_LEAD_TIME') postprocessing_lead_time,
inv_attribute_control_pvt.get_attribute_control('PREPROCESSING_LEAD_TIME') preprocessing_lead_time,
-- 4J
inv_attribute_control_pvt.get_attribute_control('ATP_RULE_ID') atp_rule_id,
inv_attribute_control_pvt.get_attribute_control('FIXED_ORDER_QUANTITY') fixed_order_quantity,
inv_attribute_control_pvt.get_attribute_control('MAX_MINMAX_QUANTITY') max_minmax_quantity,
inv_attribute_control_pvt.get_attribute_control('MAXIMUM_ORDER_QUANTITY') maximum_order_quantity,
inv_attribute_control_pvt.get_attribute_control('MINIMUM_ORDER_QUANTITY') minimum_order_quantity,
inv_attribute_control_pvt.get_attribute_control('PICKING_RULE_ID') picking_rule_id,
-- 4K
inv_attribute_control_pvt.get_attribute_control('AUTO_REDUCE_MPS') auto_reduce_mps,
inv_attribute_control_pvt.get_attribute_control('COSTING_ENABLED_FLAG') costing_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('OUTSIDE_OPERATION_FLAG') outside_operation_flag,
inv_attribute_control_pvt.get_attribute_control('OUTSIDE_OPERATION_UOM_TYPE') outside_operation_uom_type,
inv_attribute_control_pvt.get_attribute_control('POSITIVE_MEASUREMENT_ERROR') positive_measurement_error,
inv_attribute_control_pvt.get_attribute_control('RESERVABLE_TYPE') reservable_type,
inv_attribute_control_pvt.get_attribute_control('SAFETY_STOCK_BUCKET_DAYS') safety_stock_bucket_days,
-- 4L
inv_attribute_control_pvt.get_attribute_control('ATO_FORECAST_CONTROL') ato_forecast_control,
inv_attribute_control_pvt.get_attribute_control('AUTO_CREATED_CONFIG_FLAG') auto_created_config_flag,
inv_attribute_control_pvt.get_attribute_control('CYCLE_COUNT_ENABLED_FLAG') cycle_count_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('ITEM_TYPE') item_type,
inv_attribute_control_pvt.get_attribute_control('MODEL_CONFIG_CLAUSE_NAME') model_config_clause_name,
inv_attribute_control_pvt.get_attribute_control('MRP_PLANNING_CODE') mrp_planning_code,
inv_attribute_control_pvt.get_attribute_control('RETURN_INSPECTION_REQUIREMENT') return_inspection_requirement,
inv_attribute_control_pvt.get_attribute_control('SHIP_MODEL_COMPLETE_FLAG') ship_model_complete_flag,
-- 4M
inv_attribute_control_pvt.get_attribute_control('CONFIG_MODEL_TYPE') config_model_type,
inv_attribute_control_pvt.get_attribute_control('EAM_ACTIVITY_SOURCE_CODE') eam_activity_source_code,
inv_attribute_control_pvt.get_attribute_control('IB_ITEM_INSTANCE_CLASS') ib_item_instance_class,
inv_attribute_control_pvt.get_attribute_control('LOT_SUBSTITUTION_ENABLED') lot_substitution_enabled,
inv_attribute_control_pvt.get_attribute_control('MINIMUM_LICENSE_QUANTITY') minimum_license_quantity,
-- 4N
inv_attribute_control_pvt.get_attribute_control('CHARGE_PERIODICITY_CODE') charge_periodicity_code,
inv_attribute_control_pvt.get_attribute_control('OUTSOURCED_ASSEMBLY') outsourced_assembly,
inv_attribute_control_pvt.get_attribute_control('SUBCONTRACTING_COMPONENT') subcontracting_component,
-- 4O
inv_attribute_control_pvt.get_attribute_control('PREPOSITION_POINT') preposition_point,
inv_attribute_control_pvt.get_attribute_control('REPAIR_LEADTIME') repair_leadtime,
inv_attribute_control_pvt.get_attribute_control('REPAIR_PROGRAM') repair_program,
inv_attribute_control_pvt.get_attribute_control('REPAIR_YIELD') repair_yield,
-- 7A
inv_attribute_control_pvt.get_attribute_control('ENGINEERING_DATE') engineering_date,
inv_attribute_control_pvt.get_attribute_control('ENGINEERING_ECN_CODE') engineering_ecn_code,
inv_attribute_control_pvt.get_attribute_control('ENGINEERING_ITEM_ID') engineering_item_id,
inv_attribute_control_pvt.get_attribute_control('NEGATIVE_MEASUREMENT_ERROR') negative_measurement_error,
inv_attribute_control_pvt.get_attribute_control('SERVICE_STARTING_DELAY') service_starting_delay,
inv_attribute_control_pvt.get_attribute_control('SERVICEABLE_COMPONENT_FLAG') serviceable_component_flag,
-- 7B
inv_attribute_control_pvt.get_attribute_control('BASE_WARRANTY_SERVICE_ID') base_warranty_service_id,
inv_attribute_control_pvt.get_attribute_control('PAYMENT_TERMS_ID') payment_terms_id,
inv_attribute_control_pvt.get_attribute_control('PREVENTIVE_MAINTENANCE_FLAG') preventive_maintenance_flag,
inv_attribute_control_pvt.get_attribute_control('PRIMARY_SPECIALIST_ID') primary_specialist_id,
inv_attribute_control_pvt.get_attribute_control('SECONDARY_SPECIALIST_ID') secondary_specialist_id,
inv_attribute_control_pvt.get_attribute_control('SERVICEABLE_ITEM_CLASS_ID') serviceable_item_class_id,
inv_attribute_control_pvt.get_attribute_control('SERVICEABLE_PRODUCT_FLAG') serviceable_product_flag,
-- 7C
inv_attribute_control_pvt.get_attribute_control('COVERAGE_SCHEDULE_ID') coverage_schedule_id,
inv_attribute_control_pvt.get_attribute_control('MATERIAL_BILLABLE_FLAG') material_billable_flag,
inv_attribute_control_pvt.get_attribute_control('PRORATE_SERVICE_FLAG') prorate_service_flag,
inv_attribute_control_pvt.get_attribute_control('SERVICE_DURATION') service_duration,
inv_attribute_control_pvt.get_attribute_control('SERVICE_DURATION_PERIOD_CODE') service_duration_period_code,
inv_attribute_control_pvt.get_attribute_control('WARRANTY_VENDOR_ID') warranty_vendor_id,
-- 7D
inv_attribute_control_pvt.get_attribute_control('INVOICE_ENABLED_FLAG') invoice_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('INVOICEABLE_ITEM_FLAG') invoiceable_item_flag,
inv_attribute_control_pvt.get_attribute_control('MAX_WARRANTY_AMOUNT') max_warranty_amount,
inv_attribute_control_pvt.get_attribute_control('MUST_USE_APPROVED_VENDOR_FLAG') must_use_approved_vendor_flag,
inv_attribute_control_pvt.get_attribute_control('NEW_REVISION_CODE') new_revision_code,
inv_attribute_control_pvt.get_attribute_control('RESPONSE_TIME_PERIOD_CODE') response_time_period_code,
inv_attribute_control_pvt.get_attribute_control('RESPONSE_TIME_VALUE') response_time_value,
inv_attribute_control_pvt.get_attribute_control('TAX_CODE') tax_code,
-- 7E
inv_attribute_control_pvt.get_attribute_control('CONTAINER_ITEM_FLAG') container_item_flag,
inv_attribute_control_pvt.get_attribute_control('CONTAINER_TYPE_CODE') container_type_code,
inv_attribute_control_pvt.get_attribute_control('INTERNAL_VOLUME') internal_volume,
inv_attribute_control_pvt.get_attribute_control('MAXIMUM_LOAD_WEIGHT') maximum_load_weight,
inv_attribute_control_pvt.get_attribute_control('MINIMUM_FILL_PERCENT') minimum_fill_percent,
inv_attribute_control_pvt.get_attribute_control('RELEASE_TIME_FENCE_CODE') release_time_fence_code,
inv_attribute_control_pvt.get_attribute_control('RELEASE_TIME_FENCE_DAYS') release_time_fence_days,
inv_attribute_control_pvt.get_attribute_control('VEHICLE_ITEM_FLAG') vehicle_item_flag,
-- 7F
inv_attribute_control_pvt.get_attribute_control('ONT_PRICING_QTY_SOURCE') ont_pricing_qty_source,
inv_attribute_control_pvt.get_attribute_control('SECONDARY_DEFAULT_IND') secondary_default_ind,
inv_attribute_control_pvt.get_attribute_control('TRACKING_QUANTITY_IND') tracking_quantity_ind,
-- 7G
inv_attribute_control_pvt.get_attribute_control('CONFIG_MATCH') config_match,
inv_attribute_control_pvt.get_attribute_control('CONFIG_ORGS') config_orgs,
-- 7H
inv_attribute_control_pvt.get_attribute_control('ASN_AUTOEXPIRE_FLAG') asn_autoexpire_flag,
inv_attribute_control_pvt.get_attribute_control('CONSIGNED_FLAG') consigned_flag,
inv_attribute_control_pvt.get_attribute_control('CONTINOUS_TRANSFER') continous_transfer,
inv_attribute_control_pvt.get_attribute_control('CONVERGENCE') convergence,
inv_attribute_control_pvt.get_attribute_control('CRITICAL_COMPONENT_FLAG') critical_component_flag,
inv_attribute_control_pvt.get_attribute_control('DAYS_MAX_INV_SUPPLY') days_max_inv_supply,
inv_attribute_control_pvt.get_attribute_control('DAYS_MAX_INV_WINDOW') days_max_inv_window,
inv_attribute_control_pvt.get_attribute_control('DAYS_TGT_INV_SUPPLY') days_tgt_inv_supply,
inv_attribute_control_pvt.get_attribute_control('DAYS_TGT_INV_WINDOW') days_tgt_inv_window,
inv_attribute_control_pvt.get_attribute_control('DIVERGENCE') divergence,
inv_attribute_control_pvt.get_attribute_control('DRP_PLANNED_FLAG') drp_planned_flag,
inv_attribute_control_pvt.get_attribute_control('EXCLUDE_FROM_BUDGET_FLAG') exclude_from_budget_flag,
inv_attribute_control_pvt.get_attribute_control('FORECAST_HORIZON') forecast_horizon,
inv_attribute_control_pvt.get_attribute_control('SO_AUTHORIZATION_FLAG') so_authorization_flag,
inv_attribute_control_pvt.get_attribute_control('VMI_FIXED_ORDER_QUANTITY') vmi_fixed_order_quantity,
inv_attribute_control_pvt.get_attribute_control('VMI_FORECAST_TYPE') vmi_forecast_type,
inv_attribute_control_pvt.get_attribute_control('VMI_MAXIMUM_DAYS') vmi_maximum_days,
inv_attribute_control_pvt.get_attribute_control('VMI_MAXIMUM_UNITS') vmi_maximum_units,
inv_attribute_control_pvt.get_attribute_control('VMI_MINIMUM_DAYS') vmi_minimum_days,
inv_attribute_control_pvt.get_attribute_control('VMI_MINIMUM_UNITS') vmi_minimum_units,
-- 7I
inv_attribute_control_pvt.get_attribute_control('CHILD_LOT_FLAG') child_lot_flag,
inv_attribute_control_pvt.get_attribute_control('CHILD_LOT_PREFIX') child_lot_prefix,
inv_attribute_control_pvt.get_attribute_control('CHILD_LOT_STARTING_NUMBER') child_lot_starting_number,
inv_attribute_control_pvt.get_attribute_control('CHILD_LOT_VALIDATION_FLAG') child_lot_validation_flag,
inv_attribute_control_pvt.get_attribute_control('COPY_LOT_ATTRIBUTE_FLAG') copy_lot_attribute_flag,
inv_attribute_control_pvt.get_attribute_control('DEFAULT_GRADE') default_grade,
inv_attribute_control_pvt.get_attribute_control('GRADE_CONTROL_FLAG') grade_control_flag,
inv_attribute_control_pvt.get_attribute_control('LOT_DIVISIBLE_FLAG') lot_divisible_flag,
inv_attribute_control_pvt.get_attribute_control('PARENT_CHILD_GENERATION_FLAG') parent_child_generation_flag,
inv_attribute_control_pvt.get_attribute_control('PROCESS_EXECUTION_ENABLED_FLAG') process_execution_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('PROCESS_QUALITY_ENABLED_FLAG') process_quality_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('RECIPE_ENABLED_FLAG') recipe_enabled_flag,
-- 7J
inv_attribute_control_pvt.get_attribute_control('CAS_NUMBER') cas_number,
inv_attribute_control_pvt.get_attribute_control('EXPIRATION_ACTION_CODE') expiration_action_code,
inv_attribute_control_pvt.get_attribute_control('EXPIRATION_ACTION_INTERVAL') expiration_action_interval,
inv_attribute_control_pvt.get_attribute_control('HAZARDOUS_MATERIAL_FLAG') hazardous_material_flag,
inv_attribute_control_pvt.get_attribute_control('HOLD_DAYS') hold_days,
inv_attribute_control_pvt.get_attribute_control('MATURITY_DAYS') maturity_days,
inv_attribute_control_pvt.get_attribute_control('PROCESS_COSTING_ENABLED_FLAG') process_costing_enabled_flag,
inv_attribute_control_pvt.get_attribute_control('RETEST_INTERVAL') retest_interval,
-- other
inv_attribute_control_pvt.get_attribute_control('DESC_FLEX') desc_flex,
inv_attribute_control_pvt.get_attribute_control('DUAL_UOM_CONTROL') dual_uom_control,
inv_attribute_control_pvt.get_attribute_control('EFFECTIVITY_CONTROL') effectivity_control,
inv_attribute_control_pvt.get_attribute_control('ENG_ITEM_FLAG') eng_item_flag,
inv_attribute_control_pvt.get_attribute_control('FIXED_DAYS_SUPPLY') fixed_days_supply,
inv_attribute_control_pvt.get_attribute_control('GLOBAL_DESC_FLEX') global_desc_flex,
inv_attribute_control_pvt.get_attribute_control('INDIVISIBLE_FLAG') indivisible_flag,
inv_attribute_control_pvt.get_attribute_control('INVENTORY_ASSET_FLAG') inventory_asset_flag,
inv_attribute_control_pvt.get_attribute_control('PRIMARY_UNIT_OF_MEASURE') primary_unit_of_measure,
inv_attribute_control_pvt.get_attribute_control('PROCESS_SUPPLY_LOCATOR_ID') process_supply_locator_id,
inv_attribute_control_pvt.get_attribute_control('PROCESS_SUPPLY_SUBINVENTORY') process_supply_subinventory,
inv_attribute_control_pvt.get_attribute_control('PROCESS_YIELD_LOCATOR_ID') process_yield_locator_id,
inv_attribute_control_pvt.get_attribute_control('PROCESS_YIELD_SUBINVENTORY') process_yield_subinventory,
inv_attribute_control_pvt.get_attribute_control('SERIAL_TAGGING_FLAG') serial_tagging_flag,
inv_attribute_control_pvt.get_attribute_control('SERVICE_ITEM_FLAG') service_item_flag,
inv_attribute_control_pvt.get_attribute_control('USAGE_ITEM_FLAG') usage_item_flag,
inv_attribute_control_pvt.get_attribute_control('VENDOR_WARRANTY_FLAG') vendor_warranty_flag,
inv_attribute_control_pvt.get_attribute_control('WEB_STATUS') web_status,
--
'.' eol
from
dual
)
select
msi.concatenated_segments item,
mpm.organization_code master_organization_code,
mp.organization_code,
--
-- 1A
decode(decode(iacl.accounting_rule_id,1,nvl(msim.accounting_rule_id,-1),nvl(msi.accounting_rule_id,-1)),nvl(msi.accounting_rule_id,-1),'','M:[' ||msim.accounting_rule_id || '] C:[' || msi.accounting_rule_id || ']' ) accounting_rule_id,
decode(decode(iacl.buyer_id,1,nvl(msim.buyer_id,-1),nvl(msi.buyer_id,-1)),nvl(msi.buyer_id,-1),'','M:[' ||msim.buyer_id || '] C:[' || msi.buyer_id || ']' ) buyer_id,
decode(decode(iacl.customer_order_flag,1,nvl(msim.customer_order_flag,-1),nvl(msi.customer_order_flag,-1)),nvl(msi.customer_order_flag,-1),'','M:[' ||msim.customer_order_flag || '] C:[' || msi.customer_order_flag || ']' ) customer_order_flag,
decode(decode(iacl.internal_order_flag,1,nvl(msim.internal_order_flag,-1),nvl(msi.internal_order_flag,-1)),nvl(msi.internal_order_flag,-1),'','M:[' ||msim.internal_order_flag || '] C:[' || msi.internal_order_flag || ']' ) internal_order_flag,
decode(decode(iacl.inventory_item_flag,1,nvl(msim.inventory_item_flag,-1),nvl(msi.inventory_item_flag,-1)),nvl(msi.inventory_item_flag,-1),'','M:[' ||msim.inventory_item_flag || '] C:[' || msi.inventory_item_flag || ']' ) inventory_item_flag,
decode(decode(iacl.invoicing_rule_id,1,nvl(msim.invoicing_rule_id,-1),nvl(msi.invoicing_rule_id,-1)),nvl(msi.invoicing_rule_id,-1),'','M:[' ||msim.invoicing_rule_id || '] C:[' || msi.invoicing_rule_id || ']' ) invoicing_rule_id,
decode(decode(iacl.purchasing_item_flag,1,nvl(msim.purchasing_item_flag,-1),nvl(msi.purchasing_item_flag,-1)),nvl(msi.purchasing_item_flag,-1),'','M:[' ||msim.purchasing_item_flag || '] C:[' || msi.purchasing_item_flag || ']' ) purchasing_item_flag,
decode(decode(iacl.shippable_item_flag,1,nvl(msim.shippable_item_flag,-1),nvl(msi.shippable_item_flag,-1)),nvl(msi.shippable_item_flag,-1),'','M:[' ||msim.shippable_item_flag || '] C:[' || msi.shippable_item_flag || ']' ) shippable_item_flag,
-- 1B
decode(decode(iacl.bom_enabled_flag,1,nvl(msim.bom_enabled_flag,-1),nvl(msi.bom_enabled_flag,-1)),nvl(msi.bom_enabled_flag,-1),'','M:[' ||msim.bom_enabled_flag || '] C:[' || msi.bom_enabled_flag || ']' ) bom_enabled_flag,
decode(decode(iacl.build_in_wip_flag,1,nvl(msim.build_in_wip_flag,-1),nvl(msi.build_in_wip_flag,-1)),nvl(msi.build_in_wip_flag,-1),'','M:[' ||msim.build_in_wip_flag || '] C:[' || msi.build_in_wip_flag || ']' ) build_in_wip_flag,
decode(decode(iacl.check_shortages_flag,1,nvl(msim.check_shortages_flag,-1),nvl(msi.check_shortages_flag,-1)),nvl(msi.check_shortages_flag,-1),'','M:[' ||msim.check_shortages_flag || '] C:[' || msi.check_shortages_flag || ']' ) check_shortages_flag,
decode(decode(iacl.item_catalog_group_id,1,nvl(msim.item_catalog_group_id,-1),nvl(msi.item_catalog_group_id,-1)),nvl(msi.item_catalog_group_id,-1),'','M:[' ||msim.item_catalog_group_id || '] C:[' || msi.item_catalog_group_id || ']' ) item_catalog_group_id,
decode(decode(iacl.revision_qty_control_code,1,nvl(msim.revision_qty_control_code,-1),nvl(msi.revision_qty_control_code,-1)),nvl(msi.revision_qty_control_code,-1),'','M:[' ||msim.revision_qty_control_code || '] C:[' || msi.revision_qty_control_code || ']' ) revision_qty_control_code,
decode(decode(iacl.stock_enabled_flag,1,nvl(msim.stock_enabled_flag,-1),nvl(msi.stock_enabled_flag,-1)),nvl(msi.stock_enabled_flag,-1),'','M:[' ||msim.stock_enabled_flag || '] C:[' || msi.stock_enabled_flag || ']' ) stock_enabled_flag,
-- 1C
decode(decode(iacl.customer_order_enabled_flag,1,nvl(msim.customer_order_enabled_flag,-1),nvl(msi.customer_order_enabled_flag,-1)),nvl(msi.customer_order_enabled_flag,-1),'','M:[' ||msim.customer_order_enabled_flag || '] C:[' || msi.customer_order_enabled_flag || ']' ) customer_order_enabled_flag,
decode(decode(iacl.internal_order_enabled_flag,1,nvl(msim.internal_order_enabled_flag,-1),nvl(msi.internal_order_enabled_flag,-1)),nvl(msi.internal_order_enabled_flag,-1),'','M:[' ||msim.internal_order_enabled_flag || '] C:[' || msi.internal_order_enabled_flag || ']' ) internal_order_enabled_flag,
decode(decode(iacl.mtl_transactions_enabled_flag,1,nvl(msim.mtl_transactions_enabled_flag,-1),nvl(msi.mtl_transactions_enabled_flag,-1)),nvl(msi.mtl_transactions_enabled_flag,-1),'','M:[' ||msim.mtl_transactions_enabled_flag || '] C:[' || msi.mtl_transactions_enabled_flag || ']' ) mtl_transactions_enabled_flag,
decode(decode(iacl.purchasing_enabled_flag,1,nvl(msim.purchasing_enabled_flag,-1),nvl(msi.purchasing_enabled_flag,-1)),nvl(msi.purchasing_enabled_flag,-1),'','M:[' ||msim.purchasing_enabled_flag || '] C:[' || msi.purchasing_enabled_flag || ']' ) purchasing_enabled_flag,
decode(decode(iacl.so_transactions_flag,1,nvl(msim.so_transactions_flag,-1),nvl(msi.so_transactions_flag,-1)),nvl(msi.so_transactions_flag,-1),'','M:[' ||msim.so_transactions_flag || '] C:[' || msi.so_transactions_flag || ']' ) so_transactions_flag,
-- 1D
decode(decode(iacl.allow_item_desc_update_flag,1,nvl(msim.allow_item_desc_update_flag,-1),nvl(msi.allow_item_desc_update_flag,-1)),nvl(msi.allow_item_desc_update_flag,-1),'','M:[' ||msim.allow_item_desc_update_flag || '] C:[' || msi.allow_item_desc_update_flag || ']' ) allow_item_desc_update_flag,
decode(decode(iacl.catalog_status_flag,1,nvl(msim.catalog_status_flag,-1),nvl(msi.catalog_status_flag,-1)),nvl(msi.catalog_status_flag,-1),'','M:[' ||msim.catalog_status_flag || '] C:[' || msi.catalog_status_flag || ']' ) catalog_status_flag,
decode(decode(iacl.collateral_flag,1,nvl(msim.collateral_flag,-1),nvl(msi.collateral_flag,-1)),nvl(msi.collateral_flag,-1),'','M:[' ||msim.collateral_flag || '] C:[' || msi.collateral_flag || ']' ) collateral_flag,
decode(decode(iacl.default_shipping_org,1,nvl(msim.default_shipping_org,-1),nvl(msi.default_shipping_org,-1)),nvl(msi.default_shipping_org,-1),'','M:[' ||msim.default_shipping_org || '] C:[' || msi.default_shipping_org || ']' ) default_shipping_org,
decode(decode(iacl.inspection_required_flag,1,nvl(msim.inspection_required_flag,-1),nvl(msi.inspection_required_flag,-1)),nvl(msi.inspection_required_flag,-1),'','M:[' ||msim.inspection_required_flag || '] C:[' || msi.inspection_required_flag || ']' ) inspection_required_flag,
decode(decode(iacl.market_price,1,nvl(msim.market_price,-1),nvl(msi.market_price,-1)),nvl(msi.market_price,-1),'','M:[' ||msim.market_price || '] C:[' || msi.market_price || ']' ) market_price,
decode(decode(iacl.purchasing_tax_code,1,nvl(msim.purchasing_tax_code,-1),nvl(msi.purchasing_tax_code,-1)),nvl(msi.purchasing_tax_code,-1),'','M:[' ||msim.purchasing_tax_code || '] C:[' || msi.purchasing_tax_code || ']' ) purchasing_tax_code,
decode(decode(iacl.qty_rcv_exception_code,1,nvl(msim.qty_rcv_exception_code,-1),nvl(msi.qty_rcv_exception_code,-1)),nvl(msi.qty_rcv_exception_code,-1),'','M:[' ||msim.qty_rcv_exception_code || '] C:[' || msi.qty_rcv_exception_code || ']' ) qty_rcv_exception_code,
decode(decode(iacl.receipt_required_flag,1,nvl(msim.receipt_required_flag,-1),nvl(msi.receipt_required_flag,-1)),nvl(msi.receipt_required_flag,-1),'','M:[' ||msim.receipt_required_flag || '] C:[' || msi.receipt_required_flag || ']' ) receipt_required_flag,
decode(decode(iacl.returnable_flag,1,nvl(msim.returnable_flag,-1),nvl(msi.returnable_flag,-1)),nvl(msi.returnable_flag,-1),'','M:[' ||msim.returnable_flag || '] C:[' || msi.returnable_flag || ']' ) returnable_flag,
decode(decode(iacl.taxable_flag,1,nvl(msim.taxable_flag,-1),nvl(msi.taxable_flag,-1)),nvl(msi.taxable_flag,-1),'','M:[' ||msim.taxable_flag || '] C:[' || msi.taxable_flag || ']' ) taxable_flag,
-- 1E
decode(decode(iacl.asset_category_id,1,nvl(msim.asset_category_id,-1),nvl(msi.asset_category_id,-1)),nvl(msi.asset_category_id,-1),'','M:[' ||msim.asset_category_id || '] C:[' || msi.asset_category_id || ']' ) asset_category_id,
decode(decode(iacl.enforce_ship_to_location_code,1,nvl(msim.enforce_ship_to_location_code,-1),nvl(msi.enforce_ship_to_location_code,-1)),nvl(msi.enforce_ship_to_location_code,-1),'','M:[' ||msim.enforce_ship_to_location_code || '] C:[' || msi.enforce_ship_to_location_code || ']' ) enforce_ship_to_location_code,
decode(decode(iacl.hazard_class_id,1,nvl(msim.hazard_class_id,-1),nvl(msi.hazard_class_id,-1)),nvl(msi.hazard_class_id,-1),'','M:[' ||msim.hazard_class_id || '] C:[' || msi.hazard_class_id || ']' ) hazard_class_id,
decode(decode(iacl.list_price_per_unit,1,nvl(msim.list_price_per_unit,-1),nvl(msi.list_price_per_unit,-1)),nvl(msi.list_price_per_unit,-1),'','M:[' ||msim.list_price_per_unit || '] C:[' || msi.list_price_per_unit || ']' ) list_price_per_unit,
decode(decode(iacl.price_tolerance_percent,1,nvl(msim.price_tolerance_percent,-1),nvl(msi.price_tolerance_percent,-1)),nvl(msi.price_tolerance_percent,-1),'','M:[' ||msim.price_tolerance_percent || '] C:[' || msi.price_tolerance_percent || ']' ) price_tolerance_percent,
decode(decode(iacl.qty_rcv_tolerance,1,nvl(msim.qty_rcv_tolerance,-1),nvl(msi.qty_rcv_tolerance,-1)),nvl(msi.qty_rcv_tolerance,-1),'','M:[' ||msim.qty_rcv_tolerance || '] C:[' || msi.qty_rcv_tolerance || ']' ) qty_rcv_tolerance,
decode(decode(iacl.rfq_required_flag,1,nvl(msim.rfq_required_flag,-1),nvl(msi.rfq_required_flag,-1)),nvl(msi.rfq_required_flag,-1),'','M:[' ||msim.rfq_required_flag || '] C:[' || msi.rfq_required_flag || ']' ) rfq_required_flag,
decode(decode(iacl.rounding_factor,1,nvl(msim.rounding_factor,-1),nvl(msi.rounding_factor,-1)),nvl(msi.rounding_factor,-1),'','M:[' ||msim.rounding_factor || '] C:[' || msi.rounding_factor || ']' ) rounding_factor,
decode(decode(iacl.un_number_id,1,nvl(msim.un_number_id,-1),nvl(msi.un_number_id,-1)),nvl(msi.un_number_id,-1),'','M:[' ||msim.un_number_id || '] C:[' || msi.un_number_id || ']' ) un_number_id,
decode(decode(iacl.unit_of_issue,1,nvl(msim.unit_of_issue,-1),nvl(msi.unit_of_issue,-1)),nvl(msi.unit_of_issue,-1),'','M:[' ||msim.unit_of_issue || '] C:[' || msi.unit_of_issue || ']' ) unit_of_issue,
-- 1F
decode(decode(iacl.allow_express_delivery_flag,1,nvl(msim.allow_express_delivery_flag,-1),nvl(msi.allow_express_delivery_flag,-1)),nvl(msi.allow_express_delivery_flag,-1),'','M:[' ||msim.allow_express_delivery_flag || '] C:[' || msi.allow_express_delivery_flag || ']' ) allow_express_delivery_flag,
decode(decode(iacl.allow_substitute_receipts_flag,1,nvl(msim.allow_substitute_receipts_flag,-1),nvl(msi.allow_substitute_receipts_flag,-1)),nvl(msi.allow_substitute_receipts_flag,-1),'','M:[' ||msim.allow_substitute_receipts_flag || '] C:[' || msi.allow_substitute_receipts_flag || ']' ) allow_substitute_receipts_flag,
decode(decode(iacl.allow_unordered_receipts_flag,1,nvl(msim.allow_unordered_receipts_flag,-1),nvl(msi.allow_unordered_receipts_flag,-1)),nvl(msi.allow_unordered_receipts_flag,-1),'','M:[' ||msim.allow_unordered_receipts_flag || '] C:[' || msi.allow_unordered_receipts_flag || ']' ) allow_unordered_receipts_flag,
decode(decode(iacl.days_early_receipt_allowed,1,nvl(msim.days_early_receipt_allowed,-1),nvl(msi.days_early_receipt_allowed,-1)),nvl(msi.days_early_receipt_allowed,-1),'','M:[' ||msim.days_early_receipt_allowed || '] C:[' || msi.days_early_receipt_allowed || ']' ) days_early_receipt_allowed,
decode(decode(iacl.days_late_receipt_allowed,1,nvl(msim.days_late_receipt_allowed,-1),nvl(msi.days_late_receipt_allowed,-1)),nvl(msi.days_late_receipt_allowed,-1),'','M:[' ||msim.days_late_receipt_allowed || '] C:[' || msi.days_late_receipt_allowed || ']' ) days_late_receipt_allowed,
-- 1G
decode(decode(iacl.auto_lot_alpha_prefix,1,nvl(msim.auto_lot_alpha_prefix,-1),nvl(msi.auto_lot_alpha_prefix,-1)),nvl(msi.auto_lot_alpha_prefix,-1),'','M:[' ||msim.auto_lot_alpha_prefix || '] C:[' || msi.auto_lot_alpha_prefix || ']' ) auto_lot_alpha_prefix,
decode(decode(iacl.description,1,nvl(msim.description,-1),nvl(msi.description,-1)),nvl(msi.description,-1),'','M:[' ||msim.description || '] C:[' || msi.description || ']' ) description,
decode(decode(iacl.invoice_close_tolerance,1,nvl(msim.invoice_close_tolerance,-1),nvl(msi.invoice_close_tolerance,-1)),nvl(msi.invoice_close_tolerance,-1),'','M:[' ||msim.invoice_close_tolerance || '] C:[' || msi.invoice_close_tolerance || ']' ) invoice_close_tolerance,
decode(decode(iacl.long_description,1,nvl(msim.long_description,-1),nvl(msi.long_description,-1)),nvl(msi.long_description,-1),'','M:[' ||msim.long_description || '] C:[' || msi.long_description || ']' ) long_description,
decode(decode(iacl.receipt_days_exception_code,1,nvl(msim.receipt_days_exception_code,-1),nvl(msi.receipt_days_exception_code,-1)),nvl(msi.receipt_days_exception_code,-1),'','M:[' ||msim.receipt_days_exception_code || '] C:[' || msi.receipt_days_exception_code || ']' ) receipt_days_exception_code,
decode(decode(iacl.receive_close_tolerance,1,nvl(msim.receive_close_tolerance,-1),nvl(msi.receive_close_tolerance,-1)),nvl(msi.receive_close_tolerance,-1),'','M:[' ||msim.receive_close_tolerance || '] C:[' || msi.receive_close_tolerance || ']' ) receive_close_tolerance,
decode(decode(iacl.receiving_routing_id,1,nvl(msim.receiving_routing_id,-1),nvl(msi.receiving_routing_id,-1)),nvl(msi.receiving_routing_id,-1),'','M:[' ||msim.receiving_routing_id || '] C:[' || msi.receiving_routing_id || ']' ) receiving_routing_id,
-- 1HA
decode(decode(iacl.over_shipment_tolerance,1,nvl(msim.over_shipment_tolerance,-1),nvl(msi.over_shipment_tolerance,-1)),nvl(msi.over_shipment_tolerance,-1),'','M:[' ||msim.over_shipment_tolerance || '] C:[' || msi.over_shipment_tolerance || ']' ) over_shipment_tolerance,
decode(decode(iacl.overcompletion_tolerance_type,1,nvl(msim.overcompletion_tolerance_type,-1),nvl(msi.overcompletion_tolerance_type,-1)),nvl(msi.overcompletion_tolerance_type,-1),'','M:[' ||msim.overcompletion_tolerance_type || '] C:[' || msi.overcompletion_tolerance_type || ']' ) overcompletion_tolerance_type,
decode(decode(iacl.overcompletion_tolerance_value,1,nvl(msim.overcompletion_tolerance_value,-1),nvl(msi.overcompletion_tolerance_value,-1)),nvl(msi.overcompletion_tolerance_value,-1),'','M:[' ||msim.overcompletion_tolerance_value || '] C:[' || msi.overcompletion_tolerance_value || ']' ) overcompletion_tolerance_value,
decode(decode(iacl.under_shipment_tolerance,1,nvl(msim.under_shipment_tolerance,-1),nvl(msi.under_shipment_tolerance,-1)),nvl(msi.under_shipment_tolerance,-1),'','M:[' ||msim.under_shipment_tolerance || '] C:[' || msi.under_shipment_tolerance || ']' ) under_shipment_tolerance,
-- 1HB
decode(decode(iacl.defect_tracking_on_flag,1,nvl(msim.defect_tracking_on_flag,-1),nvl(msi.defect_tracking_on_flag,-1)),nvl(msi.defect_tracking_on_flag,-1),'','M:[' ||msim.defect_tracking_on_flag || '] C:[' || msi.defect_tracking_on_flag || ']' ) defect_tracking_on_flag,
decode(decode(iacl.equipment_type,1,nvl(msim.equipment_type,-1),nvl(msi.equipment_type,-1)),nvl(msi.equipment_type,-1),'','M:[' ||msim.equipment_type || '] C:[' || msi.equipment_type || ']' ) equipment_type,
decode(decode(iacl.over_return_tolerance,1,nvl(msim.over_return_tolerance,-1),nvl(msi.over_return_tolerance,-1)),nvl(msi.over_return_tolerance,-1),'','M:[' ||msim.over_return_tolerance || '] C:[' || msi.over_return_tolerance || ']' ) over_return_tolerance,
decode(decode(iacl.recovered_part_disp_code,1,nvl(msim.recovered_part_disp_code,-1),nvl(msi.recovered_part_disp_code,-1)),nvl(msi.recovered_part_disp_code,-1),'','M:[' ||msim.recovered_part_disp_code || '] C:[' || msi.recovered_part_disp_code || ']' ) recovered_part_disp_code,
decode(decode(iacl.under_return_tolerance,1,nvl(msim.under_return_tolerance,-1),nvl(msi.under_return_tolerance,-1)),nvl(msi.under_return_tolerance,-1),'','M:[' ||msim.under_return_tolerance || '] C:[' || msi.under_return_tolerance || ']' ) under_return_tolerance,
-- 1HC
decode(decode(iacl.coupon_exempt_flag,1,nvl(msim.coupon_exempt_flag,-1),nvl(msi.coupon_exempt_flag,-1)),nvl(msi.coupon_exempt_flag,-1),'','M:[' ||msim.coupon_exempt_flag || '] C:[' || msi.coupon_exempt_flag || ']' ) coupon_exempt_flag,
decode(decode(iacl.downloadable_flag,1,nvl(msim.downloadable_flag,-1),nvl(msi.downloadable_flag,-1)),nvl(msi.downloadable_flag,-1),'','M:[' ||msim.downloadable_flag || '] C:[' || msi.downloadable_flag || ']' ) downloadable_flag,
decode(decode(iacl.electronic_flag,1,nvl(msim.electronic_flag,-1),nvl(msi.electronic_flag,-1)),nvl(msi.electronic_flag,-1),'','M:[' ||msim.electronic_flag || '] C:[' || msi.electronic_flag || ']' ) electronic_flag,
decode(decode(iacl.event_flag,1,nvl(msim.event_flag,-1),nvl(msi.event_flag,-1)),nvl(msi.event_flag,-1),'','M:[' ||msim.event_flag || '] C:[' || msi.event_flag || ']' ) event_flag,
decode(decode(iacl.vol_discount_exempt_flag,1,nvl(msim.vol_discount_exempt_flag,-1),nvl(msi.vol_discount_exempt_flag,-1)),nvl(msi.vol_discount_exempt_flag,-1),'','M:[' ||msim.vol_discount_exempt_flag || '] C:[' || msi.vol_discount_exempt_flag || ']' ) vol_discount_exempt_flag,
-- 1HD
decode(decode(iacl.asset_creation_code,1,nvl(msim.asset_creation_code,-1),nvl(msi.asset_creation_code,-1)),nvl(msi.asset_creation_code,-1),'','M:[' ||msim.asset_creation_code || '] C:[' || msi.asset_creation_code || ']' ) asset_creation_code,
decode(decode(iacl.back_orderable_flag,1,nvl(msim.back_orderable_flag,-1),nvl(msi.back_orderable_flag,-1)),nvl(msi.back_orderable_flag,-1),'','M:[' ||msim.back_orderable_flag || '] C:[' || msi.back_orderable_flag || ']' ) back_orderable_flag,
decode(decode(iacl.comms_activation_reqd_flag,1,nvl(msim.comms_activation_reqd_flag,-1),nvl(msi.comms_activation_reqd_flag,-1)),nvl(msi.comms_activation_reqd_flag,-1),'','M:[' ||msim.comms_activation_reqd_flag || '] C:[' || msi.comms_activation_reqd_flag || ']' ) comms_activation_reqd_flag,
decode(decode(iacl.comms_nl_trackable_flag,1,nvl(msim.comms_nl_trackable_flag,-1),nvl(msi.comms_nl_trackable_flag,-1)),nvl(msi.comms_nl_trackable_flag,-1),'','M:[' ||msim.comms_nl_trackable_flag || '] C:[' || msi.comms_nl_trackable_flag || ']' ) comms_nl_trackable_flag,
&lp_ib_item_tracking_level_sel --decode(decode(iacl.ib_item_tracking_level,1,nvl(msim.ib_item_tracking_level,-1),nvl(msi.ib_item_tracking_level,-1)),nvl(msi.ib_item_tracking_level,-1),'','M:[' ||msim.ib_item_tracking_level || '] C:[' || msi.ib_item_tracking_level || ']' ) ib_item_tracking_level,
decode(decode(iacl.orderable_on_web_flag,1,nvl(msim.orderable_on_web_flag,-1),nvl(msi.orderable_on_web_flag,-1)),nvl(msi.orderable_on_web_flag,-1),'','M:[' ||msim.orderable_on_web_flag || '] C:[' || msi.orderable_on_web_flag || ']' ) orderable_on_web_flag,
-- 1IA
decode(decode(iacl.bulk_picked_flag,1,nvl(msim.bulk_picked_flag,-1),nvl(msi.bulk_picked_flag,-1)),nvl(msi.bulk_picked_flag,-1),'','M:[' ||msim.bulk_picked_flag || '] C:[' || msi.bulk_picked_flag || ']' ) bulk_picked_flag,
decode(decode(iacl.default_lot_status_id,1,nvl(msim.default_lot_status_id,-1),nvl(msi.default_lot_status_id,-1)),nvl(msi.default_lot_status_id,-1),'','M:[' ||msim.default_lot_status_id || '] C:[' || msi.default_lot_status_id || ']' ) default_lot_status_id,
decode(decode(iacl.dimension_uom_code,1,nvl(msim.dimension_uom_code,-1),nvl(msi.dimension_uom_code,-1)),nvl(msi.dimension_uom_code,-1),'','M:[' ||msim.dimension_uom_code || '] C:[' || msi.dimension_uom_code || ']' ) dimension_uom_code,
decode(decode(iacl.lot_status_enabled,1,nvl(msim.lot_status_enabled,-1),nvl(msi.lot_status_enabled,-1)),nvl(msi.lot_status_enabled,-1),'','M:[' ||msim.lot_status_enabled || '] C:[' || msi.lot_status_enabled || ']' ) lot_status_enabled,
decode(decode(iacl.unit_height,1,nvl(msim.unit_height,-1),nvl(msi.unit_height,-1)),nvl(msi.unit_height,-1),'','M:[' ||msim.unit_height || '] C:[' || msi.unit_height || ']' ) unit_height,
decode(decode(iacl.unit_length,1,nvl(msim.unit_length,-1),nvl(msi.unit_length,-1)),nvl(msi.unit_length,-1),'','M:[' ||msim.unit_length || '] C:[' || msi.unit_length || ']' ) unit_length,
decode(decode(iacl.unit_width,1,nvl(msim.unit_width,-1),nvl(msi.unit_width,-1)),nvl(msi.unit_width,-1),'','M:[' ||msim.unit_width || '] C:[' || msi.unit_width || ']' ) unit_width,
-- 1IB
decode(decode(iacl.default_material_status_id,1,nvl(msim.default_material_status_id,-1),nvl(msi.default_material_status_id,-1)),nvl(msi.default_material_status_id,-1),'','M:[' ||msim.default_material_status_id || '] C:[' || msi.default_material_status_id || ']' ) default_material_status_id,
decode(decode(iacl.default_serial_status_id,1,nvl(msim.default_serial_status_id,-1),nvl(msi.default_serial_status_id,-1)),nvl(msi.default_serial_status_id,-1),'','M:[' ||msim.default_serial_status_id || '] C:[' || msi.default_serial_status_id || ']' ) default_serial_status_id,
decode(decode(iacl.lot_merge_enabled,1,nvl(msim.lot_merge_enabled,-1),nvl(msi.lot_merge_enabled,-1)),nvl(msi.lot_merge_enabled,-1),'','M:[' ||msim.lot_merge_enabled || '] C:[' || msi.lot_merge_enabled || ']' ) lot_merge_enabled,
decode(decode(iacl.lot_split_enabled,1,nvl(msim.lot_split_enabled,-1),nvl(msi.lot_split_enabled,-1)),nvl(msi.lot_split_enabled,-1),'','M:[' ||msim.lot_split_enabled || '] C:[' || msi.lot_split_enabled || ']' ) lot_split_enabled,
&lp_mcc_classification_type_sel --decode(decode(iacl.mcc_classification_type,1,nvl(msim.mcc_classification_type,-1),nvl(msi.mcc_classification_type,-1)),nvl(msi.mcc_classification_type,-1),'','M:[' ||msim.mcc_classification_type || '] C:[' || msi.mcc_classification_type || ']' ) mcc_classification_type,
decode(decode(iacl.serial_status_enabled,1,nvl(msim.serial_status_enabled,-1),nvl(msi.serial_status_enabled,-1)),nvl(msi.serial_status_enabled,-1),'','M:[' ||msim.serial_status_enabled || '] C:[' || msi.serial_status_enabled || ']' ) serial_status_enabled,
-- 1IC
decode(decode(iacl.financing_allowed_flag,1,nvl(msim.financing_allowed_flag,-1),nvl(msi.financing_allowed_flag,-1)),nvl(msi.financing_allowed_flag,-1),'','M:[' ||msim.financing_allowed_flag || '] C:[' || msi.financing_allowed_flag || ']' ) financing_allowed_flag,
decode(decode(iacl.inventory_carry_penalty,1,nvl(msim.inventory_carry_penalty,-1),nvl(msi.inventory_carry_penalty,-1)),nvl(msi.inventory_carry_penalty,-1),'','M:[' ||msim.inventory_carry_penalty || '] C:[' || msi.inventory_carry_penalty || ']' ) inventory_carry_penalty,
decode(decode(iacl.operation_slack_penalty,1,nvl(msim.operation_slack_penalty,-1),nvl(msi.operation_slack_penalty,-1)),nvl(msi.operation_slack_penalty,-1),'','M:[' ||msim.operation_slack_penalty || '] C:[' || msi.operation_slack_penalty || ']' ) operation_slack_penalty,
-- 1IJ
decode(decode(iacl.contract_item_type_code,1,nvl(msim.contract_item_type_code,-1),nvl(msi.contract_item_type_code,-1)),nvl(msi.contract_item_type_code,-1),'','M:[' ||msim.contract_item_type_code || '] C:[' || msi.contract_item_type_code || ']' ) contract_item_type_code,
decode(decode(iacl.dual_uom_deviation_high,1,nvl(msim.dual_uom_deviation_high,-1),nvl(msi.dual_uom_deviation_high,-1)),nvl(msi.dual_uom_deviation_high,-1),'','M:[' ||msim.dual_uom_deviation_high || '] C:[' || msi.dual_uom_deviation_high || ']' ) dual_uom_deviation_high,
decode(decode(iacl.dual_uom_deviation_low,1,nvl(msim.dual_uom_deviation_low,-1),nvl(msi.dual_uom_deviation_low,-1)),nvl(msi.dual_uom_deviation_low,-1),'','M:[' ||msim.dual_uom_deviation_low || '] C:[' || msi.dual_uom_deviation_low || ']' ) dual_uom_deviation_low,
decode(decode(iacl.eam_act_notification_flag,1,nvl(msim.eam_act_notification_flag,-1),nvl(msi.eam_act_notification_flag,-1)),nvl(msi.eam_act_notification_flag,-1),'','M:[' ||msim.eam_act_notification_flag || '] C:[' || msi.eam_act_notification_flag || ']' ) eam_act_notification_flag,
decode(decode(iacl.eam_act_shutdown_status,1,nvl(msim.eam_act_shutdown_status,-1),nvl(msi.eam_act_shutdown_status,-1)),nvl(msi.eam_act_shutdown_status,-1),'','M:[' ||msim.eam_act_shutdown_status || '] C:[' || msi.eam_act_shutdown_status || ']' ) eam_act_shutdown_status,
decode(decode(iacl.eam_activity_cause_code,1,nvl(msim.eam_activity_cause_code,-1),nvl(msi.eam_activity_cause_code,-1)),nvl(msi.eam_activity_cause_code,-1),'','M:[' ||msim.eam_activity_cause_code || '] C:[' || msi.eam_activity_cause_code || ']' ) eam_activity_cause_code,
decode(decode(iacl.eam_activity_type_code,1,nvl(msim.eam_activity_type_code,-1),nvl(msi.eam_activity_type_code,-1)),nvl(msi.eam_activity_type_code,-1),'','M:[' ||msim.eam_activity_type_code || '] C:[' || msi.eam_activity_type_code || ']' ) eam_activity_type_code,
decode(decode(iacl.eam_item_type,1,nvl(msim.eam_item_type,-1),nvl(msi.eam_item_type,-1)),nvl(msi.eam_item_type,-1),'','M:[' ||msim.eam_item_type || '] C:[' || msi.eam_item_type || ']' ) eam_item_type,
decode(decode(iacl.secondary_uom_code,1,nvl(msim.secondary_uom_code,-1),nvl(msi.secondary_uom_code,-1)),nvl(msi.secondary_uom_code,-1),'','M:[' ||msim.secondary_uom_code || '] C:[' || msi.secondary_uom_code || ']' ) secondary_uom_code,
-- 1IK
decode(decode(iacl.create_supply_flag,1,nvl(msim.create_supply_flag,-1),nvl(msi.create_supply_flag,-1)),nvl(msi.create_supply_flag,-1),'','M:[' ||msim.create_supply_flag || '] C:[' || msi.create_supply_flag || ']' ) create_supply_flag,
decode(decode(iacl.default_so_source_type,1,nvl(msim.default_so_source_type,-1),nvl(msi.default_so_source_type,-1)),nvl(msi.default_so_source_type,-1),'','M:[' ||msim.default_so_source_type || '] C:[' || msi.default_so_source_type || ']' ) default_so_source_type,
decode(decode(iacl.lot_translate_enabled,1,nvl(msim.lot_translate_enabled,-1),nvl(msi.lot_translate_enabled,-1)),nvl(msi.lot_translate_enabled,-1),'','M:[' ||msim.lot_translate_enabled || '] C:[' || msi.lot_translate_enabled || ']' ) lot_translate_enabled,
decode(decode(iacl.planned_inv_point_flag,1,nvl(msim.planned_inv_point_flag,-1),nvl(msi.planned_inv_point_flag,-1)),nvl(msi.planned_inv_point_flag,-1),'','M:[' ||msim.planned_inv_point_flag || '] C:[' || msi.planned_inv_point_flag || ']' ) planned_inv_point_flag,
decode(decode(iacl.serv_billing_enabled_flag,1,nvl(msim.serv_billing_enabled_flag,-1),nvl(msi.serv_billing_enabled_flag,-1)),nvl(msi.serv_billing_enabled_flag,-1),'','M:[' ||msim.serv_billing_enabled_flag || '] C:[' || msi.serv_billing_enabled_flag || ']' ) serv_billing_enabled_flag,
decode(decode(iacl.serv_req_enabled_code,1,nvl(msim.serv_req_enabled_code,-1),nvl(msi.serv_req_enabled_code,-1)),nvl(msi.serv_req_enabled_code,-1),'','M:[' ||msim.serv_req_enabled_code || '] C:[' || msi.serv_req_enabled_code || ']' ) serv_req_enabled_code,
decode(decode(iacl.substitution_window_code,1,nvl(msim.substitution_window_code,-1),nvl(msi.substitution_window_code,-1)),nvl(msi.substitution_window_code,-1),'','M:[' ||msim.substitution_window_code || '] C:[' || msi.substitution_window_code || ']' ) substitution_window_code,
decode(decode(iacl.substitution_window_days,1,nvl(msim.substitution_window_days,-1),nvl(msi.substitution_window_days,-1)),nvl(msi.substitution_window_days,-1),'','M:[' ||msim.substitution_window_days || '] C:[' || msi.substitution_window_days || ']' ) substitution_window_days,
-- 4A
decode(decode(iacl.auto_serial_alpha_prefix,1,nvl(msim.auto_serial_alpha_prefix,-1),nvl(msi.auto_serial_alpha_prefix,-1)),nvl(msi.auto_serial_alpha_prefix,-1),'','M:[' ||msim.auto_serial_alpha_prefix || '] C:[' || msi.auto_serial_alpha_prefix || ']' ) auto_serial_alpha_prefix,
decode(decode(iacl.lot_control_code,1,nvl(msim.lot_control_code,-1),nvl(msi.lot_control_code,-1)),nvl(msi.lot_control_code,-1),'','M:[' ||msim.lot_control_code || '] C:[' || msi.lot_control_code || ']' ) lot_control_code,
decode(decode(iacl.serial_number_control_code,1,nvl(msim.serial_number_control_code,-1),nvl(msi.serial_number_control_code,-1)),nvl(msi.serial_number_control_code,-1),'','M:[' ||msim.serial_number_control_code || '] C:[' || msi.serial_number_control_code || ']' ) serial_number_control_code,
decode(decode(iacl.shelf_life_code,1,nvl(msim.shelf_life_code,-1),nvl(msi.shelf_life_code,-1)),nvl(msi.shelf_life_code,-1),'','M:[' ||msim.shelf_life_code || '] C:[' || msi.shelf_life_code || ']' ) shelf_life_code,
decode(decode(iacl.shelf_life_days,1,nvl(msim.shelf_life_days,-1),nvl(msi.shelf_life_days,-1)),nvl(msi.shelf_life_days,-1),'','M:[' ||msim.shelf_life_days || '] C:[' || msi.shelf_life_days || ']' ) shelf_life_days,
decode(decode(iacl.start_auto_lot_number,1,nvl(msim.start_auto_lot_number,-1),nvl(msi.start_auto_lot_number,-1)),nvl(msi.start_auto_lot_number,-1),'','M:[' ||msim.start_auto_lot_number || '] C:[' || msi.start_auto_lot_number || ']' ) start_auto_lot_number,
decode(decode(iacl.start_auto_serial_number,1,nvl(msim.start_auto_serial_number,-1),nvl(msi.start_auto_serial_number,-1)),nvl(msi.start_auto_serial_number,-1),'','M:[' ||msim.start_auto_serial_number || '] C:[' || msi.start_auto_serial_number || ']' ) start_auto_serial_number,
-- 4B
decode(decode(iacl.encumbrance_account,1,nvl(msim.encumbrance_account,-1),nvl(msi.encumbrance_account,-1)),nvl(msi.encumbrance_account,-1),'','M:[' ||msim.encumbrance_account || '] C:[' || msi.encumbrance_account || ']' ) encumbrance_account,
decode(decode(iacl.expense_account,1,nvl(msim.expense_account,-1),nvl(msi.expense_account,-1)),nvl(msi.expense_account,-1),'','M:[' ||msim.expense_account || '] C:[' || msi.expense_account || ']' ) expense_account,
decode(decode(iacl.restrict_subinventories_code,1,nvl(msim.restrict_subinventories_code,-1),nvl(msi.restrict_subinventories_code,-1)),nvl(msi.restrict_subinventories_code,-1),'','M:[' ||msim.restrict_subinventories_code || '] C:[' || msi.restrict_subinventories_code || ']' ) restrict_subinventories_code,
decode(decode(iacl.source_organization_id,1,nvl(msim.source_organization_id,-1),nvl(msi.source_organization_id,-1)),nvl(msi.source_organization_id,-1),'','M:[' ||msim.source_organization_id || '] C:[' || msi.source_organization_id || ']' ) source_organization_id,
decode(decode(iacl.source_subinventory,1,nvl(msim.source_subinventory,-1),nvl(msi.source_subinventory,-1)),nvl(msi.source_subinventory,-1),'','M:[' ||msim.source_subinventory || '] C:[' || msi.source_subinventory || ']' ) source_subinventory,
decode(decode(iacl.source_type,1,nvl(msim.source_type,-1),nvl(msi.source_type,-1)),nvl(msi.source_type,-1),'','M:[' ||msim.source_type || '] C:[' || msi.source_type || ']' ) source_type,
decode(decode(iacl.unit_weight,1,nvl(msim.unit_weight,-1),nvl(msi.unit_weight,-1)),nvl(msi.unit_weight,-1),'','M:[' ||msim.unit_weight || '] C:[' || msi.unit_weight || ']' ) unit_weight,
decode(decode(iacl.weight_uom_code,1,nvl(msim.weight_uom_code,-1),nvl(msi.weight_uom_code,-1)),nvl(msi.weight_uom_code,-1),'','M:[' ||msim.weight_uom_code || '] C:[' || msi.weight_uom_code || ']' ) weight_uom_code,
-- 4C
decode(decode(iacl.acceptable_early_days,1,nvl(msim.acceptable_early_days,-1),nvl(msi.acceptable_early_days,-1)),nvl(msi.acceptable_early_days,-1),'','M:[' ||msim.acceptable_early_days || '] C:[' || msi.acceptable_early_days || ']' ) acceptable_early_days,
decode(decode(iacl.location_control_code,1,nvl(msim.location_control_code,-1),nvl(msi.location_control_code,-1)),nvl(msi.location_control_code,-1),'','M:[' ||msim.location_control_code || '] C:[' || msi.location_control_code || ']' ) location_control_code,
decode(decode(iacl.planning_time_fence_code,1,nvl(msim.planning_time_fence_code,-1),nvl(msi.planning_time_fence_code,-1)),nvl(msi.planning_time_fence_code,-1),'','M:[' ||msim.planning_time_fence_code || '] C:[' || msi.planning_time_fence_code || ']' ) planning_time_fence_code,
decode(decode(iacl.restrict_locators_code,1,nvl(msim.restrict_locators_code,-1),nvl(msi.restrict_locators_code,-1)),nvl(msi.restrict_locators_code,-1),'','M:[' ||msim.restrict_locators_code || '] C:[' || msi.restrict_locators_code || ']' ) restrict_locators_code,
decode(decode(iacl.shrinkage_rate,1,nvl(msim.shrinkage_rate,-1),nvl(msi.shrinkage_rate,-1)),nvl(msi.shrinkage_rate,-1),'','M:[' ||msim.shrinkage_rate || '] C:[' || msi.shrinkage_rate || ']' ) shrinkage_rate,
decode(decode(iacl.unit_volume,1,nvl(msim.unit_volume,-1),nvl(msi.unit_volume,-1)),nvl(msi.unit_volume,-1),'','M:[' ||msim.unit_volume || '] C:[' || msi.unit_volume || ']' ) unit_volume,
decode(decode(iacl.volume_uom_code,1,nvl(msim.volume_uom_code,-1),nvl(msi.volume_uom_code,-1)),nvl(msi.volume_uom_code,-1),'','M:[' ||msim.volume_uom_code || '] C:[' || msi.volume_uom_code || ']' ) volume_uom_code,
-- 4D
decode(decode(iacl.acceptable_rate_decrease,1,nvl(msim.acceptable_rate_decrease,-1),nvl(msi.acceptable_rate_decrease,-1)),nvl(msi.acceptable_rate_decrease,-1),'','M:[' ||msim.acceptable_rate_decrease || '] C:[' || msi.acceptable_rate_decrease || ']' ) acceptable_rate_decrease,
decode(decode(iacl.acceptable_rate_increase,1,nvl(msim.acceptable_rate_increase,-1),nvl(msi.acceptable_rate_increase,-1)),nvl(msi.acceptable_rate_increase,-1),'','M:[' ||msim.acceptable_rate_increase || '] C:[' || msi.acceptable_rate_increase || ']' ) acceptable_rate_increase,
decode(decode(iacl.cum_manufacturing_lead_time,1,nvl(msim.cum_manufacturing_lead_time,-1),nvl(msi.cum_manufacturing_lead_time,-1)),nvl(msi.cum_manufacturing_lead_time,-1),'','M:[' ||msim.cum_manufacturing_lead_time || '] C:[' || msi.cum_manufacturing_lead_time || ']' ) cum_manufacturing_lead_time,
decode(decode(iacl.demand_time_fence_code,1,nvl(msim.demand_time_fence_code,-1),nvl(msi.demand_time_fence_code,-1)),nvl(msi.demand_time_fence_code,-1),'','M:[' ||msim.demand_time_fence_code || '] C:[' || msi.demand_time_fence_code || ']' ) demand_time_fence_code,
decode(decode(iacl.lead_time_lot_size,1,nvl(msim.lead_time_lot_size,-1),nvl(msi.lead_time_lot_size,-1)),nvl(msi.lead_time_lot_size,-1),'','M:[' ||msim.lead_time_lot_size || '] C:[' || msi.lead_time_lot_size || ']' ) lead_time_lot_size,
decode(decode(iacl.mrp_calculate_atp_flag,1,nvl(msim.mrp_calculate_atp_flag,-1),nvl(msi.mrp_calculate_atp_flag,-1)),nvl(msi.mrp_calculate_atp_flag,-1),'','M:[' ||msim.mrp_calculate_atp_flag || '] C:[' || msi.mrp_calculate_atp_flag || ']' ) mrp_calculate_atp_flag,
decode(decode(iacl.overrun_percentage,1,nvl(msim.overrun_percentage,-1),nvl(msi.overrun_percentage,-1)),nvl(msi.overrun_percentage,-1),'','M:[' ||msim.overrun_percentage || '] C:[' || msi.overrun_percentage || ']' ) overrun_percentage,
decode(decode(iacl.std_lot_size,1,nvl(msim.std_lot_size,-1),nvl(msi.std_lot_size,-1)),nvl(msi.std_lot_size,-1),'','M:[' ||msim.std_lot_size || '] C:[' || msi.std_lot_size || ']' ) std_lot_size,
-- 4E
decode(decode(iacl.bom_item_type,1,nvl(msim.bom_item_type,-1),nvl(msi.bom_item_type,-1)),nvl(msi.bom_item_type,-1),'','M:[' ||msim.bom_item_type || '] C:[' || msi.bom_item_type || ']' ) bom_item_type,
decode(decode(iacl.cumulative_total_lead_time,1,nvl(msim.cumulative_total_lead_time,-1),nvl(msi.cumulative_total_lead_time,-1)),nvl(msi.cumulative_total_lead_time,-1),'','M:[' ||msim.cumulative_total_lead_time || '] C:[' || msi.cumulative_total_lead_time || ']' ) cumulative_total_lead_time,
decode(decode(iacl.demand_time_fence_days,1,nvl(msim.demand_time_fence_days,-1),nvl(msi.demand_time_fence_days,-1)),nvl(msi.demand_time_fence_days,-1),'','M:[' ||msim.demand_time_fence_days || '] C:[' || msi.demand_time_fence_days || ']' ) demand_time_fence_days,
decode(decode(iacl.end_assembly_pegging_flag,1,nvl(msim.end_assembly_pegging_flag,-1),nvl(msi.end_assembly_pegging_flag,-1)),nvl(msi.end_assembly_pegging_flag,-1),'','M:[' ||msim.end_assembly_pegging_flag || '] C:[' || msi.end_assembly_pegging_flag || ']' ) end_assembly_pegging_flag,
decode(decode(iacl.planning_exception_set,1,nvl(msim.planning_exception_set,-1),nvl(msi.planning_exception_set,-1)),nvl(msi.planning_exception_set,-1),'','M:[' ||msim.planning_exception_set || '] C:[' || msi.planning_exception_set || ']' ) planning_exception_set,
decode(decode(iacl.planning_time_fence_days,1,nvl(msim.planning_time_fence_days,-1),nvl(msi.planning_time_fence_days,-1)),nvl(msi.planning_time_fence_days,-1),'','M:[' ||msim.planning_time_fence_days || '] C:[' || msi.planning_time_fence_days || ']' ) planning_time_fence_days,
decode(decode(iacl.repetitive_planning_flag,1,nvl(msim.repetitive_planning_flag,-1),nvl(msi.repetitive_planning_flag,-1)),nvl(msi.repetitive_planning_flag,-1),'','M:[' ||msim.repetitive_planning_flag || '] C:[' || msi.repetitive_planning_flag || ']' ) repetitive_planning_flag,
-- 4F
decode(decode(iacl.atp_components_flag,1,nvl(msim.atp_components_flag,-1),nvl(msi.atp_components_flag,-1)),nvl(msi.atp_components_flag,-1),'','M:[' ||msim.atp_components_flag || '] C:[' || msi.atp_components_flag || ']' ) atp_components_flag,
decode(decode(iacl.atp_flag,1,nvl(msim.atp_flag,-1),nvl(msi.atp_flag,-1)),nvl(msi.atp_flag,-1),'','M:[' ||msim.atp_flag || '] C:[' || msi.atp_flag || ']' ) atp_flag,
decode(decode(iacl.base_item_id,1,nvl(msim.base_item_id,-1),nvl(msi.base_item_id,-1)),nvl(msi.base_item_id,-1),'','M:[' ||msim.base_item_id || '] C:[' || msi.base_item_id || ']' ) base_item_id,
decode(decode(iacl.fixed_lead_time,1,nvl(msim.fixed_lead_time,-1),nvl(msi.fixed_lead_time,-1)),nvl(msi.fixed_lead_time,-1),'','M:[' ||msim.fixed_lead_time || '] C:[' || msi.fixed_lead_time || ']' ) fixed_lead_time,
decode(decode(iacl.pick_components_flag,1,nvl(msim.pick_components_flag,-1),nvl(msi.pick_components_flag,-1)),nvl(msi.pick_components_flag,-1),'','M:[' ||msim.pick_components_flag || '] C:[' || msi.pick_components_flag || ']' ) pick_components_flag,
decode(decode(iacl.replenish_to_order_flag,1,nvl(msim.replenish_to_order_flag,-1),nvl(msi.replenish_to_order_flag,-1)),nvl(msi.replenish_to_order_flag,-1),'','M:[' ||msim.replenish_to_order_flag || '] C:[' || msi.replenish_to_order_flag || ']' ) replenish_to_order_flag,
decode(decode(iacl.variable_lead_time,1,nvl(msim.variable_lead_time,-1),nvl(msi.variable_lead_time,-1)),nvl(msi.variable_lead_time,-1),'','M:[' ||msim.variable_lead_time || '] C:[' || msi.variable_lead_time || ']' ) variable_lead_time,
decode(decode(iacl.wip_supply_locator_id,1,nvl(msim.wip_supply_locator_id,-1),nvl(msi.wip_supply_locator_id,-1)),nvl(msi.wip_supply_locator_id,-1),'','M:[' ||msim.wip_supply_locator_id || '] C:[' || msi.wip_supply_locator_id || ']' ) wip_supply_locator_id,
-- 4G
decode(decode(iacl.allowed_units_lookup_code,1,nvl(msim.allowed_units_lookup_code,-1),nvl(msi.allowed_units_lookup_code,-1)),nvl(msi.allowed_units_lookup_code,-1),'','M:[' ||msim.allowed_units_lookup_code || '] C:[' || msi.allowed_units_lookup_code || ']' ) allowed_units_lookup_code,
decode(decode(iacl.cost_of_sales_account,1,nvl(msim.cost_of_sales_account,-1),nvl(msi.cost_of_sales_account,-1)),nvl(msi.cost_of_sales_account,-1),'','M:[' ||msim.cost_of_sales_account || '] C:[' || msi.cost_of_sales_account || ']' ) cost_of_sales_account,
decode(decode(iacl.primary_uom_code,1,nvl(msim.primary_uom_code,-1),nvl(msi.primary_uom_code,-1)),nvl(msi.primary_uom_code,-1),'','M:[' ||msim.primary_uom_code || '] C:[' || msi.primary_uom_code || ']' ) primary_uom_code,
decode(decode(iacl.sales_account,1,nvl(msim.sales_account,-1),nvl(msi.sales_account,-1)),nvl(msi.sales_account,-1),'','M:[' ||msim.sales_account || '] C:[' || msi.sales_account || ']' ) sales_account,
decode(decode(iacl.wip_supply_subinventory,1,nvl(msim.wip_supply_subinventory,-1),nvl(msi.wip_supply_subinventory,-1)),nvl(msi.wip_supply_subinventory,-1),'','M:[' ||msim.wip_supply_subinventory || '] C:[' || msi.wip_supply_subinventory || ']' ) wip_supply_subinventory,
decode(decode(iacl.wip_supply_type,1,nvl(msim.wip_supply_type,-1),nvl(msi.wip_supply_type,-1)),nvl(msi.wip_supply_type,-1),'','M:[' ||msim.wip_supply_type || '] C:[' || msi.wip_supply_type || ']' ) wip_supply_type,
-- 4H
decode(decode(iacl.carrying_cost,1,nvl(msim.carrying_cost,-1),nvl(msi.carrying_cost,-1)),nvl(msi.carrying_cost,-1),'','M:[' ||msim.carrying_cost || '] C:[' || msi.carrying_cost || ']' ) carrying_cost,
decode(decode(iacl.default_include_in_rollup_flag,1,nvl(msim.default_include_in_rollup_flag,-1),nvl(msi.default_include_in_rollup_flag,-1)),nvl(msi.default_include_in_rollup_flag,-1),'','M:[' ||msim.default_include_in_rollup_flag || '] C:[' || msi.default_include_in_rollup_flag || ']' ) default_include_in_rollup_flag,
decode(decode(iacl.fixed_lot_multiplier,1,nvl(msim.fixed_lot_multiplier,-1),nvl(msi.fixed_lot_multiplier,-1)),nvl(msi.fixed_lot_multiplier,-1),'','M:[' ||msim.fixed_lot_multiplier || '] C:[' || msi.fixed_lot_multiplier || ']' ) fixed_lot_multiplier,
decode(decode(iacl.inventory_item_status_code,1,nvl(msim.inventory_item_status_code,-1),nvl(msi.inventory_item_status_code,-1)),nvl(msi.inventory_item_status_code,-1),'','M:[' ||msim.inventory_item_status_code || '] C:[' || msi.inventory_item_status_code || ']' ) inventory_item_status_code,
decode(decode(iacl.inventory_planning_code,1,nvl(msim.inventory_planning_code,-1),nvl(msi.inventory_planning_code,-1)),nvl(msi.inventory_planning_code,-1),'','M:[' ||msim.inventory_planning_code || '] C:[' || msi.inventory_planning_code || ']' ) inventory_planning_code,
decode(decode(iacl.planner_code,1,nvl(msim.planner_code,-1),nvl(msi.planner_code,-1)),nvl(msi.planner_code,-1),'','M:[' ||msim.planner_code || '] C:[' || msi.planner_code || ']' ) planner_code,
decode(decode(iacl.planning_make_buy_code,1,nvl(msim.planning_make_buy_code,-1),nvl(msi.planning_make_buy_code,-1)),nvl(msi.planning_make_buy_code,-1),'','M:[' ||msim.planning_make_buy_code || '] C:[' || msi.planning_make_buy_code || ']' ) planning_make_buy_code,
decode(decode(iacl.rounding_control_type,1,nvl(msim.rounding_control_type,-1),nvl(msi.rounding_control_type,-1)),nvl(msi.rounding_control_type,-1),'','M:[' ||msim.rounding_control_type || '] C:[' || msi.rounding_control_type || ']' ) rounding_control_type,
-- 4I
decode(decode(iacl.full_lead_time,1,nvl(msim.full_lead_time,-1),nvl(msi.full_lead_time,-1)),nvl(msi.full_lead_time,-1),'','M:[' ||msim.full_lead_time || '] C:[' || msi.full_lead_time || ']' ) full_lead_time,
decode(decode(iacl.min_minmax_quantity,1,nvl(msim.min_minmax_quantity,-1),nvl(msi.min_minmax_quantity,-1)),nvl(msi.min_minmax_quantity,-1),'','M:[' ||msim.min_minmax_quantity || '] C:[' || msi.min_minmax_quantity || ']' ) min_minmax_quantity,
decode(decode(iacl.mrp_safety_stock_code,1,nvl(msim.mrp_safety_stock_code,-1),nvl(msi.mrp_safety_stock_code,-1)),nvl(msi.mrp_safety_stock_code,-1),'','M:[' ||msim.mrp_safety_stock_code || '] C:[' || msi.mrp_safety_stock_code || ']' ) mrp_safety_stock_code,
decode(decode(iacl.mrp_safety_stock_percent,1,nvl(msim.mrp_safety_stock_percent,-1),nvl(msi.mrp_safety_stock_percent,-1)),nvl(msi.mrp_safety_stock_percent,-1),'','M:[' ||msim.mrp_safety_stock_percent || '] C:[' || msi.mrp_safety_stock_percent || ']' ) mrp_safety_stock_percent,
decode(decode(iacl.order_cost,1,nvl(msim.order_cost,-1),nvl(msi.order_cost,-1)),nvl(msi.order_cost,-1),'','M:[' ||msim.order_cost || '] C:[' || msi.order_cost || ']' ) order_cost,
decode(decode(iacl.postprocessing_lead_time,1,nvl(msim.postprocessing_lead_time,-1),nvl(msi.postprocessing_lead_time,-1)),nvl(msi.postprocessing_lead_time,-1),'','M:[' ||msim.postprocessing_lead_time || '] C:[' || msi.postprocessing_lead_time || ']' ) postprocessing_lead_time,
decode(decode(iacl.preprocessing_lead_time,1,nvl(msim.preprocessing_lead_time,-1),nvl(msi.preprocessing_lead_time,-1)),nvl(msi.preprocessing_lead_time,-1),'','M:[' ||msim.preprocessing_lead_time || '] C:[' || msi.preprocessing_lead_time || ']' ) preprocessing_lead_time,
-- 4J
decode(decode(iacl.atp_rule_id,1,nvl(msim.atp_rule_id,-1),nvl(msi.atp_rule_id,-1)),nvl(msi.atp_rule_id,-1),'','M:[' ||msim.atp_rule_id || '] C:[' || msi.atp_rule_id || ']' ) atp_rule_id,
decode(decode(iacl.fixed_order_quantity,1,nvl(msim.fixed_order_quantity,-1),nvl(msi.fixed_order_quantity,-1)),nvl(msi.fixed_order_quantity,-1),'','M:[' ||msim.fixed_order_quantity || '] C:[' || msi.fixed_order_quantity || ']' ) fixed_order_quantity,
decode(decode(iacl.max_minmax_quantity,1,nvl(msim.max_minmax_quantity,-1),nvl(msi.max_minmax_quantity,-1)),nvl(msi.max_minmax_quantity,-1),'','M:[' ||msim.max_minmax_quantity || '] C:[' || msi.max_minmax_quantity || ']' ) max_minmax_quantity,
decode(decode(iacl.maximum_order_quantity,1,nvl(msim.maximum_order_quantity,-1),nvl(msi.maximum_order_quantity,-1)),nvl(msi.maximum_order_quantity,-1),'','M:[' ||msim.maximum_order_quantity || '] C:[' || msi.maximum_order_quantity || ']' ) maximum_order_quantity,
decode(decode(iacl.minimum_order_quantity,1,nvl(msim.minimum_order_quantity,-1),nvl(msi.minimum_order_quantity,-1)),nvl(msi.minimum_order_quantity,-1),'','M:[' ||msim.minimum_order_quantity || '] C:[' || msi.minimum_order_quantity || ']' ) minimum_order_quantity,
decode(decode(iacl.picking_rule_id,1,nvl(msim.picking_rule_id,-1),nvl(msi.picking_rule_id,-1)),nvl(msi.picking_rule_id,-1),'','M:[' ||msim.picking_rule_id || '] C:[' || msi.picking_rule_id || ']' ) picking_rule_id,
-- 4K
decode(decode(iacl.auto_reduce_mps,1,nvl(msim.auto_reduce_mps,-1),nvl(msi.auto_reduce_mps,-1)),nvl(msi.auto_reduce_mps,-1),'','M:[' ||msim.auto_reduce_mps || '] C:[' || msi.auto_reduce_mps || ']' ) auto_reduce_mps,
decode(decode(iacl.costing_enabled_flag,1,nvl(msim.costing_enabled_flag,-1),nvl(msi.costing_enabled_flag,-1)),nvl(msi.costing_enabled_flag,-1),'','M:[' ||msim.costing_enabled_flag || '] C:[' || msi.costing_enabled_flag || ']' ) costing_enabled_flag,
decode(decode(iacl.outside_operation_flag,1,nvl(msim.outside_operation_flag,-1),nvl(msi.outside_operation_flag,-1)),nvl(msi.outside_operation_flag,-1),'','M:[' ||msim.outside_operation_flag || '] C:[' || msi.outside_operation_flag || ']' ) outside_operation_flag,
decode(decode(iacl.outside_operation_uom_type,1,nvl(msim.outside_operation_uom_type,-1),nvl(msi.outside_operation_uom_type,-1)),nvl(msi.outside_operation_uom_type,-1),'','M:[' ||msim.outside_operation_uom_type || '] C:[' || msi.outside_operation_uom_type || ']' ) outside_operation_uom_type,
decode(decode(iacl.positive_measurement_error,1,nvl(msim.positive_measurement_error,-1),nvl(msi.positive_measurement_error,-1)),nvl(msi.positive_measurement_error,-1),'','M:[' ||msim.positive_measurement_error || '] C:[' || msi.positive_measurement_error || ']' ) positive_measurement_error,
decode(decode(iacl.reservable_type,1,nvl(msim.reservable_type,-1),nvl(msi.reservable_type,-1)),nvl(msi.reservable_type,-1),'','M:[' ||msim.reservable_type || '] C:[' || msi.reservable_type || ']' ) reservable_type,
decode(decode(iacl.safety_stock_bucket_days,1,nvl(msim.safety_stock_bucket_days,-1),nvl(msi.safety_stock_bucket_days,-1)),nvl(msi.safety_stock_bucket_days,-1),'','M:[' ||msim.safety_stock_bucket_days || '] C:[' || msi.safety_stock_bucket_days || ']' ) safety_stock_bucket_days,
-- 4L
decode(decode(iacl.ato_forecast_control,1,nvl(msim.ato_forecast_control,-1),nvl(msi.ato_forecast_control,-1)),nvl(msi.ato_forecast_control,-1),'','M:[' ||msim.ato_forecast_control || '] C:[' || msi.ato_forecast_control || ']' ) ato_forecast_control,
decode(decode(iacl.auto_created_config_flag,1,nvl(msim.auto_created_config_flag,-1),nvl(msi.auto_created_config_flag,-1)),nvl(msi.auto_created_config_flag,-1),'','M:[' ||msim.auto_created_config_flag || '] C:[' || msi.auto_created_config_flag || ']' ) auto_created_config_flag,
decode(decode(iacl.cycle_count_enabled_flag,1,nvl(msim.cycle_count_enabled_flag,-1),nvl(msi.cycle_count_enabled_flag,-1)),nvl(msi.cycle_count_enabled_flag,-1),'','M:[' ||msim.cycle_count_enabled_flag || '] C:[' || msi.cycle_count_enabled_flag || ']' ) cycle_count_enabled_flag,
decode(decode(iacl.item_type,1,nvl(msim.item_type,-1),nvl(msi.item_type,-1)),nvl(msi.item_type,-1),'','M:[' ||msim.item_type || '] C:[' || msi.item_type || ']' ) item_type,
decode(decode(iacl.model_config_clause_name,1,nvl(msim.model_config_clause_name,-1),nvl(msi.model_config_clause_name,-1)),nvl(msi.model_config_clause_name,-1),'','M:[' ||msim.model_config_clause_name || '] C:[' || msi.model_config_clause_name || ']' ) model_config_clause_name,
decode(decode(iacl.mrp_planning_code,1,nvl(msim.mrp_planning_code,-1),nvl(msi.mrp_planning_code,-1)),nvl(msi.mrp_planning_code,-1),'','M:[' ||msim.mrp_planning_code || '] C:[' || msi.mrp_planning_code || ']' ) mrp_planning_code,
decode(decode(iacl.return_inspection_requirement,1,nvl(msim.return_inspection_requirement,-1),nvl(msi.return_inspection_requirement,-1)),nvl(msi.return_inspection_requirement,-1),'','M:[' ||msim.return_inspection_requirement || '] C:[' || msi.return_inspection_requirement || ']' ) return_inspection_requirement,
decode(decode(iacl.ship_model_complete_flag,1,nvl(msim.ship_model_complete_flag,-1),nvl(msi.ship_model_complete_flag,-1)),nvl(msi.ship_model_complete_flag,-1),'','M:[' ||msim.ship_model_complete_flag || '] C:[' || msi.ship_model_complete_flag || ']' ) ship_model_complete_flag,
-- 4M
decode(decode(iacl.config_model_type,1,nvl(msim.config_model_type,-1),nvl(msi.config_model_type,-1)),nvl(msi.config_model_type,-1),'','M:[' ||msim.config_model_type || '] C:[' || msi.config_model_type || ']' ) config_model_type,
decode(decode(iacl.eam_activity_source_code,1,nvl(msim.eam_activity_source_code,-1),nvl(msi.eam_activity_source_code,-1)),nvl(msi.eam_activity_source_code,-1),'','M:[' ||msim.eam_activity_source_code || '] C:[' || msi.eam_activity_source_code || ']' ) eam_activity_source_code,
decode(decode(iacl.ib_item_instance_class,1,nvl(msim.ib_item_instance_class,-1),nvl(msi.ib_item_instance_class,-1)),nvl(msi.ib_item_instance_class,-1),'','M:[' ||msim.ib_item_instance_class || '] C:[' || msi.ib_item_instance_class || ']' ) ib_item_instance_class,
decode(decode(iacl.lot_substitution_enabled,1,nvl(msim.lot_substitution_enabled,-1),nvl(msi.lot_substitution_enabled,-1)),nvl(msi.lot_substitution_enabled,-1),'','M:[' ||msim.lot_substitution_enabled || '] C:[' || msi.lot_substitution_enabled || ']' ) lot_substitution_enabled,
decode(decode(iacl.minimum_license_quantity,1,nvl(msim.minimum_license_quantity,-1),nvl(msi.minimum_license_quantity,-1)),nvl(msi.minimum_license_quantity,-1),'','M:[' ||msim.minimum_license_quantity || '] C:[' || msi.minimum_license_quantity || ']' ) minimum_license_quantity,
-- 4N
decode(decode(iacl.charge_periodicity_code,1,nvl(msim.charge_periodicity_code,-1),nvl(msi.charge_periodicity_code,-1)),nvl(msi.charge_periodicity_code,-1),'','M:[' ||msim.charge_periodicity_code || '] C:[' || msi.charge_periodicity_code || ']' ) charge_periodicity_code,
decode(decode(iacl.outsourced_assembly,1,nvl(msim.outsourced_assembly,-1),nvl(msi.outsourced_assembly,-1)),nvl(msi.outsourced_assembly,-1),'','M:[' ||msim.outsourced_assembly || '] C:[' || msi.outsourced_assembly || ']' ) outsourced_assembly,
decode(decode(iacl.subcontracting_component,1,nvl(msim.subcontracting_component,-1),nvl(msi.subcontracting_component,-1)),nvl(msi.subcontracting_component,-1),'','M:[' ||msim.subcontracting_component || '] C:[' || msi.subcontracting_component || ']' ) subcontracting_component,
-- 4O
decode(decode(iacl.preposition_point,1,nvl(msim.preposition_point,-1),nvl(msi.preposition_point,-1)),nvl(msi.preposition_point,-1),'','M:[' ||msim.preposition_point || '] C:[' || msi.preposition_point || ']' ) preposition_point,
decode(decode(iacl.repair_leadtime,1,nvl(msim.repair_leadtime,-1),nvl(msi.repair_leadtime,-1)),nvl(msi.repair_leadtime,-1),'','M:[' ||msim.repair_leadtime || '] C:[' || msi.repair_leadtime || ']' ) repair_leadtime,
decode(decode(iacl.repair_program,1,nvl(msim.repair_program,-1),nvl(msi.repair_program,-1)),nvl(msi.repair_program,-1),'','M:[' ||msim.repair_program || '] C:[' || msi.repair_program || ']' ) repair_program,
decode(decode(iacl.repair_yield,1,nvl(msim.repair_yield,-1),nvl(msi.repair_yield,-1)),nvl(msi.repair_yield,-1),'','M:[' ||msim.repair_yield || '] C:[' || msi.repair_yield || ']' ) repair_yield,
-- 7A
decode(decode(iacl.engineering_date,1,nvl(msim.engineering_date,to_date('1000/01/01','YYYY/MM/DD')),nvl(msi.engineering_date,to_date('1000/01/01','YYYY/MM/DD'))),nvl(msi.engineering_date,to_date('1000/01/01','YYYY/MM/DD')),'','M:[' ||msim.engineering_date || '] C:[' || msi.engineering_date || ']' ) engineering_date,
decode(decode(iacl.engineering_ecn_code,1,nvl(msim.engineering_ecn_code,-1),nvl(msi.engineering_ecn_code,-1)),nvl(msi.engineering_ecn_code,-1),'','M:[' ||msim.engineering_ecn_code || '] C:[' || msi.engineering_ecn_code || ']' ) engineering_ecn_code,
decode(decode(iacl.engineering_item_id,1,nvl(msim.engineering_item_id,-1),nvl(msi.engineering_item_id,-1)),nvl(msi.engineering_item_id,-1),'','M:[' ||msim.engineering_item_id || '] C:[' || msi.engineering_item_id || ']' ) engineering_item_id,
decode(decode(iacl.negative_measurement_error,1,nvl(msim.negative_measurement_error,-1),nvl(msi.negative_measurement_error,-1)),nvl(msi.negative_measurement_error,-1),'','M:[' ||msim.negative_measurement_error || '] C:[' || msi.negative_measurement_error || ']' ) negative_measurement_error,
decode(decode(iacl.service_starting_delay,1,nvl(msim.service_starting_delay,-1),nvl(msi.service_starting_delay,-1)),nvl(msi.service_starting_delay,-1),'','M:[' ||msim.service_starting_delay || '] C:[' || msi.service_starting_delay || ']' ) service_starting_delay,
decode(decode(iacl.serviceable_component_flag,1,nvl(msim.serviceable_component_flag,-1),nvl(msi.serviceable_component_flag,-1)),nvl(msi.serviceable_component_flag,-1),'','M:[' ||msim.serviceable_component_flag || '] C:[' || msi.serviceable_component_flag || ']' ) serviceable_component_flag,
-- 7B
decode(decode(iacl.base_warranty_service_id,1,nvl(msim.base_warranty_service_id,-1),nvl(msi.base_warranty_service_id,-1)),nvl(msi.base_warranty_service_id,-1),'','M:[' ||msim.base_warranty_service_id || '] C:[' || msi.base_warranty_service_id || ']' ) base_warranty_service_id,
decode(decode(iacl.payment_terms_id,1,nvl(msim.payment_terms_id,-1),nvl(msi.payment_terms_id,-1)),nvl(msi.payment_terms_id,-1),'','M:[' ||msim.payment_terms_id || '] C:[' || msi.payment_terms_id || ']' ) payment_terms_id,
decode(decode(iacl.preventive_maintenance_flag,1,nvl(msim.preventive_maintenance_flag,-1),nvl(msi.preventive_maintenance_flag,-1)),nvl(msi.preventive_maintenance_flag,-1),'','M:[' ||msim.preventive_maintenance_flag || '] C:[' || msi.preventive_maintenance_flag || ']' ) preventive_maintenance_flag,
decode(decode(iacl.primary_specialist_id,1,nvl(msim.primary_specialist_id,-1),nvl(msi.primary_specialist_id,-1)),nvl(msi.primary_specialist_id,-1),'','M:[' ||msim.primary_specialist_id || '] C:[' || msi.primary_specialist_id || ']' ) primary_specialist_id,
decode(decode(iacl.secondary_specialist_id,1,nvl(msim.secondary_specialist_id,-1),nvl(msi.secondary_specialist_id,-1)),nvl(msi.secondary_specialist_id,-1),'','M:[' ||msim.secondary_specialist_id || '] C:[' || msi.secondary_specialist_id || ']' ) secondary_specialist_id,
decode(decode(iacl.serviceable_item_class_id,1,nvl(msim.serviceable_item_class_id,-1),nvl(msi.serviceable_item_class_id,-1)),nvl(msi.serviceable_item_class_id,-1),'','M:[' ||msim.serviceable_item_class_id || '] C:[' || msi.serviceable_item_class_id || ']' ) serviceable_item_class_id,
decode(decode(iacl.serviceable_product_flag,1,nvl(msim.serviceable_product_flag,-1),nvl(msi.serviceable_product_flag,-1)),nvl(msi.serviceable_product_flag,-1),'','M:[' ||msim.serviceable_product_flag || '] C:[' || msi.serviceable_product_flag || ']' ) serviceable_product_flag,
-- 7C
decode(decode(iacl.coverage_schedule_id,1,nvl(msim.coverage_schedule_id,-1),nvl(msi.coverage_schedule_id,-1)),nvl(msi.coverage_schedule_id,-1),'','M:[' ||msim.coverage_schedule_id || '] C:[' || msi.coverage_schedule_id || ']' ) coverage_schedule_id,
decode(decode(iacl.material_billable_flag,1,nvl(msim.material_billable_flag,-1),nvl(msi.material_billable_flag,-1)),nvl(msi.material_billable_flag,-1),'','M:[' ||msim.material_billable_flag || '] C:[' || msi.material_billable_flag || ']' ) material_billable_flag,
decode(decode(iacl.prorate_service_flag,1,nvl(msim.prorate_service_flag,-1),nvl(msi.prorate_service_flag,-1)),nvl(msi.prorate_service_flag,-1),'','M:[' ||msim.prorate_service_flag || '] C:[' || msi.prorate_service_flag || ']' ) prorate_service_flag,
decode(decode(iacl.service_duration,1,nvl(msim.service_duration,-1),nvl(msi.service_duration,-1)),nvl(msi.service_duration,-1),'','M:[' ||msim.service_duration || '] C:[' || msi.service_duration || ']' ) service_duration,
decode(decode(iacl.service_duration_period_code,1,nvl(msim.service_duration_period_code,-1),nvl(msi.service_duration_period_code,-1)),nvl(msi.service_duration_period_code,-1),'','M:[' ||msim.service_duration_period_code || '] C:[' || msi.service_duration_period_code || ']' ) service_duration_period_code,
decode(decode(iacl.warranty_vendor_id,1,nvl(msim.warranty_vendor_id,-1),nvl(msi.warranty_vendor_id,-1)),nvl(msi.warranty_vendor_id,-1),'','M:[' ||msim.warranty_vendor_id || '] C:[' || msi.warranty_vendor_id || ']' ) warranty_vendor_id,
-- 7D
decode(decode(iacl.invoice_enabled_flag,1,nvl(msim.invoice_enabled_flag,-1),nvl(msi.invoice_enabled_flag,-1)),nvl(msi.invoice_enabled_flag,-1),'','M:[' ||msim.invoice_enabled_flag || '] C:[' || msi.invoice_enabled_flag || ']' ) invoice_enabled_flag,
decode(decode(iacl.invoiceable_item_flag,1,nvl(msim.invoiceable_item_flag,-1),nvl(msi.invoiceable_item_flag,-1)),nvl(msi.invoiceable_item_flag,-1),'','M:[' ||msim.invoiceable_item_flag || '] C:[' || msi.invoiceable_item_flag || ']' ) invoiceable_item_flag,
decode(decode(iacl.max_warranty_amount,1,nvl(msim.max_warranty_amount,-1),nvl(msi.max_warranty_amount,-1)),nvl(msi.max_warranty_amount,-1),'','M:[' ||msim.max_warranty_amount || '] C:[' || msi.max_warranty_amount || ']' ) max_warranty_amount,
decode(decode(iacl.must_use_approved_vendor_flag,1,nvl(msim.must_use_approved_vendor_flag,-1),nvl(msi.must_use_approved_vendor_flag,-1)),nvl(msi.must_use_approved_vendor_flag,-1),'','M:[' ||msim.must_use_approved_vendor_flag || '] C:[' || msi.must_use_approved_vendor_flag || ']' ) must_use_approved_vendor_flag,
decode(decode(iacl.new_revision_code,1,nvl(msim.new_revision_code,-1),nvl(msi.new_revision_code,-1)),nvl(msi.new_revision_code,-1),'','M:[' ||msim.new_revision_code || '] C:[' || msi.new_revision_code || ']' ) new_revision_code,
decode(decode(iacl.response_time_period_code,1,nvl(msim.response_time_period_code,-1),nvl(msi.response_time_period_code,-1)),nvl(msi.response_time_period_code,-1),'','M:[' ||msim.response_time_period_code || '] C:[' || msi.response_time_period_code || ']' ) response_time_period_code,
decode(decode(iacl.response_time_value,1,nvl(msim.response_time_value,-1),nvl(msi.response_time_value,-1)),nvl(msi.response_time_value,-1),'','M:[' ||msim.response_time_value || '] C:[' || msi.response_time_value || ']' ) response_time_value,
decode(decode(iacl.tax_code,1,nvl(msim.tax_code,-1),nvl(msi.tax_code,-1)),nvl(msi.tax_code,-1),'','M:[' ||msim.tax_code || '] C:[' || msi.tax_code || ']' ) tax_code,
-- 7E
decode(decode(iacl.container_item_flag,1,nvl(msim.container_item_flag,-1),nvl(msi.container_item_flag,-1)),nvl(msi.container_item_flag,-1),'','M:[' ||msim.container_item_flag || '] C:[' || msi.container_item_flag || ']' ) container_item_flag,
decode(decode(iacl.container_type_code,1,nvl(msim.container_type_code,-1),nvl(msi.container_type_code,-1)),nvl(msi.container_type_code,-1),'','M:[' ||msim.container_type_code || '] C:[' || msi.container_type_code || ']' ) container_type_code,
decode(decode(iacl.internal_volume,1,nvl(msim.internal_volume,-1),nvl(msi.internal_volume,-1)),nvl(msi.internal_volume,-1),'','M:[' ||msim.internal_volume || '] C:[' || msi.internal_volume || ']' ) internal_volume,
decode(decode(iacl.maximum_load_weight,1,nvl(msim.maximum_load_weight,-1),nvl(msi.maximum_load_weight,-1)),nvl(msi.maximum_load_weight,-1),'','M:[' ||msim.maximum_load_weight || '] C:[' || msi.maximum_load_weight || ']' ) maximum_load_weight,
decode(decode(iacl.minimum_fill_percent,1,nvl(msim.minimum_fill_percent,-1),nvl(msi.minimum_fill_percent,-1)),nvl(msi.minimum_fill_percent,-1),'','M:[' ||msim.minimum_fill_percent || '] C:[' || msi.minimum_fill_percent || ']' ) minimum_fill_percent,
decode(decode(iacl.release_time_fence_code,1,nvl(msim.release_time_fence_code,-1),nvl(msi.release_time_fence_code,-1)),nvl(msi.release_time_fence_code,-1),'','M:[' ||msim.release_time_fence_code || '] C:[' || msi.release_time_fence_code || ']' ) release_time_fence_code,
decode(decode(iacl.release_time_fence_days,1,nvl(msim.release_time_fence_days,-1),nvl(msi.release_time_fence_days,-1)),nvl(msi.release_time_fence_days,-1),'','M:[' ||msim.release_time_fence_days || '] C:[' || msi.release_time_fence_days || ']' ) release_time_fence_days,
decode(decode(iacl.vehicle_item_flag,1,nvl(msim.vehicle_item_flag,-1),nvl(msi.vehicle_item_flag,-1)),nvl(msi.vehicle_item_flag,-1),'','M:[' ||msim.vehicle_item_flag || '] C:[' || msi.vehicle_item_flag || ']' ) vehicle_item_flag,
-- 7F
decode(decode(iacl.ont_pricing_qty_source,1,nvl(msim.ont_pricing_qty_source,-1),nvl(msi.ont_pricing_qty_source,-1)),nvl(msi.ont_pricing_qty_source,-1),'','M:[' ||msim.ont_pricing_qty_source || '] C:[' || msi.ont_pricing_qty_source || ']' ) ont_pricing_qty_source,
decode(decode(iacl.secondary_default_ind,1,nvl(msim.secondary_default_ind,-1),nvl(msi.secondary_default_ind,-1)),nvl(msi.secondary_default_ind,-1),'','M:[' ||msim.secondary_default_ind || '] C:[' || msi.secondary_default_ind || ']' ) secondary_default_ind,
decode(decode(iacl.tracking_quantity_ind,1,nvl(msim.tracking_quantity_ind,-1),nvl(msi.tracking_quantity_ind,-1)),nvl(msi.tracking_quantity_ind,-1),'','M:[' ||msim.tracking_quantity_ind || '] C:[' || msi.tracking_quantity_ind || ']' ) tracking_quantity_ind,
-- 7G
decode(decode(iacl.config_match,1,nvl(msim.config_match,-1),nvl(msi.config_match,-1)),nvl(msi.config_match,-1),'','M:[' ||msim.config_match || '] C:[' || msi.config_match || ']' ) config_match,
decode(decode(iacl.config_orgs,1,nvl(msim.config_orgs,-1),nvl(msi.config_orgs,-1)),nvl(msi.config_orgs,-1),'','M:[' ||msim.config_orgs || '] C:[' || msi.config_orgs || ']' ) config_orgs,
-- 7H
decode(decode(iacl.asn_autoexpire_flag,1,nvl(msim.asn_autoexpire_flag,-1),nvl(msi.asn_autoexpire_flag,-1)),nvl(msi.asn_autoexpire_flag,-1),'','M:[' ||msim.asn_autoexpire_flag || '] C:[' || msi.asn_autoexpire_flag || ']' ) asn_autoexpire_flag,
decode(decode(iacl.consigned_flag,1,nvl(msim.consigned_flag,-1),nvl(msi.consigned_flag,-1)),nvl(msi.consigned_flag,-1),'','M:[' ||msim.consigned_flag || '] C:[' || msi.consigned_flag || ']' ) consigned_flag,
decode(decode(iacl.continous_transfer,1,nvl(msim.continous_transfer,-1),nvl(msi.continous_transfer,-1)),nvl(msi.continous_transfer,-1),'','M:[' ||msim.continous_transfer || '] C:[' || msi.continous_transfer || ']' ) continous_transfer,
decode(decode(iacl.convergence,1,nvl(msim.convergence,-1),nvl(msi.convergence,-1)),nvl(msi.convergence,-1),'','M:[' ||msim.convergence || '] C:[' || msi.convergence || ']' ) convergence,
decode(decode(iacl.critical_component_flag,1,nvl(msim.critical_component_flag,-1),nvl(msi.critical_component_flag,-1)),nvl(msi.critical_component_flag,-1),'','M:[' ||msim.critical_component_flag || '] C:[' || msi.critical_component_flag || ']' ) critical_component_flag,
decode(decode(iacl.days_max_inv_supply,1,nvl(msim.days_max_inv_supply,-1),nvl(msi.days_max_inv_supply,-1)),nvl(msi.days_max_inv_supply,-1),'','M:[' ||msim.days_max_inv_supply || '] C:[' || msi.days_max_inv_supply || ']' ) days_max_inv_supply,
decode(decode(iacl.days_max_inv_window,1,nvl(msim.days_max_inv_window,-1),nvl(msi.days_max_inv_window,-1)),nvl(msi.days_max_inv_window,-1),'','M:[' ||msim.days_max_inv_window || '] C:[' || msi.days_max_inv_window || ']' ) days_max_inv_window,
decode(decode(iacl.days_tgt_inv_supply,1,nvl(msim.days_tgt_inv_supply,-1),nvl(msi.days_tgt_inv_supply,-1)),nvl(msi.days_tgt_inv_supply,-1),'','M:[' ||msim.days_tgt_inv_supply || '] C:[' || msi.days_tgt_inv_supply || ']' ) days_tgt_inv_supply,
decode(decode(iacl.days_tgt_inv_window,1,nvl(msim.days_tgt_inv_window,-1),nvl(msi.days_tgt_inv_window,-1)),nvl(msi.days_tgt_inv_window,-1),'','M:[' ||msim.days_tgt_inv_window || '] C:[' || msi.days_tgt_inv_window || ']' ) days_tgt_inv_window,
decode(decode(iacl.divergence,1,nvl(msim.divergence,-1),nvl(msi.divergence,-1)),nvl(msi.divergence,-1),'','M:[' ||msim.divergence || '] C:[' || msi.divergence || ']' ) divergence,
decode(decode(iacl.drp_planned_flag,1,nvl(msim.drp_planned_flag,-1),nvl(msi.drp_planned_flag,-1)),nvl(msi.drp_planned_flag,-1),'','M:[' ||msim.drp_planned_flag || '] C:[' || msi.drp_planned_flag || ']' ) drp_planned_flag,
decode(decode(iacl.exclude_from_budget_flag,1,nvl(msim.exclude_from_budget_flag,-1),nvl(msi.exclude_from_budget_flag,-1)),nvl(msi.exclude_from_budget_flag,-1),'','M:[' ||msim.exclude_from_budget_flag || '] C:[' || msi.exclude_from_budget_flag || ']' ) exclude_from_budget_flag,
decode(decode(iacl.forecast_horizon,1,nvl(msim.forecast_horizon,-1),nvl(msi.forecast_horizon,-1)),nvl(msi.forecast_horizon,-1),'','M:[' ||msim.forecast_horizon || '] C:[' || msi.forecast_horizon || ']' ) forecast_horizon,
decode(decode(iacl.so_authorization_flag,1,nvl(msim.so_authorization_flag,-1),nvl(msi.so_authorization_flag,-1)),nvl(msi.so_authorization_flag,-1),'','M:[' ||msim.so_authorization_flag || '] C:[' || msi.so_authorization_flag || ']' ) so_authorization_flag,
decode(decode(iacl.vmi_fixed_order_quantity,1,nvl(msim.vmi_fixed_order_quantity,-1),nvl(msi.vmi_fixed_order_quantity,-1)),nvl(msi.vmi_fixed_order_quantity,-1),'','M:[' ||msim.vmi_fixed_order_quantity || '] C:[' || msi.vmi_fixed_order_quantity || ']' ) vmi_fixed_order_quantity,
decode(decode(iacl.vmi_forecast_type,1,nvl(msim.vmi_forecast_type,-1),nvl(msi.vmi_forecast_type,-1)),nvl(msi.vmi_forecast_type,-1),'','M:[' ||msim.vmi_forecast_type || '] C:[' || msi.vmi_forecast_type || ']' ) vmi_forecast_type,
decode(decode(iacl.vmi_maximum_days,1,nvl(msim.vmi_maximum_days,-1),nvl(msi.vmi_maximum_days,-1)),nvl(msi.vmi_maximum_days,-1),'','M:[' ||msim.vmi_maximum_days || '] C:[' || msi.vmi_maximum_days || ']' ) vmi_maximum_days,
decode(decode(iacl.vmi_maximum_units,1,nvl(msim.vmi_maximum_units,-1),nvl(msi.vmi_maximum_units,-1)),nvl(msi.vmi_maximum_units,-1),'','M:[' ||msim.vmi_maximum_units || '] C:[' || msi.vmi_maximum_units || ']' ) vmi_maximum_units,
decode(decode(iacl.vmi_minimum_days,1,nvl(msim.vmi_minimum_days,-1),nvl(msi.vmi_minimum_days,-1)),nvl(msi.vmi_minimum_days,-1),'','M:[' ||msim.vmi_minimum_days || '] C:[' || msi.vmi_minimum_days || ']' ) vmi_minimum_days,
decode(decode(iacl.vmi_minimum_units,1,nvl(msim.vmi_minimum_units,-1),nvl(msi.vmi_minimum_units,-1)),nvl(msi.vmi_minimum_units,-1),'','M:[' ||msim.vmi_minimum_units || '] C:[' || msi.vmi_minimum_units || ']' ) vmi_minimum_units,
-- 7I
decode(decode(iacl.child_lot_flag,1,nvl(msim.child_lot_flag,-1),nvl(msi.child_lot_flag,-1)),nvl(msi.child_lot_flag,-1),'','M:[' ||msim.child_lot_flag || '] C:[' || msi.child_lot_flag || ']' ) child_lot_flag,
decode(decode(iacl.child_lot_prefix,1,nvl(msim.child_lot_prefix,-1),nvl(msi.child_lot_prefix,-1)),nvl(msi.child_lot_prefix,-1),'','M:[' ||msim.child_lot_prefix || '] C:[' || msi.child_lot_prefix || ']' ) child_lot_prefix,
decode(decode(iacl.child_lot_starting_number,1,nvl(msim.child_lot_starting_number,-1),nvl(msi.child_lot_starting_number,-1)),nvl(msi.child_lot_starting_number,-1),'','M:[' ||msim.child_lot_starting_number || '] C:[' || msi.child_lot_starting_number || ']' ) child_lot_starting_number,
decode(decode(iacl.child_lot_validation_flag,1,nvl(msim.child_lot_validation_flag,-1),nvl(msi.child_lot_validation_flag,-1)),nvl(msi.child_lot_validation_flag,-1),'','M:[' ||msim.child_lot_validation_flag || '] C:[' || msi.child_lot_validation_flag || ']' ) child_lot_validation_flag,
decode(decode(iacl.copy_lot_attribute_flag,1,nvl(msim.copy_lot_attribute_flag,-1),nvl(msi.copy_lot_attribute_flag,-1)),nvl(msi.copy_lot_attribute_flag,-1),'','M:[' ||msim.copy_lot_attribute_flag || '] C:[' || msi.copy_lot_attribute_flag || ']' ) copy_lot_attribute_flag,
decode(decode(iacl.default_grade,1,nvl(msim.default_grade,-1),nvl(msi.default_grade,-1)),nvl(msi.default_grade,-1),'','M:[' ||msim.default_grade || '] C:[' || msi.default_grade || ']' ) default_grade,
decode(decode(iacl.grade_control_flag,1,nvl(msim.grade_control_flag,-1),nvl(msi.grade_control_flag,-1)),nvl(msi.grade_control_flag,-1),'','M:[' ||msim.grade_control_flag || '] C:[' || msi.grade_control_flag || ']' ) grade_control_flag,
decode(decode(iacl.lot_divisible_flag,1,nvl(msim.lot_divisible_flag,-1),nvl(msi.lot_divisible_flag,-1)),nvl(msi.lot_divisible_flag,-1),'','M:[' ||msim.lot_divisible_flag || '] C:[' || msi.lot_divisible_flag || ']' ) lot_divisible_flag,
decode(decode(iacl.parent_child_generation_flag,1,nvl(msim.parent_child_generation_flag,-1),nvl(msi.parent_child_generation_flag,-1)),nvl(msi.parent_child_generation_flag,-1),'','M:[' ||msim.parent_child_generation_flag || '] C:[' || msi.parent_child_generation_flag || ']' ) parent_child_generation_flag,
decode(decode(iacl.process_execution_enabled_flag,1,nvl(msim.process_execution_enabled_flag,-1),nvl(msi.process_execution_enabled_flag,-1)),nvl(msi.process_execution_enabled_flag,-1),'','M:[' ||msim.process_execution_enabled_flag || '] C:[' || msi.process_execution_enabled_flag || ']' ) process_execution_enabled_flag,
decode(decode(iacl.process_quality_enabled_flag,1,nvl(msim.process_quality_enabled_flag,-1),nvl(msi.process_quality_enabled_flag,-1)),nvl(msi.process_quality_enabled_flag,-1),'','M:[' ||msim.process_quality_enabled_flag || '] C:[' || msi.process_quality_enabled_flag || ']' ) process_quality_enabled_flag,
decode(decode(iacl.recipe_enabled_flag,1,nvl(msim.recipe_enabled_flag,-1),nvl(msi.recipe_enabled_flag,-1)),nvl(msi.recipe_enabled_flag,-1),'','M:[' ||msim.recipe_enabled_flag || '] C:[' || msi.recipe_enabled_flag || ']' ) recipe_enabled_flag,
-- 7J
decode(decode(iacl.cas_number,1,nvl(msim.cas_number,-1),nvl(msi.cas_number,-1)),nvl(msi.cas_number,-1),'','M:[' ||msim.cas_number || '] C:[' || msi.cas_number || ']' ) cas_number,
decode(decode(iacl.expiration_action_code,1,nvl(msim.expiration_action_code,-1),nvl(msi.expiration_action_code,-1)),nvl(msi.expiration_action_code,-1),'','M:[' ||msim.expiration_action_code || '] C:[' || msi.expiration_action_code || ']' ) expiration_action_code,
decode(decode(iacl.expiration_action_interval,1,nvl(msim.expiration_action_interval,-1),nvl(msi.expiration_action_interval,-1)),nvl(msi.expiration_action_interval,-1),'','M:[' ||msim.expiration_action_interval || '] C:[' || msi.expiration_action_interval || ']' ) expiration_action_interval,
decode(decode(iacl.hazardous_material_flag,1,nvl(msim.hazardous_material_flag,-1),nvl(msi.hazardous_material_flag,-1)),nvl(msi.hazardous_material_flag,-1),'','M:[' ||msim.hazardous_material_flag || '] C:[' || msi.hazardous_material_flag || ']' ) hazardous_material_flag,
decode(decode(iacl.hold_days,1,nvl(msim.hold_days,-1),nvl(msi.hold_days,-1)),nvl(msi.hold_days,-1),'','M:[' ||msim.hold_days || '] C:[' || msi.hold_days || ']' ) hold_days,
decode(decode(iacl.maturity_days,1,nvl(msim.maturity_days,-1),nvl(msi.maturity_days,-1)),nvl(msi.maturity_days,-1),'','M:[' ||msim.maturity_days || '] C:[' || msi.maturity_days || ']' ) maturity_days,
decode(decode(iacl.process_costing_enabled_flag,1,nvl(msim.process_costing_enabled_flag,-1),nvl(msi.process_costing_enabled_flag,-1)),nvl(msi.process_costing_enabled_flag,-1),'','M:[' ||msim.process_costing_enabled_flag || '] C:[' || msi.process_costing_enabled_flag || ']' ) process_costing_enabled_flag,
decode(decode(iacl.retest_interval,1,nvl(msim.retest_interval,-1),nvl(msi.retest_interval,-1)),nvl(msi.retest_interval,-1),'','M:[' ||msim.retest_interval || '] C:[' || msi.retest_interval || ']' ) retest_interval,
-- other item attributes which do not specifically raise an INV_IOI_MASTER_CHILD_xxx error in item import
--decode(decode(iacl.desc_flex,1,nvl(msim.desc_flex,-1),nvl(msi.desc_flex,-1)),nvl(msi.desc_flex,-1),'','M:[' ||msim.desc_flex || '] C:[' || msi.desc_flex || ']' ) desc_flex,
decode(decode(iacl.dual_uom_control,1,nvl(msim.dual_uom_control,-1),nvl(msi.dual_uom_control,-1)),nvl(msi.dual_uom_control,-1),'','M:[' ||msim.dual_uom_control || '] C:[' || msi.dual_uom_control || ']' ) dual_uom_control,
decode(decode(iacl.effectivity_control,1,nvl(msim.effectivity_control,-1),nvl(msi.effectivity_control,-1)),nvl(msi.effectivity_control,-1),'','M:[' ||msim.effectivity_control || '] C:[' || msi.effectivity_control || ']' ) effectivity_control,
decode(decode(iacl.eng_item_flag,1,nvl(msim.eng_item_flag,-1),nvl(msi.eng_item_flag,-1)),nvl(msi.eng_item_flag,-1),'','M:[' ||msim.eng_item_flag || '] C:[' || msi.eng_item_flag || ']' ) eng_item_flag,
decode(decode(iacl.fixed_days_supply,1,nvl(msim.fixed_days_supply,-1),nvl(msi.fixed_days_supply,-1)),nvl(msi.fixed_days_supply,-1),'','M:[' ||msim.fixed_days_supply || '] C:[' || msi.fixed_days_supply || ']' ) fixed_days_supply,
--decode(decode(iacl.global_desc_flex,1,nvl(msim.global_desc_flex,-1),nvl(msi.global_desc_flex,-1)),nvl(msi.global_desc_flex,-1),'','M:[' ||msim.global_desc_flex || '] C:[' || msi.global_desc_flex || ']' ) global_desc_flex,
decode(decode(iacl.indivisible_flag,1,nvl(msim.indivisible_flag,-1),nvl(msi.indivisible_flag,-1)),nvl(msi.indivisible_flag,-1),'','M:[' ||msim.indivisible_flag || '] C:[' || msi.indivisible_flag || ']' ) indivisible_flag,
decode(decode(iacl.inventory_asset_flag,1,nvl(msim.inventory_asset_flag,-1),nvl(msi.inventory_asset_flag,-1)),nvl(msi.inventory_asset_flag,-1),'','M:[' ||msim.inventory_asset_flag || '] C:[' || msi.inventory_asset_flag || ']' ) inventory_asset_flag,
decode(decode(iacl.primary_unit_of_measure,1,nvl(msim.primary_unit_of_measure,-1),nvl(msi.primary_unit_of_measure,-1)),nvl(msi.primary_unit_of_measure,-1),'','M:[' ||msim.primary_unit_of_measure || '] C:[' || msi.primary_unit_of_measure || ']' ) primary_unit_of_measure,
decode(decode(iacl.process_supply_locator_id,1,nvl(msim.process_supply_locator_id,-1),nvl(msi.process_supply_locator_id,-1)),nvl(msi.process_supply_locator_id,-1),'','M:[' ||msim.process_supply_locator_id || '] C:[' || msi.process_supply_locator_id || ']' ) process_supply_locator_id,
decode(decode(iacl.process_supply_subinventory,1,nvl(msim.process_supply_subinventory,-1),nvl(msi.process_supply_subinventory,-1)),nvl(msi.process_supply_subinventory,-1),'','M:[' ||msim.process_supply_subinventory || '] C:[' || msi.process_supply_subinventory || ']' ) process_supply_subinventory,
decode(decode(iacl.process_yield_locator_id,1,nvl(msim.process_yield_locator_id,-1),nvl(msi.process_yield_locator_id,-1)),nvl(msi.process_yield_locator_id,-1),'','M:[' ||msim.process_yield_locator_id || '] C:[' || msi.process_yield_locator_id || ']' ) process_yield_locator_id,
decode(decode(iacl.process_yield_subinventory,1,nvl(msim.process_yield_subinventory,-1),nvl(msi.process_yield_subinventory,-1)),nvl(msi.process_yield_subinventory,-1),'','M:[' ||msim.process_yield_subinventory || '] C:[' || msi.process_yield_subinventory || ']' ) process_yield_subinventory,
decode(decode(iacl.serial_tagging_flag,1,nvl(msim.serial_tagging_flag,-1),nvl(msi.serial_tagging_flag,-1)),nvl(msi.serial_tagging_flag,-1),'','M:[' ||msim.serial_tagging_flag || '] C:[' || msi.serial_tagging_flag || ']' ) serial_tagging_flag,
decode(decode(iacl.service_item_flag,1,nvl(msim.service_item_flag,-1),nvl(msi.service_item_flag,-1)),nvl(msi.service_item_flag,-1),'','M:[' ||msim.service_item_flag || '] C:[' || msi.service_item_flag || ']' ) service_item_flag,
decode(decode(iacl.usage_item_flag,1,nvl(msim.usage_item_flag,-1),nvl(msi.usage_item_flag,-1)),nvl(msi.usage_item_flag,-1),'','M:[' ||msim.usage_item_flag || '] C:[' || msi.usage_item_flag || ']' ) usage_item_flag,
decode(decode(iacl.vendor_warranty_flag,1,nvl(msim.vendor_warranty_flag,-1),nvl(msi.vendor_warranty_flag,-1)),nvl(msi.vendor_warranty_flag,-1),'','M:[' ||msim.vendor_warranty_flag || '] C:[' || msi.vendor_warranty_flag || ']' ) vendor_warranty_flag,
decode(decode(iacl.web_status,1,nvl(msim.web_status,-1),nvl(msi.web_status,-1)),nvl(msi.web_status,-1),'','M:[' ||msim.web_status || '] C:[' || msi.web_status || ']' ) web_status,
--
mp.master_organization_id,
mp.organization_id,
msi.inventory_item_id
from
mtl_parameters mp,
mtl_parameters mpm,
mtl_system_items_vl msi,
mtl_system_items_vl msim,
item_attrib_ctl_lvls iacl
where
1=1 and
mp.organization_id != mp.master_organization_id and
mp.master_organization_id = mpm.organization_id and
mp.organization_id = msi.organization_id and
mpm.organization_id = msim.organization_id and
msi.inventory_item_id = msim.inventory_item_id and
--
-- start of master/child groop validations
(
--
--
not ( -- 1A (INVPVALM)
  decode(iacl.accounting_rule_id,1,nvl(msim.accounting_rule_id,-1),nvl(msi.accounting_rule_id,-1))=nvl(msi.accounting_rule_id,-1) and
  decode(iacl.buyer_id,1,nvl(msim.buyer_id,-1),nvl(msi.buyer_id,-1))=nvl(msi.buyer_id,-1) and
  decode(iacl.customer_order_flag,1,nvl(msim.customer_order_flag,-1),nvl(msi.customer_order_flag,-1))=nvl(msi.customer_order_flag,-1) and
  decode(iacl.internal_order_flag,1,nvl(msim.internal_order_flag,-1),nvl(msi.internal_order_flag,-1))=nvl(msi.internal_order_flag,-1) and
  decode(iacl.inventory_item_flag,1,nvl(msim.inventory_item_flag,-1),nvl(msi.inventory_item_flag,-1))=nvl(msi.inventory_item_flag,-1) and
  decode(iacl.invoicing_rule_id,1,nvl(msim.invoicing_rule_id,-1),nvl(msi.invoicing_rule_id,-1))=nvl(msi.invoicing_rule_id,-1) and
  decode(iacl.purchasing_item_flag,1,nvl(msim.purchasing_item_flag,-1),nvl(msi.purchasing_item_flag,-1))=nvl(msi.purchasing_item_flag,-1) and
  decode(iacl.shippable_item_flag,1,nvl(msim.shippable_item_flag,-1),nvl(msi.shippable_item_flag,-1))=nvl(msi.shippable_item_flag,-1)
) or
not ( -- 1B (INVPVALM)
  decode(iacl.bom_enabled_flag,1,nvl(msim.bom_enabled_flag,-1),nvl(msi.bom_enabled_flag,-1))=nvl(msi.bom_enabled_flag,-1) and
  decode(iacl.build_in_wip_flag,1,nvl(msim.build_in_wip_flag,-1),nvl(msi.build_in_wip_flag,-1))=nvl(msi.build_in_wip_flag,-1) and
  decode(iacl.check_shortages_flag,1,nvl(msim.check_shortages_flag,-1),nvl(msi.check_shortages_flag,-1))=nvl(msi.check_shortages_flag,-1) and
  decode(iacl.item_catalog_group_id,1,nvl(msim.item_catalog_group_id,-1),nvl(msi.item_catalog_group_id,-1))=nvl(msi.item_catalog_group_id,-1) and
  decode(iacl.revision_qty_control_code,1,nvl(msim.revision_qty_control_code,-1),nvl(msi.revision_qty_control_code,-1))=nvl(msi.revision_qty_control_code,-1) and
  decode(iacl.stock_enabled_flag,1,nvl(msim.stock_enabled_flag,-1),nvl(msi.stock_enabled_flag,-1))=nvl(msi.stock_enabled_flag,-1)
) or
not ( -- 1C (INVPVALM)
  decode(iacl.customer_order_enabled_flag,1,nvl(msim.customer_order_enabled_flag,-1),nvl(msi.customer_order_enabled_flag,-1))=nvl(msi.customer_order_enabled_flag,-1) and
  decode(iacl.internal_order_enabled_flag,1,nvl(msim.internal_order_enabled_flag,-1),nvl(msi.internal_order_enabled_flag,-1))=nvl(msi.internal_order_enabled_flag,-1) and
  decode(iacl.mtl_transactions_enabled_flag,1,nvl(msim.mtl_transactions_enabled_flag,-1),nvl(msi.mtl_transactions_enabled_flag,-1))=nvl(msi.mtl_transactions_enabled_flag,-1) and
  decode(iacl.purchasing_enabled_flag,1,nvl(msim.purchasing_enabled_flag,-1),nvl(msi.purchasing_enabled_flag,-1))=nvl(msi.purchasing_enabled_flag,-1) and
  decode(iacl.so_transactions_flag,1,nvl(msim.so_transactions_flag,-1),nvl(msi.so_transactions_flag,-1))=nvl(msi.so_transactions_flag,-1)
) or
not ( -- 1D (INVPVALM)
  decode(iacl.allow_item_desc_update_flag,1,nvl(msim.allow_item_desc_update_flag,-1),nvl(msi.allow_item_desc_update_flag,-1))=nvl(msi.allow_item_desc_update_flag,-1) and
  decode(iacl.catalog_status_flag,1,nvl(msim.catalog_status_flag,-1),nvl(msi.catalog_status_flag,-1))=nvl(msi.catalog_status_flag,-1) and
  decode(iacl.collateral_flag,1,nvl(msim.collateral_flag,-1),nvl(msi.collateral_flag,-1))=nvl(msi.collateral_flag,-1) and
  decode(iacl.default_shipping_org,1,nvl(msim.default_shipping_org,-1),nvl(msi.default_shipping_org,-1))=nvl(msi.default_shipping_org,-1) and
  decode(iacl.inspection_required_flag,1,nvl(msim.inspection_required_flag,-1),nvl(msi.inspection_required_flag,-1))=nvl(msi.inspection_required_flag,-1) and
  decode(iacl.market_price,1,nvl(msim.market_price,-1),nvl(msi.market_price,-1))=nvl(msi.market_price,-1) and
  decode(iacl.purchasing_tax_code,1,nvl(msim.purchasing_tax_code,-1),nvl(msi.purchasing_tax_code,-1))=nvl(msi.purchasing_tax_code,-1) and
  decode(iacl.qty_rcv_exception_code,1,nvl(msim.qty_rcv_exception_code,-1),nvl(msi.qty_rcv_exception_code,-1))=nvl(msi.qty_rcv_exception_code,-1) and
  decode(iacl.receipt_required_flag,1,nvl(msim.receipt_required_flag,-1),nvl(msi.receipt_required_flag,-1))=nvl(msi.receipt_required_flag,-1) and
  decode(iacl.returnable_flag,1,nvl(msim.returnable_flag,-1),nvl(msi.returnable_flag,-1))=nvl(msi.returnable_flag,-1) and
  decode(iacl.taxable_flag,1,nvl(msim.taxable_flag,-1),nvl(msi.taxable_flag,-1))=nvl(msi.taxable_flag,-1)
) or
not ( -- 1E (INVPVALM)
  decode(iacl.asset_category_id,1,nvl(msim.asset_category_id,-1),nvl(msi.asset_category_id,-1))=nvl(msi.asset_category_id,-1) and
  decode(iacl.enforce_ship_to_location_code,1,nvl(msim.enforce_ship_to_location_code,-1),nvl(msi.enforce_ship_to_location_code,-1))=nvl(msi.enforce_ship_to_location_code,-1) and
  decode(iacl.hazard_class_id,1,nvl(msim.hazard_class_id,-1),nvl(msi.hazard_class_id,-1))=nvl(msi.hazard_class_id,-1) and
  decode(iacl.list_price_per_unit,1,nvl(msim.list_price_per_unit,-1),nvl(msi.list_price_per_unit,-1))=nvl(msi.list_price_per_unit,-1) and
  decode(iacl.price_tolerance_percent,1,nvl(msim.price_tolerance_percent,-1),nvl(msi.price_tolerance_percent,-1))=nvl(msi.price_tolerance_percent,-1) and
  decode(iacl.qty_rcv_tolerance,1,nvl(msim.qty_rcv_tolerance,-1),nvl(msi.qty_rcv_tolerance,-1))=nvl(msi.qty_rcv_tolerance,-1) and
  decode(iacl.rfq_required_flag,1,nvl(msim.rfq_required_flag,-1),nvl(msi.rfq_required_flag,-1))=nvl(msi.rfq_required_flag,-1) and
  decode(iacl.rounding_factor,1,nvl(msim.rounding_factor,-1),nvl(msi.rounding_factor,-1))=nvl(msi.rounding_factor,-1) and
  decode(iacl.un_number_id,1,nvl(msim.un_number_id,-1),nvl(msi.un_number_id,-1))=nvl(msi.un_number_id,-1) and
  decode(iacl.unit_of_issue,1,nvl(msim.unit_of_issue,-1),nvl(msi.unit_of_issue,-1))=nvl(msi.unit_of_issue,-1)
) or
not ( -- 1F (INVPVALM)
  decode(iacl.allow_express_delivery_flag,1,nvl(msim.allow_express_delivery_flag,-1),nvl(msi.allow_express_delivery_flag,-1))=nvl(msi.allow_express_delivery_flag,-1) and
  decode(iacl.allow_substitute_receipts_flag,1,nvl(msim.allow_substitute_receipts_flag,-1),nvl(msi.allow_substitute_receipts_flag,-1))=nvl(msi.allow_substitute_receipts_flag,-1) and
  decode(iacl.allow_unordered_receipts_flag,1,nvl(msim.allow_unordered_receipts_flag,-1),nvl(msi.allow_unordered_receipts_flag,-1))=nvl(msi.allow_unordered_receipts_flag,-1) and
  decode(iacl.days_early_receipt_allowed,1,nvl(msim.days_early_receipt_allowed,-1),nvl(msi.days_early_receipt_allowed,-1))=nvl(msi.days_early_receipt_allowed,-1) and
  decode(iacl.days_late_receipt_allowed,1,nvl(msim.days_late_receipt_allowed,-1),nvl(msi.days_late_receipt_allowed,-1))=nvl(msi.days_late_receipt_allowed,-1)
) or
not ( -- 1G (INVPVALM)
  decode(iacl.auto_lot_alpha_prefix,1,nvl(msim.auto_lot_alpha_prefix,-1),nvl(msi.auto_lot_alpha_prefix,-1))=nvl(msi.auto_lot_alpha_prefix,-1) and
  decode(iacl.description,1,nvl(msim.description,-1),nvl(msi.description,-1))=nvl(msi.description,-1) and
  decode(iacl.invoice_close_tolerance,1,nvl(msim.invoice_close_tolerance,-1),nvl(msi.invoice_close_tolerance,-1))=nvl(msi.invoice_close_tolerance,-1) and
  decode(iacl.long_description,1,nvl(msim.long_description,-1),nvl(msi.long_description,-1))=nvl(msi.long_description,-1) and
  decode(iacl.receipt_days_exception_code,1,nvl(msim.receipt_days_exception_code,-1),nvl(msi.receipt_days_exception_code,-1))=nvl(msi.receipt_days_exception_code,-1) and
  decode(iacl.receive_close_tolerance,1,nvl(msim.receive_close_tolerance,-1),nvl(msi.receive_close_tolerance,-1))=nvl(msi.receive_close_tolerance,-1) and
  decode(iacl.receiving_routing_id,1,nvl(msim.receiving_routing_id,-1),nvl(msi.receiving_routing_id,-1))=nvl(msi.receiving_routing_id,-1)
) or
not ( -- 1HA (INVPVALM)
  decode(iacl.over_shipment_tolerance,1,nvl(msim.over_shipment_tolerance,-1),nvl(msi.over_shipment_tolerance,-1))=nvl(msi.over_shipment_tolerance,-1) and
  decode(iacl.overcompletion_tolerance_type,1,nvl(msim.overcompletion_tolerance_type,-1),nvl(msi.overcompletion_tolerance_type,-1))=nvl(msi.overcompletion_tolerance_type,-1) and
  decode(iacl.overcompletion_tolerance_value,1,nvl(msim.overcompletion_tolerance_value,-1),nvl(msi.overcompletion_tolerance_value,-1))=nvl(msi.overcompletion_tolerance_value,-1) and
  decode(iacl.under_shipment_tolerance,1,nvl(msim.under_shipment_tolerance,-1),nvl(msi.under_shipment_tolerance,-1))=nvl(msi.under_shipment_tolerance,-1)
) or
not ( -- 1HB (INVPVALM)
  decode(iacl.defect_tracking_on_flag,1,nvl(msim.defect_tracking_on_flag,-1),nvl(msi.defect_tracking_on_flag,-1))=nvl(msi.defect_tracking_on_flag,-1) and
  decode(iacl.equipment_type,1,nvl(msim.equipment_type,-1),nvl(msi.equipment_type,-1))=nvl(msi.equipment_type,-1) and
  decode(iacl.over_return_tolerance,1,nvl(msim.over_return_tolerance,-1),nvl(msi.over_return_tolerance,-1))=nvl(msi.over_return_tolerance,-1) and
  decode(iacl.recovered_part_disp_code,1,nvl(msim.recovered_part_disp_code,-1),nvl(msi.recovered_part_disp_code,-1))=nvl(msi.recovered_part_disp_code,-1) and
  decode(iacl.under_return_tolerance,1,nvl(msim.under_return_tolerance,-1),nvl(msi.under_return_tolerance,-1))=nvl(msi.under_return_tolerance,-1)
) or
not ( -- 1HC (INVPVALM)
  decode(iacl.coupon_exempt_flag,1,nvl(msim.coupon_exempt_flag,-1),nvl(msi.coupon_exempt_flag,-1))=nvl(msi.coupon_exempt_flag,-1) and
  decode(iacl.downloadable_flag,1,nvl(msim.downloadable_flag,-1),nvl(msi.downloadable_flag,-1))=nvl(msi.downloadable_flag,-1) and
  decode(iacl.electronic_flag,1,nvl(msim.electronic_flag,-1),nvl(msi.electronic_flag,-1))=nvl(msi.electronic_flag,-1) and
  decode(iacl.event_flag,1,nvl(msim.event_flag,-1),nvl(msi.event_flag,-1))=nvl(msi.event_flag,-1) and
  decode(iacl.vol_discount_exempt_flag,1,nvl(msim.vol_discount_exempt_flag,-1),nvl(msi.vol_discount_exempt_flag,-1))=nvl(msi.vol_discount_exempt_flag,-1)
) or
not ( -- 1HD (INVPVALM)
  decode(iacl.asset_creation_code,1,nvl(msim.asset_creation_code,-1),nvl(msi.asset_creation_code,-1))=nvl(msi.asset_creation_code,-1) and
  decode(iacl.back_orderable_flag,1,nvl(msim.back_orderable_flag,-1),nvl(msi.back_orderable_flag,-1))=nvl(msi.back_orderable_flag,-1) and
  decode(iacl.comms_activation_reqd_flag,1,nvl(msim.comms_activation_reqd_flag,-1),nvl(msi.comms_activation_reqd_flag,-1))=nvl(msi.comms_activation_reqd_flag,-1) and
  decode(iacl.comms_nl_trackable_flag,1,nvl(msim.comms_nl_trackable_flag,-1),nvl(msi.comms_nl_trackable_flag,-1))=nvl(msi.comms_nl_trackable_flag,-1) and
  &lp_ib_item_tracking_level_where --decode(iacl.ib_item_tracking_level,1,nvl(msim.ib_item_tracking_level,-1),nvl(msi.ib_item_tracking_level,-1))=nvl(msi.ib_item_tracking_level,-1) and
  decode(iacl.orderable_on_web_flag,1,nvl(msim.orderable_on_web_flag,-1),nvl(msi.orderable_on_web_flag,-1))=nvl(msi.orderable_on_web_flag,-1)
) or
not ( -- 1IA (INVPVALM)
  decode(iacl.bulk_picked_flag,1,nvl(msim.bulk_picked_flag,-1),nvl(msi.bulk_picked_flag,-1))=nvl(msi.bulk_picked_flag,-1) and
  decode(iacl.default_lot_status_id,1,nvl(msim.default_lot_status_id,-1),nvl(msi.default_lot_status_id,-1))=nvl(msi.default_lot_status_id,-1) and
  decode(iacl.dimension_uom_code,1,nvl(msim.dimension_uom_code,-1),nvl(msi.dimension_uom_code,-1))=nvl(msi.dimension_uom_code,-1) and
  decode(iacl.lot_status_enabled,1,nvl(msim.lot_status_enabled,-1),nvl(msi.lot_status_enabled,-1))=nvl(msi.lot_status_enabled,-1) and
  decode(iacl.unit_height,1,nvl(msim.unit_height,-1),nvl(msi.unit_height,-1))=nvl(msi.unit_height,-1) and
  decode(iacl.unit_length,1,nvl(msim.unit_length,-1),nvl(msi.unit_length,-1))=nvl(msi.unit_length,-1) and
  decode(iacl.unit_width,1,nvl(msim.unit_width,-1),nvl(msi.unit_width,-1))=nvl(msi.unit_width,-1)
) or
not ( -- 1IB (INVPVALM)
  decode(iacl.default_material_status_id,1,nvl(msim.default_material_status_id,-1),nvl(msi.default_material_status_id,-1))=nvl(msi.default_material_status_id,-1) and
  decode(iacl.default_serial_status_id,1,nvl(msim.default_serial_status_id,-1),nvl(msi.default_serial_status_id,-1))=nvl(msi.default_serial_status_id,-1) and
  decode(iacl.lot_merge_enabled,1,nvl(msim.lot_merge_enabled,-1),nvl(msi.lot_merge_enabled,-1))=nvl(msi.lot_merge_enabled,-1) and
  decode(iacl.lot_split_enabled,1,nvl(msim.lot_split_enabled,-1),nvl(msi.lot_split_enabled,-1))=nvl(msi.lot_split_enabled,-1) and
  &lp_mcc_classification_type_where --decode(iacl.mcc_classification_type,1,nvl(msim.mcc_classification_type,-1),nvl(msi.mcc_classification_type,-1))=nvl(msi.mcc_classification_type,-1) and
  decode(iacl.serial_status_enabled,1,nvl(msim.serial_status_enabled,-1),nvl(msi.serial_status_enabled,-1))=nvl(msi.serial_status_enabled,-1)
) or
not ( -- 1IC (INVPVALM)
  decode(iacl.financing_allowed_flag,1,nvl(msim.financing_allowed_flag,-1),nvl(msi.financing_allowed_flag,-1))=nvl(msi.financing_allowed_flag,-1) and
  decode(iacl.inventory_carry_penalty,1,nvl(msim.inventory_carry_penalty,-1),nvl(msi.inventory_carry_penalty,-1))=nvl(msi.inventory_carry_penalty,-1) and
  decode(iacl.operation_slack_penalty,1,nvl(msim.operation_slack_penalty,-1),nvl(msi.operation_slack_penalty,-1))=nvl(msi.operation_slack_penalty,-1)
) or
not ( -- 1IJ (INVPVALM)
  decode(iacl.contract_item_type_code,1,nvl(msim.contract_item_type_code,-1),nvl(msi.contract_item_type_code,-1))=nvl(msi.contract_item_type_code,-1) and
  decode(iacl.dual_uom_deviation_high,1,nvl(msim.dual_uom_deviation_high,-1),nvl(msi.dual_uom_deviation_high,-1))=nvl(msi.dual_uom_deviation_high,-1) and
  decode(iacl.dual_uom_deviation_low,1,nvl(msim.dual_uom_deviation_low,-1),nvl(msi.dual_uom_deviation_low,-1))=nvl(msi.dual_uom_deviation_low,-1) and
  decode(iacl.eam_act_notification_flag,1,nvl(msim.eam_act_notification_flag,-1),nvl(msi.eam_act_notification_flag,-1))=nvl(msi.eam_act_notification_flag,-1) and
  decode(iacl.eam_act_shutdown_status,1,nvl(msim.eam_act_shutdown_status,-1),nvl(msi.eam_act_shutdown_status,-1))=nvl(msi.eam_act_shutdown_status,-1) and
  decode(iacl.eam_activity_cause_code,1,nvl(msim.eam_activity_cause_code,-1),nvl(msi.eam_activity_cause_code,-1))=nvl(msi.eam_activity_cause_code,-1) and
  decode(iacl.eam_activity_type_code,1,nvl(msim.eam_activity_type_code,-1),nvl(msi.eam_activity_type_code,-1))=nvl(msi.eam_activity_type_code,-1) and
  decode(iacl.eam_item_type,1,nvl(msim.eam_item_type,-1),nvl(msi.eam_item_type,-1))=nvl(msi.eam_item_type,-1) and
  decode(iacl.secondary_uom_code,1,nvl(msim.secondary_uom_code,-1),nvl(msi.secondary_uom_code,-1))=nvl(msi.secondary_uom_code,-1)
) or
not ( -- 1IK (INVPVALM)
  decode(iacl.create_supply_flag,1,nvl(msim.create_supply_flag,-1),nvl(msi.create_supply_flag,-1))=nvl(msi.create_supply_flag,-1) and
  decode(iacl.default_so_source_type,1,nvl(msim.default_so_source_type,-1),nvl(msi.default_so_source_type,-1))=nvl(msi.default_so_source_type,-1) and
  decode(iacl.lot_translate_enabled,1,nvl(msim.lot_translate_enabled,-1),nvl(msi.lot_translate_enabled,-1))=nvl(msi.lot_translate_enabled,-1) and
  decode(iacl.planned_inv_point_flag,1,nvl(msim.planned_inv_point_flag,-1),nvl(msi.planned_inv_point_flag,-1))=nvl(msi.planned_inv_point_flag,-1) and
  decode(iacl.serv_billing_enabled_flag,1,nvl(msim.serv_billing_enabled_flag,-1),nvl(msi.serv_billing_enabled_flag,-1))=nvl(msi.serv_billing_enabled_flag,-1) and
  decode(iacl.serv_req_enabled_code,1,nvl(msim.serv_req_enabled_code,-1),nvl(msi.serv_req_enabled_code,-1))=nvl(msi.serv_req_enabled_code,-1) and
  decode(iacl.substitution_window_code,1,nvl(msim.substitution_window_code,-1),nvl(msi.substitution_window_code,-1))=nvl(msi.substitution_window_code,-1) and
  decode(iacl.substitution_window_days,1,nvl(msim.substitution_window_days,-1),nvl(msi.substitution_window_days,-1))=nvl(msi.substitution_window_days,-1)
) or
not ( -- 4A (INVPVLM2)
  decode(iacl.auto_serial_alpha_prefix,1,nvl(msim.auto_serial_alpha_prefix,-1),nvl(msi.auto_serial_alpha_prefix,-1))=nvl(msi.auto_serial_alpha_prefix,-1) and
  decode(iacl.lot_control_code,1,nvl(msim.lot_control_code,-1),nvl(msi.lot_control_code,-1))=nvl(msi.lot_control_code,-1) and
  decode(iacl.serial_number_control_code,1,nvl(msim.serial_number_control_code,-1),nvl(msi.serial_number_control_code,-1))=nvl(msi.serial_number_control_code,-1) and
  decode(iacl.shelf_life_code,1,nvl(msim.shelf_life_code,-1),nvl(msi.shelf_life_code,-1))=nvl(msi.shelf_life_code,-1) and
  decode(iacl.shelf_life_days,1,nvl(msim.shelf_life_days,-1),nvl(msi.shelf_life_days,-1))=nvl(msi.shelf_life_days,-1) and
  decode(iacl.start_auto_lot_number,1,nvl(msim.start_auto_lot_number,-1),nvl(msi.start_auto_lot_number,-1))=nvl(msi.start_auto_lot_number,-1) and
  decode(iacl.start_auto_serial_number,1,nvl(msim.start_auto_serial_number,-1),nvl(msi.start_auto_serial_number,-1))=nvl(msi.start_auto_serial_number,-1)
) or
not ( -- 4B (INVPVLM2)
  decode(iacl.encumbrance_account,1,nvl(msim.encumbrance_account,-1),nvl(msi.encumbrance_account,-1))=nvl(msi.encumbrance_account,-1) and
  decode(iacl.expense_account,1,nvl(msim.expense_account,-1),nvl(msi.expense_account,-1))=nvl(msi.expense_account,-1) and
  decode(iacl.restrict_subinventories_code,1,nvl(msim.restrict_subinventories_code,-1),nvl(msi.restrict_subinventories_code,-1))=nvl(msi.restrict_subinventories_code,-1) and
  decode(iacl.source_organization_id,1,nvl(msim.source_organization_id,-1),nvl(msi.source_organization_id,-1))=nvl(msi.source_organization_id,-1) and
  decode(iacl.source_subinventory,1,nvl(msim.source_subinventory,-1),nvl(msi.source_subinventory,-1))=nvl(msi.source_subinventory,-1) and
  decode(iacl.source_type,1,nvl(msim.source_type,-1),nvl(msi.source_type,-1))=nvl(msi.source_type,-1) and
  decode(iacl.unit_weight,1,nvl(msim.unit_weight,-1),nvl(msi.unit_weight,-1))=nvl(msi.unit_weight,-1) and
  decode(iacl.weight_uom_code,1,nvl(msim.weight_uom_code,-1),nvl(msi.weight_uom_code,-1))=nvl(msi.weight_uom_code,-1)
) or
not ( -- 4C (INVPVLM2)
  decode(iacl.acceptable_early_days,1,nvl(msim.acceptable_early_days,-1),nvl(msi.acceptable_early_days,-1))=nvl(msi.acceptable_early_days,-1) and
  decode(iacl.location_control_code,1,nvl(msim.location_control_code,-1),nvl(msi.location_control_code,-1))=nvl(msi.location_control_code,-1) and
  decode(iacl.planning_time_fence_code,1,nvl(msim.planning_time_fence_code,-1),nvl(msi.planning_time_fence_code,-1))=nvl(msi.planning_time_fence_code,-1) and
  decode(iacl.restrict_locators_code,1,nvl(msim.restrict_locators_code,-1),nvl(msi.restrict_locators_code,-1))=nvl(msi.restrict_locators_code,-1) and
  decode(iacl.shrinkage_rate,1,nvl(msim.shrinkage_rate,-1),nvl(msi.shrinkage_rate,-1))=nvl(msi.shrinkage_rate,-1) and
  decode(iacl.unit_volume,1,nvl(msim.unit_volume,-1),nvl(msi.unit_volume,-1))=nvl(msi.unit_volume,-1) and
  decode(iacl.volume_uom_code,1,nvl(msim.volume_uom_code,-1),nvl(msi.volume_uom_code,-1))=nvl(msi.volume_uom_code,-1)
) or
not ( -- 4D (INVPVLM2)
  decode(iacl.acceptable_rate_decrease,1,nvl(msim.acceptable_rate_decrease,-1),nvl(msi.acceptable_rate_decrease,-1))=nvl(msi.acceptable_rate_decrease,-1) and
  decode(iacl.acceptable_rate_increase,1,nvl(msim.acceptable_rate_increase,-1),nvl(msi.acceptable_rate_increase,-1))=nvl(msi.acceptable_rate_increase,-1) and
  decode(iacl.cum_manufacturing_lead_time,1,nvl(msim.cum_manufacturing_lead_time,-1),nvl(msi.cum_manufacturing_lead_time,-1))=nvl(msi.cum_manufacturing_lead_time,-1) and
  decode(iacl.demand_time_fence_code,1,nvl(msim.demand_time_fence_code,-1),nvl(msi.demand_time_fence_code,-1))=nvl(msi.demand_time_fence_code,-1) and
  decode(iacl.lead_time_lot_size,1,nvl(msim.lead_time_lot_size,-1),nvl(msi.lead_time_lot_size,-1))=nvl(msi.lead_time_lot_size,-1) and
  decode(iacl.mrp_calculate_atp_flag,1,nvl(msim.mrp_calculate_atp_flag,-1),nvl(msi.mrp_calculate_atp_flag,-1))=nvl(msi.mrp_calculate_atp_flag,-1) and
  decode(iacl.overrun_percentage,1,nvl(msim.overrun_percentage,-1),nvl(msi.overrun_percentage,-1))=nvl(msi.overrun_percentage,-1) and
  decode(iacl.std_lot_size,1,nvl(msim.std_lot_size,-1),nvl(msi.std_lot_size,-1))=nvl(msi.std_lot_size,-1)
) or
not ( -- 4E (INVPVLM2)
  decode(iacl.bom_item_type,1,nvl(msim.bom_item_type,-1),nvl(msi.bom_item_type,-1))=nvl(msi.bom_item_type,-1) and
  decode(iacl.cumulative_total_lead_time,1,nvl(msim.cumulative_total_lead_time,-1),nvl(msi.cumulative_total_lead_time,-1))=nvl(msi.cumulative_total_lead_time,-1) and
  decode(iacl.demand_time_fence_days,1,nvl(msim.demand_time_fence_days,-1),nvl(msi.demand_time_fence_days,-1))=nvl(msi.demand_time_fence_days,-1) and
  decode(iacl.end_assembly_pegging_flag,1,nvl(msim.end_assembly_pegging_flag,-1),nvl(msi.end_assembly_pegging_flag,-1))=nvl(msi.end_assembly_pegging_flag,-1) and
  decode(iacl.planning_exception_set,1,nvl(msim.planning_exception_set,-1),nvl(msi.planning_exception_set,-1))=nvl(msi.planning_exception_set,-1) and
  decode(iacl.planning_time_fence_days,1,nvl(msim.planning_time_fence_days,-1),nvl(msi.planning_time_fence_days,-1))=nvl(msi.planning_time_fence_days,-1) and
  decode(iacl.repetitive_planning_flag,1,nvl(msim.repetitive_planning_flag,-1),nvl(msi.repetitive_planning_flag,-1))=nvl(msi.repetitive_planning_flag,-1)
) or
not ( -- 4F (INVPVLM2)
  decode(iacl.atp_components_flag,1,nvl(msim.atp_components_flag,-1),nvl(msi.atp_components_flag,-1))=nvl(msi.atp_components_flag,-1) and
  decode(iacl.atp_flag,1,nvl(msim.atp_flag,-1),nvl(msi.atp_flag,-1))=nvl(msi.atp_flag,-1) and
  decode(iacl.base_item_id,1,nvl(msim.base_item_id,-1),nvl(msi.base_item_id,-1))=nvl(msi.base_item_id,-1) and
  decode(iacl.fixed_lead_time,1,nvl(msim.fixed_lead_time,-1),nvl(msi.fixed_lead_time,-1))=nvl(msi.fixed_lead_time,-1) and
  decode(iacl.pick_components_flag,1,nvl(msim.pick_components_flag,-1),nvl(msi.pick_components_flag,-1))=nvl(msi.pick_components_flag,-1) and
  decode(iacl.replenish_to_order_flag,1,nvl(msim.replenish_to_order_flag,-1),nvl(msi.replenish_to_order_flag,-1))=nvl(msi.replenish_to_order_flag,-1) and
  decode(iacl.variable_lead_time,1,nvl(msim.variable_lead_time,-1),nvl(msi.variable_lead_time,-1))=nvl(msi.variable_lead_time,-1) and
  decode(iacl.wip_supply_locator_id,1,nvl(msim.wip_supply_locator_id,-1),nvl(msi.wip_supply_locator_id,-1))=nvl(msi.wip_supply_locator_id,-1)
) or
not ( -- 4G (INVPVLM2)
  decode(iacl.allowed_units_lookup_code,1,nvl(msim.allowed_units_lookup_code,-1),nvl(msi.allowed_units_lookup_code,-1))=nvl(msi.allowed_units_lookup_code,-1) and
  decode(iacl.cost_of_sales_account,1,nvl(msim.cost_of_sales_account,-1),nvl(msi.cost_of_sales_account,-1))=nvl(msi.cost_of_sales_account,-1) and
  decode(iacl.primary_uom_code,1,nvl(msim.primary_uom_code,-1),nvl(msi.primary_uom_code,-1))=nvl(msi.primary_uom_code,-1) and
  decode(iacl.sales_account,1,nvl(msim.sales_account,-1),nvl(msi.sales_account,-1))=nvl(msi.sales_account,-1) and
  decode(iacl.wip_supply_subinventory,1,nvl(msim.wip_supply_subinventory,-1),nvl(msi.wip_supply_subinventory,-1))=nvl(msi.wip_supply_subinventory,-1) and
  decode(iacl.wip_supply_type,1,nvl(msim.wip_supply_type,-1),nvl(msi.wip_supply_type,-1))=nvl(msi.wip_supply_type,-1)
) or
not ( -- 4H (INVPVLM2)
  decode(iacl.carrying_cost,1,nvl(msim.carrying_cost,-1),nvl(msi.carrying_cost,-1))=nvl(msi.carrying_cost,-1) and
  decode(iacl.default_include_in_rollup_flag,1,nvl(msim.default_include_in_rollup_flag,-1),nvl(msi.default_include_in_rollup_flag,-1))=nvl(msi.default_include_in_rollup_flag,-1) and
  decode(iacl.fixed_lot_multiplier,1,nvl(msim.fixed_lot_multiplier,-1),nvl(msi.fixed_lot_multiplier,-1))=nvl(msi.fixed_lot_multiplier,-1) and
  decode(iacl.inventory_item_status_code,1,nvl(msim.inventory_item_status_code,-1),nvl(msi.inventory_item_status_code,-1))=nvl(msi.inventory_item_status_code,-1) and
  decode(iacl.inventory_planning_code,1,nvl(msim.inventory_planning_code,-1),nvl(msi.inventory_planning_code,-1))=nvl(msi.inventory_planning_code,-1) and
  decode(iacl.planner_code,1,nvl(msim.planner_code,-1),nvl(msi.planner_code,-1))=nvl(msi.planner_code,-1) and
  decode(iacl.planning_make_buy_code,1,nvl(msim.planning_make_buy_code,-1),nvl(msi.planning_make_buy_code,-1))=nvl(msi.planning_make_buy_code,-1) and
  decode(iacl.rounding_control_type,1,nvl(msim.rounding_control_type,-1),nvl(msi.rounding_control_type,-1))=nvl(msi.rounding_control_type,-1)
) or
not ( -- 4I (INVPVLM2)
  decode(iacl.full_lead_time,1,nvl(msim.full_lead_time,-1),nvl(msi.full_lead_time,-1))=nvl(msi.full_lead_time,-1) and
  decode(iacl.min_minmax_quantity,1,nvl(msim.min_minmax_quantity,-1),nvl(msi.min_minmax_quantity,-1))=nvl(msi.min_minmax_quantity,-1) and
  decode(iacl.mrp_safety_stock_code,1,nvl(msim.mrp_safety_stock_code,-1),nvl(msi.mrp_safety_stock_code,-1))=nvl(msi.mrp_safety_stock_code,-1) and
  decode(iacl.mrp_safety_stock_percent,1,nvl(msim.mrp_safety_stock_percent,-1),nvl(msi.mrp_safety_stock_percent,-1))=nvl(msi.mrp_safety_stock_percent,-1) and
  decode(iacl.order_cost,1,nvl(msim.order_cost,-1),nvl(msi.order_cost,-1))=nvl(msi.order_cost,-1) and
  decode(iacl.postprocessing_lead_time,1,nvl(msim.postprocessing_lead_time,-1),nvl(msi.postprocessing_lead_time,-1))=nvl(msi.postprocessing_lead_time,-1) and
  decode(iacl.preprocessing_lead_time,1,nvl(msim.preprocessing_lead_time,-1),nvl(msi.preprocessing_lead_time,-1))=nvl(msi.preprocessing_lead_time,-1)
) or
not ( -- 4J (INVPVLM2)
  decode(iacl.atp_rule_id,1,nvl(msim.atp_rule_id,-1),nvl(msi.atp_rule_id,-1))=nvl(msi.atp_rule_id,-1) and
  decode(iacl.fixed_order_quantity,1,nvl(msim.fixed_order_quantity,-1),nvl(msi.fixed_order_quantity,-1))=nvl(msi.fixed_order_quantity,-1) and
  decode(iacl.max_minmax_quantity,1,nvl(msim.max_minmax_quantity,-1),nvl(msi.max_minmax_quantity,-1))=nvl(msi.max_minmax_quantity,-1) and
  decode(iacl.maximum_order_quantity,1,nvl(msim.maximum_order_quantity,-1),nvl(msi.maximum_order_quantity,-1))=nvl(msi.maximum_order_quantity,-1) and
  decode(iacl.minimum_order_quantity,1,nvl(msim.minimum_order_quantity,-1),nvl(msi.minimum_order_quantity,-1))=nvl(msi.minimum_order_quantity,-1) and
  decode(iacl.picking_rule_id,1,nvl(msim.picking_rule_id,-1),nvl(msi.picking_rule_id,-1))=nvl(msi.picking_rule_id,-1)
) or
not ( -- 4K (INVPVLM2)
  decode(iacl.auto_reduce_mps,1,nvl(msim.auto_reduce_mps,-1),nvl(msi.auto_reduce_mps,-1))=nvl(msi.auto_reduce_mps,-1) and
  decode(iacl.costing_enabled_flag,1,nvl(msim.costing_enabled_flag,-1),nvl(msi.costing_enabled_flag,-1))=nvl(msi.costing_enabled_flag,-1) and
  decode(iacl.outside_operation_flag,1,nvl(msim.outside_operation_flag,-1),nvl(msi.outside_operation_flag,-1))=nvl(msi.outside_operation_flag,-1) and
  decode(iacl.outside_operation_uom_type,1,nvl(msim.outside_operation_uom_type,-1),nvl(msi.outside_operation_uom_type,-1))=nvl(msi.outside_operation_uom_type,-1) and
  decode(iacl.positive_measurement_error,1,nvl(msim.positive_measurement_error,-1),nvl(msi.positive_measurement_error,-1))=nvl(msi.positive_measurement_error,-1) and
  decode(iacl.reservable_type,1,nvl(msim.reservable_type,-1),nvl(msi.reservable_type,-1))=nvl(msi.reservable_type,-1) and
  decode(iacl.safety_stock_bucket_days,1,nvl(msim.safety_stock_bucket_days,-1),nvl(msi.safety_stock_bucket_days,-1))=nvl(msi.safety_stock_bucket_days,-1)
) or
not ( -- 4L (INVPVLM2)
  decode(iacl.ato_forecast_control,1,nvl(msim.ato_forecast_control,-1),nvl(msi.ato_forecast_control,-1))=nvl(msi.ato_forecast_control,-1) and
  decode(iacl.auto_created_config_flag,1,nvl(msim.auto_created_config_flag,-1),nvl(msi.auto_created_config_flag,-1))=nvl(msi.auto_created_config_flag,-1) and
  decode(iacl.cycle_count_enabled_flag,1,nvl(msim.cycle_count_enabled_flag,-1),nvl(msi.cycle_count_enabled_flag,-1))=nvl(msi.cycle_count_enabled_flag,-1) and
  decode(iacl.item_type,1,nvl(msim.item_type,-1),nvl(msi.item_type,-1))=nvl(msi.item_type,-1) and
  decode(iacl.mrp_planning_code,1,nvl(msim.mrp_planning_code,-1),nvl(msi.mrp_planning_code,-1))=nvl(msi.mrp_planning_code,-1) and
  decode(iacl.model_config_clause_name,1,nvl(msim.model_config_clause_name,-1),nvl(msi.model_config_clause_name,-1))=nvl(msi.model_config_clause_name,-1) and
  decode(iacl.return_inspection_requirement,1,nvl(msim.return_inspection_requirement,-1),nvl(msi.return_inspection_requirement,-1))=nvl(msi.return_inspection_requirement,-1) and
  decode(iacl.ship_model_complete_flag,1,nvl(msim.ship_model_complete_flag,-1),nvl(msi.ship_model_complete_flag,-1))=nvl(msi.ship_model_complete_flag,-1)
) or
not ( -- 4M (INVPVLM2)
  decode(iacl.config_model_type,1,nvl(msim.config_model_type,-1),nvl(msi.config_model_type,-1))=nvl(msi.config_model_type,-1) and
  decode(iacl.eam_activity_source_code,1,nvl(msim.eam_activity_source_code,-1),nvl(msi.eam_activity_source_code,-1))=nvl(msi.eam_activity_source_code,-1) and
  decode(iacl.ib_item_instance_class,1,nvl(msim.ib_item_instance_class,-1),nvl(msi.ib_item_instance_class,-1))=nvl(msi.ib_item_instance_class,-1) and
  decode(iacl.lot_substitution_enabled,1,nvl(msim.lot_substitution_enabled,-1),nvl(msi.lot_substitution_enabled,-1))=nvl(msi.lot_substitution_enabled,-1) and
  decode(iacl.minimum_license_quantity,1,nvl(msim.minimum_license_quantity,-1),nvl(msi.minimum_license_quantity,-1))=nvl(msi.minimum_license_quantity,-1)
) or
not ( -- 4N (INVPVLM2)
  decode(iacl.charge_periodicity_code,1,nvl(msim.charge_periodicity_code,-1),nvl(msi.charge_periodicity_code,-1))=nvl(msi.charge_periodicity_code,-1) and
  decode(iacl.outsourced_assembly,1,nvl(msim.outsourced_assembly,-1),nvl(msi.outsourced_assembly,-1))=nvl(msi.outsourced_assembly,-1) and
  decode(iacl.subcontracting_component,1,nvl(msim.subcontracting_component,-1),nvl(msi.subcontracting_component,-1))=nvl(msi.subcontracting_component,-1)
) or
not ( -- 4O (INVPVLM2)
  decode(iacl.preposition_point,1,nvl(msim.preposition_point,-1),nvl(msi.preposition_point,-1))=nvl(msi.preposition_point,-1) and
  decode(iacl.repair_leadtime,1,nvl(msim.repair_leadtime,-1),nvl(msi.repair_leadtime,-1))=nvl(msi.repair_leadtime,-1) and
  decode(iacl.repair_program,1,nvl(msim.repair_program,-1),nvl(msi.repair_program,-1))=nvl(msi.repair_program,-1) and
  decode(iacl.repair_yield,1,nvl(msim.repair_yield,-1),nvl(msi.repair_yield,-1))=nvl(msi.repair_yield,-1)
) or
not ( -- 7A (INVPVLM3)
  decode(iacl.engineering_date,1,nvl(msim.engineering_date,to_date('1000/01/01','YYYY/MM/DD')),nvl(msi.engineering_date,to_date('1000/01/01','YYYY/MM/DD')))=nvl(msi.engineering_date,to_date('1000/01/01','YYYY/MM/DD')) and
  decode(iacl.engineering_ecn_code,1,nvl(msim.engineering_ecn_code,-1),nvl(msi.engineering_ecn_code,-1))=nvl(msi.engineering_ecn_code,-1) and
  decode(iacl.engineering_item_id,1,nvl(msim.engineering_item_id,-1),nvl(msi.engineering_item_id,-1))=nvl(msi.engineering_item_id,-1) and
  decode(iacl.negative_measurement_error,1,nvl(msim.negative_measurement_error,-1),nvl(msi.negative_measurement_error,-1))=nvl(msi.negative_measurement_error,-1) and
  decode(iacl.service_starting_delay,1,nvl(msim.service_starting_delay,-1),nvl(msi.service_starting_delay,-1))=nvl(msi.service_starting_delay,-1) and
  decode(iacl.serviceable_component_flag,1,nvl(msim.serviceable_component_flag,-1),nvl(msi.serviceable_component_flag,-1))=nvl(msi.serviceable_component_flag,-1)
) or
not ( -- 7B (INVPVLM3)
  decode(iacl.base_warranty_service_id,1,nvl(msim.base_warranty_service_id,-1),nvl(msi.base_warranty_service_id,-1))=nvl(msi.base_warranty_service_id,-1) and
  decode(iacl.payment_terms_id,1,nvl(msim.payment_terms_id,-1),nvl(msi.payment_terms_id,-1))=nvl(msi.payment_terms_id,-1) and
  decode(iacl.preventive_maintenance_flag,1,nvl(msim.preventive_maintenance_flag,-1),nvl(msi.preventive_maintenance_flag,-1))=nvl(msi.preventive_maintenance_flag,-1) and
  decode(iacl.primary_specialist_id,1,nvl(msim.primary_specialist_id,-1),nvl(msi.primary_specialist_id,-1))=nvl(msi.primary_specialist_id,-1) and
  decode(iacl.secondary_specialist_id,1,nvl(msim.secondary_specialist_id,-1),nvl(msi.secondary_specialist_id,-1))=nvl(msi.secondary_specialist_id,-1) and
  decode(iacl.serviceable_item_class_id,1,nvl(msim.serviceable_item_class_id,-1),nvl(msi.serviceable_item_class_id,-1))=nvl(msi.serviceable_item_class_id,-1) and
  decode(iacl.serviceable_product_flag,1,nvl(msim.serviceable_product_flag,-1),nvl(msi.serviceable_product_flag,-1))=nvl(msi.serviceable_product_flag,-1)
) or
not ( -- 7C (INVPVLM3)
  decode(iacl.coverage_schedule_id,1,nvl(msim.coverage_schedule_id,-1),nvl(msi.coverage_schedule_id,-1))=nvl(msi.coverage_schedule_id,-1) and
  decode(iacl.material_billable_flag,1,nvl(msim.material_billable_flag,-1),nvl(msi.material_billable_flag,-1))=nvl(msi.material_billable_flag,-1) and
  decode(iacl.prorate_service_flag,1,nvl(msim.prorate_service_flag,-1),nvl(msi.prorate_service_flag,-1))=nvl(msi.prorate_service_flag,-1) and
  decode(iacl.service_duration,1,nvl(msim.service_duration,-1),nvl(msi.service_duration,-1))=nvl(msi.service_duration,-1) and
  decode(iacl.service_duration_period_code,1,nvl(msim.service_duration_period_code,-1),nvl(msi.service_duration_period_code,-1))=nvl(msi.service_duration_period_code,-1) and
  decode(iacl.warranty_vendor_id,1,nvl(msim.warranty_vendor_id,-1),nvl(msi.warranty_vendor_id,-1))=nvl(msi.warranty_vendor_id,-1)
) or
not ( -- 7D (INVPVLM3)
  decode(iacl.invoice_enabled_flag,1,nvl(msim.invoice_enabled_flag,-1),nvl(msi.invoice_enabled_flag,-1))=nvl(msi.invoice_enabled_flag,-1) and
  decode(iacl.invoiceable_item_flag,1,nvl(msim.invoiceable_item_flag,-1),nvl(msi.invoiceable_item_flag,-1))=nvl(msi.invoiceable_item_flag,-1) and
  decode(iacl.max_warranty_amount,1,nvl(msim.max_warranty_amount,-1),nvl(msi.max_warranty_amount,-1))=nvl(msi.max_warranty_amount,-1) and
  decode(iacl.must_use_approved_vendor_flag,1,nvl(msim.must_use_approved_vendor_flag,-1),nvl(msi.must_use_approved_vendor_flag,-1))=nvl(msi.must_use_approved_vendor_flag,-1) and
  decode(iacl.new_revision_code,1,nvl(msim.new_revision_code,-1),nvl(msi.new_revision_code,-1))=nvl(msi.new_revision_code,-1) and
  decode(iacl.response_time_period_code,1,nvl(msim.response_time_period_code,-1),nvl(msi.response_time_period_code,-1))=nvl(msi.response_time_period_code,-1) and
  decode(iacl.response_time_value,1,nvl(msim.response_time_value,-1),nvl(msi.response_time_value,-1))=nvl(msi.response_time_value,-1) and
  decode(iacl.tax_code,1,nvl(msim.tax_code,-1),nvl(msi.tax_code,-1))=nvl(msi.tax_code,-1)
) or
not ( -- 7E (INVPVLM3)
  decode(iacl.container_item_flag,1,nvl(msim.container_item_flag,-1),nvl(msi.container_item_flag,-1))=nvl(msi.container_item_flag,-1) and
  decode(iacl.container_type_code,1,nvl(msim.container_type_code,-1),nvl(msi.container_type_code,-1))=nvl(msi.container_type_code,-1) and
  decode(iacl.internal_volume,1,nvl(msim.internal_volume,-1),nvl(msi.internal_volume,-1))=nvl(msi.internal_volume,-1) and
  decode(iacl.maximum_load_weight,1,nvl(msim.maximum_load_weight,-1),nvl(msi.maximum_load_weight,-1))=nvl(msi.maximum_load_weight,-1) and
  decode(iacl.minimum_fill_percent,1,nvl(msim.minimum_fill_percent,-1),nvl(msi.minimum_fill_percent,-1))=nvl(msi.minimum_fill_percent,-1) and
  decode(iacl.release_time_fence_code,1,nvl(msim.release_time_fence_code,-1),nvl(msi.release_time_fence_code,-1))=nvl(msi.release_time_fence_code,-1) and
  decode(iacl.release_time_fence_days,1,nvl(msim.release_time_fence_days,-1),nvl(msi.release_time_fence_days,-1))=nvl(msi.release_time_fence_days,-1) and
  decode(iacl.vehicle_item_flag,1,nvl(msim.vehicle_item_flag,-1),nvl(msi.vehicle_item_flag,-1))=nvl(msi.vehicle_item_flag,-1)
) or
not ( -- 7F (INVPVLM3)
  decode(iacl.ont_pricing_qty_source,1,nvl(msim.ont_pricing_qty_source,-1),nvl(msi.ont_pricing_qty_source,-1))=nvl(msi.ont_pricing_qty_source,-1) and
  decode(iacl.secondary_default_ind,1,nvl(msim.secondary_default_ind,-1),nvl(msi.secondary_default_ind,-1))=nvl(msi.secondary_default_ind,-1) and
  decode(iacl.tracking_quantity_ind,1,nvl(msim.tracking_quantity_ind,-1),nvl(msi.tracking_quantity_ind,-1))=nvl(msi.tracking_quantity_ind,-1)
) or
not ( -- 7G (INVPVLM3)
  decode(iacl.config_match,1,nvl(msim.config_match,-1),nvl(msi.config_match,-1))=nvl(msi.config_match,-1) and
  decode(iacl.config_orgs,1,nvl(msim.config_orgs,-1),nvl(msi.config_orgs,-1))=nvl(msi.config_orgs,-1)
) or
not ( -- 7H (INVPVLM3)
  decode(iacl.asn_autoexpire_flag,1,nvl(msim.asn_autoexpire_flag,-1),nvl(msi.asn_autoexpire_flag,-1))=nvl(msi.asn_autoexpire_flag,-1) and
  decode(iacl.consigned_flag,1,nvl(msim.consigned_flag,-1),nvl(msi.consigned_flag,-1))=nvl(msi.consigned_flag,-1) and
  decode(iacl.continous_transfer,1,nvl(msim.continous_transfer,-1),nvl(msi.continous_transfer,-1))=nvl(msi.continous_transfer,-1) and
  decode(iacl.convergence,1,nvl(msim.convergence,-1),nvl(msi.convergence,-1))=nvl(msi.convergence,-1) and
  decode(iacl.critical_component_flag,1,nvl(msim.critical_component_flag,-1),nvl(msi.critical_component_flag,-1))=nvl(msi.critical_component_flag,-1) and
  decode(iacl.days_max_inv_supply,1,nvl(msim.days_max_inv_supply,-1),nvl(msi.days_max_inv_supply,-1))=nvl(msi.days_max_inv_supply,-1) and
  decode(iacl.days_max_inv_window,1,nvl(msim.days_max_inv_window,-1),nvl(msi.days_max_inv_window,-1))=nvl(msi.days_max_inv_window,-1) and
  decode(iacl.days_tgt_inv_supply,1,nvl(msim.days_tgt_inv_supply,-1),nvl(msi.days_tgt_inv_supply,-1))=nvl(msi.days_tgt_inv_supply,-1) and
  decode(iacl.days_tgt_inv_window,1,nvl(msim.days_tgt_inv_window,-1),nvl(msi.days_tgt_inv_window,-1))=nvl(msi.days_tgt_inv_window,-1) and
  decode(iacl.divergence,1,nvl(msim.divergence,-1),nvl(msi.divergence,-1))=nvl(msi.divergence,-1) and
  decode(iacl.drp_planned_flag,1,nvl(msim.drp_planned_flag,-1),nvl(msi.drp_planned_flag,-1))=nvl(msi.drp_planned_flag,-1) and
  decode(iacl.exclude_from_budget_flag,1,nvl(msim.exclude_from_budget_flag,-1),nvl(msi.exclude_from_budget_flag,-1))=nvl(msi.exclude_from_budget_flag,-1) and
  decode(iacl.forecast_horizon,1,nvl(msim.forecast_horizon,-1),nvl(msi.forecast_horizon,-1))=nvl(msi.forecast_horizon,-1) and
  decode(iacl.so_authorization_flag,1,nvl(msim.so_authorization_flag,-1),nvl(msi.so_authorization_flag,-1))=nvl(msi.so_authorization_flag,-1) and
  decode(iacl.vmi_fixed_order_quantity,1,nvl(msim.vmi_fixed_order_quantity,-1),nvl(msi.vmi_fixed_order_quantity,-1))=nvl(msi.vmi_fixed_order_quantity,-1) and
  decode(iacl.vmi_forecast_type,1,nvl(msim.vmi_forecast_type,-1),nvl(msi.vmi_forecast_type,-1))=nvl(msi.vmi_forecast_type,-1) and
  decode(iacl.vmi_maximum_days,1,nvl(msim.vmi_maximum_days,-1),nvl(msi.vmi_maximum_days,-1))=nvl(msi.vmi_maximum_days,-1) and
  decode(iacl.vmi_maximum_units,1,nvl(msim.vmi_maximum_units,-1),nvl(msi.vmi_maximum_units,-1))=nvl(msi.vmi_maximum_units,-1) and
  decode(iacl.vmi_minimum_days,1,nvl(msim.vmi_minimum_days,-1),nvl(msi.vmi_minimum_days,-1))=nvl(msi.vmi_minimum_days,-1) and
  decode(iacl.vmi_minimum_units,1,nvl(msim.vmi_minimum_units,-1),nvl(msi.vmi_minimum_units,-1))=nvl(msi.vmi_minimum_units,-1)
) or
not ( -- 7I (INVPVLM3)
  decode(iacl.child_lot_flag,1,nvl(msim.child_lot_flag,-1),nvl(msi.child_lot_flag,-1))=nvl(msi.child_lot_flag,-1) and
  decode(iacl.child_lot_prefix,1,nvl(msim.child_lot_prefix,-1),nvl(msi.child_lot_prefix,-1))=nvl(msi.child_lot_prefix,-1) and
  decode(iacl.child_lot_starting_number,1,nvl(msim.child_lot_starting_number,-1),nvl(msi.child_lot_starting_number,-1))=nvl(msi.child_lot_starting_number,-1) and
  decode(iacl.child_lot_validation_flag,1,nvl(msim.child_lot_validation_flag,-1),nvl(msi.child_lot_validation_flag,-1))=nvl(msi.child_lot_validation_flag,-1) and
  decode(iacl.copy_lot_attribute_flag,1,nvl(msim.copy_lot_attribute_flag,-1),nvl(msi.copy_lot_attribute_flag,-1))=nvl(msi.copy_lot_attribute_flag,-1) and
  decode(iacl.default_grade,1,nvl(msim.default_grade,-1),nvl(msi.default_grade,-1))=nvl(msi.default_grade,-1) and
  decode(iacl.grade_control_flag,1,nvl(msim.grade_control_flag,-1),nvl(msi.grade_control_flag,-1))=nvl(msi.grade_control_flag,-1) and
  decode(iacl.lot_divisible_flag,1,nvl(msim.lot_divisible_flag,-1),nvl(msi.lot_divisible_flag,-1))=nvl(msi.lot_divisible_flag,-1) and
  decode(iacl.parent_child_generation_flag,1,nvl(msim.parent_child_generation_flag,-1),nvl(msi.parent_child_generation_flag,-1))=nvl(msi.parent_child_generation_flag,-1) and
  decode(iacl.process_execution_enabled_flag,1,nvl(msim.process_execution_enabled_flag,-1),nvl(msi.process_execution_enabled_flag,-1))=nvl(msi.process_execution_enabled_flag,-1) and
  decode(iacl.process_quality_enabled_flag,1,nvl(msim.process_quality_enabled_flag,-1),nvl(msi.process_quality_enabled_flag,-1))=nvl(msi.process_quality_enabled_flag,-1) and
  decode(iacl.recipe_enabled_flag,1,nvl(msim.recipe_enabled_flag,-1),nvl(msi.recipe_enabled_flag,-1))=nvl(msi.recipe_enabled_flag,-1)
) or
not ( -- 7J (INVPVLM3)
  decode(iacl.cas_number,1,nvl(msim.cas_number,-1),nvl(msi.cas_number,-1))=nvl(msi.cas_number,-1) and
  decode(iacl.expiration_action_code,1,nvl(msim.expiration_action_code,-1),nvl(msi.expiration_action_code,-1))=nvl(msi.expiration_action_code,-1) and
  decode(iacl.expiration_action_interval,1,nvl(msim.expiration_action_interval,-1),nvl(msi.expiration_action_interval,-1))=nvl(msi.expiration_action_interval,-1) and
  decode(iacl.hazardous_material_flag,1,nvl(msim.hazardous_material_flag,-1),nvl(msi.hazardous_material_flag,-1))=nvl(msi.hazardous_material_flag,-1) and
  decode(iacl.hold_days,1,nvl(msim.hold_days,-1),nvl(msi.hold_days,-1))=nvl(msi.hold_days,-1) and
  decode(iacl.maturity_days,1,nvl(msim.maturity_days,-1),nvl(msi.maturity_days,-1))=nvl(msi.maturity_days,-1) and
  decode(iacl.process_costing_enabled_flag,1,nvl(msim.process_costing_enabled_flag,-1),nvl(msi.process_costing_enabled_flag,-1))=nvl(msi.process_costing_enabled_flag,-1) and
  decode(iacl.retest_interval,1,nvl(msim.retest_interval,-1),nvl(msi.retest_interval,-1))=nvl(msi.retest_interval,-1)
) or
not ( -- other item attributes which do not specifically raise an INV_IOI_MASTER_CHILD_xxx error in item import
  --decode(iacl.desc_flex,1,nvl(msim.desc_flex,-1),nvl(msi.desc_flex,-1))=nvl(msi.desc_flex,-1) and
  decode(iacl.dual_uom_control,1,nvl(msim.dual_uom_control,-1),nvl(msi.dual_uom_control,-1))=nvl(msi.dual_uom_control,-1) and
  decode(iacl.effectivity_control,1,nvl(msim.effectivity_control,-1),nvl(msi.effectivity_control,-1))=nvl(msi.effectivity_control,-1) and
  decode(iacl.eng_item_flag,1,nvl(msim.eng_item_flag,-1),nvl(msi.eng_item_flag,-1))=nvl(msi.eng_item_flag,-1) and
  decode(iacl.fixed_days_supply,1,nvl(msim.fixed_days_supply,-1),nvl(msi.fixed_days_supply,-1))=nvl(msi.fixed_days_supply,-1) and
  --decode(iacl.global_desc_flex,1,nvl(msim.global_desc_flex,-1),nvl(msi.global_desc_flex,-1))=nvl(msi.global_desc_flex,-1) and
  decode(iacl.indivisible_flag,1,nvl(msim.indivisible_flag,-1),nvl(msi.indivisible_flag,-1))=nvl(msi.indivisible_flag,-1) and
  decode(iacl.inventory_asset_flag,1,nvl(msim.inventory_asset_flag,-1),nvl(msi.inventory_asset_flag,-1))=nvl(msi.inventory_asset_flag,-1) and
  decode(iacl.primary_unit_of_measure,1,nvl(msim.primary_unit_of_measure,-1),nvl(msi.primary_unit_of_measure,-1))=nvl(msi.primary_unit_of_measure,-1) and
  decode(iacl.process_supply_locator_id,1,nvl(msim.process_supply_locator_id,-1),nvl(msi.process_supply_locator_id,-1))=nvl(msi.process_supply_locator_id,-1) and
  decode(iacl.process_supply_subinventory,1,nvl(msim.process_supply_subinventory,-1),nvl(msi.process_supply_subinventory,-1))=nvl(msi.process_supply_subinventory,-1) and
  decode(iacl.process_yield_locator_id,1,nvl(msim.process_yield_locator_id,-1),nvl(msi.process_yield_locator_id,-1))=nvl(msi.process_yield_locator_id,-1) and
  decode(iacl.process_yield_subinventory,1,nvl(msim.process_yield_subinventory,-1),nvl(msi.process_yield_subinventory,-1))=nvl(msi.process_yield_subinventory,-1) and
  decode(iacl.serial_tagging_flag,1,nvl(msim.serial_tagging_flag,-1),nvl(msi.serial_tagging_flag,-1))=nvl(msi.serial_tagging_flag,-1) and
  decode(iacl.service_item_flag,1,nvl(msim.service_item_flag,-1),nvl(msi.service_item_flag,-1))=nvl(msi.service_item_flag,-1) and
  decode(iacl.usage_item_flag,1,nvl(msim.usage_item_flag,-1),nvl(msi.usage_item_flag,-1))=nvl(msi.usage_item_flag,-1) and
  decode(iacl.vendor_warranty_flag,1,nvl(msim.vendor_warranty_flag,-1),nvl(msi.vendor_warranty_flag,-1))=nvl(msi.vendor_warranty_flag,-1) and
  decode(iacl.web_status,1,nvl(msim.web_status,-1),nvl(msi.web_status,-1))=nvl(msi.web_status,-1)
)
--
--
)