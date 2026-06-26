GREEN = \e[0;32m
RED = \e[0;31m
BGREEN = \e[1;32m
BRED = \e[1;31m
CYAN = \033[0;36m
RES = \e[0m
DATA_PATH = /home/gwen/data
WP_DATA = $(DATA_PATH)/wordpress
DB_DATA = $(DATA_PATH)/mariadb

all: dirs up

dirs:
	@echo "$(GREEN)Checking/Creating directories...$(RES)"
	@if [ ! -d "$(WP_DATA)" ]; then mkdir -p $(WP_DATA); fi
	@if [ ! -d "$(DB_DATA)" ]; then mkdir -p $(DB_DATA); fi
	@sudo chown -R 100:101 $(DB_DATA)
	@sudo chown -R 33:33 $(WP_DATA)
	@echo "$(BGREEN)Directories ready!$(RES)"

up:
	@echo "$(GREEN)Starting all services...$(RES)"
	@docker compose -f ./srcs/docker-compose.yaml up -d --build
	@echo "$(BGREEN)Started all services!$(RES)"

down:
	@echo "$(RED)Shutting down all services...$(RES)"
	@docker compose -f ./srcs/docker-compose.yaml down
	@echo "$(BGREEN)All services are now shut down!$(RES)"

re: fclean all

clean:
	@echo "$(RED)Cleaning containers, networks, and volumes related to the project...$(RES)"
	@docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all 2>/dev/null || true
	@docker ps -aq | xargs -r docker rm -f
	@echo "$(BGREEN)Project cleaned!$(RES)"

fclean: clean
	@echo "$(BRED)Deep cleaning all unused Docker resources...$(RES)"
	@docker volume prune -af
	@docker volume ls -q | xargs -r docker volume rm -f
	@sudo rm -rf /home/gwen/data
	@docker system prune -af
	@echo "$(BGREEN)System fully cleaned!$(RES)"

status:
	@echo "$(CYAN)Checking status... $(RES)"
	@docker compose -f srcs/docker-compose.yaml ps

.PHONY: all up re down clean status