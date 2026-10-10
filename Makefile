.PHONY: build serve check test test-smoke clean
IYI = IYI_CACHE_DIR=$(CURDIR)/.cache iyi
# Generates the static site into site/ (or OUT=dir) from data/catalog.toml.
build:
	mkdir -p bin
	$(IYI) build src/build.iyi -o bin/build --no-color
	./bin/build
# Local preview of the generated site at http://127.0.0.1:3000.
serve: build
	$(IYI) build src/serve.iyi -o bin/serve --no-color
	./bin/serve
check:
	$(IYI) check src/build.iyi --no-color
	$(IYI) check src/serve.iyi --no-color
	$(IYI) check src/smoke.iyi --no-color
	$(IYI) check src/slang_check.iyi --no-color
test:
	mkdir -p bin
	$(IYI) build src/slang_check.iyi -o bin/slang_check --no-color
	./bin/slang_check
	$(IYI) build src/check.iyi -o bin/check --no-color
	./bin/check
test-smoke:
	mkdir -p bin
	$(IYI) build src/build.iyi -o bin/build --no-color
	$(IYI) build src/smoke.iyi -o bin/smoke --no-color
	./bin/smoke
clean:
	rm -rf bin/build bin/serve bin/check bin/slang_check bin/smoke .cache site
