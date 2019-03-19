FROM ruby:2.5.3

RUN apt-get update

COPY ./Gemfile .
COPY ./Gemfile.lock .
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]