## TeamCity Server Image Dockerfile

This project contains the Dockerfile and all necessary scripts to build the Docker image and run a TeamCity server inside the container.
This image is not the same than the official, it rely on fedora, openJDK and automatically install pgsql driver.

You can pull the official ready-to-use image from the Docker Hub repository
                                     
`docker pull jetbrains/teamcity-server`

If you need to build your own image, you need to perform the following:

   ```
    docker build -t teamcity-server
   ```

See [detailed instructions](https://hub.docker.com/r/jetbrains/teamcity-server/) on how to use the image in the Docker Hub repository .
