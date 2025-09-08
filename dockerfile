FROM eclipse-temurin:21-jre

WORKDIR /app
EXPOSE 25565

# Environment variables
ENV MC_SERVER_MAIN="server.jar" \
    MC_SERVER_URL="" \
    JAVA_OPTS="-Xmx2G -Xms1G" \
    MC_ARGS="nogui" \
    # default | curseforge
    SERVER_TYPE="default"

# Install required tools
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Startup logic
ENTRYPOINT ["sh", "-c", "\
if [ \"$SERVER_TYPE\" = \"curseforge\" ]; then \
    echo 'CurseForge server mode'; \
    if [ ! -f /app/start.sh ]; then \
        echo 'Downloading CurseForge modpack from $MC_SERVER_URL...'; \
        wget -O /app/pack.zip $MC_SERVER_URL; \
        unzip /app/pack.zip -d /app; \
        rm /app/pack.zip; \
        chmod +x /app/start.sh; \
    fi; \
    exec /app/start.sh; \
else \
    if [ ! -f \"/app/$MC_SERVER_MAIN\" ]; then \
        echo 'Downloading server jar from $MC_SERVER_URL...'; \
        wget -O /app/$MC_SERVER_MAIN $MC_SERVER_URL; \
    fi; \
    exec java $JAVA_OPTS -jar /app/$MC_SERVER_MAIN $MC_ARGS; \
fi"]
