FROM golang:1.22

RUN apt-get update
RUN apt-get install -y git

WORKDIR /go

COPY generate.sh /generate.sh
RUN /generate.sh
