#!/bin/bash -uex

sudo docker build -t go-lsp-protocol-generate .
CONTAINER_ID=$(sudo docker create go-lsp-protocol-generate)
sudo docker cp "$CONTAINER_ID":/go/build/ .
sudo docker rm -v "$CONTAINER_ID"
sudo chown -R "$(id -u):$(id -g)" build
# Copy with overwrite
cp -Rfp build/* .
rm -rf build
