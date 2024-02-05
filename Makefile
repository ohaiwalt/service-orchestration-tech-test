build:
	docker build -t pw/crudservice:latest ./service/

## The run command will start the container, but as written it will fail to start because
## configuration file is missing, and application will not receive external network connections.
# run: build
# 	docker run -it --rm --name pwcrudservice #Missing additional parameters
