build:
	docker build --tag="rundeck" .

run:
	docker run --detach=true --publish=49440:4440 rundeck
