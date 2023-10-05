FROM debian:12 as install
RUN apt-get update \
 && apt-get install -y curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(cat .tool-versions)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl

FROM gcr.io/distroless/base-debian12
COPY --from=install /kubectl /bin/kubectl
ENTRYPOINT ["kubectl"]
