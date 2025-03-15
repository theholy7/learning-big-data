FROM python:3.10-slim

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    git \
    ssh \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    dbt-core \
    dbt-postgres

WORKDIR /dbt

EXPOSE 8080

CMD ["/bin/bash"]
