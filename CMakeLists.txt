cmake_minimum_required(VERSION 2.8)
SET(DEVSHELL_PATH ${CMAKE_CURRENT_SOURCE_DIR})
SET(DEVSHELL_TAG "cloudav/devshell")
SET(DEVSHELL_CONTAINER_NAME devshell)
SET(TAG_RELEASE "cloudav/devshell-package")
SET(no_proxy *.grc-apps.svc.ice.ge.com,predix.io,gecis.io,lattice.dev,*.dev,3.*,192.*,127.*,localhost,0.0.0.*)
SET(build_args --build-arg "http_proxy=$ENV{http_proxy}" --build-arg "https_proxy=$ENV{https_proxy}" --build-arg "no_proxy=$ENV{no_proxy}" )

add_custom_target(shell
  COMMAND docker build ${build_args} --tag=${DEVSHELL_TAG} .
  WORKING_DIRECTORY ${DEVSHELL_PATH})

add_custom_target(shell-noproxy
  COMMAND docker build --tag=${DEVSHELL_TAG} .
  WORKING_DIRECTORY ${DEVSHELL_PATH})

add_custom_target(packaging-devshell
  COMMAND rm -rf package
  COMMAND mkdir -p package/${DEVSHELL_CONTAINER_NAME}
  COMMAND docker run -t ${DEVSHELL_TAG} true
  COMMAND docker cp `docker ps -q -n=1`:/usr/local package/${DEVSHELL_CONTAINER_NAME}
  COMMAND docker rm -f `docker ps -q -n=1`
  COMMAND docker run -t ubuntu:16.04 true
  COMMAND for i in `ls package/${DEVSHELL_CONTAINER_NAME}/local/`\; do docker cp package/${DEVSHELL_CONTAINER_NAME}/local/$$i `docker ps -q -n=1`:/usr/local/\; done
  COMMAND docker export `docker ps -q -n=1` | docker import - ${TAG_RELEASE}
  COMMAND docker rm -f `docker ps -q -n=1`
  COMMAND docker images | grep ${TAG_RELEASE}
  COMMAND rm -rf package
  DEPENDS shell
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

