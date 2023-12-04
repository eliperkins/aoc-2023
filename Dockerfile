FROM swift:5.9 as builder

# set up the workspace
RUN mkdir /workspace
WORKDIR /workspace

# copy the source to the docker image
COPY . /workspace

RUN swift build -c release --static-swift-stdlib
