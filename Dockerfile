FROM ruby:2.6.5-alpine
RUN apk update && apk upgrade\ 
&& apk add --update --no-cache nodejs\
postgresql-dev build-base tzdata

WORKDIR /bookke
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
