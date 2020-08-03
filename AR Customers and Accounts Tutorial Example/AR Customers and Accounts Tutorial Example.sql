/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customers and Accounts (Tutorial Example)
-- Description: Basic example report combining parties and customer accounts
-- Excel Examle Output: https://www.enginatics.com/example/ar-customers-and-accounts-tutorial-example/
-- Library Link: https://www.enginatics.com/reports/ar-customers-and-accounts-tutorial-example/
-- Run Report: https://demo.enginatics.com/

select
hp.party_name customer_name,
hp.party_type,
hca.account_number
from
hz_parties hp,
hz_cust_accounts hca
where
1=1 and
hp.party_id=hca.party_id