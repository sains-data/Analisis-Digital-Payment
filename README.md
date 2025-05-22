
# 💵 **ANALYSIS OF DIGITAL PAYMENT ADOPTION THROUGH THE NUMBER OF MERCHANTS IN THE SUMATRA REGION**

This project aims to analyze the adoption of digital payment systems in the Sumatra region, specifically through the number of merchants using services such as QRIS, e-wallets, and cards. Using a Hadoop-based Big Data ecosystem, data from Bank Indonesia is processed in a structured manner through the Medallion architecture (Bronze-Silver-Gold) to understand trends and factors that influence adoption, such as digital infrastructure and population density. Technologies such as Apache Spark, Hive, and Airflow are used for data processing, analysis, and visualization, so that the end result can be used as a basis for policy recommendations to encourage equitable adoption of digital payments in Sumatra.

## 📚 **Project Overview**
This project includes:
- Batch Pipeline: Medallion Architecture (Bronze → Silver → Gold) for historical digital payment data.
- Analytical Modeling: Trend analysis & regional adoption patterns using Apache Spark & Hive.
- Data Integration: Combining national and regional e-money datasets from Bank Indonesia.
- Visualization & Reporting: Interactive dashboard via Apache Superset for policy decision-making.
- ETL & Orchestration: Automated data pipeline using Apache Airflow for scheduled updates.

🗝️ Key Focus Areas:
- Apache Hadoop Distributed File System (HDFS)
- Apache Spark (ETL, Aggregation, Interpolation)
- Apache Hive (SQL analytics, OLAP)
- Apache Airflow & Ambari (Monitoring & Orchestration)
- Apache Superset (Dashboard & Reporting)
- Data Modeling with CSV & Parquet for scalable analytics

## 🖥️ **Tools**

| No. | Technology         | Category              | Main Function                                                                 |
|-----|--------------------|-----------------------|-------------------------------------------------------------------------------|
| 1   | Apache Hadoop HDFS | Storage               | Stores raw data (Bronze), cleaned data (Silver), and aggregated data (Gold) in a distributed system |
| 2   | Apache Spark       | ETL / Analytics Engine| Performs data cleaning, transformation, interpolation, and batch aggregation |
| 3   | Apache Hive        | Query Layer           | Enables SQL-like queries on HDFS data, supports OLAP analysis and reporting  |
| 4   | Apache Airflow     | Workflow Orchestration| Schedules and manages batch pipelines: ingest → transform → aggregate → export |
| 5   | Apache Ambari      | Cluster Management    | Monitors and manages the Hadoop ecosystem components visually                |
| 6   | Apache Superset    | BI / Visualization    | Visualizes aggregated data from the Gold layer for business insights         |
| 7   | Hive Metastore     | Metadata Store        | Stores schema and metadata for Hive tables used in SQL querying              |

## 🧑‍🤝‍🧑 **Team**
    1. Johannes Krisjon S.	122450043 
    2. Bastian Heskia S.    122450130 
    3. Fadhil Fitra Wijaya 	122450082 
    4. Dhea Amelia Putri    122450004
    5. Isyamaetreya Savitri	121450037
