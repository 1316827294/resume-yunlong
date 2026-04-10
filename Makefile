FILE = resume

.PHONY: build build-de build-all dev dev-de validate validate-de clean doctor docker-build

build: validate
	pnpm yamlresume build $(FILE).yml
	mkdir -p dist
	mv -f $(FILE).pdf dist/ 2>/dev/null || true
	mv -f $(FILE).tex dist/ 2>/dev/null || true
	mv -f $(FILE).md dist/ 2>/dev/null || true
	mv -f $(FILE).html dist/ 2>/dev/null || true
	rm -f $(FILE).aux $(FILE).log $(FILE).out

build-de: validate-de
	pnpm yamlresume build $(FILE).de.yml
	mkdir -p dist
	mv -f $(FILE).de.pdf dist/ 2>/dev/null || true
	mv -f $(FILE).de.tex dist/ 2>/dev/null || true
	mv -f $(FILE).de.md dist/ 2>/dev/null || true
	mv -f $(FILE).de.html dist/ 2>/dev/null || true
	rm -f $(FILE).de.aux $(FILE).de.log $(FILE).de.out

build-all: build build-de

dev:
	pnpm yamlresume dev $(FILE).yml

dev-de:
	pnpm yamlresume dev $(FILE).de.yml

validate:
	pnpm yamlresume validate $(FILE).yml

validate-de:
	pnpm yamlresume validate $(FILE).de.yml

clean:
	rm -rf dist
	rm -f $(FILE).pdf $(FILE).tex $(FILE).md $(FILE).html
	rm -f $(FILE).de.pdf $(FILE).de.tex $(FILE).de.md $(FILE).de.html
	rm -f $(FILE).aux $(FILE).log $(FILE).out
	rm -f $(FILE).de.aux $(FILE).de.log $(FILE).de.out

doctor:
	pnpm yamlresume doctor

docker-build:
	docker run --rm -v "$$(pwd)":/home/yamlresume yamlresume/yamlresume build $(FILE).yml
	mkdir -p dist
	mv -f $(FILE).pdf dist/ 2>/dev/null || true
	mv -f $(FILE).tex dist/ 2>/dev/null || true
	mv -f $(FILE).md dist/ 2>/dev/null || true
	mv -f $(FILE).html dist/ 2>/dev/null || true
	rm -f $(FILE).aux $(FILE).log $(FILE).out
