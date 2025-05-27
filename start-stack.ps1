# Script to start the entire data analysis stack

Write-Host "Starting Hadoop, Spark, and Superset stack..." -ForegroundColor Green

# Start all services
docker-compose up -d

Write-Host "Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Check if HDFS is ready
Write-Host "Checking HDFS status..." -ForegroundColor Cyan
docker-compose exec namenode hdfs dfsadmin -report

# Check Spark status
Write-Host "Checking Spark status..." -ForegroundColor Cyan
docker-compose exec spark-master curl -s http://localhost:8080/json/ | Select-String "status"  # Masih menggunakan port 8080 di dalam container

# Upload data to HDFS
Write-Host "Uploading data to HDFS..." -ForegroundColor Cyan
docker-compose exec namenode bash -c "chmod +x /data/prepare_hdfs_data.sh && /data/prepare_hdfs_data.sh"

Write-Host "Data stack is now running!" -ForegroundColor Green
Write-Host ""
Write-Host "Access points:" -ForegroundColor Green
Write-Host "- HDFS UI: http://localhost:9870" -ForegroundColor White
Write-Host "- Spark UI: http://localhost:8081" -ForegroundColor White
Write-Host "- Jupyter Notebook: http://localhost:8888" -ForegroundColor White
Write-Host "- Superset: http://localhost:8088" -ForegroundColor White
Write-Host ""
Write-Host "For Jupyter, please check the logs for the token:" -ForegroundColor Yellow
Write-Host "docker-compose logs jupyter | Select-String token" -ForegroundColor White
