# no buildin rules and variables
MAKEFLAGS =+ -rR --warn-undefined-variables

.PHONY: \
    build \
    run \
    clean

run:
	docker run -p 8080:80 -ti joblibminexample:latest


build:
	docker build -t joblibminexample -f Dockerfile .

