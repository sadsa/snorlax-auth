FROM quay.io/keycloak/keycloak:latest AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure custom theme
COPY themes/snorlax /opt/keycloak/themes/snorlax

# Configure the database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# Build optimized configuration
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set proper permissions
USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]