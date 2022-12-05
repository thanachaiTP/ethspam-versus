FROM golang:1.13-alpine AS builder-versus
RUN apk update && apk add make
ADD . /versus
RUN cd /versus && make

FROM golang:1.13-alpine AS builder
RUN apk update && apk add make
ADD ./ethspam /ethspam
RUN cd /ethspam && make

FROM alpine:latest AS production
COPY --from=builder /ethspam/ethspam /usr/local/bin/
COPY --from=builder-versus /versus/versus /usr/local/bin/
