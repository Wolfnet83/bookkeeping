# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Running the App

```bash
# Docker (recommended)
docker compose up

# Local
bin/setup       # Install deps & set up database
bin/rails s     # Start server
bin/rails c     # Rails console
```

App runs on port 3000. Default seed credentials: `andrey.volcov@gmail.com` / `11111111`.

### Testing

```bash
bundle exec rspec                                  # All specs
bundle exec rspec spec/models/account_spec.rb      # Single file
bundle exec rspec spec/models/account_spec.rb:42   # Single example
```

## Architecture

**Rails 5.2.6** personal finance app backed by PostgreSQL. Frontend uses HAML templates, SCSS, jQuery, and Bootstrap 3. Authentication via Devise. Russian is the default locale (`:ru`).

### Domain Models

Seven core resources (routes and models): `users`, `accounts`, `transactions`, `categories`, `transfers`, `currencies`, `planned_fees` (with `planned_fee_templates`).

All resources are scoped to `current_user` — every controller starts with `before_action :authenticate_user!` and queries filter by user.

### Key Patterns

**Dual-currency storage**: Amounts are stored in both the original currency (`amount`) and the default currency (`amount_in_dc`). The `before_save :set_amount_in_default_currency` callback handles conversion.

**Account balance via callbacks**: `Transaction` automatically updates account balances:
```ruby
after_create  :affect_to_accounts_after_creation
after_destroy :affect_to_accounts_after_deletion
before_update :affect_to_accounts_before_update
```

**Dynamic scopes in controllers**: Filters are applied dynamically via `public_send(key, value)` against a whitelist of scope names. Column sort is similarly whitelisted to prevent SQL injection.

**Annotated models**: Schema info is inlined as comments at the top of each model file (via the `annotate` gem) — don't remove these manually.

### Docker Setup

- Development: `Dockerfile_alpine` + `docker-compose.yml` (mounts repo into `/bookke` for live reload)
- Production: `Dockerfile.prod` + `docker-compose-production.yml` (2 web replicas, external `nginx-ingress` network)
- `entrypoint.sh` removes stale `server.pid` before starting Puma

### Test Infrastructure

RSpec with FactoryBot, Shoulda Matchers, and DatabaseCleaner (transactional isolation). Factories live in `spec/factories/`. Controllers specs use `Devise::Test::ControllerHelpers` and a custom `ControllerMacros` helper.
