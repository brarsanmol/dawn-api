FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app/

COPY Gemfile /app/Gemfile
COPY Gemfile /app/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]