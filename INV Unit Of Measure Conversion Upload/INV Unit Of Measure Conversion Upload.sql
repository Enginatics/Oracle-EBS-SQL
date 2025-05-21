/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Unit Of Measure Conversion Upload
-- Description: INV Unit Of Measure Conversion Upload
=============================
In R12.2 and later:
This upload enables the user to 
- upload new unit of measure conversions
- update existing unit of measure conversions. 

The upload supports the following unit of measure conversion types:
- Standard, Intra-Class and Inter-Class, Lot Specific Inter-class

In R12.1:
The functionality is restricted to creating new Item specific Intra-Class and Inter-Class conversions only.
Update of existing unit of measure conversions is not supported in R12.1
Creation of Standard and Lot specific unit of measure conversions is not supported in R12.1

-- Excel Examle Output: https://www.enginatics.com/example/inv-unit-of-measure-conversion-upload/
-- Library Link: https://www.enginatics.com/reports/inv-unit-of-measure-conversion-upload/
-- Run Report: https://demo.enginatics.com/

with uom_conv_qry as
(
--
-- standard and intra-class
--
select
decode(muc.inventory_item_id,0,'Standard','Intra-class') conversion_type,
--
msiv.concatenated_segments   item,
msiv.description             item_description,
null                         lot_number,
--
muomvf.unit_of_measure_tl    from_uom,
mucv.uom_class_tl            from_uom_class,
muc.conversion_rate          uom_conversion_rate,
muomvt.unit_of_measure_tl    to_uom,
mucv.uom_class_tl            to_uom_class,
muc.disable_date             inactive_date,
--
'1 ' || muomvt.unit_of_measure_tl || ' = ' || muc.conversion_rate || ' x ' || muomvf.unit_of_measure_tl conversion_text,
--
muc.last_update_date,
muc.last_updated_by
from
mtl_uom_conversions muc,
mtl_units_of_measure_vl muomvf,
mtl_units_of_measure_vl muomvt,
mtl_uom_classes_vl mucv,
mtl_system_items_vl msiv,
mtl_parameters mp
where
muc.uom_class          = muomvf.uom_class and
muomvf.base_uom_flag   = 'Y' and
muc.uom_class          = muomvt.uom_class and
muc.uom_code           = muomvt.uom_code and
muomvt.base_uom_flag  != 'Y' and
muc.uom_class          = mucv.uom_class and
muc.inventory_item_id  = msiv.inventory_item_id (+) and
msiv.organization_id   = mp.organization_id (+) and
(muc.inventory_item_id = 0 or
 mp.organization_id    = mp.master_organization_id
)
union all
--
-- inter-class
--
select
--
'Inter-class'                conversion_type,
--
msiv.concatenated_segments   item,
msiv.description             item_description,
null                         lot_number,
--
muomvf.unit_of_measure_tl    from_uom,
mucvf.uom_class_tl           from_uom_class,
mucc.conversion_rate         uom_conversion_rate,
muomvt.unit_of_measure_tl    to_uom,
mucvt.uom_class_tl           to_uom_class,
mucc.disable_date            inactive_date,
--
'1 ' || muomvt.unit_of_measure_tl || ' = ' || mucc.conversion_rate || ' x ' || muomvf.unit_of_measure_tl conversion_text,
--
mucc.last_update_date,
mucc.last_updated_by
from
mtl_uom_class_conversions mucc,
mtl_units_of_measure_vl   muomvf,
mtl_units_of_measure_vl   muomvt,
mtl_uom_classes_vl        mucvf,
mtl_uom_classes_vl        mucvt,
mtl_system_items_vl       msiv,
mtl_parameters            mp
where
mucc.from_uom_class    = muomvf.uom_class and
mucc.from_uom_code     = muomvf.uom_code and
mucc.to_uom_class      = muomvt.uom_class and
mucc.to_uom_code       = muomvt.uom_code and
mucc.from_uom_class    = mucvf.uom_class and
mucc.to_uom_class      = mucvt.uom_class and
mucc.inventory_item_id = msiv.inventory_item_id and
msiv.organization_id   = mp.organization_id and
mp.organization_id     = mp.master_organization_id
union all
--
-- lot inter-class
--
select
--
'Lot Inter-class'             conversion_type,
--
msiv.concatenated_segments   item,
msiv.description             item_description,
mlucc.lot_number             lot_number,
--
muomvf.unit_of_measure_tl    from_uom,
mucvf.uom_class_tl           from_uom_class,
mlucc.conversion_rate        uom_conversion_rate,
muomvt.unit_of_measure_tl    to_uom,
mucvt.uom_class_tl           to_uom_class,
mlucc.disable_date           inactive_date,
--
'1 ' || muomvt.unit_of_measure_tl || ' = ' || mlucc.conversion_rate || ' x ' || muomvf.unit_of_measure_tl conversion_text,
--
mlucc.last_update_date,
mlucc.last_updated_by
from
mtl_lot_uom_class_conversions mlucc,
mtl_units_of_measure_vl       muomvf,
mtl_units_of_measure_vl       muomvt,
mtl_uom_classes_vl            mucvf,
mtl_uom_classes_vl            mucvt,
mtl_system_items_vl           msiv,
mtl_parameters                mp
where
mlucc.from_uom_class    = muomvf.uom_class and
mlucc.from_uom_code     = muomvf.uom_code and
mlucc.to_uom_class      = muomvt.uom_class and
mlucc.to_uom_code       = muomvt.uom_code and
mlucc.from_uom_class    = mucvf.uom_class and
mlucc.to_uom_class      = mucvt.uom_class and
mlucc.inventory_item_id = msiv.inventory_item_id and
mlucc.organization_id   = msiv.organization_id and
mlucc.organization_id   = mp.organization_id and
mp.organization_code    = :p_organization_code
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(uomc) */
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_date(null) timestamp_,
:p_upload_mode upload_mode_,
:p_organization_code organization,
--
uomc.item,
uomc.item_description,
uomc.lot_number,
--
uomc.from_uom,
uomc.from_uom_class,
uomc.to_uom,
uomc.to_uom_class,
uomc.uom_conversion_rate,
uomc.inactive_date,
--
null lot_update_type,
null lot_update_reason,
--
uomc.conversion_text,
uomc.conversion_type
from
uom_conv_qry uomc
where
nvl(:p_r122_api_exists,'N') = nvl(:p_r122_api_exists,'N') and
1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
x.from_uom_class,
x.from_uom,
x.to_uom_class,
x.to_uom,
nvl2(x.item,2,1),
x.item,
x.lot_number