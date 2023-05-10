
## How to Run this docker

To run this project

```bash
  docker build -t apache2-basicauth .
  docker run -d -p 80:80 --name apache2-basicauth apache2-basicauth
```


## Environment Variables

Custom HTML Path Location:

`VOLUME: /path/to/html:/var/www/html`

Example

```bash
docker run -d -p 80:80 -v /path/to/html:/var/www/html --name apache2-basicauth apache2-basicauth
```

Custom Username & Password:

`AUTH_USERNAME` & 
`AUTH_PASSWORD`


Default Authentication:
`AUTH_USERNAME: username` `AUTH_PASSWORD: password`

Example
```bash
docker run -d -p 80:80 -v /path/to/html:/var/www/html -e AUTH_USERNAME=username -e AUTH_PASSWORD=password --name apache2-basicauth apache2-basicauth
```



## How to change the authentication of the existing container

You must to recreate the docker container with new username and password

```bash
docker rm $(docker ps -a -q --filter "name=apache2-basicauth")
docker run -d -p 80:80 -v /path/to/html:/var/www/html -e AUTH_USERNAME=username -e AUTH_PASSWORD=password --name apache2-basicauth apache2-basicauth
```


## Authors

- [@sudirmansyah](https://gitlab.com/sudirmansyah)

