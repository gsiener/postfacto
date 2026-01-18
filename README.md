# Expostfacto
[![CI/CD](https://github.com/gsiener/expostfacto/actions/workflows/ci.yml/badge.svg)](https://github.com/gsiener/expostfacto/actions/workflows/ci.yml)

Expostfacto is a modernized fork of [VMware's Postfacto](https://github.com/vmware-archive/postfacto), migrated to Rails 8 with Hotwire. It helps teams run great [retrospectives](https://content.pivotal.io/blog/how-to-run-a-really-good-retrospective) remotely.

> **Name Credit**: The name "Expostfacto" was suggested by [@flavorjones](https://github.com/flavorjones) - a clever play on "ex post facto" meaning "from a thing done afterward."

<p align="center">
  <img width="700px" src="https://github.com/pivotal/postfacto/blob/master/media/sample-retro.gif?raw=true" />
</p>


## Features

### Run Retros Remotely
Postfacto lets you run an agile retrospective even when your team is distributed across the world. Your retros will live update across all your devices so each participant can follow along on their device.

### Easy Onboarding
Easily [set up](deployment/README.md#allowing-users-to-create-retros) Postfacto to work with Google OAuth so users can sign up with their Google accounts. Alternatively, you can control access to your instance with the admin dashboard.

### Run Public or Private Retros
You can create private retro boards for your team that are password protected or choose to leave them public so that anyone you give the link to can access them.

### Mobile Friendly
Participants can add and vote on items from their mobile devices, so it is easy to run a retro without everyone in the group having a laptop nearby. This works well for retros where some people are in the room and some are remote.

### Record Action Items
Retros are designed to help teams improve and that's hard to do without taking action. Postfacto tracks your team's actions to help you keep on top of them.


## What's New in Expostfacto

This fork modernizes the original Postfacto codebase:

- 🚀 **Rails 8** - Upgraded from Rails 6.1
- ⚡ **Hotwire** - Replaced React/Redux frontend with Turbo and Stimulus
- 🎨 **Tailwind CSS v4** - Modern styling framework
- 🗄️ **PostgreSQL** - Production-ready database
- 📦 **Ruby 3.3** - Latest stable Ruby (with Ruby 4.0 support planned)

## Deployment

Expostfacto is designed for easy self-hosting on modern platforms:

- **[Render](https://render.com/)** (recommended) - Deploy with `render.yaml` configuration
- Includes CI/CD via GitHub Actions
- PostgreSQL database included
- Free tier available

For deployment instructions and configuration, see the [render.yaml](render.yaml) file in the repository.

## Contributing

See the [Contributing Guide](CONTRIBUTING.md) for more info.

## Credits

This project is a fork of [vmware-archive/postfacto](https://github.com/vmware-archive/postfacto), originally created by Pivotal Labs and later maintained by VMware. We're grateful to the original authors and contributors for creating such a valuable tool for agile teams.

Special thanks to [@flavorjones](https://github.com/flavorjones) for suggesting the name "Expostfacto"!

## License

Expostfacto is licensed under the **GNU Affero General Public License** (often referred to as **AGPL-3.0**). The full text
of the license is available [here](LICENSE.md). It's important to note that this license allows you to deploy an instance of Expostfacto for private, public or internal use.
