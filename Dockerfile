# FROM maven:latest
# RUN apt-get update && apt-get install vim tree less -y
#
# # RUN git clone https://github.com/scribble/scribble-java.git \
# COPY . /scribble-java
# RUN cd scribble-java \
#     && mvn install -Dlicense.skip=true \
#     && mv scribble-dist/target/scribble-dist* /
# RUN unzip scribble-dist*
# RUN cp scribble-java/scribble-core/src/test/scrib/tmp/Test.scr .
# RUN chmod 755 scribblec.sh
#
# ENTRYPOINT ["/bin/bash"]

FROM maven:latest
RUN yum install -y unzip
RUN yum install -y vim-enhanced
# RUN ["/usr/local/Homebrew/bin/brew", "update"]
# RUN ["/usr/local/Homebrew/bin/brew", "install vim"]
# RUN brew update && brew install vim
# RUN apt-get update && apt-get install vim tree less -y

# RUN git clone https://github.com/scribble/scribble-java.git \
COPY . /scribble-java
RUN cd scribble-java \
    && mvn install -Dlicense.skip=true \
    && mv scribble-dist/target/scribble-dist* /
# ENTRYPOINT ["/usr/bin/unzip"]
# CMD ["scribble-dist-0.4.4-SNAPSHOT.zip"]
RUN unzip scribble-dist*
RUN cp scribble-java/scribble-core/src/test/scrib/tmp/Test.scr .
# RUN ["/usr/bin/tree"]
RUN ls /usr/bin
RUN chmod 755 scribblec.sh

ENTRYPOINT ["/bin/bash"]
