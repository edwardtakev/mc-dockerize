# Use Eclipse Temurin JRE (Java 21) as base image
FROM eclipse-temurin:21-jre

# Set working directory
WORKDIR /app

# Expose Minecraft server port
EXPOSE 25565

# Environment variables with defaults
ENV MC_JAR=server.jar \
    MC_JAR_URL="" \
    JAVA_OPTS="-Xmx2G -Xms1G" \
    MC_ARGS="nogui"

# Ensure wget is available
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Container startup: download jar if missing, then run it
ENTRYPOINT ["sh", "-c", "if [ ! -f /app/$MC_JAR ]; then echo 'Downloading server jar from $MC_JAR_URL...'; wget -O /app/$MC_JAR $MC_JAR_URL; fi && exec java $JAVA_OPTS -jar /app/$MC_JAR $MC_ARGS"]
