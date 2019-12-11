IMAGE := tweedproject/mysql-tweed-stencil

default:
	docker build -t $(IMAGE):edge .
	docker export $(shell docker create $(IMAGE):edge) | gzip -c > ../tweed/stencils/mysql-tweed-stencil.tar.gz
