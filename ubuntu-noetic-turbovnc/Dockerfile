FROM ubuntu:noetic

ENV INST_SCRIPTS=/tmp

USER root
RUN apt update 

ADD ./src/install_turbovnc.sh ${INST_SCRIPTS}/install_turbovnc.sh
RUN chmod a+x ${INST_SCRIPTS}/install_turbovnc.sh
RUN $INST_SCRIPTS/install_turbovnc.sh  

ADD ./src/setup_turbovnc.sh ${INST_SCRIPTS}/setup_turbovnc.sh
RUN chmod a+x ${INST_SCRIPTS}/setup_turbovnc.sh
USER ${MY_USER}
RUN $INST_SCRIPTS/setup_turbovnc.sh  
   
USER root
ADD ./src/install_ide.sh ${INST_SCRIPTS}/install_ide.sh
RUN chmod a+x ${INST_SCRIPTS}/install_ide.sh
RUN $INST_SCRIPTS/install_ide.sh  

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} /home/${MY_USER}

USER ${MY_USER}
WORKDIR /home/${MY_USER}
ENV HOME /home/${MY_USER}
CMD /bin/bash

