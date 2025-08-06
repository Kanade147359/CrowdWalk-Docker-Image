all:
	docker build --no-cache -t crowdwalk-docker .

run:
	xhost + localhost
	docker run -it --rm -e DISPLAY=host.docker.internal:0 crowdwalk-docker
	xhost -
