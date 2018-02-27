# How to setup the environment

To startup this thing your will first need three things:

 - A Redis server for enque URls for scalper or download
 - A Postgres server for save data got from pages after scalped
 - A Selenium server for scalper data from URLs on Redis queue

## Redis

Just startup a Redis server and we are done.

```
docker run --name redis4 -p 6379:6379 -d redis:4
```

## Postgresql

Startup a Postgres instanse.

```
```

If you use a remote install, setup a local to tunnel to sever

```
ssh -fN delicia@postges  -L 5432:localhost:5432
```
