/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Item Change Tracking
-- Description: Item change tracking of updates to items
-- Excel Examle Output: https://www.enginatics.com/example/item-change-tracking
-- Library Link: https://www.enginatics.com/reports/item-change-tracking
-- Run Report: https://demo.enginatics.com/


select msib.*
from mtl_system_items_b msib, mtl_parameters mp
where 1=1
and mp.organization_id=msib.organization_id