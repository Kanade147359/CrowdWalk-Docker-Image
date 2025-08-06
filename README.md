# CrowdWalk Docker Image

This repository provides a Docker image for running [CrowdWalk](https://github.com/crest-cassia/CrowdWalk), an agent-based pedestrian simulation platform originally released under the MIT License.

The Docker environment includes all necessary dependencies (OpenJDK, fonts, etc.) and supports both command-line and GUI execution.

---

## Quick Start

To run CrowdWalk with its GUI interface, you must have an X11 server running on your host system.

* macOS: [XQuartz](https://www.xquartz.org/)
* Windows: [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
* Linux: Native X11 server is typically available

Clone this repository and build the Docker image with:

```bash
git clone https://github.com/watanabe-appi/CrowdWalk-Docker-Image.git
cd CrowdWalk-Docker-Image
docker build -t crowdwalk-docker .
```

After building the Docker image, you can launch CrowdWalk using the following command:

```sh
make run
```

This will automatically detect your operating system and run the Docker container with the appropriate X11 settings.

Once the Docker container is running, you can start the simulation with the following command:

```sh
sh quickstart.sh sample/stop-sample2/properties.json -g2 -lError
```
This is a sample simulation of the movement of spectators returning home after watching the Kanmon Strait Fireworks Festival from the Mojiko side. On the first run, it may take several minutes to start, as the application downloads background map images.


## License
The original [CrowdWalk](https://github.com/crest-cassia/CrowdWalk) project is released under the MIT License.

This Dockerfile and supporting scripts are also licensed under the MIT License. See LICENSE for details.
