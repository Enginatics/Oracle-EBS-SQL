/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Change Tracking - Org View
-- Description: Item change tracking of updates to items
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-change-tracking-org-view/
-- Library Link: https://www.enginatics.com/reports/inv-item-change-tracking-org-view/
-- Run Report: https://demo.enginatics.com/

select msib.*
from mtl_system_items_b msib, mtl_parameters mp
where 1=1
and mp.organization_id=msib.organization_id