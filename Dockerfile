
FROM ubuntu:14.04.2
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -y install cmake python3 freeglut3-dev libxmu-dev libxi-dev git-all
RUN git clone --branch=master https://github.com/assimp/assimp.git assimp/assimp

RUN ls
WORKDIR /assimp/assimp
RUN ls

RUN cmake -G "Unix Makefiles" -DASSIMP_ENABLE_BOOST_WORKAROUND=YES

RUN generate \
    && make \
    && make install \
    && ldconfig \

CMD assimp -v