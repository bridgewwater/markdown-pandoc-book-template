.PHONY: test check clean build dist all
TOP_DIR := $(shell pwd)
# each tag change this
ENV_DIST_VERSION := v1.0.0

ROOT_NAME ?= android-skills-growth-strategy

ENV_MODULE_MAKE_FILE ?= ./Makefile
ENV_MODULE_MANIFEST = ./package.json
ENV_MODULE_CHANGELOG = ./CHANGELOG.md
ENV_ROOT_DIST ?= ./dist

env:
	pandoc --version
	xelatex --version
	latex --version

utils:
	node -v
	npm -v
	npm install -g commitizen cz-conventional-changelog conventional-changelog-cli

versionHelp:
	@echo "if error, pleast see log or use npm init to make package.json to fix"
	@git fetch --tags
	@echo "project base info"
	@echo " project name         : ${ROOT_NAME}"
	@echo ""
	@echo "=> please check to change version, now is [ ${ENV_DIST_VERSION} ]"
	@echo "-> check at: ${ENV_MODULE_MAKE_FILE}:4"
	@echo " $(shell head -n 4 ${ENV_MODULE_MAKE_FILE} | tail -n 1)"
	@echo "-> check at: ${ENV_MODULE_MANIFEST}:3"
	@echo " $(shell head -n 3 ${ENV_MODULE_MANIFEST} | tail -n 1)"

tagBefore: versionHelp
	@conventional-changelog -i ${ENV_MODULE_CHANGELOG} -s --skip-unstable
	@echo ""
	@echo "=> new CHANGELOG.md at: ${ENV_MODULE_CHANGELOG}"
	@echo "place check all file, then can add tag like this!"
	@echo "$$ git tag -a '${ENV_DIST_VERSION}' -m 'message for this tag'"

installTools:
	brew install pandoc
	brew install basictex

cleanDist:
	@if [ -d ${ENV_ROOT_DIST} ]; \
	then rm -rf ${ENV_ROOT_DIST} && echo "~> cleaned ${ENV_ROOT_DIST}"; \
	else echo "~> has cleaned ${ENV_ROOT_DIST}"; \
	fi

clean: cleanDist
	@echo "~> clean finish"

mkDist:
	@if [ ! -d ${ENV_ROOT_DIST} ]; \
	then mkdir -p ${ENV_ROOT_DIST} && echo "~> mkdir: ${ENV_ROOT_DIST}"; \
	fi

buildDocx: mkDist
	pandoc -d config_docx.yaml src/*.md

buildEpub: mkDist
	pandoc -d config_epub.yaml src/*.md

buildHtml: mkDist
	pandoc -d config_html.yaml src/*.md

buildPDF: mkDist
	pandoc -d config_pdf.yaml src/*.md

buildAll: buildDocx buildEpub buildHtml buildPDF
	@echo "-> full out build finish"

helpProjectRoot:
	@echo "Help: Project root Makefile"
	@echo "-- now build name: $(ROOT_NAME) version: $(ENV_DIST_VERSION)"
	@echo ""
	@echo "~> make env                  ~> check env of this project"
	@echo "~> make utils                ~> install utils of this project"
	@echo "~> make versionHelp          ~> show version of this project"
	@echo "~> make tagBefore            ~> generate each tag info before commit"
	@echo "~> make clean                ~> clean project all, more info see Makefile"
	@echo "~> make installTools         ~> install project need tools"
	@echo ""
	@echo "~> make buildDocx            ~> build docx"
	@echo "~> make buildEpub            ~> build epub"
	@echo "~> make buildHtml            ~> build html"
	@echo "~> make buildPDF             ~> build pdf"
	@echo "~> make buildAll             ~> build all above"

help: helpProjectRoot
	@echo ""
	@echo "-- more info see Makefile or include: --"
