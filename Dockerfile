FROM golang:1.12-alpine3.9

MAINTAINER fising fising@qq.com

COPY entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    echo -e 'http://mirrors.ustc.edu.cn/alpine/v3.9/main/\nhttp://mirrors.ustc.edu.cn/alpine/v3.9/community/' > /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache openssh-client git protobuf rsync make && \
    go get -u -v github.com/golang/protobuf/proto && \
    go get -u -v github.com/golang/protobuf/protoc-gen-go && \
    go get -u -v github.com/micro/go-micro && \
    go get -u -v github.com/micro/protoc-gen-micro

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/sh"]
