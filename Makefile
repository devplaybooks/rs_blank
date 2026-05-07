.PHONY: default help clean build test build_test fmt clippy update tree tree-duplicates deny audit unused-deps create_docs docs install-tools watch install-watch ayce

CRATE_NAME := $(shell grep '^name' Cargo.toml 2>/dev/null | head -1 | sed 's/.*"\(.*\)".*/\1/' | tr '-' '_')

# Default target
default: ayce

# Display help information
help:
	@echo "Available targets:"
	@echo ""
	@echo "Build & Test:"
	@echo "  make build           - Build the project"
	@echo "  make test            - Run tests"
	@echo "  make build_test      - Clean once, then build and test"
	@echo "  make clean           - Clean build artifacts"
	@echo "  make ayce            - Run all checks (fmt -> build_test -> clippy -> deny -> create_docs)"
	@echo ""
	@echo "Code Quality & Security:"
	@echo "  make fmt             - Format code"
	@echo "  make clippy          - Run clippy linter"
	@echo "  make update          - Update dependencies"
	@echo "  make tree            - Show workspace dependency tree"
	@echo "  make tree-duplicates - Show duplicate dependencies"
	@echo "  make deny            - Run cargo-deny checks"
	@echo "  make audit           - Run advisory security audit"
	@echo "  make unused-deps     - Check for unused dependencies (nightly)"
	@echo ""
	@echo "Documentation:"
	@echo "  make create_docs     - Create documentation"
	@echo "  make docs            - Create docs and open in browser (macOS/Linux)"
	@echo ""
	@echo "Tooling:"
	@echo "  make install-tools   - Install cargo-deny, cargo-udeps, and cargo-watch"
	@echo "  make watch           - Run check/test in watch mode"
	@echo "  make install-watch   - Install cargo-watch"
	@echo ""
	@echo "Meta:"
	@echo "  make help            - Display this help message"

# Clean build artifacts
clean:
	cargo clean

# Build the project
build:
	cargo build

# Run tests
test:
	cargo test

# Clean once, then run build + test
build_test: clean build test

# Format code
fmt:
	cargo fmt

# Run clippy linter
clippy:
	cargo clippy -- -Dclippy::all -Dclippy::pedantic

# Update dependencies
update:
	@echo "Updating dependencies..."
	cargo update

# Show dependency tree
tree:
	@echo "Showing dependency tree..."
	cargo tree --workspace

# Show duplicate dependencies
tree-duplicates:
	@echo "Showing duplicate dependencies..."
	cargo tree --workspace --duplicates

# Security checks with cargo-deny
deny:
	@echo "Running cargo-deny checks..."
	cargo deny check

# Security audit with cargo-deny (advisories only)
audit:
	@echo "Running security audit..."
	cargo deny check advisories

# Check for unused dependencies (requires nightly)
unused-deps:
	@echo "Checking for unused dependencies..."
	cargo +nightly udeps --workspace --all-features

# Create documentation
create_docs:
	cargo doc --no-deps

# Open documentation in browser
docs: create_docs
	@if [ -z "$(CRATE_NAME)" ]; then \
		echo "Error: Could not determine crate name. Have you run 'cargo init'?"; \
		exit 1; \
	fi; \
	DOC_PATH="./target/doc/$(CRATE_NAME)/index.html"; \
	if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open "$$DOC_PATH"; \
	elif command -v open >/dev/null 2>&1; then \
		open "$$DOC_PATH"; \
	else \
		echo "No supported opener found (tried xdg-open and open)."; \
		echo "Open $$DOC_PATH manually."; \
		exit 1; \
	fi

# Install required tools
install-tools:
	@echo "Installing development tools..."
	cargo install cargo-deny
	cargo install cargo-udeps
	cargo install cargo-watch
	@echo ""
	@echo "✓ Tools installed!"
	@echo ""

# Watch mode for development (requires cargo-watch)
watch:
	cargo watch -x "check --workspace" -x "test --workspace"

# Install cargo-watch
install-watch:
	cargo install cargo-watch


# All You Can Eat - Run all checks
ayce: fmt build_test clippy deny create_docs
