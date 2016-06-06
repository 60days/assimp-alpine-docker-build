
FROM ubuntu:14.04.2
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -y install cmake gcc build-essential zlib1g-dev g++ clang python3 freeglut3-dev libxmu-dev libxi-dev git-all
RUN git clone --branch=master https://github.com/assimp/assimp.git assimp/assimp

RUN ls
WORKDIR /assimp/assimp
RUN ls

RUN cmake -G "Unix Makefiles" -DASSIMP_ENABLE_BOOST_WORKAROUND=YES -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc

RUN make \
    && make install \
    && ldconfig 

ADD ./in /assimp/assimp/in
ADD ./out /assimp/assimp/out

VOLUME /in
VOLUME /out

#watch the in directory and run convertor on files found. output is sent to /out and original files are moved to /out also.
# iwatch doesnt seem to trigger on host-driven filesystem changes. Will look into later.
#CMD iwatch -c “assimp -f %f -o out/ -e  &amp; mv %f out/" in/


#for now we run as a one-off process on all the files in /in
#-f files -o outputlocation
#CMD find in/ -maxdepth 1 -type f -exec assimp -f {} -o out/ -e  \;

CMD assimp help