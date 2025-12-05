/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Upload
-- Description: INV Inventory Item Upload
======================
This upload can be used to create and update Inventory Items.

It supports creation of Inventory Items:
- by manually entering the Item details.
- from the same item in the Master Organization (equivalent to Assigning the item to a child organization)
- from an item template (Copy from Template)
- from an existing item in the same Organization (Copy from Item)

It supports update of existing Inventory Items either by:
- update the details of an existing inventory items by downloading the items to be updated. Use the report parameters to select and download the items to be updated.
- pasting the details of the items to be updated into an empty upload excel.

It also supports the item category assignment to multiple Inventory Category Sets
-  to assign an item to another category set, repeat the Organization Code and Item Number on a separate row in the excel and add the details of the additional category set and item category to which the item is to be assigned.
- for child organizations, only the category sets controlled at the organization level can be selected.   

Upload Mode parameter:
Create - allows creation of new items only
Update - allows updates to existing items only
Create, Update – allows the creation of new items and the updating of existing items

Create Empty File parameter
Setting the Create Empty File parameter to Yes will open an empty upload excel. 
This parameter is only applicable to the 'Update' and 'Create, Update' upload modes and suppresses the download of existing item details. ‘Create’ upload mode always opens an empty upload excel regardless of the setting of this parameter.
This is useful for users who want to paste the details of the items to be updated into an empty upload excel file from another source.

Number of Import Workers parameter
This parameter determines the number of Item Import worker concurrent requests that will be submitted in parallel to import the uploaded items into Oracle Inventory. The number of workers can be increased to improve the throughput of the process when uploading a larger number of item changes.
Remaining parameters
The remaining parameters are used to restrict the items to be downloaded for update in ‘Update’ or ‘Create, Update’ mode, and only when the ‘Create Empty File’ parameter is not set to Yes.  
 
Available Templates
Use the pre-defined templates to restrict the Item Attributes to be displayed and updated in the report. Alternatively, users can define their own custom template containing the Item Attributes of interest.

NOTE:
When creating new child items, the master-controlled item attributes are not passed to the Import API so they are defaulted from the Master Org. 
When updating existing child items, the master-controlled item attributes are copied directly from the Master Org, in case there is any pre-existing inconsistency between the Child Org and Master Org values. 
Effectively this means, for creation/updates to items in child organizations, the uploaded values for Master Controlled Item attributes are not considered by upload.

-- Excel Examle Output: https://www.enginatics.com/example/inv-item-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-upload/
-- Run Report: https://demo.enginatics.com/

