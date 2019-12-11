FROM ubuntu

RUN apt-get update && apt-get install gnupg wget -y \
    && wget -q -O - https://raw.githubusercontent.com/starkandwayne/homebrew-cf/master/public.key | apt-key add - \
    && echo "deb http://apt.starkandwayne.com stable main" | tee /etc/apt/sources.list.d/starkandwayne.list \
    && apt-get update

RUN apt-get install spruce safe vault bosh-cli mysql-client -y

ADD . /tweed
