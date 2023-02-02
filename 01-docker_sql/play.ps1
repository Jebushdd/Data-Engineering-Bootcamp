# Welcome to the all-in-one ETL Process script
ECHO "Docker buid import_taxi_data container"
docker build -t import_taxi_data:v001 ./container_import_taxi_data

ECHO "Docker buid import_taxi_data container"
docker build -t import_taxi_zones:v001 ./container_import_taxi_zones

ECHO "Run postgres and pgadmin services"
docker-compose up -d

ECHO "Waiting for services and DB to get ready for work..."
Start-Sleep -Seconds 15.0

ECHO "Load taxi_trips data"
$URL='https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-01.csv.gz'

$proyecto = Split-Path -Path $PSScriptRoot -Leaf

docker run -it `
    --network=${proyecto}_postgresdb `
    import_taxi_data:v001 `
    --user=root `
    --password=root `
    --host=pgdatabase `
    --port=5432 `
    --db=ny_taxi `
    --table_name=green_taxi_data `
    --url=${URL}

ECHO "Load taxi_zones data"
$URL='https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv'
docker run -it `
    --network=${proyecto}_postgresdb `
    import_taxi_zones:v001 `
    --user=root `
    --password=root `
    --host=pgdatabase `
    --port=5432 `
    --db=ny_taxi `
    --table_name=taxi_zones `
    --url=${URL}

ECHO "Loading PgAdmin interface"
Start-Process "http://127.0.0.1:8080"