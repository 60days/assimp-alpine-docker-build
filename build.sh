docker build -t bferns/assimp .
docker run -v `pwd`/out:/home/out -w /out -t bferns/assimp