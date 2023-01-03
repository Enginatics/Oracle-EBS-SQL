/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Login Summary
-- Description: Active application user count per month
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-login-summary/
-- Library Link: https://www.enginatics.com/reports/fnd-user-login-summary/
-- Run Report: https://demo.enginatics.com/

select distinct
trunc(fl.start_time,'month') month,
count(distinct fl.user_id) over (partition by trunc(fl.start_time,'month')) user_count
from
fnd_logins fl
where
1=1
order by
month desc