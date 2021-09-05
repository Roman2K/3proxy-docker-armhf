set -e
export DOCKER_HOST=ssh://rpi
docker build --platform linux/arm/v7 -t 3proxy .
