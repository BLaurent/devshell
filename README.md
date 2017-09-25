#Build container
To build the container do :

    cmake .
    make shell

Be patient this can be long

#Configure
Then add to your __.bashrc/.zshrc__


    DEVSHELL_CONTAINER_NAME=devshell
    DEVSHELL_VERSION=latest
    DEVSHELL_TAG="blaurent/devshell:${DEVSHELL_VERSION}"

    function shell() {
      netname=default
      ipc=""

      if [ -n "$1" ]
      then
        netname=$1
      fi

      if [ -n "$2" ]
      then
        ipc=$2
      fi

      docker container run \
        --privileged \
        --rm=true \
        --name=${DEVSHELL_CONTAINER_NAME} \
        -P=true \
        -p 8889:5000\
        --ipc=${ipc} \
        --net=${netname} \
        -u root:root \
        -v ${HOME}/.ssh:/root/.ssh \
        -v ${HOME}/.vimrc:/root/.vimrc \
        -v ${HOME}/.zshrc:/root/.zshrc \
        -v ${HOME}/.zshenv:/root/.zshenv \
        -v ${HOME}/.antigen:/root/.antigen \
        -v `pwd`:/root/workhome \
        -w /root/workhome \
        -it ${DEVSHELL_TAG} /startup.sh
    }

    function shell-join {
      docker exec -ti ${DEVSHELL_CONTAINER_NAME} /bin/zsh
    }


# Pre-Requisite
This assume that you have zsh as a shell, vim and antigen installed.
By default you will mount into the container many .XXrc file to have the exact same config in your machine and in your docker container.

#Usage

Open a new shell
Go to the directory you mount in your container
type
  shell

you should have your shell setup like on your regular machine but this time within a docker container.

so all commands like apt-get, wget, curl will work....
