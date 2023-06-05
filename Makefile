DOCKER_COMPOSE = docker compose
EXEC_PHP = $(DOCKER_COMPOSE) exec -T php-fpm
COMPOSER = $(EXEC_PHP) php -d memory_limit=512M /usr/bin/composer

.PHONY: help

help:
	@echo "Liste des commandes disponibles :"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


pull: ## Docker compose pull
	@echo "\nPulling local images...\e[0m"
	@$(DOCKER_COMPOSE) pull --quiet

build: pull ## Docker compose build
	@echo "\nBuilding local images...\e[0m"
	@$(DOCKER_COMPOSE) build 

up: ## Docker compose up
	@$(DOCKER_COMPOSE) up -d --remove-orphans

down: ## Docker compose down
	@$(DOCKER_COMPOSE) kill
	@$(DOCKER_COMPOSE) down --remove-orphans

install: build up vendor ## install the project
	
vendor: 
	@echo "\nInstalling composer packages...\e[0m"
	@$(COMPOSER) install