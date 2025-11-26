.PHONY: gen install gen-validate genall -DEFAULT-GOAL

PROJECT_NAME := "rentsystem"

create-path:
	@mkdir -p ./generated/go

install:
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@go install github.com/envoyproxy/protoc-gen-validate@latest

gen-car:
	@protoc \
	  -I \
	  proto \
	  proto/$(PROJECT_NAME)/CarOptions.proto \
	  --go_out=./generated/go \
	  --go_opt=paths=source_relative \
	  --go-grpc_out=./generated/go \
	  --go-grpc_opt=paths=source_relative \
	  --validate_out="lang=go:./generated/go" \
	  --validate_opt=paths=source_relative

gen-view: create-path install
	@protoc \
		-I \
		proto \
		proto/$(PROJECT_NAME)/$(PROJECT_NAME)_view.proto \
		--go_out=./generated/go/$(PROJECT_NAME) \
		--go_opt=paths=source_relative \
		--go-grpc_out=./generated/go/$(PROJECT_NAME) \
		--go-grpc_opt=paths=source_relative \
		--validate_out="lang=go:./generated/go/$(PROJECT_NAME)" \
		--validate_opt=paths=source_relative


-DEFAULT-GOAL: genall
