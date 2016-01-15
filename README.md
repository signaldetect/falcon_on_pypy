# RESTFul API with Falcon and PyPy

The example of using `Python3` + `PyPy` + `Falcon` + `RethinkDB` based on the
[Build massively scalable RESTFul API with Falcon and PyPy]
(https://impythonist.wordpress.com/2015/09/12/build-massively-scalable-restful-api-with-falcon-and-pypy/)
article.

## Installation

```
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ sudo nano /etc/apt/sources.list.d/docker.list
```

Add the following line into the file `docker.list` for Ubuntu Wily 15.10:

```
deb https://apt.dockerproject.org/repo ubuntu-wily main
```

For other OS please read the
[Install Docker Engine](https://docs.docker.com/engine/installation/)
documentation.

After that:

```
$ sudo apt-get update
$ sudo apt-get purge lxc-docker
$ sudo apt-get autoclean
$ sudo apt-get install linux-image-extra-$(uname -r)
$ sudo apt-get install docker-engine
$ sudo service docker start
$ cd falcon_on_pypy/
$ sudo docker build -t <your username>/falcon_on_pypy .
```

## Running

Start the Docker container via
`$ sudo docker run -p 49160:8888 -d <your username>/falcon_on_pypy` and then
open `http://127.0.0.1:49160/notes` in your browser.

## How to use

* add a new note:

```
$ curl -H "Content-Type: application/json" \
       -X POST -d '{"title": "...", "body": "..."}' \
       http://127.0.0.1:49160/notes
```

* fetch all notes: `$ curl http://127.0.0.1:49160/notes`
* fetch a note by id: `$ curl http://127.0.0.1:49160/notes?id=<note id>`
