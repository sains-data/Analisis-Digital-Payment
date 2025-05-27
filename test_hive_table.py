from pyspark.sql import SparkSession

# Initialize Spark session with Hive support
spark = SparkSession.builder \
    .appName("Test Hive Table") \
    .config("spark.sql.warehouse.dir", "/user/hive/warehouse") \
    .enableHiveSupport() \
    .getOrCreate()

try:
    # Check available tables
    print('Available tables:')
    tables = spark.sql("SHOW TABLES").collect()
    for table in tables:
        print(table[1])
    
    # Try to query the digital_payments table
    if any(table[1] == 'digital_payments' for table in tables):
        print('\nSample data from digital_payments:')
        df = spark.sql("SELECT * FROM digital_payments LIMIT 5")
        df.show()
        
        # Get count
        count = spark.sql("SELECT COUNT(*) FROM digital_payments").collect()[0][0]
        print(f'\nTotal records: {count}')
    else:
        print('\ndigital_payments table not found!')
except Exception as e:
    print(f'Error: {str(e)}')
finally:
    # Stop Spark session
    spark.stop()
