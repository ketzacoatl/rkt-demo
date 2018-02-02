from ubuntu:16.04
run apt update \
    && apt install --yes --no-install-recommends toilet \
    && rm -rf /var/lib/apt/lists/*
copy ./files/it-works.txt /etc/toilet-banner.txt
run cat /etc/toilet-banner.txt
cmd ["--metal"]
entrypoint ["/usr/bin/toilet"]
