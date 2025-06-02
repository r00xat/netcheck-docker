# netcheck-docker

A shell script to check and log when your internet connection goes down, by [@TristanBrotherton](https://github.com/TristanBrotherton) – [Find his project here](https://github.com/TristanBrotherton/netcheck)  
**Now this script runs in a Docker container.**

---

## 📋 What it does

This container runs a shell script that:

- Checks your internet connection every 5 seconds (via `ping` to `google.com`)
- Logs connection losses and recoveries with timestamps
- Optionally performs speed tests at startup and after each reconnect
- Serves a basic web interface showing log output via a lightweight Python web server

---

## 🛠️ Build the Docker container

```bash
git clone https://github.com/r00xat/netcheck-docker.git
cd netcheck-docker
docker build -t netcheck:own .
```

---

## ▶️ Start the Docker container in the console

```bash
docker run -p 9000:9000 --name netcheck_monitor netcheck:own
```

---

## 🔄 Start the Docker container in the background

```bash
docker run -d -p 9000:9000 --name netcheck_monitor netcheck:own
```

---

## 🧪 View container logs

```bash
docker logs netcheck_monitor
```

> Use this to view the output of the script while it's running in the background.

---

## 🧱 Docker Compose

```yaml
version: '3.8'

services:
  netcheck:
    image: netcheck:own  # Adjust if your image has a different name/tag
    container_name: netcheck_monitor  # Optional but descriptive

    ports:
      - "9000:9000"  # Maps host port 9000 to container port 9000

    environment:
      TZ: "Europe/Vienna"  # Set the timezone; see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
      NETCHECK_DISABLE_SPEEDTEST: "true"  # If true, disables speed tests after reconnect/start
```

---

## 🙏 Credits

This containerized version is based on the original project by [@TristanBrotherton](https://github.com/TristanBrotherton).  
Find the original script here: [TristanBrotherton/netcheck](https://github.com/TristanBrotherton/netcheck)

---

## 📄 License

This project is licensed under the [Apache-2.0 License](LICENSE).

---

➕ For a detailed list of changes made compared to the original project, see [MODIFICATIONS.md](MODIFICATIONS.md).
