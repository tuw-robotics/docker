FROM tuw_docker:tuw_noetic_base

ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG MY_PASSWORD="xyz"
ENV MY_USER ${MY_USER}

ENV PROJECT_ROOT ${MY_HOME}/projects/iwos

USER root

RUN echo "${MY_USER}:${MY_PASSWORD}" | chpasswd
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

USER ${MY_USER}
RUN rosdep update

USER root
COPY ./src/setup_ws.sh   ${INSTALL_DIR}/setup_ws.sh
RUN chmod a+x ${INSTALL_DIR}/setup_ws.sh
RUN ${INSTALL_DIR}/setup_ws.sh

USER root
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash
