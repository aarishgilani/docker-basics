# Base layer initialisation. Choose a base image from the available based images on docker server
FROM node:latest

# We define working directory inside the docker container
# This will be created for us if it does not already exsist
WORKDIR /home/server

# This are the commands the docker will run after initialization
# Here we are installing a npm package called json-server
RUN npm install -g json-server

# This command takes two attributes, it copies the files from the host machine to the docker container
# Here we are copying the file called db.json from the host machine to /home/server/db.json inside the docker container
COPY db.json /home/server/db.json

COPY alt.json /home/server/alt.json

# This takes in a port number and maps a connection from our host machine to the docker container
# While running this image in a container use docker run --rm -p hostmachineport:dockercontainerport(3000)
EXPOSE 3000

# This is what the whole docker container is built for. These commands cannot be altered by the host machine
# Entry point runs the commands in the shell format, i.e it runs the commands as /bin/sh -c
# To run the command as it is we make it into an array. This will avoid it running with /bin/sh -c
# 0.0.0.0 is the default docker bridge network id for our host machine
# We define this because json by default spins up a server on localhost
ENTRYPOINT ["json-server", "--host", "0.0.0.0"]

# Commands can be added to the entrypoint using CMD
# While you cannot edit the commands in entry point from your host machine
# You can override the cmd commands by passing in extra attribute while running docker container form terminalgit 
CMD ["db.json"]