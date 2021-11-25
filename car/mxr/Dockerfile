FROM robotics:base

ARG PRJ_DIR=${MY_HOME}/projects
ARG INSTALL_PREFIX=/opt/mx

ENV PRJ_DIR=${PRJ_DIR}
ENV INSTALL_PREFIX=${INSTALL_PREFIX}

USER root
RUN apt-get update
RUN apt-get install -y libncurses5-dev

RUN mkdir -p ${PRJ_DIR}
COPY ./utils/car.tar.gz ${PRJ_DIR}/
RUN cd ${PRJ_DIR}/ &&  \
	tar -xzvf car.tar.gz
	
RUN sh -c "echo ${INSTALL_PREFIX}/lib > /etc/ld.so.conf.d/mxr.conf" && \ 
    ldconfig

RUN mkdir ${PRJ_DIR}/car/lib/mx_joystick/build && \
    cd ${PRJ_DIR}/car/lib/mx_joystick/build && \
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} ..  && \
    make install
    
RUN mkdir ${PRJ_DIR}/car/lib/mx_objects/build && \
    cd ${PRJ_DIR}/car/lib/mx_objects/build && \
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} ..  && \
    make install
    
RUN mkdir ${PRJ_DIR}/car/lib/car_com/build && \
    cd ${PRJ_DIR}/car/lib/car_com/build && \
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} ..  && \
    cmake ..  && \
    make install
    

ADD ./src/setup_ws.sh   ${INST_SCRIPTS}/setup_ws.sh  
RUN chmod a+x ${INST_SCRIPTS}/setup_ws.sh
USER ${MY_USER}
RUN $INST_SCRIPTS/setup_ws.sh  

    
# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

