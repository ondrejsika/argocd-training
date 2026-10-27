IMAGE = ttl.sh/image-updater-example
IMAGE_PRIVATE = registry.sikalabs.com/registry/argocd-training-private/image-updater-example

build-and-push:
	make build
	make push

build-and-push-all:
	@make build-and-push
	make push-to-private

build:
	docker build -t ${IMAGE} --platform linux/amd64 --build-arg DATE="$(shell date)" .

push:
	docker push ${IMAGE}

push-to-private:
	docker tag ${IMAGE} ${IMAGE_PRIVATE}
	docker push ${IMAGE_PRIVATE}
