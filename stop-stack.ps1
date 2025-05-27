# Script to stop the entire data analysis stack

Write-Host "Stopping Hadoop, Spark, and Superset stack..." -ForegroundColor Yellow

# Stop all services
docker-compose down

Write-Host "Data stack has been stopped" -ForegroundColor Green
