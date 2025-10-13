# Makefile
PROTO_DIR := proto
GEN_DIR := gen
PROTOC := protoc
PROTO_FILES := $(shell find $(PROTO_DIR) -name '*.proto')

.PHONY: proto regen clean install-tools

proto:
	@mkdir -p $(GEN_DIR)
	$(PROTOC) -I $(PROTO_DIR) \
		--go_out=paths=source_relative:$(GEN_DIR) \
		--go-grpc_out=paths=source_relative:$(GEN_DIR) \
		$(PROTO_FILES)

regen: clean proto

clean:
	rm -rf $(GEN_DIR)

install-tools:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@echo "Don't forget to add $(shell go env GOPATH)/bin to your PATH if needed."
