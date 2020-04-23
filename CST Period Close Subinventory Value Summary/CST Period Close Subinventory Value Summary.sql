/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Period Close Subinventory Value Summary
-- Description: Same as Oracle standard's INV Period close value summary (XML), INVTRCLS_XML, but allowing export by leger or for multiple ledgers.
-- Excel Examle Output: https://www.enginatics.com/example/cst-period-close-subinventory-value-summary/
-- Library Link: https://www.enginatics.com/reports/cst-period-close-subinventory-value-summary/
-- Run Report: https://demo.enginatics.com/

select
x.period,
x.ledger,
x.organization,
x.organization_code,
x.subinventory,
x.subinventory_description,
nvl(cpsv.inventory_value,0) inventory_value
from
(
select
oap.period_name period,
gl.name ledger,
ood.organization_name organization,
ood.organization_code,
msi.secondary_inventory_name subinventory,
msi.description subinventory_description,
oap.acct_period_id,
ood.organization_id
from
gl_ledgers gl,
org_organization_definitions ood,
mtl_secondary_inventories msi,
org_acct_periods oap
where
1=1 and
gl.ledger_id=ood.set_of_books_id and
ood.organization_id=msi.organization_id and
ood.organization_id=oap.organization_id
) x,
(
select
cpsv.acct_period_id,
cpsv.organization_id,
cpsv.secondary_inventory,
cpsv.description,
nvl(sum(cpsv.inventory_value),0) inventory_value
from
cst_period_summary_v cpsv
group by
cpsv.acct_period_id,
cpsv.organization_id,
cpsv.secondary_inventory,
cpsv.description
) cpsv
where
x.acct_period_id=cpsv.acct_period_id(+) and
x.organization_id=cpsv.organization_id(+) and
x.subinventory=cpsv.secondary_inventory(+)
order by
x.period,
x.ledger,
x.organization_code,
x.subinventory