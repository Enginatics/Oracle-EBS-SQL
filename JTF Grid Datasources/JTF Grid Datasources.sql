/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JTF Grid Datasources
-- Description: JTF grid (CRM spreadtable) datasource and column definition
-- Excel Examle Output: https://www.enginatics.com/example/jtf-grid-datasources/
-- Library Link: https://www.enginatics.com/reports/jtf-grid-datasources/
-- Run Report: https://demo.enginatics.com/

select
jgdv.grid_datasource_name datasource_name,
jgdv.title_text title,
jgdv.db_view_name view_name,
jgcv.grid_col_alias column_alias,
jgcv.db_col_name view_column,
xxen_util.meaning(jgcv.data_type_code,'COLUMN_TYPE',0) data_type,
jgcv.query_seq query_sequence,
xxen_util.meaning(jgcv.sortable_flag,'WSH_DEBUG_ENABLED',665) sortable,
jgcv.label_text label,
jgcv.display_seq display_sequence,
jgcv.display_hsize display_width,
xxen_util.meaning(jgcv.display_type_code,'JTF_DISPLAY_TYPE',0) display_type
from
jtf_grid_datasources_vl jgdv,
jtf_grid_cols_vl jgcv
where
1=1 and
jgdv.grid_datasource_name=jgcv.grid_datasource_name
order by
jgdv.grid_datasource_name,
jgcv.query_seq