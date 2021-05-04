# Composer - How To Code Well

This creates a Composer Docker image that has some PHP extensions configured. 
Each Docker tag will follow PHP versions. 

See all available tags on the [Docker Hub](https://hub.docker.com/repository/docker/howtocodewell/composer/tags)

## To build locally
`docker build -t howtocodewell/composer:<TAG> .`

## To use this within your current project
Add this to your `docker-compose.yml`

```yaml
  composer:
    image: howtocodewell/composer:<TAG>
    working_dir: /var/www/html
    volumes:
      - .:/app
```

# Useful commands
Pro tip! These are great in a Makefile

Check for Composer updates

`docker-compose run --rm -w /app --no-deps composer bash -ci 'composer update'`

Install Composer packages

`docker-compose run --rm -w /app --no-deps composer bash -ci 'composer install'`

Update Composer packages

`docker-compose run --rm -w /app --no-deps composer bash -ci 'composer update'`
