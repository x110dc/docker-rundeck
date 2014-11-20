This image on the [Docker Hub](https://registry.hub.docker.com/u/x110dc/rundeck/) so running it can be as
simple as:
```
docker run --detach=true --publish=4440:4440 --publish=4443:4443 \
  --env=MYHOST=foo.com \
  --env=RDPASS=mypassword \
  --env=MAILFROM=foo@bar.baz \
  x110dc/rundeck
```

If you want to build it yourself:
```
make build
```
