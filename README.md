# 🔐 snorlax-auth

<div align="center">

![Snorlax](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png)

*Rest easy knowing Snorlax is guarding your authentication*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Keycloak](https://img.shields.io/badge/Keycloak-blue?style=flat&logo=data:image/png;base64,ABC123)](https://www.keycloak.org/)

</div>

## 📖 Overview

snorlax-auth is our centralized authentication and authorization infrastructure using Keycloak. Just as Snorlax blocks the path of unauthorized trainers, this repository manages and secures your application's authentication needs. With Snorlax's legendary defensive capabilities, your authentication infrastructure is in safe hands.

### 🌟 Features

- 🛡️ Rock-solid authentication barrier (Containerized Keycloak)
- 🔑 Centralized user management (as reliable as Snorlax's Rest)
- 🔒 Role-based access control (RBAC) (like Snorlax guarding different routes)
- 🔄 OAuth 2.0 and OpenID Connect support
- 🎨 Custom theme support (style your auth like a shiny Snorlax)
- 🔙 Automated backup solutions (because even Snorlax needs a backup)

## 🚀 Quick Start

### Prerequisites

- Docker (20.10.x or higher)
- Docker Compose (2.x or higher)
- Make (required for automation scripts)

### Installation

1. Clone the repository:

```bash
git clone git@github.com:your-organization/snorlax-auth.git
cd snorlax-auth
```

2. Set up environment variables:

```bash
cp .env.example .env
```

3. Start the services:

```bash
make up
```

4. Access Keycloak:

- Admin Console: http://localhost:8080/admin
- Default credentials (change these immediately):
  - Username: admin
  - Password: (from your .env file)


## 🛠️ Development

### Local Development

```bash
# Start development environment
make dev

# View logs
make logs

# Restart services
make restart

# Stop services
make down
```

## 📋 Makefile Commands

Our Makefile provides comprehensive commands for managing the Keycloak infrastructure, as dependable as a sleeping Snorlax. View all available commands with:

```bash
make help
```

### Core Commands

```bash
make up              # Wake up all services
make down            # Put services to rest
make restart         # Quick Rest & wake up
make status          # Check Snorlax's status
make logs            # View Snorlax's dreams (logs)
make backup          # Create a backup of the realm and database
make restore         # Restore from a backup (Usage: make restore BACKUP_FILE=path/to/backup.json)
```

## 🏗️ Repository Structure

```
snorlax-auth/
├── config/           # Snorlax's configuration
├── docker/           # Container configs
├── scripts/          # Helper scripts
├── themes/           # Custom themes
├── terraform/        # Infrastructure as Code
├── tests/            # Testing scripts
├── backups/          # Recovery points
└── docs/             # Documentation
```

### Best Practices

1. Never commit sensitive data (don't disturb a sleeping Snorlax)
2. Use `make check-env` before deployment
3. Regular `make security-scan` runs
4. Maintain regular backups using `make backup`
5. Test restores periodically

## 📞 Support

- Run `make help` for command assistance
- Create an issue in this repository
- Contact the security team at security@your-organization.com
- Join our Slack channel: #snorlax-auth-support

### Troubleshooting

If you encounter issues:

1. Check if Snorlax is awake (services are running):
```bash
make status
```

2. View Snorlax's dreams (logs):
```bash
make logs
```

3. Wake up Snorlax (restart services):
```bash
make restart
```

---
*Rest easy knowing Snorlax is guarding your authentication* 🛡️😴