FROM ubuntu:latest
RUN apt-get update && apt-get install -y software-properties-common
RUN echo "deb http://cz.archive.ubuntu.com/ubuntu groovy main universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y minetest-server
RUN apt-get install -y luarocks
RUN luarocks install luafilesystem
RUN mkdir /users
ENTRYPOINT ["/usr/lib/minetest/minetestserver"]

