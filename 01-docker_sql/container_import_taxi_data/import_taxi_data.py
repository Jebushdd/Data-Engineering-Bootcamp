# Importing green_taxi_data and taxi_zone_data
import pandas as pd
import argparse
import os
from sqlalchemy import create_engine
from time import time

def main(params): 

    user = params.user 
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    
    csv_file = 'dataset.csv.gz'

    os.system(f'wget {url} -O {csv_file}')

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df_head = pd.read_csv(csv_file, nrows=0).head()
    df_head.to_sql(name=table_name, con=engine, if_exists='replace')
    print('Tabla creada')

    df_iter = pd.read_csv(csv_file, iterator=True, chunksize=50000)
    t_start = time()
    for chunk in df_iter:
        chunk_start = time()
        chunk.lpep_pickup_datetime = pd.to_datetime(chunk.lpep_pickup_datetime)
        chunk.lpep_dropoff_datetime = pd.to_datetime(chunk.lpep_dropoff_datetime)
        chunk.to_sql(name=table_name, con=engine, if_exists='append')
        chunk_end = time()
        print('Bloque insertado en %.3f segundos' % (chunk_end - chunk_start))
    t_end = time()
    print('Archivo procesado en %.3f segundos' % (t_end - t_start))

if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Ingest csv data to postgres')
    parser.add_argument('--user', help='User for postgres')
    parser.add_argument('--password', help='Password for postgres')
    parser.add_argument('--host', help='Host for postgres')
    parser.add_argument('--port', help='Port for postgres')
    parser.add_argument('--db', help='Database name for postgres')
    parser.add_argument('--table_name', help='Name of the table we will write the results to')
    parser.add_argument('--url', help='URL of the csv file')
    args = parser.parse_args()

    main(args)