select /*+ push_pred(mic) */
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
null item_row_id,
null item_cat_row_id,
null set_process_id,
--
to_number(null) number_of_import_workers,
--
msiv.concatenated_segments item,
mp.organization_code,
null copy_from_template,
null copy_from_item,
-- Category Assignment
mic.category_set_name category_set,
mic.category item_category,
-- Catalog Assignment
(select micgbk.concatenated_segments from mtl_item_catalog_groups_b_kfv micgbk where micgbk.item_catalog_group_id = msiv.item_catalog_group_id) item_catalog,
-- Main
msiv.description description,
msiv.long_description long_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
(select mis.inventory_item_status_code_tl from mtl_item_status mis where mis.inventory_item_status_code = msiv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.allowed_units_lookup_code,'MTL_CONVERSION_TYPE',700) conversions,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.primary_uom_code and language = userenv('lang') and rownum <= 1) primary_unit_of_measure,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.secondary_uom_code and language = userenv('lang') and rownum <= 1) secondary_unit_of_measure,
xxen_util.meaning(msiv.tracking_quantity_ind,'INV_TRACKING_UOM_TYPE',0) tracking_uom_indicator,
xxen_util.meaning(msiv.ont_pricing_qty_source,'INV_PRICING_UOM_TYPE',0) pricing_uom_indicator,
xxen_util.meaning(msiv.secondary_default_ind,'INV_DEFAULTING_UOM_TYPE',0) defaulting_control,
msiv.dual_uom_deviation_high deviation_factor_plus,
msiv.dual_uom_deviation_low deviation_factor_minus,
-- Inventory
xxen_util.meaning(msiv.inventory_item_flag,'YES_NO',0) inventory_item,
xxen_util.meaning(msiv.stock_enabled_flag,'YES_NO',0) stockable,
xxen_util.meaning(msiv.mtl_transactions_enabled_flag,'YES_NO',0) transactable,
xxen_util.meaning(msiv.revision_qty_control_code,'MTL_ENG_QUANTITY',700) revision_control,
xxen_util.meaning(msiv.reservable_type,'MTL_RESERVATION_CONTROL',700) reservable,
xxen_util.meaning(msiv.check_shortages_flag,'YES_NO',0) check_material_shortage,
xxen_util.meaning(msiv.location_control_code,'MTL_LOCATION_CONTROL',700) locator_control,
xxen_util.meaning(msiv.restrict_subinventories_code,'MTL_SUBINVENTORY_RESTRICTIONS',700) restrict_subinventories,
xxen_util.meaning(msiv.restrict_locators_code,'MTL_LOCATOR_RESTRICTIONS',700) restrict_locators,
-----Serial
xxen_util.meaning(msiv.serial_number_control_code,'MTL_SERIAL_NUMBER',700) serial_number_generation,
msiv.start_auto_serial_number starting_serial_number,
msiv.auto_serial_alpha_prefix starting_serial_prefix,
------Lot
xxen_util.meaning(msiv.lot_control_code,'MTL_LOT_CONTROL',700) lot_control,
msiv.start_auto_lot_number starting_lot_number,
msiv.auto_lot_alpha_prefix starting_lot_prefix,
----Lot Expiration
xxen_util.meaning(msiv.shelf_life_code,'MTL_SHELF_LIFE',700) lot_expiration,
msiv.shelf_life_days shelf_life_days,
msiv.retest_interval retest_interval,
msiv.expiration_action_interval expiration_action_interval,
(select ma.description from mtl_actions ma where ma.action_code = msiv.expiration_action_code) expiration_action,
----Cycle Count
xxen_util.meaning(msiv.cycle_count_enabled_flag,'YES_NO',0) cycle_count_enabled,
msiv.negative_measurement_error negative_measurement_error,
msiv.positive_measurement_error positive_measurement_error,
----Grade Controlled
xxen_util.meaning(msiv.grade_control_flag,'YES_NO',0) grade_controlled,
(select mg.description from mtl_grades mg where mg.grade_code = msiv.default_grade) default_grade,
----Not Visible in Form
xxen_util.meaning(msiv.lot_status_enabled,'YES_NO',0) lot_status_enabled,
(select mms.status_code from mtl_material_statuses mms where mms.status_id = msiv.default_lot_status_id) default_lot_status,
xxen_util.meaning(msiv.serial_status_enabled,'YES_NO',0) serial_status_enabled,
(select mms.status_code from mtl_material_statuses mms where mms.status_id = msiv.default_serial_status_id) default_serial_status,
xxen_util.meaning(msiv.lot_split_enabled,'YES_NO',0) lot_split_enabled,
xxen_util.meaning(msiv.lot_merge_enabled,'YES_NO',0) lot_merge_enabled,
xxen_util.meaning(msiv.lot_translate_enabled,'YES_NO',0) lot_translate_enabled,
xxen_util.meaning(msiv.lot_substitution_enabled,'YES_NO',0) lot_substitution_enabled,
xxen_util.meaning(msiv.bulk_picked_flag,'YES_NO',0) bulk_picked,
xxen_util.meaning(msiv.lot_divisible_flag,'YES_NO',0) lot_divisible,
xxen_util.meaning(msiv.child_lot_flag,'YES_NO',0) child_lot_enabled,
xxen_util.meaning(msiv.parent_child_generation_flag,'INV_PARENT_CHILD_GENERATION',0) child_lot_generation,
msiv.child_lot_prefix child_lot_prefix,
msiv.child_lot_starting_number child_lot_starting_number,
xxen_util.meaning(msiv.child_lot_validation_flag,'YES_NO',0) child_lot_format_validation,
msiv.maturity_days maturity_days,
msiv.hold_days hold_days,
xxen_util.meaning(msiv.copy_lot_attribute_flag,'YES_NO',0) copy_lot_attributes,
--msiv.mcc_classification_type material_classification_type,
--Bills of Material
xxen_util.meaning(msiv.bom_enabled_flag,'YES_NO',0) bom_allowed,
xxen_util.meaning(msiv.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id = msiv.organization_id and msiv2.inventory_item_id = msiv.base_item_id) base_model,
xxen_util.meaning(msiv.auto_created_config_flag,'YES_NO',0) autocreated_configuration,
xxen_util.meaning(msiv.effectivity_control,'BOM_EFFECTIVITY_CONTROL',700) effectivity_control,
xxen_util.meaning(msiv.config_model_type,'CZ_CONFIG_MODEL_TYPE',708) configurator_model_type,
xxen_util.meaning(msiv.config_orgs,'INV_CONFIG_ORGS_TYPE',0) create_configured_item_bom,
xxen_util.meaning(msiv.config_match,'INV_CONFIG_MATCH_TYPE',0) match_configuration,
----Not Visible in Form
xxen_util.meaning(msiv.eng_item_flag,'YES_NO',0) engineering_item,
-- Costing
xxen_util.meaning(msiv.costing_enabled_flag,'YES_NO',0) costing_enabled,
xxen_util.meaning(msiv.inventory_asset_flag,'YES_NO',0) inventory_asset_value,
xxen_util.meaning(msiv.default_include_in_rollup_flag,'YES_NO',0) include_in_rollup,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = msiv.cost_of_sales_account) cost_of_goods_sold_account,
msiv.std_lot_size standard_lot_size,
-- Asset Management
xxen_util.meaning(msiv.eam_item_type,'MTL_EAM_ITEM_TYPE',700) asset_item_type,
xxen_util.meaning(msiv.eam_activity_type_code,'MTL_EAM_ACTIVITY_TYPE',700) asset_activity_type,
xxen_util.meaning(msiv.eam_activity_cause_code,'MTL_EAM_ACTIVITY_CAUSE' ,700) asset_activity_cause,
xxen_util.meaning(msiv.eam_activity_source_code,'MTL_EAM_ACTIVITY_SOURCE',700) asset_activity_source,
xxen_util.meaning(msiv.eam_act_shutdown_status, 'BOM_EAM_SHUTDOWN_TYPE',700) asset_shutdown_type,
xxen_util.meaning(msiv.eam_act_notification_flag,'YES_NO',0) asset_notification_required,
-- Purchasing
xxen_util.meaning(msiv.purchasing_item_flag,'YES_NO',0) purchased,
xxen_util.meaning(msiv.purchasing_enabled_flag,'YES_NO',0) purchasable,
xxen_util.meaning(msiv.must_use_approved_vendor_flag,'YES_NO',0) use_approved_supplier,
xxen_util.meaning(msiv.allow_item_desc_update_flag,'YES_NO',0) allow_description_update,
xxen_util.meaning(msiv.outsourced_assembly,'SYS_YES_NO',700) outsourced_assembly,
xxen_util.meaning(msiv.outside_operation_flag,'YES_NO',0) outside_processing_item,
xxen_util.meaning(msiv.outside_operation_uom_type,'OUTSIDE OPERATION UOM TYPE',201) outside_processing_unit_type,
xxen_util.meaning(msiv.rfq_required_flag,'YES_NO',0) rfq_required,
xxen_util.meaning(msiv.taxable_flag,'YES_NO',0) taxable,
xxen_util.meaning(msiv.purchasing_tax_code,'ZX_INPUT_CLASSIFICATIONS',0) input_tax_classification_code,
xxen_util.meaning(msiv.receipt_required_flag,'YES_NO',0) receipt_required,
xxen_util.meaning(msiv.inspection_required_flag,'YES_NO',0) inspection_required,
(select ppx.full_name from per_people_x ppx where ppx.person_id = msiv.buyer_id) default_buyer,
msiv.list_price_per_unit list_price,
msiv.market_price market_price,
msiv.price_tolerance_percent price_tolerance_pct,
msiv.receive_close_tolerance receipt_close_tolerance,
msiv.invoice_close_tolerance invoice_close_tolerance,
msiv.rounding_factor rounding_factor,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.unit_of_measure = msiv.unit_of_issue and language = userenv('lang') and rownum <= 1) unit_of_issue,
(select pun.un_number from po_un_numbers pun where pun.un_number_id = msiv.un_number_id) un_number,
(select phc.hazard_class from po_hazard_classes phc where phc.hazard_class_id = msiv.hazard_class_id) hazard_class,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = msiv.encumbrance_account) encumbrance_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = msiv.expense_account) expense_account,
(select fcbk.concatenated_segments from fa_categories_b_kfv fcbk where fcbk.category_id = msiv.asset_category_id) asset_category,
-- Receiving
xxen_util.meaning(msiv.receipt_days_exception_code,'RECEIVING CONTROL LEVEL',201) receipt_date_action,
msiv.days_early_receipt_allowed days_early_receipt_allowed,
msiv.days_late_receipt_allowed days_late_receipt_allowed,
xxen_util.meaning(msiv.allow_substitute_receipts_flag,'YES_NO',0) allow_substitute_receipts,
xxen_util.meaning(msiv.allow_unordered_receipts_flag,'YES_NO',0) allow_unordered_receipts,
xxen_util.meaning(msiv.allow_express_delivery_flag,'YES_NO',0) allow_express_transactions,
xxen_util.meaning(msiv.qty_rcv_exception_code,'RCV OPTION',201) over_receipt_qty_action,
msiv.qty_rcv_tolerance over_receipt_qty_tolerance,
(select rrh.routing_name from rcv_routing_headers rrh where rrh.routing_header_id = msiv.receiving_routing_id) receipt_routing,
xxen_util.meaning(msiv.enforce_ship_to_location_code,'RECEIVING CONTROL LEVEL',201) enforce_ship_to,
-- Physical Attributes
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.weight_uom_code and language = userenv('lang') and rownum <= 1) weight_unit_of_measure,
msiv.unit_weight unit_weight,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.volume_uom_code and language = userenv('lang') and rownum <= 1) volume_unit_of_measure,
msiv.unit_volume unit_volume,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.dimension_uom_code and language = userenv('lang') and rownum <= 1) dimension_unit_of_measure,
msiv.unit_length length,
msiv.unit_width width,
msiv.unit_height height,
xxen_util.meaning(msiv.container_item_flag,'YES_NO',0) container,
xxen_util.meaning(msiv.vehicle_item_flag,'YES_NO',0) vehicle,
xxen_util.meaning(msiv.container_type_code,'CONTAINER_TYPE',3) container_type,
msiv.internal_volume internal_volume,
msiv.maximum_load_weight maximum_load_weight,
msiv.minimum_fill_percent minimum_fill_percentage,
xxen_util.meaning(msiv.collateral_flag,'YES_NO',0) collateral_item,
xxen_util.meaning(msiv.event_flag,'YES_NO',0) event,
xxen_util.meaning(msiv.equipment_type,'SYS_YES_NO',700) equipment,
xxen_util.meaning(msiv.electronic_flag,'YES_NO',0) electronic_format,
xxen_util.meaning(msiv.downloadable_flag,'YES_NO',0) downloadable,
xxen_util.meaning(msiv.indivisible_flag,'YES_NO',0) om_indivisible,
-- General Planning
xxen_util.meaning(msiv.inventory_planning_code,'MTL_MATERIAL_PLANNING',700) inventory_planning_method,
msiv.planner_code planner,
xxen_util.meaning(msiv.subcontracting_component,'INV_SUBCONTRACTING_COMPONENT',700) subcontracting_component,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
msiv.min_minmax_quantity min_max_minimum_quantity,
msiv.max_minmax_quantity min_max_maximum_quantity,
msiv.minimum_order_quantity minimum_order_quantity,
msiv.maximum_order_quantity maximum_order_quantity,
msiv.order_cost order_cost,
msiv.carrying_cost carrying_cost_percent,
xxen_util.meaning(msiv.source_type,'MTL_SOURCE_TYPES',700) source_type,
(select mp2.organization_code from mtl_parameters mp2 where mp2.organization_id = msiv.source_organization_id) source_organization,
msiv.source_subinventory source_subinventory,
xxen_util.meaning(msiv.mrp_safety_stock_code,'MTL_SAFETY_STOCK_TYPE',700) safety_stock,
msiv.safety_stock_bucket_days safety_stock_bucket_days,
msiv.mrp_safety_stock_percent safety_stock_percent,
msiv.fixed_order_quantity fixed_order_quantity,
msiv.fixed_days_supply fixed_days_supply,
msiv.fixed_lot_multiplier fixed_lot_size_multiplier,
--
msiv.vmi_minimum_units vmi_minimum_quantity,
msiv.vmi_minimum_days vmi_minimum_days_of_supply,
msiv.vmi_maximum_units vmi_maximum_quantity,
msiv.vmi_maximum_days vmi_maximum_days_of_supply,
msiv.vmi_fixed_order_quantity vmi_fixed_quantity,
xxen_util.meaning(msiv.so_authorization_flag,'MTL_MSI_GP_RELEASE_AUTH',700) vmi_release_auth_required,
xxen_util.meaning(msiv.consigned_flag,'SYS_YES_NO',700) vmi_consigned,
xxen_util.meaning(msiv.asn_autoexpire_flag,'SYS_YES_NO',700) vmi_auto_expire_asn,
xxen_util.meaning(msiv.vmi_forecast_type,'MTL_MSI_GP_FORECAST_TYPE',700) vmi_forecast_type,
msiv.forecast_horizon vmi_forecaset_window_days,
-- MPS/MRP Planning
xxen_util.meaning(msiv.mrp_planning_code,'MRP_PLANNING_CODE',700) mrp_planning_method,
xxen_util.meaning(msiv.ato_forecast_control,'MRP_ATO_FORECAST_CONTROL',700) forecast_control,
xxen_util.meaning(msiv.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) end_assembly_pegging,
msiv.planning_exception_set planning_exception_set,
msiv.shrinkage_rate shrinkage_rate,
msiv.acceptable_early_days acceptable_early_days,
--
xxen_util.meaning(msiv.rounding_control_type,'MTL_ROUNDING',700) round_order_quantities,
xxen_util.meaning(msiv.planned_inv_point_flag,'YES_NO',0) planned_inventory_point,
xxen_util.meaning(msiv.create_supply_flag,'YES_NO',0) create_supply,
xxen_util.meaning(msiv.exclude_from_budget_flag,'SYS_YES_NO',700) exclude_from_budget,
xxen_util.meaning(msiv.critical_component_flag,'SYS_YES_NO',700) critical_component,
--
xxen_util.meaning(msiv.mrp_calculate_atp_flag,'YES_NO',0) calculate_atp,
xxen_util.meaning(msiv.auto_reduce_mps,'MRP_AUTO_REDUCE_MPS',700) reduce_mps,
--
xxen_util.meaning(msiv.repetitive_planning_flag,'YES_NO',0) repetitive_planning,
msiv.overrun_percentage overrun_percentage,
msiv.acceptable_rate_decrease acceptable_rate_minus,
msiv.acceptable_rate_increase acceptable_rate_plus,
--
xxen_util.meaning(msiv.planning_time_fence_code,'MTL_TIME_FENCE',700) planning_time_fence,
msiv.planning_time_fence_days planning_time_fence_days,
xxen_util.meaning(msiv.demand_time_fence_code,'MTL_TIME_FENCE',700) demand_time_fence,
msiv.demand_time_fence_days demand_time_fence_days,
xxen_util.meaning(msiv.release_time_fence_code,'MTL_RELEASE_TIME_FENCE',700) release_time_fence,
msiv.release_time_fence_days release_time_fence_days,
xxen_util.meaning(msiv.substitution_window_code, 'MTL_TIME_FENCE',700) substitution_window,
msiv.substitution_window_days substitution_window_days,
--
xxen_util.meaning(msiv.continous_transfer,'MTL_MSI_MRP_INT_ORG',700) continuous_inter_org_transfers,
xxen_util.meaning(msiv.convergence,'MTL_MSI_MRP_CONV_SUPP',700) convergence_pattern,
xxen_util.meaning(msiv.divergence,'MTL_MSI_MRP_DIV_SUPP',700) divergence_pattern,
--
xxen_util.meaning(msiv.drp_planned_flag,'SYS_YES_NO',700) drp_planned,
msiv.days_max_inv_supply drp_max_inv_days_supply,
msiv.days_max_inv_window drp_max_inv_window,
msiv.days_tgt_inv_supply drp_target_inv_days_supply,
msiv.days_tgt_inv_window drp_target_inv_window,
--
xxen_util.meaning(msiv.repair_program,'INV_REPAIR_PROGRAM',700) repair_program,
msiv.repair_leadtime repair_lead_time,
msiv.repair_yield repair_yield,
xxen_util.meaning(msiv.preposition_point,'YES_NO',0) repair_preposition_point,
-- Lead Times
msiv.preprocessing_lead_time preprocessing_lead_time,
msiv.full_lead_time processing_lead_time,
msiv.postprocessing_lead_time postprocessing_lead_time,
msiv.fixed_lead_time fixed_lead_time,
msiv.variable_lead_time variable_lead_time,
msiv.cum_manufacturing_lead_time cum_manufacturing_lead_time,
msiv.cumulative_total_lead_time cumulative_total_lead_time,
msiv.lead_time_lot_size lead_time_lot_size,
-- Work In Process
xxen_util.meaning(msiv.build_in_wip_flag,'YES_NO',0) build_in_wip,
xxen_util.meaning(msiv.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
msiv.wip_supply_subinventory wip_supply_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id = msiv.wip_supply_locator_id) wip_supply_locator,
xxen_util.meaning(msiv.overcompletion_tolerance_type,'WIP_TOLERANCE_TYPE',700) overcompletion_tolerance_type,
msiv.overcompletion_tolerance_value overcompletion_tolerance_value,
msiv.inventory_carry_penalty inventory_carry_penalty,
msiv.operation_slack_penalty operation_slack_penalty,
-- Order Management
xxen_util.meaning(msiv.customer_order_flag,'YES_NO',0) customer_ordered,
xxen_util.meaning(msiv.customer_order_enabled_flag,'YES_NO',0) customer_orders_enabled,
xxen_util.meaning(msiv.internal_order_flag,'YES_NO',0) internal_ordered,
xxen_util.meaning(msiv.internal_order_enabled_flag,'YES_NO',0) internal_orders_enabled,
xxen_util.meaning(msiv.shippable_item_flag,'YES_NO',0) shippable,
xxen_util.meaning(msiv.so_transactions_flag,'YES_NO',0) oe_transactable,
xxen_util.meaning(msiv.pick_components_flag,'YES_NO',0) pick_components,
xxen_util.meaning(msiv.replenish_to_order_flag,'YES_NO',0) assemble_to_order,
xxen_util.meaning(msiv.ship_model_complete_flag,'YES_NO',0) ship_model_complete,
xxen_util.meaning(msiv.returnable_flag,'YES_NO',0) returnable,
xxen_util.meaning(msiv.return_inspection_requirement,'MTL_RETURN_INSPECTION',700) rma_inspection_required,
xxen_util.meaning(msiv.financing_allowed_flag,'YES_NO',0) financing_allowed,
--
xxen_util.meaning(msiv.atp_flag,'ATP_FLAG',3) check_atp,
(select mar.rule_name from mtl_atp_rules mar where mar.rule_id = msiv.atp_rule_id) atp_rule,
xxen_util.meaning(msiv.atp_components_flag,'ATP_FLAG',3) atp_components,
(select wrv.name from wms_rules_vl wrv where wrv.rule_id = msiv.picking_rule_id) picking_rule,
(select mp2.organization_code from mtl_parameters mp2 where mp2.organization_id = msiv.default_shipping_org) default_shipping_organization,
xxen_util.meaning(msiv.default_so_source_type,'SOURCE_TYPE',660) default_so_source_type,
(select fnd.UNIT_OF_MEASURE from MTL_UOM_CONVERSIONS fnd where fnd.UOM_CLASS = '(FND_PROFILE.VALUE(ONT_UOM_CLASS_CHARGE_PERIODICITY))' and fnd.UOM_CODE = msiv.charge_periodicity_code) charge_periodicity,
--
msiv.over_shipment_tolerance over_shipment_tolerance,
msiv.under_shipment_tolerance under_shipment_tolerance,
msiv.over_return_tolerance over_return_tolerance,
msiv.under_return_tolerance under_return_tolerance,
-- Invoicing
xxen_util.meaning(msiv.invoiceable_item_flag,'YES_NO',0) invoiceable_item,
xxen_util.meaning(msiv.invoice_enabled_flag,'YES_NO',0) invoice_enabled,
(select rr.name from ra_rules rr where rr.rule_id = msiv.accounting_rule_id) accounting_rule,
(select rr.name from ra_rules rr where rr.rule_id = msiv.invoicing_rule_id) invoicing_rule,
xxen_util.meaning(msiv.tax_code,'ZX_OUTPUT_CLASSIFICATIONS',0) output_tax_classification_code,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = msiv.sales_account) sales_account,
(select rtv.name from ra_terms_vl rtv where rtv.term_id = msiv.payment_terms_id) payment_terms,
-- Service
xxen_util.meaning(msiv.serv_req_enabled_code,'CS_SR_SERV_REQ_ENABLED_TYPE',170) service_request,
xxen_util.meaning(msiv.serviceable_product_flag,'YES_NO',0) enable_contract_coverage,
xxen_util.meaning(msiv.defect_tracking_on_flag,'YES_NO',0) enable_defect_tracking,
xxen_util.meaning(msiv.comms_activation_reqd_flag,'YES_NO',0) enable_provisioning,
--
xxen_util.meaning(msiv.contract_item_type_code,'OKB_CONTRACT_ITEM_TYPE',0) contract_item_type,
msiv.service_duration contract_duration,
(select muomt.unit_of_measure_tl from mtl_units_of_measure_tl muomt where muomt.uom_code = msiv.service_duration_period_code and language = userenv('lang') and rownum <= 1) contract_duration_period,
(select octv.name from oks_coverage_templts_v octv where octv.id = msiv.coverage_schedule_id) coverage_template,
msiv.service_starting_delay starting_delay_days,
--
xxen_util.meaning(msiv.comms_nl_trackable_flag,'YES_NO',0) track_in_installed_base,
xxen_util.meaning(decode(msiv.asset_creation_code,0,2,msiv.asset_creation_code),'SYS_YES_NO',700) create_fixed_asset,
--msiv.ib_item_tracking_level level_of_ib_tracking,
xxen_util.meaning(msiv.ib_item_instance_class,'CSI_ITEM_CLASS',170) item_instance_class,
--
xxen_util.meaning(msiv.recovered_part_disp_code,'CSP_RECOVERED_PART_DISP_CODE',0) recovered_part_disposition,
xxen_util.meaning(msiv.serv_billing_enabled_flag,'YES_NO',0) enable_service_billing,
xxen_util.meaning(msiv.material_billable_flag,'MTL_SERVICE_BILLABLE_FLAG',170) billing_type,
-- Web Option
xxen_util.meaning(msiv.web_status,'IBE_ITEM_STATUS',0) web_status,
xxen_util.meaning(msiv.orderable_on_web_flag,'YES_NO',0) orderable_on_the_web,
xxen_util.meaning(msiv.back_orderable_flag,'YES_NO',0) back_orderable,
msiv.minimum_license_quantity minimum_license_quantity,
-- Process Manufacturing
xxen_util.meaning(msiv.process_quality_enabled_flag,'YES_NO',0) process_quality_enabled,
xxen_util.meaning(msiv.process_costing_enabled_flag,'YES_NO',0) process_costing_enabled,
xxen_util.meaning(msiv.recipe_enabled_flag,'YES_NO',0) recipe_enabled,
xxen_util.meaning(msiv.process_execution_enabled_flag,'YES_NO',0) process_execution_enabled,
msiv.process_supply_subinventory process_supply_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id = msiv.process_supply_locator_id) process_supply_locator,
msiv.process_yield_subinventory process_yield_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id = msiv.process_yield_locator_id) process_yield_locator,
xxen_util.meaning(msiv.hazardous_material_flag,'YES_NO',0) hazardous_material,
msiv.cas_number cas_number,
-- DFF Attributes
xxen_util.display_flexfield_context(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE1',msiv.row_id,msiv.attribute1) inv_item_attribute1,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE2',msiv.row_id,msiv.attribute2) inv_item_attribute2,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE3',msiv.row_id,msiv.attribute3) inv_item_attribute3,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE4',msiv.row_id,msiv.attribute4) inv_item_attribute4,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE5',msiv.row_id,msiv.attribute5) inv_item_attribute5,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE6',msiv.row_id,msiv.attribute6) inv_item_attribute6,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE7',msiv.row_id,msiv.attribute7) inv_item_attribute7,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE8',msiv.row_id,msiv.attribute8) inv_item_attribute8,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE9',msiv.row_id,msiv.attribute9) inv_item_attribute9,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE10',msiv.row_id,msiv.attribute10) inv_item_attribute10,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE11',msiv.row_id,msiv.attribute11) inv_item_attribute11,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE12',msiv.row_id,msiv.attribute12) inv_item_attribute12,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE13',msiv.row_id,msiv.attribute13) inv_item_attribute13,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE14',msiv.row_id,msiv.attribute14) inv_item_attribute14,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE15',msiv.row_id,msiv.attribute15) inv_item_attribute15,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE16',msiv.row_id,msiv.attribute16) inv_item_attribute16,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE17',msiv.row_id,msiv.attribute17) inv_item_attribute17,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE18',msiv.row_id,msiv.attribute18) inv_item_attribute18,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE19',msiv.row_id,msiv.attribute19) inv_item_attribute19,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE20',msiv.row_id,msiv.attribute20) inv_item_attribute20,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE21',msiv.row_id,msiv.attribute21) inv_item_attribute21,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE22',msiv.row_id,msiv.attribute22) inv_item_attribute22,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE23',msiv.row_id,msiv.attribute23) inv_item_attribute23,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE24',msiv.row_id,msiv.attribute24) inv_item_attribute24,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE25',msiv.row_id,msiv.attribute25) inv_item_attribute25,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE26',msiv.row_id,msiv.attribute26) inv_item_attribute26,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE27',msiv.row_id,msiv.attribute27) inv_item_attribute27,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE28',msiv.row_id,msiv.attribute28) inv_item_attribute28,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE29',msiv.row_id,msiv.attribute29) inv_item_attribute29,
xxen_util.display_flexfield_value(401,'MTL_SYSTEM_ITEMS',msiv.attribute_category,'ATTRIBUTE30',msiv.row_id,msiv.attribute30) inv_item_attribute30,
--
msiv.organization_id,
msiv.inventory_item_id,
to_number(mic.category_set_id) category_set_id,
decode(mp.organization_id,mp.master_organization_id,'Y',null) master_flag,
0 upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
(select
 mic.organization_id,
 mic.inventory_item_id,
 mcs.category_set_name,
 mcs.category_set_id,
 mck.concatenated_segments category
 from
 mtl_item_categories mic,
 mtl_category_sets mcs,
 mtl_categories_kfv mck
 where
 mic.category_set_id = mcs.category_set_id and
 mic.category_id = mck.category_id and
 '&lp_templ_includes_cat_cols' = 'Y' and
 2=2
) mic
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_create_empty_file,'N')  != 'Y' and
nvl(:p_coa_id,-1)=nvl(:p_coa_id,-1) and
nvl(:p_num_import_workers,1) = nvl(:p_num_import_workers,1) and
nvl(:p_purge_after_days,-1) = nvl(:p_purge_after_days,-1) and
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.responsibility_id = fnd_global.resp_id and oav.resp_application_id = fnd_global.resp_appl_id) and
msiv.organization_id = mp.organization_id and
msiv.organization_id = mic.organization_id (+) and
msiv.inventory_item_id = mic.inventory_item_id (+)