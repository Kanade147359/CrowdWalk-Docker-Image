# CrowdWalk Docker Image

This repository provides a Docker image for running [CrowdWalk](https://github.com/crest-cassia/CrowdWalk), an agent-based pedestrian simulation platform originally released under the MIT License.

The Docker environment includes all necessary dependencies (OpenJDK, fonts, etc.) and supports both command-line and GUI execution.

---

## How to Build

Clone this repository and build the Docker image with:

```bash
docker build -t crowdwalk-docker .
```

## How to Run (with GUI)

To run CrowdWalk with its GUI interface, you must have an X11 server running on your host system.

* macOS: [XQuartz](https://www.xquartz.org/)
* Windows: [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
* Linux: Native X11 server is typically available

Then run the following commands:

```sh
xhost + localhost
docker run --rm -e DISPLAY=host.docker.internal:0 crowdwalk-docker
```

Note: You may need to adjust DISPLAY depending on your platform or environment.

## Alternative: Using Makefile

This image also supports a Makefile-based workflow:

```sh
make        # Builds the application (runs Gradle inside the container)
make run    # Runs the application
```

## License
The original [CrowdWalk](https://github.com/crest-cassia/CrowdWalk) project is released under the MIT License.

This Dockerfile and supporting scripts are also licensed under the MIT License. See LICENSE for details.
