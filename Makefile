GREEN = \e[0;32m
RED = \e[0;31m
BGREEN = \e[1;32m
BRED = \e[1;31m
CYAN = \033[0;36m
RES = \e[0m

all: up

up:
	@echo "$(GREEN)Starting all services...$(RES)"
	@docker compose -f ./srcs/docker-compose.yaml up -d --build
	@echo "$(BGREEN)Started all services!$(RES)"

down:
	@echo "$(RED)Shutting down all services...$(RES)"
	@docker compose -f ./srcs/docker-compose.yaml down
	@echo "$(BGREEN)All services are now shut down!$(RES)"

re:
	@echo "$(GREEN)Rebuilding all services...$(RES)"
	@docker compose -f srcs/docker-compose.yaml up -d --build
	@echo "$(BGREEN)All services are now deployed!$(RES)"

clean:
	@echo "$(RED)Cleaning containers, networks, and volumes related to the project...$(RES)"
	@docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all 2>/dev/null || true
	@docker ps -aq | xargs -r docker rm -f
	@echo "$(BGREEN)Project cleaned!$(RES)"

fclean: clean
	@echo "$(BRED)Deep cleaning all unused Docker resources...$(RES)"
	@docker volume prune -f
	@docker system prune -af
	@echo "$(BGREEN)System fully cleaned!$(RES)"

status:
	@echo "$(CYAN)Checking status... $(RES)"
	@docker compose -f srcs/docker-compose.yaml ps

.PHONY: all up re down clean status