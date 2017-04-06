FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /sms_campaign
WORKDIR /sms_campaign
ADD Gemfile /sms_campaign/Gemfile
ADD Gemfile.lock /sms_campaign/Gemfile.lock
RUN bundle install
ADD . /sms_campaign
CMD bundle exec rails s -p ${PORT:-3000} -b '0.0.0.0'
