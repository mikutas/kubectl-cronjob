FROM debian:12 as install
RUN apt-get update \
 && apt-get install -y curl
ENV VERSION=v1.19.9
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl

FROM gcr.io/distroless/base-debian12
COPY --from=install /kubectl /bin/kubectl
ENTRYPOINT ["kubectl"]
