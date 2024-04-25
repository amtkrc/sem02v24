FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git \
build-essential \
gcc \
openjdk-21-jdk \
mono-complete \
python3 \
strace \
valgrind
RUN useradd -G sudo -m -d /home/ahmet -s /bin/bash -p "$(openssl passwd -1 1453)" ahmet
USER ahmet
WORKDIR /home/ahmet
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "ahmetki@uia.no" \
&& git config --global user.name "amtkrc" \
&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/amtkrc
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \
| tar xvz -C /usr/local
USER ahmet
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/ahmet/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
ARG DEBIAN_FRONTEND=noninteractive

RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \
| sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"
