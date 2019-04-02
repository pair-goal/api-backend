FROM ruby:2.5.1

RUN apt-get update
RUN apt-get install default-libmysqlclient-dev

COPY . .
RUN bundle install --path ./gem

EXPOSE 3000
CMD ["bundle", "exec", "bin/rails", "s", "-b", "0.0.0.0"]