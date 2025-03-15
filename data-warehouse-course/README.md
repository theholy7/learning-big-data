# How to start

Make sure that you have docker installed and running.

Then you can start by bringing the services up with `docker compose up . --build`.

Once the services are up, you should be able to attach to the container running dbt with:
`docker attach data-warehouse-course-app-1`.

You can exit with `ctrl+c` which will stop the container, or leave it running and detach with `ctrl+p ctrl+q`.

To run the dbt docs, use `dbt docs generate` first, and then `dbt docs serve --host 0.0.0.0`

**Note**: If you modify the `docker-composse.yml` file, you need to update the `dbt_project.yml` file to still connect
to the database.
