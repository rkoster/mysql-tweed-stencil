FROM ubuntu:18.04 AS stage1

RUN apt-get update \
&& apt-get install -y curl unzip \
&& mkdir /bins \
&& curl -Lo /bins/safe       https://github.com/starkandwayne/safe/releases/download/v1.4.1/safe-linux-amd64 \
&& curl -Lo /bins/spruce     https://github.com/geofffranks/spruce/releases/download/v1.23.0/spruce-linux-amd64 \
&& curl -Lo /bins/bosh       https://github.com/cloudfoundry/bosh-cli/releases/download/v6.1.1/bosh-cli-6.1.1-linux-amd64 \
&& curl -Lo /vault.zip       https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip \
&& curl -Lo /kubectl.tar.gz  https://dl.k8s.io/v1.16.3/kubernetes-client-linux-amd64.tar.gz \
&& curl -Lo /bins/jq         https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 \
&& unzip vault.zip \
&& mv vault /bins/vault \
&& tar -xzvf kubectl.tar.gz \
&& mv kubernetes/client/bin/kubectl /bins/kubectl \
&& chmod 0755 /bins/*

FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

COPY --from=stage1 /bins/* /usr/bin/
ADD . /tweed
