## 📝 Modifications

This project is based on the original [netcheck](https://github.com/TristanBrotherton/netcheck) by [@TristanBrotherton](https://github.com/TristanBrotherton).

Changes made for Docker compatibility:

### Modified files from the original project:
- **`netcheck.sh`**
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
