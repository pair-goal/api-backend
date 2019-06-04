FROM ruby:2.5.1

RUN apt-get update
RUN apt-get install default-libmysqlclient-dev

COPY . .
RUN bundle install --path ./gem

EXPOSE 3000
RUN bundle exec sidekiq -d
RUN bundle exec rails redis_subscribe
CMD RAILS_ENV=production rails s