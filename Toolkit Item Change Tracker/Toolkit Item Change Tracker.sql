/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Toolkit - Item Change Tracker
-- Description: to track item attribute changes
-- Excel Examle Output: https://www.enginatics.com/example/toolkit-item-change-tracker/
-- Library Link: https://www.enginatics.com/reports/toolkit-item-change-tracker/
-- Run Report: https://demo.enginatics.com/

select 
msib.*
from mtl_system_items_b msib, mtl_parameters mp
where 1=1
and mp.organization_id=msib.organization_id