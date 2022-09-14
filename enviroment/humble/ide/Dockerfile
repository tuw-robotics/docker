# enviroment ide
# created by Markus Bader <markus.bader@tuwien.ac.at>
# created by Eugenn Kaltenegger <eugen.kaltenegger@tuwien.ac.at>

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/noetic
ARG BASE_CONTAINER=$OWNER-enviroment-desktop
FROM $BASE_CONTAINER

ENV SCRIPTS_DIR=./scripts
ENV INSTALL_DIR=/install

USER root

RUN apt-get update 

# copy scripts to container
COPY ${SCRIPTS_DIR}/ ${INSTALL_DIR}/
# allow to run scripts in the container
RUN chmod -R a+x ${INSTALL_DIR}

# install Code (optinal: argument install_code)
ARG INSTALL_CODE=true
RUN if [ "$INSTALL_CODE" = "true" ]; then $INSTALL_DIR/install/ide/install_code.sh; fi
# install KDE-Develop (optinal: argument install_kdevelop)
ARG INSTALL_KDEVELOP=false
RUN if [ "$INSTALL_KDEVELOP" = "true" ]; then $INSTALL_DIR/install/ide/install_kdevelop.sh; fi

USER root
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
CMD /bin/bash
