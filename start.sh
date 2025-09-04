#!/bin/bash
set -e

# Check that server JAR URL is provided
if [ -z "$MC_JAR_URL" ]; then
    echo "ERROR: Please set MC_JAR_URL to the direct server JAR link"
    exit 1
fi

# Download server JAR
echo "Downloading Minecraft server from $MC_JAR_URL"
curl -s -L -o /app/server.jar "$MC_JAR_URL"

# Accept EULA
echo "eula=TRUE" > /app/eula.txt

# Start the server with Java options (default memory)
JAVA_OPTS=${JAVA_OPTS:-"-Xms1G -Xmx4G"}
exec java $JAVA_OPTS -jar server.jar nogui
