#!/bin/bash

# This will start and run the foreman container with a postgres container for testing.  The default database.yml is already in the base container for foreman
# We just start up the two containers, link them, and run some ruby commands to initialize the DB
# Once it starts, we drop into a log tail of the nginx error logs


#Start postgres
docker run --name foreman-postgres-test -p 5432:5432 -e POSTGRES_USER=foreman -e POSTGRES_PASSWORD=nLrTDsCEMAjjiwtnJJjjKpYf33VnL87R -d postgres:9.5

# Start Foreman - link to postgres
docker run --link foreman-postgres-test --name foreman-test -p8080:80 -d readytalk/foreman-docker:1.13.12-48637f3

# Give it a few seconds to start
sleep 30

# Run the db migrations and seed the db.  
docker exec -it foreman-test bundle exec rake db:migrate RAILS_ENV=production
docker exec -it foreman-test bundle exec rake db:seed RAILS_ENV=production
docker exec -it foreman-test bundle exec rake assets:precompile RAILS_ENV=production
docker exec -it foreman-test bundle exec rake locale:pack RAILS_ENV=production
docker exec -it foreman-test bundle exec rake webpack:compile RAILS_ENV=production

# Reset admin creds and then try to find them
docker exec -it foreman-test bundle exec rake permissions:reset RAILS_ENV=production
docker logs foreman-test | grep 'password:'

# fix for permissions that the migrations broke
docker exec -it foreman-test chown -R 9999:9999 /home/app/foreman/tmp

# start tailing the nginx error log
docker exec -it foreman-test tail -f /var/log/nginx/error.log
