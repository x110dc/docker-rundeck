#### Build:

```
docker build --tag="rundeck" .
```

or

```
make build
```

#### Run:

```
docker run --detach=true --publish=49440:4440 rundeck
```

or

```
make run
```

or

```
docker run --detach=true --publish=49440:4440 x110dc/docker-rundeck
```

(I like to use the long version of the parameters because it's easier for me remember what they mean.)
