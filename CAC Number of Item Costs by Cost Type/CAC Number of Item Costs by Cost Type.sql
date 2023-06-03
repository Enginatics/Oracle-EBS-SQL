/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Number of Item Costs by Cost Type
-- Description: Report to show the count of item costs by cost type.  Use this report after you copy from one cost type to another, to ensure all rows have been copied over.

/* +=============================================================================+
-- |  Copyright 2017 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_count_costs_by_cost_type.sql
-- |
-- |  Parameters:
-- |  p_from_cost_type       -- The cost type you copied from, mandatory
-- |  p_to_cost_type         -- The cost type you copied to, mandatory
-- |  p_from_org_code        -- The inventory organization you copied from, if  
-- |                            enter a blank or null value you get all organizations
-- |  p_to_org_code          -- The inventory organization you copied to, if  
-- |                            enter a blank or null value you get all organizations
-- | 
-- |  Description:
-- |  Report to show the count of item costs by cost type.  Use this report after
-- |  you copy from one cost type to another, to ensure all rows have been copied over.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     04 May 2017 Douglas Volz   Initial Coding
-- |  1.1     31 Aug 2019 Douglas Volz   Added to and from cost types and org codes
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-number-of-item-costs-by-cost-type/
-- Library Link: https://www.enginatics.com/reports/cac-number-of-item-costs-by-cost-type/
-- Run Report: https://demo.enginatics.com/

select count(*) Count,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
 cct.description Description
from    cst_item_costs cic,
 mtl_parameters mp,
 cst_cost_types cct
where cic.organization_id   = mp.organization_id
and cic.cost_type_id      = cct.cost_type_id
and 1=1
group by
 mp.organization_code,
 cct.description,
 cct.cost_type
union all
select count(*) Count,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
 cct.description Description
from    cst_item_costs cic,
 mtl_parameters mp,
 cst_cost_types cct
where cic.organization_id   = mp.organization_id
and cic.cost_type_id      = cct.cost_type_id
and 2=2
group by
 mp.organization_code,
 cct.description,
 cct.cost_type
-- Order by Cost Type, Organization Code
order by 2,3