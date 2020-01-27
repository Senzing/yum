ARG BASE_IMAGE=centos:7
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2020-01-27

LABEL Name="senzing/yum" \
      Maintainer="support@senzing.com" \
      Version="1.1.3"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via yum.

RUN yum -y install \
    https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm \
    https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

ENTRYPOINT ["yum"]
CMD ["-y", "install", "senzingapi"]
