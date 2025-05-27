CREATE EXTERNAL TABLE IF NOT EXISTS credit_card_data (
  Tanggal STRING,
  Provinsi STRING,
  Nilai_Server DOUBLE,
  Nilai_Kartu DOUBLE,
  Nilai_Registered DOUBLE,
  Nilai_Unregistered DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/'
TBLPROPERTIES ("skip.header.line.count"="1");
