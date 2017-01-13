currentdate = $(shell date +%y%m%d)

build:
	docker build -t napnap75/rpi-gandi:latest .

push: build
	docker push napnap75/rpi-gandi:latest
	docker tag napnap75/rpi-gandi:latest napnap75/rpi-gandi:$(currentdate)
	docker push napnap75/rpi-gandi:$(currentdate)
