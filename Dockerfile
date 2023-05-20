FROM quay.io/keycloak/keycloak:21.1 as builder

ENV KC_FEATURES=authorization,account2,account-api,admin-fine-grained-authz,admin2,docker,impersonation,token-exchange,client-policies,declarative-user-profile,dynamic-scopes,preview
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
ENV KC_CACHE=ispn
ENV KC_CACHE_STACK=kubernetes

RUN ["/opt/keycloak/bin/kc.sh", "build"]

FROM quay.io/keycloak/keycloak:21.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=true
ENV KC_HOSTNAME_STRICT_HTTPS=true
ENV KC_HOSTNAME_STRICT_BACKCHANNEL=true
ENV KC_HTTP_ENABLED=false
ENV KC_LOG_CONSOLE_OUTPUT=json

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]