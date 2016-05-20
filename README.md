

cmake .
make shell

Then add to your .bashrc/.zshrc

DEVSHELL_CONTAINER_NAME=devshell
DEVSHELL_TAG="cloudav/devshell"

function shell() {
  netname=default
  if [ -n "$1" ]
  then
    netname=$1
  fi

  docker run \
    --privileged \
    --rm=true \
    --name=${DEVSHELL_CONTAINER_NAME} \
    -P=true \
    --net=${netname} \
    -u root:root \
    -v ${HOME}/.ssh:/root/.ssh \
    -v ${HOME}/.vim:/root/.vim \
    -v ${HOME}/.vimrc:/root/.vimrc \
    -v ${HOME}/.antigen:/root/.antigen \
    -v ${HOME}/.zshrc:/root/.zshrc \
    -v ${HOME}/.zshenv:/root/.zshenv \
    -v `pwd`:/root/workhome \
    -w /root/workhome \
    -it ${DEVSHELL_TAG} /root/startup.sh
}


function shell-join {
  docker exec -ti ${DEVSHELL_CONTAINER_NAME} /bin/zsh
}


This assume that you have zsh as a shell,
vim and antigen installed


Open a new shell
Go to the directory you mount in your container
type 
shell

you should have your shell setup like on your regular machine but this time within a docker container.

so all commands like apt-get, wget, curl will work....