#!/usr/bin/env sh

docker-compose stop
docker-compose run web rails assets:precompile
heroku container:push web --app sms-campaign
heroku run rails db:migrate --app sms-campaign
