FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install app & setting TIMEZONE
RUN apt-get update
RUN apt-get install -y --no-install-recommends vim curl zsh sudo wget net-tools tzdata
RUN dpkg-reconfigure tzdata && printf '6\n79\n' | dpkg-reconfigure tzdata

# install git & pip
RUN apt update && \
    printf '6\n79\n' | apt install software-properties-common dirmngr gnupg-agent -y && \
    printf '\n' | add-apt-repository ppa:git-core/ppa && \
    apt update && \
    apt install git python3-pip -y

# install postgres command
RUN apt install postgresql postgresql-contrib -y

# pythonコマンドでpython3を実行できるようにシンボリックを貼る
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

ADD requirements.txt .
RUN python -m pip install --upgrade pip && python -m pip install -r requirements.txt

COPY . .
WORKDIR /app/lemonedo