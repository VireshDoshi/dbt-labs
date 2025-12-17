from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2025, 10, 31),
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG('dbt_workflow',
         default_args=default_args,
         schedule_interval='@daily',
         catchup=False) as dag:

    run_dbt_seed = BashOperator(
        task_id='dbt_seed',
        bash_command='dbt seed --profiles-dir /dbt --project-dir /dbt --full-refresh'
    )
    run_dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='dbt run --profiles-dir /dbt --project-dir /dbt --full-refresh'
    )
    run_dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='dbt test --profiles-dir /dbt --project-dir /dbt'
    )

    run_dbt_seed >> run_dbt_run >> run_dbt_test

