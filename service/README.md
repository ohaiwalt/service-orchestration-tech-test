# PW CRUD Service

This is a very simple python web app that presents get, set, and delete endpoints that pass through to redis. This application depends on Redis, which is not included.

## Configuration

This application expects a file called `service.cfg` in the same directory the service is run from. There are only
two values for connecting to Redis: the host and the port. It has this format. like this:
```
[redis]
host = "localhost"
port = 6379
```
The values of each of those variables may need to change depending on your implementation.

## API Description

The service has 4 endpoints.

* GET `pw/`: Returns a static string response with a 200 status code. 
* GET `pw/<key>`: Get `key` from redis or 404 error if not found
* POST `pw/<key>/<val>`: Sets the passed in `key` to the passed in `value`
* DELETE `pw/<key>`: Delete `key` from redis.

### Testing

Swagger UI is available on the service and is located at the `docs` URL path once the service is running. So if the service is running on localhost on port 8000, the url for swagger would be `http://localhost:8000/docs`.

## Docker

The included Dockerfile is sufficient to run this service for the purposes of the test. You are welcome to make changes to support tools you want to use, but do not add config files or configuration related environment variables to the Dockerfile.
