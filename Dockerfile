FROM ruby:2.5.3

RUN apt-get update

RUN mkdir app
WORKDIR /app

COPY ./Gemfile /app
COPY ./Gemfile.lock /app
RUN bundle install
COPY . /app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]