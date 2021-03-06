FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y -qq clean && apt-get -y -qq update
RUN apt-get -y -qq install locales zsh && chsh -s /usr/bin/zsh
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales

RUN apt-get -y -qq install openssh-server curl xz-utils
RUN echo 'root:pw' | chpasswd
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
EXPOSE 3000
EXPOSE 5000

RUN apt-get install ca-certificates && \
  cd /usr/local/share/ca-certificates && \
  mkdir ge && \
  cd ge && \
  curl https://static.gecirtnotification.com/browser_remediation/packages/GE_External_Certificate1.cer > GE_External_Certificate1.cer && \
  curl https://static.gecirtnotification.com/browser_remediation/packages/GE_External_Certificate2.cer > GE_External_Certificate2.cer && \
  update-ca-certificates -v

RUN apt-get -y -qq install build-essential libcorelinux-dev golang \
      libboost-system-dev libdouble-conversion-dev libjemalloc-dev libssl-dev libevent-dev libxml-libxml-perl \
      liblzma-dev libjemalloc1 libjemalloc-dev libsodium-dev gdb cgdb valgrind libunwind8 libunwind-dev libunwind8-dev \
      libelf-dev libdwarf-dev libiberty-dev

RUN apt-get -y -qq install clang-3.8 libc++abi1 libc++1 libc++abi-dev libc++-dev
#RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-3.8 100
#RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-3.8 100

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EEA14886  && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-get update -qq -y && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  apt-get install -y -qq oracle-java8-installer maven

RUN apt-get -y -qq install libc-dev libc6-dev libtool autotools-dev automake pkg-config
RUN apt-get -y -qq install python libboost1.58-all-dev libboost1.58-all python-pip python3-pip python-all-dev python3-all-dev build-essential
RUN pip install --upgrade pip
RUN pip install virtualenv virtualenvwrapper pydevd
RUN apt-get -y -qq install git google-mock libgflags-dev libgtest-dev libgoogle-glog-dev

RUN  cd / && \
       git clone https://github.com/vim/vim.git && \
       cd vim && \
       ./configure --prefix=/usr \
       --with-features=huge \
       --enable-multibyte \
       --enable-rubyinterp \
       --enable-pythoninterp \
       --with-python-config-dir=/usr/lib/python2.7/config \
       --enable-perlinterp \
       --enable-luainterp \
       --enable-cscope --prefix=/usr && \
       make install && \
       rm -rf vim

ENV CMAKE_VERSION 3.9.2
RUN curl -LkO https://www.cmake.org/files/v3.9/cmake-$CMAKE_VERSION.tar.gz && \
  tar xfz cmake-$CMAKE_VERSION.tar.gz && \
  cd cmake-$CMAKE_VERSION && \
  ls && \
  ./configure --prefix=/usr && \
  make -j4 install && \
  cd / && \
  rm -rf cmake*

ENV NVM_DIR /root/.nvm
ENV NVM_VERSION 0.33.4
RUN mkdir -p /root/.nvm && \
      curl https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | zsh && \
      . $NVM_DIR/nvm.sh && \
      nvm install 6 && \
      nvm install 8 && \
      nvm alias default stable && \
      nvm use default

RUN mkdir -p /root/.vim/bundle && \
      mkdir -p /root/.vim/colors
COPY vimrc /root/.vimrc
COPY inkpot.vim /root/.vim/colors
RUN . $NVM_DIR/nvm.sh && \
      git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim && \
      vim --not-a-term +PluginInstall +qall && \
      /root/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --gocode-completer

RUN git clone https://github.com/google/googletest.git && \
      cd googletest && \
      mkdir .build && \
      cd .build && \
      cmake -DCMAKE_BUILD_TYPE=RELEASE /usr/src/gtest/ && \
      make && \
      mv libg* /usr/lib/ && \
      rm -rf /googletest

# RUN git clone https://github.com/gflags/gflags.git && \
#       mkdir gflags/build && \
#       cd gflags/build && \
#       cmake -DGFLAGS_NAMESPACE=google -DBUILD_SHARED_LIBS=on .. && \
#       make -j && make install && \
#       rm -rf /gflags

# RUN git clone https://github.com/google/glog.git && \
#       cd glog && \
#       git checkout tags/v0.3.5 && \
#       touch *.* && \
#       ./configure && \
#       make -j && \
#       make install && \
#       rm -rf /glog

# ENV CAPNP_VERSION 0.6.1
# RUN git clone https://github.com/sandstorm-io/capnproto.git && \
#       cd capnproto && \
#       git checkout v${CAPNP_VERSION} && \
#       cd c++ && \
#       autoreconf -i && \
#       ./configure && \
#       make -j6 check && \
#       make install && \
#       rm -f /capnp*

RUN git clone https://github.com/zaphoyd/websocketpp.git && \
      cd websocketpp && \
      git checkout tags/0.7.0 && \
      cmake . && \
      make -j && \
      make install && \
      rm -rf /websocketpp*

RUN git clone https://github.com/facebook/folly.git && \
      cd folly && \
      cd folly && \
      autoreconf -ivf && \
      ./configure && \
      make && \
      make install && \
      rm -rf /folly

ENV ZEROMQ_VERSION 4.1.6
RUN curl -OLk https://github.com/zeromq/zeromq4-1/releases/download/v$ZEROMQ_VERSION/zeromq-$ZEROMQ_VERSION.tar.gz && \
      tar xf zeromq-$ZEROMQ_VERSION.tar.gz && \
      cd zeromq-$ZEROMQ_VERSION && \
      ./configure && \
      make -j4 && \
      make install && \
      cd / && \
      rm -rf zeromq-$ZEROMQ_VERSION*

RUN git clone https://github.com/miloyip/rapidjson && \
      cd rapidjson && \
      cmake . && \
      make -j && \
      make install && \
      cd / && \
      rm -rf rapidjson

RUN git clone https://github.com/oktal/pistache.git && \
      cd pistache && \
      git submodule update --init && \
      mkdir build && cd build && \
      cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release .. && \
      make -j4 && \
      make install && \
      cd / && \
      rm -rf pistache

RUN mkdir -p $HOME/.config/pip
COPY pip.conf $HOME/.config/pip/pip.conf
RUN pip3 install posix_ipc ipdb
# RUN pip3 install posix_ipc pycapnp ipdb

RUN mkdir /root/bin/ && curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > /root/bin/antigen.zsh

RUN wget -q --no-check-certificate "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github-rel" -O cli.tar.gz && \
      tar xfz cli.tar.gz -C /bin/ && \
      rm -rf cli.tar.gz

RUN apt-get -y -qq clean && \
  rm -rf /var/lib/apt/lists/*

COPY zshrc /root/.zshrc

RUN . $NVM_DIR/nvm.sh && \
  npm install -g yarn && \
  yarn config set strict-ssl "" && \
  yarn global add bower grunt-cli gulp jspm nodemon yo node-gyp

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

