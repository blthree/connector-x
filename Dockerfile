FROM quay.io/pypa/manylinux_2_28_x86_64


ENV PATH="/root/.cargo/bin:${PATH}:/opt/python/cp310-cp310/bin"
# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# just is the job runner
RUN cargo install just
# system dependencies
RUN yum install -y epel-release
RUN yum install -y mysql-devel postgresql-devel freetds-devel krb5-libs clang-devel perl-IPC-Cmd
# python stuff
RUN pip3 install poetry
ADD . /connector-x
WORKDIR "/connector-x"
# RUN just bootstrap-python
# RUN just build-python-wheel
CMD ["/bin/bash", "-c", "just bootstrap-python && just build-python-wheel"]

# to generate wheel
# docker build --tag "cx_manylinux_wheel" .
# docker run cx_manylinux_wheel
# docker container cp <container name>:/connector-x/connectorx-python/target/wheels/connectorx-0.3.3a1-cp310-cp310-manylinux_2_28_x86_64.whl .