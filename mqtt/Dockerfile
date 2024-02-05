# checkov:skip=CKV_DOCKER_7 eclipse-mosquitto is just a label, and injected over the top of
FROM eclipse-mosquitto

COPY mosquitto.conf /mosquitto/config/mosquitto.conf

RUN adduser -D mqtt
USER mqtt

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=5 \
    CMD mosquitto_sub -h localhost -t '$SYS/#' -C 1 -W 3
