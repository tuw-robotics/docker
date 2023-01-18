
ARG VERSION=jammy
ARG DISTRO=ubuntu
ARG ROOT_CONTAINER=$DISTRO:$VERSION
FROM $ROOT_CONTAINER

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="password"
ARG MY_UID=1000
ARG MY_GID=1000
ARG TZ=Europe/Vienna

ENV MY_USER=${MY_USER}
ENV MY_HOME=/home/${MY_USER}

USER root

RUN apt-get update && apt-get -y upgrade

# Install locale and set
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y locales apt-utils
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen; locale-gen


RUN apt-get install -y apt-utils sudo bash-completion
RUN groupadd -g ${MY_GID} ${MY_USER}   && \
    useradd -m -s /bin/bash  -u ${MY_UID} -g ${MY_GID} ${MY_USER}   && \
    export uid=${MY_UID} gid=${MY_GID}   && \
    usermod -aG sudo ${MY_USER}   && \
    usermod -aG dialout ${MY_USER}  && \
    echo "${MY_USER}:${MY_PASSWORD}" | chpasswd  && \
	sed -i 's/HISTSIZE=1000/HISTSIZE=20000/g' ${MY_HOME}/.bashrc  && \
	sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=40000/g' ${MY_HOME}/.bashrc  && \
	touch ${MY_HOME}/.sudo_as_admin_successful


USER ${MY_USER}
ENV TERM xterm-256color
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
CMD /bin/bash
