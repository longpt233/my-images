export DATAHUB_VERSION=v0.13.3
wget "https://github.com/datahub-project/datahub/archive/refs/tags/$DATAHUB_VERSION.zip"
unzip -d . $DATAHUB_VERSION.zip
cp ./datahub-*/docker/ ./


export DATAHUB_VERSION=v0.13.3 && cd docker && docker compose -f docker-compose-without-neo4j.yml up

