# AMD/ROCm RainbowMiner docker image

## Quick setup

Ensure that the AMD Container Runtime is installed and set up: https://instinct.docs.amd.com/projects/container-toolkit/en/latest/container-runtime/quick-start-guide.html

### Docker compose (recommended):
```yaml
services:
  rainbowminer:
    image: leom0/rainbowminer-rocm:latest
    container_name: rainbowminer
    # environment:             # Enable this variable if you want to
      # - INTERACTIVE_CONFIG=y # configure RainbowMiner interactively
    volumes:
      - ./Bin:/RainbowMiner/Bin
      - ./Config:/RainbowMiner/Config
      - ./Logs:/RainbowMiner/Logs
    ports:
      - 4000:4000
    gpus: all
    runtime: amd
    security_opt:
      - seccomp=unconfined
    restart: unless-stopped
    stop_grace_period: 120s
```
Place your config file in `./Config` or set `INTERACTIVE_CONFIG=y` (see above) and run the script interactively:

`docker compose exec -it rainbowminer bash /RainbowMiner/start.sh`

### Docker run:

```bash
docker run -d \
  --name rainbowminer \
  --volume "rainbowminer-bin:/RainbowMiner/Bin" \
  --volume "rainbowminer-config:/RainbowMiner/Config" \
  --volume "rainbowminer-logs:/RainbowMiner/Logs" \
  --publish 4000:4000 \
  --gpus all \
  --runtime amd \
  --security-opt seccomp=unconfined \
  --restart unless-stopped \
  --stop-timeout 120 \
  leom0/rainbowminer-rocm:latest
```
