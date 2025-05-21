/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Unit Of Measure Upload
-- Description: INV Unit Of Measure Upload
======================
Note: This upload can only be used in R12.2 or later.

This upload can be used to create and update Unit of Measure Classes and Units of Measures
-- Excel Examle Output: https://www.enginatics.com/example/inv-unit-of-measure-upload/
-- Library Link: https://www.enginatics.com/reports/inv-unit-of-measure-upload/
-- Run Report: https://demo.enginatics.com/

with uom_qry as
(
select
mucv.uom_class    uom_class,
mucv.description  class_description,
mucv.disable_date class_inactive_date,
(select
 muomv.uom_code
 from
 mtl_units_of_measure_vl muomv
 where
 muomv.uom_class = mucv.uom_class and
 muomv.base_uom_flag = 'Y'
) base_uom_code,
--
decode(muomv.base_uom_flag,'Y','Y',null) base_uom_flag,
muomv.unit_of_measure_tl unit_of_measure,
muomv.uom_code,
muomv.description uom_description,
muomv.disable_date uom_inactive_date,
--
mucv.attribute_category class_attrib_category,
mucv.attribute1 class_attribute1,
mucv.attribute2 class_attribute2,
mucv.attribute3 class_attribute3,
mucv.attribute4 class_attribute4,
mucv.attribute5 class_attribute5,
mucv.attribute6 class_attribute6,
mucv.attribute7 class_attribute7,
mucv.attribute8 class_attribute8,
mucv.attribute9 class_attribute9,
mucv.attribute10 class_attribute10,
mucv.attribute11 class_attribute11,
mucv.attribute12 class_attribute12,
mucv.attribute13 class_attribute13,
mucv.attribute14 class_attribute14,
mucv.attribute15 class_attribute15,
--
muomv.attribute_category uom_attrib_category,
muomv.attribute1 uom_attribute1,
muomv.attribute2 uom_attribute2,
muomv.attribute3 uom_attribute3,
muomv.attribute4 uom_attribute4,
muomv.attribute5 uom_attribute5,
muomv.attribute6 uom_attribute6,
muomv.attribute7 uom_attribute7,
muomv.attribute8 uom_attribute8,
muomv.attribute9 uom_attribute9,
muomv.attribute10 uom_attribute10,
muomv.attribute11 uom_attribute11,
muomv.attribute12 uom_attribute12,
muomv.attribute13 uom_attribute13,
muomv.attribute14 uom_attribute14,
muomv.attribute15 uom_attribute15,
--
mucv.last_update_date class_lud,
mucv.last_updated_by class_luby,
muomv.last_update_date uom_lud,
muomv.last_updated_by uom_luby
from
mtl_uom_classes_vl mucv,
mtl_units_of_measure_vl muomv
where
muomv.uom_class = mucv.uom_class
)
--
-- Main Query Starts Here
--
select
x.*
from
(
select /*+ push_pred(uom) */
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_date(null) timestamp_,
:p_upload_mode upload_mode_,
--
uom.uom_class,
uom.class_description,
uom.class_inactive_date,
--uom.base_uom_code,
--
uom.base_uom_flag,
uom.unit_of_measure,
uom.uom_code,
uom.uom_description,
uom.uom_inactive_date,
--
uom.class_attrib_category,
uom.class_attribute1,
uom.class_attribute2,
uom.class_attribute3,
uom.class_attribute4,
uom.class_attribute5,
uom.class_attribute6,
uom.class_attribute7,
uom.class_attribute8,
uom.class_attribute9,
uom.class_attribute10,
uom.class_attribute11,
uom.class_attribute12,
uom.class_attribute13,
uom.class_attribute14,
uom.class_attribute15,
--
uom.uom_attrib_category,
uom.uom_attribute1,
uom.uom_attribute2,
uom.uom_attribute3,
uom.uom_attribute4,
uom.uom_attribute5,
uom.uom_attribute6,
uom.uom_attribute7,
uom.uom_attribute8,
uom.uom_attribute9,
uom.uom_attribute10,
uom.uom_attribute11,
uom.uom_attribute12,
uom.uom_attribute13,
uom.uom_attribute14,
uom.uom_attribute15,
--
uom.class_lud,
uom.class_luby,
uom.uom_lud,
uom.uom_luby
from
uom_qry uom
where
1=1
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
x.uom_class,
decode(x.base_uom_flag,'Y',1,2),
x.unit_of_measure