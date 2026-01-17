# Postfacto - Claude Code Guide

## Project Overview

Postfacto is a free, open-source, self-hosted retrospective collaboration tool designed for distributed teams to run agile retrospectives remotely. It enables team members to share feedback, vote on topics, and track action items in real-time.

**License**: GNU Affero General Public License (AGPL-3.0)

## Tech Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| **Backend** | Ruby on Rails | 8.x (originally 6.1) |
| **Frontend** | React + Redux | 17.0.2 |
| **Language** | Ruby | 4.0.1 |
| **Node.js** | Node | 18.20.5 |
| **Database** | SQLite (dev), PostgreSQL/MySQL (prod) | - |
| **Test Framework (API)** | RSpec | 8.x |
| **Test Framework (Frontend)** | Jest + Enzyme | - |
| **Admin Dashboard** | ActiveAdmin | 2.9+ |

## Project Structure

```
/postfacto/
├── api/                          # Rails API backend (port 4000)
│   ├── app/
│   │   ├── admin/               # ActiveAdmin dashboard
│   │   ├── controllers/         # REST API controllers
│   │   ├── models/              # Domain models (Retro, Item, ActionItem, User)
│   │   ├── channels/            # ActionCable WebSocket handlers
│   │   └── domain/              # Business logic
│   ├── config/                  # Rails configuration
│   ├── db/                      # Migrations & seeds
│   └── spec/                    # RSpec tests
│
├── web/                          # React frontend (port 3000)
│   ├── src/
│   │   ├── components/          # React components
│   │   ├── redux/               # State management
│   │   └── api/                 # API client
│   └── package.json
│
├── e2e/                          # End-to-end tests (Capybara/Selenium)
└── docker/                       # Docker configurations
```

## Key Files

- `api/app/models/retro.rb` - Main retrospective model
- `api/app/models/item.rb` - Feedback items (happy/meh/sad)
- `api/app/models/action_item.rb` - Action items to track
- `api/config/routes.rb` - API routes under `/api` prefix
- `web/src/components/` - React UI components
- `.tool-versions` - Ruby and Node version pinning

## Running the Project

### Prerequisites

```bash
# Install mise (or asdf) for version management
# Ruby 3.2.10 and Node 18.20.5 will be auto-installed
```

### API (Backend)

```bash
cd api
bundle install --without production
RAILS_ENV=development bundle exec rake db:create db:migrate
bundle exec rails server -p 4000
```

### Web (Frontend)

```bash
cd web
npm install --legacy-peer-deps
npm start
```

### Running Tests

**API Tests:**
```bash
cd api
RAILS_ENV=test bundle exec rake db:create db:migrate
RAILS_ENV=test bundle exec rake
```

**Frontend Tests:**
```bash
cd web
CI=true npm test
```

**Linting:**
```bash
cd web
npm run lint
```

## Important Implementation Details

### Rails 8.x Migration Notes

1. **Enum Syntax**: Rails 7+ requires positional argument syntax:
   ```ruby
   # Old (Rails 6)
   enum category: { happy: 'happy', meh: 'meh', sad: 'sad' }

   # New (Rails 7+)
   enum :category, { happy: 'happy', meh: 'meh', sad: 'sad' }
   ```

2. **Secrets API**: `Rails.application.secrets.secret_key_base` is deprecated, use `Rails.application.secret_key_base`

3. **alias_attribute**: For non-database attributes, use `alias_method` instead:
   ```ruby
   # Instead of: alias_attribute :new_name, :method_name
   alias_method :new_name, :method_name
   alias_method :new_name=, :method_name=
   ```

4. **Ransack 4.x**: Requires explicit allowlisting for searchable attributes:
   ```ruby
   def self.ransackable_attributes(_auth_object = nil)
     %w[id name ...]
   end

   def self.ransackable_associations(_auth_object = nil)
     %w[items ...]
   end
   ```

5. **RSpec Configuration**: Use `fixture_paths` (array) instead of `fixture_path` (string)

### Frontend Notes

1. **node-sass** is deprecated - replaced with **sass** (dart-sass)
2. **cheerio** pinned to 1.0.0-rc.12 for enzyme compatibility
3. Use `--legacy-peer-deps` when installing due to material-ui peer dependency conflicts
4. material-ui 0.20.2 is deprecated - consider migrating to @mui/material

## Database Schema

Key models:
- **Retro**: Retrospective board with slug, password, video_link
- **Item**: Feedback items with category (happy/meh/sad), vote_count
- **ActionItem**: Action items with done status
- **User**: Retro participants
- **Archive**: Historical retro data

## API Routes

All API routes are prefixed with `/api`:
- `POST /api/retros` - Create retrospective
- `GET /api/retros/:slug` - Get retrospective
- `POST /api/retros/:retro_id/items` - Create item
- `POST /api/retros/:retro_id/items/:id/vote` - Vote on item
- `PATCH /api/retros/:retro_id/items/:id/done` - Mark item done

## Real-time Features

WebSocket communication via ActionCable:
- `RetrosChannel` - Broadcasts retro updates to connected clients
- Supports live voting, item creation, and discussion management

## Common Tasks

### Adding a new migration
```bash
cd api
bundle exec rails generate migration AddFieldToModel field:type
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=test bundle exec rake db:migrate
```

### Running specific tests
```bash
# API
cd api && RAILS_ENV=test bundle exec rspec spec/path/to/spec.rb

# Frontend
cd web && npm test -- --testPathPattern="path/to/test"
```

## Deployment

Docker-based deployment via the root `Dockerfile`.

## Known Issues & Workarounds

1. **Python 3.14+ incompatibility**: Node 14.x cannot be built with modern Python. Use Node 18+.
2. **material-ui deprecation**: Old material-ui requires React peer dependency override
3. **Enzyme + cheerio**: Pin cheerio to 1.0.0-rc.12 for compatibility
