FROM ruby:2.5.3

COPY . .

EXPOSE 3000
CMD ["rails", "s"]