## TeamCity Server Image Dockerfile

This project contains the Dockerfile and all necessary scripts to build the Docker image and run a TeamCity server inside the container.
This image is not the same than the official, it rely on fedora, openJDK and automatically install pgsql driver.

You can pull the official ready-to-use image from the Docker Hub repository
                                     
`docker pull jetbrains/teamcity-server`

If you need to build your own image, you need to perform the following:

   ```
    docker build -t lpp/teamcity-server .
   ```

Use the following command to start a container

``` 
docker run -it --name teamcity-server-instance  \
    -v <path to data directory>:/data/teamcity_server/datadir \
    -v <path to logs directory>:/opt/teamcity/logs  \
    -v <path to ssl certs directory>:/certs  \
    -p <port on host>:8111 \
    lpp/teamcity-server
```

See [detailed instructions](https://hub.docker.com/r/jetbrains/teamcity-server/) on how to use the image in the Docker Hub repository .
