FROM apache/airflow:2.5.3-python3.8

USER root
# Optional but handy for compiling deps
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
USER airflow
# Install dbt (pin versions that match your adapter)
RUN pip install --no-cache-dir \
    dbt-core==1.5.0 \
    dbt-postgres==1.5.0 \
    psycopg2-binary \
    sqlfluff \
    sqlfluff-templater-dbt

