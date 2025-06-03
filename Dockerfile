ARG POSTGRESQL_MAJOR=17
ARG POSTGIS_MAJOR_MINOR=3.5

FROM debian:bookworm-slim as build-pgvector

ARG POSTGRESQL_MAJOR
ARG POSTGRESQL_SERVER_DEV_PACKAGE=postgresql-server-dev-${POSTGRESQL_MAJOR}
ARG PGVECTOR_GIT_TAG=v0.8.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       ca-certificates \
       curl \
       git \
       gnupg2 \
       libpq-dev \
       lsb-release \
       wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc| gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       $POSTGRESQL_SERVER_DEV_PACKAGE

RUN git clone --branch $PGVECTOR_GIT_TAG --depth 1 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make \
    && make install

FROM postgis/postgis:$POSTGRESQL_MAJOR-$POSTGIS_MAJOR_MINOR

ARG POSTGRESQL_MAJOR

RUN echo $POSTGRESQL_MAJOR

COPY --from=build-pgvector \
	/usr/share/postgresql/$POSTGRESQL_MAJOR/extension/vector* \
	/usr/share/postgresql/$POSTGRESQL_MAJOR/extension/

COPY --from=build-pgvector \
	/usr/lib/postgresql/$POSTGRESQL_MAJOR/lib/vector* \
	/usr/lib/postgresql/$POSTGRESQL_MAJOR/lib/

# Copy initialization scripts
COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/
