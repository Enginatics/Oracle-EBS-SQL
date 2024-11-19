/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND SOA Runtime Error
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-soa-runtime-error/
-- Library Link: https://www.enginatics.com/reports/fnd-soa-runtime-error/
-- Run Report: https://demo.enginatics.com/

select
fsre.error_date,
fsre.error_code,
fsre.error_detail
from
fnd_soa_runtime_error fsre
where
1=1
order by
fsre.error_date desc