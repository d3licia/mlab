
# Meta's Laboratory

The 'Meta project' is a set tools for save content from imageboard.
This project was inspired in archives for 4Chan and 2Ch.

## Dependencies

Like a Rails project just use bundle to install dependencies.

```shell
bundle install
```

## Configurations

You will need also configure your database before do migration.

```shell
edit config/database.yml
```

Do the migrations to setup your database's schema

```shell
RAILS_ENV=production bundle exec rake db:create
rake db:migrate
```

## Running

You will need a redis server to enqueue URL of threads found in the catalog.

```sh
docker run --name redis4 -p 6379:6379 -d redis:4
```

Selenium is used open the pages protected by Cloudflare. It is slow but solve the problem.

```sh
sudo docker run -p 4444:4444 --name selenium-hub selenium/hub
sudo docker run --link selenium-hub:hub selenium/node-firefox
```

Monitor is a script used for search for new threads on catalog.

```sh
bundle exec bin/monitor
```

Executing enqueued tasks

```sh
QUEUE=* bundle exec rake resque:work
```
