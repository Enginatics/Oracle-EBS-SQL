/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intransit Value (Real-Time)
-- Description: Report to show intransit values across all ledgers for current onhand balances and current costing method costs. This is a "real-time" report, showing the quantities and values at the time you run this report. (Used the cstintransitvalueview to simplify the design.)
-- / +=============================================================================+
-- -- | Copyright 2009-20 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxintransitvaluereport.sql
-- -- |
-- -- | Parameters:
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | pcategoryset1 -- The first item category set to report, typically the
-- -- | Cost or Product Line Category Set
-- -- | pcategoryset2 -- The second item category set to report, typically the
-- -- | Inventory Category Set
-- -- |
-- -- | Description:
-- -- | Report to show intransit values across all ledgers, for current onhand
-- -- | balances and current costing method costs. This is a "real-time" report,
-- -- | showing the quantities and values at the time you run this report.
-- -- | (Note: Used the cstintransitvalueview to simplify the design.)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 18 Nov 2008 Douglas Volz Initial Coding
-- -- | 1.1 10 Dec 2009 Douglas Volz Modified for Celgene
-- -- | 1.2 04 Jan 2010 Douglas Volz Added intransit value accounts
-- -- | 1.3 03 Mar 2010 Douglas Volz Set the company account number based on
-- -- | the item's cost of goods sold account
-- -- | 1.4 04 Mar 2010 Douglas Volz Screen out invalid Intransit balances from
-- -- | Dec 2009 transactions for Ledger CHEEURPL.
-- -- | These intransit balances were written-off
-- -- | in the G/L in December 2009. Was not able
-- -- | to get these entries fixed in Oracle.
-- -- | 1.10 23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- -- | master, item categories and operating units.
-- -- | 1.11 23 Aug 2020 Douglas Volz Modified to get intransitowningorgid directly
-- -- | from mtlsupply; if you change the shipping
-- -- | network FOB Point and you can no longer get
-- -- | the FOB Point from cstintransitvalueview.
-- -- | 1.12 27 Nov 2024 Eric Clegg. Added Minimum Absolute Intransit Quantity parameter
-- -- | 1.13 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-intransit-value-real-time/
-- Library Link: https://www.enginatics.com/reports/cac-intransit-value-real-time/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code owning_org,
haouv.name organization_name,
mp_from.organization_code from_org,
mp_to.organization_code to_org,
xxen_util.meaning(x.fob_point,'MTL_FOB_POINT',700) fob_point,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
&category_columns
x.shipment_num shipment_number,
x.receipt_num receipt_number,
x.need_by_date,
x.shipped_date,
x.aging_date,
x.arrival_date,
msiv.primary_uom_code uom_code,
sum(x.to_org_primary_quantity) intransit_quantity,
gl.currency_code,
sum(x.to_org_primary_quantity*nvl(cic.item_cost,0)) intransit_value
from
(
select
ms.intransit_owning_org_id,
ms.from_organization_id,
ms.to_organization_id,
decode(ms.intransit_owning_org_id,ms.to_organization_id,1,2) fob_point,
ms.item_id,
ms.to_org_primary_quantity,
rsh.shipment_num,
rsh.receipt_num,
trunc(ms.need_by_date) need_by_date,
trunc(rsh.shipped_date) shipped_date,
case
when sysdate-rsh.shipped_date<31 then '30 days'
when sysdate-rsh.shipped_date<61 then '60 days'
when sysdate-rsh.shipped_date<91 then '90 days'
when sysdate-rsh.shipped_date<121 then '120 days'
when sysdate-rsh.shipped_date<151 then '150 days'
when sysdate-rsh.shipped_date<181 then '180 days'
else 'Over 180 days'
end aging_date,
trunc(ms.receipt_date) arrival_date
from
mtl_supply ms,
rcv_shipment_headers rsh
where
ms.supply_type_code in ('SHIPMENT','RECEIVING') and
ms.shipment_header_id=rsh.shipment_header_id
) x,
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_parameters mp_from,
mtl_parameters mp_to,
mtl_interorg_parameters mip,
gl_code_combinations gcc,
cst_item_costs cic,
mtl_system_items_vl msiv,
mtl_item_status_vl misv
where
1=1 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
x.intransit_owning_org_id=mp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
nvl(haouv.date_to,sysdate+1)>sysdate and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
x.from_organization_id=mp_from.organization_id and
x.to_organization_id=mp_to.organization_id and
x.from_organization_id=mip.from_organization_id and
x.to_organization_id=mip.to_organization_id and
mip.intransit_inv_account=gcc.code_combination_id and
x.intransit_owning_org_id=cic.organization_id and
x.item_id=cic.inventory_item_id and
mp.primary_cost_method=cic.cost_type_id and
cic.organization_id=msiv.organization_id and
cic.inventory_item_id=msiv.inventory_item_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
mp.organization_code,
haouv.name,
mp_from.organization_code,
mp_to.organization_code,
x.fob_point,
&segment_columns2
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
misv.inventory_item_status_code_tl,
x.shipment_num,
x.receipt_num,
x.need_by_date,
x.shipped_date,
x.aging_date,
x.arrival_date,
msiv.primary_uom_code,
gl.currency_code,
msiv.inventory_item_id,
msiv.organization_id
&lp_min_intransit_qty_clause
order by
ledger,
operating_unit,
owning_org,
from_org,
to_org,
&segment_columns2
item_number,
aging_date
