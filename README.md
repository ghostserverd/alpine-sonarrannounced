The first run of `fryfrog/sonarrannounced` will populate your `/config` folder with the sonarrAnnounced checkout and symlinks to the configuration file `settings.cfg` and the log file `status.log`. Later runs will attempt to `git pull --rebase` the checkout, to keep it up to date.

## Usage

```
docker run --rm \
	--name=sonarrannounced \
	-v <path to config>:/config \
	-e PGID=<gid> -e PUID=<uid>  \
	-e TZ=<timezone> \
	-p 3467:3467 \
	fryfrog/sonarrannounced
```

## Parameters

* `-p 3467:3467` - webui port
* `-v <path to config>:/config` - external storage for configuration
* `-e PGID=<gid>` for for GroupID - see below for explanation
* `-e PUID=<puid>` for for UserID - see below for explanation
* `-e TZ=America/Los_Angeles` - timezone

It is based on alpine-linux with S6 overlay, for shell access whilst the container is running do `docker exec -it sonarrannounced /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
Access the webui at `<your-ip>:3467`, for more information check out [sonarrannounced](https://github.com/fryfrog/alpine-sonarrannounced).

## Info

* To monitor the logs of the container in realtime `docker logs -f sonarrannounced`.
