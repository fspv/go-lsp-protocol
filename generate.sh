#!/bin/bash -uex

mkdir build
cd build

git init

PKG_NAME="github.com/fspv/go-lsp-protocol"

go mod init github.com/fspv/go-lsp-protocol

# Copy dir `internal/jsonrpc2` from https://github.com/golang/tools.git to `./jsonrpc2`
git clone https://github.com/golang/tools.git
cp -R tools/internal .
cp -R tools/gopls/internal/util internal/util
rm -rf tools

# Download go package golang.org/x/tools/gopls
go get golang.org/x/tools/gopls

cat go.mod


# Resolve golang.org/x/tools/gopls/internal/protocol path
MODULE_PATH=$(go list -m -f '{{.Dir}}' golang.org/x/tools/gopls)

cp -R "$MODULE_PATH"/internal/protocol/* .

find . -type f -print0 | xargs -0 sed -i -e "s|golang.org/x/tools/internal/|${PKG_NAME}/internal/|g"
find . -type f -print0 | xargs -0 sed -i -e "s|golang.org/x/tools/gopls/internal/|${PKG_NAME}/internal/|g"

go build

find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
