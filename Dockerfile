# Use the Keycloak 21.1 image from quay.io
FROM quay.io/keycloak/keycloak:21.1

# Define the Keycloak port
EXPOSE 8080

# Set the Keycloak configuration environment variables
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV KC_HEALTH_ENABLED=true
ENV KC_DB=postgres

# Build the final Keycloak URL with the Railway.app proxy
ENV PROXY_ADDRESS_FORWARDING=true

# You may need to update the "<your-railway-app-url>" with your actual Railway.app URL

# Start Keycloak
CMD ["-b", "0.0.0.0"]
