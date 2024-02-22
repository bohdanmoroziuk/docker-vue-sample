dev-start:
	docker compose -f compose.development.yaml up --build -d

dev-stop:
	docker compose -f compose.development.yaml down

prod-start:
	docker compose -f compose.production.yaml up --build -d

prod-stop:
	docker compose -f compose.production.yaml down