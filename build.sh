#!/bin/bash
# =============================================================================
#  This script builds docker image of docker-compose for ARMv6l (arm32v6), such
#  as RaspberryPi Zero W.
#
#  Tested only on:
#    Raspberry Pi: Zero W / Model: BCM2835 /Revision: 9000c1
#    Raspbian Linux v9 Stretch Lite / Docker v18.06.2-ce
# =============================================================================

set -eu

URL_GIT_COMPOSE='https://github.com/docker/compose.git'

NAME_FILE_DOCKER_ARM32V6='Dockerfile.arm32v6'
NAME_DIR_GIT_COMPOSE='docker-compose'
NAME_TAG_IMAGE='keinos/docker-compose:arm32v6'

PATH_DIR_CURRENT=$(cd $(dirname $0); pwd)
PATH_DIR_GIT_COMPOSE="${PATH_DIR_CURRENT}/${NAME_DIR_GIT_COMPOSE}"

# Change working directory to this script
cd $PATH_DIR_CURRENT

# Check submodule of docker/compose
echo -n '- Check Sub-Module: '
if [ ! -d $PATH_DIR_GIT_COMPOSE ]; then
   echo 'Not found.'
   echo '- Cloning submodule ... '
   # Clone as submodule
   git submodule add --force $URL_GIT_COMPOSE "./${NAME_DIR_GIT_COMPOSE}"
fi
echo 'Submodule found.'

echo '- Pulling submodule from origin:'
git submodule init && \
git submodule update

echo '- Start building:'
cd $PATH_DIR_CURRENT && \
sudo docker build -t $NAME_TAG_IMAGE -f $NAME_FILE_DOCKER_ARM32V6 "./${NAME_DIR_GIT_COMPOSE}"

echo '- Creating docker-compose runner script:'
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.1/run.sh -o ./run.sh
cat ./run.sh | sed -E "s/^VERSION=\"[0-9\.]+\"/VERSION=\"arm32v6\"/" | sed -E "s/^IMAGE=\"docker\/compose/IMAGE=\"keinos\/docker-compose/" | sudo tee ./run.sh > /dev/null
