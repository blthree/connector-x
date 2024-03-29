FROM quay.io/pypa/manylinux_2_28_x86_64

ADD . /connector-x
ENV PATH="${PATH}:/opt/python/cp310-cp310/bin"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . "$HOME/.cargo/env"
RUN cargo install just

RUN export PATH=/opt/python/cp310-cp310/bin:PATH
RUN pip3 install poetry

# RUN just bootstrap-python
# RUN just build-python-wheel

CMD ["bash"]