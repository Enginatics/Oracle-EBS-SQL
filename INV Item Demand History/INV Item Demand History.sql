/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Demand History
-- Description: Imported from BI Publisher
Description: Item demand history report
Application: Inventory
Source: Item demand history report (XML)
Short Name: INVPRFDH_XML
DB package: INV_INVPRFDH_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-demand-history/
-- Library Link: https://www.enginatics.com/reports/inv-item-demand-history/
-- Run Report: https://demo.enginatics.com/

select
 ood.organization_name,
 ood.organization_code,
 gsob.currency_code currency_code,
 (select ml.meaning period_name
  from mfg_lookups ml
  where ml.lookup_type = 'MTL_PERIOD_TYPES'
  and   ml.lookup_code = :P_period_type
 ) period_type,
 mdh.period_start_date starting_date,
 --
 msi.concatenated_segments item,
 msi.description,
 xxen_util.meaning(msi.item_type,'ITEM_TYPE',3) user_item_type,
 msi.primary_uom_code uom,
 --
 mdh.sales_order_demand sales_orders,
 mdh.interorg_issue interorg_issues,
 mdh.std_wip_usage wip_issues,
 mdh.miscellaneous_issue miscellaneous_issues,
 nvl(mdh.sales_order_demand,0) +
 nvl(mdh.interorg_issue,0) +
 nvl(mdh.std_wip_usage,0) +
 nvl(mdh.miscellaneous_issue,0) total
from
 org_organization_definitions ood,
 gl_sets_of_books gsob,
 fnd_currencies fndc,
 mtl_system_items_kfv msi,
 mtl_demand_histories mdh
where
     mdh.organization_id   = msi.organization_id
and  mdh.inventory_item_id = msi.inventory_item_id
and  mdh.organization_id   = ood.organization_id
and  ood.set_of_books_id   = gsob.set_of_books_id
and  gsob.currency_code    = fndc.currency_code
and  mdh.organization_id   = :p_org
and  mdh.period_type       = :p_period_type
and  mdh.period_start_date >= :p_start_date
and  ( (:p_cat_lo is null and :p_cat_hi is null)
      or
       (mdh.organization_id,mdh.inventory_item_id) in
       (select mic.organization_id,mic.inventory_item_id
        from   mtl_item_categories  mic, mtl_categories_kfv mc
        where  mic.category_set_id = :p_cat_set
        and    mic.organization_id = :p_org
        and    mic.category_id = mc.category_id
        and    2=2
       )
     )
and  :p_cat_set_name = :p_cat_set_name
and  :p_org_code = :p_org_code
and  1=1
order by
 msi.concatenated_segments,
 mdh.period_start_date desc