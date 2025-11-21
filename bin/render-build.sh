#!/usr/bin/env bash
# exit on error
set -o errexit

# Build commands for Render deployment
echo "=== Installing dependencies ==="
bundle install

echo "=== Precompiling assets ==="
bundle exec rails assets:precompile

echo "=== Running database migrations ==="
bundle exec rails db:migrate

echo "=== Seeding database (if needed) ==="
bundle exec rails db:seed

echo "=== Build completed successfully ==="
