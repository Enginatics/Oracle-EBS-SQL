/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Depreciation Projection
-- Description: Based on Oracle's 'Depreciation Projection Report' FASPRJ

Uses custom DB package call XXEN_FASPRJ to launch Oracle standard Depreciation Projection concurrent FAPROJ. The data generation is explained in note:
How Does FA Depreciation Projections Handle Table FA_PROJ_INTERIM_XXX or FA_PROJ_INTERIM_REP ? (Doc ID 1607626.1)
https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=1607626.1
-- Excel Examle Output: https://www.enginatics.com/example/fa-depreciation-projection/
-- Library Link: https://www.enginatics.com/reports/fa-depreciation-projection/
-- Run Report: https://demo.enginatics.com/

select distinct
gl.name ledger,
fpiv.book_type_code book,
&segment_columns
&asset_number
fpiv.period_name period,
sum(fpiv.depreciation) over (partition by fpiv.request_id, fpiv.book_type_code, &segment_columns2 &asset_number fpiv.period_name, fpiv.fiscal_year) depreciation,
fpiv.fiscal_year,
fpiv.period_index,
&segment_columns3
fpiv.request_id
from
gl_ledgers gl,
fa_book_controls fbc,
fa_proj_interim_v fpiv,
fa_additions fa,
gl_code_combinations gcc
where
1=1 and
gl.ledger_id=fbc.set_of_books_id and
fbc.book_type_code=fpiv.book_type_code and
fpiv.asset_id=fa.asset_id and
fpiv.code_combination_id=gcc.code_combination_id
order by
fpiv.request_id,
gl.name,
fpiv.book_type_code,
&segment_columns2
&asset_number
fpiv.fiscal_year,
fpiv.period_index