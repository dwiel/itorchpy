FROM       ubuntu:14.04

RUN apt-get -y update
run apt-get -y upgrade
run apt-get -y dist-upgrade
RUN apt-get -y install curl emacs bash git ipython

RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/dwiel/distro.git /opt/torch --recursive
RUN cd /opt/torch ; /opt/torch/install.sh

# TODO: maybe get rid of this by replacing sh with bash
ENV PATH /opt/toch/install/bin:${PATH}
ENV LD_LIBRARY_PATH /opt/torch/install/lib:${LD_LIBRARY_PATH}

RUN apt-get install -y python-dev 
RUN apt-get install -y python-pip
RUN pip install pyzmq
RUN pip install "ipython[notebook]" --upgrade

RUN apt-get install -y libgraphicsmagick1-dev
RUN apt-get install -y graphicsmagick
RUN apt-get install -y nodejs
RUN apt-get install -y nodejs-legacy
RUN apt-get install -y npm

# RUN /bin/bash --login -c "luarocks install gfx.js"

# ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}

# NOTE: this almost works.  soumith has disabled fb.python install which is exactly what we want
# and so that change needs to be reverted before running ...
RUN DATE=1 curl -sk https://raw.githubusercontent.com/dwiel/fblualib/master/install_all.sh | bash

# RUN curl -sk https://raw.githubusercontent.com/soumith/fblualib/master/install_all.sh | bash

EXPOSE 8888
