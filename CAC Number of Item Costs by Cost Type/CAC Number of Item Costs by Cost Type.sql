/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Number of Item Costs by Cost Type
-- Description: Report to show the count of item costs by cost type. Use this report after you copy from one cost type to another, to ensure all rows have been copied over.
-- / +=============================================================================+
-- -- | Copyright 2017 - 2019 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxcountcostsbycosttype.sql
-- -- |
-- -- | Parameters:
-- -- | pfromcosttype -- The cost type you copied from, mandatory
-- -- | ptocosttype -- The cost type you copied to, mandatory
-- -- | pfromorgcode -- The inventory organization you copied from, if
-- -- | enter a blank or null value you get all organizations
-- -- | ptoorgcode -- The inventory organization you copied to, if
-- -- | enter a blank or null value you get all organizations
-- -- |
-- -- | Description:
-- -- | Report to show the count of item costs by cost type. Use this report after
-- -- | you copy from one cost type to another, to ensure all rows have been copied over.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 04 May 2017 Douglas Volz Initial Coding
-- -- | 1.1 31 Aug 2019 Douglas Volz Added to and from cost types and org codes
-- -- | 1.2 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-number-of-item-costs-by-cost-type/
-- Library Link: https://www.enginatics.com/reports/cac-number-of-item-costs-by-cost-type/
-- Run Report: https://demo.enginatics.com/

select
count(*) count,
mp.organization_code org_code,
cct.cost_type,
cct.description
from
mtl_parameters mp,
cst_item_costs cic,
cst_cost_types cct
where
1=1 and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id
group by
mp.organization_code,
cct.cost_type,
cct.description
union all
select
count(*) count,
mp.organization_code org_code,
cct.cost_type,
cct.description
from
mtl_parameters mp,
cst_item_costs cic,
cst_cost_types cct
where
2=2 and
mp.organization_id=cic.organization_id and
cic.cost_type_id=cct.cost_type_id
group by
mp.organization_code,
cct.cost_type,
cct.description
order by
org_code,
cost_type
