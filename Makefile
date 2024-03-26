build:
	docker build . -t dev-mc-server:latest

run:
	docker run -it dev-mc-server:latest