/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Exploded BOM List
-- Description: Exploded Bill of Material List
-- Excel Examle Output: https://www.enginatics.com/example/bom-exploded-bom-list/
-- Library Link: https://www.enginatics.com/reports/bom-exploded-bom-list/
-- Run Report: https://demo.enginatics.com/

SELECT mtlsi_model.segment1  MODEL                        
,      mtlsi.segment1    BOM_LIST                              
,      mtlsi.description
,      bome.item_num  
,      decode(bome.bom_item_type, 1, 'MODEL',
                              2, 'OPTION CLASS',
                              3, 'NA',
                              4, 'OPTION') BOM_ITEM_TYPE   
,      mtlsi.inventory_item_status_code
,      bome.primary_unit_of_measure
,      bome.component_quantity
,      bome.ATP_flag
,      bome.shippable_item_flag
,      bome.internal_order_flag
,      bome.explosion_type
,      bome.effectivity_date
FROM   apps.mtl_system_items_b     mtlsi_model
,      apps.bom_bill_of_materials  bombom
,      apps.bom_explosions         bome
,      apps.mtl_system_items_b     mtlsi
,      apps.mtl_parameters         mtlp
WHERE  1=1
  AND  mtlsi_model.inventory_item_id = bombom.assembly_item_id
  AND  bombom.bill_sequence_id = bome.top_bill_sequence_id
  AND  bome.component_item_id = mtlsi.inventory_item_id
  AND  mtlsi_model.organization_id = mtlsi.organization_id
  AND  mtlsi.organization_id = bome.organization_id
  AND  bome.organization_id = mtlp.organization_id
  AND  trunc(SYSDATE) BETWEEN nvl(bome.effectivity_date, trunc(SYSDATE)) AND nvl(bome.disable_date, trunc(SYSDATE))
  AND  mtlsi_model.bom_item_type = 1
--  AND  mtlp.organization_code = 'M1'
-- AND  mtlsi_model.segment1 = '&model_number'
ORDER
   BY  bome.top_bill_sequence_id
,      bome.sort_order
,      bome.item_num