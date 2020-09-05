FROM ubuntu:latest
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:minetestdevs/stable
RUN apt-get install -y minetest-server
EXPOSE 30000

cmd /usr/lib/minetest/minetestserver 
