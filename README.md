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


## Configuration

* Use LDAP for authentication: `-v /path/to/jaas-ldap.conf:/etc/rundeck/jaas-ldap.conf -e LDAP_CONFIG_PATH=/etc/rundeck/jaas-ldap.conf`
* Supply a custom `admin.aclpolicy`: `-v /path/to/policy/on/host.aclpolicy:/etc/rundeck/admin.aclpolicy`
