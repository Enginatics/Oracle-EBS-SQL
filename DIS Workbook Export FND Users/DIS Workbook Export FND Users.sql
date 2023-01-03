/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Export FND Users
-- Description: List of FND User IDs for active workbook owners.
This export is required to remotely export workbook XMLs on the Enginatics environments for customers migrating from Discoverer to Blitz Report.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-export-fnd-users/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-export-fnd-users/
-- Run Report: https://demo.enginatics.com/

select
fu.user_id,
fu.user_name
from
fnd_user fu
where
fu.user_name in (select eqs.qs_doc_owner from &eul.eul5_qpp_stats eqs where 1=1)