FROM quay.io/keycloak/keycloak:26.0.1 AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure the database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build 

FROM quay.io/keycloak/keycloak:26.0.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set proper permissions
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]