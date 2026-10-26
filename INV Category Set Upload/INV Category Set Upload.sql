/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Category Set Upload
-- Description: Creates and updates item category sets and their list of valid categories, as the Category Sets window (Setup > Items > Categories > Category Sets).
-- Each row carries the category set and one valid category. Add a valid category with a new row for the category set, and remove one with Delete Valid Category.
-- Category sets with a category hierarchy (Product Information Management catalogs) are maintained in the catalog pages and are not included. The flex structure of a category set can only be changed while it has no item assignments or valid categories.
-- Excel Example Output: https://www.enginatics.com/example/inv-category-set-upload/
-- Library Link: https://www.enginatics.com/reports/inv-category-set-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mcsv.category_set_name category_set,
mcsv.description,
mcsv.structure_name flex_structure,
mcsv.control_level_disp controlled_at,
mcbk_d.concatenated_segments default_category,
xxen_util.yes(mcsv.mult_item_cat_assign_flag) allow_multiple_assignments,
xxen_util.yes(mcsv.validate_flag) enforce_valid_categories,
mcbk_v.concatenated_segments valid_category,
null delete_valid_category,
to_number(null) upload_row
from
mtl_category_sets_v mcsv,
mtl_categories_b_kfv mcbk_d,
mtl_category_set_valid_cats mcsvc,
mtl_categories_b_kfv mcbk_v
where
1=1 and
nvl(mcsv.hierarchy_enabled,'N')='N' and
mcsv.default_category_id=mcbk_d.category_id(+) and
mcsv.category_set_id=mcsvc.category_set_id(+) and
mcsvc.category_id=mcbk_v.category_id(+)
