.PHONY: build image serve update check test test-smoke clean
IYI = IYI_CACHE_DIR=$(CURDIR)/.cache iyi
IMAGE ?= ghcr.io/domify/iyipacks-website:latest
# .env, kept out of git, may hold GITHUB_TOKEN=… for make update.
-include .env
export GITHUB_TOKEN
# Generates the static site into site/ (or OUT=dir) from data/catalog.toml.
build:
	mkdir -p bin
	$(IYI) build src/build.iyi -o bin/build --no-color
	./bin/build
# Build the local Podman image used by Meridian's incremental transfer.
image:
	$(MAKE) build OUT=site
	podman build -f Containerfile -t $(IMAGE) .
# Local preview of the generated site at http://127.0.0.1:3000.
serve: build
	$(IYI) build src/serve.iyi -o bin/serve --no-color
	./bin/serve
# Finds the iyi modules on GitHub and writes data/modules.toml; set
# GITHUB_TOKEN, here or in .env, for code search and a higher rate limit.
update:
	mkdir -p bin
	$(IYI) build src/update.iyi -o bin/update --no-color
	./bin/update
check:
	$(IYI) check src/build.iyi --no-color
	$(IYI) check src/serve.iyi --no-color
	$(IYI) check src/smoke.iyi --no-color
	$(IYI) check src/update.iyi --no-color
test:
	mkdir -p bin
	$(IYI) build src/check.iyi -o bin/check --no-color
	./bin/check
test-smoke:
	mkdir -p bin
	$(IYI) build src/build.iyi -o bin/build --no-color
	$(IYI) build src/smoke.iyi -o bin/smoke --no-color
	./bin/smoke
clean:
	rm -rf bin/build bin/serve bin/check bin/smoke bin/update .cache site
