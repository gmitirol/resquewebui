# PHP-Resque Web UI on docker

This docker image provides a minimalistic Symfony3 application for the [PHP-Resque web interface](https://github.com/xelan/resque-webui-bundle)

## Redis configuration

To override the default redis settings, you need to map your custom [`redis.yml`](app/config/resque.yml) in the container.
Consult the Docker Compose example below for more information.

## Run container

### Pull

```bash
docker pull gmitirol/resquewebui
```

### Docker CLI

```bash    
docker run --rm -p 80:80 --name resquewebui gmitirol/resquewebui
```

### Docker Compose

```yml
version: '2'
services:
  resquewebui:
    image: gmitirol/resquewebui
    ports:
      - "80:80"
    volumes:
      - /srv/resquewebui/resque.yml:/var/www/project/app/config/resque.yml
```

## Proxy

The image just provides a minimalistic Symfony3 application for the resque web interface.
To add TLS encryption or authentication, please use a web proxy in front of it.

i.e. `jwilder/nginx-proxy` with `jrcs/letsencrypt-nginx-proxy-companion`:

```bash
...
    environment:
      - VIRTUAL_HOST=resque.example.com
      - VIRTUAL_PORT=80
      - LETSENCRYPT_HOST=resque.example.com
      - LETSENCRYPT_EMAIL=someone@example.com
...
```

## License

Licensed under [MIT License](LICENSE).
