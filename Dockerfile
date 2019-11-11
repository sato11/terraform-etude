FROM "centos:centos7.4.1708"

RUN yum update -y \
  && yum install -y git
