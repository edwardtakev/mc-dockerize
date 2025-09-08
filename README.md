
A lightweight Docker image for running a Minecraft server with custom JARs.  
Automatically downloads the server JAR on first start and runs with your chosen Java options and arguments.

---

## 🚀 Features
- Downloads the Minecraft server JAR from a provided URL if not present
- Allows custom Java options and server arguments via environment variables
- Clean containerized setup, no host dependencies
- Easy to deploy with Docker Compose or Portainer

---

## 🛠️ Environment Variables

| Variable      | Default | Description |
|---------------|---------|-------------|
| `MC_JAR`      | `server.jar` | Name of the JAR file inside `/app` |
| `MC_JAR_URL`  | *(required)* | URL to download the server JAR |
| `JAVA_OPTS`   | `-Xmx2G -Xms1G` | Java memory/flags |

---
