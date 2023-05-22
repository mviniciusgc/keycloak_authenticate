FROM quay.io/keycloak/keycloak:21.1 as builder

ENV KC_FEATURES=authorization,account2,account-api,admin-fine-grained-authz,admin2,docker,impersonation,token-exchange,client-policies,declarative-user-profile,dynamic-scopes,preview
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENV DB_VENDOR=postgres
ENV DB_ADDR=containers-us-west-83.railway.app
ENV DB_DATABASE=railway
ENV DB_USER=postgres
ENV DB_PASSWORD=DOwd4l6ecQzWFwTvct8s


EXPOSE 8080


RUN ["/opt/keycloak/bin/kc.sh", "build"]

FROM quay.io/keycloak/keycloak:21.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=false
ENV KC_LOG_CONSOLE_OUTPUT=json

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]