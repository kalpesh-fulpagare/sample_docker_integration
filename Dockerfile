FROM ruby:2.6.3-stretch
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get update -qq && apt-get install -y postgresql-client nodejs
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

