FROM python:3.9
RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2
WORKDIR /app
COPY import_taxi_zones.py import_taxi_zones.py
ENTRYPOINT ["python", "import_taxi_zones.py"]
