FROM ghcr.io/linuxsuren/hd:v0.0.93 AS hd
WORKDIR /workspace
RUN hd get kubernetes-sigs/kubectl
FROM alpine:3.17.3

RUN apk add curl bash git openssh
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash && \
    mv kustomize /usr/bin/
COPY --from=hd /workspace/kubectl kubectl
RUN chmod +x kubectl && \
    mv kubectl /usr/bin
