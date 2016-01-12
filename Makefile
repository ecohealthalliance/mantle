all: help

help:
	@echo ""
	@echo "make:"
	@echo "      model   - Run model unit tests"
	@echo "      test    - Run end-to-end tests"
	@echo "      devtest - Perform a single test"
	@echo "      install - Install required tools"
	@echo "      data    - Copy production database to local machine"
	@echo "      build   - Compile tater into binaries"
	@echo "      docker  - Build the docker image"
	@echo ""

model:
	spacejam test-packages packages/models/

test:
	MONGO_URL=mongodb://localhost:27017/chimp_db meteor --port 3100 &
	CUCUMBER_TAIL=1 ./node_modules/.bin/chimp --ddp=http://localhost:3100 --path=tests/cucumber/features/ --coffee=true --chai=true --sync=false

devtest:
	MONGO_URL=mongodb://localhost:27017/chimp_db meteor --port 3100 &
	CUCUMBER_TAIL=1 ./node_modules/.bin/chimp --ddp=http://localhost:3100 --tags=@dev --path=tests/cucumber/features/ --coffee=true --chai=true --sync=false

install:
	curl https://install.meteor.com | sh
	xcode-select –install
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install node
	npm install -g spacejam@1.2.1
	npm install chimp

data:
	./.scripts/restore_database

build:
	rm -fr build/
	meteor build build --directory --architecture os.linux.x86_64

docker:
	docker build -t tater .
