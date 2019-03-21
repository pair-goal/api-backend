FROM ruby:2.5.3

RUN apt-get update
RUN apt-get install default-libmysqlclient-dev

COPY . .
RUN bundle install --path ./gem
RUN bundle update rails
RUN bundle remove mysql2
RUN gem install mysql2
RUN bundle remove puma
RUN gem install puma

EXPOSE 3000
CMD ["bundle", "exec", "bin/rails", "s", "-b", "0.0.0.0"]