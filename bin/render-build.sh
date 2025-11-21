#!/usr/bin/env bash
# exit on error
set -o errexit

echo "=== Starting Render Build Process ==="
echo "Ruby version: $(ruby -v)"
echo "Rails environment: $RAILS_ENV"

echo "=== Installing dependencies ==="
bundle install

echo "=== Precompiling assets ==="
bundle exec rails assets:precompile

echo "=== Creating database if it doesn't exist ==="
bundle exec rails db:create || echo "Database already exists"

echo "=== Running database migrations ==="
bundle exec rails db:migrate

echo "=== Seeding database ==="
bundle exec rails db:seed

echo "=== Checking database status ==="
bundle exec rails runner "puts 'Users count: ' + User.count.to_s"

echo "=== Build completed successfully ==="
