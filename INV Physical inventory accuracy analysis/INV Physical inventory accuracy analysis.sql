/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical inventory accuracy analysis
-- Description: Imported from BI Publisher
Description: Physical inventory accuracy analysis
Application: Inventory
Source: Physical inventory accuracy analysis (XML)
Short Name: INVARPIA_XML
DB package: INV_INVARPIA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-accuracy-analysis/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-accuracy-analysis/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
ood.organization_code,
mpi.physical_inventory_name,
msiv.concatenated_segments item,
msiv.description,
&category_columns
mpacv.revision,
round(mpacv.system_quantity,:p_qty_precision) system_quantity,
msiv.primary_uom_code uom,
round(nvl(mpacv.count_quantity,0),:p_qty_precision) count_quantity,
round(mpacv.adjustment_quantity,:p_qty_precision) adjustment_quantity,
round(nvl(system_quantity*mpacv.actual_cost,0),fc.precision) system_value,
round(nvl(count_quantity*mpacv.actual_cost,0),fc.precision) count_value,
round(nvl(nvl(count_quantity*mpacv.actual_cost,0)-mpacv.system_quantity*mpacv.actual_cost,0),fc.precision) adjustment_value,
decode(round(nvl(mpacv.count_quantity*mpacv.actual_cost,0),fc.precision),0,0,
round(nvl(nvl(mpacv.count_quantity*mpacv.actual_cost,0)-mpacv.system_quantity*mpacv.actual_cost,0),fc.precision)*100/round(nvl(mpacv.count_quantity*mpacv.actual_cost,0),fc.precision)) adjustment_percent
from
mtl_physical_inventories mpi,
mtl_phy_adj_cost_v mpacv,
org_organization_definitions ood,
gl_ledgers gl,
fnd_currencies fc,
mtl_system_items_vl msiv
where
1=1 and
mpacv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mpi.physical_inventory_id=mpacv.physical_inventory_id and
(mpacv.count_quantity<>0 or mpacv.system_quantity<>0) and
mpacv.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
gl.currency_code=fc.currency_code and
mpacv.organization_id=msiv.organization_id and
mpacv.inventory_item_id=msiv.inventory_item_id
order by
mpi.physical_inventory_name,
nvl(mpacv.count_quantity*mpacv.actual_cost-mpacv.system_quantity*mpacv.actual_cost,0) asc,
msiv.concatenated_segments