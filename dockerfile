FROM eclipse-temurin:21-jdk

WORKDIR /app

# wget to download the JAR dynamically
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Default JAR file name
ENV MC_JAR=server.jar

# Auto-accept the EULA
RUN echo "eula=true" > /app/eula.txt

EXPOSE 25565
