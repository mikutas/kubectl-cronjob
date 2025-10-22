FROM debian:13 as aqua
RUN apt-get update \
 && apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.3/aqua-installer | bash -s -- -v v2.55.0
COPY aqua.yaml /aqua.yaml
RUN /root/.local/share/aquaproj-aqua/bin/aqua -c /aqua.yaml cp -o /dist kubectl

FROM gcr.io/distroless/base-debian13
COPY --from=aqua /dist/kubectl /bin/kubectl
ENTRYPOINT ["kubectl"]
