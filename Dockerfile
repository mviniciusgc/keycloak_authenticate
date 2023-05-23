FROM quay.io/keycloak/keycloak:21.1 as builder

ENV KC_FEATURES=authorization,account2,account-api,admin-fine-grained-authz,admin2,docker,impersonation,token-exchange,client-policies,declarative-user-profile,dynamic-scopes,preview
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
ENV KC_CACHE=ispn

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENV DB_ADDR: bdpostgres-production.up.railway.app
ENV DB_DATABASE: postgres
ENV DB_USER: postgres
ENV DB_PASSWORD: postgres

RUN ["/opt/keycloak/bin/kc.sh", "build"]

FROM quay.io/keycloak/keycloak:21.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

ENV KC_HOSTNAME_STRICT_BACKCHANNEL=true
ENV KC_HTTP_ENABLED=false
ENV KC_LOG_CONSOLE_OUTPUT=json

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--hostname-strict=false"]