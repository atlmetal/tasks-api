# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails 7.1 API-only application for managing tasks (CRUD). Ruby 3.0.6, SQLite3 database, Puma web server. Uses Prometheus exporter middleware for metrics.

## Common Commands

```bash
# Install dependencies
bundle install

# Database setup / reset
bin/rails db:create db:migrate
bin/rails db:seed

# Run the server (default port 3000)
bin/rails server

# Run all tests
bundle exec rspec

# Run a single test file
bundle exec rspec spec/requests/tasks_spec.rb

# Run a specific test by line number
bundle exec rspec spec/requests/tasks_spec.rb:13

# Rails console
bin/rails console
```

## Architecture

- **API-only mode** (`config.api_only = true`) — no views, sessions, or cookies. Controllers inherit from `ActionController::API`.
- **Single resource**: `Task` model with `title` (string, required, 3-100 chars), `description` (text), `completed` (boolean, required). Scopes: `Task.pending`, `Task.done`.
- **Routes**: `resources :tasks` — standard RESTful routes, JSON responses only.
- **Error responses**: Validation errors return `{ errors: [...] }` with 422. Not-found returns `{ error: "Tarea no encontrada" }` with 404.
- **Metrics**: Prometheus exporter middleware is wired in via `config/initializers/prometheus.rb` using `PrometheusExporter::LocalClient`.

## Testing

- RSpec with FactoryBot. Factories in `spec/factories/`.
- Request specs in `spec/requests/`, model specs in `spec/models/`.
- SimpleCov is configured in `spec/requests/tasks_spec.rb` with 80% minimum coverage.
- Test descriptions and error messages are in Spanish.
