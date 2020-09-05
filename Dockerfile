FROM ubuntu:latest
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:minetestdevs/stable
RUN apt-get install -y minetest-server
RUN apt-get install -y luarocks
RUN luarocks install luafilesystem
COPY cdworld /root/.minetest/worlds/cdworld
RUN echo "secure.enable_security = false" >> /root/.minetest/minetest.conf
ENTRYPOINT ["/usr/lib/minetest/minetestserver"]

