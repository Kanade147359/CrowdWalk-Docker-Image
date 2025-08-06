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
	@docker run -it --rm \
		-e DISPLAY=host.docker.internal:0 \
		$(IMAGE_NAME)
	@xhost -

## For WSL
run_on_wsl:
	@echo "Running on WSL..."
	@docker run -it --rm \
		-e DISPLAY=$$DISPLAY \
		$(IMAGE_NAME)
