.PHONY: clean-cache
clean-cache: ## Remove .gocache directory.
	rm -rf .cache/

PLATFORMS ?= amd64 arm64
BUILDX_PLATFORMS ?= linux/amd64,linux/arm64

release: clean-cache 
	$(foreach PLATFORM,$(PLATFORMS), echo -n "$(PLATFORM)...";)

	echo "Building and pushing image...$(BUILDX_PLATFORMS)"
	docker buildx build \
	    --no-cache \
		--pull \
		--push \
		--progress plain \
		--platform $(BUILDX_PLATFORMS) \
		--build-arg TARGETARCH="$(PLATFORM)" \
		-t leovamwong/kustomize:kustomize-v5.0.0_kubectl-v1.26.2 . 