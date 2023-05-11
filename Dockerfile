# Use a imagem base do Keycloak
FROM quay.io/keycloak/keycloak:21.0.1

# Defina as variáveis de ambiente para configurar o Keycloak
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin

# Expõe a porta 8080 para acessar o Keycloak
EXPOSE 8080

# Comando para iniciar o Keycloak
CMD ["-b", "0.0.0.0"]

