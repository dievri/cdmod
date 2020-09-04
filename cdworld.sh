# delete old world
rm /home/dievri/.minetest/worlds/cdworld/map.sqlite


# start server
minetestserver --worldname cdworld --port 3004 --logfile /var/log/minetest/minetest.log

