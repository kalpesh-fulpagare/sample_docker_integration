FROM ruby:2.6.3-stretch
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails_devise_docker
WORKDIR /rails_devise_docker
COPY Gemfile /rails_devise_docker/Gemfile
COPY Gemfile.lock /rails_devise_docker/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /rails_devise_docker

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

