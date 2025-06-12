PHPSTAN:=./vendor/bin/phpstan --memory-limit=1G
PHPDOC:=podman run --rm -v $(PWD):/data docker.io/phpdoc/phpdoc:3
export COMPOSER_MEMORY_LIMIT:=-1

install:
	composer update && composer install

.PHONY: install
install:
	composer install --no-dev

fix fmt:
	composer format 

lint: 
	$(PHPSTAN) analyze src --level 6

phpstan_update_baseline: 
	$(PHPSTAN) analyze --level 6 src/ test/ --generate-baseline

test:
	XDEBUG_MODE=coverage ./vendor/bin/phpunit

test_fail_fast:
	XDEBUG_MODE=coverage ./vendor/bin/phpunit --order-by=defects --stop-on-failure

test_group:
	XDEBUG_MODE=coverage ./vendor/bin/phpunit --group $(GROUP)
