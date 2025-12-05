/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Item Average Cost Upload
-- Description: CST Item Average Cost Upload
============================

This upload supports the uploading of item average costs for organizations using the Average Costing Method.

The upload delivers equivalent functionality to the Average Cost Update form in Oracle EBS 
(At this time the upload does not support value change quantity adjustments). 

Upload Mode:
Use the “Create” upload mode to generate an empty excel into which you can paste the average cost updates to be uploaded.
Use the “Create, Update” upload mode if you wish to download the current average costs for a specified set of items into the excel for updating. Additional entries (rows) can also be created in the generated excel.  

Upload Type:
The upload supports updating average costs at the (summary) item level or at the (detailed) elemental cost level. This is determined by the Upload Type report parameter.

If updating the average cost at the item level, any change made to the item average cost is spread to all cost elements and levels in the same proportion as existed prior to the update.

If updating the average cost at the elemental cost level, you only need to adjust and upload the specific cost elements/levels that require a change. It is not necessary to upload the average costs for all cost elements/levels for the item. The upload will only adjust the costs for the cost elements/levels uploaded and leave the others unchanged. The total item average cost will be updated based on the total of the item’s elemental costs.

For uploads at the item cost level, the Cost Element Level Type (This, Previous) and the Cost Element columns must be left blank.
For uploads at the elemental cost level, the Cost Element Level Type (This, Previous) and the Cost Element columns must be populated in the upload excel.

To adjust the average price for an item or cost element you must enter one and one only of either of the following columns 
- New Average Cost: the average cost of the item or cost element will be set to this value. It must be a positive value
- Percentage Change: the average cost of the item or cost element will be changed by this +/- percentage
- Value Change: the +/- amount by which the onhand inventory value should be changed. The average cost will be calculated based on the dividing the new inventory value by the quantity onhand. You can only perform a value change for items with onhand quantity.

Default Adjustment Account
The default adjustment account is used for the inventory revaluations. You can override the default adjustment account for each cost element within the upload excel if required. Otherwise leave the adjustment accounts in the upload excel blank, or you can remove them from the report template so they do not show. 

Informational Columns.
The upload excel by default contains some information columns. If you do not require these columns they can be removed from the template being used so they do not show.

The following columns are informational only
- Description: the item description
- Item Average Cost: the item’s current average cost
- Valued Quantity: the quantity on hand 
- Old Average Cost: the item or cost element/level current average cost
- Old Valuation: the current valuation of inventory onhand for the item or cost element/level
- Adjusted Average Cost: the item or cost element/level new average cost based
- Adjusted Valuation: the new valuation of inventory onhand for the item or cost element/level
- Valuation Change: the change in inventory valuation for the item or cost element/level

-- Excel Examle Output: https://www.enginatics.com/example/cst-item-average-cost-upload/
-- Library Link: https://www.enginatics.com/reports/cst-item-average-cost-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
:p_upload_type upload_type,
to_number(null) source_line_id,
to_number(null) source_header_id,
:p_trx_type transaction_type,
:p_trx_source source,
x.*
from
(
select
mp.organization_code organization,
msiv.concatenated_segments item,
ccg.cost_group cost_group,
:p_trx_date transaction_date,
msiv.description description,
cql.item_cost item_average_cost,
--
clcdv.level_type_dsp cost_element_level,
clcdv.cost_element,
--
to_number(null) new_average_cost,
to_number(null) percentage_change,
to_number(null) value_change,
--
cql.layer_quantity valued_quantity,
decode(:p_upload_type,'D',clcdv.item_cost,cql.item_cost) old_average_cost,
round(cql.layer_quantity * decode(:p_upload_type,'D',clcdv.item_cost,cql.item_cost),2) old_valuation,
--
to_number(null) adjusted_average_cost,
to_number(null) adjusted_valuation,
to_number(null) valuation_change,
--
null material_adj_account,
null material_overhead_adj_account,
null resource_adj_account,
null outside_processing_adj_account,
null overhead_adj_account,
:p_default_adj_account default_adj_account,
--
null reason,
null reference,
--
clcdv.cost_element_id,
clcdv.level_type,
0 upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
cst_quantity_layers cql,
cst_layer_cost_details_v clcdv,
cst_cost_groups ccg
where
mp.organization_id = msiv.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.primary_cost_method = 2 and
msiv.organization_id = cql.organization_id and
msiv.inventory_item_id = cql.inventory_item_id and
msiv.inventory_item_flag = 'Y' and
msiv.inventory_asset_flag = 'Y' and
msiv.costing_enabled_flag = 'Y' and
decode(:p_upload_type,'D',cql.layer_id,null) = clcdv.layer_id(+) and
(:p_upload_type = 'S' or clcdv.cost_element_id is not null) and
cql.cost_group_id = ccg.cost_group_id and
(
 (ccg.cost_group_id = mp.default_cost_group_id) or
 ( nvl(ccg.cost_group_type,1) in (1,3) and
   exists
   (select
    'EXISTS'
    from
    cst_cost_group_accounts ccga
    where
    ccga.cost_group_id = ccg.cost_group_id and
    ccga.organization_id = mp.organization_id
   )
 )
) and
1=1
union
-- for new items with no costing layers take from the cst_item_costs/cst_item_cost_details
select
mp.organization_code organization,
msiv.concatenated_segments item,
ccg.cost_group cost_group,
:p_trx_date transaction_date,
msiv.description description,
cic.item_cost item_average_cost,
--
cicdv.level_type_dsp cost_element_level,
cicdv.cost_element,
--
to_number(null) new_average_cost,
to_number(null) percentage_change,
to_number(null) value_change,
--
0 valued_quantity,
decode(:p_upload_type,'D',cicdv.item_cost,cic.item_cost) old_average_cost,
0 old_valuation,
--
to_number(null) adjusted_average_cost,
to_number(null) adjusted_valuation,
to_number(null) valuation_change,
--
null material_adj_account,
null material_overhead_adj_account,
null resource_adj_account,
null outside_processing_adj_account,
null overhead_adj_account,
null default_adj_account,
--
null reason,
null reference,
--
cicdv.cost_element_id,
cicdv.level_type,
0 upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
cst_item_costs cic,
cst_item_cost_details_v cicdv,
cst_cost_groups ccg
where
mp.organization_id = msiv.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.primary_cost_method = 2 and
msiv.organization_id = cic.organization_id and
msiv.inventory_item_id = cic.inventory_item_id and
msiv.inventory_item_flag = 'Y' and
msiv.inventory_asset_flag = 'Y' and
msiv.costing_enabled_flag = 'Y' and
not exists (select null from cst_quantity_layers cql where cql.organization_id = msiv.organization_id and cql.inventory_item_id = msiv.inventory_item_id) and
mp.primary_cost_method = cic.cost_type_id and
decode(:p_upload_type,'D',cic.organization_id,null) = cicdv.organization_id(+) and
decode(:p_upload_type,'D',cic.inventory_item_id,null) = cicdv.inventory_item_id(+) and
decode(:p_upload_type,'D',cic.cost_type_id,null) = cicdv.cost_type_id(+) and
(:p_upload_type = 'S' or cicdv.cost_element_id is not null) and
mp.default_cost_group_id = ccg.cost_group_id and
1=1
) x