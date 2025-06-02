## 📝 Modifications

This repository adapts the original [netcheck](https://github.com/TristanBrotherton/netcheck) by [@TristanBrotherton](https://github.com/TristanBrotherton) to run fully containerized in Docker. All credit for the core functionality goes to the original author.

Changes made for Docker compatibility:

### Modified files from the original project:
- **`netcheck.sh`**
  - **Python 2 fix:** Changed  
    `python -m SimpleHTTPServer $1 0.0.0.0` → `python -m SimpleHTTPServer $1`  
    (Python 2 binds to all interfaces by default)
  - **Python 3 fix:** Changed  
    `python3 -m http.server $1 0.0.0.0` → `python3 -m http.server $1 -b 0.0.0.0`  
    (Python 3 requires explicit bind address via `-b`)
- **`log/index.html`**

### New files added:

- **`Dockerfile`**  
  Defines how the Docker image is built:
  - Based on `alpine:latest`
  - Installs dependencies: `bash`, `curl`, `iputils`, `python3`, `tzdata`
  - Adds `speedtest-cli.py`
  - Copies all relevant files (scripts, HTML, JS, fonts)
  - Sets `ENTRYPOINT` to `docker-entrypoint.sh`

- **`docker-entrypoint.sh`**  
  Entry script for the Docker container. Passes Docker environment variables into the `netcheck.sh` script.

- **`docker-compose.yml`** *(optional)*  
  Configuration for running the container via Docker Compose, including ports, environment variables, and container name.

- **`log/styles.css`**
  - Custom CSS styling added for the `index.html` page served by the Python web server.

### 🗂️ Static web files (copied from or based on original project)

- `log/index.html` *(modified)*
- `log/js/`
- `log/fonts/`
- `log/styles.css` *(new)*

These files are copied into the image and served via Python’s built-in HTTP server.
These changes aim to make `netcheck` easily deployable in containerized environments such as Docker and Portainer.

