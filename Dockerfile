FROM quay.io/keycloak/keycloak:21.1 as builder

ENV KC_FEATURES=authorization,account2,account-api,admin-fine-grained-authz,admin2,docker,impersonation,token-exchange,client-policies,declarative-user-profile,dynamic-scopes,preview
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
ENV KC_CACHE=ispn

SECRET_KEYCLOAK_ADMIN:admin
SECRET_KEYCLOAK_ADMIN_PASSWORD:admin
SECRET_KC_DB_URL:jdbc:postgresql://containers-us-west-83.railway.app:6583/
SECRET_KC_DB_USERNAME:postgres
SECRET_KC_DB_PASSWORD:DOwd4l6ecQzWFwTvct8s

RUN ["/opt/keycloak/bin/kc.sh", "build"]

FROM quay.io/keycloak/keycloak:21.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

ENV KC_HOSTNAME_STRICT_BACKCHANNEL=true
ENV KC_HTTP_ENABLED=false
ENV KC_LOG_CONSOLE_OUTPUT=json

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--hostname-strict=false"]