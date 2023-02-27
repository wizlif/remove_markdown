
gen_cov: ## Generate coverage report
	# Generate `coverage/lcov.info` file
	fvm flutter test --coverage
	
	# Generate HTML report
	# Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
	genhtml coverage/lcov.info -o coverage/html
	
	# Open the report
	open coverage/html/index.html

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: gen_cov
.DEFAULT_GOAL := help
