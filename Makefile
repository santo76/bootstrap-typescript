.PHONY: tests dependencies coverage docker-build docker-tests docker-coverage
default:
	@printf "$$HELP"

# Local commands
dependencies:
	npm install

tests:
	npm run test:jest

test-watch:
	npm run test:jest:watch

test-mocha:
	npm run test:mocha

test-vitest:
	npm run test:vitest


# Docker commands
docker-build:
	docker build -t node-docker-bootstrap .
	@docker run --rm -v ${PWD}:/var/www/html/app node-docker-bootstrap npm install

docker-tests:
	@docker run --rm -t -v ${PWD}:/var/www/html/app node-docker-bootstrap npm run test:jest

docker-tests-watch:
	@docker run --rm -t -v ${PWD}:/var/www/html/app node-docker-bootstrap npm run test:jest:watch

docker-tests-mocha:
	@docker run --rm -t -v ${PWD}:/var/www/html/app node-docker-bootstrap npm run test:mocha

docker-tests-vitest:
	@docker run --rm -t -v ${PWD}:/var/www/html/app node-docker-bootstrap npm run test:vitest

docker-bash:
	@docker run --rm -it -v ${PWD}:/var/www/html/app node-docker-bootstrap sh


define HELP
# Local commands
	- make dependencies\tInstall the dependencies using composer
	- make tests\t\tRun the tests
	- make tests-watch\tRun the tests with watch
	- make tests-mocha\tRun the tests with mocha
	- make tests-vitest\tRun the tests with vitest
	- make coverage\t\tRun the code coverage
# Docker commands
	- make docker-build\t\tCreates a PHP image with xdebug and install the dependencies
	- make docker-tests\t\tRun the tests on docker
	- make docker-tests-watch\tRun the tests with watch on docker
	- make docker-tests-mocha\tRun the tests with mocha on docker
	- make docker-tests-vitest\tRun the tests with vitest on docker
	- make docker-bash\t\tEnter to container
 Please execute "make <command>". Example make help

endef

export HELP
