.PHONY: postgres

postgres:
	@docker stop postgres > /dev/null 2>&1 || true
	@docker rm postgres > /dev/null 2>&1 || true
	@docker run --interactive --tty --rm --name postgres \
		--mount type=tmpfs,destination=/var/lib/postgresql/data \
		--volume $(shell pwd)/scripts:/docker-entrypoint-initdb.d \
		--publish 5432:5432 \
		postgres:10.2-alpine postgres -c 'log_statement=all' -c 'max_connections=1000' -c 'log_connections=true' -c 'log_disconnections=true' -c 'log_duration=true'
