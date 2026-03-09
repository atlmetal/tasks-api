FROM ruby:3.3-slim
RUN apt-get update && apt-get install -y build-essential sqlite3 libsqlite3-dev libyaml-dev
WORKDIR /app
COPY Gemfile* .
RUN bundle install
COPY . .
RUN bundle exec rails db:create db:migrate
EXPOSE 3000 9394
CMD bash -c "bundle exec prometheus_exporter --bind 0.0.0.0 --port 9394 & bundle exec rails server -b 0.0.0.0"
