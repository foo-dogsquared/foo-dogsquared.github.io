.PHONY: build
build: build-openring
	hugo

.PHONY: build-openring
build-openring:
	./bin/openring-create --input assets/templates/openring-input.html --output layouts/partials/openring.html

.PHONY: serve
serve: build-openring
	ls assets/templates/openring-input.html | LAST_COMMIT_DATE=$(git log -1 --format=%cI) hugo serve --buildFuture --verboseLog

.PHONY: update
update:
	curl --silent --location https://api.github.com/repos/foo-dogsquared/hugo-theme-more-contentful/commits | jq '.[0].sha' --raw-output | xargs --replace='{}' hugo mod get -u "github.com/foo-dogsquared/hugo-theme-more-contentful@{}" && hugo mod tidy
	curl --silent --location https://api.github.com/repos/foo-dogsquared/hugo-web-feeds/commits | jq '.[0].sha' --raw-output | xargs --replace='{}' hugo mod get -u "github.com/foo-dogsquared/hugo-web-feeds@{}" && hugo mod tidy
