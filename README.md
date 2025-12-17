Linting
sqlfluff 
pip install sqlfluff sqlfluff-templater-dbt

docker run -it --rm -v ./:/sql sqlfluff/sqlfluff lint . --dialect ansi


https://github.com/dbt-labs/jaffle-shop-classic/tree/main


docker compose up