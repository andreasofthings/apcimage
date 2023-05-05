FROM python:3.11-slim as python-base
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYSETUP_PATH="." \
    VENV_PATH="./.venv" \
    PATH="$VENV_PATH/bin:$PATH"
ENV PATH="$VENV_PATH/bin:$PATH"

FROM python-base as builder-base
RUN apt-get update
RUN apt-get install -y --no-install-recommends curl build-essential gcc libffi-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev libxslt-dev gcc libjpeg-dev zlib1g-dev libwebp-dev pipenv

FROM python-base as production
RUN groupadd --gid 1000 apc \
  && useradd --uid 1000 --gid apc --shell /bin/bash apc
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH
COPY . /app/
RUN chown -R 1000:1000 /app
USER microblogpub
WORKDIR /app
EXPOSE 8000
CMD ["./entry/start.sh"]
