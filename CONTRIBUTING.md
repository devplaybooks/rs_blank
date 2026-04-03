# Contributing

Thank you for your interest in contributing! Please take a moment to read these guidelines before submitting a pull request.

## Getting Started

1. Fork the repository and clone it locally.
2. Install the development tools:
   ```shell
   make install-tools
   ```
3. Make your changes on a new branch.

## Development Workflow

Run the full quality pipeline before pushing:

```shell
make ayce
```

This runs `cargo fmt`, builds, tests, lints with Clippy (pedantic), runs `cargo deny`, and generates docs.

Individual commands:

```shell
make fmt          # Format code
make test         # Run tests
make clippy       # Run linter
make deny         # Check dependencies
make create_docs  # Build documentation
```

For continuous feedback during development:

```shell
make watch        # Re-runs check + test on file changes
```

## Code Standards

- All public APIs must have doc comments with `# Examples` sections containing working doc tests.
- Unit tests are required for every public function and struct.
- No `unwrap()`, `expect()`, or `panic!()` in library code — use `Result` and proper error types.
- Clippy pedantic lints must pass.
- Run `cargo fmt` before committing — the CI `fmt` job will fail otherwise.

See [`CLAUDE.md`](CLAUDE.md) for the full coding standards reference.

## Submitting a Pull Request

- Keep PRs focused — one feature or fix per PR.
- Fill out the pull request template.
- Ensure all CI checks pass.

## Reporting Issues

Use the [bug report](.github/ISSUE_TEMPLATE/bug_report.md) or [feature request](.github/ISSUE_TEMPLATE/feature_request.md) templates.

## Code of Conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
