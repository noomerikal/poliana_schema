CREATE EXTERNAL TABLE campaign_finance.individual_contributions_external (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    dates STRING,
    amount INT,
    street STRING,
    city STRING,
    state STRING,
    zip STRING,
    recip_code STRING,
    type STRING,
    cmtel_id STRING,
    other_id STRING,
    gender STRING,
    microfilm STRING,
    occupation STRING,
    employer STRING,
    source STRING
)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
 with serdeproperties (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://polianatest/full/contributions/crp/individuals/';


CREATE EXTERNAL TABLE individual_contributions_external (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    dates STRING,
    amount INT,
    street STRING,
    city STRING,
    state STRING,
    zip STRING,
    recip_code STRING,
    type STRING,
    cmtel_id STRING,
    other_id STRING,
    gender STRING,
    microfilm STRING,
    occupation STRING,
    employer STRING,
    source STRING
)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
 with serdeproperties (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION '/Users/dagilmore/Dev/polianalytics/poliana_processing/src/main/resources/data/industry_contr/hr2397_nays/';

CREATE EXTERNAL TABLE campaign_finance.individual_contributions_external (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    dates STRING,
    amount INT,
    street STRING,
    city STRING,
    state STRING,
    zip STRING,
    recip_code STRING,
    type STRING,
    cmtel_id STRING,
    other_id STRING,
    gender STRING,
    microfilm STRING,
    occupation STRING,
    employer STRING,
    source STRING
)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
 with serdeproperties (
   "separatorChar" = ",",
   "quoteChar"     = "|"
  )
LOCATION 's3n://polianatest/full/contributions/crp/individuals/';

CREATE VIEW campaign_finance.view_individual_contributions (
    cycle,
    fec_trans_id,
    contrib_id,
    contrib,
    recip_id,
    org_name,
    ult_org,
    real_code,
    dates,
    amount,
    street,
    city,
    state,
    zip,
    recip_code,
    type,
    cmtel_id,
    other_id,
    gender,
    microfilm,
    occupation,
    employer,
    source,
    year,
    month
) as SELECT
    cycle,
    fec_trans_id,
    contrib_id,
    contrib,
    recip_id,
    org_name,
    ult_org,
    real_code,
    dates,
    amount,
    street,
    city,
    state,
    zip,
    recip_code,
    type,
    cmtel_id,
    other_id,
    gender,
    microfilm,
    occupation,
    employer,
    source,
    year(from_unixtime(slash_date(dates))),
    month(from_unixtime(slash_date(dates)))
FROM campaign_finance.individual_contributions_external;

CREATE TABLE campaign_finance.individual_contributions (
    cycle STRING,
    fec_trans_id STRING,
    contrib_id STRING,
    contrib STRING,
    recip_id STRING,
    org_name STRING,
    ult_org STRING,
    real_code STRING,
    dates STRING,
    amount INT,
    street STRING,
    city STRING,
    state STRING,
    zip STRING,
    recip_code STRING,
    type STRING,
    cmtel_id STRING,
    other_id STRING,
    gender STRING,
    microfilm STRING,
    occupation STRING,
    employer STRING,
    source STRING
)
PARTITIONED BY (year INT, month INT)
STORED AS SEQUENCEFILE;

INSERT OVERWRITE TABLE campaign_finance.individual_contributions PARTITION (year,month) SELECT * FROM campaign_finance.view_individual_contributions;