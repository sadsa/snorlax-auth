include .env
export

# Makefile for snorlax-auth Keycloak infrastructure
SHELL := /bin/bash

# Configuration
DOCKER_COMPOSE := docker compose
BACKUP_DIR := backups
CURRENT_DATE := $(shell date '+%Y%m%d_%H%M%S')
DOCKER_REGISTRY := your-registry.com
PROJECT_NAME := snorlax-auth

# Colors for pretty printing
BLUE := \033[0;34m
GREEN := \033[0;32m
RED := \033[0;31m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Check if .env file exists, if not copy from example
ifneq ($(wildcard .env),)
    include .env
else
    $(shell cp .env.example .env)
    include .env
endif

.PHONY: help up down status logs restart clean backup restore build push security-scan \
        import-realm export-realm dev prod update-keycloak check-env test-realm

help: ## Display this help
	@echo -e "$(BLUE)snorlax-Auth Makefile Commands:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-30s$(NC) %s\n", $$1, $$2}'

generate-certs: ## Generate self-signed certificates
	@echo -e "$(BLUE)Generating self-signed certificates...$(NC)"
	@mkdir -p certs
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout certs/key.pem -out certs/cert.pem \
		-subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"
	@echo -e "$(GREEN)Certificates generated at: certs/cert.pem and certs/key.pem$(NC)"

check-env: ## Verify all required environment variables are set
	@echo -e "$(BLUE)Checking environment variables...$(NC)"
	@test -n "$(POSTGRES_PASSWORD)" || (echo -e "$(RED)POSTGRES_PASSWORD is not set$(NC)" && exit 1)
	@test -n "$(KC_BOOTSTRAP_ADMIN_PASSWORD)" || (echo -e "$(RED)KC_BOOTSTRAP_ADMIN_PASSWORD is not set$(NC)" && exit 1)
	@echo -e "$(GREEN)Environment variables check passed$(NC)"

up: check-env ## Start all services
	@echo -e "$(BLUE)Starting services...$(NC)"
	@mkdir -p $(BACKUP_DIR)
	$(DOCKER_COMPOSE) up -d
	@echo -e "$(GREEN)Services started successfully$(NC)"
	@echo -e "Admin console available at: https://localhost:8443"

down: ## Stop all services
	@echo -e "$(BLUE)Stopping services...$(NC)"
	$(DOCKER_COMPOSE) down
	@echo -e "$(GREEN)Services stopped successfully$(NC)"

status: ## Check the status of all services
	@echo -e "$(BLUE)Service status:$(NC)"
	$(DOCKER_COMPOSE) ps

logs: ## View logs from all services
	$(DOCKER_COMPOSE) logs -f

restart: down up ## Restart all services

clean: down ## Remove all containers, volumes, and temporary files
	@echo -e "$(BLUE)Cleaning up...$(NC)"
	$(DOCKER_COMPOSE) down -v
	rm -rf data/*
	@echo -e "$(GREEN)Cleanup complete$(NC)"

backup: ## Create a backup of the realm and database
	@echo -e "$(BLUE)Creating backup...$(NC)"
	@mkdir -p $(BACKUP_DIR)
	@echo "Backing up realm configuration..."
	@$(DOCKER_COMPOSE) exec -T keycloak /opt/keycloak/bin/kc.sh export --dir /tmp/export --users realm_file
	@$(DOCKER_COMPOSE) cp keycloak:/tmp/export/snorlax-realm.json $(BACKUP_DIR)/realm-$(CURRENT_DATE).json
	@echo "Backing up database..."
	@$(DOCKER_COMPOSE) exec -T postgres pg_dump -U keycloak keycloak > $(BACKUP_DIR)/db-$(CURRENT_DATE).sql
	@echo -e "$(GREEN)Backup completed: $(BACKUP_DIR)/realm-$(CURRENT_DATE).json and db-$(CURRENT_DATE).sql$(NC)"

restore: ## Restore from a backup (Usage: make restore BACKUP_FILE=path/to/backup.json)
	@if [ -z "$(BACKUP_FILE)" ]; then \
		echo -e "$(RED)Error: BACKUP_FILE is required$(NC)"; \
		echo "Usage: make restore BACKUP_FILE=path/to/backup.json"; \
		exit 1; \
	fi
	@echo -e "$(BLUE)Restoring from backup: $(BACKUP_FILE)$(NC)"
	@$(DOCKER_COMPOSE) cp $(BACKUP_FILE) keycloak:/tmp/import.json
	@$(DOCKER_COMPOSE) exec -T keycloak /opt/keycloak/bin/kc.sh import --file /tmp/import.json
	@echo -e "$(GREEN)Restore completed$(NC)"

build: ## Build the Docker images
	@echo -e "$(BLUE)Building Docker images...$(NC)"
	$(DOCKER_COMPOSE) build

push: ## Push the Docker images to registry
	@echo -e "$(BLUE)Pushing images to registry...$(NC)"
	$(DOCKER_COMPOSE) push

update-keycloak: ## Update Keycloak to the latest version
	@echo -e "$(BLUE)Updating Keycloak...$(NC)"
	@echo "Creating backup before update..."
	@$(MAKE) backup
	@echo "Pulling latest images..."
	$(DOCKER_COMPOSE) pull
	@echo "Restarting services..."
	@$(MAKE) restart
	@echo -e "$(GREEN)Update completed$(NC)"