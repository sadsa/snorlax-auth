# 🔐 snorlax-auth

<div align="center">

![Snorlax](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png)

*Rest easy knowing Snorlax is guarding your authentication*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Keycloak](https://img.shields.io/badge/Keycloak-blue?style=flat&logo=data:image/png;base64,ABC123)](https://www.keycloak.org/)

</div>

## 📖 Overview

snorlax-auth is our centralized authentication and authorization infrastructure using Keycloak. Just as Snorlax blocks the path of unauthorized trainers, this repository manages and secures your application's authentication needs.

### 🌟 Features

- 🛡️ Rock-solid authentication barrier
- 🔑 Centralized user management
- 🔒 Role-based access control (RBAC)
- 🔄 OAuth 2.0 and OpenID Connect support

## 🚀 Quick Start

### Prerequisites

- Docker (20.10.x or higher)
- Docker Compose (2.x or higher)
- Make (required for automation scripts)

### Installation and Local Development

1. **Clone the repository**:
   ```bash
   git clone git@github.com:your-organization/snorlax-auth.git
   cd snorlax-auth
   ```

2. **Set up environment variables**:
   ```bash
   cp .env.example .env
   ```

3. **Generate Certificates**:
   Before starting development, you need to generate self-signed certificates for local use. Run the following command:
   ```bash
   make generate-certs
   ```
   This will create a `certs` directory containing `cert.pem` and `key.pem` files.

4. **Start the services**:
   ```bash
   make up
   ```

5. **Access Keycloak**:
   - Admin Console: https://localhost:8443/admin
   - Default credentials (change these immediately):
     - Username: admin
     - Password: (from your .env file)

## 📋 Makefile Commands

Our Makefile provides comprehensive commands for managing the Keycloak infrastructure. View all available commands with:
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
make generate-certs  # Generate self-signed certificates
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

### Troubleshooting

#### "Your connection is not private" screen when accessing localhost over HTTPS

- In Chrome, put in `chrome://flags/#allow-insecure-localhost` in the address bar.
- Enable the option that says "Allow invalid certificates for resources loaded from localhost".
- Restart Chrome, and it should allow the site.

---
*Rest easy knowing Snorlax is guarding your authentication* 🛡️😴