# Base image with latest LTS JDK
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Copy entrypoint script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose Minecraft default port
EXPOSE 25565

# Run the entrypoint script
ENTRYPOINT ["/start.sh"]
