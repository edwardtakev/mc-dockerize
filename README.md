# Minecraft Docker Runner

A **lightweight Docker image** for running a Minecraft server, supporting both Vanilla/Paper JARs and CurseForge modpacks.
Automatically downloads the server files on first start and runs with your chosen Java options.

---

## 🚀 Features

* Automatically downloads the Minecraft server JAR or CurseForge modpack from a provided URL if not present.
* Supports custom Java options via `JAVA_OPTS`.
* Fully containerized: no dependencies required on the host.
* Easy deployment with **Docker Compose** or **Portainer**.
* Supports both Vanilla/Paper and CurseForge servers.

---

## 🛠️ Environment Variables

| Variable         | Default         | Description                                                                                            |
| ---------------- | --------------- | ------------------------------------------------------------------------------------------------------ |
| `SERVER_TYPE`    | `default`       | Server type: `default` (Vanilla/Paper) or `curseforge`.                                                |
| `MC_SERVER_URL`  | *(required)*    | URL to download the server: a JAR for Vanilla/Paper, or a zip for CurseForge.                          |
| `MC_SERVER_MAIN` | `server.jar`    | Main server file inside `/app`: JAR for Vanilla/Paper, or ignored for CurseForge (`start.sh` is used). |
| `JAVA_OPTS`      | `-Xmx2G -Xms1G` | Java memory settings and other JVM flags. Adjust to fit your server hardware.                          |
| `MC_ARGS`        | `nogui`         | Extra arguments for Vanilla/Paper JARs. Not used for CurseForge servers.                               |

> **Note:** Vanilla/Paper always runs in `nogui` mode by default. CurseForge uses its provided `start.sh` script.

---

## 📦 Docker Compose Example

```yaml
version: "3.8"
services:
  minecraft:
    image: ghcr.io/edwardtakev/mc-docker:latest
    container_name: minecraft
    restart: unless-stopped
    ports:
      - "25565:25565"
    volumes:
      - ./data:/app
    environment:
      # Server type: default (Vanilla/Paper) or curseforge
      SERVER_TYPE: "default"

      # URL to download server: JAR for Vanilla/Paper, zip for CurseForge
      MC_SERVER_URL: "https://fill-data.papermc.io/v1/objects/8de7c52c3b02403503d16fac58003f1efef7dd7a0256786843927fa92ee57f1e/paper-1.21.8-60.jar"

      # Main server file inside /app (ignored for CurseForge)
      MC_SERVER_MAIN: "server.jar"

      # Memory allocation (ignored for CurseForge)
      JAVA_OPTS: "-Xms2G -Xmx4G"
```

---

## 🐳 Run Directly with Docker

```bash
docker run -d \
  -p 25565:25565 \
  -v $(pwd)/data:/app \
  -e SERVER_TYPE="default" \
  -e MC_SERVER_URL="https://fill-data.papermc.io/v1/objects/8de7c52c3b02403503d16fac58003f1efef7dd7a0256786843927fa92ee57f1e/paper-1.21.8-60.jar" \
  -e MC_SERVER_MAIN="server.jar" \
  -e JAVA_OPTS="-Xms2G -Xmx4G" \
  ghcr.io/edwardtakev/mc-docker:latest
```

---

## 📂 Persistent Data

Mount a volume to `/app` to persist:

* `server.properties`
* World saves
* Player data
* Logs
* CurseForge modpack files

This ensures your server data is preserved even if the container is rebuilt or updated.

---

## ⚡ Switching to CurseForge

To run a CurseForge modpack:

```yaml
environment:
  SERVER_TYPE: "curseforge"
  MC_SERVER_URL: "<curseforge-modpack-zip-url>"
```

> The container will automatically unzip the modpack and run its `start.sh` script.
> You do not need to set `MC_SERVER_MAIN` for CurseForge servers.

---