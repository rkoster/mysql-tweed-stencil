IMAGE := rkoster/mysql-tweed-stencil

default:
	docker build -t $(IMAGE):latest .
	docker push $(IMAGE):latest
