/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Index Columns
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/dba-index-columns/
-- Library Link: https://www.enginatics.com/reports/dba-index-columns/
-- Run Report: https://demo.enginatics.com/

select
dic.table_owner,
dic.table_name,
dic.index_owner,
decode(di.index_type,'NORMAL',null,di.index_type) index_type,
dic.index_name,
xxen_util.meaning(decode(di.uniqueness,'UNIQUE','Y'),'YES_NO',0) unique_,
dic.column_name,
dic.column_position,
do.created
from
dba_indexes di,
dba_ind_columns dic,
dba_objects do
where
1=1 and
di.owner=dic.index_owner and
di.index_name=dic.index_name and
di.owner=do.owner(+) and
di.index_name=do.object_name(+) and
do.object_type(+)='INDEX'
order by
dic.table_name,
dic.index_name,
dic.column_position