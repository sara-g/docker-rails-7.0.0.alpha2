# Docker with Rails 7

1. Clone repo and rename new folder to project name [$ git clone repo-name folder-name]

2. (optional) Open project in editor and rename all instances of 'myapp' to the project name.

3. Create a new rails 7 app 
``$ docker-compose run --no-deps web rails new . --force --database=postgresql``

4. Build the image
`` $ docker-compose build ``

5. Replace database.yml with this (but change myapp to the project name):

```
  default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: 5

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test
```

 6. Start containers
 ``$ docker-compose up``
 
 7. Create the database
 `` $ docker-compose run web rake db:create ``
  

