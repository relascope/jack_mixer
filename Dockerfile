FROM gcc:7

RUN apt-get -y update
RUN apt-get -y install apt-utils sudo

# Build requirements
RUN apt-get -y install python-fpconst python-gtk2 python-dev libjack-jackd2-dev

# Runtime requirements
RUN DEBIAN_FRONTEND='noninteractive'  apt-get install -y jackd2

# User Management for Display
# Replace with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "develoer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    usermod -a -G audio developer

RUN apt-get clean
RUN apt-get -y autoremove

USER developer
ENV HOME /home/developer
WORKDIR /home/developer