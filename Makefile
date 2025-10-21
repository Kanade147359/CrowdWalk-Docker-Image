IMAGE_NAME := crowdwalk-docker
DOCKER_CMD := docker run -it --rm -e DISPLAY=host.docker.internal:0 $(IMAGE_NAME)

all:
	docker build -t crowdwalk-docker .

.PHONY: run run_on_mac run_on_wsl

## メインターゲット（OS自動判別）
run:
	@OS=$$(uname); \
	if [ "$$OS" = "Darwin" ]; then \
		$(MAKE) run_on_mac; \
	elif grep -qi "microsoft" /proc/version; then \
		$(MAKE) run_on_wsl; \
	else \
		echo "Unsupported OS: $$OS"; \
		exit 1; \
	fi

## For Mac
run_on_mac:
	@echo "Running on macOS..."
	@xhost +localhost
        @XA=""; \
	if [ -f "$$HOME/.Xauthority" ]; then \
		XA="-v $$HOME/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority"; \
	fi; \
	docker run --rm -it \
		--add-host=host.docker.internal:host-gateway \
		-e DISPLAY=host.docker.internal:0 \
		$${XA} \
		$(COMMON_ENV) \
		$(IMAGE_NAME) \
		bash -lc 'cd /CrowdWalk/crowdwalk && sh quickstart.sh sample/stop-sample2/properties.json -g2 -lError'
	@xhost -

## For WSL
run_on_wsl:
	@echo "Running on WSL..."
	@docker run -it --rm \
		-e DISPLAY=$$DISPLAY \
		$(IMAGE_NAME)
