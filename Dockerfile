FROM debian:12 as aqua
RUN apt-get update \
 && apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.3.2/aqua-installer | bash -s -- -v v2.24.1
COPY aqua.yaml /aqua.yaml
RUN /root/.local/share/aquaproj-aqua/bin/aqua -c /aqua.yaml cp -o /dist kubectl

FROM gcr.io/distroless/base-debian12
COPY --from=aqua /dist/kubectl /bin/kubectl
ENTRYPOINT ["kubectl"]
