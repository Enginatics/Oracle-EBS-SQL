/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA CPU Benchmark1
-- Description: Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing.
This report generates an output file of 500000 out of a total of 561495 records from a cartesian product based on EBS standard FND tables. These tables contain the same data for all EBS clients and the report can be used as a benchmark to test the database server's CPU performance.
As the query itself should complete in less than a second, most of the execution time is spend in PLSQL code to generate the Blitz Report output file.
To measure meaningful results, there should be enough SGA memory assigned to ensure that the execution time is entirely spent on CPU and not IO related wait events (to be confirmed using the DBA SGA Active Session History report).

example performance for different CPU types:
seconds	rows/s	CPU
8	62500	AMD Ryzen 9 5950X 16-Core Processor
12	41667
13	38462	AMD EPYC 7742 64-Core Processor
16	31250	Exadata CS X8M
20	25000	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
22	22727	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
23	21739	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
25	20000	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
28	17857	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
29	17241	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
39	12821	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
140	3571	SPARC-T5 chipid 1, clock 3600 MHz

Oracle Ace Johannes Michler from Promatis has written a blog about this topic:
<a href="https://promatis.com/de/benchmarking-cpus-for-oracle-e-business-suite-database/" rel="nofollow" target="_blank">https://promatis.com/de/benchmarking-cpus-for-oracle-e-business-suite-database/</a>
-- Excel Examle Output: https://www.enginatics.com/example/dba-cpu-benchmark1/
-- Library Link: https://www.enginatics.com/reports/dba-cpu-benchmark1/
-- Run Report: https://demo.enginatics.com/

select /*+ ordered full(fc) full(fl) full(fc)*/
fc.currency_code,
fl.nls_language,
fl.nls_territory,
fl.nls_codeset,
fl.utf8_date_language,
fa.application_short_name,
fa.basepath,
fa.product_code
from
fnd_languages fl,
fnd_currencies fc,
fnd_application fa
where
rownum<=:row_number and
1=1 and
fl.language_code in
(
'AR',
'BG',
'CA',
'CS',
'D',
'DK',
'E',
'EG',
'EL',
'ESA',
'F',
'FRC',
'GB',
'HR',
'HU',
'I',
'IN',
'IS',
'IW',
'JA',
'KO',
'LT',
'N',
'NL',
'PL',
'PT',
'PTB',
'RO',
'RU',
'S',
'SF',
'SK',
'SL',
'SQ',
'TH',
'TR',
'UK',
'US',
'VN',
'ZHS',
'ZHT'
) and
fc.currency_code in
(
'ADP',
'AED',
'AFA',
'AFN',
'ALL',
'AMD',
'ANG',
'AOA',
'AOK',
'AON',
'ARA',
'ARS',
'ATS',
'AUD',
'AWG',
'AZM',
'AZN',
'BAM',
'BBD',
'BDT',
'BEF',
'BGL',
'BGN',
'BHD',
'BIF',
'BMD',
'BND',
'BOB',
'BOV',
'BRC',
'BRL',
'BSD',
'BTN',
'BUK',
'BWP',
'BYB',
'BYR',
'BZD',
'CAD',
'CDF',
'CHE',
'CHF',
'CHW',
'CLF',
'CLP',
'CNY',
'COP',
'COU',
'CRC',
'CSK',
'CUC',
'CUP',
'CVE',
'CYP',
'CZK',
'DEM',
'DJF',
'DKK',
'DOP',
'DZD',
'ECS',
'ECV',
'EEK',
'EGP',
'ERN',
'ESB',
'ESP',
'ETB',
'EUR',
'FIM',
'FJD',
'FKP',
'FRF',
'GBP',
'GEK',
'GEL',
'GHC',
'GHS',
'GIP',
'GMD',
'GNF',
'GRD',
'GTQ',
'GWP',
'GYD',
'HKD',
'HNL',
'HRD',
'HRK',
'HTG',
'HUF',
'IDR',
'IEP',
'ILS',
'INR',
'IQD',
'IRR',
'ISK',
'ITL',
'JMD',
'JOD',
'JPY',
'KES',
'KGS',
'KHR',
'KMF',
'KPW',
'KRW',
'KWD',
'KYD',
'KZT',
'LAK',
'LBP',
'LKR',
'LRD',
'LSL',
'LTL',
'LUC',
'LUF',
'LUL',
'LVL',
'LVR',
'LYD',
'MAD',
'MDL',
'MGA',
'MGF',
'MKD',
'MMK',
'MNT',
'MOP',
'MRO',
'MTL',
'MUR',
'MVR',
'MWK',
'MXN',
'MXP',
'MXV',
'MYR',
'MZM',
'MZN',
'NAD',
'NGN',
'NIC',
'NIO',
'NLG',
'NOK',
'NPR',
'NZD',
'OMR',
'PAB',
'PEI',
'PEN',
'PGK',
'PHP',
'PKR',
'PLN',
'PLZ',
'PTE',
'PYG',
'QAR',
'ROL',
'RON',
'RSD',
'RUB',
'RUR',
'RWF',
'SAR',
'SBD',
'SCR',
'SDD',
'SDG',
'SDP',
'SEK',
'SGD',
'SHP',
'SIT',
'SKK',
'SLL',
'SOS',
'SRD',
'SRG',
'STAT',
'STD',
'SUR',
'SVC',
'SYP',
'SZL',
'THB',
'TJR',
'TJS',
'TMM',
'TMT',
'TND',
'TOP',
'TPE',
'TRL',
'TRY',
'TTD',
'TWD',
'TZS',
'UAH',
'UAK',
'UGS',
'UGX',
'USD',
'USN',
'USS',
'UYI',
'UYP',
'UYU',
'UZS',
'VEB',
'VEF',
'VND',
'VUV',
'WST',
'XAF',
'XAG',
'XAU',
'XB5',
'XBA',
'XBB',
'XBC',
'XBD',
'XCD',
'XDR',
'XEU',
'XFO',
'XFU',
'XOF',
'XPD',
'XPF',
'XPT',
'XTS',
'XXX',
'YDD',
'YER',
'YUD',
'YUM',
'YUN',
'ZAL',
'ZAR',
'ZMK',
'ZRN',
'ZRZ',
'ZWD',
'ZWL'
) and
fa.application_short_name in (
'ABM',
'AD',
'AHL',
'AHM',
'AK',
'ALR',
'AME',
'AMF',
'AMS',
'AMV',
'AMW',
'AN',
'AR',
'AS',
'ASF',
'ASG',
'ASL',
'ASN',
'ASO',
'ASP',
'AST',
'AU',
'AX',
'AZ',
'BEN',
'BIC',
'BIE',
'BIL',
'BIM',
'BIN',
'BIS',
'BIV',
'BIX',
'BIY',
'BLC',
'BNE',
'BOM',
'BSC',
'CCT',
'CDR',
'CE',
'CHV',
'CLA',
'CLE',
'CLJ',
'CLL',
'CLN',
'CN',
'CPGC',
'CRP',
'CS',
'CSC',
'CSD',
'CSE',
'CSF'
)
order by
fl.nls_language,
fc.currency_code,
fa.application_short_name