/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV ABC assignments
-- Description: Imported from BI Publisher
Description: ABC assignments report
Application: Inventory
Source: ABC assignments report (XML)
Short Name: INVARAAS_XML
DB package: INV_INVARAAS_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-abc-assignments/
-- Library Link: https://www.enginatics.com/reports/inv-abc-assignments/
-- Run Report: https://demo.enginatics.com/

with org_group as(
select ood.organization_id,
maag.assignment_group_id,
ood.organization_name,
gsob.currency_code,
cur.precision std_precision,
nvl(cur.extended_precision, cur.precision) ext_precision
from org_organization_definitions ood,
hr_operating_units hou,
gl_sets_of_books gsob,
mtl_abc_assignment_groups maag,
fnd_currencies cur
where
1=1 and
ood.organization_id=maag.organization_id and
hou.organization_id=ood.operating_unit and 
ood.set_of_books_id =gsob.set_of_books_id and
gsob.currency_code=cur.currency_code(+)
)
select 
og.currency_code,
mif.item_number,
mif.description,
macl.abc_class_name,
maco.sequence_number,
round(nvl(maco.compile_quantity,0),2) quantity,
round(nvl(maco.compile_value,0),og.ext_precision) usage_value, 
mif.primary_uom_code as "UOM"
from
mtl_item_flexfields mif,
mtl_abc_assignments  maa,
mtl_abc_classes macl,
mtl_abc_compiles maco,
mtl_abc_assignment_groups maag,
org_group og
where
maa.inventory_item_id=mif.item_id and 
maa.abc_class_id=macl.abc_class_id and
maag.assignment_group_id=maa.assignment_group_id and
maa.inventory_item_id=maco.inventory_item_id and
maag.compile_id=maco.compile_id and   
macl.organization_id=mif.organization_id and
maco.organization_id=mif.organization_id and
maag.organization_id=mif.organization_id and
og.organization_id=mif.organization_id and
og.assignment_group_id=maa.assignment_group_id
union
select 
og.currency_code,
mif.item_number,
mif.description,
macl.abc_class_name,
null sequence_number,
0 quantity,
0 usage_value, 
mif.primary_uom_code as "UOM"
from
mtl_item_flexfields mif,
mtl_abc_classes macl,
mtl_abc_assignment_groups maag,
mtl_abc_assignments maa,
org_group og
where
not exists
(select *
from mtl_abc_compiles maco
where
maco.organization_id=macl.organization_id and
maa.inventory_item_id=maco.inventory_item_id and
maag.compile_id=maco.compile_id ) and
maa.inventory_item_id =mif.item_id and 
maa.abc_class_id=macl.abc_class_id and
maag.assignment_group_id=maa.assignment_group_id and
macl.organization_id=mif.organization_id and
maag.organization_id=mif.organization_id and
og.organization_id=mif.organization_id and
og.assignment_group_id=maa.assignment_group_id